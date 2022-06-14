Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B781554AFCE
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jun 2022 14:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356803AbiFNMDq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jun 2022 08:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244018AbiFNMCs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jun 2022 08:02:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F0C1C132;
        Tue, 14 Jun 2022 05:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655208167; x=1686744167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7oQeAKlAd2ATqVqYodMfjK9yYRqZpDnGTOvOo+Mth6U=;
  b=JI3RPK2CGISy7qAsjWiZmYrOGMmaCilDkFOKuOnPhNPk4BX15MYZ8xnl
   dfMNfxz6tpiBhMiaT/IJzMyleTT3Y7NhyiSXWKaaPeAbSLlh205kdPKga
   udEjnZaQY7oP7+OwdwH5X6mnjfS6Ben+RELL8ysfR8qr+9XA8gJXLHM38
   go6dhJesjL6tnLVPS8AP+69ejcv76JRhiHjkzLJlBdkrM4Ayt3G0qr2E3
   tSCes9uKPR3JQNOb1g+RKBiv98Ku4eNYtWuIjH/GrIOJJzS1LU9LShO5I
   rVHDTAehf1gQmrsMyscBVkPM/156v5cgF+u2O54KUTJIjIaw1RyTvOD/v
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258432288"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="258432288"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="640332833"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2022 05:02:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0FCEDA3F; Tue, 14 Jun 2022 15:02:33 +0300 (EEST)
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
Subject: [PATCHv7 14/14] x86/tdx: Add unaccepted memory support
Date:   Tue, 14 Jun 2022 15:02:31 +0300
Message-Id: <20220614120231.48165-15-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hookup TDX-specific code to accept memory.

Accepting the memory is the same process as converting memory from
shared to private: kernel notifies VMM with MAP_GPA hypercall and then
accept pages with ACCEPT_PAGE module call.

The implementation in core kernel uses tdx_enc_status_changed(). It
already used for converting memory to shared and back for I/O
transactions.

Boot stub provides own implementation of tdx_accept_memory(). It is
similar in structure to tdx_enc_status_changed(), but only cares about
converting memory to private.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                  |  1 +
 arch/x86/boot/compressed/mem.c    | 27 ++++++++++-
 arch/x86/boot/compressed/tdx.c    | 78 +++++++++++++++++++++++++++++++
 arch/x86/coco/tdx/tdx.c           | 30 ++++++++----
 arch/x86/include/asm/shared/tdx.h |  2 +
 arch/x86/mm/unaccepted_memory.c   |  9 +++-
 6 files changed, 136 insertions(+), 11 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9783ebc4e021..80683afa5749 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -892,6 +892,7 @@ config INTEL_TDX_GUEST
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
+	select UNACCEPTED_MEMORY
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index b45458af00ca..48e36e640da1 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -5,6 +5,8 @@
 #include "error.h"
 #include "find.h"
 #include "math.h"
+#include "tdx.h"
+#include <asm/shared/tdx.h>
 
 #define PMD_SHIFT	21
 #define PMD_SIZE	(_AC(1, UL) << PMD_SHIFT)
@@ -12,10 +14,33 @@
 
 extern struct boot_params *boot_params;
 
+static bool is_tdx_guest(void)
+{
+	static bool once;
+	static bool is_tdx;
+
+	if (!IS_ENABLED(CONFIG_INTEL_TDX_GUEST))
+		return false;
+
+	if (!once) {
+		u32 eax, sig[3];
+
+		cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax,
+			    &sig[0], &sig[2],  &sig[1]);
+		is_tdx = !memcmp(TDX_IDENT, sig, sizeof(sig));
+		once = true;
+	}
+
+	return is_tdx;
+}
+
 static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
-	error("Cannot accept memory");
+	if (is_tdx_guest())
+		tdx_accept_memory(start, end);
+	else
+		error("Cannot accept memory: unknown platform\n");
 }
 
 /*
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 918a7606f53c..8518a75e5dd5 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -3,12 +3,15 @@
 #include "../cpuflags.h"
 #include "../string.h"
 #include "../io.h"
+#include "align.h"
 #include "error.h"
+#include "pgtable_types.h"
 
 #include <vdso/limits.h>
 #include <uapi/asm/vmx.h>
 
 #include <asm/shared/tdx.h>
+#include <asm/page_types.h>
 
 /* Called from __tdx_hypercall() for unrecoverable failure */
 void __tdx_hypercall_failed(void)
@@ -75,3 +78,78 @@ void early_tdx_detect(void)
 	pio_ops.f_outb = tdx_outb;
 	pio_ops.f_outw = tdx_outw;
 }
+
+static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
+				    enum pg_level level)
+{
+	unsigned long accept_size = PAGE_SIZE << ((level - 1) * PTE_SHIFT);
+	u64 tdcall_rcx;
+	u8 page_size;
+
+	if (!IS_ALIGNED(start, accept_size))
+		return 0;
+
+	if (len < accept_size)
+		return 0;
+
+	/*
+	 * Pass the page physical address to the TDX module to accept the
+	 * pending, private page.
+	 *
+	 * Bits 2:0 of RCX encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
+	 */
+	switch (level) {
+	case PG_LEVEL_4K:
+		page_size = 0;
+		break;
+	case PG_LEVEL_2M:
+		page_size = 1;
+		break;
+	case PG_LEVEL_1G:
+		page_size = 2;
+		break;
+	default:
+		return 0;
+	}
+
+	tdcall_rcx = start | page_size;
+	if (__tdx_module_call(TDX_ACCEPT_PAGE, tdcall_rcx, 0, 0, 0, NULL))
+		return 0;
+
+	return accept_size;
+}
+
+void tdx_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	/*
+	 * Notify the VMM about page mapping conversion. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
+	 * section "TDG.VP.VMCALL<MapGPA>"
+	 */
+	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
+		error("Accepting memory failed\n");
+
+	/*
+	 * For shared->private conversion, accept the page using
+	 * TDX_ACCEPT_PAGE TDX module call.
+	 */
+	while (start < end) {
+		unsigned long len = end - start;
+		unsigned long accept_size;
+
+		/*
+		 * Try larger accepts first. It gives chance to VMM to keep
+		 * 1G/2M Secure EPT entries where possible and speeds up
+		 * process by cutting number of hypercalls (if successful).
+		 */
+
+		accept_size = try_accept_one(start, len, PG_LEVEL_1G);
+		if (!accept_size)
+			accept_size = try_accept_one(start, len, PG_LEVEL_2M);
+		if (!accept_size)
+			accept_size = try_accept_one(start, len, PG_LEVEL_4K);
+		if (!accept_size)
+			error("Accepting memory failed\n");
+		start += accept_size;
+	}
+}
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index b10c95307f6e..8240f04d3646 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -664,16 +664,9 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 	return accept_size;
 }
 
-/*
- * Inform the VMM of the guest's intent for this physical page: shared with
- * the VMM or private to the guest.  The VMM is expected to change its mapping
- * of the page in response.
- */
-static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end,
+					bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
-
 	if (!enc) {
 		/* Set the shared (decrypted) bits: */
 		start |= cc_mkdec(0);
@@ -719,6 +712,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	return true;
 }
 
+void tdx_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	if (!tdx_enc_status_changed_phys(start, end, true))
+		panic("Accepting memory failed: %#llx-%#llx\n",  start, end);
+}
+
+/*
+ * Inform the VMM of the guest's intent for this physical page: shared with
+ * the VMM or private to the guest.  The VMM is expected to change its mapping
+ * of the page in response.
+ */
+static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+{
+	phys_addr_t start = __pa(vaddr);
+	phys_addr_t end = __pa(vaddr + numpages * PAGE_SIZE);
+
+	return tdx_enc_status_changed_phys(start, end, enc);
+}
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 956ced04c3be..97534c334473 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -81,5 +81,7 @@ struct tdx_module_output {
 u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		      struct tdx_module_output *out);
 
+void tdx_accept_memory(phys_addr_t start, phys_addr_t end);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_SHARED_TDX_H */
diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index 05e216716690..9ec2304272dc 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -7,6 +7,7 @@
 
 #include <asm/io.h>
 #include <asm/setup.h>
+#include <asm/shared/tdx.h>
 #include <asm/unaccepted_memory.h>
 
 /* Protects unaccepted memory bitmap */
@@ -62,7 +63,13 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 		unsigned long len = range_end - range_start;
 
 		/* Platform-specific memory-acceptance call goes here */
-		panic("Cannot accept memory: unknown platform\n");
+		if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+			tdx_accept_memory(range_start * PMD_SIZE,
+					  range_end * PMD_SIZE);
+		} else {
+			panic("Cannot accept memory: unknown platform\n");
+		}
+
 		bitmap_clear(bitmap, range_start, len);
 	}
 	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
-- 
2.35.1

