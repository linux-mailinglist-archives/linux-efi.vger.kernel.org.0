Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F18A17119D
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 08:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgB0HpF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 02:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgB0HpE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 27 Feb 2020 02:45:04 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 862AE24691
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 07:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582789502;
        bh=1DKVZpJ1NMtFpDCRoT/3aJcM0IW1AcSqjMAJKvtYKlg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PWjCPWiSzkS936HvR7EliMT4UotLlAUAyE6IsUwh67LXlMZlO+934ykpYZRPKQwm7
         51/VPBx1n6Yx3D78qnKZGhOQyVw3UIUy1gG50RIBSSDHPVHXI4mLN75S/VBXwNLjJy
         PdAdFOmoq348lU9BkwQnlE0aJFJiiJgvXszG5zbs=
Received: by mail-wr1-f52.google.com with SMTP id y17so2025785wrn.6
        for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2020 23:45:02 -0800 (PST)
X-Gm-Message-State: APjAAAW/u6IU1gCi3aWb08aCr0k/T1dwwUF7bwl5rlr6i68hbC0FHk7X
        JxuptqqIVOlvPLohCjQaC3KtFwErdSxWrjDdHSfdbQ==
X-Google-Smtp-Source: APXvYqxhBql6Oe0MnL5mBzs98ZgSlfdceYzb+t2zpkYhMsxjLgujOzvqCQXknJGmo5nqP56kW8FTdXv3a6jRwCKEvas=
X-Received: by 2002:a5d:5188:: with SMTP id k8mr3225259wrv.151.1582789500393;
 Wed, 26 Feb 2020 23:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20200226011037.7179-1-atish.patra@wdc.com> <20200226011037.7179-5-atish.patra@wdc.com>
 <CAKv+Gu8pQ3sATCc_XysQ0GUj_ahcQvjP6idgVHek8L7+ENdXKw@mail.gmail.com> <4c55e171ecc7a728c331ccb6d9057f7b9d79af8d.camel@wdc.com>
In-Reply-To: <4c55e171ecc7a728c331ccb6d9057f7b9d79af8d.camel@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 27 Feb 2020 08:44:50 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu83R1RpamGj=LBurBH_7KzEcs9Xa0ivCM-DuybLZeye9w@mail.gmail.com>
Message-ID: <CAKv+Gu83R1RpamGj=LBurBH_7KzEcs9Xa0ivCM-DuybLZeye9w@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] RISC-V: Add PE/COFF header for EFI stub
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

On Thu, 27 Feb 2020 at 02:29, Atish Patra <Atish.Patra@wdc.com> wrote:
>
> On Wed, 2020-02-26 at 08:14 +0100, Ard Biesheuvel wrote:
> > On Wed, 26 Feb 2020 at 02:10, Atish Patra <atish.patra@wdc.com>
> > wrote:
> > > Linux kernel Image can appear as an EFI application With
> > > appropriate
> > > PE/COFF header fields in the beginning of the Image header. An EFI
> > > application loader can directly load a Linux kernel Image and an
> > > EFI
> > > stub residing in kernel can boot Linux kernel directly.
> > >
> > > Add the necessary PE/COFF header.
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >  arch/riscv/include/asm/Kbuild     |   1 -
> > >  arch/riscv/include/asm/sections.h |  13 ++++
> > >  arch/riscv/kernel/Makefile        |   4 ++
> > >  arch/riscv/kernel/efi-header.S    | 107
> > > ++++++++++++++++++++++++++++++
> > >  arch/riscv/kernel/head.S          |  15 +++++
> > >  arch/riscv/kernel/image-vars.h    |  52 +++++++++++++++
> > >  arch/riscv/kernel/vmlinux.lds.S   |  27 ++++++--
> > >  7 files changed, 212 insertions(+), 7 deletions(-)
> > >  create mode 100644 arch/riscv/include/asm/sections.h
> > >  create mode 100644 arch/riscv/kernel/efi-header.S
> > >  create mode 100644 arch/riscv/kernel/image-vars.h
> > >
> > > diff --git a/arch/riscv/include/asm/Kbuild
> > > b/arch/riscv/include/asm/Kbuild
> > > index 517394390106..ef797fe44934 100644
> > > --- a/arch/riscv/include/asm/Kbuild
> > > +++ b/arch/riscv/include/asm/Kbuild
> > > @@ -24,7 +24,6 @@ generic-y += local64.h
> > >  generic-y += mm-arch-hooks.h
> > >  generic-y += percpu.h
> > >  generic-y += preempt.h
> > > -generic-y += sections.h
> > >  generic-y += serial.h
> > >  generic-y += shmparam.h
> > >  generic-y += topology.h
> > > diff --git a/arch/riscv/include/asm/sections.h
> > > b/arch/riscv/include/asm/sections.h
> > > new file mode 100644
> > > index 000000000000..3a9971b1210f
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/sections.h
> > > @@ -0,0 +1,13 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (C) 2020 Western Digital Corporation or its
> > > affiliates.
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
> > > diff --git a/arch/riscv/kernel/Makefile
> > > b/arch/riscv/kernel/Makefile
> > > index 9601ac907f70..471b1c73f77d 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -29,6 +29,10 @@ obj-y        += cacheinfo.o
> > >  obj-$(CONFIG_MMU) += vdso.o vdso/
> > >
> > >  obj-$(CONFIG_RISCV_M_MODE)     += clint.o
> > > +OBJCOPYFLAGS := --prefix-symbols=__efistub_
> > > +$(obj)/%.stub.o: $(obj)/%.o FORCE
> > > +       $(call if_changed,objcopy)
> > > +
> > >  obj-$(CONFIG_FPU)              += fpu.o
> > >  obj-$(CONFIG_SMP)              += smpboot.o
> > >  obj-$(CONFIG_SMP)              += smp.o
> > > diff --git a/arch/riscv/kernel/efi-header.S
> > > b/arch/riscv/kernel/efi-header.S
> > > new file mode 100644
> > > index 000000000000..af959e748d93
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/efi-header.S
> > > @@ -0,0 +1,107 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (C) 2019 Western Digital Corporation or its
> > > affiliates.
> > > + * Adapted from arch/arm64/kernel/efi-header.S
> > > + */
> > > +
> > > +#include <linux/pe.h>
> > > +#include <linux/sizes.h>
> > > +
> > > +       .macro  __EFI_PE_HEADER
> > > +       .long   PE_MAGIC
> > > +coff_header:
> > > +       .short  IMAGE_FILE_MACHINE_RISCV64              // Machine
> > > +       .short  section_count                           //
> > > NumberOfSections
> > > +       .long   0                                       //
> > > TimeDateStamp
> > > +       .long   0                                       //
> > > PointerToSymbolTable
> > > +       .long   0                                       //
> > > NumberOfSymbols
> > > +       .short  section_table - optional_header         //
> > > SizeOfOptionalHeader
> > > +       .short  IMAGE_FILE_DEBUG_STRIPPED | \
> > > +               IMAGE_FILE_EXECUTABLE_IMAGE | \
> > > +               IMAGE_FILE_LINE_NUMS_STRIPPED           //
> > > Characteristics
> > > +
> > > +optional_header:
> > > +       .short  PE_OPT_MAGIC_PE32PLUS                   // PE32+
> > > format
> > > +       .byte   0x02                                    //
> > > MajorLinkerVersion
> > > +       .byte   0x14                                    //
> > > MinorLinkerVersion
> > > +       .long   __text_end - efi_header_end             //
> > > SizeOfCode
> > > +       .long   _end - __text_end                       //
> > > SizeOfInitializedData
> > > +       .long   0                                       //
> > > SizeOfUninitializedData
> > > +       .long   __efistub_efi_entry - _start            //
> > > AddressOfEntryPoint
> > > +       .long   efi_header_end - _start                 //
> > > BaseOfCode
> > > +
> > > +extra_header_fields:
> > > +       .quad   0                                       //
> > > ImageBase
> > > +       .long   SZ_4K                                   //
> > > SectionAlignment
> > > +       .long   PECOFF_FILE_ALIGNMENT                   //
> > > FileAlignment
> > > +       .short  0                                       //
> > > MajorOperatingSystemVersion
> > > +       .short  0                                       //
> > > MinorOperatingSystemVersion
> > > +       .short  0                                       //
> > > MajorImageVersion
> > > +       .short  0                                       //
> > > MinorImageVersion
> >
> > Put LINUX_EFISTUB_MAJOR_VERSION and LINUX_EFISTUB_MINOR_VERSION here
> >
>
> Sure.
>
> > > +       .short  0                                       //
> > > MajorSubsystemVersion
> > > +       .short  0                                       //
> > > MinorSubsystemVersion
> > > +       .long   0                                       //
> > > Win32VersionValue
> > > +
> > > +       .long   _end - _start                           //
> > > SizeOfImage
> > > +
> > > +       // Everything before the kernel image is considered part of
> > > the header
> > > +       .long   efi_header_end - _start                 //
> > > SizeOfHeaders
> > > +       .long   0                                       // CheckSum
> > > +       .short  IMAGE_SUBSYSTEM_EFI_APPLICATION         //
> > > Subsystem
> > > +       .short  0                                       //
> > > DllCharacteristics
> > > +       .quad   0                                       //
> > > SizeOfStackReserve
> > > +       .quad   0                                       //
> > > SizeOfStackCommit
> > > +       .quad   0                                       //
> > > SizeOfHeapReserve
> > > +       .quad   0                                       //
> > > SizeOfHeapCommit
> > > +       .long   0                                       //
> > > LoaderFlags
> > > +       .long   (section_table - .) / 8                 //
> > > NumberOfRvaAndSizes
> > > +
> > > +       .quad   0                                       //
> > > ExportTable
> > > +       .quad   0                                       //
> > > ImportTable
> > > +       .quad   0                                       //
> > > ResourceTable
> > > +       .quad   0                                       //
> > > ExceptionTable
> > > +       .quad   0                                       //
> > > CertificationTable
> > > +       .quad   0                                       //
> > > BaseRelocationTable
> > > +
> > > +       // Section table
> > > +section_table:
> > > +       .ascii  ".text\0\0\0"
> > > +       .long   __text_end - efi_header_end             //
> > > VirtualSize
> > > +       .long   efi_header_end - _start                 //
> > > VirtualAddress
> > > +       .long   __text_end - efi_header_end             //
> > > SizeOfRawData
> > > +       .long   efi_header_end - _start                 //
> > > PointerToRawData
> > > +
> > > +       .long   0                                       //
> > > PointerToRelocations
> > > +       .long   0                                       //
> > > PointerToLineNumbers
> > > +       .short  0                                       //
> > > NumberOfRelocations
> > > +       .short  0                                       //
> > > NumberOfLineNumbers
> > > +       .long   IMAGE_SCN_CNT_CODE | \
> > > +               IMAGE_SCN_MEM_READ | \
> > > +               IMAGE_SCN_MEM_EXECUTE                   //
> > > Characteristics
> > > +
> > > +       .ascii  ".data\0\0\0"
> > > +       .long   __data_virt_size                        //
> > > VirtualSize
> > > +       .long   __text_end - _start                     //
> > > VirtualAddress
> > > +       .long   __data_raw_size                         //
> > > SizeOfRawData
> > > +       .long   __text_end - _start                     //
> > > PointerToRawData
> > > +
> > > +       .long   0                                       //
> > > PointerToRelocations
> > > +       .long   0                                       //
> > > PointerToLineNumbers
> > > +       .short  0                                       //
> > > NumberOfRelocations
> > > +       .short  0                                       //
> > > NumberOfLineNumbers
> > > +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA | \
> > > +               IMAGE_SCN_MEM_READ | \
> > > +               IMAGE_SCN_MEM_WRITE                     //
> > > Characteristics
> > > +
> > > +       .set    section_count, (. - section_table) / 40
> > > +
> >
> > You dropped the debug header here, which is actually *very* useful if
> > you want to single step through the stub from DEBUG edk2 firmware.
> >
>
> Ahh I see. I was not sure how to use the debug feature :). Can we do
> the same in U-boot ?
>

You could, but I doubt it has been implemented yet.

Adding the debug header will cause the firmware to record the image
path and its load address in a special debug table, which the firmware
can use to expose the load address and path of the image as it is
loaded (i.e. before moving itself into place)

When I run this under a DEBUG build of EDK2, it prints a line like

add-symbol-file /home/ardbie01/linux-build-arm64/vmlinux 0x74E0B000

which I can paste into the GDB command window, set a breakpoint on
efi_entry(), and single step through the stub.


> How about adding it back later once I can verify it with EDK2 ?
>

Sure, that is fine

> > > +       /*
> > > +        * EFI will load .text onwards at the 4k section alignment
> > > +        * described in the PE/COFF header. To ensure that
> > > instruction
> > > +        * sequences using an adrp and a :lo12: immediate will
> > > function
> >
> > Surely, this is inaccurate for RISC-V?
>
> Sorry. I should have removed the comment. We keep the the _start and
> .head.text section aligned to a PAGE_SIZE anyways using the linker
> script.

ok

> >
> > > +        * correctly at this alignment, we must ensure that .text
> > > is
> > > +        * placed at a 4k boundary in the Image to begin with.
> > > +        */
> > > +       .align 12
> > > +efi_header_end:
> > > +       .endm
> > > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > > index ac5b0e0a02f6..835dc76de285 100644
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
> > > @@ -22,10 +23,17 @@ ENTRY(_start)
> > >          * Do not modify it without modifying the structure and all
> > > bootloaders
> > >          * that expects this header format!!
> > >          */
> > > +#ifdef CONFIG_EFI
> > > +       /*
> > > +        * This instruction decodes to "MZ" ASCII required by UEFI.
> > > +        */
> > > +       li s4,-13
> >
> > What happens if you try to do plain boot on an EFI kernel? On ARM and
> > x86, we took care to use a 'MZ' opcode that behaves as a pseudo-NOP,
> > and jump to start_kernel right after, so if you boot the EFI kernel
> > as
> > a normal kernel, it still works.
> >
>
> There should have been a "j _start_kernel" after the "MZ" ascii. I just
> tested EFI kernel can now boot as a normal kernel as well with that
> change. Thanks for pointing that out.
>

Sure

> > > +#else
> > >         /* jump to start kernel */
> > >         j _start_kernel
> > >         /* reserved */
> > >         .word 0
> > > +#endif
> > >         .balign 8
> > >  #if __riscv_xlen == 64
> > >         /* Image load offset(2MB) from start of RAM */
> > > @@ -43,7 +51,14 @@ ENTRY(_start)
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
> > > diff --git a/arch/riscv/kernel/image-vars.h
> > > b/arch/riscv/kernel/image-vars.h
> > > new file mode 100644
> > > index 000000000000..57abb85065e9
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/image-vars.h
> > > @@ -0,0 +1,52 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Linker script variables to be set after section resolution, as
> > > + * ld.lld does not like variables assigned before SECTIONS is
> > > processed.
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
> > > +__efistub_stext_offset = _start_kernel - _start;
> > > +
> > > +/*
> > > + * The EFI stub has its own symbol namespace prefixed by
> > > __efistub_, to
> > > + * isolate it from the kernel proper. The following symbols are
> > > legally
> > > + * accessed by the stub, so provide some aliases to make them
> > > accessible.
> > > + * Only include data symbols here, or text symbols of functions
> > > that are
> > > + * guaranteed to be safe when executed at another offset than they
> > > were
> > > + * linked at. The routines below are all implemented in assembler
> > > in a
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
> > > diff --git a/arch/riscv/kernel/vmlinux.lds.S
> > > b/arch/riscv/kernel/vmlinux.lds.S
> > > index b32640300d07..933b9e9a4b39 100644
> > > --- a/arch/riscv/kernel/vmlinux.lds.S
> > > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > > @@ -9,6 +9,7 @@
> > >  #include <asm/page.h>
> > >  #include <asm/cache.h>
> > >  #include <asm/thread_info.h>
> > > +#include "image-vars.h"
> > >
> > >  #include <linux/sizes.h>
> > >  OUTPUT_ARCH(riscv)
> > > @@ -16,6 +17,14 @@ ENTRY(_start)
> > >
> > >  jiffies = jiffies_64;
> > >
> > > +PECOFF_FILE_ALIGNMENT = 0x200;
> > > +#ifdef CONFIG_EFI
> > > +#define PECOFF_EDATA_PADDING   \
> > > +       .pecoff_edata_padding : { BYTE(0); . =
> > > ALIGN(PECOFF_FILE_ALIGNMENT); }
> > > +#else
> > > +#define PECOFF_EDATA_PADDING
> > > +#endif
> > > +
> > >  SECTIONS
> > >  {
> > >         /* Beginning of code and text segment */
> > > @@ -26,12 +35,15 @@ SECTIONS
> > >
> > >         __init_begin = .;
> > >         INIT_TEXT_SECTION(PAGE_SIZE)
> > > +
> > > +       /* Start of data section */
> > >         INIT_DATA_SECTION(16)
> > >         /* we have to discard exit text and such at runtime, not
> > > link time */
> > >         .exit.text :
> > >         {
> > >                 EXIT_TEXT
> > >         }
> > > +
> > >         .exit.data :
> > >         {
> > >                 EXIT_DATA
> > > @@ -54,7 +66,8 @@ SECTIONS
> > >                 _etext = .;
> > >         }
> > >
> > > -       /* Start of data section */
> > > +       __text_end = .;
> > > +
> > >         _sdata = .;
> > >         RO_DATA(L1_CACHE_BYTES)
> > >         .srodata : {
> > > @@ -65,19 +78,21 @@ SECTIONS
> > >         .sdata : {
> > >                 __global_pointer$ = . + 0x800;
> > >                 *(.sdata*)
> > > -               /* End of data section */
> > > -               _edata = .;
> > >                 *(.sbss*)
> > >         }
> > > -
> > > -       BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
> > > -
> > > +       PECOFF_EDATA_PADDING
> > > +       __data_raw_size = ABSOLUTE(. - __text_end);
> > > +       /* End of data section */
> > > +       _edata = .;
> > >         EXCEPTION_TABLE(0x10)
> > >
> > >         .rel.dyn : {
> > >                 *(.rel.dyn*)
> > >         }
> > >
> > > +       BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
> > > +       __data_virt_size = ABSOLUTE(. - __text_end);
> > > +
> > >         _end = .;
> > >
> > >         STABS_DEBUG
> > > --
> > > 2.24.0
> > >
>
> --
> Regards,
> Atish
