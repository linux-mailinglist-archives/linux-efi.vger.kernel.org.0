Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBDC6B4A1A
	for <lists+linux-efi@lfdr.de>; Fri, 10 Mar 2023 16:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjCJPSs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Mar 2023 10:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjCJPSa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Mar 2023 10:18:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F1413689E;
        Fri, 10 Mar 2023 07:09:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D679B822E7;
        Fri, 10 Mar 2023 15:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2193C433A0;
        Fri, 10 Mar 2023 15:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678460909;
        bh=vv9I9JquJfVRljrb369W+69qxVkCqMQOMuE/rhxiWLg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a94OiYDF4bZmNmxeiJiV3/hvxREI97rFXNbqSMkXnJai48xjzzrv0fMy9tXnHs3BQ
         +gMs+7695gLaqdjZoQLhEIPFv6kEbHoYFdHuJlBoaso6XSZPEU0kdZxpZi05CIrs2s
         dGBJ85P0luzhAebRbwdX0I8B3/qM/xbMW2wY0rSsFChrpV9PJDVkpi/J+ZEYalmM5i
         pYCbPzNGz8l63prZGOPcY1st7PCumK5QxD9d+bguFvHq6wXlqL/W3A6VkPVSLbFqS/
         De4WJHZbjY/sC4/ENy0pxJEJkFSCVwIRTcjJYNqT1Z/MhN8eRBZUzquTJPFu4zGpH+
         nVoIOiyIQ2K+g==
Received: by mail-lf1-f46.google.com with SMTP id i9so6997275lfc.6;
        Fri, 10 Mar 2023 07:08:28 -0800 (PST)
X-Gm-Message-State: AO0yUKWfEXqKoCH3JtpKMP8fwKXiVWouYDcx06XVP0yimclbaFqyTqE4
        bSI3Pk+btIWJ9jjZneoacaYR5LXOiATnL0NB0UI=
X-Google-Smtp-Source: AK7set+YfqF0zooMa4x7KbaneXNE3hJNT2u/bHRMB/Z0YCaMqgW4KVZ319xnRjh0721NyojFd+CP6bKL6MW6lGNTJxY=
X-Received: by 2002:a19:7517:0:b0:4dd:805b:5b75 with SMTP id
 y23-20020a197517000000b004dd805b5b75mr8103648lfe.7.1678460906846; Fri, 10 Mar
 2023 07:08:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <8945a9cd072754d8dda9961a5499fc7b0c2e8743.1671098103.git.baskov@ispras.ru>
In-Reply-To: <8945a9cd072754d8dda9961a5499fc7b0c2e8743.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Mar 2023 16:08:15 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFYqpKk0BpRaZZypyjjc5z38g53r+EPQwVCH+Y1W4bd+A@mail.gmail.com>
Message-ID: <CAMj1kXFYqpKk0BpRaZZypyjjc5z38g53r+EPQwVCH+Y1W4bd+A@mail.gmail.com>
Subject: Re: [PATCH v4 15/26] efi/x86: Support extracting kernel from libstub
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 15 Dec 2022 at 13:40, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Doing it that way allows setting up stricter memory attributes,
> simplifies boot code path and removes potential relocation
> of kernel image.
>
> Wire up required interfaces and minimally initialize zero page
> fields needed for it to function correctly.
>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

Some more comments - apologies for the multi stage approach ...

> ---
>  arch/x86/boot/compressed/head_32.S            |  50 ++++-
>  arch/x86/boot/compressed/head_64.S            |  58 ++++-
>  drivers/firmware/efi/Kconfig                  |   2 +
>  drivers/firmware/efi/libstub/Makefile         |   2 +-
>  .../firmware/efi/libstub/x86-extract-direct.c | 208 ++++++++++++++++++
>  drivers/firmware/efi/libstub/x86-stub.c       | 119 +---------
>  drivers/firmware/efi/libstub/x86-stub.h       |  14 ++
>  7 files changed, 338 insertions(+), 115 deletions(-)
>  create mode 100644 drivers/firmware/efi/libstub/x86-extract-direct.c
>  create mode 100644 drivers/firmware/efi/libstub/x86-stub.h
>
...
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 043ca31c114e..f50c2a84a754 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -58,6 +58,8 @@ config EFI_DXE_MEM_ATTRIBUTES
>           Use DXE services to check and alter memory protection
>           attributes during boot via EFISTUB to ensure that memory
>           ranges used by the kernel are writable and executable.
> +         This option also enables stricter memory attributes
> +         on compressed kernel PE image.

images

>
>  config EFI_PARAMS_FROM_FDT
>         bool
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index be8b8c6e8b40..99b81c95344c 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -88,7 +88,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)        += efi-stub.o string.o intrinsics.o systable.o \
>
>  lib-$(CONFIG_ARM)              += arm32-stub.o
>  lib-$(CONFIG_ARM64)            += arm64.o arm64-stub.o arm64-entry.o smbios.o
> -lib-$(CONFIG_X86)              += x86-stub.o
> +lib-$(CONFIG_X86)              += x86-stub.o x86-extract-direct.o
>  lib-$(CONFIG_RISCV)            += riscv.o riscv-stub.o
>  lib-$(CONFIG_LOONGARCH)                += loongarch.o loongarch-stub.o
>
> diff --git a/drivers/firmware/efi/libstub/x86-extract-direct.c b/drivers/firmware/efi/libstub/x86-extract-direct.c
> new file mode 100644
> index 000000000000..4ecbc4a9b3ed
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/x86-extract-direct.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/acpi.h>
> +#include <linux/efi.h>
> +#include <linux/elf.h>
> +#include <linux/stddef.h>
> +
> +#include <asm/efi.h>
> +#include <asm/e820/types.h>
> +#include <asm/desc.h>
> +#include <asm/boot.h>
> +#include <asm/bootparam_utils.h>
> +#include <asm/shared/extract.h>
> +#include <asm/shared/pgtable.h>
> +
> +#include "efistub.h"
> +#include "x86-stub.h"
> +
> +static efi_handle_t image_handle;
> +
> +static void do_puthex(unsigned long value)
> +{
> +       efi_printk("%08lx", value);
> +}
> +
> +static void do_putstr(const char *msg)
> +{
> +       efi_printk("%s", msg);
> +}
> +
> +static unsigned long do_map_range(unsigned long start,
> +                                 unsigned long end,
> +                                 unsigned int flags)
> +{
> +       efi_status_t status;
> +

Please drop this newline.

> +       unsigned long size = end - start;
> +
> +       if (flags & MAP_ALLOC) {
> +               unsigned long addr;
> +
> +               status = efi_low_alloc_above(size, CONFIG_PHYSICAL_ALIGN,
> +                                            &addr, start);
> +               if (status != EFI_SUCCESS) {
> +                       efi_err("Unable to allocate memory for uncompressed kernel");
> +                       efi_exit(image_handle, EFI_OUT_OF_RESOURCES);
> +               }
> +

OK, so this is the place where the chosen address for deompressing the
kernel is actually allocated and carved out in the EFI memory map.
Could you add a comment here so other folks won't be confused like I
was how this is put together?

> +               if (start != addr) {
> +                       efi_debug("Unable to allocate at given address"
> +                                 " (desired=0x%lx, actual=0x%lx)",
> +                                 (unsigned long)start, addr);
> +                       start = addr;
> +               }
> +       }
> +
> +       if ((flags & (MAP_PROTECT | MAP_ALLOC)) &&
> +           IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
> +               unsigned long attr = 0;
> +
> +               if (!(flags & MAP_EXEC))
> +                       attr |= EFI_MEMORY_XP;
> +
> +               if (!(flags & MAP_WRITE))
> +                       attr |= EFI_MEMORY_RO;
> +
> +               status = efi_adjust_memory_range_protection(start, size, attr);
> +               if (status != EFI_SUCCESS)
> +                       efi_err("Unable to protect memory range");
> +       }
> +
> +       return start;
> +}
> +
> +/*
> + * Trampoline takes 3 pages and can be loaded in first megabyte of memory
> + * with its end placed between 0 and 640k where BIOS might start.
> + * (see arch/x86/boot/compressed/pgtable_64.c)
> + */
> +
> +#ifdef CONFIG_64BIT
> +static efi_status_t prepare_trampoline(void)
> +{
> +       efi_status_t status;
> +
> +       status = efi_allocate_pages(TRAMPOLINE_32BIT_SIZE,
> +                                   (unsigned long *)&trampoline_32bit,
> +                                   TRAMPOLINE_32BIT_PLACEMENT_MAX);
> +
> +       if (status != EFI_SUCCESS)
> +               return status;
> +
> +       unsigned long trampoline_start = (unsigned long)trampoline_32bit;
> +

Please put all variable declarations at the start of the block

> +       memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
> +
> +       if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
> +               /* First page of trampoline is a top level page table */
> +               efi_adjust_memory_range_protection(trampoline_start,
> +                                                  PAGE_SIZE,
> +                                                  EFI_MEMORY_XP);
> +       }
> +
> +       /* Second page of trampoline is the code (with a padding) */
> +
> +       void *caddr = (void *)trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET;
> +

same here

> +       memcpy(caddr, trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
> +
> +       if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
> +               efi_adjust_memory_range_protection((unsigned long)caddr,
> +                                                  PAGE_SIZE,
> +                                                  EFI_MEMORY_RO);
> +
> +               /* And the last page of trampoline is the stack */
> +
> +               efi_adjust_memory_range_protection(trampoline_start + 2 * PAGE_SIZE,
> +                                                  PAGE_SIZE,
> +                                                  EFI_MEMORY_XP);
> +       }
> +
> +       return EFI_SUCCESS;
> +}
> +#else
> +static inline efi_status_t prepare_trampoline(void)
> +{
> +       return EFI_SUCCESS;
> +}
> +#endif
> +
> +static efi_status_t init_loader_data(efi_handle_t handle,
> +                                    struct boot_params *params,
> +                                    struct efi_boot_memmap **map)
> +{
> +       struct efi_info *efi = (void *)&params->efi_info;
> +       efi_status_t status;
> +
> +       status = efi_get_memory_map(map, false);
> +
> +       if (status != EFI_SUCCESS) {
> +               efi_err("Unable to get EFI memory map...\n");
> +               return status;
> +       }
> +
> +       const char *signature = efi_is_64bit() ? EFI64_LOADER_SIGNATURE
> +                                              : EFI32_LOADER_SIGNATURE;
> +

Move this to the start

> +       memcpy(&efi->efi_loader_signature, signature, sizeof(__u32));
> +
> +       efi->efi_memdesc_size = (*map)->desc_size;
> +       efi->efi_memdesc_version = (*map)->desc_ver;
> +       efi->efi_memmap_size = (*map)->map_size;
> +
> +       efi_set_u64_split((unsigned long)(*map)->map,
> +                         &efi->efi_memmap, &efi->efi_memmap_hi);
> +
> +       efi_set_u64_split((unsigned long)efi_system_table,
> +                         &efi->efi_systab, &efi->efi_systab_hi);
> +
> +       image_handle = handle;
> +
> +       return EFI_SUCCESS;
> +}
> +
> +static void free_loader_data(struct boot_params *params, struct efi_boot_memmap *map)
> +{
> +       struct efi_info *efi = (void *)&params->efi_info;
> +
> +       efi_bs_call(free_pool, map);
> +
> +       efi->efi_memdesc_size = 0;
> +       efi->efi_memdesc_version = 0;
> +       efi->efi_memmap_size = 0;
> +       efi_set_u64_split(0, &efi->efi_memmap, &efi->efi_memmap_hi);
> +}
> +
> +extern unsigned char input_data[];
> +extern unsigned int input_len, output_len;
> +
> +unsigned long extract_kernel_direct(efi_handle_t handle, struct boot_params *params)
> +{
> +
> +       void *res;
> +       efi_status_t status;
> +       struct efi_extract_callbacks cb = { 0 };
> +
> +       status = prepare_trampoline();
> +
> +       if (status != EFI_SUCCESS)
> +               return 0;
> +
> +       /* Prepare environment for do_extract_kernel() call */
> +       struct efi_boot_memmap *map = NULL;

Move this to the start.

> +       status = init_loader_data(handle, params, &map);
> +
> +       if (status != EFI_SUCCESS)
> +               return 0;
> +
> +       cb.puthex = do_puthex;
> +       cb.putstr = do_putstr;
> +       cb.map_range = do_map_range;
> +
> +       res = efi_extract_kernel(params, &cb, input_data, input_len, output_len);
> +
> +       free_loader_data(params, map);
> +
> +       return (unsigned long)res;
> +}
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 7fb1eff88a18..1d1ab1911fd3 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -17,6 +17,7 @@
>  #include <asm/boot.h>
>
>  #include "efistub.h"
> +#include "x86-stub.h"
>
>  /* Maximum physical address for 64-bit kernel with 4-level paging */
>  #define MAXMEM_X86_64_4LEVEL (1ull << 46)
> @@ -24,7 +25,7 @@
>  const efi_system_table_t *efi_system_table;
>  const efi_dxe_services_table_t *efi_dxe_table;
>  u32 image_offset __section(".data");
> -static efi_loaded_image_t *image = NULL;
> +static efi_loaded_image_t *image __section(".data");
>
>  static efi_status_t
>  preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
> @@ -212,55 +213,9 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
>         }
>  }
>
> -/*
> - * Trampoline takes 2 pages and can be loaded in first megabyte of memory
> - * with its end placed between 128k and 640k where BIOS might start.
> - * (see arch/x86/boot/compressed/pgtable_64.c)
> - *
> - * We cannot find exact trampoline placement since memory map
> - * can be modified by UEFI, and it can alter the computed address.
> - */
> -
> -#define TRAMPOLINE_PLACEMENT_BASE ((128 - 8)*1024)
> -#define TRAMPOLINE_PLACEMENT_SIZE (640*1024 - (128 - 8)*1024)
> -
> -void startup_32(struct boot_params *boot_params);
> -
> -static void
> -setup_memory_protection(unsigned long image_base, unsigned long image_size)
> -{
> -       /*
> -        * Allow execution of possible trampoline used
> -        * for switching between 4- and 5-level page tables
> -        * and relocated kernel image.
> -        */
> -
> -       efi_adjust_memory_range_protection(TRAMPOLINE_PLACEMENT_BASE,
> -                                          TRAMPOLINE_PLACEMENT_SIZE, 0);
> -
> -#ifdef CONFIG_64BIT
> -       if (image_base != (unsigned long)startup_32)
> -               efi_adjust_memory_range_protection(image_base, image_size, 0);
> -#else
> -       /*
> -        * Clear protection flags on a whole range of possible
> -        * addresses used for KASLR. We don't need to do that
> -        * on x86_64, since KASLR/extraction is performed after
> -        * dedicated identity page tables are built and we only
> -        * need to remove possible protection on relocated image
> -        * itself disregarding further relocations.
> -        */
> -       efi_adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
> -                                          KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR,
> -                                          0);
> -#endif
> -}
> -
>  static const efi_char16_t apple[] = L"Apple";
>
> -static void setup_quirks(struct boot_params *boot_params,
> -                        unsigned long image_base,
> -                        unsigned long image_size)
> +static void setup_quirks(struct boot_params *boot_params)
>  {
>         efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
>                 efi_table_attr(efi_system_table, fw_vendor);
> @@ -269,9 +224,6 @@ static void setup_quirks(struct boot_params *boot_params,
>                 if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
>                         retrieve_apple_device_properties(boot_params);
>         }
> -
> -       if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES))
> -               setup_memory_protection(image_base, image_size);
>  }
>
>  /*
> @@ -384,7 +336,7 @@ static void setup_graphics(struct boot_params *boot_params)
>  }
>
>
> -static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
> +void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
>  {
>         efi_bs_call(exit, handle, status, 0, NULL);
>         for(;;)
> @@ -707,8 +659,7 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
>  }
>
>  /*
> - * On success, we return the address of startup_32, which has potentially been
> - * relocated by efi_relocate_kernel.
> + * On success, we return extracted kernel entry point.
>   * On failure, we exit to the firmware via efi_exit instead of returning.
>   */
>  asmlinkage unsigned long efi_main(efi_handle_t handle,
> @@ -733,60 +684,6 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
>                 efi_dxe_table = NULL;
>         }
>
> -       /*
> -        * If the kernel isn't already loaded at a suitable address,
> -        * relocate it.
> -        *
> -        * It must be loaded above LOAD_PHYSICAL_ADDR.
> -        *
> -        * The maximum address for 64-bit is 1 << 46 for 4-level paging. This
> -        * is defined as the macro MAXMEM, but unfortunately that is not a
> -        * compile-time constant if 5-level paging is configured, so we instead
> -        * define our own macro for use here.
> -        *
> -        * For 32-bit, the maximum address is complicated to figure out, for
> -        * now use KERNEL_IMAGE_SIZE, which will be 512MiB, the same as what
> -        * KASLR uses.
> -        *
> -        * Also relocate it if image_offset is zero, i.e. the kernel wasn't
> -        * loaded by LoadImage, but rather by a bootloader that called the
> -        * handover entry. The reason we must always relocate in this case is
> -        * to handle the case of systemd-boot booting a unified kernel image,
> -        * which is a PE executable that contains the bzImage and an initrd as
> -        * COFF sections. The initrd section is placed after the bzImage
> -        * without ensuring that there are at least init_size bytes available
> -        * for the bzImage, and thus the compressed kernel's startup code may
> -        * overwrite the initrd unless it is moved out of the way.
> -        */
> -
> -       buffer_start = ALIGN(bzimage_addr - image_offset,
> -                            hdr->kernel_alignment);
> -       buffer_end = buffer_start + hdr->init_size;
> -
> -       if ((buffer_start < LOAD_PHYSICAL_ADDR)                              ||
> -           (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
> -           (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
> -           (image_offset == 0)) {
> -               extern char _bss[];
> -
> -               status = efi_relocate_kernel(&bzimage_addr,
> -                                            (unsigned long)_bss - bzimage_addr,
> -                                            hdr->init_size,
> -                                            hdr->pref_address,
> -                                            hdr->kernel_alignment,
> -                                            LOAD_PHYSICAL_ADDR);
> -               if (status != EFI_SUCCESS) {
> -                       efi_err("efi_relocate_kernel() failed!\n");
> -                       goto fail;
> -               }
> -               /*
> -                * Now that we've copied the kernel elsewhere, we no longer
> -                * have a set up block before startup_32(), so reset image_offset
> -                * to zero in case it was set earlier.
> -                */
> -               image_offset = 0;
> -       }
> -
>  #ifdef CONFIG_CMDLINE_BOOL
>         status = efi_parse_options(CONFIG_CMDLINE);
>         if (status != EFI_SUCCESS) {
> @@ -843,7 +740,11 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
>
>         setup_efi_pci(boot_params);
>
> -       setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
> +       setup_quirks(boot_params);
> +
> +       bzimage_addr = extract_kernel_direct(handle, boot_params);
> +       if (!bzimage_addr)
> +               goto fail;
>
>         status = exit_boot(boot_params, handle);
>         if (status != EFI_SUCCESS) {
> diff --git a/drivers/firmware/efi/libstub/x86-stub.h b/drivers/firmware/efi/libstub/x86-stub.h
> new file mode 100644
> index 000000000000..baecc7c6e602
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/x86-stub.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _DRIVERS_FIRMWARE_EFI_X86STUB_H
> +#define _DRIVERS_FIRMWARE_EFI_X86STUB_H
> +
> +#include <linux/efi.h>
> +
> +#include <asm/bootparam.h>
> +
> +void __noreturn efi_exit(efi_handle_t handle, efi_status_t status);
> +unsigned long extract_kernel_direct(efi_handle_t handle, struct boot_params *boot_params);
> +void startup_32(struct boot_params *boot_params);
> +
> +#endif
> --
> 2.37.4
>
