Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41729701A7F
	for <lists+linux-efi@lfdr.de>; Sun, 14 May 2023 00:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjEMWEy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 May 2023 18:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjEMWEs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 May 2023 18:04:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2524C2D4D;
        Sat, 13 May 2023 15:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684015487; x=1715551487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vmI9ynFUPv+78hxPgRL1E8+NKhpjn7Q2/GskPdLFBX4=;
  b=BgyIxvGd8SNqGjtz7ZCWbVT2MHALIiwCNISO/kns0/875WNqi5jUmlfu
   5X4ssvAEYEVXe1WAGXT7O1SAX04arSlb7d1WNdR5MpPscDDZgR3/+t6Wu
   COyVuliwriGJCIa38HbjgwmJuFq0Ib8UnP3FcjfN4VS8XkCPLIIGzpVif
   AcRTN5dhkQhUMOADCDoee2uDo35jYCeKRkaTNwuf+rz3MxSP4gP1LUiJc
   xKis57nXa4Q8V1vOD2rRFupqp86jfFWBGJIL5EBypRFsmTDNk/aI7eEEC
   irff0oPPKMT02XZPjVFfTh8CyVgzG5mVyjpDNDfZcEUZdy8zdGe+J82ra
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="379142533"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="379142533"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 15:04:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="733429547"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="733429547"
Received: from sorinaau-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.62.145])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 15:04:36 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D4AF010CF77; Sun, 14 May 2023 01:04:33 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCHv11 1/9] mm: Add support for unaccepted memory
Date:   Sun, 14 May 2023 01:04:10 +0300
Message-Id: <20230513220418.19357-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI Specification version 2.9 introduces the concept of memory
acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
SEV-SNP, require memory to be accepted before it can be used by the
guest. Accepting happens via a protocol specific to the Virtual Machine
platform.

There are several ways kernel can deal with unaccepted memory:

 1. Accept all the memory during the boot. It is easy to implement and
    it doesn't have runtime cost once the system is booted. The downside
    is very long boot time.

    Accept can be parallelized to multiple CPUs to keep it manageable
    (i.e. via DEFERRED_STRUCT_PAGE_INIT), but it tends to saturate
    memory bandwidth and does not scale beyond the point.

 2. Accept a block of memory on the first use. It requires more
    infrastructure and changes in page allocator to make it work, but
    it provides good boot time.

    On-demand memory accept means latency spikes every time kernel steps
    onto a new memory block. The spikes will go away once workload data
    set size gets stabilized or all memory gets accepted.

 3. Accept all memory in background. Introduce a thread (or multiple)
    that gets memory accepted proactively. It will minimize time the
    system experience latency spikes on memory allocation while keeping
    low boot time.

    This approach cannot function on its own. It is an extension of #2:
    background memory acceptance requires functional scheduler, but the
    page allocator may need to tap into unaccepted memory before that.

    The downside of the approach is that these threads also steal CPU
    cycles and memory bandwidth from the user's workload and may hurt
    user experience.

The patch implements #1 and #2 for now. #2 is the default. Some
workloads may want to use #1 with accept_memory=eager in kernel
command line. #3 can be implemented later based on user's demands.

Support of unaccepted memory requires a few changes in core-mm code:

  - memblock has to accept memory on allocation;

  - page allocator has to accept memory on the first allocation of the
    page;

Memblock change is trivial.

The page allocator is modified to accept pages. New memory gets accepted
before putting pages on free lists. It is done lazily: only accept new
pages when we run out of already accepted memory. The memory gets
accepted until the high watermark is reached.

EFI code will provide two helpers if the platform supports unaccepted
memory:

 - accept_memory() makes a range of physical addresses accepted.

 - range_contains_unaccepted_memory() checks anything within the range
   of physical addresses requires acceptance.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/base/node.c    |   7 ++
 fs/proc/meminfo.c      |   5 ++
 include/linux/mm.h     |  19 +++++
 include/linux/mmzone.h |   8 ++
 mm/internal.h          |   1 +
 mm/memblock.c          |   9 +++
 mm/mm_init.c           |   7 ++
 mm/page_alloc.c        | 173 +++++++++++++++++++++++++++++++++++++++++
 mm/vmstat.c            |   3 +
 9 files changed, 232 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index b46db17124f3..655975946ef6 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -448,6 +448,9 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     "Node %d ShmemPmdMapped: %8lu kB\n"
 			     "Node %d FileHugePages: %8lu kB\n"
 			     "Node %d FilePmdMapped: %8lu kB\n"
+#endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+			     "Node %d Unaccepted:     %8lu kB\n"
 #endif
 			     ,
 			     nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
@@ -477,6 +480,10 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
 			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED))
+#endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+			     ,
+			     nid, K(sum_zone_node_page_state(nid, NR_UNACCEPTED))
 #endif
 			    );
 	len += hugetlb_report_node_meminfo(buf, len, nid);
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index b43d0bd42762..8dca4d6d96c7 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -168,6 +168,11 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		    global_zone_page_state(NR_FREE_CMA_PAGES));
 #endif
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	show_val_kb(m, "Unaccepted:     ",
+		    global_zone_page_state(NR_UNACCEPTED));
+#endif
+
 	hugetlb_report_meminfo(m);
 
 	arch_report_meminfo(m);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..d9174d464348 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3816,4 +3816,23 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 }
 #endif
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+
+bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end);
+void accept_memory(phys_addr_t start, phys_addr_t end);
+
+#else
+
+static inline bool range_contains_unaccepted_memory(phys_addr_t start,
+						    phys_addr_t end)
+{
+	return false;
+}
+
+static inline void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+}
+
+#endif
+
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a4889c9d4055..6c1c2fc13017 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -143,6 +143,9 @@ enum zone_stat_item {
 	NR_ZSPAGES,		/* allocated in zsmalloc */
 #endif
 	NR_FREE_CMA_PAGES,
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	NR_UNACCEPTED,
+#endif
 	NR_VM_ZONE_STAT_ITEMS };
 
 enum node_stat_item {
@@ -910,6 +913,11 @@ struct zone {
 	/* free areas of different sizes */
 	struct free_area	free_area[MAX_ORDER + 1];
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	/* Pages to be accepted. All pages on the list are MAX_ORDER */
+	struct list_head	unaccepted_pages;
+#endif
+
 	/* zone flags, see below */
 	unsigned long		flags;
 
diff --git a/mm/internal.h b/mm/internal.h
index 68410c6d97ac..b1db7ba5f57d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1099,4 +1099,5 @@ struct vma_prepare {
 	struct vm_area_struct *remove;
 	struct vm_area_struct *remove2;
 };
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index 3feafea06ab2..50b921119600 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1436,6 +1436,15 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 		 */
 		kmemleak_alloc_phys(found, size, 0);
 
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
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7f7f9c677854..1cfc08e25f93 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1375,6 +1375,10 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
 		zone->free_area[order].nr_free = 0;
 	}
+
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	INIT_LIST_HEAD(&zone->unaccepted_pages);
+#endif
 }
 
 void __meminit init_currently_empty_zone(struct zone *zone,
@@ -1960,6 +1964,9 @@ static void __init deferred_free_range(unsigned long pfn,
 		return;
 	}
 
+	/* Accept chunks smaller than MAX_ORDER upfront */
+	accept_memory(PFN_PHYS(pfn), PFN_PHYS(pfn + nr_pages));
+
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if (pageblock_aligned(pfn))
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47421bedc12b..d239fba3f31c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -387,6 +387,12 @@ EXPORT_SYMBOL(nr_node_ids);
 EXPORT_SYMBOL(nr_online_nodes);
 #endif
 
+static bool page_contains_unaccepted(struct page *page, unsigned int order);
+static void accept_page(struct page *page, unsigned int order);
+static bool try_to_accept_memory(struct zone *zone, unsigned int order);
+static inline bool has_unaccepted_memory(void);
+static bool __free_unaccepted(struct page *page);
+
 int page_group_by_mobility_disabled __read_mostly;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
@@ -1481,6 +1487,13 @@ void __free_pages_core(struct page *page, unsigned int order)
 
 	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
 
+	if (page_contains_unaccepted(page, order)) {
+		if (order == MAX_ORDER && __free_unaccepted(page))
+			return;
+
+		accept_page(page, order);
+	}
+
 	/*
 	 * Bypass PCP and place fresh pages right to the tail, primarily
 	 * relevant for memory onlining.
@@ -3159,6 +3172,9 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
 	if (!(alloc_flags & ALLOC_CMA))
 		unusable_free += zone_page_state(z, NR_FREE_CMA_PAGES);
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	unusable_free += zone_page_state(z, NR_UNACCEPTED);
+#endif
 
 	return unusable_free;
 }
@@ -3458,6 +3474,11 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				       gfp_mask)) {
 			int ret;
 
+			if (has_unaccepted_memory()) {
+				if (try_to_accept_memory(zone, order))
+					goto try_this_zone;
+			}
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/*
 			 * Watermark failed for this zone, but see if we can
@@ -3510,6 +3531,11 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 			return page;
 		} else {
+			if (has_unaccepted_memory()) {
+				if (try_to_accept_memory(zone, order))
+					goto try_this_zone;
+			}
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/* Try again if zone has deferred pages */
 			if (deferred_pages_enabled()) {
@@ -7215,3 +7241,150 @@ bool has_managed_dma(void)
 	return false;
 }
 #endif /* CONFIG_ZONE_DMA */
+
+#ifdef CONFIG_UNACCEPTED_MEMORY
+
+/* Counts number of zones with unaccepted pages. */
+static DEFINE_STATIC_KEY_FALSE(zones_with_unaccepted_pages);
+
+static bool lazy_accept = true;
+
+static int __init accept_memory_parse(char *p)
+{
+	if (!strcmp(p, "lazy")) {
+		lazy_accept = true;
+		return 0;
+	} else if (!strcmp(p, "eager")) {
+		lazy_accept = false;
+		return 0;
+	} else {
+		return -EINVAL;
+	}
+}
+early_param("accept_memory", accept_memory_parse);
+
+static bool page_contains_unaccepted(struct page *page, unsigned int order)
+{
+	phys_addr_t start = page_to_phys(page);
+	phys_addr_t end = start + (PAGE_SIZE << order);
+
+	return range_contains_unaccepted_memory(start, end);
+}
+
+static void accept_page(struct page *page, unsigned int order)
+{
+	phys_addr_t start = page_to_phys(page);
+
+	accept_memory(start, start + (PAGE_SIZE << order));
+}
+
+static bool try_to_accept_memory_one(struct zone *zone)
+{
+	unsigned long flags;
+	struct page *page;
+	bool last;
+
+	if (list_empty(&zone->unaccepted_pages))
+		return false;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	page = list_first_entry_or_null(&zone->unaccepted_pages,
+					struct page, lru);
+	if (!page) {
+		spin_unlock_irqrestore(&zone->lock, flags);
+		return false;
+	}
+
+	list_del(&page->lru);
+	last = list_empty(&zone->unaccepted_pages);
+
+	__mod_zone_freepage_state(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
+	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
+	spin_unlock_irqrestore(&zone->lock, flags);
+
+	accept_page(page, MAX_ORDER);
+
+	__free_pages_ok(page, MAX_ORDER, FPI_TO_TAIL);
+
+	if (last)
+		static_branch_dec(&zones_with_unaccepted_pages);
+
+	return true;
+}
+
+static bool try_to_accept_memory(struct zone *zone, unsigned int order)
+{
+	long to_accept;
+	int ret = false;
+
+	/* How much to accept to get to high watermark? */
+	to_accept = high_wmark_pages(zone) -
+		    (zone_page_state(zone, NR_FREE_PAGES) -
+		    __zone_watermark_unusable_free(zone, order, 0));
+
+	/* Accept at least one page */
+	do {
+		if (!try_to_accept_memory_one(zone))
+			break;
+		ret = true;
+		to_accept -= MAX_ORDER_NR_PAGES;
+	} while (to_accept > 0);
+
+	return ret;
+}
+
+static inline bool has_unaccepted_memory(void)
+{
+	return static_branch_unlikely(&zones_with_unaccepted_pages);
+}
+
+static bool __free_unaccepted(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+	unsigned long flags;
+	bool first = false;
+
+	if (!lazy_accept)
+		return false;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	first = list_empty(&zone->unaccepted_pages);
+	list_add_tail(&page->lru, &zone->unaccepted_pages);
+	__mod_zone_freepage_state(zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
+	__mod_zone_page_state(zone, NR_UNACCEPTED, MAX_ORDER_NR_PAGES);
+	spin_unlock_irqrestore(&zone->lock, flags);
+
+	if (first)
+		static_branch_inc(&zones_with_unaccepted_pages);
+
+	return true;
+}
+
+#else
+
+static bool page_contains_unaccepted(struct page *page, unsigned int order)
+{
+	return false;
+}
+
+static void accept_page(struct page *page, unsigned int order)
+{
+}
+
+static bool try_to_accept_memory(struct zone *zone, unsigned int order)
+{
+	return false;
+}
+
+static inline bool has_unaccepted_memory(void)
+{
+	return false;
+}
+
+static bool __free_unaccepted(struct page *page)
+{
+	BUILD_BUG();
+	return false;
+}
+
+#endif /* CONFIG_UNACCEPTED_MEMORY */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index c28046371b45..282349cabf01 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1180,6 +1180,9 @@ const char * const vmstat_text[] = {
 	"nr_zspages",
 #endif
 	"nr_free_cma",
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	"nr_unaccepted",
+#endif
 
 	/* enum numa_stat_item counters */
 #ifdef CONFIG_NUMA
-- 
2.39.3

