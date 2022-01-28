Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967254A026F
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 21:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbiA1U7R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 15:59:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:23140 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244629AbiA1U7Q (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 15:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643403556; x=1674939556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x5vneaFsQl42X/y/ifPS+cErbpw7siRo7HVvjOaNdMc=;
  b=T67oe+UjCj0zIoUQJwlZB0c9LSngjF0SbiNnQaEMyjvipdTMPwFBqbjG
   U7yX+lwKCHJImAeWegchI0aJ1ijsgJ8EZ/HmBlY2+mHF8k1kO8q0soc60
   b/YrquZiBQNJ9jtop7AYHxX7DbvX07w8hzeqbSxKyLhRdJzw5QmmNq3CI
   jnhiPISkAuFPBBDg/IXm43AfyfxbsqB5c9BYc7DehPLDddAK+/LS6C7tJ
   aq/X1NywatGaYhwVE1o4Is8uK3MfZfpSNEisSJt0EkkaCR8548Fn6eSOc
   +t3u6Twy2y8/2Cq7atzGENMhYppabTEPUcBCxCvshfdtB+R1BY6JxRSky
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="246037902"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="246037902"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 12:59:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="675199537"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2022 12:59:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id DF800488; Fri, 28 Jan 2022 22:59:09 +0200 (EET)
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
Subject: [PATCHv3 7/7] x86/tdx: Unaccepted memory support
Date:   Fri, 28 Jan 2022 23:59:06 +0300
Message-Id: <20220128205906.27503-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128205906.27503-1-kirill.shutemov@linux.intel.com>
References: <20220128205906.27503-1-kirill.shutemov@linux.intel.com>
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
 arch/x86/boot/compressed/tdx.c               | 27 ++++++++++++++++++++
 arch/x86/boot/compressed/unaccepted_memory.c | 10 +++++++-
 arch/x86/include/asm/shared/tdx.h            | 21 +++++++++++++++
 arch/x86/include/asm/tdx.h                   | 19 --------------
 arch/x86/kernel/tdx.c                        |  6 +++++
 arch/x86/mm/unaccepted_memory.c              |  6 ++++-
 7 files changed, 69 insertions(+), 21 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f4fdd408698..b4ba8cc3e9c0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -886,6 +886,7 @@ config INTEL_TDX_GUEST
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MCE
 	select X86_MEM_ENCRYPT
+	select UNACCEPTED_MEMORY
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index f2e1449c74cd..eac80d172e36 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -6,11 +6,13 @@
 #include "../cpuflags.h"
 #include "../string.h"
 #include "../io.h"
+#include "error.h"
 
 #include <vdso/limits.h>
 #include <uapi/asm/vmx.h>
 
 #include <asm/shared/tdx.h>
+#include <asm/page_types.h>
 
 static bool tdx_guest_detected;
 
@@ -86,3 +88,28 @@ void early_tdx_detect(void)
 	pio_ops.outw = tdx_outw;
 	pio_ops.outl = tdx_outl;
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
index d0de7e88dade..a2df2cae5c1b 100644
--- a/arch/x86/boot/compressed/unaccepted_memory.c
+++ b/arch/x86/boot/compressed/unaccepted_memory.c
@@ -1,12 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <asm/shared/tdx.h>
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
@@ -18,6 +23,9 @@ void mark_unaccepted(struct boot_params *params, u64 start, u64 end)
 	 * *marked* as unaccepted.
 	 */
 
+	/* __accept_memory() needs to know if kernel runs in TDX environment */
+	early_tdx_detect();
+
 	/*
 	 * Accept small regions that might not be able to be represented
 	 * in the bitmap:
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 4a0218bedc75..b17e7d68e0d3 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -3,6 +3,21 @@
 
 #include <linux/types.h>
 
+/*
+ * Used in __tdx_module_call() to gather the output registers'
+ * values of the TDCALL instruction when requesting services from
+ * the TDX module. This is a software only structure and not part
+ * of the TDX module/VMM ABI
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
 /*
  * Used in __tdx_hypercall() to gather the output registers' values
  * of the TDCALL instruction when requesting services from the VMM.
@@ -23,8 +38,14 @@ struct tdx_hypercall_output {
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
+/* Used to communicate with the TDX module */
+u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+		      struct tdx_module_output *out);
+
 /* Used to request services from the VMM */
 u64 __tdx_hypercall(u64 type, u64 fn, u64 r12, u64 r13, u64 r14,
 		    u64 r15, struct tdx_hypercall_output *out);
 
+extern void tdx_accept_memory(phys_addr_t start, phys_addr_t end);
+
 #endif
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index f6a5fb4bf72c..cf0f7f008e6c 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -7,21 +7,6 @@
 #include <asm/ptrace.h>
 #include <asm/shared/tdx.h>
 
-/*
- * Used in __tdx_module_call() to gather the output registers'
- * values of the TDCALL instruction when requesting services from
- * the TDX module. This is a software only structure and not part
- * of the TDX module/VMM ABI
- */
-struct tdx_module_output {
-	u64 rcx;
-	u64 rdx;
-	u64 r8;
-	u64 r9;
-	u64 r10;
-	u64 r11;
-};
-
 /*
  * Used by the #VE exception handler to gather the #VE exception
  * info from the TDX module. This is a software only structure
@@ -43,10 +28,6 @@ struct ve_info {
 void __init tdx_early_init(void);
 bool is_tdx_guest(void);
 
-/* Used to communicate with the TDX module */
-u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-		      struct tdx_module_output *out);
-
 bool tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 35ef57d778bb..a9bce0a54e1c 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -176,6 +176,12 @@ int tdx_hcall_request_gpa_type(phys_addr_t start, phys_addr_t end, bool enc)
 	return 0;
 }
 
+void tdx_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	if (tdx_hcall_request_gpa_type(start, end, true))
+		panic("Accepting memory failed\n");
+}
+
 static u64 __cpuidle _tdx_halt(const bool irq_disabled, const bool do_sti)
 {
 	/*
diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index adcac22dfe75..2c4ef49a0c9b 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -5,6 +5,7 @@
 
 #include <asm/io.h>
 #include <asm/setup.h>
+#include <asm/shared/tdx.h>
 #include <asm/unaccepted_memory.h>
 
 static DEFINE_SPINLOCK(unaccepted_memory_lock);
@@ -22,7 +23,10 @@ static void __accept_memory(phys_addr_t start, phys_addr_t end)
 	for_each_set_bitrange_from(rs, re, unaccepted_memory,
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

