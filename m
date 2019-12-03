Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFCFC11065D
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 22:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfLCVPw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Dec 2019 16:15:52 -0500
Received: from heinz.dinsnail.net ([81.169.187.250]:39488 "EHLO
        heinz.dinsnail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfLCVPw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Dec 2019 16:15:52 -0500
Received: from heinz.dinsnail.net ([IPv6:0:0:0:0:0:0:0:1])
        by heinz.dinsnail.net (8.15.2/8.15.2) with ESMTP id xB3LFE9k024551;
        Tue, 3 Dec 2019 22:15:14 +0100
Received: from eldalonde.UUCP (uucp@localhost)
        by heinz.dinsnail.net (8.15.2/8.15.2/Submit) with bsmtp id xB3LFC7s024550;
        Tue, 3 Dec 2019 22:15:12 +0100
Received: from eldalonde.weiser.dinsnail.net (localhost [IPv6:0:0:0:0:0:0:0:1])
        by eldalonde.weiser.dinsnail.net (8.15.2/8.15.2) with ESMTP id xB3LBk9Q000553;
        Tue, 3 Dec 2019 22:11:46 +0100
Received: (from michael@localhost)
        by eldalonde.weiser.dinsnail.net (8.15.2/8.15.2/Submit) id xB3LBkLW000552;
        Tue, 3 Dec 2019 22:11:46 +0100
Date:   Tue, 3 Dec 2019 22:11:46 +0100
From:   Michael Weiser <michael@weiser.dinsnail.net>
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-efi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: kexec_file overwrites reserved EFI ESRT memory
Message-ID: <20191203211146.GA536@weiser.dinsnail.net>
References: <20191122180552.GA32104@weiser.dinsnail.net>
 <87blt3y949.fsf@x220.int.ebiederm.org>
 <20191122210702.GE32104@weiser.dinsnail.net>
 <20191125055201.GA6569@dhcp-128-65.nay.redhat.com>
 <20191129152700.GA8286@weiser.dinsnail.net>
 <20191202085829.GA15808@dhcp-128-65.nay.redhat.com>
 <20191202090520.GA15874@dhcp-128-65.nay.redhat.com>
 <20191202234541.GA27567@weiser.dinsnail.net>
 <20191203115435.GA2606@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203115435.GA2606@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-dinsnail-net-MailScanner-Information: Please contact the ISP for more information
X-dinsnail-net-MailScanner-ID: xB3LFE9k024551
X-dinsnail-net-MailScanner: Found to be clean
X-dinsnail-net-MailScanner-From: michael@weiser.dinsnail.net
X-Spam-Status: No
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dave,

On Tue, Dec 03, 2019 at 07:54:35PM +0800, Dave Young wrote:

> > Neither adding add_efi_memmap nor adding your patch and setting that option
> > does make the ESRT memory region appear in /proc/iomem. kexec_file still
> > loads the kernel across the ESRT region.
> Hmm, sorry, my bad, actuall add_efi_memmap does not consider the
> EFI_MEMORY_RUNTIME attribute, it only reads the memory descriptor types.

> Will read your replied information later, did not get time today, but
> probably below chunk can help?

> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 3b9fd679cea9..516307617621 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -293,6 +293,8 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>  	early_memunmap(new, new_size);

>  	efi_memmap_install(new_phys, num_entries);
> +	e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +	e820__update_table(e820_table);
>  }

>  /*

Yes, that did it:

00000000-00000fff : Reserved
00001000-0009efff : System RAM
0009f000-000fffff : Reserved
  000a0000-000bffff : PCI Bus 0000:00
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000e8000-000ebfff : PCI Bus 0000:00
  000ec000-000effff : PCI Bus 0000:00
  000f0000-000fffff : PCI Bus 0000:00
    000f0000-000fffff : System ROM
00100000-74dd1fff : System RAM
  65000000-6affffff : Crash kernel
74dd2000-74dd2fff : Reserved                   <----- ESRT
74dd3000-763f5fff : System RAM
763f6000-79974fff : Reserved
79975000-799f1fff : ACPI Tables
799f2000-79aa6fff : ACPI Non-volatile Storage
  79a17000-79a17fff : USBC000:00

[    0.001381] esrt: Reserving ESRT space from 0x0000000074dd2f98 to 0x0000000074dd2fd0.
[    0.001382] memblock_reserve: [0x0000000074dd2f98-0x0000000074dd2fcf] efi_mem_reserve+0x1d/0x2b
[    0.001383] memblock_reserve: [0x000000000009e640-0x000000000009efcf] memblock_alloc_range_nid+0x93/0xfa
[    0.001384] e820: update [mem 0x74dd2000-0x74dd2fff] usable ==> reserved
[...]
[    0.043610] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.043611] memblock_alloc_try_nid: 32 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 __register_nosave_region+0x6b/0xca
[    0.043612] memblock_reserve: [0x000000047dff95c0-0x000000047dff95df] memblock_alloc_range_nid+0x93/0xfa
[    0.043613] PM: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.043615] memblock_alloc_try_nid: 32 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 __register_nosave_region+0x6b/0xca
[    0.043616] memblock_reserve: [0x000000047dff9580-0x000000047dff959f] memblock_alloc_range_nid+0x93/0xfa
[    0.043617] PM: Registered nosave memory: [mem 0x74dd2000-0x74dd2fff]       <---- ESRT
[    0.043618] memblock_alloc_try_nid: 32 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 __register_nosave_region+0x6b/0xca
[    0.043619] memblock_reserve: [0x000000047dff9540-0x000000047dff955f] memblock_alloc_range_nid+0x93/0xfa
[    0.043620] PM: Registered nosave memory: [mem 0x763f6000-0x79974fff]
[    0.043620] PM: Registered nosave memory: [mem 0x79975000-0x799f1fff]
[    0.043621] PM: Registered nosave memory: [mem 0x799f2000-0x79aa6fff]
[    0.043621] PM: Registered nosave memory: [mem 0x79aa7000-0x7a40dfff]
[...]
[    5.993928] PCI: pci_cache_line_size set to 64 bytes
[    5.994563] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    5.994565] e820: reserve RAM buffer [mem 0x74dd2000-0x77ffffff]            <----- ESRT
[    5.994565] e820: reserve RAM buffer [mem 0x763f6000-0x77ffffff]
[    5.994566] e820: reserve RAM buffer [mem 0x7a40f000-0x7bffffff]
[    5.994567] e820: reserve RAM buffer [mem 0x47e000000-0x47fffffff]
[    5.995513] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
[    5.995549] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
[...]
[   86.508053] kexec-bzImage64: Loaded purgatory at 0x98000
[   86.508056] kexec_file: Considering 0x1000-0x9efff
[   86.508057] kexec-bzImage64: Loaded boot_param, command line and misc at 0x96000 bufsz=0x1240 memsz=0x1240
[   86.508057] kexec_file: Considering 0x100000-0x74dd1fff
[   86.508058] kexec-bzImage64: Loaded 64bit kernel at 0x72000000 bufsz=0x1140888 memsz=0x24b7000
[   86.508058] kexec-bzImage64: Final command line is: 
[   86.584668] kexec_file: Loading segment 0: buf=0x00000000d5ec82bc bufsz=0x5000 mem=0x98000 memsz=0x6000
[   86.584672] kexec_file: Loading segment 1: buf=0x00000000af539c69 bufsz=0x1240 mem=0x96000 memsz=0x2000
[   86.584674] kexec_file: Loading segment 2: buf=0x0000000029f9b9a8 bufsz=0x1140888 mem=0x72000000 memsz=0x24b7000           <---- not ESRT :)

And no more invalid version error message from the kexec'd kernel.
-- 
Thanks,
Michael
