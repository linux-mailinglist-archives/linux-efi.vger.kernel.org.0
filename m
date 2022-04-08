Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEEF4F9D5C
	for <lists+linux-efi@lfdr.de>; Fri,  8 Apr 2022 20:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiDHS6E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Apr 2022 14:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239191AbiDHS5v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Apr 2022 14:57:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BE91B60E4;
        Fri,  8 Apr 2022 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649444147; x=1680980147;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=jeF8CC6CYVdLywq4UaXPKYUk87tu72pqbVJTNPs4600=;
  b=UZswd2LqzCS3cPTR8RiX9aDV/4T3F6JXLQIZIGsUZcRgqN0H56ZgeaqA
   cwO/KahpSCio3HXquXaDswDT3P7Dcwd133bqoENLOXBaDkpMFlQdNvfHM
   f/LVZtQYS4NCxfLeYLB5eyNvRQ2FddATn6+EfxAgMOgt+Mi/C2IcSxl4G
   DTOXVwf2uoeOhP7cO8EW+K2gsSF1ccabVyscrHrSEQpHY4Wm5Ibx054GC
   Zkim5A9RuFcJpuDCghNsxAmV1lzcSzLHhHMTg1S12RRxM7Yll1Ajym+KG
   nXzqfx2PvxOlt0flmMcPhy3LzpCZtBBvjbEDt9mC6+iBiWk+BTIk6AEii
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="259262666"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="259262666"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:55:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="525487576"
Received: from tsungtae-mobl.amr.corp.intel.com (HELO [10.134.43.198]) ([10.134.43.198])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:55:39 -0700
Message-ID: <767c2100-c171-1fd3-6a92-0af2e4bf3067@intel.com>
Date:   Fri, 8 Apr 2022 11:55:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
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
        Dario Faggioli <dfaggioli@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
In-Reply-To: <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/5/22 16:43, Kirill A. Shutemov wrote:
> UEFI Specification version 2.9 introduces the concept of memory
> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> SEV-SNP, requiring memory to be accepted before it can be used by the

		^ require

> guest. Accepting happens via a protocol specific for the Virtual Machine
> platform.

							^ s/for/to

> Accepting memory is costly and it makes VMM allocate memory for the
> accepted guest physical address range. It's better to postpone memory
> acceptance until memory is needed. It lowers boot time and reduces
> memory overhead.
> 
> Support of such memory requires a few changes in core-mm code:
> 
>   - memblock has to accept memory on allocation;
> 
>   - page allocator has to accept memory on the first allocation of the
>     page;
> 
> Memblock change is trivial.
> 
> The page allocator is modified to accept pages on the first allocation.
> PageUnaccepted() is used to indicate that the page requires acceptance.

Does this consume an actual page flag or is it aliased?

> Kernel only needs to accept memory once after boot, so during the boot
> and warm up phase there will be a lot of memory acceptance. After things
> are settled down the only price of the feature if couple of checks for
> PageUnaccepted() in allocate and free paths. The check refers a hot

							       ^ to

...
> + /*
> +  * PageUnaccepted() indicates that the page has to be "accepted" before it can
> +  * be used. Page allocator has to call accept_page() before returning the page
> +  * to the caller.
> +  */

Let's talk about "used" with a bit more detail.  Maybe:

/*
 * PageUnaccepted() indicates that the page has to be "accepted" before
 * it can be read or written.  The page allocator must to call
 * accept_page() before touching the page or returning it to the caller.
 */

...
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2db95780e003..53f4aa1c92a7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -121,6 +121,12 @@ typedef int __bitwise fpi_t;
>   */
>  #define FPI_SKIP_KASAN_POISON	((__force fpi_t)BIT(2))
>  
> +/*
> + * Check if the page needs to be marked as PageUnaccepted().
> + * Used for the new pages added to the buddy allocator for the first time.
> + */
> +#define FPI_UNACCEPTED		((__force fpi_t)BIT(3))
> +
>  /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
>  static DEFINE_MUTEX(pcp_batch_high_lock);
>  #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
> @@ -1023,6 +1029,26 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
>  	return page_is_buddy(higher_page, higher_buddy, order + 1);
>  }
>  
> +static void accept_page(struct page *page, unsigned int order)
> +{
> +	phys_addr_t start = page_to_phys(page);
> +	int i;
> +
> +	accept_memory(start, start + (PAGE_SIZE << order));
> +
> +	for (i = 0; i < (1 << order); i++) {
> +		if (PageUnaccepted(page + i))
> +			__ClearPageUnaccepted(page + i);
> +	}
> +}

It's probably worth a comment somewhere that this can be really slow.

> +static bool page_is_unaccepted(struct page *page, unsigned int order)
> +{
> +	phys_addr_t start = page_to_phys(page);
> +
> +	return memory_is_unaccepted(start, start + (PAGE_SIZE << order));
> +}
> +
>  /*
>   * Freeing function for a buddy system allocator.
>   *
> @@ -1058,6 +1084,7 @@ static inline void __free_one_page(struct page *page,
>  	unsigned long combined_pfn;
>  	struct page *buddy;
>  	bool to_tail;
> +	bool unaccepted = PageUnaccepted(page);
>  
>  	VM_BUG_ON(!zone_is_initialized(zone));
>  	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
> @@ -1089,6 +1116,11 @@ static inline void __free_one_page(struct page *page,
>  			clear_page_guard(zone, buddy, order, migratetype);
>  		else
>  			del_page_from_free_list(buddy, zone, order);
> +
> +		/* Mark page unaccepted if any of merged pages were unaccepted */
> +		if (PageUnaccepted(buddy))
> +			unaccepted = true;

Naming nit: following the logic with a double-negative like !unaccepted
is a bit hard.  Would this be more readable if it were:

	bool page_needs_acceptance = PageUnaccepted(page);

and then the code below...

>  		combined_pfn = buddy_pfn & pfn;
>  		page = page + (combined_pfn - pfn);
>  		pfn = combined_pfn;
> @@ -1124,6 +1156,17 @@ static inline void __free_one_page(struct page *page,
>  done_merging:
>  	set_buddy_order(page, order);
>  
> +	/*
> +	 * Check if the page needs to be marked as PageUnaccepted().
> +	 * Used for the new pages added to the buddy allocator for the first
> +	 * time.
> +	 */
> +	if (!unaccepted && (fpi_flags & FPI_UNACCEPTED))
> +		unaccepted = page_is_unaccepted(page, order);

	if (page_needs_acceptance && (fpi_flags & FPI_UNACCEPTED))
		page_needs_acceptance = page_is_unaccepted(page, order);

> +	if (unaccepted)
> +		__SetPageUnaccepted(page);

This is getting hard for me to follow.

There are:
1. Pages that come in here with PageUnaccepted()==1
2. Pages that come in here with PageUnaccepted()==0, but a buddy that
   was PageUnaccepted()==1

In either of those cases, the bitmap will be consulted to see if the
page is *truly* unaccepted or not.  But, I'm struggling to figure out
how a page could end up in one of those scenarios and *not* be
page_is_unaccepted().

There are three pieces of information that come in:
1. PageUnaccepted(page)
2. PageUnaccepted(buddies[])
3. the bitmap

and one piece of information going out:

PageUnaccepted(page);

I think I need a more coherent description of how those four things fit
together.

>  	if (fpi_flags & FPI_TO_TAIL)
>  		to_tail = true;
>  	else if (is_shuffle_order(order))
> @@ -1149,7 +1192,8 @@ static inline void __free_one_page(struct page *page,
>  static inline bool page_expected_state(struct page *page,
>  					unsigned long check_flags)
>  {
> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
> +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
> +	    !PageUnaccepted(page))
>  		return false;

That probably deserves a comment, and maybe its own if() statement.

>  	if (unlikely((unsigned long)page->mapping |
> @@ -1654,7 +1698,8 @@ void __free_pages_core(struct page *page, unsigned int order)
>  	 * Bypass PCP and place fresh pages right to the tail, primarily
>  	 * relevant for memory onlining.
>  	 */
> -	__free_pages_ok(page, order, FPI_TO_TAIL | FPI_SKIP_KASAN_POISON);
> +	__free_pages_ok(page, order,
> +			FPI_TO_TAIL | FPI_SKIP_KASAN_POISON | FPI_UNACCEPTED);
>  }
>  
>  #ifdef CONFIG_NUMA
> @@ -1807,6 +1852,7 @@ static void __init deferred_free_range(unsigned long pfn,
>  		return;
>  	}
>  
> +	accept_memory(pfn << PAGE_SHIFT, (pfn + nr_pages) << PAGE_SHIFT);
>  	for (i = 0; i < nr_pages; i++, page++, pfn++) {
>  		if ((pfn & (pageblock_nr_pages - 1)) == 0)
>  			set_pageblock_migratetype(page, MIGRATE_MOVABLE);

Comment, please.  I assume doing the slow accept up front is OK here
because this is in the deferred path.  But, it would be nice to know for
sure.

> @@ -2266,6 +2312,10 @@ static inline void expand(struct zone *zone, struct page *page,
>  		if (set_page_guard(zone, &page[size], high, migratetype))
>  			continue;
>  
> +		/* Transfer PageUnaccepted() to the newly split pages */
> +		if (PageUnaccepted(page))
> +			__SetPageUnaccepted(&page[size]);

We don't want to just accept the page here, right?  Because we're
holding the zone lock?  Maybe we should mention that:

		/*
		 * Transfer PageUnaccepted() to the newly split pages so
		 * they can be accepted after dropping the zone lock.
		 */

>  		add_to_free_list(&page[size], zone, high, migratetype);
>  		set_buddy_order(&page[size], high);
>  	}
> @@ -2396,6 +2446,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  	 */
>  	kernel_unpoison_pages(page, 1 << order);
>  
> +	if (PageUnaccepted(page))
> +		accept_page(page, order);
> +
>  	/*
>  	 * As memory initialization might be integrated into KASAN,
>  	 * KASAN unpoisoning and memory initializion code must be

Is accepted memory guaranteed to be zeroed?  Do we want to skip the
__GFP_ZERO behavior later in this function?  Or is that just a silly
over-optimization?
