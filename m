Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E00D4A026D
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 21:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245264AbiA1U7Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 15:59:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:58007 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245144AbiA1U7L (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 15:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643403551; x=1674939551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPAM/BFzre+OlxESQ1UNn23Z4mlITze1sx4aEFpsPcA=;
  b=WCu9SEOyCgu5Zs2OiPsPzg8U6P0rtrgyz5TMoOo8cFcCY8S3T5vymriy
   4I80SxxTl1pYN6Q7C9YhO7eJle/LW6QMEP7OgvDpYIr/2R09mOS0k9Bng
   rOxglMPW0ADmlsf+JP7hhQcrKSpdUt/jneZhgjDhEzZ9n7v9U5WpZvcB1
   5Caq6fk5NvTy6R7PnwKRKHcvPjnABdXxL6Mr+w3ZmqzouvYea9K7q7EtZ
   oJJPc4qw8bFxPcT486TRWhOhabkmNMoSO705FQml+lJQq6bE9/emwDiRv
   sE/P7208AhwxR9V6Hn5wh2QDXJxf9ZmLyumbvgzEEtStJY7kA/tqALLdw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247417208"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="247417208"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 12:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="533622714"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jan 2022 12:59:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D23C5478; Fri, 28 Jan 2022 22:59:09 +0200 (EET)
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
Subject: [PATCHv3 6/7] x86/mm: Provide helpers for unaccepted memory
Date:   Fri, 28 Jan 2022 23:59:05 +0300
Message-Id: <20220128205906.27503-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128205906.27503-1-kirill.shutemov@linux.intel.com>
References: <20220128205906.27503-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Core-mm requires few helpers to support unaccepted memory:

 - accept_memory() checks the range of addresses against the bitmap and
   accept memory if needed;

 - maybe_set_page_offline() checks the bitmap and marks a page with
   PageOffline() if memory acceptance required on the first
   allocation of the page.

 - accept_and_clear_page_offline() accepts memory for the page and clears
   PageOffline().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/page.h              |  5 ++
 arch/x86/include/asm/unaccepted_memory.h |  3 +
 arch/x86/mm/Makefile                     |  2 +
 arch/x86/mm/unaccepted_memory.c          | 90 ++++++++++++++++++++++++
 4 files changed, 100 insertions(+)
 create mode 100644 arch/x86/mm/unaccepted_memory.c

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 4d5810c8fab7..1e56d76ca474 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -19,6 +19,11 @@
 struct page;
 
 #include <linux/range.h>
+
+#ifdef CONFIG_UNACCEPTED_MEMORY
+#include <asm/unaccepted_memory.h>
+#endif
+
 extern struct range pfn_mapped[];
 extern int nr_pfn_mapped;
 
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index f1f835d3cd78..0c0ea777809a 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -6,9 +6,12 @@
 #include <linux/types.h>
 
 struct boot_params;
+struct page;
 
 void mark_unaccepted(struct boot_params *params, u64 start, u64 num);
 
 void accept_memory(phys_addr_t start, phys_addr_t end);
 
+void maybe_mark_page_unaccepted(struct page *page, unsigned int order);
+void accept_page(struct page *page, unsigned int order);
 #endif
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index fe3d3061fc11..e327f83e6bbf 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -60,3 +60,5 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
+
+obj-$(CONFIG_UNACCEPTED_MEMORY)	+= unaccepted_memory.o
diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
new file mode 100644
index 000000000000..adcac22dfe75
--- /dev/null
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -0,0 +1,90 @@
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/pfn.h>
+#include <linux/spinlock.h>
+
+#include <asm/io.h>
+#include <asm/setup.h>
+#include <asm/unaccepted_memory.h>
+
+static DEFINE_SPINLOCK(unaccepted_memory_lock);
+
+#define PMD_ORDER (PMD_SHIFT - PAGE_SHIFT)
+
+static void __accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long *unaccepted_memory;
+	unsigned int rs, re;
+
+	unaccepted_memory = __va(boot_params.unaccepted_memory);
+	rs = start / PMD_SIZE;
+
+	for_each_set_bitrange_from(rs, re, unaccepted_memory,
+				   DIV_ROUND_UP(end, PMD_SIZE)) {
+		/* Platform-specific memory-acceptance call goes here */
+		panic("Cannot accept memory");
+		bitmap_clear(unaccepted_memory, rs, re - rs);
+	}
+}
+
+void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long flags;
+	if (!boot_params.unaccepted_memory)
+		return;
+
+	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+	__accept_memory(start, end);
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+}
+
+void __init maybe_mark_page_unaccepted(struct page *page, unsigned int order)
+{
+	unsigned long *unaccepted_memory;
+	phys_addr_t addr = page_to_phys(page);
+	unsigned long flags;
+	bool unaccepted = false;
+	unsigned int i;
+
+	if (!boot_params.unaccepted_memory)
+		return;
+
+	unaccepted_memory = __va(boot_params.unaccepted_memory);
+	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+	if (order < PMD_ORDER) {
+		BUG_ON(test_bit(addr / PMD_SIZE, unaccepted_memory));
+		goto out;
+	}
+
+	for (i = 0; i < (1 << (order - PMD_ORDER)); i++) {
+		if (test_bit(addr / PMD_SIZE + i, unaccepted_memory)) {
+			unaccepted = true;
+			break;
+		}
+	}
+
+	/* At least part of page is uneccepted */
+	if (unaccepted)
+		__SetPageBuddyUnaccepted(page);
+out:
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+}
+
+void accept_page(struct page *page, unsigned int order)
+{
+	phys_addr_t addr = round_down(page_to_phys(page), PMD_SIZE);
+	int i;
+
+	WARN_ON_ONCE(!boot_params.unaccepted_memory);
+
+	page = pfn_to_page(addr >> PAGE_SHIFT);
+	if (order < PMD_ORDER)
+		order = PMD_ORDER;
+
+	accept_memory(addr, addr + (PAGE_SIZE << order));
+
+	for (i = 0; i < (1 << order); i++) {
+		if (PageBuddyUnaccepted(page + i))
+			__ClearPageBuddyUnaccepted(page + i);
+	}
+}
-- 
2.34.1

