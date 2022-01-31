Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9CD4A4F72
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jan 2022 20:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376506AbiAaTaH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jan 2022 14:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376507AbiAaTaG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jan 2022 14:30:06 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E57C06173B
        for <linux-efi@vger.kernel.org>; Mon, 31 Jan 2022 11:30:06 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id i34so8699469lfv.2
        for <linux-efi@vger.kernel.org>; Mon, 31 Jan 2022 11:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F2q3uiOVmeADpk35v856vRKGwpikKUcO3w2mwPER1ew=;
        b=xT/ytY0U4lkdoRBMvSTGF0cYxffxfMB64Q55Tlei6qj/IsxGpo3rPdJZIBAMd3aSLL
         8RxJO3IigJ7hnhxf5fHHEQasoi8CdWsXkBSZQYENVBBNrumis4ja3ww35Uq7yTkiJ3YP
         Aou0bpiwc5/UrwZ334tqPZB5ovDafWmHsDsd9XhQKwK1NEB2Okk89fLJN8es86Gp3/qE
         KM8zFoVSDrgbDK1tU5BqWDyn+6ASti4BzHT8+HJ4AcLxVlF2xhkvLl+iRgB12vkVf7pB
         CkDJUjZMrhGyadbK8SQSAy0CoTM+eqviaOyEKBlnA8ZOUMSX+eCxWdwLKqZ0DQ6XB+CP
         898Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F2q3uiOVmeADpk35v856vRKGwpikKUcO3w2mwPER1ew=;
        b=VHD3c9gwaeKRKJF/CFtg52PzTBn4Mc5T/xnfRKToIubdj+YEJmVgCxDQ/Xfedqxpqz
         vCIKvnnDgvL0g0AqmTKUiJTxPFE65iK3yRHl6W6RKookd5MOIjcNnWfQgwNWvg1KTTnO
         5Zvz9tKVvD0go+QVPNhgFeZcechdmVeAny9PSUXEQAgTZ6MRj7ej8BjX7igaqw7Kc9uH
         ZfjjYEp3zQa54RQXhrY2vy1vb2FpvNTyJSPlnVdM1FJTFaFm3QQ39haDqhLzzqHGu3S9
         53eLZaL2E1kQSO2aA2sOqtDBoXu5GMlgbcmIA+vhE/wYH4HCKIbRAOxW1bKgqya5KDR1
         Q+7A==
X-Gm-Message-State: AOAM532YJCF18b9w+bUYcSViyeTV5nlohQqgp+fOPIWscEdHdYGnFxuh
        Eqd90aTvK4dy6zvK4uYBBtXTxw==
X-Google-Smtp-Source: ABdhPJx7g/ySMySvj5rcX8e+0WdUXwQPFU/CsJrtsUWQwMJ3qo7yKxbA/8hancN9/T49MGkTEU7FFg==
X-Received: by 2002:a05:6512:6cb:: with SMTP id u11mr16201223lff.1.1643657404680;
        Mon, 31 Jan 2022 11:30:04 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f22sm3748574lfj.261.2022.01.31.11.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 11:30:03 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3480D10458C; Mon, 31 Jan 2022 22:30:41 +0300 (+03)
Date:   Mon, 31 Jan 2022 22:30:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        rppt@kernel.org, ak@linux.intel.com, akpm@linux-foundation.org,
        ardb@kernel.org, bp@alien8.de, brijesh.singh@amd.com,
        dave.hansen@intel.com, dfaggioli@suse.com, jroedel@suse.de,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        rientjes@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        varad.gautam@suse.com, vbabka@suse.cz, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv3.1 1/7] mm: Add support for unaccepted memory
Message-ID: <20220131193041.xuagyispia77ak2g@box.shutemov.name>
References: <YfZJQedck2YxZcWA@kernel.org>
 <20220130164548.40417-1-kirill.shutemov@linux.intel.com>
 <acc12d73-a7d1-014c-9c07-33251d7d07ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acc12d73-a7d1-014c-9c07-33251d7d07ee@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 31, 2022 at 01:13:49PM +0100, David Hildenbrand wrote:
> On 30.01.22 17:45, Kirill A. Shutemov wrote:
> > UEFI Specification version 2.9 introduces the concept of memory
> > acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> > SEV-SNP, requiring memory to be accepted before it can be used by the
> > guest. Accepting happens via a protocol specific for the Virtual Machine
> > platform.
> > 
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
> > PageBuddyUnaccepted() is used to indicate that the page requires acceptance.
> > 
> > Kernel only need to accept memory once after boot, so during the boot
> > and warm up phase there will be a lot of memory acceptance. After things
> > are settled down the only price of the feature if couple of checks for
> > PageBuddyUnaccepted() in alloc and free paths. The check refers a hot
> > variable (that also encodes PageBuddy()), so it is cheap and not visible
> > on profiles.
> > 
> > Architecture has to provide three helpers if it wants to support
> > unaccepted memory:
> > 
> >  - accept_memory() makes a range of physical addresses accepted.
> > 
> >  - maybe_mark_page_unaccepted() marks a page PageBuddyUnaccepted() if it
> >    requires acceptance. Used during boot to put pages on free lists.
> > 
> >  - accept_page() makes a page accepted and clears PageBuddyUnaccepted().
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
> 
> 
> You should somehow document+check+enforce that page poisoning cannot be
> enabled concurrently, because it cannot possibly work IIUC.

Looking at code again, I now think that sharing the bit with PageOffline()
is wrong. Previously I convinced myself that there's no conflict on the
bit. In the initial version of the patchset, the page acceptance happened
inside del_page_from_free_list() so any removal from the free list lead to
clearing the bit. It is not the case now when acceptance moved to
post_alloc_hook(). __isolate_free_page() and __offline_isolated_pages()
look problematic now.

I will use brand new bit for the flag and rename BuddyUnaccepted to just
Unaccepted, since it can be set with Buddy cleared.

Sounds okay?

> [...]
> 
> > + /*
> > +  * PageBuddyUnaccepted() indicates that the page has to be "accepted" before
> > +  * it can be used. Page allocator has to call accept_page() before returning
> > +  * the page to the caller.
> > +  *
> > +  * PageBuddyUnaccepted() encoded with the same bit as PageOffline().
> > +  * PageOffline() pages are never on free list of buddy allocator, so there's
> > +  * not conflict.
> > +  */
> > +#ifdef CONFIG_UNACCEPTED_MEMORY
> > +PAGE_TYPE_OPS(BuddyUnaccepted, offline)
> > +#else
> > +PAGE_TYPE_OPS_FALSE(BuddyUnaccepted)
> > +#endif
> 
> Much better.
> 
> > +
> >  extern void page_offline_freeze(void);
> >  extern void page_offline_thaw(void);
> >  extern void page_offline_begin(void);
> > diff --git a/mm/internal.h b/mm/internal.h
> > index d80300392a19..26e5d7cb6aff 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -718,4 +718,19 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
> >  int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
> >  		      unsigned long addr, int page_nid, int *flags);
> >  
> > +#ifndef CONFIG_UNACCEPTED_MEMORY
> > +static inline void maybe_mark_page_unaccepted(struct page *page,
> > +					      unsigned int order)
> > +{
> > +}
> > +
> > +static inline void accept_page(struct page *page, unsigned int order)
> > +{
> > +}
> > +
> > +static inline void accept_memory(phys_addr_t start, phys_addr_t end)
> > +{
> > +}
> > +#endif
> > +
> >  #endif	/* __MM_INTERNAL_H */
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 1018e50566f3..6c109b3b2a02 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1400,6 +1400,15 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> >  		 */
> >  		kmemleak_alloc_phys(found, size, 0, 0);
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
> > index 3589febc6d31..27b9bd20e675 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1077,6 +1077,7 @@ static inline void __free_one_page(struct page *page,
> >  	unsigned int max_order;
> >  	struct page *buddy;
> >  	bool to_tail;
> > +	bool unaccepted = PageBuddyUnaccepted(page);
> >  
> >  	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
> >  
> > @@ -1110,6 +1111,10 @@ static inline void __free_one_page(struct page *page,
> >  			clear_page_guard(zone, buddy, order, migratetype);
> >  		else
> >  			del_page_from_free_list(buddy, zone, order);
> > +
> > +		if (PageBuddyUnaccepted(buddy))
> > +			unaccepted = true;
> > +
> >  		combined_pfn = buddy_pfn & pfn;
> >  		page = page + (combined_pfn - pfn);
> >  		pfn = combined_pfn;
> > @@ -1143,6 +1148,10 @@ static inline void __free_one_page(struct page *page,
> >  done_merging:
> >  	set_buddy_order(page, order);
> >  
> > +	/* Mark page unaccepted if any of merged pages were unaccepted */
> > +	if (unaccepted)
> > +		__SetPageBuddyUnaccepted(page);
> > +
> >  	if (fpi_flags & FPI_TO_TAIL)
> >  		to_tail = true;
> >  	else if (is_shuffle_order(order))
> > @@ -1168,7 +1177,8 @@ static inline void __free_one_page(struct page *page,
> >  static inline bool page_expected_state(struct page *page,
> >  					unsigned long check_flags)
> >  {
> > -	if (unlikely(atomic_read(&page->_mapcount) != -1))
> > +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
> > +	    !PageBuddyUnaccepted(page))
> >  		return false;
> >  
> >  	if (unlikely((unsigned long)page->mapping |
> > @@ -1749,6 +1759,8 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
> >  {
> >  	if (early_page_uninitialised(pfn))
> >  		return;
> > +
> > +	maybe_mark_page_unaccepted(page, order);
> >  	__free_pages_core(page, order);
> 
> You'll be setting the page as unaccepted even before it's actually
> PageBuddy(). While that works, I wonder why we call
> maybe_mark_page_unaccepted() at these points.
> 
> Why are we not moving that deeper into the buddy? __free_pages_core() is
> used for any fresh pages that enter the buddy, used outside of
> page_alloc.c only for memory hot(un)plug, so I'd suggest moving it at
> least into there.
> 
> But maybe we'd even move it further down, to the place where we actually
> establish PageBuddy().
> 
> One idea would be adding a new FPI_UNACCEPTED flag, passing it from
> __free_pages_core() only, and calling maybe_mark_page_unaccepted() from
> __free_one_page() after set_buddy_order().
> 
> If in-lining would do its job properly, we'd be left with the
> FPI_UNACCEPTED checks only when called via __free_pages_core(), and we'd
> have that call at a single place right where we mess with PageBuddy().

Okay, this approach looks neat. See fixup below.

But there's down side: maybe_mark_page_unaccepted() cannot be __init
anymore, since it is called from __free_one_page().

Any comments?

diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index 2c4ef49a0c9b..a9ce5b918d44 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -42,7 +42,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
 }
 
-void __init maybe_mark_page_unaccepted(struct page *page, unsigned int order)
+void maybe_mark_page_unaccepted(struct page *page, unsigned int order)
 {
 	unsigned long *unaccepted_memory;
 	phys_addr_t addr = page_to_phys(page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 27b9bd20e675..389a9b5e6d63 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -121,6 +121,12 @@ typedef int __bitwise fpi_t;
  */
 #define FPI_SKIP_KASAN_POISON	((__force fpi_t)BIT(2))
 
+/*
+ * Check if the page needs to be marked as PageBuddyUnaccepted().
+ * Used for the new pages added to the buddy allocator for the first time.
+ */
+#define FPI_UNACCEPTED		((__force fpi_t)BIT(3))
+
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
@@ -1148,9 +1154,17 @@ static inline void __free_one_page(struct page *page,
 done_merging:
 	set_buddy_order(page, order);
 
-	/* Mark page unaccepted if any of merged pages were unaccepted */
-	if (unaccepted)
+	if (unaccepted) {
+		/* Mark page unaccepted if any of merged pages were unaccepted */
 		__SetPageBuddyUnaccepted(page);
+	} else if (fpi_flags & FPI_UNACCEPTED) {
+		/*
+		 * Check if the page needs to be marked as PageBuddyUnaccepted().
+		 * Used for the new pages added to the buddy allocator for the
+		 * first time.
+		 */
+		maybe_mark_page_unaccepted(page, order);
+	}
 
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
@@ -1699,7 +1713,8 @@ void __free_pages_core(struct page *page, unsigned int order)
 	 * Bypass PCP and place fresh pages right to the tail, primarily
 	 * relevant for memory onlining.
 	 */
-	__free_pages_ok(page, order, FPI_TO_TAIL | FPI_SKIP_KASAN_POISON);
+	__free_pages_ok(page, order,
+			FPI_TO_TAIL | FPI_SKIP_KASAN_POISON | FPI_UNACCEPTED);
 }
 
 #ifdef CONFIG_NUMA
@@ -1760,7 +1775,6 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 	if (early_page_uninitialised(pfn))
 		return;
 
-	maybe_mark_page_unaccepted(page, order);
 	__free_pages_core(page, order);
 }
 
@@ -1850,7 +1864,6 @@ static void __init deferred_free_range(unsigned long pfn,
 	if (nr_pages == pageblock_nr_pages &&
 	    (pfn & (pageblock_nr_pages - 1)) == 0) {
 		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-		maybe_mark_page_unaccepted(page, pageblock_order);
 		__free_pages_core(page, pageblock_order);
 		return;
 	}
-- 
 Kirill A. Shutemov
