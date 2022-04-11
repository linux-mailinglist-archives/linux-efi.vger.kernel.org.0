Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65EE4FB3D8
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 08:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244993AbiDKGki (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 02:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244963AbiDKGke (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 02:40:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973EE23159;
        Sun, 10 Apr 2022 23:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649659101; x=1681195101;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=uARV/jTosTxQq4l76DhMLrvvCZEgajnIMtFFAQBCWU4=;
  b=TnSPO/QFHt8JaGtULlxH99Mrplq0LJoovPQJABI8LhQci1zQm9P010Su
   bk3ztbF+tHAGXvljw9pYZS7y36hRjEs5R2X55CXTwYWPhrgJ3eWtZY/ZQ
   s8XlZ614zqX41mf96XZx/yEsQBpokF+XhkxAPijxhRUJxrr0dD+6G6v1M
   BE9GDclly5GcfXS75Y3oZ6+UllUnj5RPh/WGzwi32R3X3llwNVGdSfQEU
   KAqGdeF2lVwta5cNvmj2KJ2D6WJrytriUihPJLF1VYdHb/V2xxSD8R9Fq
   StKJ7x+zPFhxS8Olvp8/+SoHmGhwRG7p8j8L9mGJReqEWeDTA14OeeKkd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="322489526"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="322489526"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 23:38:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="525311978"
Received: from srkondle-mobl.amr.corp.intel.com (HELO [10.212.113.6]) ([10.212.113.6])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 23:38:03 -0700
Message-ID: <6c976344-fdd6-95cd-2cb0-b0e817bf0392@intel.com>
Date:   Sun, 10 Apr 2022 23:38:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
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
        Dario Faggioli <dfaggioli@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <767c2100-c171-1fd3-6a92-0af2e4bf3067@intel.com>
 <20220409155423.iv2arckmvavvpegt@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
In-Reply-To: <20220409155423.iv2arckmvavvpegt@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/9/22 08:54, Kirill A. Shutemov wrote:
> On Fri, Apr 08, 2022 at 11:55:43AM -0700, Dave Hansen wrote:
>>> The page allocator is modified to accept pages on the first allocation.
>>> PageUnaccepted() is used to indicate that the page requires acceptance.
>>
>> Does this consume an actual page flag or is it aliased?
> 
> It is encoded as a page type in mapcount of unallocated memory. It is not
> aliased with PageOffline() as I did before.
> 
> I will mention that it is a new page type.

Guess I should have looked at the code. :)

Are we just increasingly using the StudlyNames() for anything to do with
pages?

>>> + /*
>>> +  * PageUnaccepted() indicates that the page has to be "accepted" before it can
>>> +  * be used. Page allocator has to call accept_page() before returning the page
>>> +  * to the caller.
>>> +  */
>>
>> Let's talk about "used" with a bit more detail.  Maybe:
>>
>> /*
>>  * PageUnaccepted() indicates that the page has to be "accepted" before
>>  * it can be read or written.  The page allocator must to call
>>  * accept_page() before touching the page or returning it to the caller.
>>  */
> 
> I guess s/must to call/must call/, right?

Yep.

...
>>> +	/*
>>> +	 * Check if the page needs to be marked as PageUnaccepted().
>>> +	 * Used for the new pages added to the buddy allocator for the first
>>> +	 * time.
>>> +	 */
>>> +	if (!unaccepted && (fpi_flags & FPI_UNACCEPTED))
>>> +		unaccepted = page_is_unaccepted(page, order);
>>
>> 	if (page_needs_acceptance && (fpi_flags & FPI_UNACCEPTED))
>> 		page_needs_acceptance = page_is_unaccepted(page, order);
>>
>>> +	if (unaccepted)
>>> +		__SetPageUnaccepted(page);
>>
>> This is getting hard for me to follow.
>>
>> There are:
>> 1. Pages that come in here with PageUnaccepted()==1
>> 2. Pages that come in here with PageUnaccepted()==0, but a buddy that
>>    was PageUnaccepted()==1
>>
>> In either of those cases, the bitmap will be consulted to see if the
>> page is *truly* unaccepted or not.  But, I'm struggling to figure out
>> how a page could end up in one of those scenarios and *not* be
>> page_is_unaccepted().
>>
>> There are three pieces of information that come in:
>> 1. PageUnaccepted(page)
>> 2. PageUnaccepted(buddies[])
>> 3. the bitmap
> 
> 1 and 2 are the same conceptionally: merged-in pieces of the resulting page.
> 
>>
>> and one piece of information going out:
>>
>> PageUnaccepted(page);
>>
>> I think I need a more coherent description of how those four things fit
>> together.
> 
> The page gets marked as PageUnaccepted() if any of merged-in pages is
> PageUnaccepted().
> 
> For new pages, just being added to buddy allocator, consult
> page_is_unaccepted(). FPI_UNACCEPTED indicates that the page is new and
> page_is_unaccepted() check is required.
> 
> Avoid calling page_is_unaccepted() if it is known that the page needs
> acceptance anyway. It can be costly.
> 
> Is it good enough explanation?

Yeah, elaborating on the slow and fast paths makes a lot of sense.

> FPI_UNACCEPTED is not a good name. Any help with a better one?
> FPI_CHECK_UNACCEPTED?

Maybe even something like FPI_UNACCEPTED_SLOWPATH.  Then you can say
that when this is passed in the pages might not have PageUnaccepted()
set and the slow bitmap needs to be consulted.

>>>  	if (fpi_flags & FPI_TO_TAIL)
>>>  		to_tail = true;
>>>  	else if (is_shuffle_order(order))
>>> @@ -1149,7 +1192,8 @@ static inline void __free_one_page(struct page *page,
>>>  static inline bool page_expected_state(struct page *page,
>>>  					unsigned long check_flags)
>>>  {
>>> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
>>> +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
>>> +	    !PageUnaccepted(page))
>>>  		return false;
>>
>> That probably deserves a comment, and maybe its own if() statement.
> 
> Own if does not work. PageUnaccepted() is encoded in _mapcount.
> 
> What about this:
> 
> 	/*
> 	 * page->_mapcount is expected to be -1.
> 	 *
> 	 * There is an exception for PageUnaccepted(). The page type can be set
> 	 * for pages on free list. Page types are encoded in _mapcount.
> 	 *
> 	 * PageUnaccepted() will get cleared in post_alloc_hook().
> 	 */
> 	if (unlikely((atomic_read(&page->_mapcount) | PG_unaccepted) != -1))
> 		return false;
> 
> ?

That's better.  But, aren't the PG_* names usually reserved for real
page->flags bits?  That naming might be part of my confusion.

>>>  		add_to_free_list(&page[size], zone, high, migratetype);
>>>  		set_buddy_order(&page[size], high);
>>>  	}
>>> @@ -2396,6 +2446,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>>>  	 */
>>>  	kernel_unpoison_pages(page, 1 << order);
>>>  
>>> +	if (PageUnaccepted(page))
>>> +		accept_page(page, order);
>>> +
>>>  	/*
>>>  	 * As memory initialization might be integrated into KASAN,
>>>  	 * KASAN unpoisoning and memory initializion code must be
>>
>> Is accepted memory guaranteed to be zeroed?  Do we want to skip the
>> __GFP_ZERO behavior later in this function?  Or is that just a silly
>> over-optimization?
> 
> For TDX, it is true that the memory gets cleared on acceptance, but I
> don't we can say the same for any possible implementation.
> 
> I would rather leave __GFP_ZERO for peace of mind. Clearing the cache-hot
> page for the second time shouldn't be a big deal comparing to acceptance
> cost.

Sure, fair enough.
