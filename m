Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F307645181
	for <lists+linux-efi@lfdr.de>; Wed,  7 Dec 2022 02:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiLGBum (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Dec 2022 20:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiLGBuU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Dec 2022 20:50:20 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD44537CE;
        Tue,  6 Dec 2022 17:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670377803; x=1701913803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sQNT2Cy2EmGfD2ueukiP5unO91F0G3BJKGWeML9T+YI=;
  b=B6oBsEh/LUWps9lKt/VqFNquuf7NbuwOtn1zPf+zvd0goLAENaYY1HuC
   hE5iP65lNQqFCkx6v0pZay4ds/r1fpBYNlsnYF5W7k1/JrhYi4z6bq2EF
   F1zV/sY3UUaJZs1I1Egw5QPw7pq5y31PGN47KQhuXGiflgpHIAB4P57Oo
   E5xW6bv2tQNsNVZo0ZuloOeL3LeRN368omdmFFOxNHBraKgQw5qOLIieu
   2sM/4XoaDAChwOc5SusBMbUIhrZT/9Fxa051fHtI3DqVoyXmoNVORLRMi
   XXFi+tlXl1sy24U429RDfSq7brHDEsvJW3/DJWiGHxyIylO4H+exe4pIv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="316794469"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="316794469"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:50:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="640082297"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="640082297"
Received: from puneets1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.38.123])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:49:53 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id ADFAB109C90; Wed,  7 Dec 2022 04:49:39 +0300 (+03)
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
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv8 12/14] x86/tdx: Make _tdx_hypercall() and __tdx_module_call() available in boot stub
Date:   Wed,  7 Dec 2022 04:49:31 +0300
Message-Id: <20221207014933.8435-13-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Memory acceptance requires a hypercall and one or multiple module calls.

Make helpers for the calls available in boot stub. It has to accept
memory where kernel image and initrd are placed.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c           | 27 ------------------
 arch/x86/include/asm/shared/tdx.h | 46 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h        | 19 -------------
 3 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index cfd4c95b9f04..12c14affa5f2 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -14,15 +14,6 @@
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
 
-/* TDX module Call Leaf IDs */
-#define TDX_GET_INFO			1
-#define TDX_GET_VEINFO			3
-#define TDX_GET_REPORT			4
-#define TDX_ACCEPT_PAGE			6
-
-/* TDX hypercall Leaf IDs */
-#define TDVMCALL_MAP_GPA		0x10001
-
 /* MMIO direction */
 #define EPT_READ	0
 #define EPT_WRITE	1
@@ -45,24 +36,6 @@
 
 #define TDREPORT_SUBTYPE_0	0
 
-/*
- * Wrapper for standard use of __tdx_hypercall with no output aside from
- * return code.
- */
-static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
-{
-	struct tdx_hypercall_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = fn,
-		.r12 = r12,
-		.r13 = r13,
-		.r14 = r14,
-		.r15 = r15,
-	};
-
-	return __tdx_hypercall(&args, 0);
-}
-
 /* Called from __tdx_hypercall() for unrecoverable failure */
 void __tdx_hypercall_failed(void)
 {
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index e53f26228fbb..c5f12b90ef70 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -13,6 +13,15 @@
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
+/* TDX module Call Leaf IDs */
+#define TDX_GET_INFO			1
+#define TDX_GET_VEINFO			3
+#define TDX_GET_REPORT			5
+#define TDX_ACCEPT_PAGE			6
+
+/* TDX hypercall Leaf IDs */
+#define TDVMCALL_MAP_GPA		0x10001
+
 #ifndef __ASSEMBLY__
 
 /*
@@ -33,8 +42,45 @@ struct tdx_hypercall_args {
 /* Used to request services from the VMM */
 u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
 
+/*
+ * Wrapper for standard use of __tdx_hypercall with no output aside from
+ * return code.
+ */
+static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = fn,
+		.r12 = r12,
+		.r13 = r13,
+		.r14 = r14,
+		.r15 = r15,
+	};
+
+	return __tdx_hypercall(&args, 0);
+}
+
+
 /* Called from __tdx_hypercall() for unrecoverable failure */
 void __tdx_hypercall_failed(void);
 
+/*
+ * Used in __tdx_module_call() to gather the output registers' values of the
+ * TDCALL instruction when requesting services from the TDX module. This is a
+ * software only structure and not part of the TDX module/VMM ABI
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
+/* Used to communicate with the TDX module */
+u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+		      struct tdx_module_output *out);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_SHARED_TDX_H */
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 28d889c9aa16..234197ec17e4 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -20,21 +20,6 @@
 
 #ifndef __ASSEMBLY__
 
-/*
- * Used to gather the output registers values of the TDCALL and SEAMCALL
- * instructions when requesting services from the TDX module.
- *
- * This is a software only structure and not part of the TDX module/VMM ABI.
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
@@ -55,10 +40,6 @@ struct ve_info {
 
 void __init tdx_early_init(void);
 
-/* Used to communicate with the TDX module */
-u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-		      struct tdx_module_output *out);
-
 void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
-- 
2.38.0

