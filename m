Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C522271D72
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jul 2019 19:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbfGWRLb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Tue, 23 Jul 2019 13:11:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:5285 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388006AbfGWRLb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 23 Jul 2019 13:11:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 10:11:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,299,1559545200"; 
   d="scan'208";a="368453183"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2019 10:11:29 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.96]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.142]) with mapi id 14.03.0439.000;
 Tue, 23 Jul 2019 10:11:29 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Dave Young <dyoung@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "pj@sgi.com" <pj@sgi.com>
Subject: RE: Why does memblock only refer to E820 table and not EFI Memory
 Map?
Thread-Topic: Why does memblock only refer to E820 table and not EFI Memory
 Map?
Thread-Index: AQHVQS4PLLsbbSADyUqVsMzHOrg1zabYbfVg
Date:   Tue, 23 Jul 2019 17:11:28 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4F94B2C6@ORSMSX114.amr.corp.intel.com>
References: <cfee410c5dd4b359ee395ad075f31133387def70.camel@intel.com>
 <20190723080949.GB9859@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190723080949.GB9859@dhcp-128-65.nay.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTIyYzdhNDYtMTZkNS00ODNiLThiNWYtNTEzZWM1MzU1ODExIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTzFiaHJsZmc1bVdHYTlUTXVzRXpieEhjSWRjMXBxbmNpNGl5Q01BSTl6d1lKcjJuWlFkVzJTZWNIT1hGdm13TSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> > On x86 platforms, there are two sources through which kernel learns
> > about physical memory in the system namely E820 table and EFI Memory
> > Map. Each table describes which regions of system memory is usable by
> > kernel and which regions should be preserved (i.e. reserved regions
> > that typically have BIOS code/data) so that no other component in the
> > system could read/write to these regions. I think they are duplicating
> > the information and hence I have couple of questions regarding these
> >
> > 1. I see that only E820 table is being consumed by kernel [1] (i.e.
> > memblock subsystem in kernel) to distinguish between "usable" vs "reserved"
> regions.
> > Assume someone has called memblock_alloc(), the memblock subsystem
> > would service the caller by allocating memory from "usable" regions
> > and it knows this *only* from E820 table [2] (it does not check if EFI
> > Memory Map also says that this region is usable as well). So, why
> > isn't the kernel taking EFI Memory Map into consideration? (I see that
> > it does happen only when "add_efi_memmap" kernel command line arg is
> > passed i.e. passing this argument updates E820 table based on EFI
> > Memory Map) [3]. The problem I see with memblock not taking EFI Memory
> > Map into consideration is that, we are ignoring the main purpose for which EFI
> Memory Map exists.
> 
> https://blog.fpmurphy.com/2012/08/uefi-memory-v-e820-memory.html
> Probably above blog can explain some background.

Thanks a lot! Dave. The link was helpful, it did explain that Linus and HPA were 
not very happy with EFI and things were going good with E820 and hence it was given 
more preference compared to EFI.

But sadly, I am not 100% convinced yet :( (just my thoughts)
This decision was made a decade ago when EFI wasn't stable. Now that UEFI is the defacto 
on most of the x86 platforms (and since I believe UEFI is getting better) I am still unable to 
digest that kernel throws away EFI Memory Map (unless explicitly asked by "add_efi_memap")

Regards,
Sai
