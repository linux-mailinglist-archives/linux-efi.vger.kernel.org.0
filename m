Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDFE8EA59
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2019 13:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfHOLdG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Aug 2019 07:33:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36768 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbfHOLdG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Aug 2019 07:33:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so996832wme.1
        for <linux-efi@vger.kernel.org>; Thu, 15 Aug 2019 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4TfjyGxufGf0FtghnaQnBzQMHXr/pk4Qyrt6eBQkcI=;
        b=MP1794phXQvZTu9a0KyLtHnX7MXRHe5U29KVsNcUfvowuJo4pVtHA9RZ8dOKnLz00b
         L2W2IsPDdCEVli7QHemdMbKaz3Yx5ZfpqTK5ifJ6+G5uCj8ogx3Vwk2O9idvd3csh5iT
         ClH3HLkXaStj+qGT+6ESY7o2oa9PueBzFFWwefjxjVq6o+8jfokdlTTNaWER72CcTQjD
         KQI0lHs15WDnK7PHLRKCdF1bQvQL4WoVTxn3F8Q3kFlAlRu2lzq2v8t1THxAsnTKfXZJ
         pGGgHT+P+PNgW3LZ8Hckfv0koYrathAEtslEqx4+haDE1GeOvbV9CafSCO9BL+DES7eH
         JXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4TfjyGxufGf0FtghnaQnBzQMHXr/pk4Qyrt6eBQkcI=;
        b=Cw0RuSc5LLQcXhxgw2xA+Z9FKziBFk3K2pQ0WTOZBeMQHoMtpM/vs+0bANggzDT1gW
         T4Y3rLUS53MkNsKBb9geCSNExbmg14E+g6vxCty6xntySPAtdHU92ZfPfGrGLewSaoX3
         irAUfZqBpC7y9Zzkg7btA2Pf4/Jpv+Qrkz1Ql6o/GXLhl71QNyf1kxOXbL8StX/spmsW
         DMr1ncO6ic6pFqGpve1hBrK6uHPwCu9+J9lxwtO3n4SL6bX/2sTYHtHIlqlJaFHWIaMr
         6f84dDGnXMiGp3Dkh/fgHkVu98XqcIFJV9l0sC8ibjblX964sudj2Xmzi1NzC7WnW08p
         FUNg==
X-Gm-Message-State: APjAAAV4/m/rIfmRzJRPvmqb1gGKSMwpCyBxJI5JlYgsErMmDW0g9fBL
        mLQxhIwjmBPX6j9zPZXwCXxz6Jq1yvFYWSVBXSpfiA==
X-Google-Smtp-Source: APXvYqxjs8Jr9JMDmzuCHHS6WN6uMOWSEFtnu2iqYQX2ClToWSYmowYDaX7RzY/jXDbB7FLyHizp0g7Y2ZoG8N7A51E=
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr2267705wmm.119.1565868782081;
 Thu, 15 Aug 2019 04:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190802053744.5519-1-clin@suse.com> <CAKv+Gu-yaNYsLQOOcr8srW91-nt-w0e+RBqxXGOagiGGT69n1Q@mail.gmail.com>
 <CAKv+Gu8uwbY-JtjNbgoyY230X_M6xLchVM3OUg_oNWOJrF=iCg@mail.gmail.com> <20190815111543.GA4728@linux-8mug>
In-Reply-To: <20190815111543.GA4728@linux-8mug>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 15 Aug 2019 14:32:50 +0300
Message-ID: <CAKv+Gu-5M-4=SbOzbqbLUYnfFw29vhfcrVD=N9j_APYpKjq2wQ@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: fix allocation failure when reserving the kernel base
To:     Chester Lin <clin@suse.com>, Mike Rapoport <rppt@linux.ibm.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Gary Lin <GLin@suse.com>,
        Juergen Gross <JGross@suse.com>, Joey Lee <JLee@suse.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(adding Mike)

On Thu, 15 Aug 2019 at 14:28, Chester Lin <clin@suse.com> wrote:
>
> Hi Ard,
>
> On Thu, Aug 15, 2019 at 10:59:43AM +0300, Ard Biesheuvel wrote:
> > On Sun, 4 Aug 2019 at 10:57, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > Hello Chester,
> > >
> > > On Fri, 2 Aug 2019 at 08:40, Chester Lin <clin@suse.com> wrote:
> > > >
> > > > In some cases the arm32 efistub could fail to allocate memory for
> > > > uncompressed kernel. For example, we got the following error message when
> > > > verifying EFI stub on Raspberry Pi-2 [kernel-5.2.1 + grub-2.04] :
> > > >
> > > >   EFI stub: Booting Linux Kernel...
> > > >   EFI stub: ERROR: Unable to allocate memory for uncompressed kernel.
> > > >   EFI stub: ERROR: Failed to relocate kernel
> > > >
> > > > After checking the EFI memory map we found that the first page [0 - 0xfff]
> > > > had been reserved by Raspberry Pi-2's firmware, and the efistub tried to
> > > > set the dram base at 0, which was actually in a reserved region.
> > > >
> > >
> > > This by itself is a violation of the Linux boot protocol for 32-bit
> > > ARM when using the decompressor. The decompressor rounds down its own
> > > base address to a multiple of 128 MB, and assumes the whole area is
> > > available for the decompressed kernel and related data structures.
> > > (The first TEXT_OFFSET bytes are no longer used in practice, which is
> > > why putting a reserved region of 4 KB bytes works at the moment, but
> > > this is fragile). Note that the decompressor does not look at any DT
> > > or EFI provided memory maps *at all*.
> > >
> > > So unfortunately, this is not something we can fix in the kernel, but
> > > we should fix it in the bootloader or in GRUB, so it does not put any
> > > reserved regions in the first 128 MB of memory,
> > >
> >
> > OK, perhaps we can fix this by taking TEXT_OFFSET into account. The
> > ARM boot protocol docs are unclear about whether this memory should be
> > used or not, but it is no longer used for its original purpose (page
> > tables), and the RPi loader already keeps data there.
> >
> > Can you check whether the following patch works for you?
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile
> > b/drivers/firmware/efi/libstub/Makefile
> > index 0460c7581220..ee0661ddb25b 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -52,6 +52,7 @@ lib-$(CONFIG_EFI_ARMSTUB)     += arm-stub.o fdt.o
> > string.o random.o \
> >
> >  lib-$(CONFIG_ARM)              += arm32-stub.o
> >  lib-$(CONFIG_ARM64)            += arm64-stub.o
> > +CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> >  CFLAGS_arm64-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> >
> >  #
> > diff --git a/drivers/firmware/efi/libstub/arm32-stub.c
> > b/drivers/firmware/efi/libstub/arm32-stub.c
> > index e8f7aefb6813..66ff0c8ec269 100644
> > --- a/drivers/firmware/efi/libstub/arm32-stub.c
> > +++ b/drivers/firmware/efi/libstub/arm32-stub.c
> > @@ -204,7 +204,7 @@ efi_status_t
> > handle_kernel_image(efi_system_table_t *sys_table,
> >          * loaded. These assumptions are made by the decompressor,
> >          * before any memory map is available.
> >          */
> > -       dram_base = round_up(dram_base, SZ_128M);
> > +       dram_base = round_up(dram_base, SZ_128M) + TEXT_OFFSET;
> >
> >         status = reserve_kernel_base(sys_table, dram_base, reserve_addr,
> >                                      reserve_size);
> >
>
> I tried your patch on rpi2 and got the following panic. Just a reminder that I
> have replaced some log messages with "......" since it might be too long to
> post all.
>

OK. Good to know that this change helps you to get past the EFI stub boot issue.

> In this case the kernel failed to reserve cma, which should hit the issue of
> memblock_limit=0x1000 as I had mentioned in my patch description. The first
> block [0-0xfff] was scanned in adjust_lowmem_bounds(), but it did not align
> with PMD_SIZE so the cma reservation failed because the memblock.current_limit
> was extremely low. That's why I expand the first reservation from 1 PAGESIZE to
> 1 PMD_SIZE in my patch in order to avoid this issue. Please kindly let me know
> if any suggestion, thank you.
>

This looks like it is a separate issue. The memblock/cma code should
not choke on a reserved page of memory at 0x0.

Perhaps Russell or Mike (cc'ed) have an idea how to address this?



> boot-log:
> --------
>
> Loading Linux test ...
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0xf00
> [    0.000000] Linux version 5.2.1-lpae (chester@linux-8mug) (......)
> [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=30c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt: Machine model: Raspberry Pi 2 Model B Rev 1.1
> [    0.000000] printk: bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi:   System Table: 0x000000003df757c0
> [    0.000000] efi:   MemMap Address: 0x000000002c1c5040
> [    0.000000] efi:   MemMap Size: 0x000003c0
> [    0.000000] efi:   MemMap Desc. Size: 0x00000028
> [    0.000000] efi:   MemMap Desc. Version: 0x00000001
> [    0.000000] efi: EFI v2.70 by Das U-Boot
> [    0.000000] efi:  SMBIOS=0x3cb62000  MEMRESERVE=0x3cb3d040
> [    0.000000] memblock_reserve: [0x000000003cb3d040-0x000000003cb3d04f] efi_config_parse_tables+0x25c/0x2d8
> [    0.000000] efi: Processing EFI memory map:
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x000000003e000000 reserved size = 0x0000000000000010
> [    0.000000]  memory.cnt  = 0x1
> [    0.000000]  memory[0x0]     [0x0000000000000000-0x000000003dffffff], 0x000000003e000000 bytes flags: 0x0
> [    0.000000]  reserved.cnt  = 0x1
> [    0.000000]  reserved[0x0]   [0x000000003cb3d040-0x000000003cb3d04f], 0x0000000000000010 bytes flags: 0x0
> [    0.000000] memblock_remove: [0x0000000000000000-0xfffffffffffffffe] reserve_regions+0x68/0x23c
> [    0.000000] efi:   0x000000000000-0x000000000fff [Reserved           |   |  |  |  |  |  |  |   |WB|  |  |  ]
> [    0.000000] memblock_add: [0x0000000000000000-0x0000000000000fff] early_init_dt_add_memory_arch+0x164/0x178
> [    0.000000] efi:   0x000000001000-0x000000307fff [Conventional Memory|   |  |  |  |  |  |  |   |WB|  |  |  ]
> [    0.000000] memblock_add: [0x0000000000001000-0x0000000000307fff] early_init_dt_add_memory_arch+0x164/0x178
> [    0.000000] efi:   0x000000308000-0x000002307fff [Boot Data          |   |  |  |  |  |  |  |   |WB|  |  |  ]
> [    0.000000] memblock_add: [0x0000000000308000-0x0000000002307fff] early_init_dt_add_memory_arch+0x164/0x178
> [    0.000000] efi:   0x000002308000-0x000002a93fff [Loader Data        |   |  |  |  |  |  |  |   |WB|  |  |  ]
> [    0.000000] memblock_add: [0x0000000002308000-0x0000000002a93fff] early_init_dt_add_memory_arch+0x164/0x178
> [    0.000000] efi:   0x000002a94000-0x000007cf5fff [Conventional Memory|   |  |  |  |  |  |  |   |WB|  |  |  ]
> [    0.000000] memblock_add: [0x0000000002a94000-0x0000000007cf5fff] early_init_dt_add_memory_arch+0x164/0x178
> ......
> ......
> [    0.000000] memblock_add: [0x000000003df76000-0x000000003dffffff] early_init_dt_add_memory_arch+0x164/0x178
> [    0.000000] efi:   0x00003f100000-0x00003f100fff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |  ]
> [    0.000000] memblock_reserve: [0x000000002c1c5000-0x000000002c1c5fff] efi_init+0xd8/0x1c8
> [    0.000000] memblock_reserve: [0x0000000000400000-0x0000000001df2cef] arm_memblock_init+0x44/0x19c
> [    0.000000] memblock_reserve: [0x0000000000303000-0x0000000000307fff] arm_mm_memblock_reserve+0x30/0x38
> [    0.000000] memblock_reserve: [0x0000000007cf6000-0x0000000007cfc5c4] early_init_dt_reserve_memory_arch+0x2c/0x30
> [    0.000000] cma: Failed to reserve 64 MiB
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x000000003e000000 reserved size = 0x00000000019ff2c5
> [    0.000000]  memory.cnt  = 0xa
> [    0.000000]  memory[0x0]     [0x0000000000000000-0x0000000000000fff], 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0x1]     [0x0000000000001000-0x0000000007ef5fff], 0x0000000007ef5000 bytes flags: 0x0
> [    0.000000]  memory[0x2]     [0x0000000007ef6000-0x0000000007f09fff], 0x0000000000014000 bytes flags: 0x4
> [    0.000000]  memory[0x3]     [0x0000000007f0a000-0x000000003cb3efff], 0x0000000034c35000 bytes flags: 0x0
> [    0.000000]  memory[0x4]     [0x000000003cb3f000-0x000000003cb3ffff], 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0x5]     [0x000000003cb40000-0x000000003cb5ffff], 0x0000000000020000 bytes flags: 0x0
> [    0.000000]  memory[0x6]     [0x000000003cb60000-0x000000003cb68fff], 0x0000000000009000 bytes flags: 0x4
> [    0.000000]  memory[0x7]     [0x000000003cb69000-0x000000003df74fff], 0x000000000140c000 bytes flags: 0x0
> [    0.000000]  memory[0x8]     [0x000000003df75000-0x000000003df75fff], 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0x9]     [0x000000003df76000-0x000000003dffffff], 0x000000000008a000 bytes flags: 0x0
> [    0.000000]  reserved.cnt  = 0x5
> [    0.000000]  reserved[0x0]   [0x0000000000303000-0x0000000000307fff], 0x0000000000005000 bytes flags: 0x0
> [    0.000000]  reserved[0x1]   [0x0000000000400000-0x0000000001df2cef], 0x00000000019f2cf0 bytes flags: 0x0
> [    0.000000]  reserved[0x2]   [0x0000000007cf6000-0x0000000007cfc5c4], 0x00000000000065c5 bytes flags: 0x0
> [    0.000000]  reserved[0x3]   [0x000000002c1c5000-0x000000002c1c5fff], 0x0000000000001000 bytes flags: 0x0
> [    0.000000]  reserved[0x4]   [0x000000003cb3d040-0x000000003cb3d04f], 0x0000000000000010 bytes flags: 0x0
> [    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 early_alloc+0x44/0x70
> [    0.000000] Kernel panic - not syncing: early_alloc: Failed to allocate 4096 bytes align=0x1000
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.2.1-lpae #1 openSUSE Tumbleweed (unreleased)
> [    0.000000] Hardware name: BCM2835
> [    0.000000] Backtrace:
> [    0.000000] [<c043fafc>] (dump_backtrace) from [<c043fd84>] (show_stack+0x20/0x24)
> [    0.000000]  r7:c1800000 r6:00000000 r5:600001d3 r4:c1901ba0
> [    0.000000] [<c043fd64>] (show_stack) from [<c0df9400>] (dump_stack+0xd0/0x104)
> [    0.000000] [<c0df9330>] (dump_stack) from [<c048061c>] (panic+0xf8/0x32c)
> [    0.000000]  r10:c0307000 r9:c0001000 r8:00000003 r7:00000000 r6:00000000 r5:c181df04
> [    0.000000]  r4:c192b8d8 r3:00000001
> [    0.000000] [<c0480528>] (panic) from [<c1609728>] (early_alloc+0x60/0x70)
> [    0.000000]  r3:00001000 r2:00001000 r1:c10037e8 r0:c12fe64c
> [    0.000000]  r7:00000000
> [    0.000000] [<c16096c8>] (early_alloc) from [<c1609114>] (arm_pte_alloc+0x34/0x94)
> [    0.000000]  r7:00000000 r6:00000000 r4:c0307000
> [    0.000000] [<c16090e0>] (arm_pte_alloc) from [<c1609384>] (__create_mapping+0x210/0x2c0)
> [    0.000000]  r9:c0001000 r8:c0001000 r7:00000001 r6:c13f22e0 r5:c0200000 r4:c0400000
> [    0.000000] [<c1609174>] (__create_mapping) from [<c160951c>] (create_mapping+0xe8/0x108)
> [    0.000000]  r10:c0400000 r9:c16a2110 r8:c19c7a80 r7:00000000 r6:00400000 r5:c13f2000
> [    0.000000]  r4:c1801ef0
> [    0.000000] [<c1609434>] (create_mapping) from [<c1609f50>] (paging_init+0x350/0x75c)
> [    0.000000]  r4:c1842d40
>
>
> > >
> > > >   grub> lsefimmap
> > > >   Type      Physical start  - end             #Pages        Size Attributes
> > > >   reserved  0000000000000000-0000000000000fff 00000001      4KiB WB
> > > >   conv-mem  0000000000001000-0000000007ef5fff 00007ef5 130004KiB WB
> > > >   RT-data   0000000007ef6000-0000000007f09fff 00000014     80KiB RT WB
> > > >   conv-mem  0000000007f0a000-000000002d871fff 00025968 615840KiB WB
> > > >   .....
> > > >
> > > > To avoid a reserved address, we have to ignore the memory regions which are
> > > > marked as EFI_RESERVED_TYPE, and only conventional memory regions can be
> > > > chosen. If the region before the kernel base is unaligned, it will be
> > > > marked as EFI_RESERVED_TYPE and let kernel ignore it so that memblock_limit
> > > > will not be sticked with a very low address such as 0x1000.
> > > >
> >
> > This is a separate issue, so it should be handled in a separate patch.
> >
> > > > Signed-off-by: Chester Lin <clin@suse.com>
> > > > ---
> > > >  arch/arm/mm/mmu.c                         |  3 ++
> > > >  drivers/firmware/efi/libstub/arm32-stub.c | 43 ++++++++++++++++++-----
> > > >  2 files changed, 37 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > > index f3ce34113f89..909b11ba48d8 100644
> > > > --- a/arch/arm/mm/mmu.c
> > > > +++ b/arch/arm/mm/mmu.c
> > > > @@ -1184,6 +1184,9 @@ void __init adjust_lowmem_bounds(void)
> > > >                 phys_addr_t block_start = reg->base;
> > > >                 phys_addr_t block_end = reg->base + reg->size;
> > > >
> > > > +               if (memblock_is_nomap(reg))
> > > > +                       continue;
> > > > +
> > > >                 if (reg->base < vmalloc_limit) {
> > > >                         if (block_end > lowmem_limit)
> > > >                                 /*
> > > > diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
> > > > index e8f7aefb6813..10d33d36df00 100644
> > > > --- a/drivers/firmware/efi/libstub/arm32-stub.c
> > > > +++ b/drivers/firmware/efi/libstub/arm32-stub.c
> > > > @@ -128,7 +128,7 @@ static efi_status_t reserve_kernel_base(efi_system_table_t *sys_table_arg,
> > > >
> > > >         for (l = 0; l < map_size; l += desc_size) {
> > > >                 efi_memory_desc_t *desc;
> > > > -               u64 start, end;
> > > > +               u64 start, end, spare, kernel_base;
> > > >
> > > >                 desc = (void *)memory_map + l;
> > > >                 start = desc->phys_addr;
> > > > @@ -144,27 +144,52 @@ static efi_status_t reserve_kernel_base(efi_system_table_t *sys_table_arg,
> > > >                 case EFI_BOOT_SERVICES_DATA:
> > > >                         /* Ignore types that are released to the OS anyway */
> > > >                         continue;
> > > > -
> > > > +               case EFI_RESERVED_TYPE:
> > > > +                       /* Ignore reserved regions */
> > > > +                       continue;
> > > >                 case EFI_CONVENTIONAL_MEMORY:
> > > >                         /*
> > > >                          * Reserve the intersection between this entry and the
> > > >                          * region.
> > > >                          */
> > > >                         start = max(start, (u64)dram_base);
> > > > -                       end = min(end, (u64)dram_base + MAX_UNCOMP_KERNEL_SIZE);
> > > > +                       kernel_base = round_up(start, PMD_SIZE);
> > > > +                       spare = kernel_base - start;
> > > > +                       end = min(end, kernel_base + MAX_UNCOMP_KERNEL_SIZE);
> > > > +
> > > > +                       status = efi_call_early(allocate_pages,
> > > > +                                       EFI_ALLOCATE_ADDRESS,
> > > > +                                       EFI_LOADER_DATA,
> > > > +                                       MAX_UNCOMP_KERNEL_SIZE / EFI_PAGE_SIZE,
> > > > +                                       &kernel_base);
> > > > +                       if (status != EFI_SUCCESS) {
> > > > +                               pr_efi_err(sys_table_arg,
> > > > +                                       "reserve_kernel_base: alloc failed.\n");
> > > > +                               goto out;
> > > > +                       }
> > > > +                       *reserve_addr = kernel_base;
> > > >
> > > > +                       if (!spare)
> > > > +                               break;
> > > > +                       /*
> > > > +                        * If there's a gap between start and kernel_base,
> > > > +                        * it needs be reserved so that the memblock_limit
> > > > +                        * will not fall on a very low address when running
> > > > +                        * adjust_lowmem_bounds(), wchich could eventually
> > > > +                        * cause CMA reservation issue.
> > > > +                        */
> > > >                         status = efi_call_early(allocate_pages,
> > > >                                                 EFI_ALLOCATE_ADDRESS,
> > > > -                                               EFI_LOADER_DATA,
> > > > -                                               (end - start) / EFI_PAGE_SIZE,
> > > > +                                               EFI_RESERVED_TYPE,
> > > > +                                               spare / EFI_PAGE_SIZE,
> > > >                                                 &start);
> > > >                         if (status != EFI_SUCCESS) {
> > > >                                 pr_efi_err(sys_table_arg,
> > > > -                                       "reserve_kernel_base(): alloc failed.\n");
> > > > +                                       "reserve spare-region failed\n");
> > > >                                 goto out;
> > > >                         }
> > > > -                       break;
> > > >
> > > > +                       break;
> > > >                 case EFI_LOADER_CODE:
> > > >                 case EFI_LOADER_DATA:
> > > >                         /*
> > > > @@ -220,7 +245,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
> > > >         *image_size = image->image_size;
> > > >         status = efi_relocate_kernel(sys_table, image_addr, *image_size,
> > > >                                      *image_size,
> > > > -                                    dram_base + MAX_UNCOMP_KERNEL_SIZE, 0);
> > > > +                                    *reserve_addr + MAX_UNCOMP_KERNEL_SIZE, 0);
> > > >         if (status != EFI_SUCCESS) {
> > > >                 pr_efi_err(sys_table, "Failed to relocate kernel.\n");
> > > >                 efi_free(sys_table, *reserve_size, *reserve_addr);
> > > > @@ -233,7 +258,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
> > > >          * in memory. The kernel determines the base of DRAM from the
> > > >          * address at which the zImage is loaded.
> > > >          */
> > > > -       if (*image_addr + *image_size > dram_base + ZIMAGE_OFFSET_LIMIT) {
> > > > +       if (*image_addr + *image_size > *reserve_addr + ZIMAGE_OFFSET_LIMIT) {
> > > >                 pr_efi_err(sys_table, "Failed to relocate kernel, no low memory available.\n");
> > > >                 efi_free(sys_table, *reserve_size, *reserve_addr);
> > > >                 *reserve_size = 0;
> > > > --
> > > > 2.22.0
> > > >
> >
