Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84986488F4
	for <lists+linux-efi@lfdr.de>; Fri,  9 Dec 2022 20:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLIT00 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Dec 2022 14:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLIT0Z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Dec 2022 14:26:25 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F4FA1995;
        Fri,  9 Dec 2022 11:26:23 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1F4455C004A;
        Fri,  9 Dec 2022 14:26:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 09 Dec 2022 14:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670613981; x=1670700381; bh=nQ
        d2rxX92Z496VFYXmRTYHuMzUOKtggtx5EpHFAxONQ=; b=utc5B0rRcA+M/q1SYL
        nX6f3lq4Q5iuzCn8M+18hDa8JyK3YZOvzm81QeapTzgSucQHwYUz2FUZgA8ycOk7
        8S97CF41YVvzliZBWkMdE0gYMUpsSfjPLGyHwLSKqrt25sLrMH4rwQDRYBl3c40L
        Oxvn38uBD9783XXYANEB/ssp/qiIZdb/JGNig7vfUI1ah2oolwO8WWdj21yEj+kw
        blSVmKHsIhT63xsUcuk/2syKJ8OsMoEGSxdWntV6Up0uiEbibEnG01gByRifptOG
        QC7honiXt74Zq8BzeWCXDeengkHyRcUxmsdCMKsnJnAah7KBnXYKyw1FI5amqbm2
        lZ1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670613981; x=1670700381; bh=nQd2rxX92Z496VFYXmRTYHuMzUOK
        tggtx5EpHFAxONQ=; b=nstVt/UjijqOS2YjjJ8cixSSC3TlPqtmCpn32RbW1r23
        RDvT48qFEE8G+YggFC88k4p/HiSvgb15MYBEh1LLRG22T5fYD/9zYWwfdnKLQO4x
        YrFlRySzupWa+nwFdCaVAO8y24y6HXBbDjwrOUDRCUh5PWSXG2u+lMPAGa59o3je
        6IMUAGQor4fRfYOwM2y+AmB0Bs6seO7XHt5eDscQXZTPM2HeHuFuycVASosZlMDP
        H3hwfNsU0pQThfz3Wl8lBgPPqZe/QPK/8xbyLPr3WzY+MItEnwtAr6jTIZIjuCU4
        LDtRodREJKXlHRJLPqz7WBufw7x5OCTjGDJ5qfoPTw==
X-ME-Sender: <xms:24uTY6zi5iuLfQqz97maJwUeFx4VOnuO5QHk-GmEdg1jvgpmYm_dRg>
    <xme:24uTY2Qne4djmFVqedwTo---Q8meZ_qdOH_E8LndPpfgOiunC8sdNnzitVB8aCvYH
    wanP39YgZYbfil6j_Q>
X-ME-Received: <xmr:24uTY8X1Y1ScsfyychY_72m5TjzYHqhPYyxhJG7kBndrDgAueqDfvhRVZaGa4QX6BR4kaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:24uTYwgP3mn4ZIuySKmEz6EPFJnBJ5fgXsQDbnZtqutcONZCAmF5Iw>
    <xmx:24uTY8BasZy8srVy69FDl-DxzDQRz02eBkfDJkeiOhFa77VkgwOuKQ>
    <xmx:24uTYxLA8rgvKWLeUr7_JOEYLyrkbvRZD2ft6naIG-nzSg9lXqO-nw>
    <xmx:3YuTY8uiM3t7vMhNYcbAi0lQa6C3713xnjase6rNTVyd0LNKVoqfGg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Dec 2022 14:26:19 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 33A5A109CE2; Fri,  9 Dec 2022 22:26:16 +0300 (+03)
Date:   Fri, 9 Dec 2022 22:26:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv8 02/14] mm: Add support for unaccepted memory
Message-ID: <20221209192616.dg4cbe7mgh3axv5h@box.shutemov.name>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
 <20221207014933.8435-3-kirill.shutemov@linux.intel.com>
 <f944459f-76a6-60c3-7dae-0918d9ef0c5d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f944459f-76a6-60c3-7dae-0918d9ef0c5d@suse.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 09, 2022 at 07:10:25PM +0100, Vlastimil Babka wrote:
> On 12/7/22 02:49, Kirill A. Shutemov wrote:
> > UEFI Specification version 2.9 introduces the concept of memory
> > acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> > SEV-SNP, require memory to be accepted before it can be used by the
> > guest. Accepting happens via a protocol specific to the Virtual Machine
> > platform.
> > 
> > There are several ways kernel can deal with unaccepted memory:
> > 
> >  1. Accept all the memory during the boot. It is easy to implement and
> >     it doesn't have runtime cost once the system is booted. The downside
> >     is very long boot time.
> > 
> >     Accept can be parallelized to multiple CPUs to keep it manageable
> >     (i.e. via DEFERRED_STRUCT_PAGE_INIT), but it tends to saturate
> >     memory bandwidth and does not scale beyond the point.
> > 
> >  2. Accept a block of memory on the first use. It requires more
> >     infrastructure and changes in page allocator to make it work, but
> >     it provides good boot time.
> > 
> >     On-demand memory accept means latency spikes every time kernel steps
> >     onto a new memory block. The spikes will go away once workload data
> >     set size gets stabilized or all memory gets accepted.
> > 
> >  3. Accept all memory in background. Introduce a thread (or multiple)
> >     that gets memory accepted proactively. It will minimize time the
> >     system experience latency spikes on memory allocation while keeping
> >     low boot time.
> > 
> >     This approach cannot function on its own. It is an extension of #2:
> >     background memory acceptance requires functional scheduler, but the
> >     page allocator may need to tap into unaccepted memory before that.
> > 
> >     The downside of the approach is that these threads also steal CPU
> >     cycles and memory bandwidth from the user's workload and may hurt
> >     user experience.
> > 
> > Implement #2 for now. It is a reasonable default. Some workloads may
> > want to use #1 or #3 and they can be implemented later based on user's
> > demands.
> > 
> > Support of unaccepted memory requires a few changes in core-mm code:
> > 
> >   - memblock has to accept memory on allocation;
> > 
> >   - page allocator has to accept memory on the first allocation of the
> >     page;
> > 
> > Memblock change is trivial.
> > 
> > The page allocator is modified to accept pages. New memory gets accepted
> > before putting pages on free lists. It is done lazily: only accept new
> > pages when we run out of already accepted memory.
> > 
> > Architecture has to provide two helpers if it wants to support
> > unaccepted memory:
> > 
> >  - accept_memory() makes a range of physical addresses accepted.
> > 
> >  - range_contains_unaccepted_memory() checks anything within the range
> >    of physical addresses requires acceptance.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
> 
> Hi,
> 
> the intrusiveness to page allocator seems to be much better in this version
> than in the older ones, thanks!
> 
> > ---
> >  include/linux/mmzone.h     |   5 ++
> >  include/linux/page-flags.h |  24 ++++++++
> >  mm/internal.h              |  12 ++++
> >  mm/memblock.c              |   9 +++
> >  mm/page_alloc.c            | 119 +++++++++++++++++++++++++++++++++++++
> >  5 files changed, 169 insertions(+)
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 5f74891556f3..da335381e63f 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -822,6 +822,11 @@ struct zone {
> >  	/* free areas of different sizes */
> >  	struct free_area	free_area[MAX_ORDER];
> >  
> > +#ifdef CONFIG_UNACCEPTED_MEMORY
> > +	/* pages to be accepted */
> > +	struct list_head	unaccepted_pages;
> > +#endif
> > +
> >  	/* zone flags, see below */
> >  	unsigned long		flags;
> >  
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 0b0ae5084e60..ce953be8fe10 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -941,6 +941,7 @@ static inline bool is_page_hwpoison(struct page *page)
> >  #define PG_offline	0x00000100
> >  #define PG_table	0x00000200
> >  #define PG_guard	0x00000400
> > +#define PG_unaccepted	0x00000800
> >  
> >  #define PageType(page, flag)						\
> >  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> > @@ -966,6 +967,18 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
> >  	page->page_type |= PG_##lname;					\
> >  }
> >  
> > +#define PAGE_TYPE_OPS_FALSE(uname)					\
> > +static __always_inline int Page##uname(struct page *page)		\
> > +{									\
> > +	return false;							\
> > +}									\
> > +static __always_inline void __SetPage##uname(struct page *page)		\
> > +{									\
> > +}									\
> > +static __always_inline void __ClearPage##uname(struct page *page)	\
> > +{									\
> > +}
> 
> Wonder if we need this. The page type is defined regardless of
> CONFIG_UNACCEPTED_MEMORY and with CONFIG_UNACCEPTED_MEMORY=n nobody will be
> actually be setting or checking the type, so we can simply just keep the
> "real" implementations?

Okay. Makes sense.

> > +
> >  /*
> >   * PageBuddy() indicates that the page is free and in the buddy system
> >   * (see mm/page_alloc.c).
> > @@ -996,6 +1009,17 @@ PAGE_TYPE_OPS(Buddy, buddy)
> >   */
> >  PAGE_TYPE_OPS(Offline, offline)
> >  
> > +/*
> > + * PageUnaccepted() indicates that the page has to be "accepted" before it can
> > + * be read or written. The page allocator must call accept_page() before
> > + * touching the page or returning it to the caller.
> > + */
> > +#ifdef CONFIG_UNACCEPTED_MEMORY
> > +PAGE_TYPE_OPS(Unaccepted, unaccepted)
> > +#else
> > +PAGE_TYPE_OPS_FALSE(Unaccepted)
> > +#endif
> > +
> >  extern void page_offline_freeze(void);
> >  extern void page_offline_thaw(void);
> >  extern void page_offline_begin(void);
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 6b7ef495b56d..8ef4f88608ad 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -856,4 +856,16 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
> >  	return !(vma->vm_flags & VM_SOFTDIRTY);
> >  }
> >  
> > +#ifndef CONFIG_UNACCEPTED_MEMORY
> > +static inline bool range_contains_unaccepted_memory(phys_addr_t start,
> > +						    phys_addr_t end)
> > +{
> > +	return false;
> > +}
> > +
> > +static inline void accept_memory(phys_addr_t start, phys_addr_t end)
> > +{
> > +}
> > +#endif
> > +
> >  #endif	/* __MM_INTERNAL_H */
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 511d4783dcf1..3bc404a5352a 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1423,6 +1423,15 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> >  		 */
> >  		kmemleak_alloc_phys(found, size, 0);
> >  
> > +	/*
> > +	 * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
> > +	 * require memory to be accepted before it can be used by the
> > +	 * guest.
> > +	 *
> > +	 * Accept the memory of the allocated buffer.
> > +	 */
> > +	accept_memory(found, found + size);
> > +
> >  	return found;
> >  }
> >  
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 6e60657875d3..6d597e833a73 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -450,6 +450,11 @@ EXPORT_SYMBOL(nr_online_nodes);
> >  
> >  int page_group_by_mobility_disabled __read_mostly;
> >  
> > +#ifdef CONFIG_UNACCEPTED_MEMORY
> > +/* Counts number of zones with unaccepted pages. */
> > +static DEFINE_STATIC_KEY_FALSE(unaccepted_pages);
> > +#endif
> > +
> >  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> >  /*
> >   * During boot we initialize deferred pages on-demand, as needed, but once
> > @@ -1043,12 +1048,15 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
> >  {
> >  	struct free_area *area = &zone->free_area[order];
> >  
> > +	VM_BUG_ON_PAGE(PageUnevictable(page), page);
> 
> Hm I think we're not allowed to do VM_BUG_ON anymore per some semi-recent
> thread with Linus, as new BUG_ONs are forbidden in general, and Fedora
> builds with DEBUG_VM. So probably use VM_WARN_ON everywhere and bail out
> where feasible (i.e. probably not here).

Okay, I can downgrade it to VM_WARN_ON_PAGE(), but it will crash soon
after anyway. On the first access to the supposedly free page that
unaccepted.

> >  	list_move_tail(&page->buddy_list, &area->free_list[migratetype]);
> >  }
> >  
> >  static inline void del_page_from_free_list(struct page *page, struct zone *zone,
> >  					   unsigned int order)
> >  {
> > +	VM_BUG_ON_PAGE(PageUnevictable(page), page);
> > +
> >  	/* clear reported state and update reported page count */
> >  	if (page_reported(page))
> >  		__ClearPageReported(page);
> > @@ -1728,6 +1736,97 @@ static void __free_pages_ok(struct page *page, unsigned int order,
> >  	__count_vm_events(PGFREE, 1 << order);
> >  }
> >  
> > +static bool page_contains_unaccepted(struct page *page, unsigned int order)
> > +{
> > +	phys_addr_t start = page_to_phys(page);
> > +	phys_addr_t end = start + (PAGE_SIZE << order);
> > +
> > +	return range_contains_unaccepted_memory(start, end);
> > +}
> > +
> > +static void accept_page(struct page *page, unsigned int order)
> > +{
> > +	phys_addr_t start = page_to_phys(page);
> > +
> > +	accept_memory(start, start + (PAGE_SIZE << order));
> > +}
> > +
> > +#ifdef CONFIG_UNACCEPTED_MEMORY
> > +
> > +static bool try_to_accept_memory(struct zone *zone)
> > +{
> > +	unsigned long flags, order;
> > +	struct page *page;
> > +	bool last = false;
> > +	int migratetype;
> > +
> > +	if (!static_branch_unlikely(&unaccepted_pages))
> > +		return false;
> > +
> > +	spin_lock_irqsave(&zone->lock, flags);
> > +	page = list_first_entry_or_null(&zone->unaccepted_pages,
> > +					struct page, lru);
> > +	if (!page) {
> > +		spin_unlock_irqrestore(&zone->lock, flags);
> > +		return false;
> > +	}
> > +
> > +	list_del(&page->lru);
> > +	last = list_empty(&zone->unaccepted_pages);
> > +
> > +	order = page->private;
> > +	VM_BUG_ON(order > MAX_ORDER || order < pageblock_order);
> > +
> > +	migratetype = get_pfnblock_migratetype(page, page_to_pfn(page));
> > +	__mod_zone_freepage_state(zone, -1 << order, migratetype);
> > +	spin_unlock_irqrestore(&zone->lock, flags);
> > +
> > +	if (last)
> > +		static_branch_dec(&unaccepted_pages);
> > +
> > +	accept_page(page, order);
> > +	__ClearPageUnaccepted(page);
> > +	__free_pages_ok(page, order, FPI_TO_TAIL | FPI_SKIP_KASAN_POISON);
> > +
> > +	return true;
> > +}
> > +
> > +static void __free_unaccepted(struct page *page, unsigned int order)
> > +{
> > +	struct zone *zone = page_zone(page);
> > +	unsigned long flags;
> > +	int migratetype;
> > +	bool first = false;
> > +
> > +	VM_BUG_ON(order > MAX_ORDER || order < pageblock_order);
> > +	__SetPageUnaccepted(page);
> > +	page->private = order;
> > +
> > +	spin_lock_irqsave(&zone->lock, flags);
> > +	first = list_empty(&zone->unaccepted_pages);
> > +	migratetype = get_pfnblock_migratetype(page, page_to_pfn(page));
> > +	list_add_tail(&page->lru, &zone->unaccepted_pages);
> > +	__mod_zone_freepage_state(zone, 1 << order, migratetype);
> > +	spin_unlock_irqrestore(&zone->lock, flags);
> > +
> > +	if (first)
> > +		static_branch_inc(&unaccepted_pages);
> > +}
> > +
> > +#else
> > +
> > +static bool try_to_accept_memory(struct zone *zone)
> > +{
> > +	return false;
> > +}
> > +
> > +static void __free_unaccepted(struct page *page, unsigned int order)
> > +{
> > +	BUILD_BUG();
> > +}
> > +
> > +#endif /* CONFIG_UNACCEPTED_MEMORY */
> > +
> >  void __free_pages_core(struct page *page, unsigned int order)
> >  {
> >  	unsigned int nr_pages = 1 << order;
> > @@ -1750,6 +1849,13 @@ void __free_pages_core(struct page *page, unsigned int order)
> >  
> >  	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
> >  
> > +	if (page_contains_unaccepted(page, order)) {
> > +		if (order >= pageblock_order)
> > +			return __free_unaccepted(page, order);
> 
> Would it be better to only do this when all pages are unaccepted, and accept
> all of them as long as at least one in there is already accepted? Or not
> worth the trouble of making page_contains_unaccepted() actually count all of
> them, which would be necessary.

I don't think it worth the change.

This is going to be corner case that affect few pages that happened to be
on the border between unaccepted and accepted memory. It makes no
difference in practice.

> > +		else
> > +			accept_page(page, order);
> > +	}
> > +
> >  	/*
> >  	 * Bypass PCP and place fresh pages right to the tail, primarily
> >  	 * relevant for memory onlining.
> > @@ -1910,6 +2016,9 @@ static void __init deferred_free_range(unsigned long pfn,
> >  		return;
> >  	}
> >  
> > +	/* Accept chunks smaller than page-block upfront */
> > +	accept_memory(PFN_PHYS(pfn), PFN_PHYS(pfn + nr_pages));
> > +
> >  	for (i = 0; i < nr_pages; i++, page++, pfn++) {
> >  		if (pageblock_aligned(pfn))
> >  			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> > @@ -4247,6 +4356,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
> >  				       gfp_mask)) {
> >  			int ret;
> >  
> > +			if (try_to_accept_memory(zone))
> > +				goto try_this_zone;
> 
> 
> This is under !zone_watermark_fast(), but as unaccepted pages are counted as
> free pages, then I think this is unlikely to trigger in practice AFAIU as we
> should therefore be passing the watermarks even if pages are unaccepted.
> 
> That's (intentionally IIRC) different from deferred init which doesn't count
> the pages as free until they are initialized.

It is intentional in sense that we don't want to accept pages proactively.
Deferred init need to be finished before userspace starts.

> >  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> >  			/*
> >  			 * Watermark failed for this zone, but see if we can
> > @@ -4299,6 +4411,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
> >  
> >  			return page;
> >  		} else {
> > +			if (try_to_accept_memory(zone))
> > +				goto try_this_zone;
> 
> On the other hand, here we failed the full rmqueue(), including the
> potentially fragmenting fallbacks, so I'm worried that before we finally
> fail all of that and resort to accepting more memory, we already fragmented
> the already accepted memory, more than necessary.

I'm not sure I follow. We accept memory in pageblock chunks. Do we want to
allocate from a free pageblock if we have other memory to tap from? It
doesn't make sense to me.

> So one way to prevent would be to move the acceptance into rmqueue() to
> happen before __rmqueue_fallback(), which I originally had in mind and maybe
> suggested that previously.

I guess it should be pretty straight forward to fail __rmqueue_fallback()
if there's non-empty unaccepted_pages list and steer to
try_to_accept_memory() this way.

But I still don't understand why.

> But maybe less intrusive and more robust way would be to track how much
> memory is unaccepted, and actually decrement that amount  from free memory
> in zone_watermark_fast() in order to force earlier failure of that check and
> thus to accept more memory and give us a buffer of truly accepted and
> available memory up to high watermark, which should hopefully prevent most
> of the fallbacks. Then the code I flagged above as currently unecessary
> would make perfect sense.

The next patch adds per-node unaccepted memory accounting. We can move it
per-zone if it would help.

> And maybe Mel will have some ideas as well.

I don't have much expertise in page allocator. Any input is valuable.

> > +
> >  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> >  			/* Try again if zone has deferred pages */
> >  			if (static_branch_unlikely(&deferred_pages)) {
> > @@ -6935,6 +7050,10 @@ static void __meminit zone_init_free_lists(struct zone *zone)
> >  		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
> >  		zone->free_area[order].nr_free = 0;
> >  	}
> > +
> > +#ifdef CONFIG_UNACCEPTED_MEMORY
> > +	INIT_LIST_HEAD(&zone->unaccepted_pages);
> > +#endif
> >  }
> >  
> >  /*
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
