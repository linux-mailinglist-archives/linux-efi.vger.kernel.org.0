Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E906D50D7B2
	for <lists+linux-efi@lfdr.de>; Mon, 25 Apr 2022 05:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240721AbiDYDnO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 Apr 2022 23:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240726AbiDYDnC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 24 Apr 2022 23:43:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C89D2F01D;
        Sun, 24 Apr 2022 20:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650857994; x=1682393994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5hPx0r3OWxS+lz/D+l0BiGQBbeJJHb52sFjAF/68dVQ=;
  b=Bpd6NcKA0XJRrq2U5Jl6i/oyVXFhvsM76P4Lwcljbhqf60OiH3TVVl+1
   W1oiy3x1Cs8hS6wlE+Uk2/6fi+mBS25xH8wO3DnYRMmklRYQR3I+fV++4
   7i1jbZnW1D+aqk0Y7yIgRi/pr1uXYU1OoVsXRqShiba//mztPlO8nFM1C
   X7kx0MIQoGyYklb+iRVVpkiOSznOd7Kk5gpKhAw8VGD44lOJj7A/vvmlz
   X7B/nSxJ/hbFQpZ/bQv0Taz9po55XLtQUUqybWiWotTO3LhRsmDnVttvA
   kJ2b03AqqIl0V4My9m7j7O3HxMGk3fIcGsVsBrSj47h99GdhykDvMkCbK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="247051030"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="247051030"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 20:39:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="649514099"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Apr 2022 20:39:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1D2DC739; Mon, 25 Apr 2022 06:39:36 +0300 (EEST)
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
Subject: [PATCHv5 11/12] mm/vmstat: Add counter for memory accepting
Date:   Mon, 25 Apr 2022 06:39:33 +0300
Message-Id: <20220425033934.68551-12-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index de0790af1824..65cd49b93c50 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -38,6 +38,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 		}
 
 		bitmap_clear(unaccepted_memory, range_start, len);
+		count_vm_events(ACCEPT_MEMORY, len * PMD_SIZE / PAGE_SIZE);
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

