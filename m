Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2171A9461
	for <lists+linux-efi@lfdr.de>; Wed, 15 Apr 2020 09:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635203AbgDOHix (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Apr 2020 03:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635193AbgDOHij (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Apr 2020 03:38:39 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 982CA2168B;
        Wed, 15 Apr 2020 07:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586936318;
        bh=blH4gjOBxjn7WFCi4KHytX1AFeQLlSL4U/PYjhech+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1wPTlA9is/Gh/nWzfB+ImBC+qVX+s8y5vB9DbKAy4W+E3TkHm9J8TVcGAYaNppylW
         GwrPtV+9fZ7JrQHcMGzQOFE6F4Onw/v7pnW9ol+gUKl8MVC40+ApOaN3R+MiXJMAR4
         rAzZOTndCOZKwQDUlzC4vV7Alr+q4/7vLOg+zOSM=
Received: by mail-il1-f172.google.com with SMTP id u5so2413109ilb.5;
        Wed, 15 Apr 2020 00:38:38 -0700 (PDT)
X-Gm-Message-State: AGi0PuYlJZbWbfMx6FbOs4pjhwCBXSOhIoyWZ6QhqJd09NfML60RScsP
        1rbtLVsR98Rr34XJJcU4I8b42OUkhtP5Vqv917I=
X-Google-Smtp-Source: APiQypIkrNVXxs/wMlnqogLuZf9Vu/kXka0M3fj0eFWWchvCTcsE+iF+VuKO7xQcZtv+pU00li/uUr3Meo6zE98fDIA=
X-Received: by 2002:a92:443:: with SMTP id 64mr4309254ile.258.1586936317805;
 Wed, 15 Apr 2020 00:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200413212907.29244-1-atish.patra@wdc.com> <20200413212907.29244-6-atish.patra@wdc.com>
 <CAMj1kXEiQRORXMe4s_-iqmOefv-mbsPCtMT9ivJPvnkja+v0oQ@mail.gmail.com> <092b7101d0a72700435f64581e4356fe92d9ece8.camel@wdc.com>
In-Reply-To: <092b7101d0a72700435f64581e4356fe92d9ece8.camel@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Apr 2020 09:38:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHgcjv1G78oCvYOLQBQx7arS2a0C+E1CtZLzvk0BeeXAA@mail.gmail.com>
Message-ID: <CAMj1kXHgcjv1G78oCvYOLQBQx7arS2a0C+E1CtZLzvk0BeeXAA@mail.gmail.com>
Subject: Re: [v2 PATCH 5/5] RISC-V: Add EFI stub support.
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 15 Apr 2020 at 02:11, Atish Patra <Atish.Patra@wdc.com> wrote:
>
> On Tue, 2020-04-14 at 09:41 +0200, Ard Biesheuvel wrote:
> > On Mon, 13 Apr 2020 at 23:29, Atish Patra <atish.patra@wdc.com>
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
> > >  arch/riscv/include/asm/efi.h              |  45 ++++++++
> > >  drivers/firmware/efi/Kconfig              |   2 +-
> > >  drivers/firmware/efi/libstub/Makefile     |   8 ++
> > >  drivers/firmware/efi/libstub/riscv-stub.c | 131
> > > ++++++++++++++++++++++
> > >  7 files changed, 207 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/riscv/include/asm/efi.h
> > >  create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index f39e326a7a42..eb4f41c8f3ce 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -379,10 +379,30 @@ config CMDLINE_FORCE
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
> > > +       select EFI_GENERIC_STUB
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
> > > index fb6e37db836d..079435804d6d 100644
> > > --- a/arch/riscv/Makefile
> > > +++ b/arch/riscv/Makefile
> > > @@ -80,6 +80,7 @@ head-y := arch/riscv/kernel/head.o
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
> > > index 4da4886246a4..ae69e12d306a 100644
> > > --- a/arch/riscv/configs/defconfig
> > > +++ b/arch/riscv/configs/defconfig
> > > @@ -129,3 +129,4 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
> > >  # CONFIG_RUNTIME_TESTING_MENU is not set
> > >  CONFIG_MEMTEST=y
> > >  # CONFIG_SYSFS_SYSCALL is not set
> > > +CONFIG_EFI=y
> > > diff --git a/arch/riscv/include/asm/efi.h
> > > b/arch/riscv/include/asm/efi.h
> > > new file mode 100644
> > > index 000000000000..ba0a6d35cc15
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/efi.h
> > > @@ -0,0 +1,45 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2020 Western Digital Corporation or its
> > > affiliates.
> > > + * Based on arch/arm64/include/asm/efi.h
> > > + */
> > > +#ifndef _ASM_EFI_H
> > > +#define _ASM_EFI_H
> > > +
> > > +#include <asm/io.h>
> > > +#include <asm/mmu_context.h>
> > > +#include <asm/ptrace.h>
> > > +#include <asm/tlbflush.h>
> > > +
> > > +#define VA_BITS_MIN 39
> > > +
> > > +/* on RISC-V, the FDT may be located anywhere in system RAM */
> > > +static inline unsigned long efi_get_max_fdt_addr(unsigned long
> > > dram_base)
> > > +{
> > > +       return ULONG_MAX;
> > > +}
> > > +
> > > +/* Load initrd at enough distance from DRAM start */
> > > +static inline unsigned long efi_get_max_initrd_addr(unsigned long
> > > dram_base,
> > > +                                                   unsigned long
> > > image_addr)
> > > +{
> > > +       return dram_base + SZ_256M;
> > > +}
> > > +
> > > +#define efi_bs_call(func, ...) efi_system_table()->boottime-
> > > >func(__VA_ARGS__)
> > > +#define efi_rt_call(func, ...) efi_system_table()->runtime-
> > > >func(__VA_ARGS__)
> > > +#define efi_is_native()                (true)
> > > +
> > > +#define efi_table_attr(inst, attr)     (inst->attr)
> > > +
> > > +#define efi_call_proto(inst, func, ...) inst->func(inst,
> > > ##__VA_ARGS__)
> > > +
> > > +#define alloc_screen_info(x...)                (&screen_info)
> > > +extern char stext_offset[];
> > > +
> > > +static inline void free_screen_info(struct screen_info *si)
> > > +{
> > > +}
> > > +#define EFI_ALLOC_ALIGN                SZ_64K
> > > +
> > > +#endif /* _ASM_EFI_H */
> > > diff --git a/drivers/firmware/efi/Kconfig
> > > b/drivers/firmware/efi/Kconfig
> > > index 2a2b2b96a1dc..fcdc789d3f87 100644
> > > --- a/drivers/firmware/efi/Kconfig
> > > +++ b/drivers/firmware/efi/Kconfig
> > > @@ -111,7 +111,7 @@ config EFI_GENERIC_STUB
> > >
> > >  config EFI_ARMSTUB_DTB_LOADER
> > >         bool "Enable the DTB loader"
> > > -       depends on EFI_GENERIC_STUB
> > > +       depends on EFI_GENERIC_STUB && !RISCV
> > >         default y
> > >         help
> > >           Select this config option to add support for the dtb=
> > > command
> > > diff --git a/drivers/firmware/efi/libstub/Makefile
> > > b/drivers/firmware/efi/libstub/Makefile
> > > index d590504541f6..b1db3a793c43 100644
> > > --- a/drivers/firmware/efi/libstub/Makefile
> > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > @@ -22,6 +22,8 @@ cflags-$(CONFIG_ARM64)                := $(subst
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
> > >  cflags-$(CONFIG_EFI_GENERIC_STUB)      +=
> > > -I$(srctree)/scripts/dtc/libfdt
> > >
> > > @@ -56,6 +58,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)                +=
> > > efi-stub.o fdt.o string.o \
> > >  lib-$(CONFIG_ARM)              += arm32-stub.o
> > >  lib-$(CONFIG_ARM64)            += arm64-stub.o
> > >  lib-$(CONFIG_X86)              += x86-stub.o
> > > +lib-$(CONFIG_RISCV)            += riscv-stub.o
> > >  CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> > >  CFLAGS_arm64-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> > >
> > > @@ -80,6 +83,11 @@ STUBCOPY_FLAGS-$(CONFIG_ARM64)       += --
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
> > > index 000000000000..acb69eae187a
> > > --- /dev/null
> > > +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> > > @@ -0,0 +1,131 @@
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
> > > +#ifdef CONFIG_64BIT
> > > +#define MIN_KIMG_ALIGN SZ_2M
> > > +#else
> > > +#define MIN_KIMG_ALIGN SZ_4M
> > > +#endif
> > > +/*
> > > + * TEXT_OFFSET ensures that we don't overwrite the firmware that
> > > probably sits
> > > + * at the beginning of the DRAM.
> > > + */
> > > +#define TEXT_OFFSET MIN_KIMG_ALIGN
> > > +
> >
> > Again, this is not the right approach. If there are any allocations
> > in
> > memory that EFI cannot touch, you have to mark them as reserved in
> > the
> > EFI memory map. Otherwise, anything running in the EFI context (GRUB,
> > systemd-boot, shim, etc) could step on it, not just the kernel.
> >
>
> Correct. That's why I added the U-Boot series which takes care of
> modifying the DT to add the reserved memory regions. With those
> changes, any memory marked reserved by the firmware will be marked
> reserved in the EFI memory map. The proper kernel will
> also never map those memory regions if "nomap" is set.
>

OK, good to know.

> To be honest, I forgot to remove the TEXT_OFFSET in this series. I
> have removed it in the next version.
>

OK.

> > > +typedef __attribute__((noreturn)) void
> > > (*jump_kernel_func)(unsigned int,
> > > +                                                          unsigned
> > > long);
> > > +efi_status_t check_platform_features(void)
> > > +{
> > > +       return EFI_SUCCESS;
> > > +}
> > > +
> > > +static u32 get_boot_hartid_from_fdt(unsigned long fdt)
> > > +{
> > > +       int chosen_node, len;
> > > +       const fdt32_t *prop;
> > > +
> > > +       chosen_node = fdt_path_offset((void *)fdt, "/chosen");
> > > +       if (chosen_node < 0)
> > > +               return U32_MAX;
> > > +       prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid",
> > > &len);
> > > +       if (!prop || len != sizeof(u32))
> > > +               return U32_MAX;
> > > +
> > > +       return fdt32_to_cpu(*prop);
> > > +}
> > > +
> > > +/*
> > > + * Jump to real kernel here with following constraints.
> > > + * 1. MMU should be disabled.
> > > + * 2. a0 should contain hartid
> > > + * 3. a1 should DT address
> > > + */
> > > +void __noreturn efi_enter_kernel(unsigned long entrypoint,
> > > unsigned long fdt,
> > > +                                unsigned long fdt_size)
> > > +{
> > > +       unsigned long kernel_entry = entrypoint + (unsigned
> > > long)stext_offset;
> > > +       jump_kernel_func jump_kernel = (void (*)(unsigned int,
> > > unsigned long))kernel_entry;
> > > +       u32 hartid = get_boot_hartid_from_fdt(fdt);
> > > +
> > > +       if (hartid == U32_MAX)
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
> >
> > MIN_KIMG_ALIGN
> >
> > > +        */
> > > +       preferred_offset = round_up(dram_base, MIN_KIMG_ALIGN) +
> > > TEXT_OFFSET;
> > > +
> > > +       kernel_size = _edata - _start;
> > > +       kernel_memsize = kernel_size + (_end - _edata);
> > > +
> > > +       /*
> > > +        * Try a straight allocation at the preferred offset. It
> > > will also
> > > +        * ensure that, on platforms where the [dram_base,
> > > dram_base + TEXT_OFFSET)
> > > +        * interval is partially occupied by the firmware we can
> > > still place
> > > +        * the kernel at the address 'dram_base + TEXT_OFFSET'. If
> > > the straight
> > > +        * allocation fails, efi_low_alloc tries allocate memory
> > > from the lowest
> > > +        * available LOADER_DATA mapped memory as long as address
> > > and size meet
> > > +        * the alignment constraints.
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
> > > +               pr_efi("straight allocation failed do a low
> > > alloc\n");
> > > +               *reserve_size = kernel_memsize + TEXT_OFFSET;
> > > +               status = efi_low_alloc(*reserve_size,
> > > MIN_KIMG_ALIGN,
> > > +                                      reserve_addr);
> > > +
> >
> > So, instead of the above, could we simply allocate kernel_memsize
> > bytes using efi_allocate_pages(), with the max address set to
> > 'round_up(dram_base, MIN_KIMG_ALIGN) + kernel_memsize + TEXT_OFFSET -
> > 1'? This should work in the majority of cases, and not trample on the
> > TEXT_OFFSET bytes at the start, regardless of whether they are
> > reserved or not.
> >
>
> As per my understanding, efi_allocate_pages aligns as per
> EFI_ALLOC_ALIGN. But the kernel needs to be placed at a memory aligned
> to MIN_KIMG_ALIGN. That's why efi_allocate_pages may not work.
>

It will work if you do the round_up() afterwards. But
efi_allocate_pages_aligned() essentially does the same thing, so if
that works for you, it is preferred.

> > In the future, I imagine you may want to relax the requirements
> > regarding the physical placement of the kernel, in which case you can
> > start falling back to a suitably aligned allocation anywhere in
> > memory.
> >
> >
> >
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
> Actually, we don't have any kernel placement restriction other than
> 2MB/4MB alignment.
> (considering that firmware now marks all the reserved memory in DT).
>
> Can we just use efi_allocate_pages_aligned similar to arm64 ? It seems
> to work during my testing. But I wanted to make sure that I didn't
> misunderstand anything.
>

Yes, that is the preferred approach.
