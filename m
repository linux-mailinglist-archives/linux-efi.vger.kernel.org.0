Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92CF2A30DE
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 18:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgKBRG5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 12:06:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgKBRG4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Nov 2020 12:06:56 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FAF322268;
        Mon,  2 Nov 2020 17:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604336816;
        bh=Spv9lqkWtsd14GfjWpKqEBy9I+RmnERVVxS66vXEJ3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdfbK7RAYw7cyeDF/c4Gpmq8WHtQ2B3URq5tcdevNg0XAzoDgg+AdtLnJbcxoZMRj
         8ixjXbM7iF8cVhEo7s/UY2n/5mrExGBPPWu/JlylXR8AnN7VdfncaDnzR9/MTm0Lbw
         agAiOvGl0EOgN1MezJ9UFsF/53Pw0o2YEILM1H0g=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [RFC PATCH 3/7] efi/libstub: x86/mixed: increase supported argument count
Date:   Mon,  2 Nov 2020 18:06:30 +0100
Message-Id: <20201102170634.20575-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102170634.20575-1-ardb@kernel.org>
References: <20201102170634.20575-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Increase the number of arguments supported by mixed mode calls, so that
we will be able to call into the TCG2 protocol to measure the initrd
and extend the associated PCR. This involves the the TCG2 protocol's
hash_log_extend_event() method, which takes five arguments, three of
which are u64 and need to be split, producing a total of 8 outgoing
arguments.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_thunk_64.S | 17 ++++++++++++-----
 arch/x86/include/asm/efi.h              |  9 +++++----
 arch/x86/platform/efi/efi_thunk_64.S    | 17 +++++++++++++----
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index c4bb0f9363f5..e0f10c0aecfa 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -27,8 +27,6 @@ SYM_FUNC_START(__efi64_thunk)
 	push	%rbp
 	push	%rbx
 
-	leaq	1f(%rip), %rbp
-
 	movl	%ds, %eax
 	push	%rax
 	movl	%es, %eax
@@ -36,19 +34,28 @@ SYM_FUNC_START(__efi64_thunk)
 	movl	%ss, %eax
 	push	%rax
 
+	movq	0x30(%rsp), %rbp
+	movq	0x38(%rsp), %rbx
+	movq	0x40(%rsp), %rax
+
 	/*
 	 * Convert x86-64 ABI params to i386 ABI
 	 */
-	subq	$32, %rsp
+	subq	$48, %rsp
 	movl	%esi, 0x0(%rsp)
 	movl	%edx, 0x4(%rsp)
 	movl	%ecx, 0x8(%rsp)
 	movl	%r8d, 0xc(%rsp)
 	movl	%r9d, 0x10(%rsp)
+	movl	%ebp, 0x14(%rsp)
+	movl	%ebx, 0x18(%rsp)
+	movl	%eax, 0x1c(%rsp)
 
-	leaq	0x14(%rsp), %rbx
+	leaq	0x20(%rsp), %rbx
 	sgdt	(%rbx)
 
+	leaq	1f(%rip), %rbp
+
 	/*
 	 * Switch to gdt with 32-bit segments. This is the firmware GDT
 	 * that was installed when the kernel started executing. This
@@ -67,7 +74,7 @@ SYM_FUNC_START(__efi64_thunk)
 	pushq	%rax
 	lretq
 
-1:	addq	$32, %rsp
+1:	addq	$48, %rsp
 	movq	%rdi, %rax
 
 	pop	%rbx
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index bc9758ef292e..b921b593e0a3 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -45,13 +45,14 @@ extern unsigned long efi_fw_vendor, efi_config_table;
 
 #define __efi_nargs(...) __efi_nargs_(__VA_ARGS__)
 #define __efi_nargs_(...) __efi_nargs__(0, ##__VA_ARGS__,	\
+	__efi_arg_sentinel(9), __efi_arg_sentinel(8),		\
 	__efi_arg_sentinel(7), __efi_arg_sentinel(6),		\
 	__efi_arg_sentinel(5), __efi_arg_sentinel(4),		\
 	__efi_arg_sentinel(3), __efi_arg_sentinel(2),		\
 	__efi_arg_sentinel(1), __efi_arg_sentinel(0))
-#define __efi_nargs__(_0, _1, _2, _3, _4, _5, _6, _7, n, ...)	\
+#define __efi_nargs__(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, n, ...)	\
 	__take_second_arg(n,					\
-		({ BUILD_BUG_ON_MSG(1, "__efi_nargs limit exceeded"); 8; }))
+		({ BUILD_BUG_ON_MSG(1, "__efi_nargs limit exceeded"); 10; }))
 #define __efi_arg_sentinel(n) , n
 
 /*
@@ -168,8 +169,8 @@ extern u64 efi_setup;
 extern efi_status_t __efi64_thunk(u32, ...);
 
 #define efi64_thunk(...) ({						\
-	__efi_nargs_check(efi64_thunk, 6, __VA_ARGS__);			\
-	__efi64_thunk(__VA_ARGS__);					\
+	__efi_nargs_check(efi64_thunk, 9, __VA_ARGS__);			\
+	__efi64_thunk(__VA_ARGS__, 0ULL, 0ULL, 0ULL);			\
 })
 
 static inline bool efi_is_mixed(void)
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index 26f0da238c1c..2f2a625b84a4 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -33,8 +33,18 @@ SYM_CODE_START(__efi64_thunk)
 	 * Switch to 1:1 mapped 32-bit stack pointer.
 	 */
 	movq	%rsp, %rax
-	movq	efi_scratch(%rip), %rsp
-	push	%rax
+	movq	(efi_scratch - 0x2c)(%rip), %rsp
+	movq	%rax, 0x24(%rsp)
+
+	/*
+	 * Copy args passed via the stack
+	 */
+	movq	0x18(%rax), %rbp
+	movq	0x20(%rax), %rbx
+	movq	0x28(%rax), %rax
+	movl	%ebp, 0x18(%rsp)
+	movl	%ebx, 0x1c(%rsp)
+	movl	%eax, 0x20(%rsp)
 
 	/*
 	 * Calculate the physical address of the kernel text.
@@ -47,7 +57,6 @@ SYM_CODE_START(__efi64_thunk)
 	subq	%rax, %rbp
 	subq	%rax, %rbx
 
-	subq	$28, %rsp
 	movl	%ebx, 0x0(%rsp)		/* return address */
 	movl	%esi, 0x4(%rsp)
 	movl	%edx, 0x8(%rsp)
@@ -60,7 +69,7 @@ SYM_CODE_START(__efi64_thunk)
 	pushq	%rdi			/* EFI runtime service address */
 	lretq
 
-1:	movq	24(%rsp), %rsp
+1:	movq	0x20(%rsp), %rsp
 	pop	%rbx
 	pop	%rbp
 	retq
-- 
2.17.1

