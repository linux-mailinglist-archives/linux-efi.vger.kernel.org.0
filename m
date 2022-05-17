Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7739F52A6E9
	for <lists+linux-efi@lfdr.de>; Tue, 17 May 2022 17:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350270AbiEQPfV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 May 2022 11:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350210AbiEQPfT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 May 2022 11:35:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54204132D;
        Tue, 17 May 2022 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652801708; x=1684337708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TsAwCfdAdafujOyHFgsyk745Iw7lWdJZB7G50GW1UE4=;
  b=fg4ZWQB0n05Y9I5KqdOgHp3Dmv1DkCg5nFAjgvAS4LcRkA2Ie5MwzmcY
   h2xdJlv18tN9rtn5O2BE1oKrEUGMVZKPvpBzR1mZFj4iQ+PQocKGgTRpz
   Jg7sNvQpISD08yNCMtjWekNRlC7IaRSpvQXSpjFqCWud0NsQgJ2BgGREU
   81Jdx/OfIhA29wexwyWc1SZcRnbYVmjUrNxHTLYyI95XzpEWW9RNABRaa
   Jk1tYNh7xVDlq6h6wH4tyDToNYfsD0v58s6W8bDt+Trilm8viWg9NgrtC
   vvwMzQMpMoagv2wg7EaJEjk7TmUn20sD7lK0UIgL1KLRnYGEbMSrMiXbE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="268803774"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="268803774"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 08:35:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="700105240"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 17 May 2022 08:34:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id EDC4DDFD; Tue, 17 May 2022 18:34:50 +0300 (EEST)
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
Subject: [PATCHv6 14/15] x86/tdx: Add unaccepted memory support
Date:   Tue, 17 May 2022 18:34:43 +0300
Message-Id: <20220517153444.11195-15-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
index f1320d9a3da3..661392f046ec 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -890,6 +890,7 @@ config INTEL_TDX_GUEST
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
index 90237700a942..8649e6fe6c3a 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -601,16 +601,9 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
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
@@ -656,6 +649,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
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
index b4c43e6089b0..6ecd79101922 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -9,6 +9,7 @@
 #include <asm/e820/api.h>
 #include <asm/io.h>
 #include <asm/setup.h>
+#include <asm/shared/tdx.h>
 #include <asm/unaccepted_memory.h>
 
 /* Protects unaccepted memory bitmap and nr_unaccepted */
@@ -65,7 +66,13 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
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
 
 		/* In early boot nr_unaccepted is not yet initialized */
-- 
2.35.1

