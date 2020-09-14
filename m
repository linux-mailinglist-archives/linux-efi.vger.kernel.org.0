Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363842694E9
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 20:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgINSct (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 14:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgINSch (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 14:32:37 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8558221D7E;
        Mon, 14 Sep 2020 18:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600108355;
        bh=+yvukRg7EzNH2haF4QwVMJONmZtj4liSgeyRP0PGKWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mCcdtJGOclc/eZq3fo5/vtGjTgv8x1GMWj/AFrOZz/v/lf5perhrR8hrhfPS7uFyP
         M/hXlz7KnzN7u1JzIlrOVzUys3Es9ms5wh7Ic2pDThfmpirQcn/PD0JbWGRMFsH9JN
         hQMezUv/Qsq/duM5aiZrCXznBT+9dZDVeE7XwsoE=
Received: by mail-oo1-f54.google.com with SMTP id 4so103753ooh.11;
        Mon, 14 Sep 2020 11:32:35 -0700 (PDT)
X-Gm-Message-State: AOAM532wtnfeajdXvdegvpEYMuricEgzMH64NVTEIJSU0u3UVpRqTB/S
        HjDE3TFPpx2Y4bLrSN5A4TQ5HhrDYzwN5p0Hxz0=
X-Google-Smtp-Source: ABdhPJyG/PePd6j9W+RuHl2CGNX0GWKReIwvTzvgNJc0TBjIhvuT19o7oVCgn9iZYzW6x6OzZHY/eJhKwEEEA0a6Kgg=
X-Received: by 2002:a4a:c541:: with SMTP id j1mr11175843ooq.13.1600108354689;
 Mon, 14 Sep 2020 11:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200828172036.8056-1-atish.patra@wdc.com> <20200828172036.8056-6-atish.patra@wdc.com>
 <CAMj1kXH82MGDLNkyWae=wqNxZY7ZMvrDU3gNAOSF+m9YFGe7aw@mail.gmail.com> <CAOnJCUJhxLVNi74F7n6+ZaqkL36urh+4oybozmK4ypgD0-=Cxw@mail.gmail.com>
In-Reply-To: <CAOnJCUJhxLVNi74F7n6+ZaqkL36urh+4oybozmK4ypgD0-=Cxw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 14 Sep 2020 21:32:23 +0300
X-Gmail-Original-Message-ID: <CAMj1kXE1qi1zKZiXpEB+z5bQORRKz4ampNAVK2XiSawgq5zc+g@mail.gmail.com>
Message-ID: <CAMj1kXE1qi1zKZiXpEB+z5bQORRKz4ampNAVK2XiSawgq5zc+g@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] RISC-V: Add PE/COFF header for EFI stub
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 12 Sep 2020 at 05:04, Atish Patra <atishp@atishpatra.org> wrote:
>
> On Fri, Sep 11, 2020 at 6:09 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 28 Aug 2020 at 20:20, Atish Patra <atish.patra@wdc.com> wrote:
> > >
> > > Linux kernel Image can appear as an EFI application With appropriate
> > > PE/COFF header fields in the beginning of the Image header. An EFI
> > > application loader can directly load a Linux kernel Image and an EFI
> > > stub residing in kernel can boot Linux kernel directly.
> > >
> > > Add the necessary PE/COFF header.
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > Link: https://lore.kernel.org/r/20200421033336.9663-3-atish.patra@wdc.com
> > > [ardb: - use C prefix for c.li to ensure the expected opcode is emitted
> > >        - align all image sections according to PE/COFF section alignment ]
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > Reviewed-by: Anup Patel <anup@brainfault.org>
> >
> > Since you need to respin this anyway, one comment below on a thing
> > that I spotted while revisiting these patches.
> >
> > > ---
> > >  arch/riscv/include/asm/sections.h |  13 ++++
> > >  arch/riscv/kernel/Makefile        |   4 ++
> > >  arch/riscv/kernel/efi-header.S    | 104 ++++++++++++++++++++++++++++++
> > >  arch/riscv/kernel/head.S          |  16 +++++
> > >  arch/riscv/kernel/image-vars.h    |  51 +++++++++++++++
> > >  arch/riscv/kernel/vmlinux.lds.S   |  22 ++++++-
> > >  6 files changed, 208 insertions(+), 2 deletions(-)
> > >  create mode 100644 arch/riscv/include/asm/sections.h
> > >  create mode 100644 arch/riscv/kernel/efi-header.S
> > >  create mode 100644 arch/riscv/kernel/image-vars.h
> > >
> > > diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
> > > new file mode 100644
> > > index 000000000000..3a9971b1210f
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/sections.h
> > > @@ -0,0 +1,13 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> > > + */
> > > +#ifndef __ASM_SECTIONS_H
> > > +#define __ASM_SECTIONS_H
> > > +
> > > +#include <asm-generic/sections.h>
> > > +
> > > +extern char _start[];
> > > +extern char _start_kernel[];
> > > +
> > > +#endif /* __ASM_SECTIONS_H */
> > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > index dc93710f0b2f..41e3895a3192 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -31,6 +31,10 @@ obj-y        += cacheinfo.o
> > >  obj-y  += patch.o
> > >  obj-$(CONFIG_MMU) += vdso.o vdso/
> > >
> > > +OBJCOPYFLAGS := --prefix-symbols=__efistub_
> > > +$(obj)/%.stub.o: $(obj)/%.o FORCE
> > > +       $(call if_changed,objcopy)
> > > +
> > >  obj-$(CONFIG_RISCV_M_MODE)     += traps_misaligned.o
> > >  obj-$(CONFIG_FPU)              += fpu.o
> > >  obj-$(CONFIG_SMP)              += smpboot.o
> > > diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
> > > new file mode 100644
> > > index 000000000000..822b4c9ff2bb
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/efi-header.S
> > > @@ -0,0 +1,104 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> > > + * Adapted from arch/arm64/kernel/efi-header.S
> > > + */
> > > +
> > > +#include <linux/pe.h>
> > > +#include <linux/sizes.h>
> > > +
> > > +       .macro  __EFI_PE_HEADER
> > > +       .long   PE_MAGIC
> > > +coff_header:
> > > +#ifdef CONFIG_64BIT
> > > +       .short  IMAGE_FILE_MACHINE_RISCV64              // Machine
> > > +#else
> > > +       .short  IMAGE_FILE_MACHINE_RISCV32              // Machine
> > > +#endif
> > > +       .short  section_count                           // NumberOfSections
> > > +       .long   0                                       // TimeDateStamp
> > > +       .long   0                                       // PointerToSymbolTable
> > > +       .long   0                                       // NumberOfSymbols
> > > +       .short  section_table - optional_header         // SizeOfOptionalHeader
> > > +       .short  IMAGE_FILE_DEBUG_STRIPPED | \
> > > +               IMAGE_FILE_EXECUTABLE_IMAGE | \
> > > +               IMAGE_FILE_LINE_NUMS_STRIPPED           // Characteristics
> > > +
> > > +optional_header:
> > > +       .short  PE_OPT_MAGIC_PE32PLUS                   // PE32+ format
> >
> > Are you sure both riscv32 and riscv64 use PE32+? IIUC, 32-bit
> > architectures use PE32 not PE32+ (but I could be wrong)
> >
>
> Ahh yes. You are correct. Thanks for noticing it.
> I just followed the U-Boot implementation [1]. I will update this in
> the next revision and update the U-Boot code as well.
>
> As per the specification, we also need to add a BaseOfData[2] entry for RV32.
> Does any of the efi application loader actually use BaseOfData or can
> we set it to zero for RV32 ?
>

Just do whatever ARM and 32-bit x86 do.


> [1] https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/-/blob/u-boot-amlogic/arch/riscv/lib/crt0_riscv_efi.S#L51
> [2] https://docs.microsoft.com/en-us/windows/win32/debug/pe-format
>
> > > +       .byte   0x02                                    // MajorLinkerVersion
> > > +       .byte   0x14                                    // MinorLinkerVersion
> > > +       .long   __pecoff_text_end - efi_header_end      // SizeOfCode
> > > +       .long   __pecoff_data_virt_size                 // SizeOfInitializedData
> > > +       .long   0                                       // SizeOfUninitializedData
> > > +       .long   __efistub_efi_pe_entry - _start         // AddressOfEntryPoint
> > > +       .long   efi_header_end - _start                 // BaseOfCode
> > > +
> > > +extra_header_fields:
> > > +       .quad   0                                       // ImageBase
> > > +       .long   PECOFF_SECTION_ALIGNMENT                // SectionAlignment
> > > +       .long   PECOFF_FILE_ALIGNMENT                   // FileAlignment
> > > +       .short  0                                       // MajorOperatingSystemVersion
> > > +       .short  0                                       // MinorOperatingSystemVersion
> > > +       .short  LINUX_EFISTUB_MAJOR_VERSION             // MajorImageVersion
> > > +       .short  LINUX_EFISTUB_MINOR_VERSION             // MinorImageVersion
> > > +       .short  0                                       // MajorSubsystemVersion
> > > +       .short  0                                       // MinorSubsystemVersion
> > > +       .long   0                                       // Win32VersionValue
> > > +
> > > +       .long   _end - _start                           // SizeOfImage
> > > +
> > > +       // Everything before the kernel image is considered part of the header
> > > +       .long   efi_header_end - _start                 // SizeOfHeaders
> > > +       .long   0                                       // CheckSum
> > > +       .short  IMAGE_SUBSYSTEM_EFI_APPLICATION         // Subsystem
> > > +       .short  0                                       // DllCharacteristics
> > > +       .quad   0                                       // SizeOfStackReserve
> > > +       .quad   0                                       // SizeOfStackCommit
> > > +       .quad   0                                       // SizeOfHeapReserve
> > > +       .quad   0                                       // SizeOfHeapCommit
> > > +       .long   0                                       // LoaderFlags
> > > +       .long   (section_table - .) / 8                 // NumberOfRvaAndSizes
> > > +
> > > +       .quad   0                                       // ExportTable
> > > +       .quad   0                                       // ImportTable
> > > +       .quad   0                                       // ResourceTable
> > > +       .quad   0                                       // ExceptionTable
> > > +       .quad   0                                       // CertificationTable
> > > +       .quad   0                                       // BaseRelocationTable
> > > +
> > > +       // Section table
> > > +section_table:
> > > +       .ascii  ".text\0\0\0"
> > > +       .long   __pecoff_text_end - efi_header_end      // VirtualSize
> > > +       .long   efi_header_end - _start                 // VirtualAddress
> > > +       .long   __pecoff_text_end - efi_header_end      // SizeOfRawData
> > > +       .long   efi_header_end - _start                 // PointerToRawData
> > > +
> > > +       .long   0                                       // PointerToRelocations
> > > +       .long   0                                       // PointerToLineNumbers
> > > +       .short  0                                       // NumberOfRelocations
> > > +       .short  0                                       // NumberOfLineNumbers
> > > +       .long   IMAGE_SCN_CNT_CODE | \
> > > +               IMAGE_SCN_MEM_READ | \
> > > +               IMAGE_SCN_MEM_EXECUTE                   // Characteristics
> > > +
> > > +       .ascii  ".data\0\0\0"
> > > +       .long   __pecoff_data_virt_size                 // VirtualSize
> > > +       .long   __pecoff_text_end - _start              // VirtualAddress
> > > +       .long   __pecoff_data_raw_size                  // SizeOfRawData
> > > +       .long   __pecoff_text_end - _start              // PointerToRawData
> > > +
> > > +       .long   0                                       // PointerToRelocations
> > > +       .long   0                                       // PointerToLineNumbers
> > > +       .short  0                                       // NumberOfRelocations
> > > +       .short  0                                       // NumberOfLineNumbers
> > > +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA | \
> > > +               IMAGE_SCN_MEM_READ | \
> > > +               IMAGE_SCN_MEM_WRITE                     // Characteristics
> > > +
> > > +       .set    section_count, (. - section_table) / 40
> > > +
> > > +       .balign 0x1000
> > > +efi_header_end:
> > > +       .endm
> > > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > > index c6a37e8231a8..3631147732ee 100644
> > > --- a/arch/riscv/kernel/head.S
> > > +++ b/arch/riscv/kernel/head.S
> > > @@ -13,6 +13,7 @@
> > >  #include <asm/csr.h>
> > >  #include <asm/hwcap.h>
> > >  #include <asm/image.h>
> > > +#include "efi-header.S"
> > >
> > >  __HEAD
> > >  ENTRY(_start)
> > > @@ -22,10 +23,18 @@ ENTRY(_start)
> > >          * Do not modify it without modifying the structure and all bootloaders
> > >          * that expects this header format!!
> > >          */
> > > +#ifdef CONFIG_EFI
> > > +       /*
> > > +        * This instruction decodes to "MZ" ASCII required by UEFI.
> > > +        */
> > > +       c.li s4,-13
> > > +       j _start_kernel
> > > +#else
> > >         /* jump to start kernel */
> > >         j _start_kernel
> > >         /* reserved */
> > >         .word 0
> > > +#endif
> > >         .balign 8
> > >  #if __riscv_xlen == 64
> > >         /* Image load offset(2MB) from start of RAM */
> > > @@ -43,7 +52,14 @@ ENTRY(_start)
> > >         .ascii RISCV_IMAGE_MAGIC
> > >         .balign 4
> > >         .ascii RISCV_IMAGE_MAGIC2
> > > +#ifdef CONFIG_EFI
> > > +       .word pe_head_start - _start
> > > +pe_head_start:
> > > +
> > > +       __EFI_PE_HEADER
> > > +#else
> > >         .word 0
> > > +#endif
> > >
> > >  .align 2
> > >  #ifdef CONFIG_MMU
> > > diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
> > > new file mode 100644
> > > index 000000000000..8c212efb37a6
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/image-vars.h
> > > @@ -0,0 +1,51 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> > > + * Linker script variables to be set after section resolution, as
> > > + * ld.lld does not like variables assigned before SECTIONS is processed.
> > > + * Based on arch/arm64/kerne/image-vars.h
> > > + */
> > > +#ifndef __RISCV_KERNEL_IMAGE_VARS_H
> > > +#define __RISCV_KERNEL_IMAGE_VARS_H
> > > +
> > > +#ifndef LINKER_SCRIPT
> > > +#error This file should only be included in vmlinux.lds.S
> > > +#endif
> > > +
> > > +#ifdef CONFIG_EFI
> > > +
> > > +/*
> > > + * The EFI stub has its own symbol namespace prefixed by __efistub_, to
> > > + * isolate it from the kernel proper. The following symbols are legally
> > > + * accessed by the stub, so provide some aliases to make them accessible.
> > > + * Only include data symbols here, or text symbols of functions that are
> > > + * guaranteed to be safe when executed at another offset than they were
> > > + * linked at. The routines below are all implemented in assembler in a
> > > + * position independent manner
> > > + */
> > > +__efistub_memcmp               = memcmp;
> > > +__efistub_memchr               = memchr;
> > > +__efistub_memcpy               = memcpy;
> > > +__efistub_memmove              = memmove;
> > > +__efistub_memset               = memset;
> > > +__efistub_strlen               = strlen;
> > > +__efistub_strnlen              = strnlen;
> > > +__efistub_strcmp               = strcmp;
> > > +__efistub_strncmp              = strncmp;
> > > +__efistub_strrchr              = strrchr;
> > > +
> > > +#ifdef CONFIG_KASAN
> > > +__efistub___memcpy             = memcpy;
> > > +__efistub___memmove            = memmove;
> > > +__efistub___memset             = memset;
> > > +#endif
> > > +
> > > +__efistub__start               = _start;
> > > +__efistub__start_kernel                = _start_kernel;
> > > +__efistub__end                 = _end;
> > > +__efistub__edata               = _edata;
> > > +__efistub_screen_info          = screen_info;
> > > +
> > > +#endif
> > > +
> > > +#endif /* __RISCV_KERNEL_IMAGE_VARS_H */
> > > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> > > index f3586e31ed1e..6dcf790282dd 100644
> > > --- a/arch/riscv/kernel/vmlinux.lds.S
> > > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > > @@ -10,6 +10,7 @@
> > >  #include <asm/cache.h>
> > >  #include <asm/thread_info.h>
> > >  #include <asm/set_memory.h>
> > > +#include "image-vars.h"
> > >
> > >  #include <linux/sizes.h>
> > >  OUTPUT_ARCH(riscv)
> > > @@ -17,6 +18,9 @@ ENTRY(_start)
> > >
> > >  jiffies = jiffies_64;
> > >
> > > +PECOFF_SECTION_ALIGNMENT = 0x1000;
> > > +PECOFF_FILE_ALIGNMENT = 0x200;
> > > +
> > >  SECTIONS
> > >  {
> > >         /* Beginning of code and text segment */
> > > @@ -76,6 +80,10 @@ SECTIONS
> > >
> > >         EXCEPTION_TABLE(0x10)
> > >
> > > +#ifdef CONFIG_EFI
> > > +       . = ALIGN(PECOFF_SECTION_ALIGNMENT);
> > > +       __pecoff_text_end = .;
> > > +#endif
> > >         . = ALIGN(SECTION_ALIGN);
> > >         _data = .;
> > >
> > > @@ -83,16 +91,26 @@ SECTIONS
> > >         .sdata : {
> > >                 __global_pointer$ = . + 0x800;
> > >                 *(.sdata*)
> > > -               /* End of data section */
> > > -               _edata = .;
> > >         }
> > >
> > > +#ifdef CONFIG_EFI
> > > +       .pecoff_edata_padding : { BYTE(0); . = ALIGN(PECOFF_FILE_ALIGNMENT); }
> > > +       __pecoff_data_raw_size = ABSOLUTE(. - __pecoff_text_end);
> > > +#endif
> > > +
> > > +       /* End of data section */
> > > +       _edata = .;
> > > +
> > >         BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
> > >
> > >         .rel.dyn : {
> > >                 *(.rel.dyn*)
> > >         }
> > >
> > > +#ifdef CONFIG_EFI
> > > +       . = ALIGN(PECOFF_SECTION_ALIGNMENT);
> > > +       __pecoff_data_virt_size = ABSOLUTE(. - __pecoff_text_end);
> > > +#endif
> > >         _end = .;
> > >
> > >         STABS_DEBUG
> > > --
> > > 2.24.0
> > >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish
