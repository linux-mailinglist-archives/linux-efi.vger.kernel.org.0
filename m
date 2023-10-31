Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECBB7DC69F
	for <lists+linux-efi@lfdr.de>; Tue, 31 Oct 2023 07:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbjJaGgT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Oct 2023 02:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbjJaGgT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Oct 2023 02:36:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400F4C1;
        Mon, 30 Oct 2023 23:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698734176; x=1730270176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qWw/BBd4ZjIVJSakD08IVsaUHodEER+hLrFDko3lTaU=;
  b=I8k8d0hqPATCAx5y68/5ymgoSKpjqWHZMOhgqP63GkS/D93oD7u98+28
   a+mLBykrfzkA1Cg32XsjWjNwV/871k8SiBXfH47GuYEuLa1noDb+LX5jd
   zKqWF2dKffdDeS1Z7aIjMYaxpR+CmhS/3hRVURzpNrk8QGaLHOluryG9W
   42OUL4NNAE5OTTcGmSALAm/9slIqAkAqdmHYA/F7eu97AnD+WmoBBZjUn
   2+zlECpdkjFRr9kp7uWOIh00ZcsrnQ7ido38MaS/SmXolQ6rZEdo/mTm5
   tGaQUC5mualJMliP6CfnUFmfNdN1rbf1tvpykeK4xFqpS0BiPKNOtU4He
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="474463666"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="474463666"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 23:36:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1091896326"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1091896326"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmsmga005.fm.intel.com with ESMTP; 30 Oct 2023 23:36:06 -0700
From:   Xiao Wang <xiao.w.wang@intel.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org
Cc:     anup@brainfault.org, haicheng.li@intel.com,
        ajones@ventanamicro.com, yujie.liu@intel.com, charlie@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH v5 1/2] riscv: Rearrange hwcap.h and cpufeature.h
Date:   Tue, 31 Oct 2023 14:45:52 +0800
Message-Id: <20231031064553.2319688-2-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031064553.2319688-1-xiao.w.wang@intel.com>
References: <20231031064553.2319688-1-xiao.w.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/cpufeature.h | 83 ++++++++++++++++++++++++++
 arch/riscv/include/asm/elf.h        |  2 +-
 arch/riscv/include/asm/hwcap.h      | 91 -----------------------------
 arch/riscv/include/asm/pgtable.h    |  1 +
 arch/riscv/include/asm/switch_to.h  |  2 +-
 arch/riscv/include/asm/vector.h     |  2 +-
 arch/riscv/kvm/aia.c                |  2 +-
 arch/riscv/kvm/main.c               |  2 +-
 arch/riscv/kvm/tlb.c                |  2 +-
 arch/riscv/kvm/vcpu_fp.c            |  2 +-
 arch/riscv/kvm/vcpu_onereg.c        |  2 +-
 arch/riscv/kvm/vcpu_vector.c        |  2 +-
 drivers/clocksource/timer-riscv.c   |  2 +-
 drivers/perf/riscv_pmu_sbi.c        |  2 +-
 14 files changed, 95 insertions(+), 102 deletions(-)

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
diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index b3b2dfbdf945..06c236bfab53 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -14,7 +14,7 @@
 #include <asm/auxvec.h>
 #include <asm/byteorder.h>
 #include <asm/cacheinfo.h>
-#include <asm/hwcap.h>
+#include <asm/cpufeature.h>
 
 /*
  * These are used to set parameters in the core dumps.
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
index c8e8867c42f6..294044429e8e 100644
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
 
diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 74bb27440527..a944294f6f23 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -14,7 +14,7 @@
 #include <linux/kvm_host.h>
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
-#include <asm/hwcap.h>
+#include <asm/cpufeature.h>
 #include <asm/kvm_aia_imsic.h>
 
 struct aia_hgei_control {
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 48ae0d4b3932..225a435d9c9a 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/kvm_host.h>
 #include <asm/csr.h>
-#include <asm/hwcap.h>
+#include <asm/cpufeature.h>
 #include <asm/sbi.h>
 
 long kvm_arch_dev_ioctl(struct file *filp,
diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 44bc324aeeb0..23c0e82b5103 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -12,7 +12,7 @@
 #include <linux/kvm_host.h>
 #include <asm/cacheflush.h>
 #include <asm/csr.h>
-#include <asm/hwcap.h>
+#include <asm/cpufeature.h>
 #include <asm/insn-def.h>
 
 #define has_svinval()	riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
diff --git a/arch/riscv/kvm/vcpu_fp.c b/arch/riscv/kvm/vcpu_fp.c
index 08ba48a395aa..030904d82b58 100644
--- a/arch/riscv/kvm/vcpu_fp.c
+++ b/arch/riscv/kvm/vcpu_fp.c
@@ -11,7 +11,7 @@
 #include <linux/err.h>
 #include <linux/kvm_host.h>
 #include <linux/uaccess.h>
-#include <asm/hwcap.h>
+#include <asm/cpufeature.h>
 
 #ifdef CONFIG_FPU
 void kvm_riscv_vcpu_fp_reset(struct kvm_vcpu *vcpu)
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 1b7e9fa265cb..b03e0c879dab 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -13,7 +13,7 @@
 #include <linux/uaccess.h>
 #include <linux/kvm_host.h>
 #include <asm/cacheflush.h>
-#include <asm/hwcap.h>
+#include <asm/cpufeature.h>
 #include <asm/kvm_vcpu_vector.h>
 #include <asm/vector.h>
 
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index b430cbb69521..b339a2682f25 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -11,7 +11,7 @@
 #include <linux/err.h>
 #include <linux/kvm_host.h>
 #include <linux/uaccess.h>
-#include <asm/hwcap.h>
+#include <asm/cpufeature.h>
 #include <asm/kvm_vcpu_vector.h>
 #include <asm/vector.h>
 
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 9c8f3e2decc2..e0333142c18c 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -25,7 +25,7 @@
 #include <linux/limits.h>
 #include <clocksource/timer-riscv.h>
 #include <asm/smp.h>
-#include <asm/hwcap.h>
+#include <asm/cpufeature.h>
 #include <asm/sbi.h>
 #include <asm/timex.h>
 
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 9a51053b1f99..b97d3f1abcb1 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -22,7 +22,7 @@
 
 #include <asm/errata_list.h>
 #include <asm/sbi.h>
-#include <asm/hwcap.h>
+#include <asm/cpufeature.h>
 
 #define SYSCTL_NO_USER_ACCESS	0
 #define SYSCTL_USER_ACCESS	1
-- 
2.25.1

