Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D8A772ABA
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjHGQ2V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjHGQ2P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:28:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29031701;
        Mon,  7 Aug 2023 09:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D66461EE4;
        Mon,  7 Aug 2023 16:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C768C433CA;
        Mon,  7 Aug 2023 16:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425686;
        bh=1leImSL0GIXC+stm+qJDUcS1s2kkKXwvVrWLvnoMRrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNO+asru/o9IAzB9Rz0aHThLy1VSYOkXyPdXCJcrcvmGKMIGu3UiuL+rhw+IYMch+
         n0H58JAZl4/8xpTvSXbiXlIoG2+2bZf973Smtb9Okuix0OTdZDz7E72qOdbwhwsY36
         dFR43pQ4IXDfGjYhm86q6Jtbsy89CJJVjDck8BpkC8Byke4Hhu1lWdCGPItft9nn+v
         6yfftwl8cgQvDWhNAigiyUUU9EToJgl10JVKl0ANLdugXTwC1fQOZo27oVzhUTjVrM
         GqjN3e3uLsZZDQDx5bD4p+hoV2ZtJuxWz3HIi3Y4qMjmb4TjKdb6QPEDSPudeLyrG2
         g/AfSOIMAK6iw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v9 12/23] x86/decompressor: Call trampoline directly from C code
Date:   Mon,  7 Aug 2023 18:27:09 +0200
Message-Id: <20230807162720.545787-13-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807162720.545787-1-ardb@kernel.org>
References: <20230807162720.545787-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6565; i=ardb@kernel.org; h=from:subject; bh=1leImSL0GIXC+stm+qJDUcS1s2kkKXwvVrWLvnoMRrI=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWidOT5H5vWP+VUOMlyvnDP++939Auj2f9+X3Z/svOUT /qyznd6OkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEVBYyMnT9Uz9sdFjmHat5 04f13OtsdA4+akpf+HfL+cPfXx2/cmwjw/9kg7hTHUbq9/rz5edeeF70nL3EwLZ0VafJ4tKd1zt 9v7MBAA==
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

Instead of returning to the asm calling code to invoke the trampoline,
call it straight from the C code that sets it up. That way, the struct
return type is no longer needed for returning two values, and the call
can be made conditional more cleanly in a subsequent patch.

This means that all callee save 64-bit registers need to be preserved
and restored, as their contents may not survive the legacy mode switch.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 31 ++++++++-----------
 arch/x86/boot/compressed/pgtable_64.c | 32 ++++++++------------
 2 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 37fd7b7d683d696c..cd6e3e175389aa6b 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -430,25 +430,14 @@ SYM_CODE_START(startup_64)
 #endif
 
 	/*
-	 * paging_prepare() sets up the trampoline and checks if we need to
-	 * enable 5-level paging.
-	 *
-	 * paging_prepare() returns a two-quadword structure which lands
-	 * into RDX:RAX:
-	 *   - Address of the trampoline is returned in RAX.
-	 *   - Non zero RDX means trampoline needs to enable 5-level
-	 *     paging.
+	 * configure_5level_paging() updates the number of paging levels using
+	 * a trampoline in 32-bit addressable memory if the current number does
+	 * not match the desired number.
 	 *
 	 * Pass the boot_params pointer as the first argument.
 	 */
 	movq	%r15, %rdi
-	call	paging_prepare
-
-	/* Pass the trampoline address and boolean flag as args #1 and #2 */
-	movq	%rax, %rdi
-	movq	%rdx, %rsi
-	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
-	call	*%rax
+	call	configure_5level_paging
 
 	/*
 	 * cleanup_trampoline() would restore trampoline memory.
@@ -543,11 +532,14 @@ SYM_FUNC_END(.Lrelocated)
 	.section ".rodata", "a", @progbits
 SYM_CODE_START(trampoline_32bit_src)
 	/*
-	 * Preserve live 64-bit registers on the stack: this is necessary
-	 * because the architecture does not guarantee that GPRs will retain
-	 * their full 64-bit values across a 32-bit mode switch.
+	 * Preserve callee save 64-bit registers on the stack: this is
+	 * necessary because the architecture does not guarantee that GPRs will
+	 * retain their full 64-bit values across a 32-bit mode switch.
 	 */
 	pushq	%r15
+	pushq	%r14
+	pushq	%r13
+	pushq	%r12
 	pushq	%rbp
 	pushq	%rbx
 
@@ -574,6 +566,9 @@ SYM_CODE_START(trampoline_32bit_src)
 	/* Restore the preserved 64-bit registers */
 	popq	%rbx
 	popq	%rbp
+	popq	%r12
+	popq	%r13
+	popq	%r14
 	popq	%r15
 	retq
 
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 5198a05aefa8d14a..f9cc86b2ee55ca80 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -16,11 +16,6 @@ unsigned int __section(".data") pgdir_shift = 39;
 unsigned int __section(".data") ptrs_per_p4d = 1;
 #endif
 
-struct paging_config {
-	unsigned long trampoline_start;
-	unsigned long l5_required;
-};
-
 /* Buffer to preserve trampoline memory */
 static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
 
@@ -29,7 +24,7 @@ static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
  * purposes.
  *
  * Avoid putting the pointer into .bss as it will be cleared between
- * paging_prepare() and extract_kernel().
+ * configure_5level_paging() and extract_kernel().
  */
 unsigned long *trampoline_32bit __section(".data");
 
@@ -106,13 +101,13 @@ static unsigned long find_trampoline_placement(void)
 	return bios_start - TRAMPOLINE_32BIT_SIZE;
 }
 
-struct paging_config paging_prepare(void *rmode)
+asmlinkage void configure_5level_paging(struct boot_params *bp)
 {
-	struct paging_config paging_config = {};
-	void *tramp_code;
+	void (*toggle_la57)(void *trampoline, bool enable_5lvl);
+	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
-	boot_params = rmode;
+	boot_params = bp;
 
 	/*
 	 * Check if LA57 is desired and supported.
@@ -130,7 +125,7 @@ struct paging_config paging_prepare(void *rmode)
 			!cmdline_find_option_bool("no5lvl") &&
 			native_cpuid_eax(0) >= 7 &&
 			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
-		paging_config.l5_required = 1;
+		l5_required = true;
 
 		/* Initialize variables for 5-level paging */
 		__pgtable_l5_enabled = 1;
@@ -138,9 +133,7 @@ struct paging_config paging_prepare(void *rmode)
 		ptrs_per_p4d = 512;
 	}
 
-	paging_config.trampoline_start = find_trampoline_placement();
-
-	trampoline_32bit = (unsigned long *)paging_config.trampoline_start;
+	trampoline_32bit = (unsigned long *)find_trampoline_placement();
 
 	/* Preserve trampoline memory */
 	memcpy(trampoline_save, trampoline_32bit, TRAMPOLINE_32BIT_SIZE);
@@ -149,7 +142,7 @@ struct paging_config paging_prepare(void *rmode)
 	memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
 
 	/* Copy trampoline code in place */
-	tramp_code = memcpy(trampoline_32bit +
+	toggle_la57 = memcpy(trampoline_32bit +
 			TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
 			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
 
@@ -159,7 +152,8 @@ struct paging_config paging_prepare(void *rmode)
 	 * immediate absolute address, which needs to be adjusted based on the
 	 * placement of the trampoline.
 	 */
-	*(u32 *)(tramp_code + trampoline_ljmp_imm_offset) += (unsigned long)tramp_code;
+	*(u32 *)((u8 *)toggle_la57 + trampoline_ljmp_imm_offset) +=
+						(unsigned long)toggle_la57;
 
 	/*
 	 * The code below prepares page table in trampoline memory.
@@ -175,10 +169,10 @@ struct paging_config paging_prepare(void *rmode)
 	 * We are not going to use the page table in trampoline memory if we
 	 * are already in the desired paging mode.
 	 */
-	if (paging_config.l5_required == !!(native_read_cr4() & X86_CR4_LA57))
+	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
 		goto out;
 
-	if (paging_config.l5_required) {
+	if (l5_required) {
 		/*
 		 * For 4- to 5-level paging transition, set up current CR3 as
 		 * the first and the only entry in a new top-level page table.
@@ -201,7 +195,7 @@ struct paging_config paging_prepare(void *rmode)
 	}
 
 out:
-	return paging_config;
+	toggle_la57(trampoline_32bit, l5_required);
 }
 
 void cleanup_trampoline(void *pgtable)
-- 
2.39.2

