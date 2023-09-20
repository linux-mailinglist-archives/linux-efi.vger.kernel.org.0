Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0E97A7469
	for <lists+linux-efi@lfdr.de>; Wed, 20 Sep 2023 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjITHj5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Sep 2023 03:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjITHjy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Sep 2023 03:39:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A34C9;
        Wed, 20 Sep 2023 00:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695195589; x=1726731589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WLrigc7M2aJBmw6Tk0aSBjJF93oGzGXZq+VW9pT9fwo=;
  b=jk26wCGus1Z8U1/dMGkHFS7JLvhrW50uRDn43soJTaoqAavZlM2JQeV9
   LQ16pYTNybSWh3vryLSUBndQ6l7RFEXLxOfUXO0mO8AjNSg2uVNyW1isp
   lV7Pi6tGYgdWMxXf3o3dd9E0Lb1W5oTcuSo9BU67xyw0JAQsSebzvc2Vq
   k6fxYikbbfzx9pzLkZtwdBRNq7w8KCUO7JJAh+e4+izgGXoGEPUtUnmqP
   xhk/42IYd1EPHqaOMynGjFCYNvr6VqSrAJNOqjTb9mFg5n8RsevbZLHPR
   +Dmz2Rezw0H+iY1M9HrpVeCIfWReX7bcwZm/yZRz/Q5o4Cq+OzyjMIKMV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="446622625"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="446622625"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 00:39:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="816791831"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="816791831"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmsmga004.fm.intel.com with ESMTP; 20 Sep 2023 00:39:45 -0700
From:   Xiao Wang <xiao.w.wang@intel.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org
Cc:     anup@brainfault.org, haicheng.li@intel.com,
        ajones@ventanamicro.com, linux-riscv@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH v2 1/2] riscv: Rearrange hwcap.h and cpufeature.h
Date:   Wed, 20 Sep 2023 15:46:52 +0800
Message-Id: <20230920074653.2509631-2-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920074653.2509631-1-xiao.w.wang@intel.com>
References: <20230920074653.2509631-1-xiao.w.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now hwcap.h and cpufeature.h are mutually including each other, and most of
the variable/API declarations in hwcap.h are implemented in cpufeature.c,
so, it's better to move them into cpufeature.h and leave only macros for
ISA extension logical IDs in hwcap.h.

BTW, the riscv_isa_extension_mask macro is not used now, so this patch
removes it.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/include/asm/cpufeature.h | 83 ++++++++++++++++++++++++++
 arch/riscv/include/asm/hwcap.h      | 91 -----------------------------
 arch/riscv/include/asm/pgtable.h    |  1 +
 arch/riscv/include/asm/switch_to.h  |  2 +-
 arch/riscv/include/asm/vector.h     |  2 +-
 5 files changed, 86 insertions(+), 93 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 13b7d35648a9..3061d33abc2f 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -7,7 +7,10 @@
 #define _ASM_CPUFEATURE_H
 
 #include <linux/bitmap.h>
+#include <linux/jump_label.h>
 #include <asm/hwcap.h>
+#include <asm/alternative-macros.h>
+#include <asm/errno.h>
 
 /*
  * These are probed via a device_initcall(), via either the SBI or directly
@@ -33,4 +36,84 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
 void check_unaligned_access(int cpu);
 void riscv_user_isa_enable(void);
 
+unsigned long riscv_get_elf_hwcap(void);
+
+struct riscv_isa_ext_data {
+	const unsigned int id;
+	const char *name;
+	const char *property;
+};
+
+extern const struct riscv_isa_ext_data riscv_isa_ext[];
+extern const size_t riscv_isa_ext_count;
+extern bool riscv_isa_fallback;
+
+unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
+
+bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit);
+#define riscv_isa_extension_available(isa_bitmap, ext)	\
+	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
+
+static __always_inline bool
+riscv_has_extension_likely(const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
+			   "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		asm_volatile_goto(
+		ALTERNATIVE("j	%l[l_no]", "nop", 0, %[ext], 1)
+		:
+		: [ext] "i" (ext)
+		:
+		: l_no);
+	} else {
+		if (!__riscv_isa_extension_available(NULL, ext))
+			goto l_no;
+	}
+
+	return true;
+l_no:
+	return false;
+}
+
+static __always_inline bool
+riscv_has_extension_unlikely(const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
+			   "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		asm_volatile_goto(
+		ALTERNATIVE("nop", "j	%l[l_yes]", 0, %[ext], 1)
+		:
+		: [ext] "i" (ext)
+		:
+		: l_yes);
+	} else {
+		if (__riscv_isa_extension_available(NULL, ext))
+			goto l_yes;
+	}
+
+	return false;
+l_yes:
+	return true;
+}
+
+static __always_inline bool riscv_cpu_has_extension_likely(int cpu, const unsigned long ext)
+{
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_likely(ext))
+		return true;
+
+	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
+}
+
+static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsigned long ext)
+{
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_unlikely(ext))
+		return true;
+
+	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
+}
+
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 31774bcdf1c6..141b7109c25c 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -8,9 +8,6 @@
 #ifndef _ASM_RISCV_HWCAP_H
 #define _ASM_RISCV_HWCAP_H
 
-#include <asm/alternative-macros.h>
-#include <asm/errno.h>
-#include <linux/bits.h>
 #include <uapi/asm/hwcap.h>
 
 #define RISCV_ISA_EXT_a		('a' - 'a')
@@ -67,92 +64,4 @@
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
 #endif
 
-#ifndef __ASSEMBLY__
-
-#include <linux/jump_label.h>
-#include <asm/cpufeature.h>
-
-unsigned long riscv_get_elf_hwcap(void);
-
-struct riscv_isa_ext_data {
-	const unsigned int id;
-	const char *name;
-	const char *property;
-};
-
-extern const struct riscv_isa_ext_data riscv_isa_ext[];
-extern const size_t riscv_isa_ext_count;
-extern bool riscv_isa_fallback;
-
-unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
-
-#define riscv_isa_extension_mask(ext) BIT_MASK(RISCV_ISA_EXT_##ext)
-
-bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit);
-#define riscv_isa_extension_available(isa_bitmap, ext)	\
-	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
-
-static __always_inline bool
-riscv_has_extension_likely(const unsigned long ext)
-{
-	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
-			   "ext must be < RISCV_ISA_EXT_MAX");
-
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
-		asm_volatile_goto(
-		ALTERNATIVE("j	%l[l_no]", "nop", 0, %[ext], 1)
-		:
-		: [ext] "i" (ext)
-		:
-		: l_no);
-	} else {
-		if (!__riscv_isa_extension_available(NULL, ext))
-			goto l_no;
-	}
-
-	return true;
-l_no:
-	return false;
-}
-
-static __always_inline bool
-riscv_has_extension_unlikely(const unsigned long ext)
-{
-	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
-			   "ext must be < RISCV_ISA_EXT_MAX");
-
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
-		asm_volatile_goto(
-		ALTERNATIVE("nop", "j	%l[l_yes]", 0, %[ext], 1)
-		:
-		: [ext] "i" (ext)
-		:
-		: l_yes);
-	} else {
-		if (__riscv_isa_extension_available(NULL, ext))
-			goto l_yes;
-	}
-
-	return false;
-l_yes:
-	return true;
-}
-
-static __always_inline bool riscv_cpu_has_extension_likely(int cpu, const unsigned long ext)
-{
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_likely(ext))
-		return true;
-
-	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
-}
-
-static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsigned long ext)
-{
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_unlikely(ext))
-		return true;
-
-	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
-}
-#endif
-
 #endif /* _ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index b2ba3f79cfe9..e05b5dc1f0cb 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -291,6 +291,7 @@ static inline pte_t pud_pte(pud_t pud)
 }
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
+#include <asm/cpufeature.h>
 
 static __always_inline bool has_svnapot(void)
 {
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index a727be723c56..f90d8e42f3c7 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -9,7 +9,7 @@
 #include <linux/jump_label.h>
 #include <linux/sched/task_stack.h>
 #include <asm/vector.h>
-#include <asm/hwcap.h>
+#include <asm/cpufeature.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index c5ee07b3df07..87aaef656257 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -15,7 +15,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <asm/ptrace.h>
-#include <asm/hwcap.h>
+#include <asm/cpufeature.h>
 #include <asm/csr.h>
 #include <asm/asm.h>
 
-- 
2.25.1

