Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A473A7A5B
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jun 2021 11:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhFOJXS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Jun 2021 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhFOJXR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Jun 2021 05:23:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82345C061574
        for <linux-efi@vger.kernel.org>; Tue, 15 Jun 2021 02:21:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v9so1210195wrx.6
        for <linux-efi@vger.kernel.org>; Tue, 15 Jun 2021 02:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hoiAIq/z3yHkNOvXZ9mqTktxHY6cU6zfc8Z8n8hwB2c=;
        b=dsuNsbmKoY2N6+AlN9aaiT+TWOGei21Q4xVOs+s+euqjC6pK0xXN2UNMrdovjUICay
         YZ/IrnjU5d5qhz0BnY6MufGXsEqcjhfBJnV2IcZB9rwLg56ikKkDA56RvNiTA45VxryG
         DyEaYBBlbq4UIXsjFG/xrM52wFiHstM/FgwmCevwIVyEwBripWuYUf5VYwh84epaWdkV
         bjcZfZ1Ab1IIDsN1Gv5gWAAqmnsZI28CUAf4pZiGIOWVhLIvy7eB6emGZ0y80/GFppeI
         gpyQf7rl0YWh7jpDurD80vRgbgfxO+xrnVUD3Fs53cxdfuPRsSHtSboUjfgghix5Mvsq
         wS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hoiAIq/z3yHkNOvXZ9mqTktxHY6cU6zfc8Z8n8hwB2c=;
        b=uP730bOY0OCbzjgBS2dkRKLgsY149uUXRvDa1+lcMLTQ4levqu4V5kUrl1ztNMZNY7
         qFqghsubj9H1RSJCoLRA+8QL010Lu7XLC6wenDGCatjG0DCRiB8hQu9RFf2F/FKInn3y
         elvFIShcf3OI1WF58Gj1s+J3VKIqnpfwgBjyMC04A/aBXUSED9j9IylmcdgwBD3XbCYT
         loK6tOA6m8ihXr9ODfs/Q+pJeEBScaIoLBrlAxh7sjwXsHzKsXY2Ke3G2h/o6PyQX8oO
         OsxPy9VXPkG3PoNTB52fvfGOR1JJu66v/zdcNnNbgFb/0KVno2QsoFqjwKGqy1wfCgaI
         f5ZQ==
X-Gm-Message-State: AOAM533y3pAxI5w9FyimAYCOexT8GC6q+g/ZHYlWqg+YW+giSmEEki5u
        4Vwx47fkmWNZMUzbBSf7knDgMMUPwaaByg==
X-Google-Smtp-Source: ABdhPJz5vOBth5ohjUdIX3ofVBDQl3CY/XtQIpxbavD/8atrzaT2uENJhJEIOEQCPImfRyvXTtpVjA==
X-Received: by 2002:adf:d1c9:: with SMTP id b9mr23986542wrd.101.1623748872145;
        Tue, 15 Jun 2021 02:21:12 -0700 (PDT)
Received: from apalos.home ([2a02:587:4680:7ec2:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id h15sm18280113wrq.88.2021.06.15.02.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 02:21:11 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, pjones@redhat.com, nivedita@alum.mit.edu,
        mjg59@google.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/4] efi/libstub: x86/mixed: increase supported argument count
Date:   Tue, 15 Jun 2021 12:21:03 +0300
Message-Id: <20210615092105.288331-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615092105.288331-1-ilias.apalodimas@linaro.org>
References: <20210615092105.288331-1-ilias.apalodimas@linaro.org>
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
2.31.0

