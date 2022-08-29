Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93755A51A4
	for <lists+linux-efi@lfdr.de>; Mon, 29 Aug 2022 18:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiH2Q0Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Aug 2022 12:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiH2Q0N (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Aug 2022 12:26:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7567C1D9;
        Mon, 29 Aug 2022 09:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661790371; x=1693326371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k1Bydfd+WyOURaZCkIr7Wq133wz3qjLUnS9McjzhzJY=;
  b=KhDSx0LbgD4w16GLVGrsvItZ1EQg7hGfDcG948YJ8Xz8d9J/Gf9aFaYc
   gXHmDAPgty/hkwS11QbKJIZd+pDub9fSKfeF8CxVfxZgBpgRIW45jVXB/
   14cKQNoWvSwGzb3bY1yJyKrPmoK+KEqxf2mp4Dq2IIcsTo6GJ0Dse1E8q
   16SGsBn5ToVjXzAA3D0qgIhQg7ZrQvl8zf/vpcX7JDRigy18+UWEX0tx6
   MubULz0q7ImuA9VVYNN6+A2Q/45qBVx1ijUQg33tFIywWsgmyzNOHGaFG
   HKwa4815ecdMBoNyECDagszi/9wVojgPKiU7kj26oCfrxc6LEDHf3SMGi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295714034"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="295714034"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 09:19:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="611342635"
Received: from rlacadex-mobl.amr.corp.intel.com (HELO [10.209.116.122]) ([10.209.116.122])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 09:19:30 -0700
Message-ID: <984e07ed-914f-93ca-a141-3fc8677878e0@intel.com>
Date:   Mon, 29 Aug 2022 09:19:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
 <20220810141959.ictqchz7josyd7pt@techsingularity.net>
 <CAAH4kHa6s3sBRySNu-TZG_6vOaN4KheVy4kvxG5s=wOTDGy2=Q@mail.gmail.com>
 <2981e25e-9cda-518a-9750-b8694f2356b5@amd.com>
 <CAAH4kHbcfnVWNQHf6Mrg__bSFT6196Sx4kno6o0Zo7hsgOgnNw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAAH4kHbcfnVWNQHf6Mrg__bSFT6196Sx4kno6o0Zo7hsgOgnNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/29/22 09:02, Dionna Amalie Glaze wrote:
>>> The stack track is in mm/page_alloc.c. I've done a little
>>> investigation, but I can't account for why there's a hard cutoff of
>>> correctness at 256GB
>>>
>>> [    0.065563] RIP: 0010:memmap_init_range+0x108/0x173
>>> [    0.066309] Code: 77 16 f6 42 10 02 74 10 48 03 42 08 48 c1 e8 0c
>>> 48 89 c3 e9 3a ff ff ff 48 89 df 48 c1 e7 06 48 03 3d d9 a2 66 ff 48
>>> 8d 47 08 <c7> 47 34 01 00 00 00 48 c7 47 38 00 00 00 00 c7 47 30 ff ff
>>> ff ff
>>> [    0.069108] RSP: 0000:ffffffffad603dc8 EFLAGS: 00010082 ORIG_RAX:
>>> 0000000000000404
>>> [    0.070193] RAX: ffffdba740000048 RBX: 0000000000000001 RCX: 0000000000000000
>>> [    0.071170] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffdba740000040
>>> [    0.072224] RBP: 0000000000000000 R08: 0000000000001000 R09: 0000000000000000
>>> [    0.073283] R10: 0000000000000001 R11: ffffffffad645c60 R12: 0000000000000000
>>> [    0.074304] R13: 00000000000000a0 R14: 0000000000000000 R15: 0000000000000000
>>> [    0.075285] FS:  0000000000000000(0000) GS:ffffffffadd6c000(0000)
>>> knlGS:0000000000000000
>>> [    0.076365] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [    0.077194] CR2: ffffdba740000074 CR3: 0008001ee3a0c000 CR4: 00000000000606b0
>>> [    0.078209] Call Trace:
>>> [    0.078524]  <TASK>
>>> [    0.078887]  ? free_area_init+0x5c1/0x66c
>>> [    0.079417]  ? zone_sizes_init+0x52/0x6c
>>> [    0.079934]  ? setup_arch+0xa55/0xb6d
>>> [    0.080417]  ? start_kernel+0x64/0x65a
>>> [    0.080897]  ? secondary_startup_64_no_verify+0xd6/0xdb
>>> [    0.081620]  </TASK>
>> Note that there is a bug in Brijesh's version of the patch and it will
>> almost exclusively use the MSR protocol. Please try the version of the
>> patch that I recently sent up based on the current unaccepted memory tree
>> from Kirill.
>>
> I've now tested this patch set with Tom's new patch set, and it
> appears to be that the problem with 256GB is more likely to be due to
> this unaccepted memory patch set rather than something AMD-specific.
> 
> Kirill, do you see any problems with 256GB on TDX? It seems there is
> some unaccepted memory getting touched in memmap_init_range when the
> VM's memory size is at least 256GB

It really helps this kind of stuff if you can post the *actual* error.
I assume this was a page fault, so there should have been some other
stuff before the RIP:...

Another thing that's really nice is to do the disassembly of the "Code:"
or share disassembly of memmap_init_range.  Even nicer would be to give
an faddr2line of the RIP value and track down which C code was actually
at fault.

It's *possible* to look into these things from what you posted, but it's
just slow.  I'm sure Kirill will appreciate the help.
