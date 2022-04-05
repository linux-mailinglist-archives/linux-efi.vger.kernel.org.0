Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC2C4F534D
	for <lists+linux-efi@lfdr.de>; Wed,  6 Apr 2022 06:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiDFEEt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Apr 2022 00:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1850059AbiDFCrJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Apr 2022 22:47:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FBF58E68;
        Tue,  5 Apr 2022 16:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649202539; x=1680738539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RyShgqLY7MIPXh/I0xSRyqWdn3IGjezVnvsj+/bA36c=;
  b=IxyomQOvNhLCXl+F2I43x8415ZOs1Sv5NnbMp7BjDiaWGC3B6jdEB0mo
   pg18Bn8YfObGGlzbqJg00vRn2zOqFaaFMkpd82i9HE/U4G0pMLQXo8FXB
   YfAgrVz7uFpA0nyq4960iNLK0OSc+MXOcWlew3sFNUt2Sphkj+DA2PmGz
   e82X4N8/F6p3zAotK+CjtvE6byzqMmTj/PJSDtqu/Xpea9O7j5OyKuZY5
   X65NZDEgPvG4idF0cHnAQJwaG67iEpZXj4Ke9gbYzwTX5Sa8C+L2JBIn+
   C86lrPMXPQ36B5673h+4RSxHB0UtifuhG8lHNJ/whUqRNpX8VbK2PIQsC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260888338"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="260888338"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="641817585"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2022 16:48:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E93DB62E; Wed,  6 Apr 2022 02:43:47 +0300 (EEST)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 8/8] mm/vmstat: Add counter for memory accepting
Date:   Wed,  6 Apr 2022 02:43:43 +0300
Message-Id: <20220405234343.74045-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The counter increased every time kernel accepts a memory region.

The counter allows to see if memory acceptation is still ongoing and
contributes to memory allocation latency.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/unaccepted_memory.c | 1 +
 include/linux/vm_event_item.h   | 3 +++
 mm/vmstat.c                     | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index 2f1c3c0375cd..7cfe0bd8d2be 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -32,6 +32,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 		else
 			panic("Cannot accept memory");
 		bitmap_clear(unaccepted_memory, rs, re - rs);
+		count_vm_events(ACCEPT_MEMORY, PMD_SIZE / PAGE_SIZE);
 	}
 	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
 }
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 16a0a4fd000b..6a468164a2f9 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -136,6 +136,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
 		DIRECT_MAP_LEVEL3_SPLIT,
+#endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+		ACCEPT_MEMORY,
 #endif
 		NR_VM_EVENT_ITEMS
 };
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b75b1a64b54c..4c9197f32406 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1397,6 +1397,9 @@ const char * const vmstat_text[] = {
 	"direct_map_level2_splits",
 	"direct_map_level3_splits",
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	"accept_memory",
+#endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
-- 
2.35.1

