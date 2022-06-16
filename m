Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433B954D9BF
	for <lists+linux-efi@lfdr.de>; Thu, 16 Jun 2022 07:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358677AbiFPFg7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Jun 2022 01:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350831AbiFPFg5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Jun 2022 01:36:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321D65B3D0
        for <linux-efi@vger.kernel.org>; Wed, 15 Jun 2022 22:36:56 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f8so425560plo.9
        for <linux-efi@vger.kernel.org>; Wed, 15 Jun 2022 22:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8VvB5cP8XpJaCAMqO5do3F/JBWBM4/eP8xN9r0iP2ZE=;
        b=QRlKg40WepExwXx4ITl36DcMiKlONXzjcoIYe1YCxxNxa160Uwfmk8J2wd1Ur+ecm9
         qACZXB++MKTKxRF5skD8FP2TXNnoRI/MaySoXbuspnWeU+aTSAR3rOOzJ6X6PK8CfHqe
         ydB4d1vdWYUsnA0sQkznYfHobMCsDgcwgiTuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8VvB5cP8XpJaCAMqO5do3F/JBWBM4/eP8xN9r0iP2ZE=;
        b=D6FOoRwvgfOOj7gYMuJVtdYuZqzSX4kOA8pT3RUQ8c90nkvUZyK6YNifRjKGCAhPbl
         b+BqcU23nRCtXTpI/1Qt9EdRdeUn8DBV5Oo9wSGpz1AD8DiuXclFeK3DhcYrxMuB4MUN
         5n0hIgbUOqAkKAvgRM3WMsXQeHIVpSAnPAcSHPhbCyx8QZ6V2Du+q5cs5fblHpbWA/YO
         GZOU92ZlO/vAPi1JLVcLxWPlBZ3fGhBqOL/DQzEog1rQQJNTapg0CXPnjRciRLIKA35e
         MIGrJMFLppbkhb3mkDLWx0ZwHrrGAncSxhKxxWI8Kfkg6vEhfI7yoQDZ686LMJexmelG
         z7Vw==
X-Gm-Message-State: AJIora+gje5PvOtKXhktxf/auFN8ICx7cy35BN7o3iThnLtlFe7DdA8y
        NcQk8q4V6QnwiXLPUddxO2eiRQ==
X-Google-Smtp-Source: AGRyM1u1yfJsO6JQiPI/cS0mNrZQ90lnEJf4H298TQ7uNVIe7cET5tpqTJnbT+ld+HS8Fv9pWgNbAw==
X-Received: by 2002:a17:90b:1bc1:b0:1ea:8403:92b5 with SMTP id oa1-20020a17090b1bc100b001ea840392b5mr3209374pjb.116.1655357815610;
        Wed, 15 Jun 2022 22:36:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903024300b001624965d83bsm617411plh.228.2022.06.15.22.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 22:36:55 -0700 (PDT)
Date:   Wed, 15 Jun 2022 22:36:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dao Lu <daolu@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Changbin Du <changbin.du@intel.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        "open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" 
        <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] arch/riscv: Add support for STACKLEAK gcc plugin
Message-ID: <202206152234.DE7FC51F9@keescook>
References: <20220615213834.3116135-1-daolu@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615213834.3116135-1-daolu@rivosinc.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 15, 2022 at 02:38:29PM -0700, Dao Lu wrote:
> This adds support for STACKLEAK gcc plugin to ricv by implementing

typo: riscv

> stackleak_check_alloca, based heavily on the arm64 version, and adding

stackleak_check_alloca does not exist. Was this maybe from an older
commit log?

> the two helpers used by the stackleak common code:
> current_top_of_stack() and on_thread_stack(). This also adds the missing
> helper functions for riscv, on_stack() and on_task_stack().
> Additionally, this disables the plugin for EFI stub code for riscv.

I can't speak to the arch-specific bits here, but if this passes the
current LKDTM tests, then that should be a good indication that it's
working. :)

> 
> Signed-off-by: Dao Lu <daolu@rivosinc.com>
> ---
>  arch/riscv/Kconfig                    |  1 +
>  arch/riscv/include/asm/processor.h    | 18 ++++++++++++++++++
>  arch/riscv/include/asm/stacktrace.h   | 27 +++++++++++++++++++++++++++
>  arch/riscv/kernel/entry.S             |  3 +++
>  drivers/firmware/efi/libstub/Makefile |  2 +-
>  5 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c22f58155948..22aa146acd25 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -80,6 +80,7 @@ config RISCV
>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>  	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_STACKLEAK
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
>  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 21c8072dce17..3a7505ab7f58 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -85,6 +85,24 @@ int riscv_of_parent_hartid(struct device_node *node);
>  extern void riscv_fill_hwcap(void);
>  extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>  
> +/*
> + * For CONFIG_GCC_PLUGIN_STACKLEAK
> + *
> + * These need to be macros because otherwise we get stuck in a nightmare
> + * of header definitions for the use of task_stack_page.
> + */
> +
> +struct stack_info {
> +	unsigned long low;
> +	unsigned long high;
> +};
> +
> +/*
> + * The top of the current task's task stack
> + */
> +#define current_top_of_stack()	((unsigned long)current->stack + THREAD_SIZE)
> +#define on_thread_stack()	(on_task_stack(current, current_stack_pointer, 1, NULL))
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_RISCV_PROCESSOR_H */
> diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm/stacktrace.h
> index 3450c1912afd..afb66b677b6a 100644
> --- a/arch/riscv/include/asm/stacktrace.h
> +++ b/arch/riscv/include/asm/stacktrace.h
> @@ -16,4 +16,31 @@ extern void notrace walk_stackframe(struct task_struct *task, struct pt_regs *re
>  extern void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
>  			   const char *loglvl);
>  
> +static inline bool on_stack(unsigned long sp, unsigned long size,
> +			    unsigned long low, unsigned long high,
> +			    struct stack_info *info)
> +{
> +	if (!low)
> +		return false;
> +
> +	if (sp < low || sp + size < sp || sp + size > high)
> +		return false;
> +
> +	if (info) {
> +		info->low = low;
> +		info->high = high;
> +	}
> +	return true;
> +}
> +
> +static inline bool on_task_stack(const struct task_struct *tsk,
> +				 unsigned long sp, unsigned long size,
> +				 struct stack_info *info)
> +{
> +	unsigned long low = (unsigned long)task_stack_page(tsk);
> +	unsigned long high = low + THREAD_SIZE;
> +
> +	return on_stack(sp, size, low, high, info);
> +}
> +
>  #endif /* _ASM_RISCV_STACKTRACE_H */
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 2e5b88ca11ce..65d441cb560f 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -264,6 +264,9 @@ ret_from_exception:
>  	bnez s0, resume_kernel
>  
>  resume_userspace:
> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +	call stackleak_erase
> +#endif
>  	/* Interrupts must be disabled here so flags are checked atomically */
>  	REG_L s0, TASK_TI_FLAGS(tp) /* current_thread_info->flags */
>  	andi s1, s0, _TIF_WORK_MASK
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index d0537573501e..5e1fc4f82883 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>  				   -fno-builtin -fpic \
>  				   $(call cc-option,-mno-single-pic-base)
>  cflags-$(CONFIG_RISCV)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> -				   -fpic
> +				   -fpic $(DISABLE_STACKLEAK_PLUGIN)
>  
>  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
>  
> -- 
> 2.25.1
> 

-- 
Kees Cook
