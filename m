Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DFE37767C
	for <lists+linux-efi@lfdr.de>; Sun,  9 May 2021 13:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhEILqN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 9 May 2021 07:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhEILqM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 9 May 2021 07:46:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E36C061573
        for <linux-efi@vger.kernel.org>; Sun,  9 May 2021 04:45:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a4so13703348wrr.2
        for <linux-efi@vger.kernel.org>; Sun, 09 May 2021 04:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hoiAIq/z3yHkNOvXZ9mqTktxHY6cU6zfc8Z8n8hwB2c=;
        b=fMYvUXUjg3oolfqTBDiYR0OIQuC7lcfDKZxNktcrYHxb8imwa8oKgsArc3NvQt2k4j
         aAZRUQ1RglF0N4zmqgNPhI+oyDjwYyl//yro/Z8Vj6iUw5GKiP8pi5x0pyxqSQ0abtL2
         R6Zdn9M9r33CUcezWhqbxINs5HHDf9PcZ3Rto0r6/Vi278lGAZwF02kTN1MugD9EC2i2
         bWYalzp1Yj1rtfM4ndQ2jZ5H0SmJBRq5vGLg5BkF7192/gaCxnx+GsxEZtSUeu7K0x2D
         3ux1gOM8DVIKfAjffP8wY46xke05fOuIJ4IbqcHKUB9+yEwoQB9bHlOIl05tz7qJRhRH
         Ej0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hoiAIq/z3yHkNOvXZ9mqTktxHY6cU6zfc8Z8n8hwB2c=;
        b=eZwyZB86IEMMOi04qbY0XVIjefU40APvGPtE9U5kU9Z7at4mhZgJSxXEjMJPelbWC7
         1zWYCSg0FIbu5QKCIGew5xzmC8bU/4IJHHWW7xAcflqFcNsTfIfd2YjwinWBMkg0jDId
         nI5oUlaXiLywRVmG6YkSMvOd7eErNC/CB372Y6p9HuXgbtNg21RjfdvJZSmrhvXJhhoS
         i27iZPodtUTwn1hUHKop/9lCIa9J6i0igC6+4kJ6MqyvZB8ncgNRtjmsQhvJlesxxlxE
         oJRRL1HK8iXq//vTAP5rN/xNLE9z3zvIWzXYzV5iQ581PhqxnJlShjGcOPBUiPoUKsrP
         /OTg==
X-Gm-Message-State: AOAM531G9QNShqpcjfz7PhxGNn+Tdi7PIxg+9yxusPW49xn4SH7gQjOy
        5qkkSrNvg1uqyTwYivVUe4Q5bn+KtVN3tw==
X-Google-Smtp-Source: ABdhPJxF7tx9E/hR8sgMc8TFY509Bwjl9XwhtnIU049tnudzLXUVirVR6adC9mg+FF1GKRIMq5JEJw==
X-Received: by 2002:adf:f251:: with SMTP id b17mr24522214wrp.410.1620560707728;
        Sun, 09 May 2021 04:45:07 -0700 (PDT)
Received: from apalos.home ([2a02:587:466e:1389:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id c8sm17650244wrx.4.2021.05.09.04.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 04:45:07 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, pjones@redhat.com, nivedita@alum.mit.edu,
        mjg59@google.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [RFC PATCH 2/4] efi/libstub: x86/mixed: increase supported argument count
Date:   Sun,  9 May 2021 14:44:52 +0300
Message-Id: <20210509114454.185583-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210509114454.185583-1-ilias.apalodimas@linaro.org>
References: <20210509114454.185583-1-ilias.apalodimas@linaro.org>
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

