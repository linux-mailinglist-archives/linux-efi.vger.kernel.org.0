Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104CD50D7B8
	for <lists+linux-efi@lfdr.de>; Mon, 25 Apr 2022 05:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbiDYDnG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 Apr 2022 23:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbiDYDnC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 24 Apr 2022 23:43:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABED12F031;
        Sun, 24 Apr 2022 20:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650857992; x=1682393992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UW/BHigZ6spgrKRAqG9bWiHedWVnA5vrB2UptEivfzc=;
  b=Wq3ULo2C+tSeDwqVzZIb01wooRUSz5J6Ob+G8UmhDkVjAb0MTnxhSPLx
   oloyCDzn3SspBr/TWszB9ij0hbPDnOMmtMQZFJP27R6fHrt97eg8CQPOh
   Nz/h3AiKoeLC9UenNXulARhpYfsUMLNZpa4aPXQL3/hMbT3ZziNJtr45g
   lBpmmsYcOTRe5FAWFQ/6xkYSghNJbMHmppGbaENAsjDmkVezv/zhersXW
   7pcmOqcvlqxsRamG1FfPOXV1rlFFjZUCNBnLqqLeHZPfzNyOS5zhl0YaZ
   hpWad1RfoSjetmfBMIhMHR1uPL4BP0ZNzTEeolTt8QEcrPrVpwdY/WTSr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="325612384"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="325612384"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 20:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="659959901"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 24 Apr 2022 20:39:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 288BC7E0; Mon, 25 Apr 2022 06:39:36 +0300 (EEST)
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
Subject: [PATCHv5 12/12] x86/mm: Report unaccepted memory in /proc/meminfo
Date:   Mon, 25 Apr 2022 06:39:34 +0300
Message-Id: <20220425033934.68551-13-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Track amount of unaccepted memory and report it in /proc/meminfo.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/set_memory.h        |  2 ++
 arch/x86/include/asm/unaccepted_memory.h |  9 ++++++
 arch/x86/mm/init.c                       |  8 ++++++
 arch/x86/mm/pat/set_memory.c             |  2 +-
 arch/x86/mm/unaccepted_memory.c          | 36 +++++++++++++++++++++++-
 5 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 78ca53512486..e467f3941d22 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -86,6 +86,8 @@ bool kernel_page_present(struct page *page);
 
 extern int kernel_set_to_readonly;
 
+void direct_map_meminfo(struct seq_file *m);
+
 #ifdef CONFIG_X86_64
 /*
  * Prevent speculative access to the page by either unmapping
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index a59264ee0ab3..7c93661152a9 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -3,7 +3,10 @@
 #ifndef _ASM_X86_UNACCEPTED_MEMORY_H
 #define _ASM_X86_UNACCEPTED_MEMORY_H
 
+#include <linux/types.h>
+
 struct boot_params;
+struct seq_file;
 
 void process_unaccepted_memory(struct boot_params *params, u64 start, u64 num);
 
@@ -12,5 +15,11 @@ void process_unaccepted_memory(struct boot_params *params, u64 start, u64 num);
 void accept_memory(phys_addr_t start, phys_addr_t end);
 bool memory_is_unaccepted(phys_addr_t start, phys_addr_t end);
 
+void unaccepted_meminfo(struct seq_file *m);
+
+#else
+
+static inline void unaccepted_meminfo(struct seq_file *m) {}
+
 #endif
 #endif
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index d8cfce221275..7e92a9d93994 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1065,3 +1065,11 @@ unsigned long max_swapfile_size(void)
 	return pages;
 }
 #endif
+
+#ifdef CONFIG_PROC_FS
+void arch_report_meminfo(struct seq_file *m)
+{
+	direct_map_meminfo(m);
+	unaccepted_meminfo(m);
+}
+#endif
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index abf5ed76e4b7..2880ba01451c 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -105,7 +105,7 @@ static void split_page_count(int level)
 	direct_pages_count[level - 1] += PTRS_PER_PTE;
 }
 
-void arch_report_meminfo(struct seq_file *m)
+void direct_map_meminfo(struct seq_file *m)
 {
 	seq_printf(m, "DirectMap4k:    %8lu kB\n",
 			direct_pages_count[PG_LEVEL_4K] << 2);
diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index 65cd49b93c50..66a6c529bf31 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -3,14 +3,17 @@
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <linux/spinlock.h>
+#include <linux/seq_file.h>
 
+#include <asm/e820/api.h>
 #include <asm/io.h>
 #include <asm/setup.h>
 #include <asm/shared/tdx.h>
 #include <asm/unaccepted_memory.h>
 
-/* Protects unaccepted memory bitmap */
+/* Protects unaccepted memory bitmap and nr_unaccepted */
 static DEFINE_SPINLOCK(unaccepted_memory_lock);
+static unsigned long nr_unaccepted;
 
 void accept_memory(phys_addr_t start, phys_addr_t end)
 {
@@ -39,6 +42,12 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 
 		bitmap_clear(unaccepted_memory, range_start, len);
 		count_vm_events(ACCEPT_MEMORY, len * PMD_SIZE / PAGE_SIZE);
+
+		/* In early boot nr_unaccepted is not yet initialized */
+		if (nr_unaccepted) {
+			WARN_ON(nr_unaccepted < len);
+			nr_unaccepted -= len;
+		}
 	}
 	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
 }
@@ -62,3 +71,28 @@ bool memory_is_unaccepted(phys_addr_t start, phys_addr_t end)
 
 	return ret;
 }
+
+void unaccepted_meminfo(struct seq_file *m)
+{
+	seq_printf(m, "UnacceptedMem:  %8lu kB\n",
+		   (READ_ONCE(nr_unaccepted) * PMD_SIZE) >> 10);
+}
+
+static int __init unaccepted_meminfo_init(void)
+{
+	unsigned long *unaccepted_memory;
+	unsigned long flags, bitmap_size;
+
+	if (!boot_params.unaccepted_memory)
+		return 0;
+
+	bitmap_size = e820__end_of_ram_pfn() * PAGE_SIZE / PMD_SIZE;
+	unaccepted_memory = __va(boot_params.unaccepted_memory);
+
+	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+	nr_unaccepted = bitmap_weight(unaccepted_memory, bitmap_size);
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+
+	return 0;
+}
+fs_initcall(unaccepted_meminfo_init);
-- 
2.35.1

