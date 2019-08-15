Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F30C8E5DA
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2019 09:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfHOH75 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Aug 2019 03:59:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37749 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbfHOH75 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Aug 2019 03:59:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so555850wmf.2
        for <linux-efi@vger.kernel.org>; Thu, 15 Aug 2019 00:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LV+82vFyg5z4e0teXoGTrMA+EjOg7t6iT9Oj6uw7yPM=;
        b=tfiL+28tRTegf7fQ7sw0mV4Q7P8lfpj9JtTYtDiukQnb9y9ne3Dulj9KdIlK22ZAse
         gDt8h/2J05cT9QkpVdi1ow/cuCaEj+8xchRXqxGgxFgjjcqlMgFEBst0g0ctnEKpr0Ir
         FZpmKJ67PEc+JUsTKgim6NKr8d5S5kAy50YXK6oZE6MhmU0c96bcvJ76Eg7mltpfW42l
         cavPZ9TxiOZfTdQ+noIZIlQkFFHkb6WyunatIqDRxlJYKhmIvBUOZ9QzY7F3fevEc/gO
         9LgACL3Rc2585SCCBxkbC2Q+B0xoIYQF2YrDkVI6uUg/Wr5AISvnu8bfCB+4esQgHkmB
         dhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LV+82vFyg5z4e0teXoGTrMA+EjOg7t6iT9Oj6uw7yPM=;
        b=gpwDM11gCwjKZxs2R4FDLynEiBJ9k1kF9xvJf/ks1Lxey2uamMy0CWfQ2LGNvI6/o7
         dT7qe6YCuUpaTjBAVdM0hssB+EpvXE58hUxVtIueRp1ZszPyPuBxR8MvF3alg+XpEFNg
         7BiNAUgs4NgdTOauIQKudcjDK0RP/t18kOmTbTRlxVQ/aBdZZUg1bdMZGJ9adOSsBpUf
         GW/mElbZgwVpHwiBzyeTqu2AEFDvIJN5oK0I6hKPMCcgnuX5nd4DWGmLlkF9Zcv4uIaL
         7xrXC3mDmd/+kuXieSAd1okJDYoUkpJdFgwWFGcesOcPrsENsp1hFcKO6te978abPSni
         zwAQ==
X-Gm-Message-State: APjAAAW/x3sU59urIAGJ63/SdIhEq4VWdj8IKZ8UIitwZEQttQmc8t5t
        l7H2sa0ySge1m1youKfHIcR5ofENj2Q3Dwu75NoSqA==
X-Google-Smtp-Source: APXvYqzLBo2ZOv7jKXJbwzGfJsuorr2WgUfx00oSBYoGRBY8/25lsdYDc63+RPT0JXJUAv73T+AXPvsi+IkUVg6LoYQ=
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr1429804wma.53.1565855995011;
 Thu, 15 Aug 2019 00:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190802053744.5519-1-clin@suse.com> <CAKv+Gu-yaNYsLQOOcr8srW91-nt-w0e+RBqxXGOagiGGT69n1Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu-yaNYsLQOOcr8srW91-nt-w0e+RBqxXGOagiGGT69n1Q@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 15 Aug 2019 10:59:43 +0300
Message-ID: <CAKv+Gu8uwbY-JtjNbgoyY230X_M6xLchVM3OUg_oNWOJrF=iCg@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: fix allocation failure when reserving the kernel base
To:     Chester Lin <clin@suse.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        Juergen Gross <JGross@suse.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        Joey Lee <JLee@suse.com>, Gary Lin <GLin@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 4 Aug 2019 at 10:57, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> Hello Chester,
>
> On Fri, 2 Aug 2019 at 08:40, Chester Lin <clin@suse.com> wrote:
> >
> > In some cases the arm32 efistub could fail to allocate memory for
> > uncompressed kernel. For example, we got the following error message when
> > verifying EFI stub on Raspberry Pi-2 [kernel-5.2.1 + grub-2.04] :
> >
> >   EFI stub: Booting Linux Kernel...
> >   EFI stub: ERROR: Unable to allocate memory for uncompressed kernel.
> >   EFI stub: ERROR: Failed to relocate kernel
> >
> > After checking the EFI memory map we found that the first page [0 - 0xfff]
> > had been reserved by Raspberry Pi-2's firmware, and the efistub tried to
> > set the dram base at 0, which was actually in a reserved region.
> >
>
> This by itself is a violation of the Linux boot protocol for 32-bit
> ARM when using the decompressor. The decompressor rounds down its own
> base address to a multiple of 128 MB, and assumes the whole area is
> available for the decompressed kernel and related data structures.
> (The first TEXT_OFFSET bytes are no longer used in practice, which is
> why putting a reserved region of 4 KB bytes works at the moment, but
> this is fragile). Note that the decompressor does not look at any DT
> or EFI provided memory maps *at all*.
>
> So unfortunately, this is not something we can fix in the kernel, but
> we should fix it in the bootloader or in GRUB, so it does not put any
> reserved regions in the first 128 MB of memory,
>

OK, perhaps we can fix this by taking TEXT_OFFSET into account. The
ARM boot protocol docs are unclear about whether this memory should be
used or not, but it is no longer used for its original purpose (page
tables), and the RPi loader already keeps data there.

Can you check whether the following patch works for you?

diff --git a/drivers/firmware/efi/libstub/Makefile
b/drivers/firmware/efi/libstub/Makefile
index 0460c7581220..ee0661ddb25b 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -52,6 +52,7 @@ lib-$(CONFIG_EFI_ARMSTUB)     += arm-stub.o fdt.o
string.o random.o \

 lib-$(CONFIG_ARM)              += arm32-stub.o
 lib-$(CONFIG_ARM64)            += arm64-stub.o
+CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)

 #
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c
b/drivers/firmware/efi/libstub/arm32-stub.c
index e8f7aefb6813..66ff0c8ec269 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -204,7 +204,7 @@ efi_status_t
handle_kernel_image(efi_system_table_t *sys_table,
         * loaded. These assumptions are made by the decompressor,
         * before any memory map is available.
         */
-       dram_base = round_up(dram_base, SZ_128M);
+       dram_base = round_up(dram_base, SZ_128M) + TEXT_OFFSET;

        status = reserve_kernel_base(sys_table, dram_base, reserve_addr,
                                     reserve_size);

>
> >   grub> lsefimmap
> >   Type      Physical start  - end             #Pages        Size Attributes
> >   reserved  0000000000000000-0000000000000fff 00000001      4KiB WB
> >   conv-mem  0000000000001000-0000000007ef5fff 00007ef5 130004KiB WB
> >   RT-data   0000000007ef6000-0000000007f09fff 00000014     80KiB RT WB
> >   conv-mem  0000000007f0a000-000000002d871fff 00025968 615840KiB WB
> >   .....
> >
> > To avoid a reserved address, we have to ignore the memory regions which are
> > marked as EFI_RESERVED_TYPE, and only conventional memory regions can be
> > chosen. If the region before the kernel base is unaligned, it will be
> > marked as EFI_RESERVED_TYPE and let kernel ignore it so that memblock_limit
> > will not be sticked with a very low address such as 0x1000.
> >

This is a separate issue, so it should be handled in a separate patch.

> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  arch/arm/mm/mmu.c                         |  3 ++
> >  drivers/firmware/efi/libstub/arm32-stub.c | 43 ++++++++++++++++++-----
> >  2 files changed, 37 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index f3ce34113f89..909b11ba48d8 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -1184,6 +1184,9 @@ void __init adjust_lowmem_bounds(void)
> >                 phys_addr_t block_start = reg->base;
> >                 phys_addr_t block_end = reg->base + reg->size;
> >
> > +               if (memblock_is_nomap(reg))
> > +                       continue;
> > +
> >                 if (reg->base < vmalloc_limit) {
> >                         if (block_end > lowmem_limit)
> >                                 /*
> > diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
> > index e8f7aefb6813..10d33d36df00 100644
> > --- a/drivers/firmware/efi/libstub/arm32-stub.c
> > +++ b/drivers/firmware/efi/libstub/arm32-stub.c
> > @@ -128,7 +128,7 @@ static efi_status_t reserve_kernel_base(efi_system_table_t *sys_table_arg,
> >
> >         for (l = 0; l < map_size; l += desc_size) {
> >                 efi_memory_desc_t *desc;
> > -               u64 start, end;
> > +               u64 start, end, spare, kernel_base;
> >
> >                 desc = (void *)memory_map + l;
> >                 start = desc->phys_addr;
> > @@ -144,27 +144,52 @@ static efi_status_t reserve_kernel_base(efi_system_table_t *sys_table_arg,
> >                 case EFI_BOOT_SERVICES_DATA:
> >                         /* Ignore types that are released to the OS anyway */
> >                         continue;
> > -
> > +               case EFI_RESERVED_TYPE:
> > +                       /* Ignore reserved regions */
> > +                       continue;
> >                 case EFI_CONVENTIONAL_MEMORY:
> >                         /*
> >                          * Reserve the intersection between this entry and the
> >                          * region.
> >                          */
> >                         start = max(start, (u64)dram_base);
> > -                       end = min(end, (u64)dram_base + MAX_UNCOMP_KERNEL_SIZE);
> > +                       kernel_base = round_up(start, PMD_SIZE);
> > +                       spare = kernel_base - start;
> > +                       end = min(end, kernel_base + MAX_UNCOMP_KERNEL_SIZE);
> > +
> > +                       status = efi_call_early(allocate_pages,
> > +                                       EFI_ALLOCATE_ADDRESS,
> > +                                       EFI_LOADER_DATA,
> > +                                       MAX_UNCOMP_KERNEL_SIZE / EFI_PAGE_SIZE,
> > +                                       &kernel_base);
> > +                       if (status != EFI_SUCCESS) {
> > +                               pr_efi_err(sys_table_arg,
> > +                                       "reserve_kernel_base: alloc failed.\n");
> > +                               goto out;
> > +                       }
> > +                       *reserve_addr = kernel_base;
> >
> > +                       if (!spare)
> > +                               break;
> > +                       /*
> > +                        * If there's a gap between start and kernel_base,
> > +                        * it needs be reserved so that the memblock_limit
> > +                        * will not fall on a very low address when running
> > +                        * adjust_lowmem_bounds(), wchich could eventually
> > +                        * cause CMA reservation issue.
> > +                        */
> >                         status = efi_call_early(allocate_pages,
> >                                                 EFI_ALLOCATE_ADDRESS,
> > -                                               EFI_LOADER_DATA,
> > -                                               (end - start) / EFI_PAGE_SIZE,
> > +                                               EFI_RESERVED_TYPE,
> > +                                               spare / EFI_PAGE_SIZE,
> >                                                 &start);
> >                         if (status != EFI_SUCCESS) {
> >                                 pr_efi_err(sys_table_arg,
> > -                                       "reserve_kernel_base(): alloc failed.\n");
> > +                                       "reserve spare-region failed\n");
> >                                 goto out;
> >                         }
> > -                       break;
> >
> > +                       break;
> >                 case EFI_LOADER_CODE:
> >                 case EFI_LOADER_DATA:
> >                         /*
> > @@ -220,7 +245,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
> >         *image_size = image->image_size;
> >         status = efi_relocate_kernel(sys_table, image_addr, *image_size,
> >                                      *image_size,
> > -                                    dram_base + MAX_UNCOMP_KERNEL_SIZE, 0);
> > +                                    *reserve_addr + MAX_UNCOMP_KERNEL_SIZE, 0);
> >         if (status != EFI_SUCCESS) {
> >                 pr_efi_err(sys_table, "Failed to relocate kernel.\n");
> >                 efi_free(sys_table, *reserve_size, *reserve_addr);
> > @@ -233,7 +258,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
> >          * in memory. The kernel determines the base of DRAM from the
> >          * address at which the zImage is loaded.
> >          */
> > -       if (*image_addr + *image_size > dram_base + ZIMAGE_OFFSET_LIMIT) {
> > +       if (*image_addr + *image_size > *reserve_addr + ZIMAGE_OFFSET_LIMIT) {
> >                 pr_efi_err(sys_table, "Failed to relocate kernel, no low memory available.\n");
> >                 efi_free(sys_table, *reserve_size, *reserve_addr);
> >                 *reserve_size = 0;
> > --
> > 2.22.0
> >
