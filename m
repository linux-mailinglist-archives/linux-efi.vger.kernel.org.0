Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDA065EADF
	for <lists+linux-efi@lfdr.de>; Thu,  5 Jan 2023 13:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjAEMqH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Jan 2023 07:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjAEMpx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Jan 2023 07:45:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DB0B559CF
        for <linux-efi@vger.kernel.org>; Thu,  5 Jan 2023 04:45:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 436F515BF;
        Thu,  5 Jan 2023 04:46:33 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.45.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 812233F663;
        Thu,  5 Jan 2023 04:45:50 -0800 (PST)
Date:   Thu, 5 Jan 2023 12:45:44 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH v2 1/2] arm64: efi: Avoid workqueue to check whether EFI
 runtime is live
Message-ID: <Y7bGeOZ1+Z2cH9NF@FVFF77S0Q05N>
References: <20230104174433.1259428-1-ardb@kernel.org>
 <20230104174433.1259428-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104174433.1259428-2-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Wed, Jan 04, 2023 at 06:44:32PM +0100, Ard Biesheuvel wrote:
> Comparing current_work() against efi_rts_work.work is sufficient to
> decide whether current is currently running EFI runtime services code at
> any level in its call stack.
> 
> However, there are other potential users of the EFI runtime stack, such
> as the ACPI subsystem, which may invoke efi_call_virt_pointer()
> directly, and so any sync exceptions occurring in firmware during those
> calls are currently misidentified.
> 
> So instead, let's check whether the spinlock is locked, and whether the
> stashed value of the thread stack pointer points into current's thread
> stack. This can only be the case if current was interrupted while
> running EFI runtime code.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/efi.h | 10 ++++++++++
>  arch/arm64/kernel/efi.c      |  3 ++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 31d13a6001df49c4..aca6dcaa33efbac4 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -42,14 +42,24 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
>  
>  #define arch_efi_call_virt_teardown()					\
>  ({									\
> +	efi_rt_stack_top[-1] = 0;					\

Is there any reason not to do this in the asm, given all the other setting of
this occurs there? I know that'd mean duplicating the writ for both the regular
case and the exception handler, but then it'd be clearly associated with the
instant we move away from the EFI RT stack.

That would also hide this write from KCSAN; itherwise this'll need to be a
WRITE_ONCE() to pair with the (not necessariyl) locked read in current_in_efi()
below.

>  	spin_unlock(&efi_rt_lock);					\
>  	__efi_fpsimd_end();						\
>  	efi_virtmap_unload();						\
>  })
>  
>  extern spinlock_t efi_rt_lock;
> +extern u64 *efi_rt_stack_top;
>  efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
>  
> +/*
> + * efi_rt_stack_top[-1] contains the value the stack pointer had before
> + * switching to the EFI runtime stack.
> + */
> +#define current_in_efi()						\
> +	(!preemptible() && spin_is_locked(&efi_rt_lock) &&		\
> +	 on_task_stack(current, efi_rt_stack_top[-1], 1))

KCSAN is liable to complain about the access to efi_rt_stack_top[-1], since
that can race with another thread updating the value, and it's not necessarily
single-copy-atomic.

It's probably worth making this a READ_ONCE(), even if we move all the writes
to asm, to avoid tearing.

Aside from those points, this looks good to me.

Thanks,
Mark.

> +
>  #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
>  
>  /*
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index fab05de2e12dd5d8..b273900f45668587 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -11,6 +11,7 @@
>  #include <linux/init.h>
>  
>  #include <asm/efi.h>
> +#include <asm/stacktrace.h>
>  
>  static bool region_is_misaligned(const efi_memory_desc_t *md)
>  {
> @@ -154,7 +155,7 @@ asmlinkage efi_status_t __efi_rt_asm_recover(void);
>  bool efi_runtime_fixup_exception(struct pt_regs *regs, const char *msg)
>  {
>  	 /* Check whether the exception occurred while running the firmware */
> -	if (current_work() != &efi_rts_work.work || regs->pc >= TASK_SIZE_64)
> +	if (!current_in_efi() || regs->pc >= TASK_SIZE_64)
>  		return false;
>  
>  	pr_err(FW_BUG "Unable to handle %s in EFI runtime service\n", msg);
> -- 
> 2.39.0
> 
