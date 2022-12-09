Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6386483DB
	for <lists+linux-efi@lfdr.de>; Fri,  9 Dec 2022 15:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiLIOht (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Dec 2022 09:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiLIOhs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Dec 2022 09:37:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF4B7B482
        for <linux-efi@vger.kernel.org>; Fri,  9 Dec 2022 06:37:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3913323A;
        Fri,  9 Dec 2022 06:37:52 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.41.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 782673F73D;
        Fri,  9 Dec 2022 06:37:44 -0800 (PST)
Date:   Fri, 9 Dec 2022 14:37:41 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH] arm64: efi: Account for the EFI runtime stack in stack
 unwinder
Message-ID: <Y5NINaentm954uix@FVFF77S0Q05N>
References: <20221209133414.3330761-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209133414.3330761-1-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 09, 2022 at 02:34:14PM +0100, Ard Biesheuvel wrote:
> The EFI runtime services run from a dedicated stack now, and so the
> stack unwinder needs to be informed about this.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> 
> I realised while looking into this that comparing current_work() against
> efi_rts_work.work is not sufficient to decide whether current is running
> EFI code, given that the ACPI subsystem will call efi_call_virt_pointer()
> directly.
> 
> So instead, we can check whether the stashed thread stack pointer value
> matches current's thread stack if the EFI runtime stack is currently in
> use:
> 
> #define current_in_efi()                                               \
>        (!preemptible() && spin_is_locked(&efi_rt_lock) &&              \
>         on_task_stack(current, efi_rt_stack_top[-1], 1))

Unless you're overwriting task_struct::stack (which seems scary to me), that
doesn't look right; on_task_stack() checks whether a given base + size is on
the stack allocated for the task (i.e. task_struct::stack + THREAD_SIZE), not
the stack the task is currently using.

I would expect this to be something like:

#define current_in_efi()						\
	(!preemptible() && spin_is_locked(&efi_rt_lock) &&		\
	 stackinfo_on_stack(stackinfo_get_efi(), current_stack_pointer, 1))

... or an inline function given this is sufficiently painful as a macro.

... unless I've confused myself?

FWIW, the patch belows looks good to me!

Mark.

> but this will be folded into the preceding patch, which I am not
> reproducing here.
> 
>  arch/arm64/include/asm/stacktrace.h | 15 +++++++++++++++
>  arch/arm64/kernel/stacktrace.c      | 12 ++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> index 5a0edb064ea478bb..327cdcfcb1db0ad5 100644
> --- a/arch/arm64/include/asm/stacktrace.h
> +++ b/arch/arm64/include/asm/stacktrace.h
> @@ -104,4 +104,19 @@ static inline struct stack_info stackinfo_get_sdei_critical(void)
>  #define stackinfo_get_sdei_critical()	stackinfo_get_unknown()
>  #endif
>  
> +#ifdef CONFIG_EFI
> +extern u64 *efi_rt_stack_top;
> +
> +static inline struct stack_info stackinfo_get_efi(void)
> +{
> +	unsigned long high = (u64)efi_rt_stack_top;
> +	unsigned long low = high - THREAD_SIZE;
> +
> +	return (struct stack_info) {
> +		.low = low,
> +		.high = high,
> +	};
> +}
> +#endif
> +
>  #endif	/* __ASM_STACKTRACE_H */
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 634279b3b03d1b07..ee9fd2018cd75ed2 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2012 ARM Ltd.
>   */
>  #include <linux/kernel.h>
> +#include <linux/efi.h>
>  #include <linux/export.h>
>  #include <linux/ftrace.h>
>  #include <linux/sched.h>
> @@ -12,6 +13,7 @@
>  #include <linux/sched/task_stack.h>
>  #include <linux/stacktrace.h>
>  
> +#include <asm/efi.h>
>  #include <asm/irq.h>
>  #include <asm/stack_pointer.h>
>  #include <asm/stacktrace.h>
> @@ -186,6 +188,13 @@ void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
>  			: stackinfo_get_unknown();		\
>  	})
>  
> +#define STACKINFO_EFI						\
> +	({							\
> +		((task == current) && current_in_efi())		\
> +			? stackinfo_get_efi()			\
> +			: stackinfo_get_unknown();		\
> +	})
> +
>  noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
>  			      void *cookie, struct task_struct *task,
>  			      struct pt_regs *regs)
> @@ -199,6 +208,9 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
>  #if defined(CONFIG_VMAP_STACK) && defined(CONFIG_ARM_SDE_INTERFACE)
>  		STACKINFO_SDEI(normal),
>  		STACKINFO_SDEI(critical),
> +#endif
> +#ifdef CONFIG_EFI
> +		STACKINFO_EFI,
>  #endif
>  	};
>  	struct unwind_state state = {
> -- 
> 2.35.1
> 
