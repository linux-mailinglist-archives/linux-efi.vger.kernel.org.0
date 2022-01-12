Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1918248CC90
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 20:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345920AbiALT4e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 14:56:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:46878 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357410AbiALTyz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 Jan 2022 14:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642017295; x=1673553295;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+z6qhzkY5AZh8lvp5ZYnAbRLSbu3XClV+3f1x7uGg64=;
  b=gOhxgnsvs+RrdlXnSykIUtCvUPYH1sfsD/0ZtPlrrHOvNk6ITZnv0fsD
   DQz8jum22OE9E9/5moWEIhVO7ME48ULmP2MKlRXRHDDReP+GOYD8E2cXm
   vu/lgt2T5hlHZjTvhjWjBo11t+iodUYYxHYpS+rZkBO8EZ3TsHDmTXn74
   qZyiET4iRM1MFkObE4eikd2rR1Kw2adIFhN5wMZdUUeKNZ40ETImMoPPJ
   CnMJleuUwD5vQs+I/Q90ACWyrOkhHeDXTLTkcNIPrioSn+8elYfaH9OBG
   xy4sjDBzOarBQElNUAWhCbg8BmbmgSA0dx98af+mSGAMZMHq80Caz/GuF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="223824034"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="223824034"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 11:53:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="593122646"
Received: from kumarkan-mobl.amr.corp.intel.com (HELO [10.209.80.194]) ([10.209.80.194])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 11:53:45 -0800
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
 <20220111113314.27173-6-kirill.shutemov@linux.intel.com>
 <3a361a1d-0e14-8884-c5bb-90aeb87e38ef@intel.com>
 <20220112194302.cyxhjypsptr4mtix@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv2 5/7] x86/mm: Reserve unaccepted memory bitmap
Message-ID: <a4b5707f-0f0b-57a8-ccdb-d89f66210b52@intel.com>
Date:   Wed, 12 Jan 2022 11:53:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220112194302.cyxhjypsptr4mtix@box.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/12/22 11:43 AM, Kirill A. Shutemov wrote:
> On Tue, Jan 11, 2022 at 11:10:40AM -0800, Dave Hansen wrote:
>> On 1/11/22 03:33, Kirill A. Shutemov wrote:
>>> Unaccepted memory bitmap is allocated during decompression stage and
>>> handed over to main kernel image via boot_params. The bitmap is used to
>>> track if memory has been accepted.
>>>
>>> Reserve unaccepted memory bitmap has to prevent reallocating memory for
>>> other means.
>>
>> I'm having a hard time parsing that changelog, especially the second
>> paragraph.  Could you give it another shot?
> 
> What about this:
> 
> 	Unaccepted memory bitmap is allocated during decompression stage and
> 	handed over to main kernel image via boot_params.
> 
> 	Kernel tracks what memory has been accepted in the bitmap.
> 
> 	Reserve memory where the bitmap is placed to prevent memblock from
> 	re-allocating the memory for other needs.
> 
> ?

Ahh, I get what you're trying to say now.  But, it still really lacks a
coherent problem statement.  How about this?

	== Problem ==

	A given page of memory can only be accepted once.  The kernel
	has a need to accept memory both in the early decompression
	stage and during normal runtime.

	== Solution ==

	Use a bitmap to communicate the acceptance state of each page
	between the decompression stage and normal runtime.  This
	eliminates the possibility of attempting to double-accept a
	page.

	== Details ==

	Allocate the bitmap during decompression stage and hand it over
	to the main kernel image via boot_params.

	In the runtime kernel, reserve the bitmap's memory to ensure
	nothing overwrites it.

>>> +	/* Mark unaccepted memory bitmap reserved */
>>> +	if (boot_params.unaccepted_memory) {
>>> +		unsigned long size;
>>> +
>>> +		/* One bit per 2MB */
>>> +		size = DIV_ROUND_UP(e820__end_of_ram_pfn() * PAGE_SIZE,
>>> +				    PMD_SIZE * BITS_PER_BYTE);
>>> +		memblock_reserve(boot_params.unaccepted_memory, size);
>>> +	}
>>
>> Is it OK that the size of the bitmap is inferred from
>> e820__end_of_ram_pfn()?  Is this OK in the presence of mem= and other things
>> that muck with the e820?
> 
> Good question. I think we are fine. If kernel is not able to allocate
> memory from a part of physical address space we don't need the bitmap for
> it either.

That's a good point.  If the e820 range does a one-way shrink it's
probably fine.  The only problem would be if the bitmap had space for
for stuff past e820__end_of_ram_pfn() *and* it later needed to be accepted.

Would it be worth recording the size of the reservation and then
double-checking against it in the bitmap operations?
