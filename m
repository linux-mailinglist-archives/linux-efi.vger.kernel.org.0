Return-Path: <linux-efi+bounces-2782-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AC2A2F5DB
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 18:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C7B165C01
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 17:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A2C25742A;
	Mon, 10 Feb 2025 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/xKN1OM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907A02566C1
	for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209816; cv=none; b=TcNgSwWUzVOnk43fcGw9D6X2wUb436zDiA4Dn+VkoioefhtQgpt2YV7clv1HqJtHpEXAhIwG3KSYcL1sq2dJw+GWd6/SFW625Nu7/tAxj4zQvdwH2jZriXoX9zLcesoPh5nFhgF4v14jstBsClgJ0XMatCXSdyZHYNmW1zyZWHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209816; c=relaxed/simple;
	bh=7iSijZUrTtrRR03PZDgH1zpU7xqM0ZMrFF0nsmlrrpE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RzTjcbbKZ887f1QaQmMcTllPvda9lQt952EzqfPJGBdcVjGp9n2Z9FKOzlMfBMtq+ciEacvvYCKSmrpzW7Pb1Vi1xP41YPexp9UI8QwITo8Jsx3qj7/+PYntZnfGFsi84Xq41ClUxYQJTQw4Lv0MiDofY0lwVueqiHcmyHzhd7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/xKN1OM; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38dc32f753dso1675166f8f.3
        for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 09:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739209813; x=1739814613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=laE9eRboDAND4J5qc5k+GSW4SOFEdoYWGFcZSQBsh/M=;
        b=d/xKN1OMa/CLaF4e5TqSkfiemECz9A55e4VvxGsoHy3e8IAUzqN9nw6PrhUgiLSR+P
         TU1+fYB0/ZXDd4Cp0y7IR+stshN98g28yGM3OZ6Wln8WqNd8GXBHGjGOKXGwryCYW2gz
         qYJFda8FQ/Tcg7ZLpgWUEC/XBvkLXibjP2Dc2Y4+9xFe29v7HMCLcku6GbzeR+mbuyJH
         nvO6eVkwy3aJe5Y7crW235fGDH9I+Zb57IIRGDXcuezLJLlP5kP4YwV7iJet/q1PAOre
         ZdPfXv+sId2HGSS5ODicvsqKrYNSg7rAXy5FgNGFFYmykPtupXyZHpV7ChOegrxJhXjX
         Pc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209813; x=1739814613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laE9eRboDAND4J5qc5k+GSW4SOFEdoYWGFcZSQBsh/M=;
        b=V6Syo5ciqPHUtK/ZxB5FfxDJTlooM0LL4dgtS5+6tatfs+Ym/sLvLYk+gcQLozSXC9
         +1K4xcwfyM8U7rJJqv4RU1qlv4bVFm/rA+3MC7yMNXkOI9W34U5XHs5iyyhtDzJi9hfr
         U51Lf0OOGq6dMsT2yDPnMPOeC20uCXhlrWmcbGLaTxwfaVCFNz+LdcYt5umoQU9044+y
         z5RpqbwFlSETd6MHk6HBSRGVDzj0I5X7uHK44NzfmpkdO6kTC31TUoP0nl2y6HlYWRIm
         Zoh5QKp9SkNX4zAuHjLK0w2aUd/fqzpw7So8PLVLwzvMbkWUKxcRVdFPKzTr64ILQHgN
         0qqA==
X-Gm-Message-State: AOJu0YylqMBF0vonX3ZOtAebWGXUZ24jg08U/i8WhtVygMJTUgZp1l1A
	5M9uJvVb0yKW4qv1B5KqMI8oRqxMOv5KhB2mHZZHnqMPp4dYSuiA4l65n5QczJatbej6363e6uF
	xI7fhdwy3jU5kO/qgk+55yQCwNfHjfYpeaGMy76GJklmHQRC7ybql4LIGF/RY5a7ncoXL4ksL3o
	LTT5Sj0TaW4fiRUCDthCA/vbmP8Q==
X-Google-Smtp-Source: AGHT+IHEVhlSJynqCf5ga+kvT437lPhHVY+w3I8rLxdLC3rp6YXrxz1vR/G4EGZ9cSCMXYWv9sIfrVZ5
X-Received: from wmbeo3.prod.google.com ([2002:a05:600c:82c3:b0:435:f81b:bac8])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:6d8b:0:b0:38d:e016:a67b
 with SMTP id ffacd0b85a97d-38de41be85fmr539245f8f.39.1739209812969; Mon, 10
 Feb 2025 09:50:12 -0800 (PST)
Date: Mon, 10 Feb 2025 18:49:48 +0100
In-Reply-To: <20250210174941.3251435-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210174941.3251435-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3293; i=ardb@kernel.org;
 h=from:subject; bh=q2h484d7VXWpPU8ScxpoIvyL7JuzBh691XDsMq6nSoU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX2VjbWjpu3mLk6py7ZKYiemGF4uSzl3a9HHtx8fPbpy+
 JIos8unjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRX8sY/scIrtlqn6F1/tie
 o7I27Krm//8/Tk3LMGv0qZ0nuch72T1GhslvU8y+rpW571C25Nu+h8+E1V5Zm6er3JoUc/DkUqX SsywA
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210174941.3251435-15-ardb+git@google.com>
Subject: [PATCH v2 6/7] x86/efi/mixed: Simplify and document thunking logic
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hdegoede@redhat.com, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that the GDT/IDT and data segment selector preserve/restore logic
has been removed from the boot-time EFI mixed mode thunking routines,
the remaining logic to handle the function arguments can be simplified:
the setup of the arguments on the stack can be moved into the 32-bit
callee, which is able to use a more idiomatic sequence of PUSH
instructions.

This, in turn, allows the far call and far return to be issued using
plain LCALL and LRET instructions, removing the need to set up the
return explicitly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 77 ++++++++++----------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 984956931ed7..e04ed99bc449 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -22,43 +22,7 @@
 #include <asm/processor-flags.h>
 #include <asm/segment.h>
 
-	.code64
 	.text
-SYM_FUNC_START(__efi64_thunk)
-	push	%rbp
-	push	%rbx
-
-	/* Copy args passed on stack */
-	movq	0x18(%rsp), %rbp
-	movq	0x20(%rsp), %rbx
-	movq	0x28(%rsp), %rax
-
-	/*
-	 * Convert x86-64 ABI params to i386 ABI
-	 */
-	subq	$64, %rsp
-	movl	%esi, 0x0(%rsp)
-	movl	%edx, 0x4(%rsp)
-	movl	%ecx, 0x8(%rsp)
-	movl	%r8d, 0xc(%rsp)
-	movl	%r9d, 0x10(%rsp)
-	movl	%ebp, 0x14(%rsp)
-	movl	%ebx, 0x18(%rsp)
-	movl	%eax, 0x1c(%rsp)
-
-	leaq	1f(%rip), %rbp
-	movl	%cs, %ebx
-
-	ljmpl	*efi32_call(%rip)
-
-1:	addq	$64, %rsp
-	movq	%rdi, %rax
-
-	pop	%rbx
-	pop	%rbp
-	RET
-SYM_FUNC_END(__efi64_thunk)
-
 	.code32
 #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 SYM_FUNC_START(efi32_stub_entry)
@@ -81,11 +45,26 @@ SYM_FUNC_END(efi32_stub_entry)
 #endif
 
 /*
- * EFI service pointer must be in %edi.
+ * Called using a far call from __efi64_thunk() below, using the x86_64 SysV
+ * ABI (except for R8/R9 which are inaccessible to 32-bit code - EAX/EBX are
+ * used instead).  EBP+16 points to the arguments passed via the stack.
  *
- * The stack should represent the 32-bit calling convention.
+ * The first argument (EDI) is a pointer to the boot service or protocol, to
+ * which the remaining arguments are passed, each truncated to 32 bits.
  */
 SYM_FUNC_START_LOCAL(efi_enter32)
+	/*
+	 * Convert x86-64 SysV ABI params to i386 ABI
+	 */
+	pushl	32(%ebp)	/* Up to 3 args passed via the stack */
+	pushl	24(%ebp)
+	pushl	16(%ebp)
+	pushl	%ebx		/* R9 */
+	pushl	%eax		/* R8 */
+	pushl	%ecx
+	pushl	%edx
+	pushl	%esi
+
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -104,11 +83,29 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 
 	call	efi32_enable_long_mode
 
-	pushl	%ebx
-	pushl	%ebp
+	addl	$32, %esp
+	movl	%edi, %eax
 	lret
 SYM_FUNC_END(efi_enter32)
 
+	.code64
+SYM_FUNC_START(__efi64_thunk)
+	push	%rbp
+	movl	%esp, %ebp
+	push	%rbx
+
+	/* Move args #5 and #6 into 32-bit accessible registers */
+	movl	%r8d, %eax
+	movl	%r9d, %ebx
+
+	lcalll	*efi32_call(%rip)
+
+	pop	%rbx
+	pop	%rbp
+	RET
+SYM_FUNC_END(__efi64_thunk)
+
+	.code32
 SYM_FUNC_START_LOCAL(efi32_enable_long_mode)
 	movl	%cr4, %eax
 	btsl	$(X86_CR4_PAE_BIT), %eax
-- 
2.48.1.362.g079036d154-goog


