Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000236626F7
	for <lists+linux-efi@lfdr.de>; Mon,  9 Jan 2023 14:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjAIN0x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Jan 2023 08:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjAIN0x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Jan 2023 08:26:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52AFC8FE2
        for <linux-efi@vger.kernel.org>; Mon,  9 Jan 2023 05:26:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3D7DC14;
        Mon,  9 Jan 2023 05:27:32 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.46.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5C833F23F;
        Mon,  9 Jan 2023 05:26:49 -0800 (PST)
Date:   Mon, 9 Jan 2023 13:26:43 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, catalin.marinas@arm.com,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3 1/2] arm64: efi: Avoid workqueue to check whether EFI
 runtime is live
Message-ID: <Y7wWEwHR2RDU/KD3@FVFF77S0Q05N>
References: <20230106174703.1883495-1-ardb@kernel.org>
 <20230106174703.1883495-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106174703.1883495-2-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 06, 2023 at 06:47:02PM +0100, Ard Biesheuvel wrote:
> Comparing current_work() against efi_rts_work.work is sufficient to
> decide whether current is currently running EFI runtime services code at
> any level in its call stack.
> 
> However, there are other potential users of the EFI runtime stack, such
> as the ACPI subsystem, which may invoke efi_call_virt_pointer()
> directly, and so any sync exceptions occurring in firmware during those
> calls are currently misidentified.
> 
> So instead, let's check whether 'current' has preemption disabled, and
> whether the stashed value of the thread stack pointer points into
> current's thread stack. This can only be the case if current was
> interrupted while running EFI runtime code. This implies that we should
> clear the stashed value after switching back, to avoid false positives.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks for this!

Mark.

> ---
>  arch/arm64/include/asm/efi.h       | 9 +++++++++
>  arch/arm64/kernel/efi-rt-wrapper.S | 6 ++++++
>  arch/arm64/kernel/efi.c            | 3 ++-
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 31d13a6001df49c4..f68d13c3a44e7bb2 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -48,8 +48,17 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
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
> +	(!preemptible() &&						\
> +	 on_task_stack(current, READ_ONCE(efi_rt_stack_top[-1]), 1))
> +
>  #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
>  
>  /*
> diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
> index a00886410537d6a6..11f3ec9f09e86de6 100644
> --- a/arch/arm64/kernel/efi-rt-wrapper.S
> +++ b/arch/arm64/kernel/efi-rt-wrapper.S
> @@ -45,7 +45,10 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
>  	mov	x4, x6
>  	blr	x8
>  
> +	mov	x16, sp
>  	mov	sp, x29
> +	str	xzr, [x16, #8]			// clear recorded task SP value
> +
>  	ldp	x1, x2, [sp, #16]
>  	cmp	x2, x18
>  	ldp	x29, x30, [sp], #112
> @@ -70,6 +73,9 @@ SYM_FUNC_END(__efi_rt_asm_wrapper)
>  SYM_CODE_START(__efi_rt_asm_recover)
>  	mov	sp, x30
>  
> +	ldr_l	x16, efi_rt_stack_top		// clear recorded task SP value
> +	str	xzr, [x16, #-8]
> +
>  	ldp	x19, x20, [sp, #32]
>  	ldp	x21, x22, [sp, #48]
>  	ldp	x23, x24, [sp, #64]
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
