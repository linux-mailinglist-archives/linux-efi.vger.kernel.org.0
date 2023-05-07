Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7159B6F9CD2
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 01:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjEGXqt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 May 2023 19:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjEGXqp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 7 May 2023 19:46:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB16120BE;
        Sun,  7 May 2023 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683503201; x=1715039201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gf4ahacUkHLsgr0L6SRROIOspGC7mKmz2423NAe8qwk=;
  b=e2KzmQYvcjWpsYlaFPvdGASx9yTKE+Smm1tziNPaH0HTcGhtdGIsO8A3
   bUaxhQX1aLJYM9FUB+0yCjP/C3bC97mrZpepiYyAx+l2Yfwe4ttf7n0fr
   Rz7eTgjRqwkFqCF02tgSMpj92dqSVoRhR/7GYN/53lKcYL6rXa57X8r+y
   dkTffH/YbmIkSBXO7fOYCU6pqs4hNRTunshnhvNyKuTk5mQehDmtpOKaM
   jPB4FtOP1IZ++ENhziWtsPaGSK7jvGYiNOOkTWWA5XEcpqmuKasV7vXbU
   8kzeYdywHo9Se2Jy0iv0+Bj1K6t0UXA95seTBy43s6LoQv7JUt3TnBqsg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="333953540"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="333953540"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 16:46:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="675852968"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="675852968"
Received: from dancaspi-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.61.73])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 16:46:32 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 53CDB10D33B; Mon,  8 May 2023 02:46:20 +0300 (+03)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv10 07/11] x86/mm: Provide helpers for unaccepted memory
Date:   Mon,  8 May 2023 02:46:14 +0300
Message-Id: <20230507234618.18067-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230507234618.18067-1-kirill.shutemov@linux.intel.com>
References: <20230507234618.18067-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Core-mm requires few helpers to support unaccepted memory:

 - accept_memory() checks the range of addresses against the bitmap and
   accept memory if needed.

 - range_contains_unaccepted_memory() checks if anything within the
   range requires acceptance.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/page.h              |  3 ++
 arch/x86/include/asm/unaccepted_memory.h |  4 ++
 arch/x86/mm/Makefile                     |  2 +
 arch/x86/mm/unaccepted_memory.c          | 61 ++++++++++++++++++++++++
 4 files changed, 70 insertions(+)
 create mode 100644 arch/x86/mm/unaccepted_memory.c

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index d18e5c332cb9..4bab2bb2c9c0 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -19,6 +19,9 @@
 struct page;
 
 #include <linux/range.h>
+
+#include <asm/unaccepted_memory.h>
+
 extern struct range pfn_mapped[];
 extern int nr_pfn_mapped;
 
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index 41fbfc798100..89fc91c61560 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -7,6 +7,10 @@ struct boot_params;
 
 void process_unaccepted_memory(struct boot_params *params, u64 start, u64 num);
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+
 void accept_memory(phys_addr_t start, phys_addr_t end);
+bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end);
 
 #endif
+#endif
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c80febc44cd2..b0ef1755e5c8 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -67,3 +67,5 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
+
+obj-$(CONFIG_UNACCEPTED_MEMORY)	+= unaccepted_memory.o
diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
new file mode 100644
index 000000000000..1df918b21469
--- /dev/null
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/pfn.h>
+#include <linux/spinlock.h>
+
+#include <asm/io.h>
+#include <asm/setup.h>
+#include <asm/unaccepted_memory.h>
+
+/* Protects unaccepted memory bitmap */
+static DEFINE_SPINLOCK(unaccepted_memory_lock);
+
+void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long range_start, range_end;
+	unsigned long *bitmap;
+	unsigned long flags;
+
+	if (!boot_params.unaccepted_memory)
+		return;
+
+	bitmap = __va(boot_params.unaccepted_memory);
+	range_start = start / PMD_SIZE;
+
+	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+	for_each_set_bitrange_from(range_start, range_end, bitmap,
+				   DIV_ROUND_UP(end, PMD_SIZE)) {
+		unsigned long len = range_end - range_start;
+
+		/* Platform-specific memory-acceptance call goes here */
+		panic("Cannot accept memory: unknown platform\n");
+		bitmap_clear(bitmap, range_start, len);
+	}
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+}
+
+bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long *bitmap;
+	unsigned long flags;
+	bool ret = false;
+
+	if (!boot_params.unaccepted_memory)
+		return 0;
+
+	bitmap = __va(boot_params.unaccepted_memory);
+
+	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+	while (start < end) {
+		if (test_bit(start / PMD_SIZE, bitmap)) {
+			ret = true;
+			break;
+		}
+
+		start += PMD_SIZE;
+	}
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+
+	return ret;
+}
-- 
2.39.3

