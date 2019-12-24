Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A000112A2C6
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfLXPL0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:11:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbfLXPLZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:25 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACAA72075B;
        Tue, 24 Dec 2019 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200284;
        bh=bw1aR5xG5oBy6qwC2Fs7sfBU7lQlJ5VpQVJ8qulCHHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjFH2pNTvh4ZhTNeh0IZ45WH+J08IwGxLH7In3gqQHoqBE0ea9wAKPvpZMooTN90s
         sSK/++PtbqfmDF/sxl89empsSL6ADKeydERKnrl7jRrgHkRJeu+dFSs+QbrJThbSef
         usRytIquRrlHYFjZQlx9BaT6lSk8Kgl0sjXlhewk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 25/25] efi/libstub/x86: avoid globals to store context during mixed mode calls
Date:   Tue, 24 Dec 2019 16:10:25 +0100
Message-Id: <20191224151025.32482-26-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of storing the return address in a global variable when calling
a 32-bit EFI service from the 64-bit stub, avoid the indirection via
efi_exit32, and take the return address from the stack.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_thunk_64.S | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index 593913692d16..6d95eb6b8912 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -10,7 +10,7 @@
  * needs to be able to service interrupts.
  *
  * On the plus side, we don't have to worry about mangling 64-bit
- * addresses into 32-bits because we're executing with an identify
+ * addresses into 32-bits because we're executing with an identity
  * mapped pagetable and haven't transitioned to 64-bit virtual addresses
  * yet.
  */
@@ -28,7 +28,7 @@ SYM_FUNC_START(efi64_thunk)
 	push	%rbx
 
 	subq	$8, %rsp
-	leaq	efi_exit32(%rip), %rax
+	leaq	1f(%rip), %rax
 	movl	%eax, 4(%rsp)
 	leaq	efi_gdt64(%rip), %rax
 	movl	%eax, (%rsp)
@@ -55,9 +55,6 @@ SYM_FUNC_START(efi64_thunk)
 
 	sgdt	save_gdt(%rip)
 
-	leaq	1f(%rip), %rbx
-	movq	%rbx, func_rt_ptr(%rip)
-
 	/*
 	 * Switch to gdt with 32-bit segments. This is the firmware GDT
 	 * that was installed when the kernel started executing. This
@@ -72,6 +69,7 @@ SYM_FUNC_START(efi64_thunk)
 	lretq
 
 1:	addq	$32, %rsp
+	movq	%rdi, %rax
 
 	lgdt	save_gdt(%rip)
 
@@ -99,13 +97,6 @@ SYM_FUNC_START(efi64_thunk)
 	ret
 SYM_FUNC_END(efi64_thunk)
 
-SYM_FUNC_START_LOCAL(efi_exit32)
-	movq	func_rt_ptr(%rip), %rax
-	push	%rax
-	mov	%rdi, %rax
-	ret
-SYM_FUNC_END(efi_exit32)
-
 	.code32
 /*
  * EFI service pointer must be in %edi.
@@ -186,8 +177,6 @@ SYM_DATA_START_LOCAL(save_gdt)
 	.quad	0
 SYM_DATA_END(save_gdt)
 
-SYM_DATA_LOCAL(func_rt_ptr, .quad 0)
-
 SYM_DATA_START(efi_gdt64)
 	.word	efi_gdt64_end - efi_gdt64
 	.long	0			/* Filled out by user */
-- 
2.20.1

