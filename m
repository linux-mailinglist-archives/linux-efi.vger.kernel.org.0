Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CB4456E72
	for <lists+linux-efi@lfdr.de>; Fri, 19 Nov 2021 12:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhKSLvJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Nov 2021 06:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhKSLvI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Nov 2021 06:51:08 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35412C061574
        for <linux-efi@vger.kernel.org>; Fri, 19 Nov 2021 03:48:07 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id z1-20020a05600c220100b00337f97d2464so7556090wml.1
        for <linux-efi@vger.kernel.org>; Fri, 19 Nov 2021 03:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jzbLIXzxwn+BG1Jh+SPLy6v+awyEDiVu+TM/OwiCocQ=;
        b=mKUnIHVzxUVp4UyiIQp1qyf3qxycL8MU5enasac5ZEwd4qQz0fDgQEd/nyYOlbyoiJ
         qnkjl0wh/3WptNBi7M2fEq8thHktUOHKDSB/loQeaDuaZLJwHlTreg2Vgj89SD7LiuIn
         M23MRZzDXE1pmujjCFvmImBiUfsHDAcssgJpC44KF3julFAVAwgxL+cG5kbog0t9jp+G
         Wajwj/9C1Leuv1QPnVMAsBKSsCCXYTxIzq7hcjxKYnutPjcE4ION6EydatNBoVSvxAl9
         1vI1QECH0pvY7NdqPgbML1J8pWTZDz9eEynQ6WfpB6dKHAH5v+X/LOp0qXM5ZNX7rXh1
         Tv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzbLIXzxwn+BG1Jh+SPLy6v+awyEDiVu+TM/OwiCocQ=;
        b=xEUmYO2LZ15cEfqlCNi5pT1+9dR6OuyVxNCwwfTrNhSsrB9S/yJo8KYhYa7xkRAb6K
         xBbs9mgnRif9uZbpdg770B+nyTUSo7P0LadpZTfZ2KTfnUiDdJsV5/S2PwyO+PUlPJT6
         +s473J/Y/VeJ0CpZKLH9ZoaUk0UF9wV8BgeXQa30yrezgHq0royC7FcVg8V04KBAwO0S
         VsVfe7KFayab94pbXyRWzibba3Qmzhf5EjD6w7iM7GMmmczBgxWLsn8HgKetbW/AEqE8
         gBRgOeIMlncEITgWhvYa0VbvZPwVFnz63yOw6di3qRgh0DDmUZ+zahXyrtkt4D/P3cQz
         p9SQ==
X-Gm-Message-State: AOAM532kzoXzPLQGu5fRrqjSH/n9il6PfJa9oQkttaXh25isI7yVQO4z
        YRva6Tt5y3LMvCt8yqdzcnFsLV4imOQ4aQ==
X-Google-Smtp-Source: ABdhPJyb71IUvhUFpBMQ3BNGf/djJgCWtSf2iNcPwWBS7yIoXp1CV9QSb/OUYhAtuFGVGoKCRarrNA==
X-Received: by 2002:a05:600c:282:: with SMTP id 2mr6095354wmk.91.1637322485675;
        Fri, 19 Nov 2021 03:48:05 -0800 (PST)
Received: from apalos.home ([2a02:587:4627:18c0:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id c4sm2688039wrr.37.2021.11.19.03.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:48:05 -0800 (PST)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, pjones@redhat.com, nivedita@alum.mit.edu,
        mjg59@google.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        jroedel@suse.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/4 v3] efi/libstub: x86/mixed: increase supported argument count
Date:   Fri, 19 Nov 2021 13:47:43 +0200
Message-Id: <20211119114745.1560453-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119114745.1560453-1-ilias.apalodimas@linaro.org>
References: <20211119114745.1560453-1-ilias.apalodimas@linaro.org>
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

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v1,2:
- Rebased on top of 22aa45cb465b
 arch/x86/boot/compressed/efi_thunk_64.S | 14 +++++++++++---
 arch/x86/include/asm/efi.h              | 10 ++++++----
 arch/x86/platform/efi/efi_thunk_64.S    | 14 ++++++++++++--
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index 8bb92e9f4e97..d05f781d54f2 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -26,8 +26,6 @@ SYM_FUNC_START(__efi64_thunk)
 	push	%rbp
 	push	%rbx
 
-	leaq	1f(%rip), %rbp
-
 	movl	%ds, %eax
 	push	%rax
 	movl	%es, %eax
@@ -35,6 +33,11 @@ SYM_FUNC_START(__efi64_thunk)
 	movl	%ss, %eax
 	push	%rax
 
+	/* Copy args passed on stack */
+	movq	0x30(%rsp), %rbp
+	movq	0x38(%rsp), %rbx
+	movq	0x40(%rsp), %rax
+
 	/*
 	 * Convert x86-64 ABI params to i386 ABI
 	 */
@@ -44,13 +47,18 @@ SYM_FUNC_START(__efi64_thunk)
 	movl	%ecx, 0x8(%rsp)
 	movl	%r8d, 0xc(%rsp)
 	movl	%r9d, 0x10(%rsp)
+	movl	%ebp, 0x14(%rsp)
+	movl	%ebx, 0x18(%rsp)
+	movl	%eax, 0x1c(%rsp)
 
-	leaq	0x14(%rsp), %rbx
+	leaq	0x20(%rsp), %rbx
 	sgdt	(%rbx)
 
 	addq	$16, %rbx
 	sidt	(%rbx)
 
+	leaq	1f(%rip), %rbp
+
 	/*
 	 * Switch to IDT and GDT with 32-bit segments. This is the firmware GDT
 	 * and IDT that was installed when the kernel started executing. The
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
2.33.1

