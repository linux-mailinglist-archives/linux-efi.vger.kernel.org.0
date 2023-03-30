Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F44D6D03D1
	for <lists+linux-efi@lfdr.de>; Thu, 30 Mar 2023 13:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjC3LuQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Mar 2023 07:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjC3LuP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Mar 2023 07:50:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F92F2108;
        Thu, 30 Mar 2023 04:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680177011; x=1711713011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZA6Ow13DZ6fov0DkWaGCGd0ySWhtAHUVohuKyDxTtmM=;
  b=j3MkSlPhyEIH+jPw7xsELfRX1v6nsu8tSAeyYN0oK1K97+sJW8MLrQy/
   RTJcrwItofFwNQRyiIP/ZgeH9w+iRTvw92OSm+Vwu8bB0GH7KAWw2c3SS
   ik3iFf2lhRPoBS4hv+/gcL/yKdlAxOTc4TsaCupkrsZ3fCBiIAsPWqzD7
   NVZdZ3yPdmsTjN/Ta/hbcjoyOVl/UDRiNVmP91JXOL5zTk7L/6sqHEcuh
   KIQSsnEbLpZMF6qKBYDaYC9N5bJRwMwQIUxwQ3MJngPzFk9Ouvqdo90b5
   +FvTkkf9YBp6nFadJoCj6RF2irANS9uKpeymt2QHdLcSNqgxNxL70As3i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="339868371"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="339868371"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 04:50:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="1014401426"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="1014401426"
Received: from ngreburx-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.209.91])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 04:50:02 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id EFD9310438D; Thu, 30 Mar 2023 14:49:59 +0300 (+03)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCHv9 02/14] mm: Add support for unaccepted memory
Date:   Thu, 30 Mar 2023 14:49:44 +0300
Message-Id: <20230330114956.20342-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Architecture has to provide two helpers if it wants to support
unaccepted memory:

 - accept_memory() makes a range of physical addresses accepted.

 - range_contains_unaccepted_memory() checks anything within the range
   of physical addresses requires acceptance.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
---
 drivers/base/node.c    |   7 ++
 fs/proc/meminfo.c      |   5 ++
 include/linux/mmzone.h |   8 ++
 mm/internal.h          |  13 ++++
 mm/memblock.c          |   9 +++
 mm/mm_init.c           |   7 ++
 mm/page_alloc.c        | 161 +++++++++++++++++++++++++++++++++++++++++
 mm/vmstat.c            |   3 +
 8 files changed, 213 insertions(+)

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
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 72837e019bd1..c5f50ad19870 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -148,6 +148,9 @@ enum zone_stat_item {
 	NR_ZSPAGES,		/* allocated in zsmalloc */
 #endif
 	NR_FREE_CMA_PAGES,
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	NR_UNACCEPTED,
+#endif
 	NR_VM_ZONE_STAT_ITEMS };
 
 enum node_stat_item {
@@ -919,6 +922,11 @@ struct zone {
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
index c05ad651b515..748bfeac1fea 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1114,4 +1114,17 @@ struct vma_prepare {
 	struct vm_area_struct *remove;
 	struct vm_area_struct *remove2;
 };
+
+#ifndef CONFIG_UNACCEPTED_MEMORY
+static inline bool range_contains_unaccepted_memory(phys_addr_t start,
+						    phys_addr_t end)
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
index 7911224b1ed3..54f89d9ac98e 100644
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
index dd3a6ed9663f..5e5afbefda1e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1373,6 +1373,10 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
 		zone->free_area[order].nr_free = 0;
 	}
+
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	INIT_LIST_HEAD(&zone->unaccepted_pages);
+#endif
 }
 
 void __meminit init_currently_empty_zone(struct zone *zone,
@@ -1958,6 +1962,9 @@ static void __init deferred_free_range(unsigned long pfn,
 		return;
 	}
 
+	/* Accept chunks smaller than MAX_ORDER upfront */
+	accept_memory(PFN_PHYS(pfn), PFN_PHYS(pfn + nr_pages));
+
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if (pageblock_aligned(pfn))
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0767dd6bc5ba..d62fcb2f28bd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -387,6 +387,11 @@ EXPORT_SYMBOL(nr_node_ids);
 EXPORT_SYMBOL(nr_online_nodes);
 #endif
 
+static bool page_contains_unaccepted(struct page *page, unsigned int order);
+static void accept_page(struct page *page, unsigned int order);
+static bool try_to_accept_memory(struct zone *zone, unsigned int order);
+static bool __free_unaccepted(struct page *page);
+
 int page_group_by_mobility_disabled __read_mostly;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
@@ -1481,6 +1486,13 @@ void __free_pages_core(struct page *page, unsigned int order)
 
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
@@ -3150,6 +3162,9 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
 	if (!(alloc_flags & ALLOC_CMA))
 		unusable_free += zone_page_state(z, NR_FREE_CMA_PAGES);
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	unusable_free += zone_page_state(z, NR_UNACCEPTED);
+#endif
 
 	return unusable_free;
 }
@@ -3449,6 +3464,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				       gfp_mask)) {
 			int ret;
 
+			if (try_to_accept_memory(zone, order))
+				goto try_this_zone;
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/*
 			 * Watermark failed for this zone, but see if we can
@@ -3501,6 +3519,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 			return page;
 		} else {
+			if (try_to_accept_memory(zone, order))
+				goto try_this_zone;
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/* Try again if zone has deferred pages */
 			if (deferred_pages_enabled()) {
@@ -7184,3 +7205,143 @@ bool has_managed_dma(void)
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
+	if (!static_branch_unlikely(&zones_with_unaccepted_pages))
+		return false;
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
+static bool __free_unaccepted(struct page *page)
+{
+	BUILD_BUG();
+	return false;
+}
+
+#endif /* CONFIG_UNACCEPTED_MEMORY */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 0a6d742322db..16ec8b994ef3 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1256,6 +1256,9 @@ const char * const vmstat_text[] = {
 	"nr_zspages",
 #endif
 	"nr_free_cma",
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	"nr_unaccepted",
+#endif
 
 	/* enum numa_stat_item counters */
 #ifdef CONFIG_NUMA
-- 
2.39.2

