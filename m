Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AC44A37C3
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jan 2022 17:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355624AbiA3QqN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jan 2022 11:46:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:59726 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355610AbiA3QqM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 30 Jan 2022 11:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643561172; x=1675097172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iPSUyfTOWmQNxJXF3W6BUfHMnx9aMsx3QIVFSuilmwM=;
  b=GHRI8lG+1jtfjYTCN4vhxEQPm0zuhH7KaKL030eVlExBuiQuY3QTdwlW
   pGQuhD7lnIqOjDxhHWjOJdbfAdLfQltYAjCnWa5vVM4TKJ1IPjbfYfyo+
   Tnl+rfivEClDrJ2kSUkPsC7FF3HfLxH8XLM0lHM8rE82V+g5A8c4cLWyO
   /8lGDj4rTvkxtT7UpTZnnZ1gVxbWiAug8a/RkPNJeYmCQl9eNPSK9D07F
   uTz8p17XvJnHZ3gmZvcdCxNSR1KlgQb54Y5zbvnk/lmmZWZXWtiqW8RHo
   LJo/lI2kmNifEAaklpGUWXwfP0A+JkkHJPPDUZNeTYGEN03lV63fp8Cvu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="230933092"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="230933092"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 08:46:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="770566154"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jan 2022 08:46:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 36E80176; Sun, 30 Jan 2022 18:46:13 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     rppt@kernel.org
Cc:     ak@linux.intel.com, akpm@linux-foundation.org, ardb@kernel.org,
        bp@alien8.de, brijesh.singh@amd.com, dave.hansen@intel.com,
        david@redhat.com, dfaggioli@suse.com, jroedel@suse.de,
        kirill.shutemov@linux.intel.com, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org, rientjes@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, thomas.lendacky@amd.com, varad.gautam@suse.com,
        vbabka@suse.cz, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCHv3.1 1/7] mm: Add support for unaccepted memory
Date:   Sun, 30 Jan 2022 19:45:48 +0300
Message-Id: <20220130164548.40417-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YfZJQedck2YxZcWA@kernel.org>
References: <YfZJQedck2YxZcWA@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI Specification version 2.9 introduces the concept of memory
acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
SEV-SNP, requiring memory to be accepted before it can be used by the
guest. Accepting happens via a protocol specific for the Virtual Machine
platform.

Accepting memory is costly and it makes VMM allocate memory for the
accepted guest physical address range. It's better to postpone memory
acceptance until memory is needed. It lowers boot time and reduces
memory overhead.

Support of such memory requires a few changes in core-mm code:

  - memblock has to accept memory on allocation;

  - page allocator has to accept memory on the first allocation of the
    page;

Memblock change is trivial.

The page allocator is modified to accept pages on the first allocation.
PageBuddyUnaccepted() is used to indicate that the page requires acceptance.

Kernel only need to accept memory once after boot, so during the boot
and warm up phase there will be a lot of memory acceptance. After things
are settled down the only price of the feature if couple of checks for
PageBuddyUnaccepted() in alloc and free paths. The check refers a hot
variable (that also encodes PageBuddy()), so it is cheap and not visible
on profiles.

Architecture has to provide three helpers if it wants to support
unaccepted memory:

 - accept_memory() makes a range of physical addresses accepted.

 - maybe_mark_page_unaccepted() marks a page PageBuddyUnaccepted() if it
   requires acceptance. Used during boot to put pages on free lists.

 - accept_page() makes a page accepted and clears PageBuddyUnaccepted().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
---
 include/linux/page-flags.h | 27 +++++++++++++++++++++++++++
 mm/internal.h              | 15 +++++++++++++++
 mm/memblock.c              |  9 +++++++++
 mm/page_alloc.c            | 23 ++++++++++++++++++++++-
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1c3b6e5c8bfd..1bdc6b422207 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -871,6 +871,18 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
 	page->page_type |= PG_##lname;					\
 }
 
+#define PAGE_TYPE_OPS_FALSE(uname)					\
+static __always_inline int Page##uname(struct page *page)		\
+{									\
+	return false;							\
+}									\
+static __always_inline void __SetPage##uname(struct page *page)		\
+{									\
+}									\
+static __always_inline void __ClearPage##uname(struct page *page)	\
+{									\
+}
+
 /*
  * PageBuddy() indicates that the page is free and in the buddy system
  * (see mm/page_alloc.c).
@@ -901,6 +913,21 @@ PAGE_TYPE_OPS(Buddy, buddy)
  */
 PAGE_TYPE_OPS(Offline, offline)
 
+ /*
+  * PageBuddyUnaccepted() indicates that the page has to be "accepted" before
+  * it can be used. Page allocator has to call accept_page() before returning
+  * the page to the caller.
+  *
+  * PageBuddyUnaccepted() encoded with the same bit as PageOffline().
+  * PageOffline() pages are never on free list of buddy allocator, so there's
+  * not conflict.
+  */
+#ifdef CONFIG_UNACCEPTED_MEMORY
+PAGE_TYPE_OPS(BuddyUnaccepted, offline)
+#else
+PAGE_TYPE_OPS_FALSE(BuddyUnaccepted)
+#endif
+
 extern void page_offline_freeze(void);
 extern void page_offline_thaw(void);
 extern void page_offline_begin(void);
diff --git a/mm/internal.h b/mm/internal.h
index d80300392a19..26e5d7cb6aff 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -718,4 +718,19 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
+#ifndef CONFIG_UNACCEPTED_MEMORY
+static inline void maybe_mark_page_unaccepted(struct page *page,
+					      unsigned int order)
+{
+}
+
+static inline void accept_page(struct page *page, unsigned int order)
+{
+}
+
+static inline void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+}
+#endif
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index 1018e50566f3..6c109b3b2a02 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1400,6 +1400,15 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 		 */
 		kmemleak_alloc_phys(found, size, 0, 0);
 
+	/*
+	 * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
+	 * require memory to be accepted before it can be used by the
+	 * guest.
+	 *
+	 * Accept the memory of the allocated buffer.
+	 */
+	accept_memory(found, found + size);
+
 	return found;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31..27b9bd20e675 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1077,6 +1077,7 @@ static inline void __free_one_page(struct page *page,
 	unsigned int max_order;
 	struct page *buddy;
 	bool to_tail;
+	bool unaccepted = PageBuddyUnaccepted(page);
 
 	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
 
@@ -1110,6 +1111,10 @@ static inline void __free_one_page(struct page *page,
 			clear_page_guard(zone, buddy, order, migratetype);
 		else
 			del_page_from_free_list(buddy, zone, order);
+
+		if (PageBuddyUnaccepted(buddy))
+			unaccepted = true;
+
 		combined_pfn = buddy_pfn & pfn;
 		page = page + (combined_pfn - pfn);
 		pfn = combined_pfn;
@@ -1143,6 +1148,10 @@ static inline void __free_one_page(struct page *page,
 done_merging:
 	set_buddy_order(page, order);
 
+	/* Mark page unaccepted if any of merged pages were unaccepted */
+	if (unaccepted)
+		__SetPageBuddyUnaccepted(page);
+
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
 	else if (is_shuffle_order(order))
@@ -1168,7 +1177,8 @@ static inline void __free_one_page(struct page *page,
 static inline bool page_expected_state(struct page *page,
 					unsigned long check_flags)
 {
-	if (unlikely(atomic_read(&page->_mapcount) != -1))
+	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
+	    !PageBuddyUnaccepted(page))
 		return false;
 
 	if (unlikely((unsigned long)page->mapping |
@@ -1749,6 +1759,8 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 {
 	if (early_page_uninitialised(pfn))
 		return;
+
+	maybe_mark_page_unaccepted(page, order);
 	__free_pages_core(page, order);
 }
 
@@ -1838,10 +1850,12 @@ static void __init deferred_free_range(unsigned long pfn,
 	if (nr_pages == pageblock_nr_pages &&
 	    (pfn & (pageblock_nr_pages - 1)) == 0) {
 		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+		maybe_mark_page_unaccepted(page, pageblock_order);
 		__free_pages_core(page, pageblock_order);
 		return;
 	}
 
+	accept_memory(pfn << PAGE_SHIFT, (pfn + nr_pages) << PAGE_SHIFT);
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if ((pfn & (pageblock_nr_pages - 1)) == 0)
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
@@ -2312,6 +2326,10 @@ static inline void expand(struct zone *zone, struct page *page,
 		if (set_page_guard(zone, &page[size], high, migratetype))
 			continue;
 
+		/* Transfer PageBuddyUnaccepted() to the newly split pages */
+		if (PageBuddyUnaccepted(page))
+			__SetPageBuddyUnaccepted(&page[size]);
+
 		add_to_free_list(&page[size], zone, high, migratetype);
 		set_buddy_order(&page[size], high);
 	}
@@ -2408,6 +2426,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	 */
 	kernel_unpoison_pages(page, 1 << order);
 
+	if (PageBuddyUnaccepted(page))
+		accept_page(page, order);
+
 	/*
 	 * As memory initialization might be integrated into KASAN,
 	 * kasan_alloc_pages and kernel_init_free_pages must be
-- 
2.34.1

