Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8FA1B2E96
	for <lists+linux-efi@lfdr.de>; Tue, 21 Apr 2020 19:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgDURvw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Apr 2020 13:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgDURvv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 21 Apr 2020 13:51:51 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9B5C206F4;
        Tue, 21 Apr 2020 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587491510;
        bh=CPFz1MpneVXzubun2jadVMmarIWPJetbLkojFtlMX64=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xxuHz6VS3R6EzWzz9hQj09zvH+zDr2UnKISz7O9YMsQj3NbK5PfL4i06cxS2sv6o8
         R0TOOyoFy342iEagIR3Kyqf8aSS1kZbkzE7hWPMK+tUtYLVLXv+ToCdrTSqYFQQGOy
         kRuuDDkXQ9LdZQ4aoiQtFUDrJx5AvGNXTGGKi3cc=
Received: by mail-io1-f51.google.com with SMTP id p10so6374761ioh.7;
        Tue, 21 Apr 2020 10:51:50 -0700 (PDT)
X-Gm-Message-State: AGi0PuYVWivivVowlto04TECThYqhHHzVp/oqIyT3smqL7Hpa/Jany+4
        khkCWSJA08F2KMkTv9Ian1+fv1lwmTbrY6nGbSg=
X-Google-Smtp-Source: APiQypLWW0xDTDkUEniuzuWAaPm/4CZpHke36iID+T5+UdHxo7VW5Iu/32lGsidSvPgavTyXAwyvn95PnknbHLk6pYY=
X-Received: by 2002:a5d:8045:: with SMTP id b5mr14106578ior.16.1587491510019;
 Tue, 21 Apr 2020 10:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200421033336.9663-1-atish.patra@wdc.com> <20200421033336.9663-3-atish.patra@wdc.com>
In-Reply-To: <20200421033336.9663-3-atish.patra@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Apr 2020 19:51:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGX5hNLs1qKvhD=+uX_KOuOnb+EP9UXPbBnaDu83eB81w@mail.gmail.com>
Message-ID: <CAMj1kXGX5hNLs1qKvhD=+uX_KOuOnb+EP9UXPbBnaDu83eB81w@mail.gmail.com>
Subject: Re: [v4 PATCH 2/3] RISC-V: Add PE/COFF header for EFI stub
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Atish,

One thing I forgot to check, below:

On Tue, 21 Apr 2020 at 05:34, Atish Patra <atish.patra@wdc.com> wrote:
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
>  arch/riscv/include/asm/sections.h | 13 ++++
>  arch/riscv/kernel/Makefile        |  4 ++
>  arch/riscv/kernel/efi-header.S    | 99 +++++++++++++++++++++++++++++++
>  arch/riscv/kernel/head.S          | 16 +++++
>  arch/riscv/kernel/image-vars.h    | 53 +++++++++++++++++
>  arch/riscv/kernel/vmlinux.lds.S   | 20 ++++++-
>  6 files changed, 203 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/include/asm/sections.h
>  create mode 100644 arch/riscv/kernel/efi-header.S
>  create mode 100644 arch/riscv/kernel/image-vars.h
>
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
> index 86c83081044f..86ca755f8a9f 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -32,6 +32,10 @@ obj-y        += patch.o
>  obj-$(CONFIG_MMU) += vdso.o vdso/
>
>  obj-$(CONFIG_RISCV_M_MODE)     += clint.o traps_misaligned.o
> +OBJCOPYFLAGS := --prefix-symbols=__efistub_
> +$(obj)/%.stub.o: $(obj)/%.o FORCE
> +       $(call if_changed,objcopy)
> +
>  obj-$(CONFIG_FPU)              += fpu.o
>  obj-$(CONFIG_SMP)              += smpboot.o
>  obj-$(CONFIG_SMP)              += smp.o
> diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
> new file mode 100644
> index 000000000000..69dde8268527
> --- /dev/null
> +++ b/arch/riscv/kernel/efi-header.S
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
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

Here you set the section alignment to 4 KB ...

> +       .long   PECOFF_FILE_ALIGNMENT                   // FileAlignment
> +       .short  0                                       // MajorOperatingSystemVersion
> +       .short  0                                       // MinorOperatingSystemVersion
> +       .short  LINUX_EFISTUB_MAJOR_VERSION             // MajorImageVersion
> +       .short  LINUX_EFISTUB_MINOR_VERSION             // MinorImageVersion
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

... and here you define the address of the first section, which should
be aligned to section alignment of 4 KB

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
> +efi_header_end:

... so you will need to put an .p2align 12 here to ensure that
efi_header_end appears at 4 KB boundary.

Similarly, you will have to align the symbols __text_end and
__data_virt_size in the linker scripts to make them round multiples of
4 KB.



> +       .endm
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 98a406474e7d..ddd613dac9d6 100644
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
> @@ -22,10 +23,18 @@ ENTRY(_start)
>          * Do not modify it without modifying the structure and all bootloaders
>          * that expects this header format!!
>          */
> +#ifdef CONFIG_EFI
> +       /*
> +        * This instruction decodes to "MZ" ASCII required by UEFI.
> +        */
> +       li s4,-13
> +       j _start_kernel
> +#else
>         /* jump to start kernel */
>         j _start_kernel
>         /* reserved */
>         .word 0
> +#endif
>         .balign 8
>  #if __riscv_xlen == 64
>         /* Image load offset(2MB) from start of RAM */
> @@ -43,7 +52,14 @@ ENTRY(_start)
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
> index 000000000000..bd8b764f0ad9
> --- /dev/null
> +++ b/arch/riscv/kernel/image-vars.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
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
> index 0339b6bbe11a..20ebf7e8c215 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -10,6 +10,7 @@
>  #include <asm/cache.h>
>  #include <asm/thread_info.h>
>  #include <asm/set_memory.h>
> +#include "image-vars.h"
>
>  #include <linux/sizes.h>
>  OUTPUT_ARCH(riscv)
> @@ -17,6 +18,14 @@ ENTRY(_start)
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
> @@ -62,6 +71,8 @@ SECTIONS
>                 _etext = .;
>         }
>
> +       __text_end = .;
> +
>         /* Start of data section */
>         _sdata = .;
>         RO_DATA(SECTION_ALIGN)
> @@ -78,9 +89,12 @@ SECTIONS
>         .sdata : {
>                 __global_pointer$ = . + 0x800;
>                 *(.sdata*)
> -               /* End of data section */
> -               _edata = .;
>         }
> +       PECOFF_EDATA_PADDING
> +       __data_raw_size = ABSOLUTE(. - __text_end);
> +
> +       /* End of data section */
> +       _edata = .;
>
>         BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
>
> @@ -88,6 +102,8 @@ SECTIONS
>                 *(.rel.dyn*)
>         }
>
> +       __data_virt_size = ABSOLUTE(. - __text_end);
> +
>         _end = .;
>
>         STABS_DEBUG
> --
> 2.24.0
>
