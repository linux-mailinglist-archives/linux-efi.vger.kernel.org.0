Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE754AFC9
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jun 2022 14:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356217AbiFNMCp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jun 2022 08:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356199AbiFNMCj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jun 2022 08:02:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9868219C3D;
        Tue, 14 Jun 2022 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655208156; x=1686744156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GFpQ+/mE/sWJAfnOObzg9+iqOuEtZS5nHGCJB+ROj7k=;
  b=lR0Tlrth9jb2eA4DpCFuMHriYJH1U86vrFxnkN+OU0+Csxxm9aT6jx70
   wBmnE4h5RKtwKGBLnP+AknBZHSH3uEV4tljEDGyaHybw4XlApzpz+4mDh
   P3oggA8OaPBSRYOQ1CxoCJpUGflQUwgo18KlTlayMXcZV29KOvjs9dlZk
   7lHDQV/h3lXPd5tPD7EeqrvO5J680ZPfZheeB7OE/4VyXgvRXZnKvbB5A
   OtuGfQQ1WZu6BqUIZMnFzFK/ayPBPG7QDd3dLE1b5je8UXTcfCDpi3UIY
   SxztVRDf8imJ46DVscdNed1Zl/GOzOMHkkk4vx7+ERJpWpTiWossKH1hT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="364934642"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="364934642"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="588429901"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2022 05:02:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 94DE65D3; Tue, 14 Jun 2022 15:02:32 +0300 (EEST)
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv7 03/14] mm: Report unaccepted memory in meminfo
Date:   Tue, 14 Jun 2022 15:02:20 +0300
Message-Id: <20220614120231.48165-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 include/linux/mmzone.h | 1 +
 mm/page_alloc.c        | 9 ++++++++-
 mm/vmstat.c            | 1 +
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0ac6376ef7a1..fc7cf4d91eb6 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -446,6 +446,9 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     "Node %d ShmemPmdMapped: %8lu kB\n"
 			     "Node %d FileHugePages: %8lu kB\n"
 			     "Node %d FilePmdMapped: %8lu kB\n"
+#endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+			     "Node %d UnacceptedPages: %8lu kB\n"
 #endif
 			     ,
 			     nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
@@ -474,6 +477,10 @@ static ssize_t node_read_meminfo(struct device *dev,
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
index 6e89f0e2fd20..796544e50365 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -153,6 +153,11 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		    global_zone_page_state(NR_FREE_CMA_PAGES));
 #endif
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	show_val_kb(m, "UnacceptedPages:",
+		    global_node_page_state(NR_UNACCEPTED));
+#endif
+
 	hugetlb_report_meminfo(m);
 
 	arch_report_meminfo(m);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aab70355d64f..aa08cd7eaaf5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -212,6 +212,7 @@ enum node_stat_item {
 	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
 	NR_KERNEL_STACK_KB,	/* measured in KiB */
+	NR_UNACCEPTED,
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 279c2746aaa8..6316d695a567 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1012,6 +1012,7 @@ static void accept_page(struct page *page, unsigned int order)
 
 	accept_memory(start, start + (PAGE_SIZE << order));
 	__ClearPageUnaccepted(page);
+	mod_node_page_state(page_pgdat(page), NR_UNACCEPTED, -(1 << order));
 
 	/* Assert that there is no PageUnaccepted() on tail pages */
 	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
@@ -1063,6 +1064,7 @@ static inline void __free_one_page(struct page *page,
 	struct page *buddy;
 	bool to_tail;
 	bool page_needs_acceptance = false;
+	int nr_unaccepted = 0;
 
 	VM_BUG_ON(!zone_is_initialized(zone));
 	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
@@ -1076,6 +1078,7 @@ static inline void __free_one_page(struct page *page,
 
 	if (PageUnaccepted(page)) {
 		page_needs_acceptance = true;
+		nr_unaccepted += 1 << order;
 		__ClearPageUnaccepted(page);
 	}
 
@@ -1117,6 +1120,7 @@ static inline void __free_one_page(struct page *page,
 		/* Mark page unaccepted if any of merged pages were unaccepted */
 		if (PageUnaccepted(buddy)) {
 			page_needs_acceptance = true;
+			nr_unaccepted += 1 << order;
 			__ClearPageUnaccepted(buddy);
 		}
 
@@ -1143,8 +1147,11 @@ static inline void __free_one_page(struct page *page,
 	 */
 	if (!page_needs_acceptance && (fpi_flags & FPI_UNACCEPTED_SLOWPATH))
 		page_needs_acceptance = page_contains_unaccepted(page, order);
-	if (page_needs_acceptance)
+	if (page_needs_acceptance) {
 		__SetPageUnaccepted(page);
+		__mod_node_page_state(page_pgdat(page), NR_UNACCEPTED,
+				    (1 << order) - nr_unaccepted);
+	}
 
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 373d2730fcf2..4e12d22f1e04 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1236,6 +1236,7 @@ const char * const vmstat_text[] = {
 	"nr_foll_pin_acquired",
 	"nr_foll_pin_released",
 	"nr_kernel_stack",
+	"nr_unaccepted",
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	"nr_shadow_call_stack",
 #endif
-- 
2.35.1

