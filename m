Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2385BBA05
	for <lists+linux-efi@lfdr.de>; Sat, 17 Sep 2022 20:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIQS5n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 17 Sep 2022 14:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIQS5m (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 17 Sep 2022 14:57:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06A224BDE;
        Sat, 17 Sep 2022 11:57:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E726B80DE9;
        Sat, 17 Sep 2022 18:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20525C433D6;
        Sat, 17 Sep 2022 18:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663441058;
        bh=Hfb+Y6609FU56495iKUs6WONqSCIZRkSDoJzpLP1bNU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kaiOLslFnvEvNltWIYU7+uBic7DCn9x8mDUo2ooZiMjFh/6UPQsIbZk2U65v4bhON
         kiFALgX0jCR4TP38gHhlLuaK083tQMvWqY8U2OMwCMyzNm2ho5Z5jdwW4EYaVhVDla
         vDHrV3QYd/nOSCnbWGVUFjUKXVwAg1G/5Z+PNTAZcpEobo4rkxN0P9q5DcBvEFv8ga
         LAMcSyYv7nxVrTOYA+HYBAduRKuTe4wwVCSjkPX4mOJvwcCHX7C2whpj8K63DuntM4
         C/8l0g7aHWx5PGidPKkBtJf7baISveCTzKRd+K4vFIs/8XwJDLKjonyg+IGPelydTT
         kpW4pyQHJbm+A==
Received: by mail-oi1-f176.google.com with SMTP id n124so9982686oih.7;
        Sat, 17 Sep 2022 11:57:38 -0700 (PDT)
X-Gm-Message-State: ACgBeo1MgUyI203WiCVUBsKtp3bitpDJDQR4yeoQxExXzX/BxU3PTuBf
        aUpVFlssOlcSzZoBcmAhEhVkSu0miay3qRzn0q0=
X-Google-Smtp-Source: AA6agR617xmrGntRDUuQNT4f0XrlTICsJm83ygJiFiSi2G4z/bmA27iiZ0FDha/WBvap2QE/A62uCxU5+EONPJuiBCw=
X-Received: by 2002:a05:6808:151f:b0:350:1b5e:2380 with SMTP id
 u31-20020a056808151f00b003501b5e2380mr7865764oiw.112.1663441057188; Sat, 17
 Sep 2022 11:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220907014809.919979-1-guoren@kernel.org> <YyXWFI6OdVecqYcp@FVFF77S0Q05N>
In-Reply-To: <YyXWFI6OdVecqYcp@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 18 Sep 2022 02:57:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRNLp5CxP0nK3=duUk_Sq+BbNmNGd0icxna86+4DdR3jQ@mail.gmail.com>
Message-ID: <CAJF2gTRNLp5CxP0nK3=duUk_Sq+BbNmNGd0icxna86+4DdR3jQ@mail.gmail.com>
Subject: Re: [RFC PATCH] generic_entry: Add stackleak support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        Conor.Dooley@microchip.com, xianting.tian@linux.alibaba.com,
        daolu@rivosinc.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Sep 17, 2022 at 10:13 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Sep 06, 2022 at 09:48:09PM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Make generic_entry supports basic STACKLEAK, and no arch custom
> > code is needed.
>
> IIUC, this change is going to cause redundant work to be done on x86 (since it
> erases the stack in its entry assembly). It also means any arch relying upon
> this will not clear some stack contents that could be cleared from assembly
> later in the return to userspace path, after the C entry code stack frames are
> gone.
Yeah, it's a point, Thx.


>
> I assume you're adding this so that riscv can use stackleak? WHy can't it call
> stackleak_erase*() later in the return-to-userspce path?
Okay, I would move stackleak_erase back to riscv code and call it in
ret_from_exception of entry.S.

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 426529b84db0..fe5f67c3ea2c 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -130,7 +130,6 @@ END(handle_exception)
 ENTRY(ret_from_exception)
        REG_L s0, PT_STATUS(sp)

-       csrc CSR_STATUS, SR_IE
 #ifdef CONFIG_RISCV_M_MODE
        /* the MPP value is too large to be used as an immediate arg for addi */
        li t0, SR_MPP
@@ -139,6 +138,8 @@ ENTRY(ret_from_exception)
        andi s0, s0, SR_SPP
 #endif
        bnez s0, 1f
+       call stackleak_erase
+       csrc CSR_STATUS, SR_IE

        /* Save unwound kernel stack pointer in thread_info */
        addi s0, sp, PT_SIZE_ON_STACK
@@ -150,6 +151,7 @@ ENTRY(ret_from_exception)
         */
        csrw CSR_SCRATCH, tp
 1:
+       csrc CSR_STATUS, SR_IE

>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  drivers/firmware/efi/libstub/Makefile | 4 +++-
> >  include/linux/stackleak.h             | 3 +++
> >  kernel/entry/common.c                 | 5 +++++
> >  security/Kconfig.hardening            | 2 +-
> >  4 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index d0537573501e..bb6ad37a9690 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -19,7 +19,7 @@ cflags-$(CONFIG_X86)                += -m$(BITS) -D__KERNEL__ \
> >  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
> >  # disable the stackleak plugin
> >  cflags-$(CONFIG_ARM64)               := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > -                                -fpie $(DISABLE_STACKLEAK_PLUGIN) \
> > +                                -fpie \
> >                                  $(call cc-option,-mbranch-protection=none)
> >  cflags-$(CONFIG_ARM)         := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >                                  -fno-builtin -fpic \
> > @@ -27,6 +27,8 @@ cflags-$(CONFIG_ARM)                := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >  cflags-$(CONFIG_RISCV)               := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >                                  -fpic
> >
> > +cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK) += $(DISABLE_STACKLEAK_PLUGIN)
> > +
> >  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> >
> >  KBUILD_CFLAGS                        := $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
>
> Huh; is there a latent bug here where x86's EFI stub is instrumented with
> stackleak?
Oops, I forgot x86. Thank you for reminding.


>
> Thanks,
> Mark.
>
> > diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
> > index c36e7a3b45e7..9890802a5868 100644
> > --- a/include/linux/stackleak.h
> > +++ b/include/linux/stackleak.h
> > @@ -76,8 +76,11 @@ static inline void stackleak_task_init(struct task_struct *t)
> >  # endif
> >  }
> >
> > +void noinstr stackleak_erase(void);
> > +
> >  #else /* !CONFIG_GCC_PLUGIN_STACKLEAK */
> >  static inline void stackleak_task_init(struct task_struct *t) { }
> > +static inline void stackleak_erase(void) {}
> >  #endif
> >
> >  #endif
> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> > index 063068a9ea9b..6acb1d6a1396 100644
> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/livepatch.h>
> >  #include <linux/audit.h>
> >  #include <linux/tick.h>
> > +#include <linux/stackleak.h>
> >
> >  #include "common.h"
> >
> > @@ -194,6 +195,10 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
> >
> >       lockdep_assert_irqs_disabled();
> >
> > +#ifndef CONFIG_HAVE_ARCH_STACKLEAK
> > +     stackleak_erase();
> > +#endif
> > +
> >       /* Flush pending rcuog wakeup before the last need_resched() check */
> >       tick_nohz_user_enter_prepare();
> >
> > diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> > index bd2aabb2c60f..3329482beb8d 100644
> > --- a/security/Kconfig.hardening
> > +++ b/security/Kconfig.hardening
> > @@ -152,7 +152,7 @@ config GCC_PLUGIN_STRUCTLEAK_VERBOSE
> >  config GCC_PLUGIN_STACKLEAK
> >       bool "Poison kernel stack before returning from syscalls"
> >       depends on GCC_PLUGINS
> > -     depends on HAVE_ARCH_STACKLEAK
> > +     depends on HAVE_ARCH_STACKLEAK || GENERIC_ENTRY
> >       help
> >         This option makes the kernel erase the kernel stack before
> >         returning from system calls. This has the effect of leaving
> > --
> > 2.36.1
> >



--
Best Regards
 Guo Ren
