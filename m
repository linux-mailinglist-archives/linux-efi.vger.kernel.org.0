Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BB452A6E8
	for <lists+linux-efi@lfdr.de>; Tue, 17 May 2022 17:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348046AbiEQPfU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 May 2022 11:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350160AbiEQPfI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 May 2022 11:35:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE0250037;
        Tue, 17 May 2022 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652801707; x=1684337707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HVjMB3MvnvnUL83RU6E0S1pRWzbakqXi101UVCGUEjg=;
  b=W4qWdlOvHTmkwX1YKX/JdhO/90JP8Fy/C5iy0x8Vq2MGyi7AOwkes85v
   eMQUi5KD4OFvM1UGibCcGInXL8jq1M/zmah5SU5BunS7x5TwFY5FDBgkx
   X+ODo340Ndn2tJ1duLfEZxudtXN2RWprT8qRoimm/ibo75dVVDmbTWFYM
   rzp3SaxA17VTCRsXq5YU/EXJN5XzE7FIkaeMQSzqzmvkoJKGpPgNGiqWx
   xD7WViyGj8XynTldCjqZ8cRLZKbw1+bnhtenmOaPToPu/pJodKWHumze4
   J0B5S1M9uxbUug0VQOEhMtZ9IBAyVUe0+PgywMNYXkB27YqnENT0c3UuO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="331837240"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="331837240"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 08:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="574566799"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 17 May 2022 08:34:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id BA7B7CE3; Tue, 17 May 2022 18:34:50 +0300 (EEST)
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
Subject: [PATCHv6 10/15] x86/mm: Report unaccepted memory in /proc/meminfo
Date:   Tue, 17 May 2022 18:34:39 +0300
Message-Id: <20220517153444.11195-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 89fc91c61560..d8622d952212 100644
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
 bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end);
 
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
index 0656db33574d..f08881c4b8ee 100644
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
index 33bf70592a46..1ca71eb98c24 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -2,14 +2,17 @@
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/pfn.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock.h>
 
+#include <asm/e820/api.h>
 #include <asm/io.h>
 #include <asm/setup.h>
 #include <asm/unaccepted_memory.h>
 
-/* Protects unaccepted memory bitmap */
+/* Protects unaccepted memory bitmap and nr_unaccepted */
 static DEFINE_SPINLOCK(unaccepted_memory_lock);
+static unsigned long nr_unaccepted;
 
 void accept_memory(phys_addr_t start, phys_addr_t end)
 {
@@ -63,6 +66,12 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 		/* Platform-specific memory-acceptance call goes here */
 		panic("Cannot accept memory: unknown platform\n");
 		bitmap_clear(bitmap, range_start, len);
+
+		/* In early boot nr_unaccepted is not yet initialized */
+		if (nr_unaccepted) {
+			WARN_ON(nr_unaccepted < len);
+			nr_unaccepted -= len;
+		}
 	}
 	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
 }
@@ -90,3 +99,28 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
 
 	return ret;
 }
+
+void unaccepted_meminfo(struct seq_file *m)
+{
+	seq_printf(m, "UnacceptedMem:  %8lu kB\n",
+		   (READ_ONCE(nr_unaccepted) * PMD_SIZE) >> 10);
+}
+
+static int __init unaccepted_init(void)
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
+fs_initcall(unaccepted_init);
-- 
2.35.1

