Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60582645171
	for <lists+linux-efi@lfdr.de>; Wed,  7 Dec 2022 02:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiLGBtz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Dec 2022 20:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLGBtx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Dec 2022 20:49:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD8D528AB;
        Tue,  6 Dec 2022 17:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670377792; x=1701913792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u+bYwyFm4XjH9XBhSQUvtr3jzM1TLHyKc0CMjo+kLEU=;
  b=XVQJLrRaUd5neqrX2yVzjILOLK/KWr25vuIzqj6+2JP/dk1dr7loSULx
   XRo8aK9CwgqRNpdAz0ENxQvc44yvIeWtxlABOJrOXiWnK4Iutm8J7xwoM
   pFkYe1TwrT9RZ4+CxGfIWF32fmqd/49lFGOQuIn7kFM2SzAaviTcBzQqs
   MzuhzvUqM2qyvFLSjGNlUwHT2c8ay1WKkDRKXdhV5u87UFbNtytOjIIM9
   1UminUgMO2lrDiHRUJOhJK9QEYKvMUW6gWnx/rTbT5QjS2ZxQsSEi/rGa
   yG74sdN2oU4gsSjG2NZNNrwwvUUt81hVgabDOadog6PAfKVPIT5ve08Ce
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="315494434"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="315494434"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:49:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="646427593"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="646427593"
Received: from puneets1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.38.123])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:49:41 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4782B109C87; Wed,  7 Dec 2022 04:49:39 +0300 (+03)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv8 03/14] mm: Report unaccepted memory in meminfo
Date:   Wed,  7 Dec 2022 04:49:22 +0300
Message-Id: <20221207014933.8435-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Track amount of unaccepted memory and report it in /proc/meminfo and in
node meminfo.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 drivers/base/node.c    | 7 +++++++
 fs/proc/meminfo.c      | 5 +++++
 include/linux/mmzone.h | 3 +++
 mm/page_alloc.c        | 2 ++
 mm/vmstat.c            | 1 +
 5 files changed, 18 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index faf3597a96da..ca6f0590be21 100644
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
+			     nid, K(node_page_state(pgdat, NR_UNACCEPTED))
 #endif
 			    );
 	len += hugetlb_report_node_meminfo(buf, len, nid);
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 440960110a42..789b77c7b6df 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -155,6 +155,11 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		    global_zone_page_state(NR_FREE_CMA_PAGES));
 #endif
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	show_val_kb(m, "Unaccepted:     ",
+		    global_node_page_state(NR_UNACCEPTED));
+#endif
+
 	hugetlb_report_meminfo(m);
 
 	arch_report_meminfo(m);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index da335381e63f..9c762e8175fc 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -198,6 +198,9 @@ enum node_stat_item {
 	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
 	NR_KERNEL_STACK_KB,	/* measured in KiB */
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	NR_UNACCEPTED,
+#endif
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6d597e833a73..e80e8d398863 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1779,6 +1779,7 @@ static bool try_to_accept_memory(struct zone *zone)
 
 	migratetype = get_pfnblock_migratetype(page, page_to_pfn(page));
 	__mod_zone_freepage_state(zone, -1 << order, migratetype);
+	__mod_node_page_state(page_pgdat(page), NR_UNACCEPTED, -1 << order);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	if (last)
@@ -1807,6 +1808,7 @@ static void __free_unaccepted(struct page *page, unsigned int order)
 	migratetype = get_pfnblock_migratetype(page, page_to_pfn(page));
 	list_add_tail(&page->lru, &zone->unaccepted_pages);
 	__mod_zone_freepage_state(zone, 1 << order, migratetype);
+	__mod_node_page_state(page_pgdat(page), NR_UNACCEPTED, 1 << order);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	if (first)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b2371d745e00..fb15213be374 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1230,6 +1230,7 @@ const char * const vmstat_text[] = {
 	"nr_foll_pin_acquired",
 	"nr_foll_pin_released",
 	"nr_kernel_stack",
+	"nr_unaccepted",
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	"nr_shadow_call_stack",
 #endif
-- 
2.38.0

