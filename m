Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B91F76D2E1
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 17:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjHBPu6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 11:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjHBPud (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 11:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B27530D8;
        Wed,  2 Aug 2023 08:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 671BD61A22;
        Wed,  2 Aug 2023 15:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CABC433CA;
        Wed,  2 Aug 2023 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690991388;
        bh=3slwLgPBFo4lIzwatlq/F8EQYbZMUNi+1FW4DnffzCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jYvhkZSuKn2oxTyIi+Gwz4/zH29XyPXbPMuSNaVKAsJK6IOxHUAzyQbXYksGYSAB0
         dwrvwVK2txwCPqiRL+4bKJUD+aGesuzbhMhavimYGrjzjOPQNPpAAFR1Sd+5paGfSQ
         tBkWn73UT/pgua9sru760A5njBx/Q9YDdhyrnIZ+HKGZ9CDywsin4oIyA/FyIENvZA
         eaeWf9ZzAvzyrrRAFmu20aManzoe6EWKQ7k2yN2ZjTvsRSGaE0iwHnvPFktM/F6t8w
         5lYpSH/316oSCP4STSYEamuj9Pwy4Z1Ao4PfFlOSkkBQx3965PEVvKNY8ATU4Ign2s
         h9mI14H0pRmFg==
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
Subject: [PATCH v8 13/23] x86/decompressor: Only call the trampoline when changing paging levels
Date:   Wed,  2 Aug 2023 17:48:21 +0200
Message-Id: <20230802154831.2147855-14-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802154831.2147855-1-ardb@kernel.org>
References: <20230802154831.2147855-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5592; i=ardb@kernel.org; h=from:subject; bh=3slwLgPBFo4lIzwatlq/F8EQYbZMUNi+1FW4DnffzCA=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVU1cFy0XepzeX6vBznpIWfbnz0qNj1nK7V4/PSPlXHW efeqXzWUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYyQZuRYdeSneW9P1zNDorz m71bs/HV9OPXVJ6XL7nYaLphrdhGq3yG/2Vnrh5qeD4z9o3U1aRjHlZ/W/tl3C+eO6C7qXJOFbP AL3YA
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

Since the current and desired number of paging levels are known when the
trampoline is being prepared, avoid calling the trampoline at all if it
is clear that calling it is not going to result in a change to the
number of paging levels.

Given that the CPU is already running in long mode, the PAE and LA57
settings are necessarily consistent with the currently active page
tables, and other fields in CR4 will be initialized by the startup code
in the kernel proper. So limit the manipulation of CR4 to toggling the
LA57 bit, which is the only thing that really needs doing at this point
in the boot. This also means that there is no need to pass the value of
l5_required to toggle_la57(), as it will not be called unless CR4.LA57
needs to toggle.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 45 ++------------------
 arch/x86/boot/compressed/pgtable_64.c | 22 ++++------
 2 files changed, 13 insertions(+), 54 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index cd6e3e175389aa6b..8730b1d58e2b0825 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -387,10 +387,6 @@ SYM_CODE_START(startup_64)
 	 * For the trampoline, we need the top page table to reside in lower
 	 * memory as we don't have a way to load 64-bit values into CR3 in
 	 * 32-bit mode.
-	 *
-	 * We go though the trampoline even if we don't have to: if we're
-	 * already in a desired paging mode. This way the trampoline code gets
-	 * tested on every boot.
 	 */
 
 	/* Make sure we have GDT with 32-bit code segment */
@@ -526,8 +522,7 @@ SYM_FUNC_END(.Lrelocated)
  *
  * Return address is at the top of the stack (might be above 4G).
  * The first argument (EDI) contains the 32-bit addressable base of the
- * trampoline memory. A non-zero second argument (ESI) means that the
- * trampoline needs to enable 5-level paging.
+ * trampoline memory.
  */
 	.section ".rodata", "a", @progbits
 SYM_CODE_START(trampoline_32bit_src)
@@ -579,25 +574,10 @@ SYM_CODE_START(trampoline_32bit_src)
 	btrl	$X86_CR0_PG_BIT, %eax
 	movl	%eax, %cr0
 
-	/* Check what paging mode we want to be in after the trampoline */
-	testl	%esi, %esi
-	jz	1f
-
-	/* We want 5-level paging: don't touch CR3 if it already points to 5-level page tables */
-	movl	%cr4, %eax
-	testl	$X86_CR4_LA57, %eax
-	jnz	3f
-	jmp	2f
-1:
-	/* We want 4-level paging: don't touch CR3 if it already points to 4-level page tables */
-	movl	%cr4, %eax
-	testl	$X86_CR4_LA57, %eax
-	jz	3f
-2:
 	/* Point CR3 to the trampoline's new top level page table */
 	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%edi), %eax
 	movl	%eax, %cr3
-3:
+
 	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
 	movl	$MSR_EFER, %ecx
 	rdmsr
@@ -606,26 +586,9 @@ SYM_CODE_START(trampoline_32bit_src)
 	jc	1f
 	wrmsr
 1:
-#ifdef CONFIG_X86_MCE
-	/*
-	 * Preserve CR4.MCE if the kernel will enable #MC support.
-	 * Clearing MCE may fault in some environments (that also force #MC
-	 * support). Any machine check that occurs before #MC support is fully
-	 * configured will crash the system regardless of the CR4.MCE value set
-	 * here.
-	 */
+	/* Toggle CR4.LA57 */
 	movl	%cr4, %eax
-	andl	$X86_CR4_MCE, %eax
-#else
-	movl	$0, %eax
-#endif
-
-	/* Enable PAE and LA57 (if required) paging modes */
-	orl	$X86_CR4_PAE, %eax
-	testl	%esi, %esi
-	jz	1f
-	orl	$X86_CR4_LA57, %eax
-1:
+	btcl	$X86_CR4_LA57_BIT, %eax
 	movl	%eax, %cr4
 
 	/* Enable paging again. */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index f9cc86b2ee55ca80..4213473ae54883c8 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -103,7 +103,7 @@ static unsigned long find_trampoline_placement(void)
 
 asmlinkage void configure_5level_paging(struct boot_params *bp)
 {
-	void (*toggle_la57)(void *trampoline, bool enable_5lvl);
+	void (*toggle_la57)(void *trampoline);
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
@@ -133,6 +133,13 @@ asmlinkage void configure_5level_paging(struct boot_params *bp)
 		ptrs_per_p4d = 512;
 	}
 
+	/*
+	 * The trampoline will not be used if the paging mode is already set to
+	 * the desired one.
+	 */
+	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
+		return;
+
 	trampoline_32bit = (unsigned long *)find_trampoline_placement();
 
 	/* Preserve trampoline memory */
@@ -160,18 +167,8 @@ asmlinkage void configure_5level_paging(struct boot_params *bp)
 	 *
 	 * The new page table will be used by trampoline code for switching
 	 * from 4- to 5-level paging or vice versa.
-	 *
-	 * If switching is not required, the page table is unused: trampoline
-	 * code wouldn't touch CR3.
 	 */
 
-	/*
-	 * We are not going to use the page table in trampoline memory if we
-	 * are already in the desired paging mode.
-	 */
-	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
-		goto out;
-
 	if (l5_required) {
 		/*
 		 * For 4- to 5-level paging transition, set up current CR3 as
@@ -194,8 +191,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp)
 		       (void *)src, PAGE_SIZE);
 	}
 
-out:
-	toggle_la57(trampoline_32bit, l5_required);
+	toggle_la57(trampoline_32bit);
 }
 
 void cleanup_trampoline(void *pgtable)
-- 
2.39.2

