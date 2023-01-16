Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8FC66BF7F
	for <lists+linux-efi@lfdr.de>; Mon, 16 Jan 2023 14:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjAPNQg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Jan 2023 08:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjAPNQR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Jan 2023 08:16:17 -0500
X-Greylist: delayed 570 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Jan 2023 05:14:12 PST
Received: from outbound-smtp22.blacknight.com (outbound-smtp22.blacknight.com [81.17.249.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56739C6
        for <linux-efi@vger.kernel.org>; Mon, 16 Jan 2023 05:14:12 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 6239FBABA0
        for <linux-efi@vger.kernel.org>; Mon, 16 Jan 2023 13:04:41 +0000 (GMT)
Received: (qmail 29400 invoked from network); 16 Jan 2023 13:04:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Jan 2023 13:04:40 -0000
Date:   Mon, 16 Jan 2023 13:04:37 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
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
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv8 02/14] mm: Add support for unaccepted memory
Message-ID: <20230116130437.pm5fsmcmmo2q7uzz@techsingularity.net>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
 <20221207014933.8435-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221207014933.8435-3-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 07, 2022 at 04:49:21AM +0300, Kirill A. Shutemov wrote:
> UEFI Specification version 2.9 introduces the concept of memory
> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> SEV-SNP, require memory to be accepted before it can be used by the
> guest. Accepting happens via a protocol specific to the Virtual Machine
> platform.
> 
> There are several ways kernel can deal with unaccepted memory:
> 
>  1. Accept all the memory during the boot. It is easy to implement and
>     it doesn't have runtime cost once the system is booted. The downside
>     is very long boot time.
> 
>     Accept can be parallelized to multiple CPUs to keep it manageable
>     (i.e. via DEFERRED_STRUCT_PAGE_INIT), but it tends to saturate
>     memory bandwidth and does not scale beyond the point.
> 

This should be an option via kernel command line if at all possible as soon
as possible because if issues like fragmentation show up as highlighted by
Vlastimil, then there will be need to do a comparison.  Furthermore, while
boot time is the primary focus of this series, it ignores ramp-up time of
an application that ultimately uses a high percentage of memory. A latency
sensitive application that stalls while accepting memory during ramp-up
may be more undesirable than a long boot time because it's unpredictable.
While it's not exactly the same, sometimes similar happens for ext4 for
lazy inode init after filesystem creation and this feature can be disabled
because it screws with benchmarks based on fresh filesystems. That problem
only happens on every filesystem init though, not every boot.

>  2. Accept a block of memory on the first use. It requires more
>     infrastructure and changes in page allocator to make it work, but
>     it provides good boot time.
> 
>     On-demand memory accept means latency spikes every time kernel steps
>     onto a new memory block. The spikes will go away once workload data
>     set size gets stabilized or all memory gets accepted.
> 

For very large machines (and > 1TB virtual machines do exist), this may
take a long time.

>  3. Accept all memory in background. Introduce a thread (or multiple)
>     that gets memory accepted proactively. It will minimize time the
>     system experience latency spikes on memory allocation while keeping
>     low boot time.
> 
>     This approach cannot function on its own. It is an extension of #2:
>     background memory acceptance requires functional scheduler, but the
>     page allocator may need to tap into unaccepted memory before that.
> 
>     The downside of the approach is that these threads also steal CPU
>     cycles and memory bandwidth from the user's workload and may hurt
>     user experience.
> 

This is not necessarily true, while the background thread (or threads,
one per zone using one local CPU) are running an allocation request
could block on a waitqueue until the background thread makes progress.
That means the application would only stall if the background thread
is too slow or there are too many allocation requests. With that setup,
it would be possible that an application never blocks on accepting memory.


> Implement #2 for now. It is a reasonable default. Some workloads may
> want to use #1 or #3 and they can be implemented later based on user's
> demands.
> 
> Support of unaccepted memory requires a few changes in core-mm code:
> 
>   - memblock has to accept memory on allocation;
> 
>   - page allocator has to accept memory on the first allocation of the
>     page;
> 
> Memblock change is trivial.
> 
> The page allocator is modified to accept pages. New memory gets accepted
> before putting pages on free lists. It is done lazily: only accept new
> pages when we run out of already accepted memory.
> 

And this is the primary disadvantage between 2 and 3, stalls are guaranteed
for some allocating tasks until all memory is accepted.

> Architecture has to provide two helpers if it wants to support
> unaccepted memory:
> 
>  - accept_memory() makes a range of physical addresses accepted.
> 

accept_memory is introduced later in the series and it's an arch-specfic
decision on what range to accept. pageblock order would be the miminum
to help fragmentation avoidance but MAX_ORDER-1 would make more sense.
MAX_ORDER-1 would amortise the cost of acceptance, reduce potential issues
with fragmentation and reduce the total number of stalls required to
accept memory. The minimum range to accept should be generically enforced
in accept_memory that calls arch_accept_memory with the range. accept_page
-> accept_memory is fine but the core->arch_specific divide should be clear.

>  - range_contains_unaccepted_memory() checks anything within the range
>    of physical addresses requires acceptance.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
> ---
>  include/linux/mmzone.h     |   5 ++
>  include/linux/page-flags.h |  24 ++++++++
>  mm/internal.h              |  12 ++++
>  mm/memblock.c              |   9 +++
>  mm/page_alloc.c            | 119 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 169 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 5f74891556f3..da335381e63f 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -822,6 +822,11 @@ struct zone {
>  	/* free areas of different sizes */
>  	struct free_area	free_area[MAX_ORDER];
>  
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +	/* pages to be accepted */
> +	struct list_head	unaccepted_pages;
> +#endif
> +

If MAX_ORDER-1 ranges were accepted at a time, it could be documented that the
list_head only contains orders of pages of a fixed size.

>  	/* zone flags, see below */
>  	unsigned long		flags;
>  
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 0b0ae5084e60..ce953be8fe10 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -941,6 +941,7 @@ static inline bool is_page_hwpoison(struct page *page)
>  #define PG_offline	0x00000100
>  #define PG_table	0x00000200
>  #define PG_guard	0x00000400
> +#define PG_unaccepted	0x00000800
>  
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> @@ -966,6 +967,18 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
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
> @@ -996,6 +1009,17 @@ PAGE_TYPE_OPS(Buddy, buddy)
>   */
>  PAGE_TYPE_OPS(Offline, offline)
>  
> +/*
> + * PageUnaccepted() indicates that the page has to be "accepted" before it can
> + * be read or written. The page allocator must call accept_page() before
> + * touching the page or returning it to the caller.
> + */
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +PAGE_TYPE_OPS(Unaccepted, unaccepted)
> +#else
> +PAGE_TYPE_OPS_FALSE(Unaccepted)
> +#endif
> +
>  extern void page_offline_freeze(void);
>  extern void page_offline_thaw(void);
>  extern void page_offline_begin(void);
> diff --git a/mm/internal.h b/mm/internal.h
> index 6b7ef495b56d..8ef4f88608ad 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -856,4 +856,16 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
>  	return !(vma->vm_flags & VM_SOFTDIRTY);
>  }
>  
> +#ifndef CONFIG_UNACCEPTED_MEMORY
> +static inline bool range_contains_unaccepted_memory(phys_addr_t start,
> +						    phys_addr_t end)
> +{
> +	return false;
> +}
> +
> +static inline void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +}
> +#endif
> +
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 511d4783dcf1..3bc404a5352a 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1423,6 +1423,15 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  		 */
>  		kmemleak_alloc_phys(found, size, 0);
>  
> +	/*
> +	 * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
> +	 * require memory to be accepted before it can be used by the
> +	 * guest.
> +	 *
> +	 * Accept the memory of the allocated buffer.
> +	 */
> +	accept_memory(found, found + size);
> +
>  	return found;
>  }
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6e60657875d3..6d597e833a73 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -450,6 +450,11 @@ EXPORT_SYMBOL(nr_online_nodes);
>  
>  int page_group_by_mobility_disabled __read_mostly;
>  
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +/* Counts number of zones with unaccepted pages. */
> +static DEFINE_STATIC_KEY_FALSE(unaccepted_pages);
> +#endif
> +
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  /*
>   * During boot we initialize deferred pages on-demand, as needed, but once
> @@ -1043,12 +1048,15 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
>  {
>  	struct free_area *area = &zone->free_area[order];
>  
> +	VM_BUG_ON_PAGE(PageUnevictable(page), page);
>  	list_move_tail(&page->buddy_list, &area->free_list[migratetype]);
>  }
>  
>  static inline void del_page_from_free_list(struct page *page, struct zone *zone,
>  					   unsigned int order)
>  {
> +	VM_BUG_ON_PAGE(PageUnevictable(page), page);
> +
>  	/* clear reported state and update reported page count */
>  	if (page_reported(page))
>  		__ClearPageReported(page);

Aside from what Vlastimil said, it's not commented *why* these VM_BUG_ON_PAGE
(or WARN) could trigger and why Unevitable specifically. It could be a long
time after these patches are merged before they are used in production so if
it does happen, it'd be nice to have a comment explaining why it could occur.

> @@ -1728,6 +1736,97 @@ static void __free_pages_ok(struct page *page, unsigned int order,
>  	__count_vm_events(PGFREE, 1 << order);
>  }
>  
> +static bool page_contains_unaccepted(struct page *page, unsigned int order)
> +{
> +	phys_addr_t start = page_to_phys(page);
> +	phys_addr_t end = start + (PAGE_SIZE << order);
> +
> +	return range_contains_unaccepted_memory(start, end);
> +}
> +

If pages are accepted in MAX_ORDER-1 ranges enforced by the core, it'll
not be necessary to check ranges as 1 page will be enough to know the
whole block needs to be accepted.

> +static void accept_page(struct page *page, unsigned int order)
> +{
> +	phys_addr_t start = page_to_phys(page);
> +
> +	accept_memory(start, start + (PAGE_SIZE << order));
> +}
> +

Generically enforce a minimum range -- MAX_ORDER-1 recommended.

> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +
> +static bool try_to_accept_memory(struct zone *zone)
> +{
> +	unsigned long flags, order;
> +	struct page *page;
> +	bool last = false;
> +	int migratetype;
> +
> +	if (!static_branch_unlikely(&unaccepted_pages))
> +		return false;
> +
> +	spin_lock_irqsave(&zone->lock, flags);
> +	page = list_first_entry_or_null(&zone->unaccepted_pages,
> +					struct page, lru);
> +	if (!page) {
> +		spin_unlock_irqrestore(&zone->lock, flags);
> +		return false;
> +	}
> +

Probably could check this first locklessly as unaccepted pages only go down,
never up unless memory hotplug is a factor?

> +	list_del(&page->lru);
> +	last = list_empty(&zone->unaccepted_pages);
> +
> +	order = page->private;

If blocks are released in fixed sizes or MAX_ORDER-1 then order is
irrelevant.

> +	VM_BUG_ON(order > MAX_ORDER || order < pageblock_order);
> +
> +	migratetype = get_pfnblock_migratetype(page, page_to_pfn(page));

As is the migration type because the migration type will become the type
that splits at least a pageblock for the first time.

> +	__mod_zone_freepage_state(zone, -1 << order, migratetype);
> +	spin_unlock_irqrestore(&zone->lock, flags);
> +
> +	if (last)
> +		static_branch_dec(&unaccepted_pages);
> +
> +	accept_page(page, order);
> +	__ClearPageUnaccepted(page);
> +	__free_pages_ok(page, order, FPI_TO_TAIL | FPI_SKIP_KASAN_POISON);
> +

If accept_page returns the first struct page of the block freed then this
can be simplified. The corner case for zone boundaries or holes within a zone
that are not MAX_ORDER-1 should be accepted unconditionally in early boot.

> +	return true;
> +}
> +
> +static void __free_unaccepted(struct page *page, unsigned int order)
> +{
> +	struct zone *zone = page_zone(page);
> +	unsigned long flags;
> +	int migratetype;
> +	bool first = false;
> +
> +	VM_BUG_ON(order > MAX_ORDER || order < pageblock_order);

Regardless of forced alignment, this should be a WARN_ON and bail. It's most
likely early in boot and if it affects 1 machine, it'll happen every time.

> +	__SetPageUnaccepted(page);
> +	page->private = order;
> +
> +	spin_lock_irqsave(&zone->lock, flags);
> +	first = list_empty(&zone->unaccepted_pages);
> +	migratetype = get_pfnblock_migratetype(page, page_to_pfn(page));
> +	list_add_tail(&page->lru, &zone->unaccepted_pages);
> +	__mod_zone_freepage_state(zone, 1 << order, migratetype);
> +	spin_unlock_irqrestore(&zone->lock, flags);
> +

Enforcing alignment would also simplify fragmentation handling here.

> +	if (first)
> +		static_branch_inc(&unaccepted_pages);
> +}
> +
> +#else
> +
> +static bool try_to_accept_memory(struct zone *zone)
> +{
> +	return false;
> +}
> +
> +static void __free_unaccepted(struct page *page, unsigned int order)
> +{
> +	BUILD_BUG();
> +}
> +
> +#endif /* CONFIG_UNACCEPTED_MEMORY */
> +
>  void __free_pages_core(struct page *page, unsigned int order)
>  {
>  	unsigned int nr_pages = 1 << order;
> @@ -1750,6 +1849,13 @@ void __free_pages_core(struct page *page, unsigned int order)
>  
>  	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
>  
> +	if (page_contains_unaccepted(page, order)) {
> +		if (order >= pageblock_order)
> +			return __free_unaccepted(page, order);
> +		else
> +			accept_page(page, order);
> +	}
> +

If MAX_ORDER-1 is the minimum for acceptance then this changes. It would
have to be checked if this is a zone boundary and if so, accept the
pages immediately with a comment, otherwise add a MAX_ORDER-1 page to the
unaccepted list.

>  	/*
>  	 * Bypass PCP and place fresh pages right to the tail, primarily
>  	 * relevant for memory onlining.
> @@ -1910,6 +2016,9 @@ static void __init deferred_free_range(unsigned long pfn,
>  		return;
>  	}
>  
> +	/* Accept chunks smaller than page-block upfront */
> +	accept_memory(PFN_PHYS(pfn), PFN_PHYS(pfn + nr_pages));
> +
>  	for (i = 0; i < nr_pages; i++, page++, pfn++) {
>  		if (pageblock_aligned(pfn))
>  			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> @@ -4247,6 +4356,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  				       gfp_mask)) {
>  			int ret;
>  
> +			if (try_to_accept_memory(zone))
> +				goto try_this_zone;
> +

This is a potential fragmentation hazard because by the time this
is reached, the watermarks are low. By then, pageblocks potentially
became mixed due to __rmqueue_fallback and the mixing of blocks may be
persistent. __rmqueue_fallback should fail if there is still unaccepted
memory.

That said, what you have here is fine, it's just not enough to avoid
the hazard on its own.

>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  			/*
>  			 * Watermark failed for this zone, but see if we can
> @@ -4299,6 +4411,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  
>  			return page;
>  		} else {
> +			if (try_to_accept_memory(zone))
> +				goto try_this_zone;
> +

This has a similar problem, fallbacks could have already occurred. By
forbidding fallbacks until all memory within a zone is accepted, this
should be less of an issue because NULL will be returned, more memory is
accepted and it retries. It'll be a little race prone as another request
could allocate the newly accepted memory before the retry but it would
eventually be resolved.

Vlastimil was correct in terms of how to gauge how serious fragmentation
issues are early-on. Tracking /proc/pagetypeinfo helps but is hard to
use because it has no information on mixed pageblocks. It's better to
track mm_page_alloc_extfrag and at the very least, count the number of
times this happens when all memory is accepted up-front versus deferred
acceptance. Any major difference in counts is potentially problematic.

At the very least, a kernel build with all CPUs early in boot would be a
start. Slightly better would be to run the number of a number of separate
kernel builds that uses a high percentage of memory. As the allocations
are a good mix, but short-lived, it would also help to run fio in the
background creating many 4K files to overally generate a mix of page
tables allocations, slab and movable allocs, some of which are short-lived
from kernbench and others that are more persisent due to fio. I don't
have something suitable automated in mmtests at the moment as it's been
a while since I investigated fragmentation specifically and the old tests
took too long to complete on larger systems.

>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  			/* Try again if zone has deferred pages */
>  			if (static_branch_unlikely(&deferred_pages)) {
> @@ -6935,6 +7050,10 @@ static void __meminit zone_init_free_lists(struct zone *zone)
>  		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
>  		zone->free_area[order].nr_free = 0;
>  	}
> +
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +	INIT_LIST_HEAD(&zone->unaccepted_pages);
> +#endif
>  }
>  
>  /*
> -- 
> 2.38.0
> 

-- 
Mel Gorman
SUSE Labs
