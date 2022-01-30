Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05A84A351C
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jan 2022 09:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245345AbiA3IQQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jan 2022 03:16:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54050 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiA3IQP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jan 2022 03:16:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7773A61035;
        Sun, 30 Jan 2022 08:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEADC340E4;
        Sun, 30 Jan 2022 08:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643530574;
        bh=Kj6ddOq5QHP7GclXHj1ybguuXq6ZA/wCuiUiRcvPprA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C1lXwqP594YRNMW+7ckFOaUsIlGP/cvWTeooFm87PdDvyg9JBfUyxHn9DYk0mFXCQ
         l7bz0kTCvbnBUZtgxQG4IJe9Pe5oNBtepfxiund2Lz6Fimv8RZ9aafY9GBPqzok2MK
         Tz9ajDj99yNwvp+o7lg37AdcTUBkEZaKrCb5Ji82/iHBdgJ74JH2qQizrdCTnLKygE
         OOji6h826y5ntPNsWranNYshvfxSLHF8rgjYEigpzu4fCgBkdTkM+0SZr9LucRdOEr
         2NQK2+G5oHEnw2NVMmzz+EOesvvmd4pwlD1vrDbFfCs2+3xah0h5wh+jWLHxuIJn8d
         nAdVT+EQTvZXA==
Date:   Sun, 30 Jan 2022 10:16:01 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/7] mm: Add support for unaccepted memory
Message-ID: <YfZJQedck2YxZcWA@kernel.org>
References: <20220128205906.27503-1-kirill.shutemov@linux.intel.com>
 <20220128205906.27503-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128205906.27503-2-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:59:00PM +0300, Kirill A. Shutemov wrote:
> UEFI Specification version 2.9 introduces the concept of memory
> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> SEV-SNP, requiring memory to be accepted before it can be used by the
> guest. Accepting happens via a protocol specific for the Virtual Machine
> platform.
> 
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
> PageBuddyUnaccepted() is used to indicate that the page requires acceptance.
> 
> Kernel only need to accept memory once after boot, so during the boot
> and warm up phase there will be a lot of memory acceptance. After things
> are settled down the only price of the feature if couple of checks for
> PageBuddyUnaccepted() in alloc and free paths. The check refers a hot
> variable (that also encodes PageBuddy()), so it is cheap and not visible
> on profiles.
> 
> Architecture has to provide three helpers if it wants to support
> unaccepted memory:
> 
>  - accept_memory() makes a range of physical addresses accepted.
> 
>  - maybe_mark_page_unaccepted() marks a page PageBuddyUnaccepted() if it
>    requires acceptance. Used during boot to put pages on free lists.
> 
>  - accept_page() makes a page accepted and clears PageBuddyUnaccepted().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/linux/page-flags.h | 27 +++++++++++++++++++++++++++
>  mm/internal.h              | 15 +++++++++++++++
>  mm/memblock.c              |  8 ++++++++
>  mm/page_alloc.c            | 23 ++++++++++++++++++++++-
>  4 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 1c3b6e5c8bfd..1bdc6b422207 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -871,6 +871,18 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
>  	page->page_type |= PG_##lname;					\
>  }
>  
> +#define PAGE_TYPE_OPS_FALSE(uname)					\
> +static __always_inline int Page##uname(struct page *page)		\
> +{									\
> +	return false;							\
> +}									\
> +static __always_inline void __SetPage##uname(struct page *page)		\
> +{									\
> +}									\
> +static __always_inline void __ClearPage##uname(struct page *page)	\
> +{									\
> +}
> +
>  /*
>   * PageBuddy() indicates that the page is free and in the buddy system
>   * (see mm/page_alloc.c).
> @@ -901,6 +913,21 @@ PAGE_TYPE_OPS(Buddy, buddy)
>   */
>  PAGE_TYPE_OPS(Offline, offline)
>  
> + /*
> +  * PageBuddyUnaccepted() indicates that the page has to be "accepted" before
> +  * it can be used. Page allocator has to call accept_page() before returning
> +  * the page to the caller.
> +  *
> +  * PageBuddyUnaccepted() encoded with the same bit as PageOffline().
> +  * PageOffline() pages are never on free list of buddy allocator, so there's
> +  * not conflict.
> +  */
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +PAGE_TYPE_OPS(BuddyUnaccepted, offline)
> +#else
> +PAGE_TYPE_OPS_FALSE(BuddyUnaccepted)
> +#endif
> +
>  extern void page_offline_freeze(void);
>  extern void page_offline_thaw(void);
>  extern void page_offline_begin(void);
> diff --git a/mm/internal.h b/mm/internal.h
> index d80300392a19..26e5d7cb6aff 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -718,4 +718,19 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
>  int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
>  		      unsigned long addr, int page_nid, int *flags);
>  
> +#ifndef CONFIG_UNACCEPTED_MEMORY
> +static inline void maybe_mark_page_unaccepted(struct page *page,
> +					      unsigned int order)
> +{
> +}
> +
> +static inline void accept_page(struct page *page, unsigned int order)
> +{
> +}
> +
> +static inline void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +}
> +#endif
> +
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 1018e50566f3..24ab07c44d4a 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1400,6 +1400,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  		 */
>  		kmemleak_alloc_phys(found, size, 0, 0);
>  
> +	/*
> +	 * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
> +	 * requiring memory to be accepted before it can be used by the

Nit:     ^ require

> +	 * guest.
> +	 *
> +	 * Accept the memory of the allocated buffer.
> +	 */
> +	accept_memory(found, found + size);

I'd appreciate an empty line here.

Otherwise

Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock

>  	return found;
>  }
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589febc6d31..27b9bd20e675 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1077,6 +1077,7 @@ static inline void __free_one_page(struct page *page,
>  	unsigned int max_order;
>  	struct page *buddy;
>  	bool to_tail;
> +	bool unaccepted = PageBuddyUnaccepted(page);
>  
>  	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
>  
> @@ -1110,6 +1111,10 @@ static inline void __free_one_page(struct page *page,
>  			clear_page_guard(zone, buddy, order, migratetype);
>  		else
>  			del_page_from_free_list(buddy, zone, order);
> +
> +		if (PageBuddyUnaccepted(buddy))
> +			unaccepted = true;
> +
>  		combined_pfn = buddy_pfn & pfn;
>  		page = page + (combined_pfn - pfn);
>  		pfn = combined_pfn;
> @@ -1143,6 +1148,10 @@ static inline void __free_one_page(struct page *page,
>  done_merging:
>  	set_buddy_order(page, order);
>  
> +	/* Mark page unaccepted if any of merged pages were unaccepted */
> +	if (unaccepted)
> +		__SetPageBuddyUnaccepted(page);
> +
>  	if (fpi_flags & FPI_TO_TAIL)
>  		to_tail = true;
>  	else if (is_shuffle_order(order))
> @@ -1168,7 +1177,8 @@ static inline void __free_one_page(struct page *page,
>  static inline bool page_expected_state(struct page *page,
>  					unsigned long check_flags)
>  {
> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
> +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
> +	    !PageBuddyUnaccepted(page))
>  		return false;
>  
>  	if (unlikely((unsigned long)page->mapping |
> @@ -1749,6 +1759,8 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
>  {
>  	if (early_page_uninitialised(pfn))
>  		return;
> +
> +	maybe_mark_page_unaccepted(page, order);
>  	__free_pages_core(page, order);
>  }
>  
> @@ -1838,10 +1850,12 @@ static void __init deferred_free_range(unsigned long pfn,
>  	if (nr_pages == pageblock_nr_pages &&
>  	    (pfn & (pageblock_nr_pages - 1)) == 0) {
>  		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> +		maybe_mark_page_unaccepted(page, pageblock_order);
>  		__free_pages_core(page, pageblock_order);
>  		return;
>  	}
>  
> +	accept_memory(pfn << PAGE_SHIFT, (pfn + nr_pages) << PAGE_SHIFT);
>  	for (i = 0; i < nr_pages; i++, page++, pfn++) {
>  		if ((pfn & (pageblock_nr_pages - 1)) == 0)
>  			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> @@ -2312,6 +2326,10 @@ static inline void expand(struct zone *zone, struct page *page,
>  		if (set_page_guard(zone, &page[size], high, migratetype))
>  			continue;
>  
> +		/* Transfer PageBuddyUnaccepted() to the newly split pages */
> +		if (PageBuddyUnaccepted(page))
> +			__SetPageBuddyUnaccepted(&page[size]);
> +
>  		add_to_free_list(&page[size], zone, high, migratetype);
>  		set_buddy_order(&page[size], high);
>  	}
> @@ -2408,6 +2426,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  	 */
>  	kernel_unpoison_pages(page, 1 << order);
>  
> +	if (PageBuddyUnaccepted(page))
> +		accept_page(page, order);
> +
>  	/*
>  	 * As memory initialization might be integrated into KASAN,
>  	 * kasan_alloc_pages and kernel_init_free_pages must be
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
