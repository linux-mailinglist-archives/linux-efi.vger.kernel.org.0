Return-Path: <linux-efi+bounces-1225-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D62D90AE23
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 14:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3149C1F225DE
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397FE196C98;
	Mon, 17 Jun 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nntBnYVE"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA79196C72;
	Mon, 17 Jun 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628264; cv=none; b=ZrjT+R2D/yn1r0lY+7fX50S9JY26r1oYumNpNz+5n8CAhvA580ssceUcQM/zryFlcreMvzAbysrxtvYaobhirxISHTmzL5zdgNSCKGA6o6/uUzyb69z7zO3ON/MCAXA+UEjoUXwHyAQ84xoZzjsfPq/247BrJZGs/uqMWJrICQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628264; c=relaxed/simple;
	bh=bk3jaCTgEwyFqgeARzSHMxmOvQdgz0Ppwlp60WKOmQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FD3e1PkYi/M4tGxxE9BKUy6hm++Zh1wFXzx8hz9G77SmjDZ7eRYdQCCTVKh56W9Ew3piviVLyv/1UseGnRTOklLv0T6Gi66Y6NBzB39GSzRaRfr6tGyhk8JW7IHVY04eLEs1KJQshHQmzeyU43K1fCGPrfrvU/ge/Mx34wTEdmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nntBnYVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F878C4AF1C;
	Mon, 17 Jun 2024 12:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718628263;
	bh=bk3jaCTgEwyFqgeARzSHMxmOvQdgz0Ppwlp60WKOmQw=;
	h=From:To:Cc:Subject:Date:From;
	b=nntBnYVEohFkLJK2lrDYhAJL6Dirglm7fViLEJx1cun+AEuKLjAubktVJcRIVtxox
	 FxovPk10y+7rfn8sOdCoAfU1Mfs771FeOzuAYF1x699ODbPSfY/F4lU0sKGnPK89x/
	 qtNgP8t1NYd2ZWHdB5KjOV6feKx6NVslrchwnFIv0sV/6p7FiJnYZwP0f5BUY0z/F5
	 TvpkzAOHgr+qKuOTmBKS+QzqUgvUpA0E4P4pO1vf4anw+1yliUZA04dQ6ao3PG5H7Z
	 LEbIcA9OrAn3iTpZo+HOYJ/ZoAPalXO0mPCL90aGfvvRf/nPpkTbfBHtY2Nt4XXHPL
	 BsZqgjaoqYmZg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH] riscv: enable HAVE_ARCH_STACKLEAK
Date: Mon, 17 Jun 2024 20:30:29 +0800
Message-ID: <20240617123029.723-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the stackleak feature. Whenever the kernel returns to user
space the kernel stack is filled with a poison value.

At the same time, disables the plugin in EFI stub code because EFI stub
is out of scope for the protection.

Tested on qemu and milkv duo:
/ # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
[   38.675575] lkdtm: Performing direct entry STACKLEAK_ERASING
[   38.678448] lkdtm: stackleak stack usage:
[   38.678448]   high offset: 288 bytes
[   38.678448]   current:     496 bytes
[   38.678448]   lowest:      1328 bytes
[   38.678448]   tracked:     1328 bytes
[   38.678448]   untracked:   448 bytes
[   38.678448]   poisoned:    14312 bytes
[   38.678448]   low offset:  8 bytes
[   38.689887] lkdtm: OK: the rest of the thread stack is properly erased

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig                    | 1 +
 arch/riscv/kernel/entry.S             | 4 ++++
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0525ee2d63c7..9cbfdffec96c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -118,6 +118,7 @@ config RISCV
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 68a24cf9481a..80ff55a26d13 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -130,6 +130,10 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 #endif
 	bnez s0, 1f
 
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	call	stackleak_erase_on_task_stack
+#endif
+
 	/* Save unwound kernel stack pointer in thread_info */
 	addi s0, sp, PT_SIZE_ON_STACK
 	REG_S s0, TASK_TI_KERNEL_SP(tp)
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 06f0428a723c..3a9521c57641 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -28,7 +28,8 @@ cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
 				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
 				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
-cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax
+cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax \
+				   $(DISABLE_STACKLEAK_PLUGIN)
 cflags-$(CONFIG_LOONGARCH)	+= -fpie
 
 cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
-- 
2.43.0


