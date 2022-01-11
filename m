Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D14A48B799
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 20:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiAKTqm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 14:46:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:44887 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238076AbiAKTqm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 11 Jan 2022 14:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641930402; x=1673466402;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gTc4jBDH9a16Q1xuiD12eIuLKoPR30A3hlnu1JbJSQM=;
  b=Dm8PJ1/swRZEZyTnJXG3AdhQU4Sm6WR2cQUTU3nl8Z4udlYsnM3oMJlj
   2qY77Dtshs+Scpy6+6+HQved4ACTpaZvc+loZv84RzptNxslBcC7Hd2sa
   7pnwUyOB7wrudZMpJBZppUe8Hc8umzB6uzv6NPkjEWggwjroCy4hSV1xZ
   II9P5wAoUFTl/o4QVh5J3EdumzAJXrqqMc3ZDWu3QrZ4HINgUqGhOMCcp
   nP7CBRxHNSbUkCvKQJnHWToowQbqLKPdKdjZR+WPaWyQMALD2XY/Ug5IJ
   8Kv/kh/2Q4lVTIdhNaCRgmbc+DP3wz3fMvjO9G0Cv0Zl2Qp1rJU77Zkg/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="230911498"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="230911498"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 11:46:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="613324769"
Received: from padhika1-mobl.amr.corp.intel.com (HELO [10.209.13.65]) ([10.209.13.65])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 11:46:40 -0800
Message-ID: <3a68fabd-eaff-2164-5609-3a71fd4a7257@intel.com>
Date:   Tue, 11 Jan 2022 11:46:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCHv2 1/7] mm: Add support for unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220111113314.27173-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> diff --git a/mm/memblock.c b/mm/memblock.c
> index 1018e50566f3..6dfa594192de 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1400,6 +1400,7 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>   		 */
>   		kmemleak_alloc_phys(found, size, 0, 0);
>   
> +	accept_memory(found, found + size);
>   	return found;
>   }

This could use a comment.

Looking at this, I also have to wonder if accept_memory() is a bit too 
generic.  Should it perhaps be: cc_accept_memory() or 
cc_guest_accept_memory()?

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5952749ad40..5707b4b5f774 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1064,6 +1064,7 @@ static inline void __free_one_page(struct page *page,
>   	unsigned int max_order;
>   	struct page *buddy;
>   	bool to_tail;
> +	bool offline = PageOffline(page);
>   
>   	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
>   
> @@ -1097,6 +1098,10 @@ static inline void __free_one_page(struct page *page,
>   			clear_page_guard(zone, buddy, order, migratetype);
>   		else
>   			del_page_from_free_list(buddy, zone, order);
> +
> +		if (PageOffline(buddy))
> +			offline = true;
> +
>   		combined_pfn = buddy_pfn & pfn;
>   		page = page + (combined_pfn - pfn);
>   		pfn = combined_pfn;
> @@ -1130,6 +1135,9 @@ static inline void __free_one_page(struct page *page,
>   done_merging:
>   	set_buddy_order(page, order);
>   
> +	if (offline)
> +		__SetPageOffline(page);
> +
>   	if (fpi_flags & FPI_TO_TAIL)
>   		to_tail = true;
>   	else if (is_shuffle_order(order))

This is touching some pretty hot code paths.  You mention both that 
accepting memory is slow and expensive, yet you're doing it in the core 
allocator.

That needs at least some discussion in the changelog.

> @@ -1155,7 +1163,8 @@ static inline void __free_one_page(struct page *page,
>   static inline bool page_expected_state(struct page *page,
>   					unsigned long check_flags)
>   {
> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
> +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
> +	    !PageOffline(page))
>   		return false;

Looking at stuff like this, I can't help but think that a:

	#define PageOffline PageUnaccepted

and some other renaming would be a fine idea.  I get that the Offline 
bit can be reused, but I'm not sure that the "Offline" *naming* should 
be reused.  What you're doing here is logically distinct from existing 
offlining.

>   	if (unlikely((unsigned long)page->mapping |
> @@ -1734,6 +1743,8 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
>   {
>   	if (early_page_uninitialised(pfn))
>   		return;
> +
> +	maybe_set_page_offline(page, order);
>   	__free_pages_core(page, order);
>   }
>   
> @@ -1823,10 +1834,12 @@ static void __init deferred_free_range(unsigned long pfn,
>   	if (nr_pages == pageblock_nr_pages &&
>   	    (pfn & (pageblock_nr_pages - 1)) == 0) {
>   		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> +		maybe_set_page_offline(page, pageblock_order);
>   		__free_pages_core(page, pageblock_order);
>   		return;
>   	}
>   
> +	accept_memory(pfn << PAGE_SHIFT, (pfn + nr_pages) << PAGE_SHIFT);
>   	for (i = 0; i < nr_pages; i++, page++, pfn++) {
>   		if ((pfn & (pageblock_nr_pages - 1)) == 0)
>   			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> @@ -2297,6 +2310,9 @@ static inline void expand(struct zone *zone, struct page *page,
>   		if (set_page_guard(zone, &page[size], high, migratetype))
>   			continue;
>   
> +		if (PageOffline(page))
> +			__SetPageOffline(&page[size]);

Yeah, this is really begging for comments.  Please add some.

>   		add_to_free_list(&page[size], zone, high, migratetype);
>   		set_buddy_order(&page[size], high);
>   	}
> @@ -2393,6 +2409,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>   	 */
>   	kernel_unpoison_pages(page, 1 << order);
>   
> +	if (PageOffline(page))
> +		accept_and_clear_page_offline(page, order);
> +
>   	/*
>   	 * As memory initialization might be integrated into KASAN,
>   	 * kasan_alloc_pages and kernel_init_free_pages must be

I guess once there are no more PageOffline() pages in the allocator, the 
only impact from these patches will be a bunch of conditional branches 
from the "if (PageOffline(page))" that always have the same result.  The 
branch predictors should do a good job with that.

*BUT*, that overhead is going to be universally inflicted on all users 
on x86, even those without TDX.  I guess the compiler will save non-x86 
users because they'll have an empty stub for 
accept_and_clear_page_offline() which the compiler will optimize away.

It sure would be nice to have some changelog material about why this is 
OK, though.  This is especially true since there's a global spinlock 
hidden in accept_and_clear_page_offline() wrapping a slow and "costly" 
operation.
