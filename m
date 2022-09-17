Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9505BB8B5
	for <lists+linux-efi@lfdr.de>; Sat, 17 Sep 2022 16:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiIQON6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 17 Sep 2022 10:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiIQON4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 17 Sep 2022 10:13:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 833AF32BB1;
        Sat, 17 Sep 2022 07:13:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AEB9153B;
        Sat, 17 Sep 2022 07:14:01 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D04083F71A;
        Sat, 17 Sep 2022 07:13:52 -0700 (PDT)
Date:   Sat, 17 Sep 2022 15:13:40 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     guoren@kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        Conor.Dooley@microchip.com, xianting.tian@linux.alibaba.com,
        daolu@rivosinc.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [RFC PATCH] generic_entry: Add stackleak support
Message-ID: <YyXWFI6OdVecqYcp@FVFF77S0Q05N>
References: <20220907014809.919979-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907014809.919979-1-guoren@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 06, 2022 at 09:48:09PM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Make generic_entry supports basic STACKLEAK, and no arch custom
> code is needed.

IIUC, this change is going to cause redundant work to be done on x86 (since it
erases the stack in its entry assembly). It also means any arch relying upon
this will not clear some stack contents that could be cleared from assembly
later in the return to userspace path, after the C entry code stack frames are
gone.

I assume you're adding this so that riscv can use stackleak? WHy can't it call
stackleak_erase*() later in the return-to-userspce path?

> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  drivers/firmware/efi/libstub/Makefile | 4 +++-
>  include/linux/stackleak.h             | 3 +++
>  kernel/entry/common.c                 | 5 +++++
>  security/Kconfig.hardening            | 2 +-
>  4 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index d0537573501e..bb6ad37a9690 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -19,7 +19,7 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
>  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>  # disable the stackleak plugin
>  cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> -				   -fpie $(DISABLE_STACKLEAK_PLUGIN) \
> +				   -fpie \
>  				   $(call cc-option,-mbranch-protection=none)
>  cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>  				   -fno-builtin -fpic \
> @@ -27,6 +27,8 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>  cflags-$(CONFIG_RISCV)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>  				   -fpic
>  
> +cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK) += $(DISABLE_STACKLEAK_PLUGIN)
> +
>  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
>  
>  KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \

Huh; is there a latent bug here where x86's EFI stub is instrumented with
stackleak?

Thanks,
Mark.

> diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
> index c36e7a3b45e7..9890802a5868 100644
> --- a/include/linux/stackleak.h
> +++ b/include/linux/stackleak.h
> @@ -76,8 +76,11 @@ static inline void stackleak_task_init(struct task_struct *t)
>  # endif
>  }
>  
> +void noinstr stackleak_erase(void);
> +
>  #else /* !CONFIG_GCC_PLUGIN_STACKLEAK */
>  static inline void stackleak_task_init(struct task_struct *t) { }
> +static inline void stackleak_erase(void) {}
>  #endif
>  
>  #endif
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 063068a9ea9b..6acb1d6a1396 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -8,6 +8,7 @@
>  #include <linux/livepatch.h>
>  #include <linux/audit.h>
>  #include <linux/tick.h>
> +#include <linux/stackleak.h>
>  
>  #include "common.h"
>  
> @@ -194,6 +195,10 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
>  
>  	lockdep_assert_irqs_disabled();
>  
> +#ifndef CONFIG_HAVE_ARCH_STACKLEAK
> +	stackleak_erase();
> +#endif
> +
>  	/* Flush pending rcuog wakeup before the last need_resched() check */
>  	tick_nohz_user_enter_prepare();
>  
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index bd2aabb2c60f..3329482beb8d 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -152,7 +152,7 @@ config GCC_PLUGIN_STRUCTLEAK_VERBOSE
>  config GCC_PLUGIN_STACKLEAK
>  	bool "Poison kernel stack before returning from syscalls"
>  	depends on GCC_PLUGINS
> -	depends on HAVE_ARCH_STACKLEAK
> +	depends on HAVE_ARCH_STACKLEAK || GENERIC_ENTRY
>  	help
>  	  This option makes the kernel erase the kernel stack before
>  	  returning from system calls. This has the effect of leaving
> -- 
> 2.36.1
> 
