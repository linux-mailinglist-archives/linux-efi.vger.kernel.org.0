Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C874F53F8
	for <lists+linux-efi@lfdr.de>; Wed,  6 Apr 2022 06:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350035AbiDFEFY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Apr 2022 00:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1850045AbiDFCrJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Apr 2022 22:47:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D50294A33;
        Tue,  5 Apr 2022 16:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649202521; x=1680738521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bHjOpRF0FH9a4fKmacsGbqTcyKL/garGb9vIFX8+JmU=;
  b=d2xudDnw/rXJ16zDW0kypN9CMrA754m4j6/tOfQCQhtBDx+ExaF7Y9gM
   jned6Y5a6Ksz2EUEdFoBdN3G35SjMhhhxUT4K0xFoOwmnzmc9B+sOVfz2
   5TC6T0u2rVE2my18epAkxVKqVLiUc4V36WnWVdPE03PF0pOAPPz1XAwsO
   mth46lQIxPKDm9OTvY3vWsHoZfhwKPZlyRpmS2ei1qHw3ACYk8Lp5dkmk
   1//wGmIEU5PhHxOK0SqobObFBopSWtp9hzhklLMkSkGz5mXbp31ww3vcx
   ZxYaXlt+BoIo7YeeudVT6PyUWlc4qoBow1B9z8uBVyR+Ktmm4+H89hdFZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="258479964"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="258479964"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:48:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="556723611"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Apr 2022 16:48:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 838195C; Wed,  6 Apr 2022 02:43:47 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCHv4 1/8] mm: Add support for unaccepted memory
Date:   Wed,  6 Apr 2022 02:43:36 +0300
Message-Id: <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
PageUnaccepted() is used to indicate that the page requires acceptance.

Kernel only needs to accept memory once after boot, so during the boot
and warm up phase there will be a lot of memory acceptance. After things
are settled down the only price of the feature if couple of checks for
PageUnaccepted() in allocate and free paths. The check refers a hot
variable (that also encodes PageBuddy()), so it is cheap and not visible
on profiles.

Architecture has to provide two helpers if it wants to support
unaccepted memory:

 - accept_memory() makes a range of physical addresses accepted.

 - memory_is_unaccepted() checks anything within the range of physical
   addresses requires acceptance.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
---
 include/linux/page-flags.h | 24 ++++++++++++++++
 mm/internal.h              | 11 ++++++++
 mm/memblock.c              |  9 ++++++
 mm/page_alloc.c            | 57 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 9d8eeaa67d05..aaaedc111092 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -928,6 +928,7 @@ static inline bool is_page_hwpoison(struct page *page)
 #define PG_offline	0x00000100
 #define PG_table	0x00000200
 #define PG_guard	0x00000400
+#define PG_unaccepted	0x00000800
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
@@ -953,6 +954,18 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
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
@@ -983,6 +996,17 @@ PAGE_TYPE_OPS(Buddy, buddy)
  */
 PAGE_TYPE_OPS(Offline, offline)
 
+ /*
+  * PageUnaccepted() indicates that the page has to be "accepted" before it can
+  * be used. Page allocator has to call accept_page() before returning the page
+  * to the caller.
+  */
+#ifdef CONFIG_UNACCEPTED_MEMORY
+PAGE_TYPE_OPS(Unaccepted, unaccepted)
+#else
+PAGE_TYPE_OPS_FALSE(Unaccepted)
+#endif
+
 extern void page_offline_freeze(void);
 extern void page_offline_thaw(void);
 extern void page_offline_begin(void);
diff --git a/mm/internal.h b/mm/internal.h
index cf16280ce132..10302fe857c4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -758,4 +758,15 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
 
 DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
+#ifndef CONFIG_UNACCEPTED_MEMORY
+static inline bool memory_is_unaccepted(phys_addr_t start, phys_addr_t end)
+{
+	return false;
+}
+
+static inline void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+}
+#endif
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index e4f03a6e8e56..a1f7f8b304d5 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1405,6 +1405,15 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
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
index 2db95780e003..53f4aa1c92a7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -121,6 +121,12 @@ typedef int __bitwise fpi_t;
  */
 #define FPI_SKIP_KASAN_POISON	((__force fpi_t)BIT(2))
 
+/*
+ * Check if the page needs to be marked as PageUnaccepted().
+ * Used for the new pages added to the buddy allocator for the first time.
+ */
+#define FPI_UNACCEPTED		((__force fpi_t)BIT(3))
+
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
@@ -1023,6 +1029,26 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
 	return page_is_buddy(higher_page, higher_buddy, order + 1);
 }
 
+static void accept_page(struct page *page, unsigned int order)
+{
+	phys_addr_t start = page_to_phys(page);
+	int i;
+
+	accept_memory(start, start + (PAGE_SIZE << order));
+
+	for (i = 0; i < (1 << order); i++) {
+		if (PageUnaccepted(page + i))
+			__ClearPageUnaccepted(page + i);
+	}
+}
+
+static bool page_is_unaccepted(struct page *page, unsigned int order)
+{
+	phys_addr_t start = page_to_phys(page);
+
+	return memory_is_unaccepted(start, start + (PAGE_SIZE << order));
+}
+
 /*
  * Freeing function for a buddy system allocator.
  *
@@ -1058,6 +1084,7 @@ static inline void __free_one_page(struct page *page,
 	unsigned long combined_pfn;
 	struct page *buddy;
 	bool to_tail;
+	bool unaccepted = PageUnaccepted(page);
 
 	VM_BUG_ON(!zone_is_initialized(zone));
 	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
@@ -1089,6 +1116,11 @@ static inline void __free_one_page(struct page *page,
 			clear_page_guard(zone, buddy, order, migratetype);
 		else
 			del_page_from_free_list(buddy, zone, order);
+
+		/* Mark page unaccepted if any of merged pages were unaccepted */
+		if (PageUnaccepted(buddy))
+			unaccepted = true;
+
 		combined_pfn = buddy_pfn & pfn;
 		page = page + (combined_pfn - pfn);
 		pfn = combined_pfn;
@@ -1124,6 +1156,17 @@ static inline void __free_one_page(struct page *page,
 done_merging:
 	set_buddy_order(page, order);
 
+	/*
+	 * Check if the page needs to be marked as PageUnaccepted().
+	 * Used for the new pages added to the buddy allocator for the first
+	 * time.
+	 */
+	if (!unaccepted && (fpi_flags & FPI_UNACCEPTED))
+		unaccepted = page_is_unaccepted(page, order);
+
+	if (unaccepted)
+		__SetPageUnaccepted(page);
+
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
 	else if (is_shuffle_order(order))
@@ -1149,7 +1192,8 @@ static inline void __free_one_page(struct page *page,
 static inline bool page_expected_state(struct page *page,
 					unsigned long check_flags)
 {
-	if (unlikely(atomic_read(&page->_mapcount) != -1))
+	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
+	    !PageUnaccepted(page))
 		return false;
 
 	if (unlikely((unsigned long)page->mapping |
@@ -1654,7 +1698,8 @@ void __free_pages_core(struct page *page, unsigned int order)
 	 * Bypass PCP and place fresh pages right to the tail, primarily
 	 * relevant for memory onlining.
 	 */
-	__free_pages_ok(page, order, FPI_TO_TAIL | FPI_SKIP_KASAN_POISON);
+	__free_pages_ok(page, order,
+			FPI_TO_TAIL | FPI_SKIP_KASAN_POISON | FPI_UNACCEPTED);
 }
 
 #ifdef CONFIG_NUMA
@@ -1807,6 +1852,7 @@ static void __init deferred_free_range(unsigned long pfn,
 		return;
 	}
 
+	accept_memory(pfn << PAGE_SHIFT, (pfn + nr_pages) << PAGE_SHIFT);
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if ((pfn & (pageblock_nr_pages - 1)) == 0)
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
@@ -2266,6 +2312,10 @@ static inline void expand(struct zone *zone, struct page *page,
 		if (set_page_guard(zone, &page[size], high, migratetype))
 			continue;
 
+		/* Transfer PageUnaccepted() to the newly split pages */
+		if (PageUnaccepted(page))
+			__SetPageUnaccepted(&page[size]);
+
 		add_to_free_list(&page[size], zone, high, migratetype);
 		set_buddy_order(&page[size], high);
 	}
@@ -2396,6 +2446,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	 */
 	kernel_unpoison_pages(page, 1 << order);
 
+	if (PageUnaccepted(page))
+		accept_page(page, order);
+
 	/*
 	 * As memory initialization might be integrated into KASAN,
 	 * KASAN unpoisoning and memory initializion code must be
-- 
2.35.1

