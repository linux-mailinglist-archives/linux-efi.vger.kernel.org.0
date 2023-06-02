Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC571FF19
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 12:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjFBKYG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 06:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbjFBKXU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 06:23:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55397E62;
        Fri,  2 Jun 2023 03:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6F5164E4E;
        Fri,  2 Jun 2023 10:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29891C433A1;
        Fri,  2 Jun 2023 10:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685701371;
        bh=hFZ/SCviIEc1YZbiLBLlEDyweQ6PGSxYwFHksamIzHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nfff8boM+8RvgzsdhvHcWIJlC+g8g4Wq7plDTW+pSwMYIQ+FA/pQdAwR9wmQEH9Hu
         tozvIv+dHkPk86T9EBsrWvOOuGTPKW7gZ1ZHFUVu2k6Ovt3PHh+gxoR8+qQPsVhlDW
         I6Y/rXYNtS0G3JWI7pYAWi7AWH91sSo+67RvGTNLsw5fRCo9oURHj2UeXSnUhWALgD
         JPnuP1Y3H72MpzNEBpqLfzxVt5VauFyizJ1+959HL6IdT4uP5VmAQ8c1oz24VJVXBI
         nCzjaghvF4ZqJNjwJRi87HnpiVPxe0xMZ/kWrnWUBOv80HiGGxF9Se1bYlP7zMhhrY
         WEN/khJAwidrA==
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
Subject: [PATCH v4 10/21] x86/decompressor: Call trampoline directly from C code
Date:   Fri,  2 Jun 2023 12:13:02 +0200
Message-Id: <20230602101313.3557775-11-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230602101313.3557775-1-ardb@kernel.org>
References: <20230602101313.3557775-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4966; i=ardb@kernel.org; h=from:subject; bh=hFZ/SCviIEc1YZbiLBLlEDyweQ6PGSxYwFHksamIzHs=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXywJrzy7b+fukf7pKxUXarwbGeLatCFi5a9qu7hWG6Y BHjqmPzO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBE2NYwMvQlzjl3wOv7IbPb G1zn37z3xyPONlq48lbd/YbFa+5dmvWK4X+69v0z8yrf/xZ/78K/z/ENe0idEl+Imabpz9+VvoJ OAewA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of returning to the asm calling code to invoke the trampoline,
call it straight from the C code that sets the scene. That way, the
struct return type is no longer needed for returning two values, and the
call can be made conditional more cleanly in a subsequent patch.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 20 +++-----------
 arch/x86/boot/compressed/pgtable_64.c | 28 ++++++++------------
 2 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 741b4e8fefc915ea..a60ec9283bd760e3 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -430,24 +430,12 @@ SYM_CODE_START(startup_64)
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
-	 *
+	 * set_paging_levels() updates the number of paging levels using a
+	 * trampoline in 32-bit addressable memory if the current number does
+	 * not match the desired number.
 	 */
 	movq	%r15, %rdi		/* pass struct boot_params pointer */
-	call	paging_prepare
-
-	/* Pass the trampoline address and boolean flag as args #1 and #2 */
-	movq	%rax, %rdi
-	movq	%rdx, %rsi
-	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
-	call	*%rax
+	call	set_paging_levels
 
 	/*
 	 * cleanup_trampoline() would restore trampoline memory.
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 09fc18180929fab3..b62b6819dcdd01be 100644
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
 
@@ -106,10 +101,10 @@ static unsigned long find_trampoline_placement(void)
 	return bios_start - TRAMPOLINE_32BIT_SIZE;
 }
 
-struct paging_config paging_prepare(void *rmode)
+asmlinkage void set_paging_levels(void *rmode)
 {
-	struct paging_config paging_config = {};
-	void *tramp_code;
+	void (*toggle_la57)(void *trampoline, bool enable_5lvl);
+	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
 	boot_params = rmode;
@@ -130,12 +125,10 @@ struct paging_config paging_prepare(void *rmode)
 			!cmdline_find_option_bool("no5lvl") &&
 			native_cpuid_eax(0) >= 7 &&
 			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
-		paging_config.l5_required = 1;
+		l5_required = true;
 	}
 
-	paging_config.trampoline_start = find_trampoline_placement();
-
-	trampoline_32bit = (unsigned long *)paging_config.trampoline_start;
+	trampoline_32bit = (unsigned long *)find_trampoline_placement();
 
 	/* Preserve trampoline memory */
 	memcpy(trampoline_save, trampoline_32bit, TRAMPOLINE_32BIT_SIZE);
@@ -144,7 +137,7 @@ struct paging_config paging_prepare(void *rmode)
 	memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
 
 	/* Copy trampoline code in place */
-	tramp_code = memcpy(trampoline_32bit +
+	toggle_la57 = memcpy(trampoline_32bit +
 			TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
 			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
 
@@ -154,7 +147,8 @@ struct paging_config paging_prepare(void *rmode)
 	 * immediate absolute address, so we have to adjust that based on the
 	 * placement of the trampoline.
 	 */
-	*(u32 *)(tramp_code + trampoline_ljmp_imm_offset) += (unsigned long)tramp_code;
+	*(u32 *)((u8 *)toggle_la57 + trampoline_ljmp_imm_offset) +=
+						(unsigned long)toggle_la57;
 
 	/*
 	 * The code below prepares page table in trampoline memory.
@@ -170,10 +164,10 @@ struct paging_config paging_prepare(void *rmode)
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
@@ -196,7 +190,7 @@ struct paging_config paging_prepare(void *rmode)
 	}
 
 out:
-	return paging_config;
+	toggle_la57(trampoline_32bit, l5_required);
 }
 
 void cleanup_trampoline(void *pgtable)
-- 
2.39.2

