Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC32D172917
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 21:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgB0UAI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 15:00:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729940AbgB0UAH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 27 Feb 2020 15:00:07 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9626A246B0
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582833606;
        bh=GhBHQR0KsLss9rI8vAWNephgOo+CqDMm/nyyHpxeFeU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QkruEEv+xesDG/50bYdKetEdMujdscLsOwDRATvEE6APXeCNYYFOL3lknZnhvQQpL
         u+9P0rRJmQrG+iD6hPMx0hR/sW6cRVSDnUKxokMyhE+5fQKxgW6wLy/dVyGvYvMSZB
         lmQd6cRuFOsyDmCOUGV9UbbusxS58TNYXEJM6Yd0=
Received: by mail-wr1-f42.google.com with SMTP id x7so353268wrr.0
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 12:00:06 -0800 (PST)
X-Gm-Message-State: APjAAAXMwXtB/7GWKyev8pSV76+hAL99j5TJIg0tsVKo/NTAIzi8XaZg
        VKt6cQYDQu6/b+D63G2qU/8qn8VcTnCF70kSiGIsQw==
X-Google-Smtp-Source: APXvYqwUW/XMaLwBdxrekPsTtrp6W+mlq4e08IMbboWSyEuUlsoIcXbtf7Z0gnm54wCyGWPuuEsb1HX/yZzOk42i1oY=
X-Received: by 2002:a5d:5188:: with SMTP id k8mr499630wrv.151.1582833604739;
 Thu, 27 Feb 2020 12:00:04 -0800 (PST)
MIME-Version: 1.0
References: <20200226011037.7179-1-atish.patra@wdc.com> <20200226011037.7179-6-atish.patra@wdc.com>
 <CAKv+Gu_iAzQ6et13aACarqns8-xzQ+YSqj+m3mVGGy=ny8GJBg@mail.gmail.com> <26172d39fdb5ecd951ade0a89566c010f6166a03.camel@wdc.com>
In-Reply-To: <26172d39fdb5ecd951ade0a89566c010f6166a03.camel@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 27 Feb 2020 20:59:53 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8i93gM0dMqzbhvNbqsgd9dHCMGzX7E47uusrUvv6xRJA@mail.gmail.com>
Message-ID: <CAKv+Gu8i93gM0dMqzbhvNbqsgd9dHCMGzX7E47uusrUvv6xRJA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] RISC-V: Add EFI stub support.
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.schaefer@hpe.com" <daniel.schaefer@hpe.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "greentime.hu@sifive.com" <greentime.hu@sifive.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "agraf@csgraf.de" <agraf@csgraf.de>,
        "will@kernel.org" <will@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "han_mao@c-sky.com" <han_mao@c-sky.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 27 Feb 2020 at 20:53, Atish Patra <Atish.Patra@wdc.com> wrote:
>
> On Wed, 2020-02-26 at 08:28 +0100, Ard Biesheuvel wrote:
> > On Wed, 26 Feb 2020 at 02:10, Atish Patra <atish.patra@wdc.com>
> > wrote:
> > > Add a RISC-V architecture specific stub code that actually copies
> > > the
> > > actual kernel image to a valid address and jump to it after boot
> > > services
> > > are terminated. Enable UEFI related kernel configs as well for
> > > RISC-V.
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >  arch/riscv/Kconfig                        |  20 ++++
> > >  arch/riscv/Makefile                       |   1 +
> > >  arch/riscv/configs/defconfig              |   1 +
> > >  drivers/firmware/efi/libstub/Makefile     |   8 ++
> > >  drivers/firmware/efi/libstub/riscv-stub.c | 135
> > > ++++++++++++++++++++++
> > >  5 files changed, 165 insertions(+)
> > >  create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 42c122170cfd..68b1d565e51d 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -372,10 +372,30 @@ config CMDLINE_FORCE
> > >
> > >  endchoice
> > >
> > > +config EFI_STUB
> > > +       bool
> > > +
> > > +config EFI
> > > +       bool "UEFI runtime support"
> > > +       depends on OF
> > > +       select LIBFDT
> > > +       select UCS2_STRING
> > > +       select EFI_PARAMS_FROM_FDT
> > > +       select EFI_STUB
> > > +       select EFI_GENERIC_ARCH_STUB
> > > +       default y
> > > +       help
> > > +         This option provides support for runtime services
> > > provided
> > > +         by UEFI firmware (such as non-volatile variables,
> > > realtime
> > > +          clock, and platform reset). A UEFI stub is also provided
> > > to
> > > +         allow the kernel to be booted as an EFI application. This
> > > +         is only useful on systems that have UEFI firmware.
> > > +
> > >  endmenu
> > >
> > >  menu "Power management options"
> > >
> > >  source "kernel/power/Kconfig"
> > > +source "drivers/firmware/Kconfig"
> > >
> > >  endmenu
> > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > index b9009a2fbaf5..0afaa89ba9ad 100644
> > > --- a/arch/riscv/Makefile
> > > +++ b/arch/riscv/Makefile
> > > @@ -78,6 +78,7 @@ head-y := arch/riscv/kernel/head.o
> > >  core-y += arch/riscv/
> > >
> > >  libs-y += arch/riscv/lib/
> > > +core-$(CONFIG_EFI_STUB) +=
> > > $(objtree)/drivers/firmware/efi/libstub/lib.a
> > >
> > >  PHONY += vdso_install
> > >  vdso_install:
> > > diff --git a/arch/riscv/configs/defconfig
> > > b/arch/riscv/configs/defconfig
> > > index e2ff95cb3390..0a5d3578f51e 100644
> > > --- a/arch/riscv/configs/defconfig
> > > +++ b/arch/riscv/configs/defconfig
> > > @@ -125,3 +125,4 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
> > >  # CONFIG_FTRACE is not set
> > >  # CONFIG_RUNTIME_TESTING_MENU is not set
> > >  CONFIG_MEMTEST=y
> > > +CONFIG_EFI=y
> > > diff --git a/drivers/firmware/efi/libstub/Makefile
> > > b/drivers/firmware/efi/libstub/Makefile
> > > index 2c5b76787126..38facb61745b 100644
> > > --- a/drivers/firmware/efi/libstub/Makefile
> > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > @@ -21,6 +21,8 @@ cflags-$(CONFIG_ARM64)                := $(subst
> > > $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > >  cflags-$(CONFIG_ARM)           := $(subst
> > > $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > >                                    -fno-builtin -fpic \
> > >                                    $(call cc-option,-mno-single-
> > > pic-base)
> > > +cflags-$(CONFIG_RISCV)         := $(subst
> > > $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > +                                  -fpic
> > >
> > >  cflags-$(CONFIG_EFI_GENERIC_ARCH_STUB) +=
> > > -I$(srctree)/scripts/dtc/libfdt
> > >
> > > @@ -55,6 +57,7 @@ lib-$(CONFIG_EFI_GENERIC_ARCH_STUB)           +=
> > > efi-stub.o fdt.o string.o \
> > >  lib-$(CONFIG_ARM)              += arm32-stub.o
> > >  lib-$(CONFIG_ARM64)            += arm64-stub.o
> > >  lib-$(CONFIG_X86)              += x86-stub.o
> > > +lib-$(CONFIG_RISCV)            += riscv-stub.o
> > >  CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> > >  CFLAGS_arm64-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> > >
> > > @@ -79,6 +82,11 @@ STUBCOPY_FLAGS-$(CONFIG_ARM64)       += --
> > > prefix-alloc-sections=.init \
> > >                                    --prefix-symbols=__efistub_
> > >  STUBCOPY_RELOC-$(CONFIG_ARM64) := R_AARCH64_ABS
> > >
> > > +STUBCOPY_FLAGS-$(CONFIG_RISCV) += --prefix-alloc-sections=.init \
> > > +                                  --prefix-symbols=__efistub_
> > > +STUBCOPY_RELOC-$(CONFIG_RISCV) := R_RISCV_HI20
> > > +
> > > +
> > >  $(obj)/%.stub.o: $(obj)/%.o FORCE
> > >         $(call if_changed,stubcopy)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/riscv-stub.c
> > > b/drivers/firmware/efi/libstub/riscv-stub.c
> > > new file mode 100644
> > > index 000000000000..3935b29ea93a
> > > --- /dev/null
> > > +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> > > @@ -0,0 +1,135 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2013, 2014 Linaro Ltd;  <roy.franz@linaro.org>
> > > + * Copyright (C) 2020 Western Digital Corporation or its
> > > affiliates.
> > > + *
> > > + * This file implements the EFI boot stub for the RISC-V kernel.
> > > + * Adapted from ARM64 version at
> > > drivers/firmware/efi/libstub/arm64-stub.c.
> > > + */
> > > +
> > > +#include <linux/efi.h>
> > > +#include <linux/libfdt.h>
> > > +#include <linux/libfdt_env.h>
> > > +#include <asm/efi.h>
> > > +#include <asm/sections.h>
> > > +
> > > +#include "efistub.h"
> > > +/*
> > > + * RISCV requires the kernel image to placed TEXT_OFFSET bytes
> > > beyond a 2 MB
> > > + * aligned base for 64 bit and 4MB for 32 bit.
> > > + */
> > > +#if IS_ENABLED(CONFIG_64BIT)
> >
> > You can use #ifdef here
> >
>
> ok.
>
> > > +#define MIN_KIMG_ALIGN SZ_2M
> > > +#else
> > > +#define MIN_KIMG_ALIGN SZ_4M
> > > +#endif
> > > +/*
> > > + * TEXT_OFFSET ensures that we don't overwrite the firmware that
> > > probably sits
> > > + * at the beginning of the DRAM.
> > > + */
> >
> > Ugh. Really? On an EFI system, that memory should be reserved in some
> > way, we shouldn't be able to stomp on it like that.
> >
>
> Currently, we reserve the initial 128KB for run time firmware(only
> openSBI for now, EDK2 later) by using PMP (physical memory protection).
> Any acess to that region from supervisor mode (i.e. U-Boot) will result
> in a fault.
>
> Is it mandatory for UEFI to reserve the beginning of the DRAM ?
>

It is mandatory to describe which memory is usable and which memory is
reserved. If this memory is not usable, you either describe it as
reserved, or not describe it at all. Describing it as usable memory,
allocating it for the kernel but with a hidden agreement that it is
reserved is highly likely to cause problems down the road.



> > > +#define TEXT_OFFSET MIN_KIMG_ALIGN
> > > +
> > > +typedef __attribute__((noreturn)) void
> > > (*jump_kernel_func)(unsigned int,
> > > +                                                          unsigned
> > > long);
> > > +
> > > +efi_status_t check_platform_features(void)
> > > +{
> > > +       return EFI_SUCCESS;
> > > +}
> > > +
> > > +u64 get_boot_hartid_from_fdt(unsigned long fdt)
> >
> > static
> >
> > > +{
> > > +       int chosen_node, len;
> > > +       const fdt64_t *prop;
> > > +       uint64_t hartid = U64_MAX;
> > > +
> > > +       chosen_node = fdt_path_offset((void *)fdt, "/chosen");
> > > +       if (chosen_node < 0)
> > > +               return hartid;
> >
> > Just return U64_MAX here
> >
> > > +       prop = fdt_getprop((void *)fdt, chosen_node, "efi-boot-
> > > hartid", &len);
> >
> > Please call this 'boot-hartid' not 'efi-boot-hartid' as the hartid
> > value is independent of whether you boot via EFI or not.
> >
> > > +       if (!prop || len != sizeof(u64))
> > > +               return hartid;
> > > +
> >
> > Return U64_MAX
> >
> > > +       hartid = fdt64_to_cpu(*prop);
> > > +
> >
> > and just return the swabbed value, so you can get rid of the local
> > var.
> >
>
> Fixed all the above issues. I changed it to u32 as u64 won't work on 32
> bit systems.
>

If the hart id is only 32 bits max then i guess that will work.

> > > +       return hartid;
> > > +}
> > > +
> > > +/*
> > > + * Jump to real kernel here with following constraints.
> > > + * 1. MMU should be disabled.
> > > + * 2. a0 should contain hartid
> > > + * 3. a1 should DT address
> > > + */
> > > +void __noreturn efi_enter_kernel(unsigned long entrypoint,
> > > unsigned long fdt)
> >
> > This prototype has changed, and now includes the size of the fdt in
> > param 3.
> >
>
> Ahh yes. Fixed.
>
> > > +{
> > > +       unsigned long kernel_entry = entrypoint + _start_kernel -
> > > _start;
> >
> > stext_offset ? It has a terrible name though, and I'll probably
> > propose to change it at some point, for all arches. But you can still
> > use it here.
> >
>
> Sure. I updated it with stext_offset.
>
> > > +       jump_kernel_func jump_kernel = (void (*)(unsigned int,
> > > unsigned long))kernel_entry;
> > > +       u64 hartid = get_boot_hartid_from_fdt(fdt);
> > > +
> > > +       if (hartid == U64_MAX)
> > > +               /* We can not use panic or BUG at this point */
> > > +               __asm__ __volatile__ ("ebreak");
> > > +       /* Disable MMU */
> > > +       csr_write(CSR_SATP, 0);
> > > +       jump_kernel(hartid, fdt);
> > > +}
> > > +
> > > +efi_status_t handle_kernel_image(unsigned long *image_addr,
> > > +                                unsigned long *image_size,
> > > +                                unsigned long *reserve_addr,
> > > +                                unsigned long *reserve_size,
> > > +                                unsigned long dram_base,
> > > +                                efi_loaded_image_t *image)
> > > +{
> > > +       efi_status_t status;
> > > +       unsigned long kernel_size, kernel_memsize = 0;
> > > +       unsigned long preferred_offset;
> > > +
> > > +       /*
> > > +        * The preferred offset of the kernel Image is TEXT_OFFSET
> > > bytes beyond
> > > +        * a KIMG_ALIGN aligned base.
> > > +        */
> > > +       preferred_offset = round_up(dram_base, MIN_KIMG_ALIGN) +
> > > TEXT_OFFSET;
> > > +
> > > +       kernel_size = _edata - _start;
> > > +       kernel_memsize = kernel_size + (_end - _edata);
> > > +
> > > +       /*
> > > +        * Try a straight allocation at the preferred offset.
> > > +        * This will work around the issue where, if dram_base ==
> > > 0x0,
> > > +        * efi_low_alloc() refuses to allocate at 0x0 (to prevent
> > > the
> > > +        * address of the allocation to be mistaken for a FAIL
> > > return
> > > +        * value or a NULL pointer). It will also ensure that, on
> > > +        * platforms where the [dram_base, dram_base + TEXT_OFFSET)
> > > +        * interval is partially occupied by the firmware (like on
> > > APM
> > > +        * Mustang), we can still place the kernel at the address
> > > +        * 'dram_base + TEXT_OFFSET'.
> >
> > Better drop this entire last sentence (unless it is relevant, but
> > then
> > rework it to drop the APM Mustang reference)
> >
>
> As stated above, RISC-V firmware occupies [dram_base, dram_base +
> 128K). That's why I thought this comment is useful. I should have
> removed the mustand reference. I will update it.
>
> > > +        */
> > > +       if (*image_addr == preferred_offset)
> > > +               return EFI_SUCCESS;
> > > +
> > > +       *image_addr = *reserve_addr = preferred_offset;
> > > +       *reserve_size = round_up(kernel_memsize, EFI_ALLOC_ALIGN);
> > > +
> > > +       status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
> > > +                               EFI_LOADER_DATA,
> > > +                               *reserve_size / EFI_PAGE_SIZE,
> > > +                               (efi_physical_addr_t
> > > *)reserve_addr);
> > > +
> > > +       if (status != EFI_SUCCESS) {
> > > +               *reserve_size = kernel_memsize + TEXT_OFFSET;
> > > +               status = efi_low_alloc(*reserve_size,
> > > MIN_KIMG_ALIGN,
> > > +                                      reserve_addr);
> > > +
> > > +               if (status != EFI_SUCCESS) {
> > > +                       pr_efi_err("Failed to relocate kernel\n");
> > > +                       *reserve_size = 0;
> > > +                       return status;
> > > +               }
> > > +               *image_addr = *reserve_addr + TEXT_OFFSET;
> > > +       }
> > > +       memcpy((void *)*image_addr, image->image_base,
> > > kernel_size);
> > > +
> > > +       return EFI_SUCCESS;
> > > +}
> > > --
> > > 2.24.0
> > >
>
> --
> Regards,
> Atish
