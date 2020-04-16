Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3F71ABA2A
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 09:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439575AbgDPHlp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 03:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439429AbgDPHl3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 16 Apr 2020 03:41:29 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0AFC21582;
        Thu, 16 Apr 2020 07:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587022887;
        bh=4TTjkqAnPzESEaMpzyDsW4qMG4adBNBzCXldkWbAPyE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vRvys4fO4FDYliZJeVbmNAA97rCUERxdV7ADIqrheaPVpAL7GFMdyqLlhXnaCg14r
         sUTijIXIVRyUwhRJTW2+mJt4pjHG7DhGVgZ92wNStjkuyB4wBwRLhuOeb3PMuj/twf
         KhIDsipyZ+f+hjWiS3l5rN3jfhwHFkowAXxXg5rU=
Received: by mail-il1-f179.google.com with SMTP id t4so4608718ilp.1;
        Thu, 16 Apr 2020 00:41:26 -0700 (PDT)
X-Gm-Message-State: AGi0PuapTDyg2axckATnsI7JzzK5S2V76hJxfPN+xTOUCKwul26VkL+z
        7hAbHoVjaw9F09XRLpHzwSdp5HFNRmpvM3zLRTs=
X-Google-Smtp-Source: APiQypL5oR5E7VbE7BgqZAbumpfrcAQB5g358CMMmKUvg++j1Mmhxkuo0M1gmJuOzAr+fIuhB4m0om7t/aqIYvV2tPk=
X-Received: by 2002:a92:991c:: with SMTP id p28mr4968802ili.258.1587022886147;
 Thu, 16 Apr 2020 00:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200415195422.19866-1-atish.patra@wdc.com> <20200415195422.19866-6-atish.patra@wdc.com>
In-Reply-To: <20200415195422.19866-6-atish.patra@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Apr 2020 09:41:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFRqTYr7_M_j6oN1-xnQ6V4uCYK49yAbjvrf1BB823Cng@mail.gmail.com>
Message-ID: <CAMj1kXFRqTYr7_M_j6oN1-xnQ6V4uCYK49yAbjvrf1BB823Cng@mail.gmail.com>
Subject: Re: [v3 PATCH 5/5] RISC-V: Add EFI stub support.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 15 Apr 2020 at 21:54, Atish Patra <atish.patra@wdc.com> wrote:
>
> Add a RISC-V architecture specific stub code that actually copies the
> actual kernel image to a valid address and jump to it after boot services
> are terminated. Enable UEFI related kernel configs as well for RISC-V.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/Kconfig                        |  20 ++++
>  arch/riscv/Makefile                       |   1 +
>  arch/riscv/configs/defconfig              |   1 +
>  arch/riscv/include/asm/efi.h              |  44 +++++++++
>  drivers/firmware/efi/Kconfig              |   2 +-
>  drivers/firmware/efi/libstub/Makefile     |   7 ++
>  drivers/firmware/efi/libstub/riscv-stub.c | 111 ++++++++++++++++++++++
>  7 files changed, 185 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/efi.h
>  create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f39e326a7a42..eb4f41c8f3ce 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -379,10 +379,30 @@ config CMDLINE_FORCE
>
>  endchoice
>
> +config EFI_STUB
> +       bool
> +
> +config EFI
> +       bool "UEFI runtime support"
> +       depends on OF
> +       select LIBFDT
> +       select UCS2_STRING
> +       select EFI_PARAMS_FROM_FDT
> +       select EFI_STUB
> +       select EFI_GENERIC_STUB
> +       default y
> +       help
> +         This option provides support for runtime services provided
> +         by UEFI firmware (such as non-volatile variables, realtime
> +          clock, and platform reset). A UEFI stub is also provided to
> +         allow the kernel to be booted as an EFI application. This
> +         is only useful on systems that have UEFI firmware.
> +
>  endmenu
>
>  menu "Power management options"
>
>  source "kernel/power/Kconfig"
> +source "drivers/firmware/Kconfig"
>
>  endmenu
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index fb6e37db836d..079435804d6d 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -80,6 +80,7 @@ head-y := arch/riscv/kernel/head.o
>  core-y += arch/riscv/
>
>  libs-y += arch/riscv/lib/
> +core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>
>  PHONY += vdso_install
>  vdso_install:
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 4da4886246a4..ae69e12d306a 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -129,3 +129,4 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
>  # CONFIG_RUNTIME_TESTING_MENU is not set
>  CONFIG_MEMTEST=y
>  # CONFIG_SYSFS_SYSCALL is not set
> +CONFIG_EFI=y
> diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
> new file mode 100644
> index 000000000000..62d7d5eafed8
> --- /dev/null
> +++ b/arch/riscv/include/asm/efi.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> + * Based on arch/arm64/include/asm/efi.h
> + */
> +#ifndef _ASM_EFI_H
> +#define _ASM_EFI_H
> +
> +#include <asm/io.h>
> +#include <asm/mmu_context.h>
> +#include <asm/ptrace.h>
> +#include <asm/tlbflush.h>
> +
> +#define VA_BITS_MIN 39
> +
> +/* on RISC-V, the FDT may be located anywhere in system RAM */
> +static inline unsigned long efi_get_max_fdt_addr(unsigned long dram_base)
> +{
> +       return ULONG_MAX;
> +}
> +
> +/* Load initrd at enough distance from DRAM start */
> +static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
> +                                                   unsigned long image_addr)
> +{
> +       return dram_base + SZ_256M;
> +}
> +
> +#define efi_bs_call(func, ...) efi_system_table()->boottime->func(__VA_ARGS__)
> +#define efi_rt_call(func, ...) efi_system_table()->runtime->func(__VA_ARGS__)
> +#define efi_is_native()                (true)
> +
> +#define efi_table_attr(inst, attr)     (inst->attr)
> +
> +#define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
> +
> +#define alloc_screen_info(x...)                (&screen_info)
> +extern char stext_offset[];
> +
> +static inline void free_screen_info(struct screen_info *si)
> +{
> +}
> +
> +#endif /* _ASM_EFI_H */
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 2a2b2b96a1dc..fcdc789d3f87 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -111,7 +111,7 @@ config EFI_GENERIC_STUB
>
>  config EFI_ARMSTUB_DTB_LOADER
>         bool "Enable the DTB loader"
> -       depends on EFI_GENERIC_STUB
> +       depends on EFI_GENERIC_STUB && !RISCV
>         default y
>         help
>           Select this config option to add support for the dtb= command
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 2b4e09bf987c..7d46b70b51f2 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -22,6 +22,8 @@ cflags-$(CONFIG_ARM64)                := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>  cflags-$(CONFIG_ARM)           := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>                                    -fno-builtin -fpic \
>                                    $(call cc-option,-mno-single-pic-base)
> +cflags-$(CONFIG_RISCV)         := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> +                                  -fpic
>
>  cflags-$(CONFIG_EFI_GENERIC_STUB)      += -I$(srctree)/scripts/dtc/libfdt
>
> @@ -57,6 +59,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)                += efi-stub.o fdt.o string.o \
>  lib-$(CONFIG_ARM)              += arm32-stub.o
>  lib-$(CONFIG_ARM64)            += arm64-stub.o
>  lib-$(CONFIG_X86)              += x86-stub.o
> +lib-$(CONFIG_RISCV)            += riscv-stub.o
>  CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  CFLAGS_arm64-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
>
> @@ -81,6 +84,10 @@ STUBCOPY_FLAGS-$(CONFIG_ARM64)       += --prefix-alloc-sections=.init \
>                                    --prefix-symbols=__efistub_
>  STUBCOPY_RELOC-$(CONFIG_ARM64) := R_AARCH64_ABS
>
> +STUBCOPY_FLAGS-$(CONFIG_RISCV) += --prefix-alloc-sections=.init \
> +                                  --prefix-symbols=__efistub_
> +STUBCOPY_RELOC-$(CONFIG_RISCV) := R_RISCV_HI20
> +
>  $(obj)/%.stub.o: $(obj)/%.o FORCE
>         $(call if_changed,stubcopy)
>
> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> new file mode 100644
> index 000000000000..69d13e0ebaea
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2013, 2014 Linaro Ltd;  <roy.franz@linaro.org>
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> + *
> + * This file implements the EFI boot stub for the RISC-V kernel.
> + * Adapted from ARM64 version at drivers/firmware/efi/libstub/arm64-stub.c.
> + */
> +
> +#include <linux/efi.h>
> +#include <linux/libfdt.h>
> +#include <linux/libfdt_env.h>
> +#include <asm/efi.h>
> +#include <asm/sections.h>
> +
> +#include "efistub.h"
> +/*
> + * RISCV requires the kernel image to placed TEXT_OFFSET bytes beyond a 2 MB
> + * aligned base for 64 bit and 4MB for 32 bit.
> + */
> +#ifdef CONFIG_64BIT
> +#define MIN_KIMG_ALIGN SZ_2M
> +#else
> +#define MIN_KIMG_ALIGN SZ_4M
> +#endif
> +
> +typedef __attribute__((noreturn)) void (*jump_kernel_func)(unsigned int,
> +                                                          unsigned long);
> +efi_status_t check_platform_features(void)
> +{
> +       return EFI_SUCCESS;
> +}
> +
> +static u32 get_boot_hartid_from_fdt(unsigned long fdt)
> +{
> +       int chosen_node, len;
> +       const fdt32_t *prop;
> +
> +       chosen_node = fdt_path_offset((void *)fdt, "/chosen");
> +       if (chosen_node < 0)
> +               return U32_MAX;
> +       prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid", &len);
> +       if (!prop || len != sizeof(u32))
> +               return U32_MAX;
> +
> +       return fdt32_to_cpu(*prop);
> +}
> +
> +/*
> + * Jump to real kernel here with following constraints.
> + * 1. MMU should be disabled.
> + * 2. a0 should contain hartid
> + * 3. a1 should DT address
> + */
> +void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned long fdt,
> +                                unsigned long fdt_size)
> +{
> +       unsigned long kernel_entry = entrypoint + (unsigned long)stext_offset;
> +       jump_kernel_func jump_kernel = (jump_kernel_func) kernel_entry;
> +       u32 hartid = get_boot_hartid_from_fdt(fdt);
> +
> +       if (hartid == U32_MAX)
> +               /* We can not use panic or BUG at this point */
> +               __asm__ __volatile__ ("ebreak");
> +       /* Disable MMU */
> +       csr_write(CSR_SATP, 0);
> +       jump_kernel(hartid, fdt);
> +}
> +
> +efi_status_t handle_kernel_image(unsigned long *image_addr,
> +                                unsigned long *image_size,
> +                                unsigned long *reserve_addr,
> +                                unsigned long *reserve_size,
> +                                unsigned long dram_base,
> +                                efi_loaded_image_t *image)
> +{
> +       efi_status_t status;
> +       unsigned long kernel_size, kernel_memsize = 0;
> +       unsigned long max_alloc_address;
> +
> +       if (image->image_base != _start)
> +               pr_efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
> +

I don't think you need this.

> +       kernel_size = _edata - _start;
> +       kernel_memsize = kernel_size + (_end - _edata);
> +       max_alloc_address = round_up(dram_base, MIN_KIMG_ALIGN) +
> +                           kernel_memsize;
> +

You said the kernel could be anywhere in memory, as long as it is
aligned correctly, right?
In that case, you don't need this, you can simply pass ULONG_MAX as
the max address.

> +       if (IS_ALIGNED((u64)_start, MIN_KIMG_ALIGN)) {
> +               /*
> +                * Just execute from wherever we were loaded by the
> +                * UEFI PE/COFF loader if the alignment is suitable.
> +                */
> +               *image_addr = (u64)_start;

Change these casts to (unsigned long), as reported by the robot.

So you no longer need the placement to be TEXT_OFFSET bytes past a
MIN_KIMG_ALIGN aligned boundary, right?

> +               *reserve_size = 0;
> +               return EFI_SUCCESS;
> +       }
> +       status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
> +                                           max_alloc_address, MIN_KIMG_ALIGN);
> +
> +       if (status != EFI_SUCCESS) {
> +               pr_efi_err("Failed to relocate kernel\n");
> +               *reserve_size = 0;
> +               return status;
> +       }
> +       *image_addr = *reserve_addr;
> +
> +       memcpy((void *)*image_addr, _start, kernel_size);
> +
> +       return EFI_SUCCESS;
> +}
> --
> 2.24.0
>
