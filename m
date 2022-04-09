Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD1B4FA95E
	for <lists+linux-efi@lfdr.de>; Sat,  9 Apr 2022 17:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiDIPzF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 9 Apr 2022 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiDIPzE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 9 Apr 2022 11:55:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2901C7F
        for <linux-efi@vger.kernel.org>; Sat,  9 Apr 2022 08:52:56 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k21so19731830lfe.4
        for <linux-efi@vger.kernel.org>; Sat, 09 Apr 2022 08:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hipyA+VdoCYs/q6L4fybzDyFBHWJqPMIOpZlgArjiq0=;
        b=Ki0Lb8Vdq3QXgufsULBVyMXZx1RCC0kaYN+83epHTLYepnUs9zjn2U+VLzp2nfnMQh
         6XERa6etXb/gsln+X3GURJeYdl0S9r4d3gaUVtw0P0MB0ZozcAIbdTxLcAFav2UbllHf
         0SEz5T8ZnKdKpJxUtnzPySqpWcuuW3piKVNdWidyFggh9iZxmn05PCgPA6JgGPbELHZb
         HiAzWF3l+G5sjrcLtaCqoh4EJl8BQRT+ugQIE6MJQAYAD4huqhrBE5RqiTmYzO65udba
         323WLeW/HXcX8C3kOp60LASrixUE/uWn+aKbI7JTMemxme+/vvdHtPi+6+XLX1xFqy/M
         VpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hipyA+VdoCYs/q6L4fybzDyFBHWJqPMIOpZlgArjiq0=;
        b=YVbZf6fy+MQMB9nx8lPaoX7YKXYkj8whFZqz/sTvMiL7jmog59TVwzxt0fab9mvdbz
         6pnQVsy8QfxAFcyCnh85ImmRtDu/bGULlp/iAmaEYKKALD/ZUyXK9P4KCF87lp5rUg/0
         HIdBhjUwVaXs+kuv4syX4Wew4+XAFD1Mbg2gLHeHTZp9/tS3ZI1VfIddMxuOs62tWvy3
         vrnG53lcwHAfeSgEdLd+PvBx9r+2S7YW00UuvTMSTG8ieWovnfnTk0VoAFcdwfXliS9p
         0bcdTJQFMBy7mNq7B0CXJMg0tyJbZR/l2426Q78jWH9iVQHBKR/OFnABPKW2PKvzwYgm
         TqEA==
X-Gm-Message-State: AOAM5300KkWLS8aGb86gauyZR1ZxRfX984aMvNd/FiKNvL+K4pfAVK6H
        ZbG0PLiR5HcXhyYVpo5aX6YxeA==
X-Google-Smtp-Source: ABdhPJyZ70SN8H4VNEmJK6kJ9+nC4blt10fHCvsKTIXf+GtYppcgMkdb1rNhz3C337ZokhxLhD+w/w==
X-Received: by 2002:a05:6512:3b8c:b0:46b:9446:422b with SMTP id g12-20020a0565123b8c00b0046b9446422bmr1653894lfv.381.1649519574966;
        Sat, 09 Apr 2022 08:52:54 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o18-20020a2e9b52000000b0024af0b04d04sm2582983ljj.1.2022.04.09.08.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 08:52:52 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E44BC1039DB; Sat,  9 Apr 2022 18:54:23 +0300 (+03)
Date:   Sat, 9 Apr 2022 18:54:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
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
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
Message-ID: <20220409155423.iv2arckmvavvpegt@box.shutemov.name>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <767c2100-c171-1fd3-6a92-0af2e4bf3067@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <767c2100-c171-1fd3-6a92-0af2e4bf3067@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 08, 2022 at 11:55:43AM -0700, Dave Hansen wrote:
> On 4/5/22 16:43, Kirill A. Shutemov wrote:
> > UEFI Specification version 2.9 introduces the concept of memory
> > acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> > SEV-SNP, requiring memory to be accepted before it can be used by the
> 
> 		^ require

Heh. That's wording form the spec.

> > guest. Accepting happens via a protocol specific for the Virtual Machine
> > platform.
> 
> 							^ s/for/to
> 
> > Accepting memory is costly and it makes VMM allocate memory for the
> > accepted guest physical address range. It's better to postpone memory
> > acceptance until memory is needed. It lowers boot time and reduces
> > memory overhead.
> > 
> > Support of such memory requires a few changes in core-mm code:
> > 
> >   - memblock has to accept memory on allocation;
> > 
> >   - page allocator has to accept memory on the first allocation of the
> >     page;
> > 
> > Memblock change is trivial.
> > 
> > The page allocator is modified to accept pages on the first allocation.
> > PageUnaccepted() is used to indicate that the page requires acceptance.
> 
> Does this consume an actual page flag or is it aliased?

It is encoded as a page type in mapcount of unallocated memory. It is not
aliased with PageOffline() as I did before.

I will mention that it is a new page type.

> > Kernel only needs to accept memory once after boot, so during the boot
> > and warm up phase there will be a lot of memory acceptance. After things
> > are settled down the only price of the feature if couple of checks for
> > PageUnaccepted() in allocate and free paths. The check refers a hot
> 
> 							       ^ to
> 
> ...
> > + /*
> > +  * PageUnaccepted() indicates that the page has to be "accepted" before it can
> > +  * be used. Page allocator has to call accept_page() before returning the page
> > +  * to the caller.
> > +  */
> 
> Let's talk about "used" with a bit more detail.  Maybe:
> 
> /*
>  * PageUnaccepted() indicates that the page has to be "accepted" before
>  * it can be read or written.  The page allocator must to call
>  * accept_page() before touching the page or returning it to the caller.
>  */

I guess s/must to call/must call/, right?

> ...
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 2db95780e003..53f4aa1c92a7 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -121,6 +121,12 @@ typedef int __bitwise fpi_t;
> >   */
> >  #define FPI_SKIP_KASAN_POISON	((__force fpi_t)BIT(2))
> >  
> > +/*
> > + * Check if the page needs to be marked as PageUnaccepted().
> > + * Used for the new pages added to the buddy allocator for the first time.
> > + */
> > +#define FPI_UNACCEPTED		((__force fpi_t)BIT(3))
> > +
> >  /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
> >  static DEFINE_MUTEX(pcp_batch_high_lock);
> >  #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
> > @@ -1023,6 +1029,26 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
> >  	return page_is_buddy(higher_page, higher_buddy, order + 1);
> >  }
> >  
> > +static void accept_page(struct page *page, unsigned int order)
> > +{
> > +	phys_addr_t start = page_to_phys(page);
> > +	int i;
> > +
> > +	accept_memory(start, start + (PAGE_SIZE << order));
> > +
> > +	for (i = 0; i < (1 << order); i++) {
> > +		if (PageUnaccepted(page + i))
> > +			__ClearPageUnaccepted(page + i);
> > +	}
> > +}
> 
> It's probably worth a comment somewhere that this can be really slow.
> 
> > +static bool page_is_unaccepted(struct page *page, unsigned int order)
> > +{
> > +	phys_addr_t start = page_to_phys(page);
> > +
> > +	return memory_is_unaccepted(start, start + (PAGE_SIZE << order));
> > +}
> > +
> >  /*
> >   * Freeing function for a buddy system allocator.
> >   *
> > @@ -1058,6 +1084,7 @@ static inline void __free_one_page(struct page *page,
> >  	unsigned long combined_pfn;
> >  	struct page *buddy;
> >  	bool to_tail;
> > +	bool unaccepted = PageUnaccepted(page);
> >  
> >  	VM_BUG_ON(!zone_is_initialized(zone));
> >  	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
> > @@ -1089,6 +1116,11 @@ static inline void __free_one_page(struct page *page,
> >  			clear_page_guard(zone, buddy, order, migratetype);
> >  		else
> >  			del_page_from_free_list(buddy, zone, order);
> > +
> > +		/* Mark page unaccepted if any of merged pages were unaccepted */
> > +		if (PageUnaccepted(buddy))
> > +			unaccepted = true;
> 
> Naming nit: following the logic with a double-negative like !unaccepted
> is a bit hard.  Would this be more readable if it were:
> 
> 	bool page_needs_acceptance = PageUnaccepted(page);
> 
> and then the code below...
> 
> >  		combined_pfn = buddy_pfn & pfn;
> >  		page = page + (combined_pfn - pfn);
> >  		pfn = combined_pfn;
> > @@ -1124,6 +1156,17 @@ static inline void __free_one_page(struct page *page,
> >  done_merging:
> >  	set_buddy_order(page, order);
> >  
> > +	/*
> > +	 * Check if the page needs to be marked as PageUnaccepted().
> > +	 * Used for the new pages added to the buddy allocator for the first
> > +	 * time.
> > +	 */
> > +	if (!unaccepted && (fpi_flags & FPI_UNACCEPTED))
> > +		unaccepted = page_is_unaccepted(page, order);
> 
> 	if (page_needs_acceptance && (fpi_flags & FPI_UNACCEPTED))
> 		page_needs_acceptance = page_is_unaccepted(page, order);
> 
> > +	if (unaccepted)
> > +		__SetPageUnaccepted(page);
> 
> This is getting hard for me to follow.
> 
> There are:
> 1. Pages that come in here with PageUnaccepted()==1
> 2. Pages that come in here with PageUnaccepted()==0, but a buddy that
>    was PageUnaccepted()==1
> 
> In either of those cases, the bitmap will be consulted to see if the
> page is *truly* unaccepted or not.  But, I'm struggling to figure out
> how a page could end up in one of those scenarios and *not* be
> page_is_unaccepted().
> 
> There are three pieces of information that come in:
> 1. PageUnaccepted(page)
> 2. PageUnaccepted(buddies[])
> 3. the bitmap

1 and 2 are the same conceptionally: merged-in pieces of the resulting page.

> 
> and one piece of information going out:
> 
> PageUnaccepted(page);
> 
> I think I need a more coherent description of how those four things fit
> together.

The page gets marked as PageUnaccepted() if any of merged-in pages is
PageUnaccepted().

For new pages, just being added to buddy allocator, consult
page_is_unaccepted(). FPI_UNACCEPTED indicates that the page is new and
page_is_unaccepted() check is required.

Avoid calling page_is_unaccepted() if it is known that the page needs
acceptance anyway. It can be costly.

Is it good enough explanation?

FPI_UNACCEPTED is not a good name. Any help with a better one?
FPI_CHECK_UNACCEPTED?

> >  	if (fpi_flags & FPI_TO_TAIL)
> >  		to_tail = true;
> >  	else if (is_shuffle_order(order))
> > @@ -1149,7 +1192,8 @@ static inline void __free_one_page(struct page *page,
> >  static inline bool page_expected_state(struct page *page,
> >  					unsigned long check_flags)
> >  {
> > -	if (unlikely(atomic_read(&page->_mapcount) != -1))
> > +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
> > +	    !PageUnaccepted(page))
> >  		return false;
> 
> That probably deserves a comment, and maybe its own if() statement.

Own if does not work. PageUnaccepted() is encoded in _mapcount.

What about this:

	/*
	 * page->_mapcount is expected to be -1.
	 *
	 * There is an exception for PageUnaccepted(). The page type can be set
	 * for pages on free list. Page types are encoded in _mapcount.
	 *
	 * PageUnaccepted() will get cleared in post_alloc_hook().
	 */
	if (unlikely((atomic_read(&page->_mapcount) | PG_unaccepted) != -1))
		return false;

?

> >  	if (unlikely((unsigned long)page->mapping |
> > @@ -1654,7 +1698,8 @@ void __free_pages_core(struct page *page, unsigned int order)
> >  	 * Bypass PCP and place fresh pages right to the tail, primarily
> >  	 * relevant for memory onlining.
> >  	 */
> > -	__free_pages_ok(page, order, FPI_TO_TAIL | FPI_SKIP_KASAN_POISON);
> > +	__free_pages_ok(page, order,
> > +			FPI_TO_TAIL | FPI_SKIP_KASAN_POISON | FPI_UNACCEPTED);
> >  }
> >  
> >  #ifdef CONFIG_NUMA
> > @@ -1807,6 +1852,7 @@ static void __init deferred_free_range(unsigned long pfn,
> >  		return;
> >  	}
> >  
> > +	accept_memory(pfn << PAGE_SHIFT, (pfn + nr_pages) << PAGE_SHIFT);
> >  	for (i = 0; i < nr_pages; i++, page++, pfn++) {
> >  		if ((pfn & (pageblock_nr_pages - 1)) == 0)
> >  			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> 
> Comment, please.  I assume doing the slow accept up front is OK here
> because this is in the deferred path.  But, it would be nice to know for
> sure.

It is acceptance of smaller than page block upfront. I will add a comment.

> 
> > @@ -2266,6 +2312,10 @@ static inline void expand(struct zone *zone, struct page *page,
> >  		if (set_page_guard(zone, &page[size], high, migratetype))
> >  			continue;
> >  
> > +		/* Transfer PageUnaccepted() to the newly split pages */
> > +		if (PageUnaccepted(page))
> > +			__SetPageUnaccepted(&page[size]);
> 
> We don't want to just accept the page here, right?  Because we're
> holding the zone lock?  Maybe we should mention that:
> 
> 		/*
> 		 * Transfer PageUnaccepted() to the newly split pages so
> 		 * they can be accepted after dropping the zone lock.
> 		 */

Okay.

> >  		add_to_free_list(&page[size], zone, high, migratetype);
> >  		set_buddy_order(&page[size], high);
> >  	}
> > @@ -2396,6 +2446,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
> >  	 */
> >  	kernel_unpoison_pages(page, 1 << order);
> >  
> > +	if (PageUnaccepted(page))
> > +		accept_page(page, order);
> > +
> >  	/*
> >  	 * As memory initialization might be integrated into KASAN,
> >  	 * KASAN unpoisoning and memory initializion code must be
> 
> Is accepted memory guaranteed to be zeroed?  Do we want to skip the
> __GFP_ZERO behavior later in this function?  Or is that just a silly
> over-optimization?

For TDX, it is true that the memory gets cleared on acceptance, but I
don't we can say the same for any possible implementation.

I would rather leave __GFP_ZERO for peace of mind. Clearing the cache-hot
page for the second time shouldn't be a big deal comparing to acceptance
cost.

-- 
 Kirill A. Shutemov
