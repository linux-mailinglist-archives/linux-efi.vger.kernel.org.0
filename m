Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E36FA076
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 09:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjEHHEb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 03:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjEHHEH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 03:04:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2391A1F7;
        Mon,  8 May 2023 00:04:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3B9661F96;
        Mon,  8 May 2023 07:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92676C433A4;
        Mon,  8 May 2023 07:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529441;
        bh=Qz3uNSnHMPU7hlGyuEpJliraqb/Fez39IiSe2mqtMoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MidC1/dw8hHKhTnSTurzN66Te3FasH9dv9RRbVjhDmi0cPle2+vUWXABnMG8TutuI
         kl2MPAtEHubbYhLNCldB94CYlHTuihuJWGMG04rNMqoCipCfqXtCLaXdvJ7GL9V8Cl
         QMrIt0id9mQ7E4QSTM0PDGqubGeVft/4yrBKLamt2Hi8NKVNchbBlEL6By+BlDB9Wq
         v5K7sGrnwEgIRx5Hf70Imlftmym5t9dt27h3aZTO0oD9BDjrRKTayITO8791n8Oply
         G6niEyDO9GukZN8YfRPEhCYNqc5mh53pYl/motJn32lFL+WXb1UxJoWcQJpJ4G0Mzs
         WT2s0eGeSh0/w==
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
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 05/20] x86: decompressor: Avoid the need for a stack in the 32-bit trampoline
Date:   Mon,  8 May 2023 09:03:15 +0200
Message-Id: <20230508070330.582131-6-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508070330.582131-1-ardb@kernel.org>
References: <20230508070330.582131-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5630; i=ardb@kernel.org; h=from:subject; bh=Qz3uNSnHMPU7hlGyuEpJliraqb/Fez39IiSe2mqtMoo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3nrewOe799/icPx6dEn/3t+fZXfEZZbuNP/mqf1R5 d7DxJo3HaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAi2fsYGU7qp9znf5r0+ZaT xvXTqou0FX/ktK4Q5uYWc5jjvNPyvDDDf6/OxSZvDJ7VMeS/eZqS5euTN2G9Js+OHCst7V1d6nN VGQA=
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

The 32-bit trampoline no longer uses the stack for anything except
performing a long return back to long mode. Currently, this stack is
allocated in the same page that carries the trampoline code, which means
this page must be mapped writable and executable, and the stack is
therefore executable as well.

So let's do a long jump instead: that way, we can pre-calculate the
return address and poke it into the code before we call it. In a later
patch, we will take advantage of this by removing writable permissions
(and adding executable ones) explicitly when booting via the EFI stub.

Not playing with the stack pointer also makes it more straight-forward
to call the trampoline code as an ordinary 64-bit function from C code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 34 ++++----------------
 arch/x86/boot/compressed/pgtable.h    |  6 ++--
 arch/x86/boot/compressed/pgtable_64.c | 12 ++++++-
 3 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index b1f8a867777120bb..3b5fc851737ffc39 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -460,9 +460,6 @@ SYM_CODE_START(startup_64)
 	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
 	call	*%rax
 
-	/* Restore the stack, the 32-bit trampoline uses its own stack */
-	leaq	rva(boot_stack_end)(%rbx), %rsp
-
 	/*
 	 * cleanup_trampoline() would restore trampoline memory.
 	 *
@@ -563,24 +560,17 @@ SYM_FUNC_END(.Lrelocated)
  * EDI contains the base address of the trampoline memory.
  * Non-zero ESI means trampoline needs to enable 5-level paging.
  */
+	.section ".rodata", "a", @progbits
 SYM_CODE_START(trampoline_32bit_src)
-	popq	%r8
 	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
 	pushq	$__KERNEL32_CS
 	leaq	0f(%rip), %rax
 	pushq	%rax
 	lretq
+.Lret:	retq
 
 	.code32
-0:	/* Set up data and stack segments */
-	movl	$__KERNEL_DS, %eax
-	movl	%eax, %ds
-	movl	%eax, %ss
-
-	/* Set up new stack */
-	leal	TRAMPOLINE_32BIT_STACK_END(%edi), %esp
-
-	/* Disable paging */
+0:	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
 	movl	%eax, %cr0
@@ -634,26 +624,16 @@ SYM_CODE_START(trampoline_32bit_src)
 1:
 	movl	%eax, %cr4
 
-	/* Calculate address of paging_enabled() once we are executing in the trampoline */
-	leal	.Lpaging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%edi), %eax
-
-	/* Prepare the stack for far return to Long Mode */
-	pushl	$__KERNEL_CS
-	pushl	%eax
-
 	/* Enable paging again. */
 	movl	%cr0, %eax
 	btsl	$X86_CR0_PG_BIT, %eax
 	movl	%eax, %cr0
 
-	lret
+.Ljmp:	ljmpl	$__KERNEL_CS, $(.Lret - trampoline_32bit_src)
 SYM_CODE_END(trampoline_32bit_src)
 
-	.code64
-SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
-	/* Return from the trampoline */
-	jmp	*%r8
-SYM_FUNC_END(.Lpaging_enabled)
+/* keep this right after trampoline_32bit_src() so we can infer its size */
+SYM_DATA(trampoline_ljmp_imm_offset, .word  .Ljmp + 1 - trampoline_32bit_src)
 
 	/*
          * The trampoline code has a size limit.
@@ -662,7 +642,7 @@ SYM_FUNC_END(.Lpaging_enabled)
 	 */
 	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
 
-	.code32
+	.text
 SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index 4e8cef135226bcbb..131488f50af55d0a 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -6,9 +6,7 @@
 #define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
 
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
-#define TRAMPOLINE_32BIT_CODE_SIZE	0xA0
-
-#define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
+#define TRAMPOLINE_32BIT_CODE_SIZE	0x80
 
 #ifndef __ASSEMBLER__
 
@@ -16,5 +14,7 @@ extern unsigned long *trampoline_32bit;
 
 extern void trampoline_32bit_src(void *trampoline, bool enable_5lvl);
 
+extern const u16 trampoline_ljmp_imm_offset;
+
 #endif /* __ASSEMBLER__ */
 #endif /* BOOT_COMPRESSED_PAGETABLE_H */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 2ac12ff4111bf8c0..09fc18180929fab3 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -109,6 +109,7 @@ static unsigned long find_trampoline_placement(void)
 struct paging_config paging_prepare(void *rmode)
 {
 	struct paging_config paging_config = {};
+	void *tramp_code;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
 	boot_params = rmode;
@@ -143,9 +144,18 @@ struct paging_config paging_prepare(void *rmode)
 	memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
 
 	/* Copy trampoline code in place */
-	memcpy(trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
+	tramp_code = memcpy(trampoline_32bit +
+			TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
 			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
 
+	/*
+	 * Avoid the need for a stack in the 32-bit trampoline code, by using
+	 * LJMP rather than LRET to return back to long mode. LJMP takes an
+	 * immediate absolute address, so we have to adjust that based on the
+	 * placement of the trampoline.
+	 */
+	*(u32 *)(tramp_code + trampoline_ljmp_imm_offset) += (unsigned long)tramp_code;
+
 	/*
 	 * The code below prepares page table in trampoline memory.
 	 *
-- 
2.39.2

