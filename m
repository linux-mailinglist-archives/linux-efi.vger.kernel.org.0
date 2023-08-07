Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB62772AAC
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjHGQ2O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjHGQ2K (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:28:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30421711;
        Mon,  7 Aug 2023 09:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB8AC61F13;
        Mon,  7 Aug 2023 16:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990C8C433C8;
        Mon,  7 Aug 2023 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425680;
        bh=GJ13nl3ZCY2Menb4uKjvqNr/G3g/s/XryQUjS3VTYnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWEhD3JDmEXfirtAA8jeiRsOgKJZKXAE5FgUL93IZystwzJSmTfbbUbwR7SZjJMEG
         qOTSjmCp+ncTspATJu7v6nL+r8i1TbYbf9PCi/9iC99UWVzu871Cuav7gusxV1twqi
         CRLEoe6r86TeUKCSceQN4U0OuLsbUAqanF/iKB5OyC6XB49w5ZiBVLvjDJB88NrBzU
         LwKwjFSq7TF8qvbFuZuikTTfMTfuL+4ZxIvn2VYSKdbZfdNAmSo71NnBpyxskdOpSP
         ts7yIkPeRX4ITjZbyW2CYs+TnyMvRqCsv1JRW6y67aIND4vamw0oGTMBAF9gsZr88X
         LFPwKObaYjHuA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v9 09/23] x86/decompressor: Call trampoline as a normal function
Date:   Mon,  7 Aug 2023 18:27:06 +0200
Message-Id: <20230807162720.545787-10-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807162720.545787-1-ardb@kernel.org>
References: <20230807162720.545787-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5005; i=ardb@kernel.org; h=from:subject; bh=GJ13nl3ZCY2Menb4uKjvqNr/G3g/s/XryQUjS3VTYnU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWidNjNs8Ui2fH3+B/vnq1mJtLFMblggsPVv54qOa5O5 +btVvDsKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPZ0cXI8JZNsfGtHxtj4ZrT LXukZrJ3qa7QP2PVpn9IqDJ52fw3VowMszcffLz7/Mvj3vnTH25nyIgxzD2c35CmxW1TZWwcZL2 MGQA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move the long return to switch to 32-bit mode into the trampoline code
so it can be called as an ordinary function. This will allow it to be
called directly from C code in a subsequent patch.

While at it, reorganize the code somewhat to keep the prologue and
epilogue of the function together, making the code a bit easier to
follow. Also, given that the trampoline is now entered in 64-bit mode, a
simple RIP-relative reference can be used to take the address of the
exit point.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 79 +++++++++-----------
 arch/x86/boot/compressed/pgtable.h |  2 +-
 2 files changed, 36 insertions(+), 45 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 19bf810409e2aa62..91b5eee306148f9a 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -447,39 +447,8 @@ SYM_CODE_START(startup_64)
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
 
-	/* Set up 32-bit addressable stack */
-	leaq	TRAMPOLINE_32BIT_STACK_END(%rcx), %rsp
-
-	/*
-	 * Preserve live 64-bit registers on the stack: this is necessary
-	 * because the architecture does not guarantee that GPRs will retain
-	 * their full 64-bit values across a 32-bit mode switch.
-	 */
-	pushq	%r15
-	pushq	%rbp
-	pushq	%rbx
-
-	/*
-	 * Push the 64-bit address of trampoline_return() onto the new stack.
-	 * It will be used by the trampoline to return to the main code. Due to
-	 * the 32-bit mode switch, it cannot be kept it in a register either.
-	 */
-	leaq	trampoline_return(%rip), %rdi
-	pushq	%rdi
-
-	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
-	pushq	$__KERNEL32_CS
 	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
-	pushq	%rax
-	lretq
-trampoline_return:
-	/* Restore live 64-bit registers */
-	popq	%rbx
-	popq	%rbp
-	popq	%r15
-
-	/* Restore the stack, the 32-bit trampoline uses its own stack */
-	leaq	rva(boot_stack_end)(%rbx), %rsp
+	call	*%rax
 
 	/*
 	 * cleanup_trampoline() would restore trampoline memory.
@@ -561,7 +530,6 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	jmp	*%rax
 SYM_FUNC_END(.Lrelocated)
 
-	.code32
 /*
  * This is the 32-bit trampoline that will be copied over to low memory.
  *
@@ -570,6 +538,39 @@ SYM_FUNC_END(.Lrelocated)
  * Non zero RDX means trampoline needs to enable 5-level paging.
  */
 SYM_CODE_START(trampoline_32bit_src)
+	/*
+	 * Preserve live 64-bit registers on the stack: this is necessary
+	 * because the architecture does not guarantee that GPRs will retain
+	 * their full 64-bit values across a 32-bit mode switch.
+	 */
+	pushq	%r15
+	pushq	%rbp
+	pushq	%rbx
+
+	/* Set up 32-bit addressable stack and push the old RSP value */
+	leaq	(TRAMPOLINE_32BIT_STACK_END - 8)(%rcx), %rbx
+	movq	%rsp, (%rbx)
+	movq	%rbx, %rsp
+
+	/* Take the address of the trampoline exit code */
+	leaq	.Lret(%rip), %rbx
+
+	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
+	pushq	$__KERNEL32_CS
+	leaq	0f(%rip), %rax
+	pushq	%rax
+	lretq
+
+.Lret:
+	/* Restore the preserved 64-bit registers */
+	movq	(%rsp), %rsp
+	popq	%rbx
+	popq	%rbp
+	popq	%r15
+	retq
+
+	.code32
+0:
 	/* Set up data and stack segments */
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
@@ -633,12 +634,9 @@ SYM_CODE_START(trampoline_32bit_src)
 1:
 	movl	%eax, %cr4
 
-	/* Calculate address of paging_enabled() once we are executing in the trampoline */
-	leal	.Lpaging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%ecx), %eax
-
 	/* Prepare the stack for far return to Long Mode */
 	pushl	$__KERNEL_CS
-	pushl	%eax
+	pushl	%ebx
 
 	/* Enable paging again. */
 	movl	%cr0, %eax
@@ -648,12 +646,6 @@ SYM_CODE_START(trampoline_32bit_src)
 	lret
 SYM_CODE_END(trampoline_32bit_src)
 
-	.code64
-SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
-	/* Return from the trampoline */
-	retq
-SYM_FUNC_END(.Lpaging_enabled)
-
 	/*
          * The trampoline code has a size limit.
          * Make sure we fail to compile if the trampoline code grows
@@ -661,7 +653,6 @@ SYM_FUNC_END(.Lpaging_enabled)
 	 */
 	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
 
-	.code32
 SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index cc9b2529a08634b4..91dbb99203fbce2d 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -6,7 +6,7 @@
 #define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
 
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
-#define TRAMPOLINE_32BIT_CODE_SIZE	0x80
+#define TRAMPOLINE_32BIT_CODE_SIZE	0xA0
 
 #define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
 
-- 
2.39.2

