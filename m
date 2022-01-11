Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1836648AC8A
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 12:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349638AbiAKLdk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 06:33:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:29988 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349569AbiAKLdY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 11 Jan 2022 06:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641900803; x=1673436803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XXiNVM5MD77OC0PKAJ7Qh/8iyqoz0w1CDeuRwsZQWGI=;
  b=LiKE8RG22ZL9qXwub7zmaAvo44gGeblGhsYrdrL2F0qRBhpyUJasboT0
   iIN0yKzPaFGULMSokTqnqMFx0t5YGXtmKMr2Q+UVXBIoV42zx8euMcfjH
   f1riuPx4TB8hleF1fY62c6NgDxL8hARsYYk++QeGaJ829Rv93F0/q+4e2
   Y21dL8QsKKpYgqgarS0QD/VCOR7u6Qag+WY6aEX+NkrRmmlz4UPqVFpD/
   /GrznyrNFZp8RQM6NIfbcymVb/+Ap5CI0A5rKA0VNgeZqujC0oPidkDUS
   AQo5Q5J5OivZf4xCr+vLvtd0ej/NLdbEAcO71HTFDfpDDzXlWjpSPTMjj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="304202781"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="304202781"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 03:33:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="490351608"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 11 Jan 2022 03:33:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6C8D9651; Tue, 11 Jan 2022 13:33:19 +0200 (EET)
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
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 6/7] x86/mm: Provide helpers for unaccepted memory
Date:   Tue, 11 Jan 2022 14:33:13 +0300
Message-Id: <20220111113314.27173-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
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
 arch/x86/boot/compressed/unaccepted_memory.c |  3 +-
 arch/x86/include/asm/page.h                  |  5 ++
 arch/x86/include/asm/unaccepted_memory.h     |  3 +
 arch/x86/mm/Makefile                         |  2 +
 arch/x86/mm/unaccepted_memory.c              | 90 ++++++++++++++++++++
 5 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/mm/unaccepted_memory.c

diff --git a/arch/x86/boot/compressed/unaccepted_memory.c b/arch/x86/boot/compressed/unaccepted_memory.c
index 91db800d5f5e..b6caca4d3d22 100644
--- a/arch/x86/boot/compressed/unaccepted_memory.c
+++ b/arch/x86/boot/compressed/unaccepted_memory.c
@@ -20,8 +20,7 @@ void mark_unaccepted(struct boot_params *params, u64 start, u64 end)
 
 	/* Immediately accept whole range if it is within a PMD_SIZE block: */
 	if ((start & PMD_MASK) == (end & PMD_MASK)) {
-		npages = (end - start) / PAGE_SIZE;
-		__accept_memory(start, start + npages * PAGE_SIZE);
+		__accept_memory(start, end);
 		return;
 	}
 
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
index f1f835d3cd78..8a06ac8fc9e9 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -6,9 +6,12 @@
 #include <linux/types.h>
 
 struct boot_params;
+struct page;
 
 void mark_unaccepted(struct boot_params *params, u64 start, u64 num);
 
 void accept_memory(phys_addr_t start, phys_addr_t end);
 
+void maybe_set_page_offline(struct page *page, unsigned int order);
+void accept_and_clear_page_offline(struct page *page, unsigned int order);
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
index 000000000000..984eaead0b11
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
+	bitmap_for_each_set_region(unaccepted_memory, rs, re,
+				   start / PMD_SIZE,
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
+void __init maybe_set_page_offline(struct page *page, unsigned int order)
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
+		__SetPageOffline(page);
+out:
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+}
+
+void accept_and_clear_page_offline(struct page *page, unsigned int order)
+{
+	phys_addr_t addr = round_down(page_to_phys(page), PMD_SIZE);
+	int i;
+
+	/* PageOffline() page on a free list, but no unaccepted memory? Hm. */
+	WARN_ON_ONCE(!boot_params.unaccepted_memory);
+
+	page = pfn_to_page(addr >> PAGE_SHIFT);
+	if (order < PMD_ORDER)
+		order = PMD_ORDER;
+
+	accept_memory(addr, addr + (PAGE_SIZE << order));
+
+	for (i = 0; i < (1 << order); i++) {
+		if (PageOffline(page + i))
+			__ClearPageOffline(page + i);
+	}
+}
-- 
2.34.1

