Return-Path: <linux-efi+bounces-1282-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6C6913F55
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 02:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE251B21728
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 00:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1EC2F22;
	Mon, 24 Jun 2024 00:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSPiRWKf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14DD2907;
	Mon, 24 Jun 2024 00:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719187639; cv=none; b=ixr8NG1Xgo/HdvE0rZuxwm+TII6bPizzpaKfUB1k6emLSN69FpdmhSTViJRIl4l6nW73IJ4uWu9drCZ5ZRnyQ3Ap0Kj7dnKxq2udzBDH9UcV2t3FnN/XhBESTpwweVy5vOMjZbKxUVgb3futF1HHEnqdpl7f7gsSioXyRqrzCVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719187639; c=relaxed/simple;
	bh=M/D8vlWXoM1yHQ0w1T9PpEu39JoCCs6wgGXVYV5gxxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNAYYXnCxO6YNQjbMHiq2s61foDOkxGadlkpmXdr3At5Zr8dycPw6pjRDXpNEqC+pmdRyj75gWXRZ2zBSZHLVbdu5eVO2FzhcX5UiOfZF8j5haNpbf6YnOkp3QK9oAB2vxD2qwtXxwQoycujA2mkgHxb1GphEl9XYmWIchT1+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSPiRWKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC35FC2BD10;
	Mon, 24 Jun 2024 00:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719187639;
	bh=M/D8vlWXoM1yHQ0w1T9PpEu39JoCCs6wgGXVYV5gxxU=;
	h=From:To:Cc:Subject:Date:From;
	b=NSPiRWKfmTUtXs4C//mdABIyTHMbRalsw432APe5BvfvvroLA5UWpqDzkKv3Zy054
	 htlq/TfMZtkCbC7EdG7ejn7GycpxNxsXc9ayYCUi1FT1D2gGgzNy7tF/ME9hVNl1XC
	 bgkwdsaXs8b9OUAjMzWFlelCsd7KVABfwV1fUiAA80aSJDzGVUlyxbQtzuSFMDnmpE
	 Scdhc3LwCT9egp25g3xV79dY/0OK5VRrepy3VumGe1POUDE7CMg5bQtNOBkEHEx8VI
	 ePSmWrKdfahfSiMchNn9HgKbLnQqWGBiFkbrAVoHYzXEvN6039+ttfH6uD7S2OsSOh
	 r0IYfJfZ5C/cQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ard Biesheuvel <ardb@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v2] riscv: enable HAVE_ARCH_STACKLEAK
Date: Mon, 24 Jun 2024 07:53:16 +0800
Message-ID: <20240623235316.2010-1-jszhang@kernel.org>
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

since v2:
 - add #include <linux/sizes.h> to fixing compiler error found by
   Charlie

 arch/riscv/Kconfig                    | 1 +
 arch/riscv/include/asm/thread_info.h  | 1 +
 arch/riscv/kernel/entry.S             | 4 ++++
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 4 files changed, 8 insertions(+), 1 deletion(-)

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
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 5d473343634b..fca5c6be2b81 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -10,6 +10,7 @@
 
 #include <asm/page.h>
 #include <linux/const.h>
+#include <linux/sizes.h>
 
 /* thread information allocation */
 #define THREAD_SIZE_ORDER	CONFIG_THREAD_SIZE_ORDER
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


