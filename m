Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B4524370B
	for <lists+linux-efi@lfdr.de>; Thu, 13 Aug 2020 11:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgHMJAu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Aug 2020 05:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMJAt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Aug 2020 05:00:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A4FC061383
        for <linux-efi@vger.kernel.org>; Thu, 13 Aug 2020 02:00:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p14so4035276wmg.1
        for <linux-efi@vger.kernel.org>; Thu, 13 Aug 2020 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ily92RBIA0gCYaaItOKfOr0UCPH0JTHy6ebueRFMAbI=;
        b=QeBKdlyI7zNq6ihcq1cAaaj1AdxeHWefsJ5YIKyu+WwyE0MWINJDOPfqMSn2arET8R
         p7pNw44HU+Y1yNwa86vVtPDFBZgm3FPotU37Igcj5i5FkKZpOoGyLDylOXk1ypmeljel
         6eVS+8g2VffyTbJn3WaVAe4i1/NEvAWq6BOZ2mlElFe2pgF4n9Cy3waJR/JkvtWW3iYr
         K3J8SaCRX503vZnFvoqy9Y3JDSJtrWe+5N2yhRQZdswUZeGzenP010VpcB/fXLrhAwXU
         BY1HDdc/ZAfKNkVepcLJ0KQOT3BhdbV/XRP3sqMxnS0IjsP9VH1iMSLnkprXFD4kXCDw
         wO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ily92RBIA0gCYaaItOKfOr0UCPH0JTHy6ebueRFMAbI=;
        b=aKQGOamLEEL5aFHmFapNqvT4IVP4Cos1ArXO4Au5o3cRCiAZSdvSWMSCzCHD5MLzaA
         UI8rjsj5BeV0jEE7rhrSdUb2GObE7uCQ/Zh74OD6eKf4mkDIk67I2zVXctVRIRueR4B3
         3u9yRjmJlS1FLbg8TqMTK+zh2hz2PW33UwepFgpdPadnAw1wRmPLSj9r4lVzv4ak+gA9
         izr6qGSz1KLNBLWFk/XmPRvdCNBpEoe2LADJrTrhLXZM2Rdq1UYeu85wQ7dwDWp4AJfo
         qFA8aZ+TWpJZKWUGx2wB6meFV0QrS455FeqqX9wHLNcg6jICpWQq8TvfavFvi78AyJlW
         B+WA==
X-Gm-Message-State: AOAM533a97kBBGQ2OsvZ377pRfuw2Uboy04652iIjDbt9NieOpYG/LPh
        rvy2GyAlS45t1cTvuFakafaGijdissGzCUJcrfGs7w==
X-Google-Smtp-Source: ABdhPJzxdYnxCVkygWdQLurAleYTH1SAyOYzaK+QCZmvkBu1KX7DzxQepkzg9zoYl4Go78+QMG5nFFvpys1gytMMeRw=
X-Received: by 2002:a1c:9c91:: with SMTP id f139mr3580422wme.134.1597309247442;
 Thu, 13 Aug 2020 02:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200812234758.3563-1-atish.patra@wdc.com> <20200812234758.3563-6-atish.patra@wdc.com>
In-Reply-To: <20200812234758.3563-6-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 13 Aug 2020 14:30:35 +0530
Message-ID: <CAAhSdy3R2Q2soNZcXMp_3uUjKPmFV_W_MX+gq-syUnJppz8YaA@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] RISC-V: Add PE/COFF header for EFI stub
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        fwts-devel@lists.ubuntu.com, Mao Han <han_mao@c-sky.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Price <steven.price@arm.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Daniel Schaefer <daniel.schaefer@hpe.com>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 13, 2020 at 5:18 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Linux kernel Image can appear as an EFI application With appropriate
> PE/COFF header fields in the beginning of the Image header. An EFI
> application loader can directly load a Linux kernel Image and an EFI
> stub residing in kernel can boot Linux kernel directly.
>
> Add the necessary PE/COFF header.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Link: https://lore.kernel.org/r/20200421033336.9663-3-atish.patra@wdc.com
> [ardb: - use C prefix for c.li to ensure the expected opcode is emitted
>        - align all image sections according to PE/COFF section alignment ]
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/riscv/include/asm/sections.h |  13 ++++
>  arch/riscv/kernel/Makefile        |   4 ++
>  arch/riscv/kernel/efi-header.S    | 104 ++++++++++++++++++++++++++++++
>  arch/riscv/kernel/head.S          |  16 +++++
>  arch/riscv/kernel/image-vars.h    |  51 +++++++++++++++
>  arch/riscv/kernel/vmlinux.lds.S   |  22 ++++++-
>  6 files changed, 208 insertions(+), 2 deletions(-)
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
> index a5287ab9f7f2..eabec4dce50b 100644
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
> index 000000000000..822b4c9ff2bb
> --- /dev/null
> +++ b/arch/riscv/kernel/efi-header.S
> @@ -0,0 +1,104 @@
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
> +#ifdef CONFIG_64BIT
> +       .short  IMAGE_FILE_MACHINE_RISCV64              // Machine
> +#else
> +       .short  IMAGE_FILE_MACHINE_RISCV32              // Machine
> +#endif
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
> +       .long   __pecoff_text_end - efi_header_end      // SizeOfCode
> +       .long   __pecoff_data_virt_size                 // SizeOfInitializedData
> +       .long   0                                       // SizeOfUninitializedData
> +       .long   __efistub_efi_pe_entry - _start         // AddressOfEntryPoint
> +       .long   efi_header_end - _start                 // BaseOfCode
> +
> +extra_header_fields:
> +       .quad   0                                       // ImageBase
> +       .long   PECOFF_SECTION_ALIGNMENT                // SectionAlignment
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
> +       .long   __pecoff_text_end - efi_header_end      // VirtualSize
> +       .long   efi_header_end - _start                 // VirtualAddress
> +       .long   __pecoff_text_end - efi_header_end      // SizeOfRawData
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
> +       .long   __pecoff_data_virt_size                 // VirtualSize
> +       .long   __pecoff_text_end - _start              // VirtualAddress
> +       .long   __pecoff_data_raw_size                  // SizeOfRawData
> +       .long   __pecoff_text_end - _start              // PointerToRawData
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
> +       .balign 0x1000
> +efi_header_end:
> +       .endm
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index a2f0cb3ca0a6..f5583473f41c 100644
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
> +       c.li s4,-13
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
> index 000000000000..8c212efb37a6
> --- /dev/null
> +++ b/arch/riscv/kernel/image-vars.h
> @@ -0,0 +1,51 @@
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
> index f3586e31ed1e..6dcf790282dd 100644
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
> @@ -17,6 +18,9 @@ ENTRY(_start)
>
>  jiffies = jiffies_64;
>
> +PECOFF_SECTION_ALIGNMENT = 0x1000;
> +PECOFF_FILE_ALIGNMENT = 0x200;
> +
>  SECTIONS
>  {
>         /* Beginning of code and text segment */
> @@ -76,6 +80,10 @@ SECTIONS
>
>         EXCEPTION_TABLE(0x10)
>
> +#ifdef CONFIG_EFI
> +       . = ALIGN(PECOFF_SECTION_ALIGNMENT);
> +       __pecoff_text_end = .;
> +#endif
>         . = ALIGN(SECTION_ALIGN);
>         _data = .;
>
> @@ -83,16 +91,26 @@ SECTIONS
>         .sdata : {
>                 __global_pointer$ = . + 0x800;
>                 *(.sdata*)
> -               /* End of data section */
> -               _edata = .;
>         }
>
> +#ifdef CONFIG_EFI
> +       .pecoff_edata_padding : { BYTE(0); . = ALIGN(PECOFF_FILE_ALIGNMENT); }
> +       __pecoff_data_raw_size = ABSOLUTE(. - __pecoff_text_end);
> +#endif
> +
> +       /* End of data section */
> +       _edata = .;
> +
>         BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
>
>         .rel.dyn : {
>                 *(.rel.dyn*)
>         }
>
> +#ifdef CONFIG_EFI
> +       . = ALIGN(PECOFF_SECTION_ALIGNMENT);
> +       __pecoff_data_virt_size = ABSOLUTE(. - __pecoff_text_end);
> +#endif
>         _end = .;
>
>         STABS_DEBUG
> --
> 2.24.0
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
