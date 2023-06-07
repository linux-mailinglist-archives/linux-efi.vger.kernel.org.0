Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D9772558C
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 09:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbjFGHZ4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 03:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbjFGHZ0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 03:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681BF1FD4;
        Wed,  7 Jun 2023 00:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA77463B70;
        Wed,  7 Jun 2023 07:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79581C433EF;
        Wed,  7 Jun 2023 07:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686122670;
        bh=6LI2p3tMGpqgjf5Vh98U5/dlrPhBIFsp0XryDg0+x/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgM11BuIp3TzyU26yqt96LabnmOCTvGHaPsyBKuLDOzlPjLzSSUgk6lhaBLEMlLgZ
         PYpYt3y1fOhyNa5YWFzrfNtRxOMMvWTRWWw2q2CvV+lWP91uU03/kr2OjAwltciJcw
         WFsq8tCURRaSCs6OLg9K25Sjc/JEw2f4zfNrG/ovNcFhOP1EDTOQrcn6DLyUwJxKS5
         eph44AGkWFbmVmMi55+hPsfSq5TEK/E/e/NfRZLGRSMg4XYlZgbDDTgF9cXKvHJlam
         XQ5W2E4qBHKB2B41W4z12g3jdfBcjedfCqxKJhOJ9TtZ7302p4y9o7SzxID9qHlRCL
         7tSsImNsDEdWg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v5 08/20] x86/decompressor: Use standard calling convention for trampoline
Date:   Wed,  7 Jun 2023 09:23:30 +0200
Message-Id: <20230607072342.4054036-9-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607072342.4054036-1-ardb@kernel.org>
References: <20230607072342.4054036-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4143; i=ardb@kernel.org; h=from:subject; bh=6LI2p3tMGpqgjf5Vh98U5/dlrPhBIFsp0XryDg0+x/4=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXBIG9l6kWJ8zVOTq1sXadOmfbaxrX+bM1U2TXTp8ROI vgNn21HKQuDGAeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmEjRBYb/+a4JOuuYb/Ite7Lo 1+rYCnfuU29Oi3C/7JUPaU458kokjJHh2k9Za4Hmk1166rJ7PnHv6ytfyJMkfGjZs+V+6utfPLP iAQA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Update the trampoline code so its arguments are passed via RDI and RSI,
which matches the ordinary SysV calling convention for x86_64. This will
allow this code to be called directly from C.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 30 +++++++++-----------
 arch/x86/boot/compressed/pgtable.h |  2 +-
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index af45ddd8297a4a07..a387cd80964e1a1e 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -443,9 +443,9 @@ SYM_CODE_START(startup_64)
 	movq	%r15, %rdi		/* pass struct boot_params pointer */
 	call	paging_prepare
 
-	/* Save the trampoline address in RCX */
-	movq	%rax, %rcx
-
+	/* Pass the trampoline address and boolean flag as args #1 and #2 */
+	movq	%rax, %rdi
+	movq	%rdx, %rsi
 	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
 	call	*%rax
 
@@ -534,11 +534,11 @@ SYM_FUNC_END(.Lrelocated)
 /*
  * This is the 32-bit trampoline that will be copied over to low memory.
  *
- * ECX contains the base address of the trampoline memory.
- * Non zero RDX means trampoline needs to enable 5-level paging.
+ * EDI contains the base address of the trampoline memory.
+ * Non-zero ESI means trampoline needs to enable 5-level paging.
  */
 SYM_CODE_START(trampoline_32bit_src)
-	popq	%rdi
+	popq	%r8
 	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
 	pushq	$__KERNEL32_CS
 	leaq	0f(%rip), %rax
@@ -552,7 +552,7 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	%eax, %ss
 
 	/* Set up new stack */
-	leal	TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
+	leal	TRAMPOLINE_32BIT_STACK_END(%edi), %esp
 
 	/* Disable paging */
 	movl	%cr0, %eax
@@ -560,7 +560,7 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	%eax, %cr0
 
 	/* Check what paging mode we want to be in after the trampoline */
-	testl	%edx, %edx
+	testl	%esi, %esi
 	jz	1f
 
 	/* We want 5-level paging: don't touch CR3 if it already points to 5-level page tables */
@@ -575,21 +575,17 @@ SYM_CODE_START(trampoline_32bit_src)
 	jz	3f
 2:
 	/* Point CR3 to the trampoline's new top level page table */
-	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%ecx), %eax
+	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%edi), %eax
 	movl	%eax, %cr3
 3:
 	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
-	pushl	%ecx
-	pushl	%edx
 	movl	$MSR_EFER, %ecx
 	rdmsr
 	btsl	$_EFER_LME, %eax
 	/* Avoid writing EFER if no change was made (for TDX guest) */
 	jc	1f
 	wrmsr
-1:	popl	%edx
-	popl	%ecx
-
+1:
 #ifdef CONFIG_X86_MCE
 	/*
 	 * Preserve CR4.MCE if the kernel will enable #MC support.
@@ -606,14 +602,14 @@ SYM_CODE_START(trampoline_32bit_src)
 
 	/* Enable PAE and LA57 (if required) paging modes */
 	orl	$X86_CR4_PAE, %eax
-	testl	%edx, %edx
+	testl	%esi, %esi
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
 1:
 	movl	%eax, %cr4
 
 	/* Calculate address of paging_enabled() once we are executing in the trampoline */
-	leal	.Lpaging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%ecx), %eax
+	leal	.Lpaging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%edi), %eax
 
 	/* Prepare the stack for far return to Long Mode */
 	pushl	$__KERNEL_CS
@@ -630,7 +626,7 @@ SYM_CODE_END(trampoline_32bit_src)
 	.code64
 SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
 	/* Return from the trampoline */
-	jmp	*%rdi
+	jmp	*%r8
 SYM_FUNC_END(.Lpaging_enabled)
 
 	/*
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index 91dbb99203fbce2d..4e8cef135226bcbb 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -14,7 +14,7 @@
 
 extern unsigned long *trampoline_32bit;
 
-extern void trampoline_32bit_src(void *return_ptr);
+extern void trampoline_32bit_src(void *trampoline, bool enable_5lvl);
 
 #endif /* __ASSEMBLER__ */
 #endif /* BOOT_COMPRESSED_PAGETABLE_H */
-- 
2.39.2

