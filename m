Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94246721F3
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2019 00:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbfGWWF1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Jul 2019 18:05:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:51476 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731276AbfGWWF1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 23 Jul 2019 18:05:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 15:05:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,300,1559545200"; 
   d="scan'208";a="369056989"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2019 15:05:26 -0700
Message-ID: <180ae7c8af18d7a73cd8ba18e8fe2aa7ef562fd3.camel@intel.com>
Subject: Re: Why does memblock only refer to E820 table and not EFI Memory
 Map?
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-efi@vger.kernel.org, mingo@kernel.org,
        bp@alien8.de, peterz@infradead.org, ard.biesheuvel@linaro.org,
        rppt@linux.ibm.com, pj@sgi.com
Date:   Tue, 23 Jul 2019 15:01:57 -0700
In-Reply-To: <20190723213821.GA3311@ranerica-svr.sc.intel.com>
References: <cfee410c5dd4b359ee395ad075f31133387def70.camel@intel.com>
         <20190723213821.GA3311@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


> > On x86 platforms, there are two sources through which kernel learns about
> > physical memory in the system namely E820 table and EFI Memory Map. Each
> > table
> > describes which regions of system memory is usable by kernel and which
> > regions
> > should be preserved (i.e. reserved regions that typically have BIOS
> > code/data)
> > so that no other component in the system could read/write to these
> > regions. I
> > think they are duplicating the information and hence I have couple of
> > questions regarding these
> 
> But isn't it true that in x86 systems the E820 table is populated from the
> EFI memory map?

I don't know that it happens.. :(

> At least in systems with EFI firmware and a Linux which understands
> EFI. If booting from the EFI stub, the stub will take the EFI memory map and
> assemble the E820 table passed as part of the boot params [4]. It also
> considers the case when there are more than 128 entries in the table [5].
> Thus, if booting as an EFI application it will definitely use the EFI memory
> map. If Linux' EFI entry point is not used the bootloader should to the
> same. For instance, grub also reads the EFI memory map to assemble the E820
> memory map [6], [7], [8].

Thanks a lot! for the pointers Ricardo :)
I haven't looked at EFI stub and Grub code and hence didn't knew this was
happening. It does make me feel better that EFI Memory Map is indeed being
used to generate e820 in EFI stub case, so at-least it's getting consumed
indirectly.

> > 1. I see that only E820 table is being consumed by kernel [1] (i.e.
> > memblock
> > subsystem in kernel) to distinguish between "usable" vs "reserved"
> > regions.
> > Assume someone has called memblock_alloc(), the memblock subsystem would
> > service the caller by allocating memory from "usable" regions and it knows
> > this *only* from E820 table [2] (it does not check if EFI Memory Map also
> > says
> > that this region is usable as well). So, why isn't the kernel taking EFI
> > Memory Map into consideration? (I see that it does happen only when
> > "add_efi_memmap" kernel command line arg is passed i.e. passing this
> > argument
> > updates E820 table based on EFI Memory Map) [3]. The problem I see with
> > memblock not taking EFI Memory Map into consideration is that, we are
> > ignoring
> > the main purpose for which EFI Memory Map exists.
> > 
> > 2. Why doesn't the kernel have "add_efi_memmap" by default? From the
> > commit
> > "200001eb140e: x86 boot: only pick up additional EFI memmap if
> > add_efi_memmap
> > flag", I didn't understand why the decision was made so. Shouldn't we give
> > more preference to EFI Memory map rather than E820 table as it's the
> > latest
> > and E820 is legacy?
> 
> I did a a quick experiment with and without add_efi_memmmap. the e820
> table looked exactly the same. I guess this shows that what I wrote
> above makes sense ;) . Have you observed difference?

When I did a quick test, I didn't notice any difference (with and without
add_efi_memap) because both e820 and EFI Memory Map were reporting regions in
sync. So, "add_efi_memmap" didn't have to add any new regions into e820. Hence
my last question, what if both the tables (EFI Memory Map and e820) are out of
sync? Shouldn't happen in Grub and EFI stub because they generate e820 from
EFI Memory Map, as pointed by you.

Regards,
Sai

