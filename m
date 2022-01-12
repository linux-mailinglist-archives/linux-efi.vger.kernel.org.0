Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8D148CB39
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 19:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356451AbiALSrI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 13:47:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:38945 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356461AbiALSrD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 Jan 2022 13:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642013223; x=1673549223;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Um0+dCThHlIVpdz2/59PejvkWBME4NoXAIzGQVp4iJU=;
  b=F48Z5LawMg86I/02ZuHR43eh4HvCxLGq8QuJ8Sg4X/RXPOB4M/DfS0Xo
   TTA56qhIR6PU/9SxKIu3uw25Q7aasAxO2Y5Vp05AAGUujvYlf8MF26Zw+
   KXpT+8nJ1S4py3fUW9nsjt7yRT2dsH8a9nnied3ovckvFlwU/YJc0ceui
   OlBGOuyVGWKs5fbJ6+VPiyL8ieTgh8MHDDW1MiDYjrm7DGL1hJikLI6bl
   xoxMuWVv6x/l5hMCm2izlViX9VIAgsNTDrSiK/xyhTdY+xKRj9/SlWuYd
   Q4Rr19XxvTzZ1tlwERNG78FcBSTTzpjGcR3SG13nV9wxs0aNE348US+O1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307168117"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="307168117"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 10:40:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="691495229"
Received: from kumarkan-mobl.amr.corp.intel.com (HELO [10.209.80.194]) ([10.209.80.194])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 10:40:55 -0800
Message-ID: <af7ceba3-c27e-9f18-6c1b-c251428d8da4@intel.com>
Date:   Wed, 12 Jan 2022 10:40:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCHv2 1/7] mm: Add support for unaccepted memory
Content-Language: en-US
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
 <20220111113314.27173-2-kirill.shutemov@linux.intel.com>
 <3a68fabd-eaff-2164-5609-3a71fd4a7257@intel.com>
 <20220112183054.uedczc4ldntrj25j@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220112183054.uedczc4ldntrj25j@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/12/22 10:30, Kirill A. Shutemov wrote:
> On Tue, Jan 11, 2022 at 11:46:37AM -0800, Dave Hansen wrote:
>>> diff --git a/mm/memblock.c b/mm/memblock.c
>>> index 1018e50566f3..6dfa594192de 100644
>>> --- a/mm/memblock.c
>>> +++ b/mm/memblock.c
>>> @@ -1400,6 +1400,7 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>>>    		 */
>>>    		kmemleak_alloc_phys(found, size, 0, 0);
>>> +	accept_memory(found, found + size);
>>>    	return found;
>>>    }
>>
>> This could use a comment.
> 
> How about this:
> 
> 	/*
> 	 * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
> 	 * requiring memory to be accepted before it can be used by the
> 	 * guest.
> 	 *
> 	 * Accept the memory of the allocated buffer.
> 	 */

I think a one-liner that might cue the reader to go look at 
accept_memory() itself would be fine.  Maybe:

	/* Make the memblock usable when running in picky VM guests: */

That implies that the memory isn't usable without doing this and also 
points out that it's related to running in a guest.

>> Looking at this, I also have to wonder if accept_memory() is a bit too
>> generic.  Should it perhaps be: cc_accept_memory() or
>> cc_guest_accept_memory()?
> 
> I'll rename accept_memory() to cc_accept_memory() and
> accept_and_clear_page_offline() to cc_accept_and_clear_page_offline().
> 
>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index c5952749ad40..5707b4b5f774 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -1064,6 +1064,7 @@ static inline void __free_one_page(struct page *page,
>>>    	unsigned int max_order;
>>>    	struct page *buddy;
>>>    	bool to_tail;
>>> +	bool offline = PageOffline(page);
>>>    	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
>>> @@ -1097,6 +1098,10 @@ static inline void __free_one_page(struct page *page,
>>>    			clear_page_guard(zone, buddy, order, migratetype);
>>>    		else
>>>    			del_page_from_free_list(buddy, zone, order);
>>> +
>>> +		if (PageOffline(buddy))
>>> +			offline = true;
>>> +
>>>    		combined_pfn = buddy_pfn & pfn;
>>>    		page = page + (combined_pfn - pfn);
>>>    		pfn = combined_pfn;
>>> @@ -1130,6 +1135,9 @@ static inline void __free_one_page(struct page *page,
>>>    done_merging:
>>>    	set_buddy_order(page, order);
>>> +	if (offline)
>>> +		__SetPageOffline(page);
>>> +
> 
> I'll add
> 
> 	/* Mark page PageOffline() if any merged page was PageOffline() */
> 
> above the 'if'.
> 
>>>    	if (fpi_flags & FPI_TO_TAIL)
>>>    		to_tail = true;
>>>    	else if (is_shuffle_order(order))
>>
>> This is touching some pretty hot code paths.  You mention both that
>> accepting memory is slow and expensive, yet you're doing it in the core
>> allocator.
>>
>> That needs at least some discussion in the changelog.
> 
> That is page type transfer on page merging. What expensive do you see here?
> The cachelines with both struct pages are hot already.

I meant that comment generically rather than at this specific hunk.

Just in general, I think this series needs to acknowledge that it is 
touching very core parts of the allocator and might make page allocation 
*MASSIVELY* slower, albeit temporarily.

>>> @@ -1155,7 +1163,8 @@ static inline void __free_one_page(struct page *page,
>>>    static inline bool page_expected_state(struct page *page,
>>>    					unsigned long check_flags)
>>>    {
>>> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
>>> +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
>>> +	    !PageOffline(page))
>>>    		return false;
>>
>> Looking at stuff like this, I can't help but think that a:
>>
>> 	#define PageOffline PageUnaccepted
>>
>> and some other renaming would be a fine idea.  I get that the Offline bit
>> can be reused, but I'm not sure that the "Offline" *naming* should be
>> reused.  What you're doing here is logically distinct from existing
>> offlining.
> 
> I find the Offline name fitting. In both cases page is not accessible
> without additional preparation.
> 
> Why do you want to multiply entities?

The name wouldn't be bad *if* there was no other use of "Offline".  But, 
logically, your use of "Offline" and the existing use of "Offline" are 
different things.  They are totally orthogonal areas of the code.  They 
should have different names.

Again, I'm fine with using the same _bit_ in page->flags.  But, the two 
logical uses need two different names.
