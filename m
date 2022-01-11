Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2111848AC88
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 12:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349633AbiAKLdh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 06:33:37 -0500
Received: from mga04.intel.com ([192.55.52.120]:11112 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349556AbiAKLdT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 11 Jan 2022 06:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641900799; x=1673436799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ix1Lln08Q+6dMYxeRkLCXlqDI7dwftevgrEgpLe26DE=;
  b=EOCPcVVvhyRtHbK7HrePAxpd/dSDdH9MuzZtKMbASPpxXrEe+zUbG6aL
   NNOR/XJPncU3SCyvQRd1bIS+PiueDzpisCmSlqKQl9g1LDWgZqF3aFAME
   0QjIbF5i7hXlXeZh4Q791/X487ySA2KGdsmtkOHOEdInyQNlbegc+Ywik
   IHATTdIhHNThrB7Jchkd6vAjXSO5j+5KMkLuq9ZEn+JfgiQF/rw7E8xAz
   y7DYAB9iTNMCynRs2YuW6JMYEKGRL9IBBgaXdOZwUoL2w5c5E4AYh7gab
   0wOUi3gG2fBmsTxYvoEzJFlxf4reb8fNj6vUM2C+np9DLyAl8Qw7RBUJT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="242277611"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="242277611"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 03:33:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="576179347"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jan 2022 03:33:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 79EB7699; Tue, 11 Jan 2022 13:33:19 +0200 (EET)
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
Subject: [PATCHv2 7/7] x86/tdx: Unaccepted memory support
Date:   Tue, 11 Jan 2022 14:33:14 +0300
Message-Id: <20220111113314.27173-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

All preparation is complete. Hookup TDX-specific code to accept memory.

There are two tdx_accept_memory() implementations: one in main kernel
and one in the decompressor.

The implementation in core kernel uses tdx_hcall_gpa_intent().
The helper is not available in the decompressor, self-contained
implementation added there instead.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                             |  1 +
 arch/x86/boot/compressed/tdx.c               | 67 ++++++++++++++++++++
 arch/x86/boot/compressed/unaccepted_memory.c |  9 ++-
 arch/x86/include/asm/tdx.h                   |  2 +
 arch/x86/kernel/tdx.c                        |  7 ++
 arch/x86/mm/unaccepted_memory.c              |  6 +-
 6 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e2ed1684f399..5d0f99bd3538 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -879,6 +879,7 @@ config INTEL_TDX_GUEST
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MCE
 	select X86_MEM_ENCRYPT
+	select UNACCEPTED_MEMORY
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 50c8145bd0f3..587e6d948953 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -5,12 +5,54 @@
 
 #include "../cpuflags.h"
 #include "../string.h"
+#include "error.h"
 
+#include <asm/page_types.h>
+
+#define TDX_HYPERCALL_STANDARD	0
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
+/*
+ * Used in __tdx_module_call() helper function to gather the
+ * output registers' values of TDCALL instruction when requesting
+ * services from the TDX module. This is software only structure
+ * and not related to TDX module/VMM.
+ */
+struct tdx_module_output {
+	u64 rcx;
+	u64 rdx;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+};
+
+/*
+ * Used in __tdx_hypercall() helper function to gather the
+ * output registers' values of TDCALL instruction when requesting
+ * services from the VMM. This is software only structure
+ * and not related to TDX module/VMM.
+ */
+struct tdx_hypercall_output {
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+};
+
 static bool tdx_guest_detected;
 
+/* Helper function used to communicate with the TDX module */
+u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+		      struct tdx_module_output *out);
+
+/* Helper function used to request services from VMM */
+u64 __tdx_hypercall(u64 type, u64 fn, u64 r12, u64 r13, u64 r14,
+		    u64 r15, struct tdx_hypercall_output *out);
+
 void early_tdx_detect(void)
 {
 	u32 eax, sig[3];
@@ -28,3 +70,28 @@ bool early_is_tdx_guest(void)
 {
 	return tdx_guest_detected;
 }
+
+#define TDACCEPTPAGE		6
+#define TDVMCALL_MAP_GPA	0x10001
+
+void tdx_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	struct tdx_hypercall_output outl = {0};
+	int i;
+
+	if (__tdx_hypercall(TDX_HYPERCALL_STANDARD, TDVMCALL_MAP_GPA,
+			    start, end, 0, 0, &outl)) {
+		error("Cannot accept memory: MapGPA failed\n");
+	}
+
+	/*
+	 * For shared->private conversion, accept the page using TDACCEPTPAGE
+	 * TDX module call.
+	 */
+	for (i = 0; i < (end - start) / PAGE_SIZE; i++) {
+		if (__tdx_module_call(TDACCEPTPAGE, start + i * PAGE_SIZE,
+				      0, 0, 0, NULL)) {
+			error("Cannot accept memory: page accept failed\n");
+		}
+	}
+}
diff --git a/arch/x86/boot/compressed/unaccepted_memory.c b/arch/x86/boot/compressed/unaccepted_memory.c
index b6caca4d3d22..c23526c25e50 100644
--- a/arch/x86/boot/compressed/unaccepted_memory.c
+++ b/arch/x86/boot/compressed/unaccepted_memory.c
@@ -2,11 +2,15 @@
 
 #include "error.h"
 #include "misc.h"
+#include "tdx.h"
 
 static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
-	error("Cannot accept memory");
+	if (early_is_tdx_guest())
+		tdx_accept_memory(start, end);
+	else
+		error("Cannot accept memory");
 }
 
 void mark_unaccepted(struct boot_params *params, u64 start, u64 end)
@@ -18,6 +22,9 @@ void mark_unaccepted(struct boot_params *params, u64 start, u64 end)
 	 * *marked* as unaccepted.
 	 */
 
+	/* __accept_memory() needs to know if kernel runs in TDX environment */
+	early_tdx_detect();
+
 	/* Immediately accept whole range if it is within a PMD_SIZE block: */
 	if ((start & PMD_MASK) == (end & PMD_MASK)) {
 		__accept_memory(start, end);
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 6d901cb6d607..fbbe4644cc7b 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -90,6 +90,8 @@ phys_addr_t tdx_shared_mask(void);
 int tdx_hcall_request_gpa_type(phys_addr_t start, phys_addr_t end,
 			       enum tdx_map_type map_type);
 
+extern void tdx_accept_memory(phys_addr_t start, phys_addr_t end);
+
 #else
 
 static inline void tdx_early_init(void) { };
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 0f8f7285c05b..a0ff720425d8 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -162,6 +162,13 @@ int tdx_hcall_request_gpa_type(phys_addr_t start, phys_addr_t end,
 	return 0;
 }
 
+void tdx_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	if (tdx_hcall_request_gpa_type(start, end, TDX_MAP_PRIVATE)) {
+		panic("Accepting memory failed\n");
+	}
+}
+
 static u64 __cpuidle _tdx_halt(const bool irq_disabled, const bool do_sti)
 {
 	/*
diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index 984eaead0b11..9f468d58d51f 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -5,6 +5,7 @@
 
 #include <asm/io.h>
 #include <asm/setup.h>
+#include <asm/tdx.h>
 #include <asm/unaccepted_memory.h>
 
 static DEFINE_SPINLOCK(unaccepted_memory_lock);
@@ -21,7 +22,10 @@ static void __accept_memory(phys_addr_t start, phys_addr_t end)
 				   start / PMD_SIZE,
 				   DIV_ROUND_UP(end, PMD_SIZE)) {
 		/* Platform-specific memory-acceptance call goes here */
-		panic("Cannot accept memory");
+		if (cc_platform_has(CC_ATTR_GUEST_TDX))
+			tdx_accept_memory(rs * PMD_SIZE, re * PMD_SIZE);
+		else
+			panic("Cannot accept memory");
 		bitmap_clear(unaccepted_memory, rs, re - rs);
 	}
 }
-- 
2.34.1

