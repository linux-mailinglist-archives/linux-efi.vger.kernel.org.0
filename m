Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDCE20C127
	for <lists+linux-efi@lfdr.de>; Sat, 27 Jun 2020 13:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgF0L7q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Jun 2020 07:59:46 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:64406 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0L7q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Jun 2020 07:59:46 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 05RBxLuL005471;
        Sat, 27 Jun 2020 20:59:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 05RBxLuL005471
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593259162;
        bh=33K0o4jMyuNW1m+uNmwZD39xg5DgxY8M9/Y0nUDsReo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IaskzhGPOnpWNrLEhw05tUWuu/9onmdQSGDzGi6q348VwVNAQFsIL17D34Cn4nwzd
         WzTV7yw7SMzW/PULklT6EqM+fi94lNywSQKMQlv8gDpBvgTAz71m4xFL/lD3K4P41X
         lZd5h6LnyXS4hoVOSPmEUTk5pA9jFWxzPZlLTEMcxNKY7qjs1S5a3KZyPdJRMHEcsu
         5Zp4d6FbM1pMAYupG3oS9GvJoluPzO8l7bAJJh/3ocxXncgYZRNLg6wQwRR50+DdLD
         M9Fe0+EA0+hcCmwvsqBaP0edpn+xNha/Rpq6yRreVFp3o+ZOmuPK2pvFOHON8jUvN8
         kApnCABezGbpA==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id b205so2488920vkb.8;
        Sat, 27 Jun 2020 04:59:21 -0700 (PDT)
X-Gm-Message-State: AOAM532UWbcXIDv8THhRoheGqiixiTjGtlbHttiAGajyV7btuUXDQu76
        aCgsfwx77eIX1rTUmDxZEQjIJ1nchS1gX4OI2uI=
X-Google-Smtp-Source: ABdhPJxtYjCsm8j5OAsLI6FQikY5L8/yPhKzTFSua9Z5ykU5LqtgpneaerUWj21FIYNDbvCGsbGmq+eiEKXGVx68+Cg=
X-Received: by 2002:a1f:1f04:: with SMTP id f4mr5014768vkf.73.1593259160073;
 Sat, 27 Jun 2020 04:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200626185913.92890-1-masahiroy@kernel.org> <CAKwvOd=V_M43CP7G87K3TqSsxua2NcXPz6BnDt-z6167O2WAzQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=V_M43CP7G87K3TqSsxua2NcXPz6BnDt-z6167O2WAzQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 27 Jun 2020 20:58:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATcwGkSWV7NSgwG_WqzvTPphT9=KK+qvT3FK_7y1UCzTA@mail.gmail.com>
Message-ID: <CAK7LNATcwGkSWV7NSgwG_WqzvTPphT9=KK+qvT3FK_7y1UCzTA@mail.gmail.com>
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

On Sat, Jun 27, 2020 at 5:13 AM Nick Desaulniers
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
>
> Generally looks pretty good, just a few more questions before adding
> my tag explicitly.
>
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
>
> So it looks like the previous behavior always added
> `-fno-stack-protector` (since CONFIG_CC_HAS_STACKPROTECTOR_NONE was
> always true), but then we append either `-fstack-protector` or
> `-fstack-protector-strong` based on configs.  While that's ok, and you
> patch doesn't change that behavior, and it's good to be explicit to
> set the stack protector or not...it seems weird to have
> `-fno-stack-protector -fstack-protector` in the command line flags.  I
> would prefer if we checked for not having CONFIG_STACKPROTECTOR or
> CONFIG_STACKPROTECTOR_STRONG before adding `-fno-stack-protector`.
> That doesn't have to be done in this patch, per se.
>
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
> >
> >  # Options used by linker script
> >  export LDS_START      := $(START)
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 00e378de8bc0..89c3cdfba753 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -37,7 +37,7 @@ REALMODE_CFLAGS       := $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
> >                    -mno-mmx -mno-sse
> >
> >  REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -ffreestanding)
> > -REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -fno-stack-protector)
> > +REALMODE_CFLAGS += -fno-stack-protector
> >  REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
> >  REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
> >  export REALMODE_CFLAGS
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 7619742f91c9..c88a31569a5e 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -36,7 +36,7 @@ cflags-$(CONFIG_X86_64) := -mcmodel=small
> >  KBUILD_CFLAGS += $(cflags-y)
> >  KBUILD_CFLAGS += -mno-mmx -mno-sse
> >  KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
> > -KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
> > +KBUILD_CFLAGS += -fno-stack-protector
> >  KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
> >  KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
> >  KBUILD_CFLAGS += -Wno-pointer-sign
> > diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> > index 04e65f0698f6..215376d975a2 100644
> > --- a/arch/x86/entry/vdso/Makefile
> > +++ b/arch/x86/entry/vdso/Makefile
> > @@ -82,7 +82,7 @@ $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
> >  # optimize sibling calls.
> >  #
> >  CFL := $(PROFILING) -mcmodel=small -fPIC -O2 -fasynchronous-unwind-tables -m64 \
> > -       $(filter -g%,$(KBUILD_CFLAGS)) $(call cc-option, -fno-stack-protector) \
> > +       $(filter -g%,$(KBUILD_CFLAGS)) -fno-stack-protector \
> >         -fno-omit-frame-pointer -foptimize-sibling-calls \
> >         -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
> >
> > @@ -151,7 +151,7 @@ KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
> >  KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
> >  KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
> >  KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
> > -KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
> > +KBUILD_CFLAGS_32 += -fno-stack-protector
> >  KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
> >  KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
> >  KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
> > diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
> > index dba6a83bc349..93792b457b81 100644
> > --- a/arch/x86/kernel/cpu/Makefile
> > +++ b/arch/x86/kernel/cpu/Makefile
> > @@ -17,8 +17,7 @@ KCOV_INSTRUMENT_perf_event.o := n
> >  KCSAN_SANITIZE_common.o := n
> >
> >  # Make sure load_percpu_segment has no stackprotector
> > -nostackp := $(call cc-option, -fno-stack-protector)
> > -CFLAGS_common.o                := $(nostackp)
> > +CFLAGS_common.o                := -fno-stack-protector
>
> Any time I see `:=` assignment to a CFLAGS variable, it's a red flag
> for overwriting existing CFLAGS, which is a common source of bugs.  I
> recognize the kernel is current a mix and match for:
>
> CFLAGS_<file>.o
>
> rules to either use `+=` or `:=`, but I wish we were consistent, and
> consistent in our use of `+=`.  For those rules, is there a difference
> between the use of `+=` and `:=` like there is for the more general
> case of appending to KBUILD_CFLAGS?  If not, it's ok to match the
> existing style, but it's curious to me in this patch to see a mixed
> use of `+=` and `:=`.


I think Kees mostly answered your question.

Let me add some comments.


'+=' is the most used in kernel Makefiles, but
':=' and '=' are also used.

So, you are right, we are inconsistent.
This applies to not only CFLAGS_<file>.o, but also obj-y, etc.

For example,
https://github.com/torvalds/linux/blob/v5.7/arch/arm64/kernel/Makefile#L15
'obj-y :=' works since it is the first assignment to obj-y in that file.
'obj-y +=' also works, of course.

We can consistently use '+=' everywhere, but I do not send
patches for churn.


You can use any assignment operator to CFLAGS_<file>.o
if it is the first assignment in the Makefile.
Using '+=' is robust for future code insertion/removal, though.


If the right-hand side contains variable references,
there is important difference in the behavior.

You may know two flavors in variables
(https://www.gnu.org/software/make/manual/make.html#Flavors)


CFLAGS_foo.o := $(call cc-option,-fno-stack-protector)
The cc-option is expanded immediately when this line is parsed.
(So, the compiler is invoked for 'make clean' too)


CFLAGS_foo.o += $(call cc-option,-fno-stack-protector)
If this is the first assignment in the file,
'+=' act as '=', so the evaluation of cc-option
is delayed until $(CFLAGS_foo.o) is expanded.
(So, the compiler is NOT invoked for 'make clean')



-- 
Best Regards
Masahiro Yamada
