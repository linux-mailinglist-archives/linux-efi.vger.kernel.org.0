Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093A96F0F9
	for <lists+linux-efi@lfdr.de>; Sun, 21 Jul 2019 00:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfGTWyo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 20 Jul 2019 18:54:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:2970 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfGTWyo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 20 Jul 2019 18:54:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2019 15:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,288,1559545200"; 
   d="scan'208";a="367626781"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jul 2019 15:54:43 -0700
Message-ID: <cfee410c5dd4b359ee395ad075f31133387def70.camel@intel.com>
Subject: Why does memblock only refer to E820 table and not EFI Memory Map?
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-mm@kvack.org, linux-efi@vger.kernel.org
Cc:     mingo@kernel.org, bp@alien8.de, peterz@infradead.org,
        ard.biesheuvel@linaro.org, rppt@linux.ibm.com, pj@sgi.com
Date:   Sat, 20 Jul 2019 15:52:04 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi All,

Disclaimer:
1. Please note that this discussion is x86 specific
2. Below stated things are my understanding about kernel and I could have
missed somethings, so please let me know if I understood something wrong.
3. I have focused only on memblock here because if I understand correctly,
memblock is the base that feeds other memory management subsystems in kernel
(like the buddy allocator).

On x86 platforms, there are two sources through which kernel learns about
physical memory in the system namely E820 table and EFI Memory Map. Each table
describes which regions of system memory is usable by kernel and which regions
should be preserved (i.e. reserved regions that typically have BIOS code/data)
so that no other component in the system could read/write to these regions. I
think they are duplicating the information and hence I have couple of
questions regarding these

1. I see that only E820 table is being consumed by kernel [1] (i.e. memblock
subsystem in kernel) to distinguish between "usable" vs "reserved" regions.
Assume someone has called memblock_alloc(), the memblock subsystem would
service the caller by allocating memory from "usable" regions and it knows
this *only* from E820 table [2] (it does not check if EFI Memory Map also says
that this region is usable as well). So, why isn't the kernel taking EFI
Memory Map into consideration? (I see that it does happen only when
"add_efi_memmap" kernel command line arg is passed i.e. passing this argument
updates E820 table based on EFI Memory Map) [3]. The problem I see with
memblock not taking EFI Memory Map into consideration is that, we are ignoring
the main purpose for which EFI Memory Map exists.

2. Why doesn't the kernel have "add_efi_memmap" by default? From the commit
"200001eb140e: x86 boot: only pick up additional EFI memmap if add_efi_memmap
flag", I didn't understand why the decision was made so. Shouldn't we give
more preference to EFI Memory map rather than E820 table as it's the latest
and E820 is legacy?

3. Why isn't kernel checking that both the tables E820 table and EFI Memory
Map are in sync i.e. is there any *possibility* that a buggy BIOS could report
a region as usable in E820 table and as reserved in EFI Memory Map?

[1] 
https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/setup.c#L1106
[2] 
https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/e820.c#L1265
[3] 
https://elixir.bootlin.com/linux/latest/source/arch/x86/platform/efi/efi.c#L129

Regards,
Sai

