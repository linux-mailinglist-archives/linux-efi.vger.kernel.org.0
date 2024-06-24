Return-Path: <linux-efi+bounces-1283-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7531D914088
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 04:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286761F21015
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 02:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB50F442C;
	Mon, 24 Jun 2024 02:33:26 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B154C7D;
	Mon, 24 Jun 2024 02:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719196406; cv=none; b=bfFJIAVvylAS6FHVmZeohGlj7CZtbEZOj2s9Z09zyuBRDYiopgN9KZGT+HnuVp0bLDniiDdMuLn2YlHb5nVooTLdDdbHDTt21Cci1UsQnURV1KJ+oLwi5LYPBTLtVIP7xcggcjpr1IpBXpCzEIfSEqsIcWT6k3v3uBI7QsRz9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719196406; c=relaxed/simple;
	bh=EQwv71rGAq0fb3+SxzCsfbvbc2/nvpSkCIwnv34zwmc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V7KMY64MMyKhhd/vJkj38GXshTG3hM9O2ZB4iidp29PiFMQJdgPePnY6O+qM8yAv6tmz8Cew7RWwx3xKl3bQTDnZibJenqkw8huqmBceXrtzSs/Ej8mcfkzyYR5EFZy/iy98k6Lps8wPsXEEiCFKSEObqZ/P8e1ZMc5YRe2oJNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W6sN63Qn3z1SDHM;
	Mon, 24 Jun 2024 10:28:54 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 790E0140E40;
	Mon, 24 Jun 2024 10:33:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 24 Jun
 2024 10:33:14 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <ardb@kernel.org>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <rmk+kernel@armlinux.org.uk>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>, <robh@kernel.org>,
	<kees@kernel.org>, <masahiroy@kernel.org>, <palmer@rivosinc.com>,
	<samitolvanen@google.com>, <xiao.w.wang@intel.com>, <alexghiti@rivosinc.com>,
	<nathan@kernel.org>, <jan.kiszka@siemens.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2] ARM: Add support for STACKLEAK gcc plugin
Date: Mon, 24 Jun 2024 10:36:12 +0800
Message-ID: <20240624023612.2134144-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Add the STACKLEAK gcc plugin to arm32 by adding the helper used by
stackleak common code: on_thread_stack(). It initialize the stack with the
poison value before returning from system calls which improves the kernel
security. Additionally, this disables the plugin in EFI stub code and
decompress code, which are out of scope for the protection.

Before the test on Qemu versatilepb board:
	# echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
	lkdtm: Performing direct entry STACKLEAK_ERASING
	lkdtm: XFAIL: stackleak is not supported on this arch (HAVE_ARCH_STACKLEAK=n)

After:
	# echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
	lkdtm: Performing direct entry STACKLEAK_ERASING
	lkdtm: stackleak stack usage:
	  high offset: 80 bytes
	  current:     280 bytes
	  lowest:      696 bytes
	  tracked:     696 bytes
	  untracked:   192 bytes
	  poisoned:    7220 bytes
	  low offset:  4 bytes
	lkdtm: OK: the rest of the thread stack is properly erased

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
v2:
- Make on_thread_stack() more legible.
- Add Acked-by.
---
 arch/arm/Kconfig                      | 1 +
 arch/arm/boot/compressed/Makefile     | 1 +
 arch/arm/include/asm/stacktrace.h     | 7 +++++++
 arch/arm/kernel/entry-common.S        | 3 +++
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 036381c5d42f..b211b7f5a138 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -86,6 +86,7 @@ config ARM
 	select HAVE_ARCH_PFN_VALID
 	select HAVE_ARCH_SECCOMP
 	select HAVE_ARCH_SECCOMP_FILTER if AEABI && !OABI_COMPAT
+	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARM_LPAE
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 6bca03c0c7f0..945b5975fce2 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -9,6 +9,7 @@ OBJS		=
 
 HEAD	= head.o
 OBJS	+= misc.o decompress.o
+CFLAGS_decompress.o += $(DISABLE_STACKLEAK_PLUGIN)
 ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
 OBJS	+= debug.o
 AFLAGS_head.o += -DDEBUG
diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 360f0d2406bf..f80a85b091d6 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -26,6 +26,13 @@ struct stackframe {
 #endif
 };
 
+static inline bool on_thread_stack(void)
+{
+	unsigned long delta = current_stack_pointer ^ (unsigned long)current->stack;
+
+	return delta < THREAD_SIZE;
+}
+
 static __always_inline
 void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
 {
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 5c31e9de7a60..f379c852dcb7 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -119,6 +119,9 @@ no_work_pending:
 
 	ct_user_enter save = 0
 
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	bl	stackleak_erase_on_task_stack
+#endif
 	restore_user_regs fast = 0, offset = 0
 ENDPROC(ret_to_user_from_irq)
 ENDPROC(ret_to_user)
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 06f0428a723c..20d8a491f25f 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -27,7 +27,8 @@ cflags-$(CONFIG_ARM64)		+= -fpie $(DISABLE_STACKLEAK_PLUGIN) \
 cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
 				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
 				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
-				   $(call cc-option,-mno-single-pic-base)
+				   $(call cc-option,-mno-single-pic-base) \
+				   $(DISABLE_STACKLEAK_PLUGIN)
 cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax
 cflags-$(CONFIG_LOONGARCH)	+= -fpie
 
-- 
2.34.1


