Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DC352080E
	for <lists+linux-efi@lfdr.de>; Tue, 10 May 2022 00:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiEIXAQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 May 2022 19:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiEIXAK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 May 2022 19:00:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A858532D9;
        Mon,  9 May 2022 15:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652136975; x=1683672975;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+l021sdnbY03zc6MnzzVgd4KREt6Immd2x/BeBZRvqg=;
  b=V+NxhXwMHuaDEjAT+67xiLDNlBkH8+WTPfUh+ftBL9z0WjS2pksU5xKj
   H/bp//svSrm+g7G520gybl6JRKVW5W0JzGjdfIoRPJs1dYg114fEjE+ym
   8K6i501iuz7tdeV1+AVMrNFNmyewbdgus8eyzedkW8gFKaUsyy+9qDMYW
   g/QjCiNIRbuXivdlNL54sasMZo+SCusEU97G+p5LTdYNSU+Awy/udved2
   gQkBqKbsh+jDpHmizjm5Wxd+tB4NWYMuoIbyiCPnFp2S5/Fq8ytHA/6RS
   hX0beDZXRcK/dn5TAMvLDRKFY/eyjoXe0aj0ywBZBGR45ZpCvO1A6PB6Q
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="355619535"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="355619535"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 15:56:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="634421767"
Received: from dmansurr-mobl.amr.corp.intel.com (HELO [10.212.251.158]) ([10.212.251.158])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 15:56:13 -0700
Message-ID: <71c0e2b4-1a58-62ad-b8af-9e00fdd1222d@intel.com>
Date:   Mon, 9 May 2022 15:56:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 0/8] x86: Show in sysfs if a memory node is able to do
 encryption
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
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
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michael Roth <michael.roth@amd.com>
References: <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com>
 <YnUYLDjIThbIz/Uf@zn.tnic> <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com>
 <CAPcyv4i73m6iPPfJE9CBdxf-OWGXahvGqvh6G-pqVO=3LB6ktQ@mail.gmail.com>
 <47140A56-D3F8-4292-B355-5F92E3BA9F67@alien8.de>
 <6abea873-52a2-f506-b21b-4b567bee1874@intel.com>
 <FDABC5C8-B80A-4977-9F97-5A8FC47F69D6@alien8.de>
 <4bc56567-e2ce-40ec-19ab-349c8de8d969@intel.com>
 <CE52D65A-C9F4-408D-B18A-72D87495A433@alien8.de>
 <ec93952f-d09a-2dda-bfa9-5d667a257fdc@intel.com> <YnmTFB1iXy7Qo403@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YnmTFB1iXy7Qo403@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/9/22 15:17, Borislav Petkov wrote:
> 
>> This new ABI provides a way to avoid that situation in the first place.
>>  Userspace can look at sysfs to figure out which NUMA nodes support
>> "encryption" (aka. TDX) and can use the existing NUMA policy ABI to
>> avoid TDH.MEM.PAGE.ADD failures.
>>
>> So, here's the question for the TDX folks: are these mixed-capability
>> systems a problem for you?  Does this ABI help you fix the problem?
> What I'm not really sure too is, is per-node granularity ok? I guess it
> is but let me ask it anyway...

I think nodes are the only sane granularity.

tl;dr: Zones might work in theory but have no existing useful ABI around
them and too many practical problems.  Nodes are the only other real
option without inventing something new and fancy.

--

What about zones (or any sub-node granularity really)?

Folks have, for instance, discussed adding new memory zones for this
purpose: have ZONE_NORMAL, and then ZONE_UNENCRYPTABLE (or something
similar).  Zones are great because they have their own memory allocation
pools and can be targeted directly from within the kernel using things
like GFP_DMA.  If you run out of ZONE_FOO, you can theoretically just
reclaim ZONE_FOO.

But, even a single new zone isn't necessarily good enough.  What if we
have some ZONE_NORMAL that's encryption-capable and some that's not?
The same goes for ZONE_MOVABLE.  We'd probably need at least:

	ZONE_NORMAL
	ZONE_NORMAL_UNENCRYPTABLE
	ZONE_MOVABLE
	ZONE_MOVABLE_UNENCRYPTABLE

Also, zones are (mostly) not exposed to userspace.  If we want userspace
to be able to specify encryption capabilities, we're talking about new
ABI for enumeration and policy specification.

Why node granularity?

First, for the majority of cases, nodes "just work".  ACPI systems with
an "HMAT" table already separate out different performance classes of
memory into different Proximity Domains (PXMs) which the kernel maps
into NUMA nodes.

This means that for NVDIMMs or virtually any CXL memory regions (one or
more CXL devices glued together) we can think of, they already get their
own NUMA node.  Those nodes have their own zones (implicitly) and can
lean on the existing NUMA ABI for enumeration and policy creation.

Basically, the firmware creates the NUMA nodes for the kernel.  All the
kernel has to do is acknowledge which of them can do encryption or not.

The one place where nodes fall down is if a memory hot-add occurs within
an existing node and the newly hot-added memory does not match the
encryption capabilities of the existing memory.  The kernel basically
has two options in that case:
 * Throw away the memory until the next reboot where the system might be
   reconfigured in a way to support more uniform capabilities (this is
   actually *likely* for a reboot of a TDX system)
 * Create a synthetic NUMA node to hold it

Neither one of those is a horrible option.  Throwing the memory away is
the most likely way TDX will handle this situation if it pops up.  For
now, the folks building TDX-capable BIOSes claim emphatically that such
a system won't be built.
