Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC1D16F864
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 08:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgBZHOY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 02:14:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbgBZHOX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 26 Feb 2020 02:14:23 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FDD02467B
        for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2020 07:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582701262;
        bh=Z98ON1hUeAoPuZyzybLMb3+lvXHsoPQFWByBsOmMJps=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zqD6Lz1W0sTug8zTxHzCoVXuTCK/qlxn7R8HSRLul8XBW3MnIO7ZfhpYvOmRqB/tu
         3+XMvMi5lKrlsS6dbjH/N7w9jhfygSSTo5s1ybqAUpfW3qklPHsnzefRwr0IhBtnlQ
         ayXGdoC+e0i5zMNKMe9/BUYqyANXywv6K8urkZlk=
Received: by mail-wm1-f41.google.com with SMTP id z12so1723461wmi.4
        for <linux-efi@vger.kernel.org>; Tue, 25 Feb 2020 23:14:22 -0800 (PST)
X-Gm-Message-State: APjAAAVHcvwcPXpcJku5DLLzwEVU4oJxDiD18OgmnR30mY1W40gT0m7D
        hnO7k45pqAgYVnPqLTjZrk+gxFpOKgSfWoT6IZ3IcQ==
X-Google-Smtp-Source: APXvYqy38I+zeTvtcqHgC9uwnKQDf/w10sxjlQcggGr2HFUGpE7CI22mAK6Eep8G2S00zd7Wb1tHeepQReuvP9YpFMY=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr3972846wmk.68.1582701260448;
 Tue, 25 Feb 2020 23:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20200226011037.7179-1-atish.patra@wdc.com> <20200226011037.7179-5-atish.patra@wdc.com>
In-Reply-To: <20200226011037.7179-5-atish.patra@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Feb 2020 08:14:09 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8pQ3sATCc_XysQ0GUj_ahcQvjP6idgVHek8L7+ENdXKw@mail.gmail.com>
Message-ID: <CAKv+Gu8pQ3sATCc_XysQ0GUj_ahcQvjP6idgVHek8L7+ENdXKw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] RISC-V: Add PE/COFF header for EFI stub
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Alexander Graf <agraf@csgraf.de>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "Chang, Abner (HPS SW/FW Technologist)" <abner.chang@hpe.com>,
        "Schaefer, Daniel (DualStudy)" <daniel.schaefer@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 26 Feb 2020 at 02:10, Atish Patra <atish.patra@wdc.com> wrote:
>
> Linux kernel Image can appear as an EFI application With appropriate
> PE/COFF header fields in the beginning of the Image header. An EFI
> application loader can directly load a Linux kernel Image and an EFI
> stub residing in kernel can boot Linux kernel directly.
>
> Add the necessary PE/COFF header.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/Kbuild     |   1 -
>  arch/riscv/include/asm/sections.h |  13 ++++
>  arch/riscv/kernel/Makefile        |   4 ++
>  arch/riscv/kernel/efi-header.S    | 107 ++++++++++++++++++++++++++++++
>  arch/riscv/kernel/head.S          |  15 +++++
>  arch/riscv/kernel/image-vars.h    |  52 +++++++++++++++
>  arch/riscv/kernel/vmlinux.lds.S   |  27 ++++++--
>  7 files changed, 212 insertions(+), 7 deletions(-)
>  create mode 100644 arch/riscv/include/asm/sections.h
>  create mode 100644 arch/riscv/kernel/efi-header.S
>  create mode 100644 arch/riscv/kernel/image-vars.h
>
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 517394390106..ef797fe44934 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -24,7 +24,6 @@ generic-y += local64.h
>  generic-y += mm-arch-hooks.h
>  generic-y += percpu.h
>  generic-y += preempt.h
> -generic-y += sections.h
>  generic-y += serial.h
>  generic-y += shmparam.h
>  generic-y += topology.h
> diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
> new file mode 100644
> index 000000000000..3a9971b1210f
> --- /dev/null
> +++ b/arch/riscv/include/asm/sections.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> + */
> +#ifndef __ASM_SECTIONS_H
> +#define __ASM_SECTIONS_H
> +
> +#include <asm-generic/sections.h>
> +
> +extern char _start[];
> +extern char _start_kernel[];
> +
> +#endif /* __ASM_SECTIONS_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 9601ac907f70..471b1c73f77d 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -29,6 +29,10 @@ obj-y        += cacheinfo.o
>  obj-$(CONFIG_MMU) += vdso.o vdso/
>
>  obj-$(CONFIG_RISCV_M_MODE)     += clint.o
> +OBJCOPYFLAGS := --prefix-symbols=__efistub_
> +$(obj)/%.stub.o: $(obj)/%.o FORCE
> +       $(call if_changed,objcopy)
> +
>  obj-$(CONFIG_FPU)              += fpu.o
>  obj-$(CONFIG_SMP)              += smpboot.o
>  obj-$(CONFIG_SMP)              += smp.o
> diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
> new file mode 100644
> index 000000000000..af959e748d93
> --- /dev/null
> +++ b/arch/riscv/kernel/efi-header.S
> @@ -0,0 +1,107 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + * Adapted from arch/arm64/kernel/efi-header.S
> + */
> +
> +#include <linux/pe.h>
> +#include <linux/sizes.h>
> +
> +       .macro  __EFI_PE_HEADER
> +       .long   PE_MAGIC
> +coff_header:
> +       .short  IMAGE_FILE_MACHINE_RISCV64              // Machine
> +       .short  section_count                           // NumberOfSections
> +       .long   0                                       // TimeDateStamp
> +       .long   0                                       // PointerToSymbolTable
> +       .long   0                                       // NumberOfSymbols
> +       .short  section_table - optional_header         // SizeOfOptionalHeader
> +       .short  IMAGE_FILE_DEBUG_STRIPPED | \
> +               IMAGE_FILE_EXECUTABLE_IMAGE | \
> +               IMAGE_FILE_LINE_NUMS_STRIPPED           // Characteristics
> +
> +optional_header:
> +       .short  PE_OPT_MAGIC_PE32PLUS                   // PE32+ format
> +       .byte   0x02                                    // MajorLinkerVersion
> +       .byte   0x14                                    // MinorLinkerVersion
> +       .long   __text_end - efi_header_end             // SizeOfCode
> +       .long   _end - __text_end                       // SizeOfInitializedData
> +       .long   0                                       // SizeOfUninitializedData
> +       .long   __efistub_efi_entry - _start            // AddressOfEntryPoint
> +       .long   efi_header_end - _start                 // BaseOfCode
> +
> +extra_header_fields:
> +       .quad   0                                       // ImageBase
> +       .long   SZ_4K                                   // SectionAlignment
> +       .long   PECOFF_FILE_ALIGNMENT                   // FileAlignment
> +       .short  0                                       // MajorOperatingSystemVersion
> +       .short  0                                       // MinorOperatingSystemVersion
> +       .short  0                                       // MajorImageVersion
> +       .short  0                                       // MinorImageVersion

Put LINUX_EFISTUB_MAJOR_VERSION and LINUX_EFISTUB_MINOR_VERSION here

> +       .short  0                                       // MajorSubsystemVersion
> +       .short  0                                       // MinorSubsystemVersion
> +       .long   0                                       // Win32VersionValue
> +
> +       .long   _end - _start                           // SizeOfImage
> +
> +       // Everything before the kernel image is considered part of the header
> +       .long   efi_header_end - _start                 // SizeOfHeaders
> +       .long   0                                       // CheckSum
> +       .short  IMAGE_SUBSYSTEM_EFI_APPLICATION         // Subsystem
> +       .short  0                                       // DllCharacteristics
> +       .quad   0                                       // SizeOfStackReserve
> +       .quad   0                                       // SizeOfStackCommit
> +       .quad   0                                       // SizeOfHeapReserve
> +       .quad   0                                       // SizeOfHeapCommit
> +       .long   0                                       // LoaderFlags
> +       .long   (section_table - .) / 8                 // NumberOfRvaAndSizes
> +
> +       .quad   0                                       // ExportTable
> +       .quad   0                                       // ImportTable
> +       .quad   0                                       // ResourceTable
> +       .quad   0                                       // ExceptionTable
> +       .quad   0                                       // CertificationTable
> +       .quad   0                                       // BaseRelocationTable
> +
> +       // Section table
> +section_table:
> +       .ascii  ".text\0\0\0"
> +       .long   __text_end - efi_header_end             // VirtualSize
> +       .long   efi_header_end - _start                 // VirtualAddress
> +       .long   __text_end - efi_header_end             // SizeOfRawData
> +       .long   efi_header_end - _start                 // PointerToRawData
> +
> +       .long   0                                       // PointerToRelocations
> +       .long   0                                       // PointerToLineNumbers
> +       .short  0                                       // NumberOfRelocations
> +       .short  0                                       // NumberOfLineNumbers
> +       .long   IMAGE_SCN_CNT_CODE | \
> +               IMAGE_SCN_MEM_READ | \
> +               IMAGE_SCN_MEM_EXECUTE                   // Characteristics
> +
> +       .ascii  ".data\0\0\0"
> +       .long   __data_virt_size                        // VirtualSize
> +       .long   __text_end - _start                     // VirtualAddress
> +       .long   __data_raw_size                         // SizeOfRawData
> +       .long   __text_end - _start                     // PointerToRawData
> +
> +       .long   0                                       // PointerToRelocations
> +       .long   0                                       // PointerToLineNumbers
> +       .short  0                                       // NumberOfRelocations
> +       .short  0                                       // NumberOfLineNumbers
> +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA | \
> +               IMAGE_SCN_MEM_READ | \
> +               IMAGE_SCN_MEM_WRITE                     // Characteristics
> +
> +       .set    section_count, (. - section_table) / 40
> +

You dropped the debug header here, which is actually *very* useful if
you want to single step through the stub from DEBUG edk2 firmware.

> +       /*
> +        * EFI will load .text onwards at the 4k section alignment
> +        * described in the PE/COFF header. To ensure that instruction
> +        * sequences using an adrp and a :lo12: immediate will function

Surely, this is inaccurate for RISC-V?

> +        * correctly at this alignment, we must ensure that .text is
> +        * placed at a 4k boundary in the Image to begin with.
> +        */
> +       .align 12
> +efi_header_end:
> +       .endm
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index ac5b0e0a02f6..835dc76de285 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -13,6 +13,7 @@
>  #include <asm/csr.h>
>  #include <asm/hwcap.h>
>  #include <asm/image.h>
> +#include "efi-header.S"
>
>  __HEAD
>  ENTRY(_start)
> @@ -22,10 +23,17 @@ ENTRY(_start)
>          * Do not modify it without modifying the structure and all bootloaders
>          * that expects this header format!!
>          */
> +#ifdef CONFIG_EFI
> +       /*
> +        * This instruction decodes to "MZ" ASCII required by UEFI.
> +        */
> +       li s4,-13

What happens if you try to do plain boot on an EFI kernel? On ARM and
x86, we took care to use a 'MZ' opcode that behaves as a pseudo-NOP,
and jump to start_kernel right after, so if you boot the EFI kernel as
a normal kernel, it still works.

> +#else
>         /* jump to start kernel */
>         j _start_kernel
>         /* reserved */
>         .word 0
> +#endif
>         .balign 8
>  #if __riscv_xlen == 64
>         /* Image load offset(2MB) from start of RAM */
> @@ -43,7 +51,14 @@ ENTRY(_start)
>         .ascii RISCV_IMAGE_MAGIC
>         .balign 4
>         .ascii RISCV_IMAGE_MAGIC2
> +#ifdef CONFIG_EFI
> +       .word pe_head_start - _start
> +pe_head_start:
> +
> +       __EFI_PE_HEADER
> +#else
>         .word 0
> +#endif
>
>  .align 2
>  #ifdef CONFIG_MMU
> diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
> new file mode 100644
> index 000000000000..57abb85065e9
> --- /dev/null
> +++ b/arch/riscv/kernel/image-vars.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Linker script variables to be set after section resolution, as
> + * ld.lld does not like variables assigned before SECTIONS is processed.
> + * Based on arch/arm64/kerne/image-vars.h
> + */
> +#ifndef __RISCV_KERNEL_IMAGE_VARS_H
> +#define __RISCV_KERNEL_IMAGE_VARS_H
> +
> +#ifndef LINKER_SCRIPT
> +#error This file should only be included in vmlinux.lds.S
> +#endif
> +
> +#ifdef CONFIG_EFI
> +
> +__efistub_stext_offset = _start_kernel - _start;
> +
> +/*
> + * The EFI stub has its own symbol namespace prefixed by __efistub_, to
> + * isolate it from the kernel proper. The following symbols are legally
> + * accessed by the stub, so provide some aliases to make them accessible.
> + * Only include data symbols here, or text symbols of functions that are
> + * guaranteed to be safe when executed at another offset than they were
> + * linked at. The routines below are all implemented in assembler in a
> + * position independent manner
> + */
> +__efistub_memcmp               = memcmp;
> +__efistub_memchr               = memchr;
> +__efistub_memcpy               = memcpy;
> +__efistub_memmove              = memmove;
> +__efistub_memset               = memset;
> +__efistub_strlen               = strlen;
> +__efistub_strnlen              = strnlen;
> +__efistub_strcmp               = strcmp;
> +__efistub_strncmp              = strncmp;
> +__efistub_strrchr              = strrchr;
> +
> +#ifdef CONFIG_KASAN
> +__efistub___memcpy             = memcpy;
> +__efistub___memmove            = memmove;
> +__efistub___memset             = memset;
> +#endif
> +
> +__efistub__start               = _start;
> +__efistub__start_kernel                = _start_kernel;
> +__efistub__end                 = _end;
> +__efistub__edata               = _edata;
> +__efistub_screen_info          = screen_info;
> +
> +#endif
> +
> +#endif /* __RISCV_KERNEL_IMAGE_VARS_H */
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index b32640300d07..933b9e9a4b39 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -9,6 +9,7 @@
>  #include <asm/page.h>
>  #include <asm/cache.h>
>  #include <asm/thread_info.h>
> +#include "image-vars.h"
>
>  #include <linux/sizes.h>
>  OUTPUT_ARCH(riscv)
> @@ -16,6 +17,14 @@ ENTRY(_start)
>
>  jiffies = jiffies_64;
>
> +PECOFF_FILE_ALIGNMENT = 0x200;
> +#ifdef CONFIG_EFI
> +#define PECOFF_EDATA_PADDING   \
> +       .pecoff_edata_padding : { BYTE(0); . = ALIGN(PECOFF_FILE_ALIGNMENT); }
> +#else
> +#define PECOFF_EDATA_PADDING
> +#endif
> +
>  SECTIONS
>  {
>         /* Beginning of code and text segment */
> @@ -26,12 +35,15 @@ SECTIONS
>
>         __init_begin = .;
>         INIT_TEXT_SECTION(PAGE_SIZE)
> +
> +       /* Start of data section */
>         INIT_DATA_SECTION(16)
>         /* we have to discard exit text and such at runtime, not link time */
>         .exit.text :
>         {
>                 EXIT_TEXT
>         }
> +
>         .exit.data :
>         {
>                 EXIT_DATA
> @@ -54,7 +66,8 @@ SECTIONS
>                 _etext = .;
>         }
>
> -       /* Start of data section */
> +       __text_end = .;
> +
>         _sdata = .;
>         RO_DATA(L1_CACHE_BYTES)
>         .srodata : {
> @@ -65,19 +78,21 @@ SECTIONS
>         .sdata : {
>                 __global_pointer$ = . + 0x800;
>                 *(.sdata*)
> -               /* End of data section */
> -               _edata = .;
>                 *(.sbss*)
>         }
> -
> -       BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
> -
> +       PECOFF_EDATA_PADDING
> +       __data_raw_size = ABSOLUTE(. - __text_end);
> +       /* End of data section */
> +       _edata = .;
>         EXCEPTION_TABLE(0x10)
>
>         .rel.dyn : {
>                 *(.rel.dyn*)
>         }
>
> +       BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
> +       __data_virt_size = ABSOLUTE(. - __text_end);
> +
>         _end = .;
>
>         STABS_DEBUG
> --
> 2.24.0
>
