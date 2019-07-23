Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACFF1721AE
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jul 2019 23:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfGWVi5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Jul 2019 17:38:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:26580 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727643AbfGWVi5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 23 Jul 2019 17:38:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 14:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,300,1559545200"; 
   d="scan'208";a="169682593"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jul 2019 14:38:56 -0700
Date:   Tue, 23 Jul 2019 14:38:21 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-mm@kvack.org, linux-efi@vger.kernel.org, mingo@kernel.org,
        bp@alien8.de, peterz@infradead.org, ard.biesheuvel@linaro.org,
        rppt@linux.ibm.com, pj@sgi.com
Subject: Re: Why does memblock only refer to E820 table and not EFI Memory
 Map?
Message-ID: <20190723213821.GA3311@ranerica-svr.sc.intel.com>
References: <cfee410c5dd4b359ee395ad075f31133387def70.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfee410c5dd4b359ee395ad075f31133387def70.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jul 20, 2019 at 03:52:04PM -0700, Sai Praneeth Prakhya wrote:
> Hi All,
> 
> Disclaimer:
> 1. Please note that this discussion is x86 specific
> 2. Below stated things are my understanding about kernel and I could have
> missed somethings, so please let me know if I understood something wrong.
> 3. I have focused only on memblock here because if I understand correctly,
> memblock is the base that feeds other memory management subsystems in kernel
> (like the buddy allocator).
> 
> On x86 platforms, there are two sources through which kernel learns about
> physical memory in the system namely E820 table and EFI Memory Map. Each table
> describes which regions of system memory is usable by kernel and which regions
> should be preserved (i.e. reserved regions that typically have BIOS code/data)
> so that no other component in the system could read/write to these regions. I
> think they are duplicating the information and hence I have couple of
> questions regarding these

But isn't it true that in x86 systems the E820 table is populated from the EFI
memory map? At least in systems with EFI firmware and a Linux which understands
EFI. If booting from the EFI stub, the stub will take the EFI memory map and
assemble the E820 table passed as part of the boot params [4]. It also considers
the case when there are more than 128 entries in the table [5]. Thus, if booting
as an EFI application it will definitely use the EFI memory map. If Linux' EFI
entry point is not used the bootloader should to the same. For instance, grub
also reads the EFI memory map to assemble the E820 memory map [6], [7], [8].

> 
> 1. I see that only E820 table is being consumed by kernel [1] (i.e. memblock
> subsystem in kernel) to distinguish between "usable" vs "reserved" regions.
> Assume someone has called memblock_alloc(), the memblock subsystem would
> service the caller by allocating memory from "usable" regions and it knows
> this *only* from E820 table [2] (it does not check if EFI Memory Map also says
> that this region is usable as well). So, why isn't the kernel taking EFI
> Memory Map into consideration? (I see that it does happen only when
> "add_efi_memmap" kernel command line arg is passed i.e. passing this argument
> updates E820 table based on EFI Memory Map) [3]. The problem I see with
> memblock not taking EFI Memory Map into consideration is that, we are ignoring
> the main purpose for which EFI Memory Map exists.
> 
> 2. Why doesn't the kernel have "add_efi_memmap" by default? From the commit
> "200001eb140e: x86 boot: only pick up additional EFI memmap if add_efi_memmap
> flag", I didn't understand why the decision was made so. Shouldn't we give
> more preference to EFI Memory map rather than E820 table as it's the latest
> and E820 is legacy?

I did a a quick experiment with and without add_efi_memmmap. the e820
table looked exactly the same. I guess this shows that what I wrote
above makes sense ;) . Have you observed difference?

Thanks and BR,
Ricardo

[4]. https://elixir.bootlin.com/linux/latest/source/arch/x86/boot/compressed/eboot.c#L516
[5]. https://elixir.bootlin.com/linux/latest/source/arch/x86/boot/compressed/eboot.c#L493
[6]. http://git.savannah.gnu.org/cgit/grub.git/tree/grub-core/loader/i386/linux.c#n573
[7]. http://git.savannah.gnu.org/cgit/grub.git/tree/grub-core/mmap/mmap.c#n110
[8]. http://git.savannah.gnu.org/cgit/grub.git/tree/grub-core/mmap/efi/mmap.c#n139
 
