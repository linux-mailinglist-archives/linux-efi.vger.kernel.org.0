Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E695A701A89
	for <lists+linux-efi@lfdr.de>; Sun, 14 May 2023 00:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjEMWFN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 May 2023 18:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjEMWE5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 May 2023 18:04:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987A635B5;
        Sat, 13 May 2023 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684015495; x=1715551495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TXEN8aOVCx4uC+2oczJcWR+KSaKZgQy+3tVmVD2kOCc=;
  b=V9ueDi1e6zM5SJa+CoTciccEh44SngEZZLtasQ5kCq92q8T2MKveP5sI
   Mx+R8gWhTOSICY1mb7hf8fJYAIwsFW5CKlIsXDdOCrfkAi4CVthITt6Ln
   BJiDyPW5GfDrSo1UHUpI33ypJGFqDM21DW90YJ89M2j6qlOFu9kByCLFu
   9IqY/px5lqIdDYpkO3Q62cwetkvMzN8tuEYPjGLoeccylJkVroWQzMICD
   U5iADnNqv+llm03m4FvSCR2gXJdvXzcxG1TNsQLN8XGa8qGr6zHACg8RV
   N2i9b3m0q8PI2FtzVKYoAtFBbk0StWWc+b8t8wjzccGtiJBWuBpCuzUy5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="379142592"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="379142592"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 15:04:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="733429558"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="733429558"
Received: from sorinaau-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.62.145])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 15:04:45 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 39B2D10CF7F; Sun, 14 May 2023 01:04:34 +0300 (+03)
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
Subject: [PATCHv11 9/9] x86/tdx: Add unaccepted memory support
Date:   Sun, 14 May 2023 01:04:18 +0300
Message-Id: <20230513220418.19357-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
 arch/x86/Kconfig                         |  2 +
 arch/x86/boot/compressed/Makefile        |  2 +-
 arch/x86/boot/compressed/error.c         | 19 +++++
 arch/x86/boot/compressed/error.h         |  1 +
 arch/x86/boot/compressed/mem.c           | 35 ++++++++-
 arch/x86/boot/compressed/tdx-shared.c    |  2 +
 arch/x86/boot/compressed/tdx.c           | 37 +++++++++
 arch/x86/coco/tdx/Makefile               |  2 +-
 arch/x86/coco/tdx/tdx-shared.c           | 95 ++++++++++++++++++++++++
 arch/x86/coco/tdx/tdx.c                  | 86 +--------------------
 arch/x86/include/asm/shared/tdx.h        |  2 +
 arch/x86/include/asm/tdx.h               |  2 +
 arch/x86/include/asm/unaccepted_memory.h | 23 ++++++
 13 files changed, 221 insertions(+), 87 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdx-shared.c
 create mode 100644 arch/x86/coco/tdx/tdx-shared.c
 create mode 100644 arch/x86/include/asm/unaccepted_memory.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..5c72067c06d4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -884,9 +884,11 @@ config INTEL_TDX_GUEST
 	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
+	depends on EFI_STUB
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
+	select UNACCEPTED_MEMORY
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index cc4978123c30..78f67e0a2666 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,7 +107,7 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
-vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
+vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o $(obj)/tdx-shared.o
 
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
diff --git a/arch/x86/boot/compressed/error.c b/arch/x86/boot/compressed/error.c
index c881878e56d3..5313c5cb2b80 100644
--- a/arch/x86/boot/compressed/error.c
+++ b/arch/x86/boot/compressed/error.c
@@ -22,3 +22,22 @@ void error(char *m)
 	while (1)
 		asm("hlt");
 }
+
+/* EFI libstub  provides vsnprintf() */
+#ifdef CONFIG_EFI_STUB
+void panic(const char *fmt, ...)
+{
+	static char buf[1024];
+	va_list args;
+	int len;
+
+	va_start(args, fmt);
+	len = vsnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
+
+	if (len && buf[len - 1] == '\n')
+		buf[len - 1] = '\0';
+
+	error(buf);
+}
+#endif
diff --git a/arch/x86/boot/compressed/error.h b/arch/x86/boot/compressed/error.h
index 1de5821184f1..86fe33b93715 100644
--- a/arch/x86/boot/compressed/error.h
+++ b/arch/x86/boot/compressed/error.h
@@ -6,5 +6,6 @@
 
 void warn(char *m);
 void error(char *m) __noreturn;
+void panic(const char *fmt, ...) __noreturn __cold;
 
 #endif /* BOOT_COMPRESSED_ERROR_H */
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index 67594fcb11d9..a4308d077885 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -1,9 +1,42 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include "../cpuflags.h"
+#include "../string.h"
 #include "error.h"
+#include "tdx.h"
+#include <asm/shared/tdx.h>
+
+/*
+ * accept_memory() and process_unaccepted_memory() called from EFI stub which
+ * runs before decompresser and its early_tdx_detect().
+ *
+ * Enumerate TDX directly from the early users.
+ */
+static bool early_is_tdx_guest(void)
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
 
 void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
-	error("Cannot accept memory");
+	if (early_is_tdx_guest())
+		tdx_accept_memory(start, end);
+	else
+		error("Cannot accept memory: unknown platform\n");
 }
diff --git a/arch/x86/boot/compressed/tdx-shared.c b/arch/x86/boot/compressed/tdx-shared.c
new file mode 100644
index 000000000000..5ac43762fe13
--- /dev/null
+++ b/arch/x86/boot/compressed/tdx-shared.c
@@ -0,0 +1,2 @@
+#include "error.h"
+#include "../../coco/tdx/tdx-shared.c"
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 2d81d3cc72a1..d073764eaa50 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -9,6 +9,9 @@
 #include <uapi/asm/vmx.h>
 
 #include <asm/shared/tdx.h>
+#include <asm/page_types.h>
+
+static u64 cc_mask;
 
 /* Called from __tdx_hypercall() for unrecoverable failure */
 void __tdx_hypercall_failed(void)
@@ -16,6 +19,38 @@ void __tdx_hypercall_failed(void)
 	error("TDVMCALL failed. TDX module bug?");
 }
 
+static u64 get_cc_mask(void)
+{
+	struct tdx_module_output out;
+	unsigned int gpa_width;
+
+	/*
+	 * TDINFO TDX module call is used to get the TD execution environment
+	 * information like GPA width, number of available vcpus, debug mode
+	 * information, etc. More details about the ABI can be found in TDX
+	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
+	 * [TDG.VP.INFO].
+	 *
+	 * The GPA width that comes out of this call is critical. TDX guests
+	 * can not meaningfully run without it.
+	 */
+	if (__tdx_module_call(TDX_GET_INFO, 0, 0, 0, 0, &out))
+		error("TDCALL GET_INFO failed (Buggy TDX module!)\n");
+
+	gpa_width = out.rcx & GENMASK(5, 0);
+
+	/*
+	 * The highest bit of a guest physical address is the "sharing" bit.
+	 * Set it for shared pages and clear it for private pages.
+	 */
+	return BIT_ULL(gpa_width - 1);
+}
+
+u64 cc_mkdec(u64 val)
+{
+	return val & ~cc_mask;
+}
+
 static inline unsigned int tdx_io_in(int size, u16 port)
 {
 	struct tdx_hypercall_args args = {
@@ -70,6 +105,8 @@ void early_tdx_detect(void)
 	if (memcmp(TDX_IDENT, sig, sizeof(sig)))
 		return;
 
+	cc_mask = get_cc_mask();
+
 	/* Use hypercalls instead of I/O instructions */
 	pio_ops.f_inb  = tdx_inb;
 	pio_ops.f_outb = tdx_outb;
diff --git a/arch/x86/coco/tdx/Makefile b/arch/x86/coco/tdx/Makefile
index 46c55998557d..2c7dcbf1458b 100644
--- a/arch/x86/coco/tdx/Makefile
+++ b/arch/x86/coco/tdx/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += tdx.o tdcall.o
+obj-y += tdx.o tdx-shared.o tdcall.o
diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
new file mode 100644
index 000000000000..ee74f7bbe806
--- /dev/null
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -0,0 +1,95 @@
+#include <asm/tdx.h>
+#include <asm/pgtable.h>
+
+static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
+				    enum pg_level pg_level)
+{
+	unsigned long accept_size = page_level_size(pg_level);
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
+	switch (pg_level) {
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
+bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end, bool enc)
+{
+	if (!enc) {
+		/* Set the shared (decrypted) bits: */
+		start |= cc_mkdec(0);
+		end   |= cc_mkdec(0);
+	}
+
+	/*
+	 * Notify the VMM about page mapping conversion. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
+	 * section "TDG.VP.VMCALL<MapGPA>"
+	 */
+	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
+		return false;
+
+	/* private->shared conversion  requires only MapGPA call */
+	if (!enc)
+		return true;
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
+			return false;
+		start += accept_size;
+	}
+
+	return true;
+}
+
+void tdx_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	if (!tdx_enc_status_changed_phys(start, end, true))
+		panic("Accepting memory failed: %#llx-%#llx\n",  start, end);
+}
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 0d5fe6e24e45..32501277ef84 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -713,46 +713,6 @@ static bool tdx_cache_flush_required(void)
 	return true;
 }
 
-static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
-				    enum pg_level pg_level)
-{
-	unsigned long accept_size = page_level_size(pg_level);
-	u64 tdcall_rcx;
-	u8 page_size;
-
-	if (!IS_ALIGNED(start, accept_size))
-		return 0;
-
-	if (len < accept_size)
-		return 0;
-
-	/*
-	 * Pass the page physical address to the TDX module to accept the
-	 * pending, private page.
-	 *
-	 * Bits 2:0 of RCX encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
-	 */
-	switch (pg_level) {
-	case PG_LEVEL_4K:
-		page_size = 0;
-		break;
-	case PG_LEVEL_2M:
-		page_size = 1;
-		break;
-	case PG_LEVEL_1G:
-		page_size = 2;
-		break;
-	default:
-		return 0;
-	}
-
-	tdcall_rcx = start | page_size;
-	if (__tdx_module_call(TDX_ACCEPT_PAGE, tdcall_rcx, 0, 0, 0, NULL))
-		return 0;
-
-	return accept_size;
-}
-
 /*
  * Inform the VMM of the guest's intent for this physical page: shared with
  * the VMM or private to the guest.  The VMM is expected to change its mapping
@@ -761,51 +721,9 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 {
 	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	phys_addr_t end = __pa(vaddr + numpages * PAGE_SIZE);
 
-	if (!enc) {
-		/* Set the shared (decrypted) bits: */
-		start |= cc_mkdec(0);
-		end   |= cc_mkdec(0);
-	}
-
-	/*
-	 * Notify the VMM about page mapping conversion. More info about ABI
-	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
-	 * section "TDG.VP.VMCALL<MapGPA>"
-	 */
-	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
-		return false;
-
-	/* private->shared conversion  requires only MapGPA call */
-	if (!enc)
-		return true;
-
-	/*
-	 * For shared->private conversion, accept the page using
-	 * TDX_ACCEPT_PAGE TDX module call.
-	 */
-	while (start < end) {
-		unsigned long len = end - start;
-		unsigned long accept_size;
-
-		/*
-		 * Try larger accepts first. It gives chance to VMM to keep
-		 * 1G/2M Secure EPT entries where possible and speeds up
-		 * process by cutting number of hypercalls (if successful).
-		 */
-
-		accept_size = try_accept_one(start, len, PG_LEVEL_1G);
-		if (!accept_size)
-			accept_size = try_accept_one(start, len, PG_LEVEL_2M);
-		if (!accept_size)
-			accept_size = try_accept_one(start, len, PG_LEVEL_4K);
-		if (!accept_size)
-			return false;
-		start += accept_size;
-	}
-
-	return true;
+	return tdx_enc_status_changed_phys(start, end, enc);
 }
 
 void __init tdx_early_init(void)
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 1ff0ee822961..95fbe7376694 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -91,5 +91,7 @@ struct tdx_module_output {
 u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		      struct tdx_module_output *out);
 
+void tdx_accept_memory(phys_addr_t start, phys_addr_t end);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_SHARED_TDX_H */
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 234197ec17e4..3a7340ad9a4b 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -50,6 +50,8 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
 
 int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
 
+bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end, bool enc);
+
 #else
 
 static inline void tdx_early_init(void) { };
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
new file mode 100644
index 000000000000..72b354f992bb
--- /dev/null
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -0,0 +1,23 @@
+#ifndef _ASM_X86_UNACCEPTED_MEMORY_H
+#define _ASM_X86_UNACCEPTED_MEMORY_H
+
+#include <linux/efi.h>
+#include <asm/tdx.h>
+
+static inline void arch_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	/* Platform-specific memory-acceptance call goes here */
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+		tdx_accept_memory(start, end);
+	} else {
+		panic("Cannot accept memory: unknown platform\n");
+	}
+}
+
+static inline struct efi_unaccepted_memory *efi_get_unaccepted_table(void)
+{
+	if (efi.unaccepted == EFI_INVALID_TABLE_ADDR)
+		return NULL;
+	return __va(efi.unaccepted);
+}
+#endif
-- 
2.39.3

