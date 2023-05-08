Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD4E6FBAED
	for <lists+linux-efi@lfdr.de>; Tue,  9 May 2023 00:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjEHWMk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 18:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjEHWMf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 18:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1190AD18;
        Mon,  8 May 2023 15:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 527A364356;
        Mon,  8 May 2023 22:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864BAC433A1;
        Mon,  8 May 2023 22:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683583915;
        bh=T3WSGNYBa9bs0oydrzcT7TbH9u43a/djb//tipxYvnE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TeAmMSq99b60bIAqRyB/1RoSFogiMDTez/omPpMbMFymKZ4uWOHAxUrj4gsjLH3UL
         GrOtnwBPPAPiplWOHur+JD8CpNRQ4BSdL8Gqaoa5xxK09NjkPtHADqo7+i88hLcf2k
         5EZKB15oix2zbv++inNuAmjYZzPxsvD3IFYwVVdxvBSzsO+cb8vdGCPVidYBNqvAN9
         g2ea7xjgSXm9W1cUFosUp59nEHz4XBhFFdRDDxpK6N5HmZ5yr0MWkyO06sxOtU2M4z
         e2y3jcAPCCdz2Q4VJiSj5S8ArOuxwASlsXcm1YDZCfA3FDrrsqkBf2eBxCCIbExenn
         yTNWS37JDn5XQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ac7f53ae44so56134561fa.2;
        Mon, 08 May 2023 15:11:55 -0700 (PDT)
X-Gm-Message-State: AC+VfDwGnNZmpO7E7nMOJNN1rWrQwdVGPLk6spQnixii9Twwk4qMCJ6c
        9iRHYN+G4ED3ayElysQDH2rctds23YERRc28Zi8=
X-Google-Smtp-Source: ACHHUZ7cCZeNYoLvUmMd1Y08SifmUokxwhnb4KKLwjt4ivo7CpG4nzr9jxPJ8UVkY4+T6J6leRlLpS1pw6OBEekcACc=
X-Received: by 2002:a2e:97cd:0:b0:2ad:8620:80f3 with SMTP id
 m13-20020a2e97cd000000b002ad862080f3mr138691ljj.30.1683583913269; Mon, 08 May
 2023 15:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230507234618.18067-1-kirill.shutemov@linux.intel.com>
 <20230507234618.18067-5-kirill.shutemov@linux.intel.com> <CAMj1kXE26G=HgqBHoJOWF+FyXs7Ryj7VFFY9A+xG7HmUXnb5bg@mail.gmail.com>
 <20230508190043.ouauzbghn27khdy4@box.shutemov.name>
In-Reply-To: <20230508190043.ouauzbghn27khdy4@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 May 2023 00:11:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFxw4+opJuq=g2unocitRyKYz_hfrZb-grsZtPwBOyKgw@mail.gmail.com>
Message-ID: <CAMj1kXFxw4+opJuq=g2unocitRyKYz_hfrZb-grsZtPwBOyKgw@mail.gmail.com>
Subject: Re: [PATCHv10 04/11] efi/x86: Implement support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 8 May 2023 at 21:00, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Mon, May 08, 2023 at 09:30:22AM +0200, Ard Biesheuvel wrote:
> > Hello Kirill,
> >
> > On Mon, 8 May 2023 at 01:46, Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > UEFI Specification version 2.9 introduces the concept of memory
> > > acceptance: Some Virtual Machine platforms, such as Intel TDX or AMD
> > > SEV-SNP, requiring memory to be accepted before it can be used by the
> > > guest. Accepting happens via a protocol specific for the Virtual
> > > Machine platform.
> > >
> > > Accepting memory is costly and it makes VMM allocate memory for the
> > > accepted guest physical address range. It's better to postpone memory
> > > acceptance until memory is needed. It lowers boot time and reduces
> > > memory overhead.
> > >
> > > The kernel needs to know what memory has been accepted. Firmware
> > > communicates this information via memory map: a new memory type --
> > > EFI_UNACCEPTED_MEMORY -- indicates such memory.
> > >
> > > Range-based tracking works fine for firmware, but it gets bulky for
> > > the kernel: e820 has to be modified on every page acceptance. It leads
> > > to table fragmentation, but there's a limited number of entries in the
> > > e820 table
> > >
> > > Another option is to mark such memory as usable in e820 and track if the
> > > range has been accepted in a bitmap. One bit in the bitmap represents
> > > 2MiB in the address space: one 4k page is enough to track 64GiB or
> > > physical address space.
> > >
> > > In the worst-case scenario -- a huge hole in the middle of the
> > > address space -- It needs 256MiB to handle 4PiB of the address
> > > space.
> > >
> > > Any unaccepted memory that is not aligned to 2M gets accepted upfront.
> > >
> > > The bitmap is allocated and constructed in the EFI stub and passed down
> > > to the kernel via boot_params. allocate_e820() allocates the bitmap if
> > > unaccepted memory is present, according to the maximum address in the
> > > memory map.
> > >
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > ---
> > >  Documentation/arch/x86/zero-page.rst     |  1 +
> > >  arch/x86/boot/compressed/Makefile        |  1 +
> > >  arch/x86/boot/compressed/mem.c           | 73 ++++++++++++++++++++++++
> > >  arch/x86/include/asm/unaccepted_memory.h | 10 ++++
> > >  arch/x86/include/uapi/asm/bootparam.h    |  2 +-
> > >  drivers/firmware/efi/Kconfig             | 14 +++++
> > >  drivers/firmware/efi/efi.c               |  1 +
> > >  drivers/firmware/efi/libstub/x86-stub.c  | 65 +++++++++++++++++++++
> > >  include/linux/efi.h                      |  3 +-
> > >  9 files changed, 168 insertions(+), 2 deletions(-)
> > >  create mode 100644 arch/x86/boot/compressed/mem.c
> > >  create mode 100644 arch/x86/include/asm/unaccepted_memory.h
> > >
> > > diff --git a/Documentation/arch/x86/zero-page.rst b/Documentation/arch/x86/zero-page.rst
> > > index 45aa9cceb4f1..f21905e61ade 100644
> > > --- a/Documentation/arch/x86/zero-page.rst
> > > +++ b/Documentation/arch/x86/zero-page.rst
> > > @@ -20,6 +20,7 @@ Offset/Size   Proto   Name                    Meaning
> > >  060/010                ALL     ist_info                Intel SpeedStep (IST) BIOS support information
> > >                                                 (struct ist_info)
> > >  070/008                ALL     acpi_rsdp_addr          Physical address of ACPI RSDP table
> > > +078/008                ALL     unaccepted_memory       Bitmap of unaccepted memory (1bit == 2M)
> >
> > Unaccepted memory is a generic EFI feature, and will need to be
> > supported on other architectures as well.
> >
> > Could we perhaps use a EFI configuration table to pass the bitmap to
> > the core kernel, instead of adding more cruft to this archaic header?
> > That could be implemented in a arch-agnostic manner, even in cases
> > where the bootloader is the agent that calls ExitBootServices(), as it
> > would be the loader that allocates and populates the bitmap in that
> > case.
>
> Okay, that's a fair point.
>
> Below is my take on this. It is on top of whole patchset. It seems to be
> functional, but more testing is required.
>

Thanks a lot for having a stab at this. Some minor nits below, but
this generally looks like the way to do it.


> While there I also removed hardcoded 1b == 2MB.
>
> My EFI knowledge is rather superficial. I would be glad for feedback.
>
...
> diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
> index cf475243b6d5..5b63628912da 100644
> --- a/arch/x86/boot/compressed/efi.h
> +++ b/arch/x86/boot/compressed/efi.h
> @@ -105,6 +105,15 @@ struct efi_setup_data {
>         u64 reserved[8];
>  };
>
> +struct efi_unaccepted_memory {
> +       u32 version;
> +       u32 unit_size;
> +       u64 size;

Could we add a base here too? DRAM could be anywhere in the PA space
on some architectures.


> +       u64 bitmap[];

Should this be unsigned long[] ?

> +};
> +
> +extern struct efi_unaccepted_memory *unaccepted_table;
> +
>  static inline int efi_guidcmp (efi_guid_t left, efi_guid_t right)
>  {
>         return memcmp(&left, &right, sizeof (efi_guid_t));
> diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> index e6b92e822ddd..7d50aea0d6b1 100644
> --- a/arch/x86/boot/compressed/mem.c
> +++ b/arch/x86/boot/compressed/mem.c
> @@ -1,7 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>
> +#include <linux/uuid.h>
>  #include "../cpuflags.h"
>  #include "bitmap.h"
> +#include "efi.h"
>  #include "error.h"
>  #include "find.h"
>  #include "math.h"
> @@ -12,8 +14,6 @@
>  #define PMD_SIZE       (_AC(1, UL) << PMD_SHIFT)
>  #define PMD_MASK       (~(PMD_SIZE - 1))
>
> -extern struct boot_params *boot_params;
> -
>  /*
>   * accept_memory() and process_unaccepted_memory() called from EFI stub which
>   * runs before decompresser and its early_tdx_detect().
> @@ -57,66 +57,77 @@ static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
>   *
>   * The function will never reach the bitmap_set() with zero bits to set.
>   */
> -void process_unaccepted_memory(struct boot_params *params, u64 start, u64 end)
> +void process_unaccepted_memory(u64 start, u64 end)
>  {
> +       u64 unit_size = unaccepted_table->unit_size;
> +       u64 unit_mask = unaccepted_table->unit_size - 1;
> +       u64 bitmap_size = unaccepted_table->size;
> +
>         /*
>          * Ensure that at least one bit will be set in the bitmap by
> -        * immediately accepting all regions under 2*PMD_SIZE.  This is
> +        * immediately accepting all regions under 2*unit_size.  This is
>          * imprecise and may immediately accept some areas that could
>          * have been represented in the bitmap.  But, results in simpler
>          * code below
>          *
> -        * Consider case like this:
> +        * Consider case like this (assuming unit_size == 2MB):
>          *
>          * | 4k | 2044k |    2048k   |
>          * ^ 0x0        ^ 2MB        ^ 4MB
>          *
>          * Only the first 4k has been accepted. The 0MB->2MB region can not be
>          * represented in the bitmap. The 2MB->4MB region can be represented in
> -        * the bitmap. But, the 0MB->4MB region is <2*PMD_SIZE and will be
> +        * the bitmap. But, the 0MB->4MB region is <2*unit_size and will be
>          * immediately accepted in its entirety.
>          */
> -       if (end - start < 2 * PMD_SIZE) {
> +       if (end - start < 2 * unit_size) {
>                 __accept_memory(start, end);
>                 return;
>         }
>
>         /*
>          * No matter how the start and end are aligned, at least one unaccepted
> -        * PMD_SIZE area will remain to be marked in the bitmap.
> +        * unit_size area will remain to be marked in the bitmap.
>          */
>
> -       /* Immediately accept a <PMD_SIZE piece at the start: */
> -       if (start & ~PMD_MASK) {
> -               __accept_memory(start, round_up(start, PMD_SIZE));
> -               start = round_up(start, PMD_SIZE);
> +       /* Immediately accept a <unit_size piece at the start: */
> +       if (start & unit_mask) {
> +               __accept_memory(start, round_up(start, unit_size));
> +               start = round_up(start, unit_size);
>         }
>
> -       /* Immediately accept a <PMD_SIZE piece at the end: */
> -       if (end & ~PMD_MASK) {
> -               __accept_memory(round_down(end, PMD_SIZE), end);
> -               end = round_down(end, PMD_SIZE);
> +       /* Immediately accept a <unit_size piece at the end: */
> +       if (end & unit_mask) {
> +               __accept_memory(round_down(end, unit_size), end);
> +               end = round_down(end, unit_size);
> +       }
> +
> +       /* Accept everything that cannot be recorded into the bitmap */
> +       if (end > bitmap_size * unit_size * BITS_PER_BYTE) {
> +               __accept_memory(bitmap_size * unit_size * BITS_PER_BYTE, end);
> +               end = bitmap_size * unit_size * BITS_PER_BYTE;
>         }
>
>         /*
> -        * 'start' and 'end' are now both PMD-aligned.
> +        * 'start' and 'end' are now both unit_size-aligned.
>          * Record the range as being unaccepted:
>          */
> -       bitmap_set((unsigned long *)params->unaccepted_memory,
> -                  start / PMD_SIZE, (end - start) / PMD_SIZE);
> +       bitmap_set((unsigned long *)unaccepted_table->bitmap,
> +                  start / unit_size, (end - start) / unit_size);
>  }
>
>  void accept_memory(phys_addr_t start, phys_addr_t end)
>  {
>         unsigned long range_start, range_end;
>         unsigned long *bitmap, bitmap_size;
> +       u64 unit_size = unaccepted_table->unit_size;
>
> -       bitmap = (unsigned long *)boot_params->unaccepted_memory;
> -       range_start = start / PMD_SIZE;
> -       bitmap_size = DIV_ROUND_UP(end, PMD_SIZE);
> +       bitmap = (unsigned long *)unaccepted_table->bitmap;
> +       range_start = start / unit_size;
> +       bitmap_size = DIV_ROUND_UP(end, unit_size);
>
>         for_each_set_bitrange_from(range_start, range_end, bitmap, bitmap_size) {
> -               __accept_memory(range_start * PMD_SIZE, range_end * PMD_SIZE);
> +               __accept_memory(range_start * unit_size, range_end * unit_size);
>                 bitmap_clear(bitmap, range_start, range_end - range_start);
>         }
>  }
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 186bfd53e042..f481f0b30873 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -456,7 +456,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>
>         debug_putstr("\nDecompressing Linux... ");
>
> -       if (boot_params->unaccepted_memory) {
> +       if (unaccepted_table) {
>                 debug_putstr("Accepting memory... ");
>                 accept_memory(__pa(output), __pa(output) + needed_size);
>         }
> diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
> index 89fc91c61560..9f695bdde01c 100644
> --- a/arch/x86/include/asm/unaccepted_memory.h
> +++ b/arch/x86/include/asm/unaccepted_memory.h
> @@ -3,9 +3,7 @@
>  #ifndef _ASM_X86_UNACCEPTED_MEMORY_H
>  #define _ASM_X86_UNACCEPTED_MEMORY_H
>
> -struct boot_params;
> -
> -void process_unaccepted_memory(struct boot_params *params, u64 start, u64 num);
> +void process_unaccepted_memory(u64 start, u64 num);
>
>  #ifdef CONFIG_UNACCEPTED_MEMORY
>
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index 630a54046af0..01d19fc22346 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -189,7 +189,7 @@ struct boot_params {
>         __u64  tboot_addr;                              /* 0x058 */
>         struct ist_info ist_info;                       /* 0x060 */
>         __u64 acpi_rsdp_addr;                           /* 0x070 */
> -       __u64 unaccepted_memory;                        /* 0x078 */
> +       __u8  _pad3[8];                                 /* 0x078 */
>         __u8  hd0_info[16];     /* obsolete! */         /* 0x080 */
>         __u8  hd1_info[16];     /* obsolete! */         /* 0x090 */
>         struct sys_desc_table sys_desc_table; /* obsolete! */   /* 0x0a0 */
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 483c36a28d2e..8ee6b756712f 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -16,6 +16,7 @@
>  #include <linux/firmware-map.h>
>  #include <linux/sort.h>
>  #include <linux/memory_hotplug.h>
> +#include <linux/efi.h>
>
>  #include <asm/e820/api.h>
>  #include <asm/setup.h>
> @@ -1324,13 +1325,15 @@ void __init e820__memblock_setup(void)
>          * e820_table is not finalized and e820__end_of_ram_pfn() cannot be
>          * used to get correct RAM size.
>          */
> -       if (boot_params.unaccepted_memory) {
> +       if (efi.unaccepted != EFI_INVALID_TABLE_ADDR) {
> +               struct efi_unaccepted_memory *unaccepted;
>                 unsigned long size;
>
> -               /* One bit per 2MB */
> -               size = DIV_ROUND_UP(e820__end_of_ram_pfn() * PAGE_SIZE,
> -                                   PMD_SIZE * BITS_PER_BYTE);
> -               memblock_reserve(boot_params.unaccepted_memory, size);
> +               unaccepted = __va(efi.unaccepted);
> +
> +               size = sizeof(struct efi_unaccepted_memory);
> +               size += unaccepted->size;
> +               memblock_reserve(efi.unaccepted, size);
>         }
>

This could be moved to generic code (but we'll need to use early_memremap())

>         /*
> diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
> index f61174d4c3cb..ec2b616ef32e 100644
> --- a/arch/x86/mm/unaccepted_memory.c
> +++ b/arch/x86/mm/unaccepted_memory.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/efi.h>
>  #include <linux/memblock.h>
>  #include <linux/mm.h>
>  #include <linux/pfn.h>
> @@ -14,15 +15,19 @@ static DEFINE_SPINLOCK(unaccepted_memory_lock);
>
>  void accept_memory(phys_addr_t start, phys_addr_t end)
>  {
> +       struct efi_unaccepted_memory *unaccepted;
>         unsigned long range_start, range_end;
> -       unsigned long *bitmap;
> -       unsigned long flags;
> +       unsigned long flags, *bitmap;
> +       u64 unit_size;
>
> -       if (!boot_params.unaccepted_memory)
> +       if (efi.unaccepted == EFI_INVALID_TABLE_ADDR)
>                 return;
>
> -       bitmap = __va(boot_params.unaccepted_memory);
> -       range_start = start / PMD_SIZE;
> +       unaccepted = __va(efi.unaccepted);
> +       unit_size = unaccepted->unit_size;
> +       bitmap = (unsigned long *)unaccepted->bitmap;
> +
> +       range_start = start / unit_size;
>
>         /*
>          * load_unaligned_zeropad() can lead to unwanted loads across page
> @@ -42,23 +47,25 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>          * used:
>          *
>          * 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
> -        *    checks up to end+2M if 'end' is aligned on a 2M boundary.
> +        *    checks up to end+unit_size if 'end' is aligned on a unit_size
> +        *    boundary.
>          *
> -        * 2. Implicitly extend accept_memory(start, end) to end+2M if 'end' is
> -        *    aligned on a 2M boundary. (immediately following this comment)
> +        * 2. Implicitly extend accept_memory(start, end) to end+unit_size if
> +        *    'end' is aligned on a unit_size boundary. (immediately following
> +        *    this comment)
>          */
> -       if (!(end % PMD_SIZE))
> -               end += PMD_SIZE;
> +       if (!(end % unit_size))
> +               end += unit_size;
>
>         spin_lock_irqsave(&unaccepted_memory_lock, flags);
>         for_each_set_bitrange_from(range_start, range_end, bitmap,
> -                                  DIV_ROUND_UP(end, PMD_SIZE)) {
> +                                  DIV_ROUND_UP(end, unit_size)) {
>                 unsigned long len = range_end - range_start;
>
>                 /* Platform-specific memory-acceptance call goes here */
>                 if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> -                       tdx_accept_memory(range_start * PMD_SIZE,
> -                                         range_end * PMD_SIZE);
> +                       tdx_accept_memory(range_start * unit_size,
> +                                         range_end * unit_size);
>                 } else {
>                         panic("Cannot accept memory: unknown platform\n");
>                 }
> @@ -70,30 +77,33 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>
>  bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
>  {
> -       unsigned long *bitmap;
> -       unsigned long flags;
> +       struct efi_unaccepted_memory *unaccepted;
> +       unsigned long flags, *bitmap;
>         bool ret = false;
> +       u64 unit_size;
>
> -       if (!boot_params.unaccepted_memory)
> +       if (efi.unaccepted == EFI_INVALID_TABLE_ADDR)
>                 return 0;
>
> -       bitmap = __va(boot_params.unaccepted_memory);
> +       unaccepted = __va(efi.unaccepted);
> +       unit_size = unaccepted->unit_size;
> +       bitmap = (unsigned long *)unaccepted->bitmap;
>
>         /*
>          * Also consider the unaccepted state of the *next* page. See fix #1 in
>          * the comment on load_unaligned_zeropad() in accept_memory().
>          */
> -       if (!(end % PMD_SIZE))
> -               end += PMD_SIZE;
> +       if (!(end % unit_size))
> +               end += unit_size;
>
>         spin_lock_irqsave(&unaccepted_memory_lock, flags);
>         while (start < end) {
> -               if (test_bit(start / PMD_SIZE, bitmap)) {
> +               if (test_bit(start / unit_size, bitmap)) {
>                         ret = true;
>                         break;
>                 }
>
> -               start += PMD_SIZE;
> +               start += unit_size;
>         }
>         spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 7dce06e419c5..e15a2005ed93 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -50,6 +50,9 @@ struct efi __read_mostly efi = {
>  #ifdef CONFIG_EFI_COCO_SECRET
>         .coco_secret            = EFI_INVALID_TABLE_ADDR,
>  #endif
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +       .unaccepted             = EFI_INVALID_TABLE_ADDR,
> +#endif
>  };
>  EXPORT_SYMBOL(efi);
>
> @@ -605,6 +608,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
>  #ifdef CONFIG_EFI_COCO_SECRET
>         {LINUX_EFI_COCO_SECRET_AREA_GUID,       &efi.coco_secret,       "CocoSecret"    },
>  #endif
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +       {LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID,   &efi.unaccepted,        "Unaccepted"    },
> +#endif
>  #ifdef CONFIG_EFI_GENERIC_STUB
>         {LINUX_EFI_SCREEN_INFO_TABLE_GUID,      &screen_info_table                      },
>  #endif
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 1afe7b5b02e1..4953b40f30c3 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -26,6 +26,7 @@ const efi_system_table_t *efi_system_table;
>  const efi_dxe_services_table_t *efi_dxe_table;
>  u32 image_offset __section(".data");
>  static efi_loaded_image_t *image = NULL;
> +struct efi_unaccepted_memory *unaccepted_table;
>
>  static efi_status_t
>  preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
> @@ -621,7 +622,7 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
>                                 continue;
>                         }
>                         e820_type = E820_TYPE_RAM;
> -                       process_unaccepted_memory(params, d->phys_addr,
> +                       process_unaccepted_memory(d->phys_addr,
>                                                   d->phys_addr + PAGE_SIZE * d->num_pages);
>                         break;
>                 default:
> @@ -692,12 +693,22 @@ static efi_status_t allocate_unaccepted_bitmap(struct boot_params *params,
>                                                __u32 nr_desc,
>                                                struct efi_boot_memmap *map)
>  {
> -       unsigned long *mem = NULL;
> -       u64 size, max_addr = 0;
> +       efi_guid_t unaccepted_table_guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
> +       u64 bitmap_size, max_addr = 0;
>         efi_status_t status;
>         bool found = false;
>         int i;
>
> +       /* Check if the table is already installed */
> +       unaccepted_table = get_efi_config_table(unaccepted_table_guid);
> +       if (unaccepted_table) {
> +               if (unaccepted_table->version != 0) {
> +                       efi_err("Unknown version of unaccepted memory tatble\n");
> +                       return EFI_UNSUPPORTED;
> +               }
> +               return EFI_SUCCESS;
> +       }
> +
>         /* Check if there's any unaccepted memory and find the max address */
>         for (i = 0; i < nr_desc; i++) {
>                 efi_memory_desc_t *d;
> @@ -710,11 +721,6 @@ static efi_status_t allocate_unaccepted_bitmap(struct boot_params *params,
>                         max_addr = d->phys_addr + d->num_pages * PAGE_SIZE;
>         }
>
> -       if (!found) {
> -               params->unaccepted_memory = 0;
> -               return EFI_SUCCESS;
> -       }
> -
>         /*
>          * range_contains_unaccepted_memory() may need to check one 2M chunk
>          * beyond the end of RAM to deal with load_unaligned_zeropad(). Make
> @@ -736,11 +742,26 @@ static efi_status_t allocate_unaccepted_bitmap(struct boot_params *params,
>          * The bitmap will be populated in setup_e820() according to the memory
>          * map after efi_exit_boot_services().
>          */
> -       size = DIV_ROUND_UP(max_addr, PMD_SIZE * BITS_PER_BYTE);
> -       status = efi_allocate_pages(size, (unsigned long *)&mem, ULONG_MAX);
> -       if (status == EFI_SUCCESS) {
> -               memset(mem, 0, size);
> -               params->unaccepted_memory = (unsigned long)mem;
> +       bitmap_size = DIV_ROUND_UP(max_addr, PMD_SIZE * BITS_PER_BYTE);
> +
> +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> +                            sizeof(*unaccepted_table) + bitmap_size,
> +                            (void **)&unaccepted_table);
> +       if (status != EFI_SUCCESS) {
> +               efi_err("Failed to allocate unaccepted memory config table\n");
> +               return status;
> +       }
> +
> +       unaccepted_table->version = 0;
> +       unaccepted_table->unit_size = PMD_SIZE;
> +       unaccepted_table->size = bitmap_size;
> +       memset(unaccepted_table->bitmap, 0, bitmap_size);
> +
> +       status = efi_bs_call(install_configuration_table,
> +                            &unaccepted_table_guid, unaccepted_table);
> +       if (status != EFI_SUCCESS) {
> +               efi_bs_call(free_pool, unaccepted_table);
> +               efi_err("Failed to install unaccepted memory config table!\n");
>         }
>
>         return status;
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index efbe14641638..f765266a81b3 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -418,6 +418,7 @@ void efi_native_runtime_setup(void);
>  #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID      EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
>  #define LINUX_EFI_COCO_SECRET_AREA_GUID                EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
>  #define LINUX_EFI_BOOT_MEMMAP_GUID             EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
> +#define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID    EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
>
>  #define RISCV_EFI_BOOT_PROTOCOL_GUID           EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
>
> @@ -535,6 +536,13 @@ struct efi_boot_memmap {
>         efi_memory_desc_t       map[];
>  };
>
> +struct efi_unaccepted_memory {
> +       u32 version;
> +       u32 unit_size;
> +       u64 size;
> +       u64 bitmap[];
> +};
> +
>  /*
>   * Architecture independent structure for describing a memory map for the
>   * benefit of efi_memmap_init_early(), and for passing context between
> @@ -637,6 +645,7 @@ extern struct efi {
>         unsigned long                   tpm_final_log;          /* TPM2 Final Events Log table */
>         unsigned long                   mokvar_table;           /* MOK variable config table */
>         unsigned long                   coco_secret;            /* Confidential computing secret table */
> +       unsigned long                   unaccepted;
>
>         efi_get_time_t                  *get_time;
>         efi_set_time_t                  *set_time;
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
