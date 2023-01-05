Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7E65EAEB
	for <lists+linux-efi@lfdr.de>; Thu,  5 Jan 2023 13:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjAEMrM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Jan 2023 07:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjAEMrL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Jan 2023 07:47:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A247B479E8
        for <linux-efi@vger.kernel.org>; Thu,  5 Jan 2023 04:47:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 371A115BF;
        Thu,  5 Jan 2023 04:47:52 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.45.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7427E3F663;
        Thu,  5 Jan 2023 04:47:09 -0800 (PST)
Date:   Thu, 5 Jan 2023 12:47:06 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH v2 2/2] arm64: efi: Account for the EFI runtime stack in
 stack unwinder
Message-ID: <Y7bGytVFvKmkCXBh@FVFF77S0Q05N>
References: <20230104174433.1259428-1-ardb@kernel.org>
 <20230104174433.1259428-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104174433.1259428-3-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 04, 2023 at 06:44:33PM +0100, Ard Biesheuvel wrote:
> The EFI runtime services run from a dedicated stack now, and so the
> stack unwinder needs to be informed about this.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks for this!

Mark.

> ---
>  arch/arm64/include/asm/stacktrace.h | 15 +++++++++++++++
>  arch/arm64/kernel/stacktrace.c      | 12 ++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> index 4e5354beafb01bac..66ec8caa6ac07fa0 100644
> --- a/arch/arm64/include/asm/stacktrace.h
> +++ b/arch/arm64/include/asm/stacktrace.h
> @@ -106,4 +106,19 @@ static inline struct stack_info stackinfo_get_sdei_critical(void)
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
> index 117e2c180f3c77d8..83154303e682c8b6 100644
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
>  noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry,
>  			      void *cookie, struct task_struct *task,
>  			      struct pt_regs *regs)
> @@ -199,6 +208,9 @@ noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry,
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
> 2.39.0
> 
