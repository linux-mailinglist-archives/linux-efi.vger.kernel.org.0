Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E95204BE
	for <lists+linux-efi@lfdr.de>; Mon,  9 May 2022 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240353AbiEISvj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 May 2022 14:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240328AbiEISvi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 May 2022 14:51:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E911FE3C1;
        Mon,  9 May 2022 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652122063; x=1683658063;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DgxFrV+YaA+Y0+KuhtxWQXk6HsnmyPhzD2ZlERyiq44=;
  b=IxhQiUjaqQvHeeLwfO91lbAoVggC2haQ7U3hdNYz7HQQSy234zt/yoiX
   gBB5VZzvt/fWGuG5bWAy14cpb3yw1YCWaza3C0IRLHzlFF+XHgPCyqNQS
   ztz80JrnpBp7iNcrE0+m4ldYae6f6iIfSDYBSh9VWUM44mKwaC/2YEzam
   Yt8H+zbWwf/lDVRjQt+BFt5oEpgKKV80cX6YkPe83aO3SVASSmqS3puzw
   JL4Y8qPltpdBIJG4JrzVBvI8FQ48QSKVr99qKz3p6c+EH2YyB3AZE4ud4
   Sti2fA0yt7V/olFP59wLWejZ2kXqQfiB1cQLsZGC5Dr5D1bYAzSZxHeHM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="268804963"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="268804963"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 11:47:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="634140944"
Received: from dmansurr-mobl.amr.corp.intel.com (HELO [10.212.251.158]) ([10.212.251.158])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 11:47:41 -0700
Message-ID: <ec93952f-d09a-2dda-bfa9-5d667a257fdc@intel.com>
Date:   Mon, 9 May 2022 11:47:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 0/8] x86: Show in sysfs if a memory node is able to do
 encryption
Content-Language: en-US
To:     Boris Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        "H. Peter Anvin" <hpa@zytor.com>, daniel.gutson@eclypsium.com,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, X86 ML <x86@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
 <YnKr+aMf4PspDpHZ@zn.tnic>
 <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com>
 <YnUYLDjIThbIz/Uf@zn.tnic> <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com>
 <CAPcyv4i73m6iPPfJE9CBdxf-OWGXahvGqvh6G-pqVO=3LB6ktQ@mail.gmail.com>
 <47140A56-D3F8-4292-B355-5F92E3BA9F67@alien8.de>
 <6abea873-52a2-f506-b21b-4b567bee1874@intel.com>
 <FDABC5C8-B80A-4977-9F97-5A8FC47F69D6@alien8.de>
 <4bc56567-e2ce-40ec-19ab-349c8de8d969@intel.com>
 <CE52D65A-C9F4-408D-B18A-72D87495A433@alien8.de>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CE52D65A-C9F4-408D-B18A-72D87495A433@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

... adding some KVM/TDX folks

On 5/6/22 12:02, Boris Petkov wrote:
>> This node attribute punts the problem back out to userspace.  It
>> gives userspace the ability to steer allocations to compatible NUMA
>> nodes.  If something goes wrong, they can use other NUMA ABIs to
>> inspect the situation, like /proc/$pid/numa_maps.
> That's all fine and dandy but I still don't see the *actual*,
> real-life use case of why something would request memory of
> particular encryption capabilities. Don't get me wrong  - I'm not
> saying there are not such use cases - I'm saying we should go all the
> way and fully define properly  *why* we're doing this whole hoopla.

Let's say TDX is running on a system with mixed encryption
capabilities*.  Some NUMA nodes support TDX and some don't.  If that
happens, your guest RAM can come from anywhere.  When the host kernel
calls into the TDX module to add pages to the guest (via
TDH.MEM.PAGE.ADD) it might get an error back from the TDX module.  At
that point, the host kernel is stuck.  It's got a partially created
guest and no recourse to fix the error.

This new ABI provides a way to avoid that situation in the first place.
 Userspace can look at sysfs to figure out which NUMA nodes support
"encryption" (aka. TDX) and can use the existing NUMA policy ABI to
avoid TDH.MEM.PAGE.ADD failures.

So, here's the question for the TDX folks: are these mixed-capability
systems a problem for you?  Does this ABI help you fix the problem?
Will your userspace (qemu and friends) actually use consume from this ABI?

* There are three ways we might hit a system with this issue:
  1. NVDIMMs that don't support  TDX, like lack of memory integrity
     protection.
  2. CXL-attached memory controllers that can't do encryption at all
  3. Nominally TDX-compatible memory that was not covered/converted by
     the kernel for some reason (memory hot-add, or ran out of TDMR
     resources)
