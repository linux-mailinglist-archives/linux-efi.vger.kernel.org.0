Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D056476D2D4
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 17:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjHBPt5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 11:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbjHBPtl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 11:49:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41D73582;
        Wed,  2 Aug 2023 08:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55D9E61A17;
        Wed,  2 Aug 2023 15:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D10C433C8;
        Wed,  2 Aug 2023 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690991362;
        bh=7D4HdiWvB51jf9PtMrHNY1LkXYyyjvNVJhuX8x8xGjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZfszIB0vikmV5dUDm5A07JTJtNSWqyl6BhVhfyblluuk4AdP0uHAN+/BTNZWuoEYv
         o/qpSvuPrSp8QnBrLDtb25ycWfaclwOVlC0+5hwDC/RgdluaVxenrbsU8qLWf1nqiG
         9KCBjrW2tCGRSX5Hw8q+zaoxwjEI8gEnvoVOpehTzNJ+qBqyrMcAG1DwRS7KFMKbA5
         p+3CjyOmes9pf+8Ca1lueFxEKQ2jytBbN63bZGDXORNkHG1K/qR06uLNDW3J5BlTcA
         VHLK9w/jsH6o3tY65TesgRB5YCAY4dGswGqMAoGnnDLY7igegj0PeMm1FOTHMSRFT3
         82YMXna+3A0ig==
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
Subject: [PATCH v8 07/23] x86/decompressor: Store boot_params pointer in callee save register
Date:   Wed,  2 Aug 2023 17:48:15 +0200
Message-Id: <20230802154831.2147855-8-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802154831.2147855-1-ardb@kernel.org>
References: <20230802154831.2147855-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4376; i=ardb@kernel.org; h=from:subject; bh=7D4HdiWvB51jf9PtMrHNY1LkXYyyjvNVJhuX8x8xGjA=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVU1a4b6lEz705PuOiQleLra/F5etHHoDMbLqb5X5r+X ery8imPOkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEplQx/NN/phJy7Pp5Qf90 vym/OK8Eb6i6Y+nDLFmWmn57ae/dI1MZ/rvLtBxbM2ul/XrvA1HNJjOzFPfY6v2RnNzSH9F+14f hExsA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

