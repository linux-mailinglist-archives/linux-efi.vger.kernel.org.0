Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611727A746C
	for <lists+linux-efi@lfdr.de>; Wed, 20 Sep 2023 09:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjITHkD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Sep 2023 03:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjITHj6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Sep 2023 03:39:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098469E;
        Wed, 20 Sep 2023 00:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695195592; x=1726731592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D6J5R/1H9NYmwj1HBb/6nCFtRveDV5ws9Ss+Z61Hsv4=;
  b=fhp0BFxid/4XCiwEPDP+PyK6jr6iUmAtZlYzy6B4LlnX7IakwrbWLJXs
   Kpam+GJdGGy91RwkQbYf8P8IarAwFIgiX65ZaEPmUw1KcNTnEqRTIDNAv
   N/nS/7HW8rUW+Rqj8D6AraxDoo4/RCfSS3Ve8LN7hbqnTHGVhopNmGvrc
   Ce4ZC1xUoQkyUCEpecEWN9AUIDYSaGwBy3qKSna3ElhR5g3dyS1UUH7H+
   5uirz3w7PKHf/xhPUI8Ws+2YGEJOEI71y1ZVV82ou0Af4FKK7Y1D3np+u
   zKjos8kIcecBF0AsdwVj2+QuHhHQKCIpkDw4qvk+smjzjmcEA3qTC4suI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="446622643"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="446622643"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 00:39:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="816791848"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="816791848"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmsmga004.fm.intel.com with ESMTP; 20 Sep 2023 00:39:48 -0700
From:   Xiao Wang <xiao.w.wang@intel.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org
Cc:     anup@brainfault.org, haicheng.li@intel.com,
        ajones@ventanamicro.com, linux-riscv@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH v2 2/2] riscv: Optimize bitops with Zbb extension
Date:   Wed, 20 Sep 2023 15:46:53 +0800
Message-Id: <20230920074653.2509631-3-xiao.w.wang@intel.com>
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

This patch leverages the alternative mechanism to dynamically optimize
bitops (including __ffs, __fls, ffs, fls) with Zbb instructions. When
Zbb ext is not supported by the runtime CPU, legacy implementation is
used. If Zbb is supported, then the optimized variants will be selected
via alternative patching.

The legacy bitops support is taken from the generic C implementation as
fallback.

If the parameter is a build-time constant, we leverage compiler builtin to
calculate the result directly, this approach is inspired by x86 bitops
implementation.

EFI stub runs before the kernel, so alternative mechanism should not be
used there, this patch introduces a macro NO_ALTERNATIVE for this purpose.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/include/asm/bitops.h       | 266 +++++++++++++++++++++++++-
 drivers/firmware/efi/libstub/Makefile |   2 +-
 2 files changed, 264 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index 3540b690944b..c97e774cb647 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -15,13 +15,273 @@
 #include <asm/barrier.h>
 #include <asm/bitsperlong.h>
 
+#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
 #include <asm-generic/bitops/__ffs.h>
-#include <asm-generic/bitops/ffz.h>
-#include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/__fls.h>
+#include <asm-generic/bitops/ffs.h>
+#include <asm-generic/bitops/fls.h>
+
+#else
+#include <asm/alternative-macros.h>
+#include <asm/hwcap.h>
+
+#if (BITS_PER_LONG == 64)
+#define CTZW	"ctzw "
+#define CLZW	"clzw "
+#elif (BITS_PER_LONG == 32)
+#define CTZW	"ctz "
+#define CLZW	"clz "
+#else
+#error "Unexpected BITS_PER_LONG"
+#endif
+
+static __always_inline unsigned long variable__ffs(unsigned long word)
+{
+	int num;
+
+	asm_volatile_goto(
+		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
+		: : : : legacy);
+
+	asm volatile (
+		".option push\n"
+		".option arch,+zbb\n"
+		"ctz %0, %1\n"
+		".option pop\n"
+		: "=r" (word) : "r" (word) :);
+
+	return word;
+
+legacy:
+	num = 0;
+#if BITS_PER_LONG == 64
+	if ((word & 0xffffffff) == 0) {
+		num += 32;
+		word >>= 32;
+	}
+#endif
+	if ((word & 0xffff) == 0) {
+		num += 16;
+		word >>= 16;
+	}
+	if ((word & 0xff) == 0) {
+		num += 8;
+		word >>= 8;
+	}
+	if ((word & 0xf) == 0) {
+		num += 4;
+		word >>= 4;
+	}
+	if ((word & 0x3) == 0) {
+		num += 2;
+		word >>= 2;
+	}
+	if ((word & 0x1) == 0)
+		num += 1;
+	return num;
+}
+
+/**
+ * __ffs - find first set bit in a long word
+ * @word: The word to search
+ *
+ * Undefined if no set bit exists, so code should check against 0 first.
+ */
+#define __ffs(word)				\
+	(__builtin_constant_p(word) ?		\
+	 (unsigned long)__builtin_ctzl(word) :	\
+	 variable__ffs(word))
+
+static __always_inline unsigned long variable__fls(unsigned long word)
+{
+	int num;
+
+	asm_volatile_goto(
+		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
+		: : : : legacy);
+
+	asm volatile (
+		".option push\n"
+		".option arch,+zbb\n"
+		"clz %0, %1\n"
+		".option pop\n"
+		: "=r" (word) : "r" (word) :);
+
+	return BITS_PER_LONG - 1 - word;
+
+legacy:
+	num = BITS_PER_LONG - 1;
+#if BITS_PER_LONG == 64
+	if (!(word & (~0ul << 32))) {
+		num -= 32;
+		word <<= 32;
+	}
+#endif
+	if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
+		num -= 16;
+		word <<= 16;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
+		num -= 8;
+		word <<= 8;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
+		num -= 4;
+		word <<= 4;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
+		num -= 2;
+		word <<= 2;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-1))))
+		num -= 1;
+	return num;
+}
+
+/**
+ * __fls - find last set bit in a long word
+ * @word: the word to search
+ *
+ * Undefined if no set bit exists, so code should check against 0 first.
+ */
+#define __fls(word)							\
+	(__builtin_constant_p(word) ?					\
+	 (unsigned long)(BITS_PER_LONG - 1 - __builtin_clzl(word)) :	\
+	 variable__fls(word))
+
+static __always_inline int variable_ffs(int x)
+{
+	int r;
+
+	asm_volatile_goto(
+		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
+		: : : : legacy);
+
+	asm volatile (
+		".option push\n"
+		".option arch,+zbb\n"
+		"bnez %1, 1f\n"
+		"li %0, 0\n"
+		"j 2f\n"
+		"1:\n"
+		CTZW "%0, %1\n"
+		"addi %0, %0, 1\n"
+		"2:\n"
+		".option pop\n"
+		: "=r" (r) : "r" (x) :);
+
+	return r;
+
+legacy:
+	r = 1;
+	if (!x)
+		return 0;
+	if (!(x & 0xffff)) {
+		x >>= 16;
+		r += 16;
+	}
+	if (!(x & 0xff)) {
+		x >>= 8;
+		r += 8;
+	}
+	if (!(x & 0xf)) {
+		x >>= 4;
+		r += 4;
+	}
+	if (!(x & 3)) {
+		x >>= 2;
+		r += 2;
+	}
+	if (!(x & 1)) {
+		x >>= 1;
+		r += 1;
+	}
+	return r;
+}
+
+/**
+ * ffs - find first set bit in a word
+ * @x: the word to search
+ *
+ * This is defined the same way as the libc and compiler builtin ffs routines.
+ *
+ * ffs(value) returns 0 if value is 0 or the position of the first set bit if
+ * value is nonzero. The first (least significant) bit is at position 1.
+ */
+#define ffs(x) (__builtin_constant_p(x) ? __builtin_ffs(x) : variable_ffs(x))
+
+static __always_inline int variable_fls(unsigned int x)
+{
+	int r;
+
+	asm_volatile_goto(
+		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
+		: : : : legacy);
+
+	asm volatile (
+		".option push\n"
+		".option arch,+zbb\n"
+		"bnez %1, 1f\n"
+		"li %0, 0\n"
+		"j 2f\n"
+		"1:\n"
+		CLZW "%0, %1\n"
+		"neg %0, %0\n"
+		"addi %0, %0, 32\n"
+		"2:\n"
+		".option pop\n"
+		: "=r" (r) : "r" (x) :);
+
+	return r;
+
+legacy:
+	r = 32;
+	if (!x)
+		return 0;
+	if (!(x & 0xffff0000u)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xff000000u)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xf0000000u)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xc0000000u)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000u)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+
+/**
+ * fls - find last set bit in a word
+ * @x: the word to search
+ *
+ * This is defined in a similar way as ffs, but returns the position of the most
+ * significant set bit.
+ *
+ * fls(value) returns 0 if value is 0 or the position of the last set bit if
+ * value is nonzero. The last (most significant) bit is at position 32.
+ */
+#define fls(x)								\
+	(__builtin_constant_p(x) ?					\
+	 (int)(((x) != 0) ?						\
+	  (sizeof(unsigned int) * 8 - __builtin_clz(x)) : 0) :		\
+	 variable_fls(x))
+
+#endif
+
+#include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
-#include <asm-generic/bitops/ffs.h>
 
 #include <asm-generic/bitops/hweight.h>
 
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index a1157c2a7170..d68cacd4e3af 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
 				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
 				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
-cflags-$(CONFIG_RISCV)		+= -fpic
+cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE
 cflags-$(CONFIG_LOONGARCH)	+= -fpie
 
 cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
-- 
2.25.1

