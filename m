Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228D63FEA5D
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 10:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243979AbhIBIGC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 04:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243834AbhIBIFh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Sep 2021 04:05:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F26FC061575
        for <linux-efi@vger.kernel.org>; Thu,  2 Sep 2021 01:04:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bt14so2358205ejb.3
        for <linux-efi@vger.kernel.org>; Thu, 02 Sep 2021 01:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2iiIateKTBWZjYnp/KWTI57EARQY66xop+0IjqBRQms=;
        b=hR+d5ry0uVSHfzVzl/epW0T7mbhbdzoFJYYGEK1aOvt2vRqE8tVGyF6Or0Vl1KfgIX
         mhdhHKriiHzK155761637Uc8dBDh5S6u/9qWHrKZ07d0eD6ByTKRpBxLUNaDgovzPUkS
         /l9jCVMNZjtoUPFNDFnwYJZgF0BCZzf8xFh/vufRE5SzSbiuPNZlQgBBoXC9R6JBuVeF
         6U7pE0WvB40+wQFJRyF0mqsIWwz0hjTwGaCxHa+x6nI7xNz8uetZleQ/onwVk/JPW/Wa
         ry/ATjkqZ8Vn33WXJepLIK0jkSKO0ZK9kXWjeyh1dlLv1bsdQgnKVCSR4ZKpYU5OK1Zb
         iQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2iiIateKTBWZjYnp/KWTI57EARQY66xop+0IjqBRQms=;
        b=XnAvcMuTNEW7+ms74QyXSH3b7fGWcYH0rKn055wpCnUXRsin42QMmkZEXnwfsuGC5L
         lBYP0Ji/atwRP/wbh6W9IiDOiP/FXzzhDAX31ffjM+V4LxVkq1+eJtQpXhi5Obd/Egm1
         DAIhKMHrJXPEP9Ffpkwdfk2JFkoOfhwB8VdJ2bpkKjCvFHeB8MCL0dV10AaNrqly2wiR
         cVYUlsI0eiJAKKx6GPXdjnJGgTINPepAB/nDAbJe6yYGDLTiKzSBkhLYgtHBMUDDpx5N
         ITsA+/ofWOIdDnGYO4g9drvvmefpPBzTM/Rsy5G1hr3CBVYEZ4nQxHcSI4sXebwJh+H0
         8K/Q==
X-Gm-Message-State: AOAM531NqrMQZYLNr0Sw7F1hwcp0T/oMqTg/q+zOIZXpdPrDE4BJ+CV7
        LTYalB/da+G+50Y9+BKqeFSjaKEmnvEcUA==
X-Google-Smtp-Source: ABdhPJx6534/nBTJcN1KJiFkLTjmFWzfX2CFSg93Iisk4BfLM54OOUAWm3zfBsuMjaRz9EJ0wyAH4A==
X-Received: by 2002:a17:906:2c07:: with SMTP id e7mr2509215ejh.87.1630569877956;
        Thu, 02 Sep 2021 01:04:37 -0700 (PDT)
Received: from localhost.localdomain (ppp-94-66-220-137.home.otenet.gr. [94.66.220.137])
        by smtp.gmail.com with ESMTPSA id m12sm537105ejd.21.2021.09.02.01.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 01:04:37 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org, ardb@kernel.org,
        James.Bottomley@hansenpartnership.com
Cc:     pjones@redhat.com, nivedita@alum.mit.edu, mjg59@google.com,
        daniel.kiper@oracle.com, leif@nuviainc.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/4 v2] efi/libstub: x86/mixed: increase supported argument count
Date:   Thu,  2 Sep 2021 11:04:14 +0300
Message-Id: <20210902080416.5461-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210902080416.5461-1-ilias.apalodimas@linaro.org>
References: <20210902080416.5461-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Increase the number of arguments supported by mixed mode calls, so that
we will be able to call into the TCG2 protocol to measure the initrd
and extend the associated PCR. This involves the TCG2 protocol's
hash_log_extend_event() method, which takes five arguments, three of
which are u64 and need to be split, producing a total of 8 outgoing
arguments.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/x86/boot/compressed/efi_thunk_64.S | 17 ++++++++++++-----
 arch/x86/include/asm/efi.h              | 10 ++++++----
 arch/x86/platform/efi/efi_thunk_64.S    | 14 ++++++++++++--
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index 95a223b3e56a..fec6c48d6b30 100644
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
index 85f156f8ef81..a323dbac9182 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -46,13 +46,14 @@ extern unsigned long efi_mixed_mode_stack_pa;
 
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
@@ -176,8 +177,9 @@ extern u64 efi_setup;
 extern efi_status_t __efi64_thunk(u32, ...);
 
 #define efi64_thunk(...) ({						\
-	__efi_nargs_check(efi64_thunk, 6, __VA_ARGS__);			\
-	__efi64_thunk(__VA_ARGS__);					\
+	u64 __pad[3]; /* must have space for 3 args on the stack */	\
+	__efi_nargs_check(efi64_thunk, 9, __VA_ARGS__);			\
+	__efi64_thunk(__VA_ARGS__, __pad);				\
 })
 
 static inline bool efi_is_mixed(void)
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index fd3dd1708eba..5b7c6e09954e 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -36,6 +36,17 @@ SYM_CODE_START(__efi64_thunk)
 	movq	efi_mixed_mode_stack_pa(%rip), %rsp
 	push	%rax
 
+	/*
+	 * Copy args passed via the stack
+	 */
+	subq	$0x24, %rsp
+	movq	0x18(%rax), %rbp
+	movq	0x20(%rax), %rbx
+	movq	0x28(%rax), %rax
+	movl	%ebp, 0x18(%rsp)
+	movl	%ebx, 0x1c(%rsp)
+	movl	%eax, 0x20(%rsp)
+
 	/*
 	 * Calculate the physical address of the kernel text.
 	 */
@@ -47,7 +58,6 @@ SYM_CODE_START(__efi64_thunk)
 	subq	%rax, %rbp
 	subq	%rax, %rbx
 
-	subq	$28, %rsp
 	movl	%ebx, 0x0(%rsp)		/* return address */
 	movl	%esi, 0x4(%rsp)
 	movl	%edx, 0x8(%rsp)
@@ -60,7 +70,7 @@ SYM_CODE_START(__efi64_thunk)
 	pushq	%rdi			/* EFI runtime service address */
 	lretq
 
-1:	movq	24(%rsp), %rsp
+1:	movq	0x20(%rsp), %rsp
 	pop	%rbx
 	pop	%rbp
 	retq
-- 
2.32.0.rc0

