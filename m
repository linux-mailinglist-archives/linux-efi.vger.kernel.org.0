Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3518971395
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jul 2019 10:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfGWIJ7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Jul 2019 04:09:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbfGWIJ7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 23 Jul 2019 04:09:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36B3C308FE8D;
        Tue, 23 Jul 2019 08:09:59 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-90.pek2.redhat.com [10.72.12.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6705B60606;
        Tue, 23 Jul 2019 08:09:55 +0000 (UTC)
Date:   Tue, 23 Jul 2019 16:09:49 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-mm@kvack.org, linux-efi@vger.kernel.org, mingo@kernel.org,
        bp@alien8.de, peterz@infradead.org, ard.biesheuvel@linaro.org,
        rppt@linux.ibm.com, pj@sgi.com
Subject: Re: Why does memblock only refer to E820 table and not EFI Memory
 Map?
Message-ID: <20190723080949.GB9859@dhcp-128-65.nay.redhat.com>
References: <cfee410c5dd4b359ee395ad075f31133387def70.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfee410c5dd4b359ee395ad075f31133387def70.camel@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 23 Jul 2019 08:09:59 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,
On 07/20/19 at 03:52pm, Sai Praneeth Prakhya wrote:
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

https://blog.fpmurphy.com/2012/08/uefi-memory-v-e820-memory.html
Probably above blog can explain some background.

> 
> 2. Why doesn't the kernel have "add_efi_memmap" by default? From the commit
> "200001eb140e: x86 boot: only pick up additional EFI memmap if add_efi_memmap
> flag", I didn't understand why the decision was made so. Shouldn't we give
> more preference to EFI Memory map rather than E820 table as it's the latest
> and E820 is legacy?
> 
> 3. Why isn't kernel checking that both the tables E820 table and EFI Memory
> Map are in sync i.e. is there any *possibility* that a buggy BIOS could report
> a region as usable in E820 table and as reserved in EFI Memory Map?
> 
> [1] 
> https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/setup.c#L1106
> [2] 
> https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/e820.c#L1265
> [3] 
> https://elixir.bootlin.com/linux/latest/source/arch/x86/platform/efi/efi.c#L129
> 
> Regards,
> Sai
> 

Thanks
Dave
