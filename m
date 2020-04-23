Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C7E1B5A33
	for <lists+linux-efi@lfdr.de>; Thu, 23 Apr 2020 13:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgDWLPn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Apr 2020 07:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbgDWLPn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 23 Apr 2020 07:15:43 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BE6E2071C
        for <linux-efi@vger.kernel.org>; Thu, 23 Apr 2020 11:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587640542;
        bh=s8tyDeSnPmzA3UOechwoqVF+XXFNg1QxITuSBlddXoI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AT4YwH8eZp5IHZznXO/cQaUJ+StLML6fPc4x+k83Vwo7VGa4kU9nvSq8EmRat26KJ
         kWV8Po1Sy6z23if38/UldDZooVz2OqUO3YgHhfwyXUYLIQXXDORl/44JNpLNHpvpGc
         fmIds/zX8+S7BxEnvXeax5wRaepMWSYicUwD5Yvo=
Received: by mail-il1-f180.google.com with SMTP id u189so5159004ilc.4
        for <linux-efi@vger.kernel.org>; Thu, 23 Apr 2020 04:15:42 -0700 (PDT)
X-Gm-Message-State: AGi0PuYsqbXy5IliCBy68jxYOjhOGuJH22I+3KjYnlLOODqHWbqhWAEZ
        fUa03IApEcH+Wi2a39hajH4FFLuYhJsSH6E+9a4=
X-Google-Smtp-Source: APiQypLzmW1+zoNLiUJSIx5tlNAUaJ5+uL+OgyYiKK2HjdO14T/zmyhw0ztOWXjFyLcJGFkioSwKQVBIZHQZatcmNfM=
X-Received: by 2002:a92:39dd:: with SMTP id h90mr2884674ilf.80.1587640541779;
 Thu, 23 Apr 2020 04:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200422172414.6662-1-ardb@kernel.org> <20200422172414.6662-8-ardb@kernel.org>
 <47e7e7a64905eeec1094116234c80a0553b02346.camel@wdc.com>
In-Reply-To: <47e7e7a64905eeec1094116234c80a0553b02346.camel@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 23 Apr 2020 13:15:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEYrKQrQGjb8Z4b8tVgpPK3_LiZPYLL8mK3vQaBW2OXgA@mail.gmail.com>
Message-ID: <CAMj1kXEYrKQrQGjb8Z4b8tVgpPK3_LiZPYLL8mK3vQaBW2OXgA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] RISC-V: Add EFI stub support.
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 22 Apr 2020 at 20:48, Atish Patra <Atish.Patra@wdc.com> wrote:
>
> On Wed, 2020-04-22 at 19:24 +0200, Ard Biesheuvel wrote:
> > From: Atish Patra <atish.patra@wdc.com>
> >
> > Add a RISC-V architecture specific stub code that actually copies the
> > actual kernel image to a valid address and jump to it after boot
> > services
> > are terminated. Enable UEFI related kernel configs as well for RISC-
> > V.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Link:
> > https://lore.kernel.org/r/20200421033336.9663-4-atish.patra@wdc.com
> > [ardb: - move hartid fetch into check_platform_features()
> >        - use image_size not reserve_size
> >        - moved asm/efi.h addition into separate patch ]
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/riscv/Kconfig                        |  20 ++++
> >  arch/riscv/Makefile                       |   1 +
> >  arch/riscv/configs/defconfig              |   1 +
> >  drivers/firmware/efi/Kconfig              |   4 +-
> >  drivers/firmware/efi/libstub/Makefile     |  10 ++
> >  drivers/firmware/efi/libstub/riscv-stub.c | 109 ++++++++++++++++++++
> >  6 files changed, 143 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index f05dd09acd48..54c78cafcd35 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -379,10 +379,30 @@ config CMDLINE_FORCE
> >
> >  endchoice
> >
> > +config EFI_STUB
> > +     bool
> > +
> > +config EFI
> > +     bool "UEFI runtime support"
> > +     depends on OF
> > +     select LIBFDT
> > +     select UCS2_STRING
> > +     select EFI_PARAMS_FROM_FDT
> > +     select EFI_STUB
> > +     select EFI_GENERIC_STUB
>
> As palmer suggested RISCV_ISA_C should be selected here to avoid
> unintentional errors. Otherwise, every looks good.
>

Ah, I must have misunderstood. I thought using c.li instead of li was
sufficient here.


In any case, once Palmer confirms that he is ok with the approach I
suggested, he can fix that up when applying the patches.

Thanks,
Ard.


> > +     default y
> > +     help
> > +       This option provides support for runtime services provided
> > +       by UEFI firmware (such as non-volatile variables, realtime
> > +       clock, and platform reset). A UEFI stub is also provided to
> > +       allow the kernel to be booted as an EFI application. This
> > +       is only useful on systems that have UEFI firmware.
> > +
> >  endmenu
> >
> >  menu "Power management options"
> >
> >  source "kernel/power/Kconfig"
> > +source "drivers/firmware/Kconfig"
> >
> >  endmenu
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index fb6e37db836d..079435804d6d 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -80,6 +80,7 @@ head-y := arch/riscv/kernel/head.o
> >  core-y += arch/riscv/
> >
> >  libs-y += arch/riscv/lib/
> > +core-$(CONFIG_EFI_STUB) +=
> > $(objtree)/drivers/firmware/efi/libstub/lib.a
> >
> >  PHONY += vdso_install
> >  vdso_install:
> > diff --git a/arch/riscv/configs/defconfig
> > b/arch/riscv/configs/defconfig
> > index 4da4886246a4..ae69e12d306a 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -129,3 +129,4 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
> >  # CONFIG_RUNTIME_TESTING_MENU is not set
> >  CONFIG_MEMTEST=y
> >  # CONFIG_SYSFS_SYSCALL is not set
> > +CONFIG_EFI=y
> > diff --git a/drivers/firmware/efi/Kconfig
> > b/drivers/firmware/efi/Kconfig
> > index 4e788dd55b03..8bfc17381b29 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -111,7 +111,7 @@ config EFI_GENERIC_STUB
> >
> >  config EFI_ARMSTUB_DTB_LOADER
> >       bool "Enable the DTB loader"
> > -     depends on EFI_GENERIC_STUB
> > +     depends on EFI_GENERIC_STUB && !RISCV
> >       default y
> >       help
> >         Select this config option to add support for the dtb= command
> > @@ -126,7 +126,7 @@ config EFI_ARMSTUB_DTB_LOADER
> >
> >  config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
> >       bool "Enable the command line initrd loader"
> > -     depends on EFI_GENERIC_STUB
> > +     depends on EFI_GENERIC_STUB && !RISCV
> >       default y
> >       help
> >         Select this config option to add support for the initrd=
> > command
> > diff --git a/drivers/firmware/efi/libstub/Makefile
> > b/drivers/firmware/efi/libstub/Makefile
> > index 75cb2c3a1519..a4fd1b048e8c 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -22,6 +22,8 @@ cflags-$(CONFIG_ARM64)              := $(subst
> > $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >  cflags-$(CONFIG_ARM)         := $(subst
> > $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >                                  -fno-builtin -fpic \
> >                                  $(call cc-option,-mno-single-pic-
> > base)
> > +cflags-$(CONFIG_RISCV)               := $(subst
> > $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > +                                -fpic
> >
> >  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> >
> > @@ -56,6 +58,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)      += efi-stub.o
> > fdt.o string.o \
> >  lib-$(CONFIG_ARM)            += arm32-stub.o
> >  lib-$(CONFIG_ARM64)          += arm64-stub.o
> >  lib-$(CONFIG_X86)            += x86-stub.o
> > +lib-$(CONFIG_RISCV)          += riscv-stub.o
> >  CFLAGS_arm32-stub.o          := -DTEXT_OFFSET=$(TEXT_OFFSET)
> >  CFLAGS_arm64-stub.o          := -DTEXT_OFFSET=$(TEXT_OFFSET)
> >
> > @@ -80,6 +83,13 @@ STUBCOPY_FLAGS-$(CONFIG_ARM64)     += --prefix-
> > alloc-sections=.init \
> >                                  --prefix-symbols=__efistub_
> >  STUBCOPY_RELOC-$(CONFIG_ARM64)       := R_AARCH64_ABS
> >
> > +# For RISC-V, we don't need anything special other than arm64. Keep
> > all the
> > +# symbols in .init section and make sure that no absolute symbols
> > references
> > +# doesn't exist.
> > +STUBCOPY_FLAGS-$(CONFIG_RISCV)       += --prefix-alloc-
> > sections=.init \
> > +                                --prefix-symbols=__efistub_
> > +STUBCOPY_RELOC-$(CONFIG_RISCV)       := R_RISCV_HI20
> > +
> >  $(obj)/%.stub.o: $(obj)/%.o FORCE
> >       $(call if_changed,stubcopy)
> >
> > diff --git a/drivers/firmware/efi/libstub/riscv-stub.c
> > b/drivers/firmware/efi/libstub/riscv-stub.c
> > new file mode 100644
> > index 000000000000..349646928e9b
> > --- /dev/null
> > +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> > @@ -0,0 +1,109 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> > + */
> > +
> > +#include <linux/efi.h>
> > +#include <linux/libfdt.h>
> > +
> > +#include <asm/efi.h>
> > +#include <asm/sections.h>
> > +
> > +#include "efistub.h"
> > +
> > +/*
> > + * RISC-V requires the kernel image to placed 2 MB aligned base for
> > 64 bit and
> > + * 4MB for 32 bit.
> > + */
> > +#ifdef CONFIG_64BIT
> > +#define MIN_KIMG_ALIGN               SZ_2M
> > +#else
> > +#define MIN_KIMG_ALIGN               SZ_4M
> > +#endif
> > +
> > +typedef void __noreturn (*jump_kernel_func)(unsigned int, unsigned
> > long);
> > +
> > +static u32 hartid;
> > +
> > +static u32 get_boot_hartid_from_fdt(void)
> > +{
> > +     const void *fdt;
> > +     int chosen_node, len;
> > +     const fdt32_t *prop;
> > +
> > +     fdt = get_efi_config_table(DEVICE_TREE_GUID);
> > +     if (!fdt)
> > +             return U32_MAX;
> > +
> > +     chosen_node = fdt_path_offset(fdt, "/chosen");
> > +     if (chosen_node < 0)
> > +             return U32_MAX;
> > +
> > +     prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid",
> > &len);
> > +     if (!prop || len != sizeof(u32))
> > +             return U32_MAX;
> > +
> > +     return fdt32_to_cpu(*prop);
> > +}
> > +
> > +efi_status_t check_platform_features(void)
> > +{
> > +     hartid = get_boot_hartid_from_fdt();
> > +     if (hartid == U32_MAX) {
> > +             pr_efi_err("/chosen/boot-hartid missing or
> > invalid!\n");
> > +             return EFI_UNSUPPORTED;
> > +     }
> > +     return EFI_SUCCESS;
> > +}
> > +
> > +void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned
> > long fdt,
> > +                              unsigned long fdt_size)
> > +{
> > +     unsigned long kernel_entry = entrypoint + (unsigned
> > long)stext_offset;
> > +     jump_kernel_func jump_kernel = (jump_kernel_func)kernel_entry;
> > +
> > +     /*
> > +      * Jump to real kernel here with following constraints.
> > +      * 1. MMU should be disabled.
> > +      * 2. a0 should contain hartid
> > +      * 3. a1 should DT address
> > +      */
> > +     csr_write(CSR_SATP, 0);
> > +     jump_kernel(hartid, fdt);
> > +}
> > +
> > +efi_status_t handle_kernel_image(unsigned long *image_addr,
> > +                              unsigned long *image_size,
> > +                              unsigned long *reserve_addr,
> > +                              unsigned long *reserve_size,
> > +                              unsigned long dram_base,
> > +                              efi_loaded_image_t *image)
> > +{
> > +     unsigned long kernel_size = 0;
> > +     unsigned long preferred_addr;
> > +     efi_status_t status;
> > +
> > +     kernel_size = _edata - _start;
> > +     *image_addr = (unsigned long)_start;
> > +     *image_size = kernel_size + (_end - _edata);
> > +
> > +     /*
> > +      * RISC-V kernel maps PAGE_OFFSET virtual address to the same
> > physical
> > +      * address where kernel is booted. That's why kernel should
> > boot from
> > +      * as low as possible to avoid wastage of memory. Currently,
> > dram_base
> > +      * is occupied by the firmware. So the preferred address for
> > kernel to
> > +      * boot is next aligned address. If preferred address is not
> > available,
> > +      * relocate_kernel will fall back to efi_low_alloc_above to
> > allocate
> > +      * lowest possible memory region as long as the address and
> > size meets
> > +      * the alignment constraints.
> > +      */
> > +     preferred_addr = round_up(dram_base, MIN_KIMG_ALIGN) +
> > MIN_KIMG_ALIGN;
> > +     status = efi_relocate_kernel(image_addr, kernel_size,
> > *image_size,
> > +                                  preferred_addr, MIN_KIMG_ALIGN,
> > dram_base);
> > +
> > +     if (status != EFI_SUCCESS) {
> > +             pr_efi_err("Failed to relocate kernel\n");
> > +             *image_size = 0;
> > +     }
> > +     return status;
> > +}
>
> --
> Regards,
> Atish
