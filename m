Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1DD10D7E5
	for <lists+linux-efi@lfdr.de>; Fri, 29 Nov 2019 16:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfK2Pco (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Nov 2019 10:32:44 -0500
Received: from heinz.dinsnail.net ([81.169.187.250]:51282 "EHLO
        heinz.dinsnail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfK2Pco (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Nov 2019 10:32:44 -0500
Received: from heinz.dinsnail.net ([IPv6:0:0:0:0:0:0:0:1])
        by heinz.dinsnail.net (8.15.2/8.15.2) with ESMTP id xATFUA2v016367;
        Fri, 29 Nov 2019 16:30:10 +0100
Received: from eldalonde.UUCP (uucp@localhost)
        by heinz.dinsnail.net (8.15.2/8.15.2/Submit) with bsmtp id xATFU6CW016366;
        Fri, 29 Nov 2019 16:30:06 +0100
Received: from eldalonde.weiser.dinsnail.net (localhost [IPv6:0:0:0:0:0:0:0:1])
        by eldalonde.weiser.dinsnail.net (8.15.2/8.15.2) with ESMTP id xATFR0fe012378;
        Fri, 29 Nov 2019 16:27:00 +0100
Received: (from michael@localhost)
        by eldalonde.weiser.dinsnail.net (8.15.2/8.15.2/Submit) id xATFR0xb012377;
        Fri, 29 Nov 2019 16:27:00 +0100
Date:   Fri, 29 Nov 2019 16:27:00 +0100
From:   Michael Weiser <michael@weiser.dinsnail.net>
To:     Dave Young <dyoung@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-efi@vger.kernel.org, kexec@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: kexec_file overwrites reserved EFI ESRT memory
Message-ID: <20191129152700.GA8286@weiser.dinsnail.net>
References: <20191122180552.GA32104@weiser.dinsnail.net>
 <87blt3y949.fsf@x220.int.ebiederm.org>
 <20191122210702.GE32104@weiser.dinsnail.net>
 <20191125055201.GA6569@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125055201.GA6569@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-dinsnail-net-MailScanner-Information: Please contact the ISP for more information
X-dinsnail-net-MailScanner-ID: xATFUA2v016367
X-dinsnail-net-MailScanner: Found to be clean
X-dinsnail-net-MailScanner-From: michael@weiser.dinsnail.net
X-Spam-Status: No
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Dave,

On Mon, Nov 25, 2019 at 01:52:01PM +0800, Dave Young wrote:

> > > Fundamentally when deciding where to place a new kernel kexec (either
> > > user space or the in kernel kexec_file implementation) needs to be able
> > > to ask the question which memory ares are reserved.
[...]
> > > So my question is why doesn't the ESRT reservation wind up in
> > > /proc/iomem?
> > 
> > My guess is that the focus was that some EFI structures need to be kept
> > around accross the life cycle of *one* running kernel and
> > memblock_reserve() was enough for that. Marking them so they survive
> > kexecing another kernel might just never have cropped up thus far. Ard
> > or Matt would know.
> Can you check your un-reserved memory, if your memory falls into EFI
> BOOT* then in X86 you can use something like below if it is not covered:

> void __init efi_esrt_init(void)
> {
> ...
> 	pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &end);
> 	if (md.type == EFI_BOOT_SERVICES_DATA)
> 		efi_mem_reserve(esrt_data, esrt_data_size);
> ...
> }

Please bear with me if I'm a bit slow on the uptake here: On my machine,
the esrt module reports at boot:

[    0.001244] esrt: Reserving ESRT space from 0x0000000074dd2f98 to 0x0000000074dd2fd0.

This area is of type "Boot Data" (== BOOT_SERVICES_DATA) which makes the
code you quote reserve it using memblock_reserve() shown by
memblock=debug:

[    0.001246] memblock_reserve: [0x0000000074dd2f98-0x0000000074dd2fcf] efi_mem_reserve+0x1d/0x2b

It also calls into arch/x86/platform/efi/quirks.c:efi_arch_mem_reserve()
which tags it as EFI_MEMORY_RUNTIME while the surrounding ones aren't
as shown by efi=debug:

[    0.178111] efi: mem10: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000074dd3000-0x0000000075becfff] (14MB)
[    0.178113] efi: mem11: [Boot Data          |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000074dd2000-0x0000000074dd2fff] (0MB)
[    0.178114] efi: mem12: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d635000-0x0000000074dd1fff] (119MB)

This prevents arch/x86/platform/efi/quirks.c:efi_free_boot_services()
from calling __memblock_free_late() on it. And indeed, memblock=debug does
not report this area as being free'd while the surrounding ones are:

[    0.178369] __memblock_free_late: [0x0000000074dd3000-0x0000000075becfff] efi_free_boot_services+0x126/0x1f8
[    0.178658] __memblock_free_late: [0x000000006d635000-0x0000000074dd1fff] efi_free_boot_services+0x126/0x1f8

The esrt area does not show up in /proc/iomem though:

00100000-763f5fff : System RAM
  62000000-62a00d80 : Kernel code
  62c00000-62f15fff : Kernel rodata
  63000000-630ea8bf : Kernel data
  63fed000-641fffff : Kernel bss
  65000000-6affffff : Crash kernel

And thus kexec loads the new kernel right over that area as shown when
enabling -DDEBUG on kexec_file.c (0x74dd3000 being inbetween 0x73000000
and 0x73000000+0x24be000 = 0x754be000):

[  650.007695] kexec_file: Loading segment 0: buf=0x000000003a9c84d6 bufsz=0x5000 mem=0x98000 memsz=0x6000
[  650.007699] kexec_file: Loading segment 1: buf=0x0000000017b2b9e6 bufsz=0x1240 mem=0x96000 memsz=0x2000
[  650.007703] kexec_file: Loading segment 2: buf=0x00000000fdf72ba2 bufsz=0x1150888 mem=0x73000000 memsz=0x24be000

... because it looks for any memory hole large enough in iomem resources
tagged as System RAM, which 0x74dd2000-0x74dd2fff would then need to be
excluded from on my system.

Looking some more at efi_arch_mem_reserve() I see that it also registers
the area with efi.memmap and installs it using efi_memmap_install().
which seems to call memremap(MEMREMAP_WB) on it. From my understanding
of the comments in the source of memremap(), MEMREMAP_WB does specifically
*not* reserve that memory in any way.

> Unfortunately I noticed there are different requirements/ways for
> different types of "reserved" memory.  But that is another topic..

I tried to reserve the area with something like this:

t a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 4de244683a7e..b86a5df027a2 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -249,6 +249,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
        efi_memory_desc_t md;
        int num_entries;
        void *new;
+       struct resource *res;
 
        if (efi_mem_desc_lookup(addr, &md) ||
            md.type != EFI_BOOT_SERVICES_DATA) {
@@ -294,6 +295,21 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
        early_memunmap(new, new_size);
 
        efi_memmap_install(new_phys, num_entries);
+
+       res = memblock_alloc(sizeof(*res), SMP_CACHE_BYTES);
+       if (!res) {
+               pr_err("Failed to allocate EFI io resource allocator for "
+                               "0x%llx:0x%llx", mr.range.start, mr.range.end);
+               return;
+       }
+
+       res->start      = mr.range.start;
+       res->end        = mr.range.end;
+       res->name       = "EFI runtime";
+       res->flags      = IORESOURCE_MEM | IORESOURCE_BUSY;
+       res->desc       = IORES_DESC_NONE;
+
+       insert_resource(&iomem_resource, res);
 }
 
 /*

... but failed miserably in terms of the kernel not booting because I
have no experience whatsoever in programming and debugging early kernel
init. But I am somewhat keen to ride the learning curve here. :)

Am I on the right track or were you a couple of leaps ahead of me
already and I just didn't get the question?
-- 
Thanks,
Michael
