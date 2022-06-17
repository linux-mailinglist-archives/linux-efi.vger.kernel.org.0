Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A915D54FB20
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jun 2022 18:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383305AbiFQQcy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Jun 2022 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383264AbiFQQcy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Jun 2022 12:32:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBC96562
        for <linux-efi@vger.kernel.org>; Fri, 17 Jun 2022 09:32:52 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d13so4286281plh.13
        for <linux-efi@vger.kernel.org>; Fri, 17 Jun 2022 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9u51CE6MuvCEUihOmshcU90j7YwKJB4q4TkXfgvMtC0=;
        b=h3N1IudI9o50D0w+VbgATrzUm5tzxG8m5/3TIip9oD12Q5E2hSppZ8I3Ao/7MHZf3r
         GSGupEluqHTR9AxlhXqS4ak/vmOIqx5dzkTrmQJNcfNmygbJ8LZ0iHf/qodAaRl9yY62
         Ds0bfB68mVpCbq5/QCsnTbps1RUPWyspfVItNBtc2D68V7KC4ydDei4dmGTDGj1CO5SR
         fHr2I7WDXpZsqM8hTWO7JcJmwiUeJTwEMtJsb/uoRIvHAAPafc6Gq04hi4GOuNSpXTom
         m8ugJOGII/Icyer8wllOpTsgl/X2ilNol3br2svETk6je0Bnncg7LRPnHf9Fii3izYDf
         aGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9u51CE6MuvCEUihOmshcU90j7YwKJB4q4TkXfgvMtC0=;
        b=6az4Sn2ojJJjk72FTSyHdmcrlkTiCfldPv0AQIXvxq/XrO9Pg60QSssDI0G07RCbOt
         dXFN1x2HN+chE4ujdunkm8NilGsGIn/Wdnvo7brV3iDrZyeLM+1azndxCfqdIru2+BK9
         +aeKvrfrTB2pnChAOjkxOkF0tRUqwNrUfC0/WtFxgGSXxmdtCdz/D8fYf3H9IUu5kfXJ
         2/gpPnsRRTwHdO0Be/sYXJaFtI2ePowm/KRY94ZuH/p4SYrCinmMRKEwj2cOOld26QJL
         h3zuZFM+cOqjxQlLzrkg5eQz9OZgIqDM4AgXVDZmrv7nmr7N0iswgEZfPQ239rT9lx3d
         2jNA==
X-Gm-Message-State: AJIora+TvgAvVsaXKGPpYs/ks5qaf+Rbqoh9XPCTy0MoyYer6EuMw4lE
        k7uNybGzK0jfCaZbwWAb5e5uEX908xRDSxRiacte+A==
X-Google-Smtp-Source: AGRyM1uf7VCaHqSgIUjTnPjgfFEPONMk5ZxvJTqh8FMyfXm1LN7UasCXa61qYfMu2xHbnmKSQUqX4h2Mug1YdAvz1Jk=
X-Received: by 2002:a17:902:e552:b0:163:6a5e:4e08 with SMTP id
 n18-20020a170902e55200b001636a5e4e08mr10171956plf.130.1655483571756; Fri, 17
 Jun 2022 09:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220615213834.3116135-1-daolu@rivosinc.com> <202206152234.DE7FC51F9@keescook>
In-Reply-To: <202206152234.DE7FC51F9@keescook>
From:   Dao Lu <daolu@rivosinc.com>
Date:   Fri, 17 Jun 2022 09:32:41 -0700
Message-ID: <CAKh7v-Rjk+35mmgZ3eE1_9fu7_fkqD-EB4RM6DBOKPhCLcts1g@mail.gmail.com>
Subject: Re: [PATCH] arch/riscv: Add support for STACKLEAK gcc plugin
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Thanks Kees.

> stackleak_check_alloca does not exist. Was this maybe from an older
commit log?

Yeah it was from an older version and was later removed, I will take it away
from the commit message in the next version.

Thanks,
Dao


On Wed, Jun 15, 2022 at 10:36 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jun 15, 2022 at 02:38:29PM -0700, Dao Lu wrote:
> > This adds support for STACKLEAK gcc plugin to ricv by implementing
>
> typo: riscv
>
> > stackleak_check_alloca, based heavily on the arm64 version, and adding
>
> stackleak_check_alloca does not exist. Was this maybe from an older
> commit log?
>
> > the two helpers used by the stackleak common code:
> > current_top_of_stack() and on_thread_stack(). This also adds the missing
> > helper functions for riscv, on_stack() and on_task_stack().
> > Additionally, this disables the plugin for EFI stub code for riscv.
>
> I can't speak to the arch-specific bits here, but if this passes the
> current LKDTM tests, then that should be a good indication that it's
> working. :)
>
> >
> > Signed-off-by: Dao Lu <daolu@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig                    |  1 +
> >  arch/riscv/include/asm/processor.h    | 18 ++++++++++++++++++
> >  arch/riscv/include/asm/stacktrace.h   | 27 +++++++++++++++++++++++++++
> >  arch/riscv/kernel/entry.S             |  3 +++
> >  drivers/firmware/efi/libstub/Makefile |  2 +-
> >  5 files changed, 50 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index c22f58155948..22aa146acd25 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -80,6 +80,7 @@ config RISCV
> >       select HAVE_ARCH_MMAP_RND_BITS if MMU
> >       select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> >       select HAVE_ARCH_SECCOMP_FILTER
> > +     select HAVE_ARCH_STACKLEAK
> >       select HAVE_ARCH_TRACEHOOK
> >       select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
> >       select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > index 21c8072dce17..3a7505ab7f58 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -85,6 +85,24 @@ int riscv_of_parent_hartid(struct device_node *node);
> >  extern void riscv_fill_hwcap(void);
> >  extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
> >
> > +/*
> > + * For CONFIG_GCC_PLUGIN_STACKLEAK
> > + *
> > + * These need to be macros because otherwise we get stuck in a nightmare
> > + * of header definitions for the use of task_stack_page.
> > + */
> > +
> > +struct stack_info {
> > +     unsigned long low;
> > +     unsigned long high;
> > +};
> > +
> > +/*
> > + * The top of the current task's task stack
> > + */
> > +#define current_top_of_stack()       ((unsigned long)current->stack + THREAD_SIZE)
> > +#define on_thread_stack()    (on_task_stack(current, current_stack_pointer, 1, NULL))
> > +
> >  #endif /* __ASSEMBLY__ */
> >
> >  #endif /* _ASM_RISCV_PROCESSOR_H */
> > diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm/stacktrace.h
> > index 3450c1912afd..afb66b677b6a 100644
> > --- a/arch/riscv/include/asm/stacktrace.h
> > +++ b/arch/riscv/include/asm/stacktrace.h
> > @@ -16,4 +16,31 @@ extern void notrace walk_stackframe(struct task_struct *task, struct pt_regs *re
> >  extern void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
> >                          const char *loglvl);
> >
> > +static inline bool on_stack(unsigned long sp, unsigned long size,
> > +                         unsigned long low, unsigned long high,
> > +                         struct stack_info *info)
> > +{
> > +     if (!low)
> > +             return false;
> > +
> > +     if (sp < low || sp + size < sp || sp + size > high)
> > +             return false;
> > +
> > +     if (info) {
> > +             info->low = low;
> > +             info->high = high;
> > +     }
> > +     return true;
> > +}
> > +
> > +static inline bool on_task_stack(const struct task_struct *tsk,
> > +                              unsigned long sp, unsigned long size,
> > +                              struct stack_info *info)
> > +{
> > +     unsigned long low = (unsigned long)task_stack_page(tsk);
> > +     unsigned long high = low + THREAD_SIZE;
> > +
> > +     return on_stack(sp, size, low, high, info);
> > +}
> > +
> >  #endif /* _ASM_RISCV_STACKTRACE_H */
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 2e5b88ca11ce..65d441cb560f 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -264,6 +264,9 @@ ret_from_exception:
> >       bnez s0, resume_kernel
> >
> >  resume_userspace:
> > +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> > +     call stackleak_erase
> > +#endif
> >       /* Interrupts must be disabled here so flags are checked atomically */
> >       REG_L s0, TASK_TI_FLAGS(tp) /* current_thread_info->flags */
> >       andi s1, s0, _TIF_WORK_MASK
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index d0537573501e..5e1fc4f82883 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)                := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >                                  -fno-builtin -fpic \
> >                                  $(call cc-option,-mno-single-pic-base)
> >  cflags-$(CONFIG_RISCV)               := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > -                                -fpic
> > +                                -fpic $(DISABLE_STACKLEAK_PLUGIN)
> >
> >  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> >
> > --
> > 2.25.1
> >
>
> --
> Kees Cook
