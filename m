Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EBD772AB1
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjHGQ2Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjHGQ2D (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F62610DE;
        Mon,  7 Aug 2023 09:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C401161F1B;
        Mon,  7 Aug 2023 16:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8331C433C9;
        Mon,  7 Aug 2023 16:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425676;
        bh=7D4HdiWvB51jf9PtMrHNY1LkXYyyjvNVJhuX8x8xGjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kuZyfxX//dsYMytxVlhyRFGkSFiSHw8cD/YABMCIzaJthJ4PmTpg3r4Ckl/hfzKgg
         uPZXOE9mzZ9G6GVn9R0FNcMPAgg/DcgYNlew/U/epCuRbJACj1PsIKLFbFxX/LVwlI
         4P9lc8Mn8EBjoVodGB3TDduGNhjc6cGaMSAkaKLWcl0pGbyF4+q6DyYZ8v98lxpsOs
         0fcqUUCc9+TaWDGdqXZpUnKRcmoGoRbalyD0Zv325W28JLi2SCPT4lR163de95G2YW
         H1Ie0857RU2pxIndOrKw558EXdZa/qZLKLZ4ZWdeYZSfDKKS1ilEZrH9RT6ps9zTmN
         uHs5fcwy5ggJA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v9 07/23] x86/decompressor: Store boot_params pointer in callee save register
Date:   Mon,  7 Aug 2023 18:27:04 +0200
Message-Id: <20230807162720.545787-8-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807162720.545787-1-ardb@kernel.org>
References: <20230807162720.545787-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4376; i=ardb@kernel.org; h=from:subject; bh=7D4HdiWvB51jf9PtMrHNY1LkXYyyjvNVJhuX8x8xGjA=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWidPAN9aiZd6cnXHTISvH1tfg8vehj0JkNF9P8L03/L nV5+ZRHHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiB/8xMhyd+aBbWOXKKZ+f 225NefmuXZuL1d31X8V/9ZS7htkfowMYGSbN3rl/GudmacVIhdd9jjtmPNjg0vXCWi08o9n+h8m LPnYA
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

Instead of pushing and popping %RSI several times to preserve the struct
boot_params pointer across the execution of the startup code, move it
into a callee save register before the first call into C, and copy it
back when needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 42 ++++++++------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a3f764daf3a3adbc..19bf810409e2aa62 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -405,10 +405,14 @@ SYM_CODE_START(startup_64)
 	lretq
 
 .Lon_kernel_cs:
+	/*
+	 * RSI holds a pointer to a boot_params structure provided by the
+	 * loader, and this needs to be preserved across C function calls. So
+	 * move it into a callee saved register.
+	 */
+	movq	%rsi, %r15
 
-	pushq	%rsi
 	call	load_stage1_idt
-	popq	%rsi
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/*
@@ -419,12 +423,10 @@ SYM_CODE_START(startup_64)
 	 * CPUID instructions being issued, so go ahead and do that now via
 	 * sev_enable(), which will also handle the rest of the SEV-related
 	 * detection/setup to ensure that has been done in advance of any dependent
-	 * code.
+	 * code. Pass the boot_params pointer as the first argument.
 	 */
-	pushq	%rsi
-	movq	%rsi, %rdi		/* real mode address */
+	movq	%r15, %rdi
 	call	sev_enable
-	popq	%rsi
 #endif
 
 	/*
@@ -437,13 +439,10 @@ SYM_CODE_START(startup_64)
 	 *   - Non zero RDX means trampoline needs to enable 5-level
 	 *     paging.
 	 *
-	 * RSI holds real mode data and needs to be preserved across
-	 * this function call.
+	 * Pass the boot_params pointer as the first argument.
 	 */
-	pushq	%rsi
-	movq	%rsi, %rdi		/* real mode address */
+	movq	%r15, %rdi
 	call	paging_prepare
-	popq	%rsi
 
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
@@ -456,9 +455,9 @@ SYM_CODE_START(startup_64)
 	 * because the architecture does not guarantee that GPRs will retain
 	 * their full 64-bit values across a 32-bit mode switch.
 	 */
+	pushq	%r15
 	pushq	%rbp
 	pushq	%rbx
-	pushq	%rsi
 
 	/*
 	 * Push the 64-bit address of trampoline_return() onto the new stack.
@@ -475,9 +474,9 @@ SYM_CODE_START(startup_64)
 	lretq
 trampoline_return:
 	/* Restore live 64-bit registers */
-	popq	%rsi
 	popq	%rbx
 	popq	%rbp
+	popq	%r15
 
 	/* Restore the stack, the 32-bit trampoline uses its own stack */
 	leaq	rva(boot_stack_end)(%rbx), %rsp
@@ -487,14 +486,9 @@ trampoline_return:
 	 *
 	 * RDI is address of the page table to use instead of page table
 	 * in trampoline memory (if required).
-	 *
-	 * RSI holds real mode data and needs to be preserved across
-	 * this function call.
 	 */
-	pushq	%rsi
 	leaq	rva(top_pgtable)(%rbx), %rdi
 	call	cleanup_trampoline
-	popq	%rsi
 
 	/* Zero EFLAGS */
 	pushq	$0
@@ -504,7 +498,6 @@ trampoline_return:
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
  */
-	pushq	%rsi
 	leaq	(_bss-8)(%rip), %rsi
 	leaq	rva(_bss-8)(%rbx), %rdi
 	movl	$(_bss - startup_32), %ecx
@@ -512,7 +505,6 @@ trampoline_return:
 	std
 	rep	movsq
 	cld
-	popq	%rsi
 
 	/*
 	 * The GDT may get overwritten either during the copy we just did or
@@ -544,30 +536,28 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	shrq	$3, %rcx
 	rep	stosq
 
-	pushq	%rsi
 	call	load_stage2_idt
 
 	/* Pass boot_params to initialize_identity_maps() */
-	movq	(%rsp), %rdi
+	movq	%r15, %rdi
 	call	initialize_identity_maps
-	popq	%rsi
 
 /*
  * Do the extraction, and jump to the new kernel..
  */
-	pushq	%rsi			/* Save the real mode argument */
-	movq	%rsi, %rdi		/* real mode address */
+	/* pass struct boot_params pointer */
+	movq	%r15, %rdi
 	leaq	boot_heap(%rip), %rsi	/* malloc area for uncompression */
 	leaq	input_data(%rip), %rdx  /* input_data */
 	movl	input_len(%rip), %ecx	/* input_len */
 	movq	%rbp, %r8		/* output target address */
 	movl	output_len(%rip), %r9d	/* decompressed length, end of relocs */
 	call	extract_kernel		/* returns kernel entry point in %rax */
-	popq	%rsi
 
 /*
  * Jump to the decompressed kernel.
  */
+	movq	%r15, %rsi
 	jmp	*%rax
 SYM_FUNC_END(.Lrelocated)
 
-- 
2.39.2

