Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9829120B9A9
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 22:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgFZUBU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Jun 2020 16:01:20 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:51729 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFZUBT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Jun 2020 16:01:19 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 05QK0nG4004437;
        Sat, 27 Jun 2020 05:00:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 05QK0nG4004437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593201650;
        bh=OXHwkDS97YKhUrAvqCEhi2sUp24PxBPo/pfpCJH3QVE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fHAHcOXeaFkZ3dNHc3TCO/Fn79SdloQnS0ouLQM9CAiOxATrdzoIsu9gA9PobvQjy
         uhxzwbi9QzCgoPtOsJZRkeG4yb4WFGuYabOR+8gguc+bdbelw2Ek37iH2RbC1a2rih
         zNXi128WnnwyTz6Z2d7kMBFT0TBJmfRyshq+TLNM43UJ/WFd8TVgFyyCeNmXFYSfDK
         0TS7y1wiUn6GRdWqxasvhq8d3mkARRMsTzboF+TYpCYEq1t1UuS/o06gFELErXEIyR
         lZPgR38erJexcZRh8aQ9QvLNL0DN6gjxbYqAY+vDEETap5gCbuMYkrUDHupdaDjG/i
         t4f0Hc3Us9TjA==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id k7so4766647vso.2;
        Fri, 26 Jun 2020 13:00:50 -0700 (PDT)
X-Gm-Message-State: AOAM5329E/rjy1QqIJ90z1463gmc3taBlqVUTVEDyF3FooeB0XH4qR4/
        I7AeD9Xi/LA+ekMUQt1jtvYysNKp6/2dzKnVyJI=
X-Google-Smtp-Source: ABdhPJzp9e+JAYW0XdVMuASkiuMc/lyWSlI2W2q//y0vxO2Q5ASawknG9RbzoxyXXm/WPKeBVq/gwycL53AFY3KPTLM=
X-Received: by 2002:a67:f813:: with SMTP id l19mr3783323vso.215.1593201648927;
 Fri, 26 Jun 2020 13:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200626185913.92890-1-masahiroy@kernel.org> <CAKwvOdnK4KZaE=D40UyKHN-nB1Y-oXXJUcVv08cGJNsExOs-Pw@mail.gmail.com>
In-Reply-To: <CAKwvOdnK4KZaE=D40UyKHN-nB1Y-oXXJUcVv08cGJNsExOs-Pw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 27 Jun 2020 05:00:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNASx-kj=fHFN9=NDB-HKRSdWAEpGyKF86q8127SqFc07Ag@mail.gmail.com>
Message-ID: <CAK7LNASx-kj=fHFN9=NDB-HKRSdWAEpGyKF86q8127SqFc07Ag@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: remove cc-option test of -fno-stack-protector
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jun 27, 2020 at 4:09 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jun 26, 2020 at 12:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Some Makefiles already pass -fno-stack-protector unconditionally.
> > For example, arch/arm64/kernel/vdso/Makefile, arch/x86/xen/Makefile.
> > No problem report so far about hard-coding this option. So, we can
> > assume all supported compilers know -fno-stack-protector.
> >
> > GCC 4.8 and Clang support this option (https://godbolt.org/z/_HDGzN)
> >
> > Get rid of cc-option from -fno-stack-protector.
> >
> > Remove CONFIG_CC_HAS_STACKPROTECTOR_NONE, which should always be 'y'.
> >
> > Note:
> > arch/mips/vdso/Makefile adds -fno-stack-protector twice, first
> > unconditionally, and second conditionally. I removed the second one.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Documentation/kbuild/kconfig-language.rst | 4 ++--
> >  Makefile                                  | 2 +-
> >  arch/Kconfig                              | 3 ---
> >  arch/arm/boot/compressed/Makefile         | 3 +--
> >  arch/mips/vdso/Makefile                   | 3 +--
> >  arch/powerpc/kernel/Makefile              | 2 +-
> >  arch/powerpc/platforms/powermac/Makefile  | 2 +-
> >  arch/sparc/vdso/Makefile                  | 4 ++--
> >  arch/um/Makefile                          | 3 +--
> >  arch/x86/Makefile                         | 2 +-
> >  arch/x86/boot/compressed/Makefile         | 2 +-
> >  arch/x86/entry/vdso/Makefile              | 4 ++--
> >  arch/x86/kernel/cpu/Makefile              | 3 +--
> >  arch/x86/lib/Makefile                     | 2 +-
> >  arch/x86/mm/Makefile                      | 7 +++----
> >  arch/x86/power/Makefile                   | 3 +--
> >  arch/x86/purgatory/Makefile               | 2 +-
> >  arch/x86/um/vdso/Makefile                 | 2 +-
> >  arch/x86/xen/Makefile                     | 5 ++---
> >  drivers/firmware/efi/libstub/Makefile     | 2 +-
> >  drivers/xen/Makefile                      | 3 +--
> >  kernel/kcsan/Makefile                     | 3 +--
> >  lib/Makefile                              | 4 ++--
> >  mm/kasan/Makefile                         | 2 +-
> >  24 files changed, 30 insertions(+), 42 deletions(-)
> >
> > diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
> > index a1601ec3317b..2538e7cb08e6 100644
> > --- a/Documentation/kbuild/kconfig-language.rst
> > +++ b/Documentation/kbuild/kconfig-language.rst
> > @@ -540,8 +540,8 @@ followed by a test macro::
> >  If you need to expose a compiler capability to makefiles and/or C source files,
> >  `CC_HAS_` is the recommended prefix for the config option::
> >
> > -  config CC_HAS_STACKPROTECTOR_NONE
> > -       def_bool $(cc-option,-fno-stack-protector)
> > +  config CC_HAS_ASM_GOTO
> > +       def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
> >
> >  Build as module only
> >  ~~~~~~~~~~~~~~~~~~~~
> > diff --git a/Makefile b/Makefile
> > index 5496a32dffa6..73948798ce3f 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -762,7 +762,7 @@ ifneq ($(CONFIG_FRAME_WARN),0)
> >  KBUILD_CFLAGS += -Wframe-larger-than=$(CONFIG_FRAME_WARN)
> >  endif
> >
> > -stackp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
> > +stackp-flags-y                                    := -fno-stack-protector
> >  stackp-flags-$(CONFIG_STACKPROTECTOR)             := -fstack-protector
> >  stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 8cc35dc556c7..1ea61290900a 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -478,9 +478,6 @@ config HAVE_STACKPROTECTOR
> >           An arch should select this symbol if:
> >           - it has implemented a stack canary (e.g. __stack_chk_guard)
> >
> > -config CC_HAS_STACKPROTECTOR_NONE
> > -       def_bool $(cc-option,-fno-stack-protector)
> > -
> >  config STACKPROTECTOR
> >         bool "Stack Protector buffer overflow detection"
> >         depends on HAVE_STACKPROTECTOR
> > diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> > index 00602a6fba04..cb7a56c6723c 100644
> > --- a/arch/arm/boot/compressed/Makefile
> > +++ b/arch/arm/boot/compressed/Makefile
> > @@ -84,9 +84,8 @@ endif
> >
> >  # -fstack-protector-strong triggers protection checks in this code,
> >  # but it is being used too early to link to meaningful stack_chk logic.
> > -nossp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
> >  $(foreach o, $(libfdt_objs) atags_to_fdt.o, \
> > -       $(eval CFLAGS_$(o) := -I $(srctree)/scripts/dtc/libfdt $(nossp-flags-y)))
> > +       $(eval CFLAGS_$(o) := -I $(srctree)/scripts/dtc/libfdt -fno-stack-protector))
> >
> >  # These were previously generated C files. When you are building the kernel
> >  # with O=, make sure to remove the stale files in the output tree. Otherwise,
> > diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
> > index 2e64c7600eea..57fe83235281 100644
> > --- a/arch/mips/vdso/Makefile
> > +++ b/arch/mips/vdso/Makefile
> > @@ -35,8 +35,7 @@ cflags-vdso := $(ccflags-vdso) \
> >         -O3 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
> >         -mrelax-pic-calls $(call cc-option, -mexplicit-relocs) \
> >         -fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
> > -       $(call cc-option, -fno-asynchronous-unwind-tables) \
> > -       $(call cc-option, -fno-stack-protector)
> > +       $(call cc-option, -fno-asynchronous-unwind-tables)
> >  aflags-vdso := $(ccflags-vdso) \
> >         -D__ASSEMBLY__ -Wa,-gdwarf-2
> >
> > diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> > index 244542ae2a91..3a83f2b876a5 100644
> > --- a/arch/powerpc/kernel/Makefile
> > +++ b/arch/powerpc/kernel/Makefile
> > @@ -16,7 +16,7 @@ CFLAGS_prom_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
> >  CFLAGS_btext.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
> >  CFLAGS_prom.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
> >
> > -CFLAGS_prom_init.o += $(call cc-option, -fno-stack-protector)
> > +CFLAGS_prom_init.o += -fno-stack-protector
> >  CFLAGS_prom_init.o += -DDISABLE_BRANCH_PROFILING
> >  CFLAGS_prom_init.o += -ffreestanding
> >
> > diff --git a/arch/powerpc/platforms/powermac/Makefile b/arch/powerpc/platforms/powermac/Makefile
> > index f4247ade71ca..cf85f0662d0d 100644
> > --- a/arch/powerpc/platforms/powermac/Makefile
> > +++ b/arch/powerpc/platforms/powermac/Makefile
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  CFLAGS_bootx_init.o            += -fPIC
> > -CFLAGS_bootx_init.o            += $(call cc-option, -fno-stack-protector)
> > +CFLAGS_bootx_init.o            += -fno-stack-protector
> >
> >  KASAN_SANITIZE_bootx_init.o := n
> >
> > diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> > index 708cb6304c2d..f44355e46f31 100644
> > --- a/arch/sparc/vdso/Makefile
> > +++ b/arch/sparc/vdso/Makefile
> > @@ -54,7 +54,7 @@ $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
> >  # optimize sibling calls.
> >  #
> >  CFL := $(PROFILING) -mcmodel=medlow -fPIC -O2 -fasynchronous-unwind-tables -m64 \
> > -       $(filter -g%,$(KBUILD_CFLAGS)) $(call cc-option, -fno-stack-protector) \
> > +       $(filter -g%,$(KBUILD_CFLAGS)) -fno-stack-protector \
> >         -fno-omit-frame-pointer -foptimize-sibling-calls \
> >         -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
> >
> > @@ -93,7 +93,7 @@ KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
> >  KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
> >  KBUILD_CFLAGS_32 := $(filter-out $(SPARC_REG_CFLAGS),$(KBUILD_CFLAGS_32))
> >  KBUILD_CFLAGS_32 += -m32 -msoft-float -fpic
> > -KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
> > +KBUILD_CFLAGS_32 += -fno-stack-protector
> >  KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
> >  KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
> >  KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
> > diff --git a/arch/um/Makefile b/arch/um/Makefile
> > index 3f27aa3ec0a6..1cea46ff9bb7 100644
> > --- a/arch/um/Makefile
> > +++ b/arch/um/Makefile
> > @@ -121,8 +121,7 @@ LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
> >  LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib $(call cc-option, -no-pie)
> >
> >  CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
> > -       $(call cc-option, -fno-stack-protector,) \
> > -       $(call cc-option, -fno-stack-protector-all,)
> > +       -fno-stack-protector $(call cc-option, -fno-stack-protector-all)
>
> Just curious, looks like we could do the same for
> `-fno-stack-protector-all`, here or tree-wide, right?  Wait, what
> compiler recognizes -fno-stack-protector-all?
> https://godbolt.org/z/QFQKE_


-fstack-protector
-fstack-protector-strong
-fstack-protector-all

are supported.

But,

-fno-stack-protector-strong
-fno-stack-protector-all

are unsupported.



Perheps, -fno-stack-protector is enough
to disable all variants of stack-protector.



-- 
Best Regards
Masahiro Yamada
