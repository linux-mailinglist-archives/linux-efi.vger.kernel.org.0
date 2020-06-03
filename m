Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C991ECBA3
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jun 2020 10:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgFCIgt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Jun 2020 04:36:49 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:48565 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFCIgt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Jun 2020 04:36:49 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 0538aPiS020583;
        Wed, 3 Jun 2020 17:36:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 0538aPiS020583
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1591173386;
        bh=NxqSJBg8D8C1YsmrHM+mF5MoQe65tmoe3D+vaOQDOKM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ktSp8YrhvT/Kpy42OkGt/Hv4iuob/8xHkzYKUE5yjsFOsWVRxn/oBW/RvP/1MvuXn
         GSzweM/XjVJKkDhwpYsg+z10jhIM8FwTFmp4DcwNc0Qx57HlepiDlKP1u5NVwmbjfW
         J1X7b1iQvGort1uQg0gxLHq1Waq9Avw3QeH8JW4vDVAAYESPZQSh9M8U654sosvXz/
         xzxGj0Z4efH2MlIYUHNe1HcDEYD0Gg2bOG+VjtgSGkbO4Gi9ha6xeJm0YkcBimJ0RK
         l9mkvuDec1C/H5EsbjdP+DpSxMfR1OCiQGwovF9woFBZFQhkxxytg5AAFUyp0zVwz5
         KbqJ3+TgDZFNw==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id y123so909629vsb.6;
        Wed, 03 Jun 2020 01:36:26 -0700 (PDT)
X-Gm-Message-State: AOAM532mewYAqLRKi3pbvQW2pstiPgSABtPUTK3FMROv3s0n1DN227hk
        EOBsYON6+4rbFHXas2xMbGVo8/66fAhwjAAb0Yo=
X-Google-Smtp-Source: ABdhPJzYSBgSCJ6OroZkJeJc3OcbCz18pTAqEfCVovW3lv0ayn3q7oo63JILbdbwyAqTugDZXRL78X571Y8yZWYQKE4=
X-Received: by 2002:a05:6102:1081:: with SMTP id s1mr20654080vsr.215.1591173384904;
 Wed, 03 Jun 2020 01:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200603053313.3863761-1-masahiroy@kernel.org> <CAMj1kXGk-2pyTZ3yNW14Kk4fvtsNOb7maAHVM2C=vVAjaaFRug@mail.gmail.com>
In-Reply-To: <CAMj1kXGk-2pyTZ3yNW14Kk4fvtsNOb7maAHVM2C=vVAjaaFRug@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 3 Jun 2020 17:35:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNARg70FrTmnuoUiLM6KWxeJ+AeXqgB53GS6sY7z0J+qH6g@mail.gmail.com>
Message-ID: <CAK7LNARg70FrTmnuoUiLM6KWxeJ+AeXqgB53GS6sY7z0J+qH6g@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: refactor Makefile to not use lib-y syntax
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 3, 2020 at 3:45 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 3 Jun 2020 at 07:34, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Documentation/kbuild/makefiles.rst says:
> >
> >   Use of lib-y is normally restricted to `lib/` and `arch/*/lib`.
> >
> > I want to disallow lib-y outside of them.
> >
>
> Why?


Because I plan to remove lib-y entirely at some point.

lib-y is not so useful to shrink the image size because:

  - An object in lib.a can be omitted only when no symbol
    in that object is referenced.  This rarely happens.

  -  lib-y objects are often exported by nature
     because lib-y is a collection of utility functions.
     Even if no in-tree user, we always need to keep them
     because EXPORT_SYMBOL() is the interface to modules.


When I worked on commit 7273ad2b08f8ac9563579d16a3cf528857b26f49,
I made some research.

The benefit of lib-y is just 362 byte for x86_64_defconfig.
( Before: 26578002, After: 26578364)

My hope is lib-y will be replaced by dead-code elimination or
ultimately by LTO.

drivers/firmware/efi/libstub/Makefile
is the only Makefile that breaks the rule:
"Use of lib-y is normally restricted to `lib/` and `arch/*/lib`"




>
> > Add a custom rule to build lib.a, which is linked to the decompressor
> > for ARCH=x86, ARCH=arm.
> >
> > For ARCH=arm64, use obj-y to link objects to vmlinux in the ordinary
> > way.
> >
>
> The code works perfectly fine as is, and I don't see what is
> fundamentally wrong with using static libraries outside of lib/ and
> arch/*/lib.

The intended usage of lib-y is to hook lib.a
to scripts/vmlinux.sh via KBUILD_VMLINUX_LIBS.

This Makefile is just what you found to work.


>
> Also, I would like this code to still be incorporated as a static
> library into arm64 as well, so that only pieces that are actually
> needed are incorporated into the final image.

No.
It is not working like that because you set
lib.a to core-y.

All objects in core-y are always linked to vmlinux.




Thanks.





>
>
>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/arm64/Makefile                   |  1 -
> >  drivers/firmware/efi/Makefile         |  2 +-
> >  drivers/firmware/efi/libstub/Makefile | 51 +++++++++++++++------------
> >  3 files changed, 30 insertions(+), 24 deletions(-)
> >
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index 650e1185c190..ab79b20efc8d 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -145,7 +145,6 @@ export      TEXT_OFFSET
> >
> >  core-y         += arch/arm64/
> >  libs-y         := arch/arm64/lib/ $(libs-y)
> > -core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> >
> >  # Default target when executing plain make
> >  boot           := arch/arm64/boot
> > diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> > index 7a216984552b..317a05cd388b 100644
> > --- a/drivers/firmware/efi/Makefile
> > +++ b/drivers/firmware/efi/Makefile
> > @@ -20,7 +20,7 @@ obj-$(CONFIG_EFI_VARS_PSTORE)         += efi-pstore.o
> >  obj-$(CONFIG_UEFI_CPER)                        += cper.o
> >  obj-$(CONFIG_EFI_RUNTIME_MAP)          += runtime-map.o
> >  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)     += runtime-wrappers.o
> > -subdir-$(CONFIG_EFI_STUB)              += libstub
> > +obj-$(CONFIG_EFI_STUB)                 += libstub/
> >  obj-$(CONFIG_EFI_FAKE_MEMMAP)          += fake_map.o
> >  obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)   += efibc.o
> >  obj-$(CONFIG_EFI_TEST)                 += test/
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index cce4a7436052..e4e9b17fa3b2 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -44,7 +44,7 @@ OBJECT_FILES_NON_STANDARD     := y
> >  # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
> >  KCOV_INSTRUMENT                        := n
> >
> > -lib-y                          := efi-stub-helper.o gop.o secureboot.o tpm.o \
> > +stub-obj-y                     := efi-stub-helper.o gop.o secureboot.o tpm.o \
> >                                    file.o mem.o random.o randomalloc.o pci.o \
> >                                    skip_spaces.o lib-cmdline.o lib-ctype.o \
> >                                    alignedmem.o relocate.o vsprintf.o
> > @@ -55,15 +55,19 @@ efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
> >  $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
> >         $(call if_changed_rule,cc_o_c)
> >
> > -lib-$(CONFIG_EFI_GENERIC_STUB) += efi-stub.o fdt.o string.o \
> > +stub-obj-$(CONFIG_EFI_GENERIC_STUB)    += efi-stub.o fdt.o string.o \
> >                                    $(patsubst %.c,lib-%.o,$(efi-deps-y))
> >
> > -lib-$(CONFIG_ARM)              += arm32-stub.o
> > -lib-$(CONFIG_ARM64)            += arm64-stub.o
> > -lib-$(CONFIG_X86)              += x86-stub.o
> > +stub-obj-$(CONFIG_ARM)         += arm32-stub.o
> > +stub-obj-$(CONFIG_ARM64)       += arm64-stub.o
> > +stub-obj-$(CONFIG_X86)         += x86-stub.o
> >  CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> >  CFLAGS_arm64-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> >
> > +targets                                += $(stub-obj-y)
> > +stub-obj-y                     := $(patsubst %.o,%.stub.o, $(stub-obj-y))
> > +targets                                += $(stub-obj-y)
> > +
> >  #
> >  # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
> >  # .bss section, so the .bss section of the EFI stub needs to be included in the
> > @@ -83,23 +87,6 @@ STUBCOPY_FLAGS-$(CONFIG_ARM) += --rename-section .data=.data.efistub \
> >                                    --rename-section .bss=.bss.efistub,load,alloc
> >  STUBCOPY_RELOC-$(CONFIG_ARM)   := R_ARM_ABS
> >
> > -#
> > -# arm64 puts the stub in the kernel proper, which will unnecessarily retain all
> > -# code indefinitely unless it is annotated as __init/__initdata/__initconst etc.
> > -# So let's apply the __init annotations at the section level, by prefixing
> > -# the section names directly. This will ensure that even all the inline string
> > -# literals are covered.
> > -# The fact that the stub and the kernel proper are essentially the same binary
> > -# also means that we need to be extra careful to make sure that the stub does
> > -# not rely on any absolute symbol references, considering that the virtual
> > -# kernel mapping that the linker uses is not active yet when the stub is
> > -# executing. So build all C dependencies of the EFI stub into libstub, and do
> > -# a verification pass to see if any absolute relocations exist in any of the
> > -# object files.
> > -#
> > -extra-y                                := $(lib-y)
> > -lib-y                          := $(patsubst %.o,%.stub.o,$(lib-y))
> > -
> >  STUBCOPY_FLAGS-$(CONFIG_ARM64) += --prefix-alloc-sections=.init \
> >                                    --prefix-symbols=__efistub_
> >  STUBCOPY_RELOC-$(CONFIG_ARM64) := R_AARCH64_ABS
> > @@ -121,3 +108,23 @@ quiet_cmd_stubcopy = STUBCPY $@
> >                 /bin/false;                                             \
> >         fi;                                                             \
> >         $(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
> > +
> > +# arm64 puts the stub in the kernel proper, which will unnecessarily retain all
> > +# code indefinitely unless it is annotated as __init/__initdata/__initconst etc.
> > +# So let's apply the __init annotations at the section level, by prefixing
> > +# the section names directly. This will ensure that even all the inline string
> > +# literals are covered.
> > +# The fact that the stub and the kernel proper are essentially the same binary
> > +# also means that we need to be extra careful to make sure that the stub does
> > +# not rely on any absolute symbol references, considering that the virtual
> > +# kernel mapping that the linker uses is not active yet when the stub is
> > +# executing. So build all C dependencies of the EFI stub into libstub, and do
> > +# a verification pass to see if any absolute relocations exist in any of the
> > +# object files.
> > +#
> > +obj-$(CONFIG_ARM64)            += $(stub-obj-y)
> > +extra-$(CONFIG_ARM)            += lib.a
> > +extra-$(CONFIG_X86)            += lib.a
> > +
> > +$(obj)/lib.a: $(addprefix $(obj)/, $(stub-obj-y)) FORCE
> > +       $(call if_changed,ar)
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best Regards
Masahiro Yamada
