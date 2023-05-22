Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0CC70B635
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjEVHQK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 03:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjEVHPr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 03:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED7118F;
        Mon, 22 May 2023 00:15:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 532D261DD3;
        Mon, 22 May 2023 07:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA83C4339C;
        Mon, 22 May 2023 07:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684739719;
        bh=u+mBV9LASMmynY9CQFGbcEYb3DED+j3/4fMymyiLQXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FyjAA71PYrnpMLQHPHv32CH7/BWCS6DH91r8ny9yChy7sOq8/30xAg760z547M2O5
         YthevGeJ5sdMO7RP0KpjBmHDCZm04SpHkKUXGGPnk1oh093YhuyEgjQbsYhBOFllUy
         hngucDLL8pwjGpkykQX8i/QhwBJRfES+9nDgsMOUkUjJRpT1tU/5p8VxYg/1KTb6DZ
         N/rpOcxxe8by8sDqBShDD0CHILaxXjWD9+EJ4pliMvzYNnCQbekaazrRfrBJ59Ut1T
         QfAGS2j0BtezeMB9Z74qvE1h6+fFWXtuqTyivAbAP7t6DnJzlG0gAYDK2sRSbMCqHR
         ufxYdIy6qrd2A==
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
Subject: [PATCH v3 11/21] x86/decompressor: Only call the trampoline when changing paging levels
Date:   Mon, 22 May 2023 09:14:05 +0200
Message-Id: <20230522071415.501717-12-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522071415.501717-1-ardb@kernel.org>
References: <20230522071415.501717-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3739; i=ardb@kernel.org; h=from:subject; bh=u+mBV9LASMmynY9CQFGbcEYb3DED+j3/4fMymyiLQXA=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVbzMrC9nxPor1CuD6POqfBqxxt7VtsE05xa3y19Hiz8 VL3Y9eOUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJENcxj+2cW3taQ3TdRs3W80 u1L4BD9nxvrHpRFMWyt/C83jrll2jpFhdVCjxOEvb1LvXTrkl1bDI7eq4PSsuY6lJSZ7+I/2FbI wAwA=
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
number of paging levels. Given that the CPU is already running in long
mode, the PAE and LA57 settings are necessarily consistent with the
currently active page tables - the only difference is that CR4.MCE will
always be preserved in this case, but it will be cleared by the real
kernel startup code if CONFIG_X86_MCE is not enabled.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 21 +-------------------
 arch/x86/boot/compressed/pgtable_64.c | 18 +++++++----------
 2 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a60ec9283bd760e3..403c96dae34d9c6d 100644
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
@@ -542,25 +538,10 @@ SYM_CODE_START(trampoline_32bit_src)
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
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index b62b6819dcdd01be..b92cf1d6e156d5f6 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -128,6 +128,13 @@ asmlinkage void set_paging_levels(void *rmode)
 		l5_required = true;
 	}
 
+	/*
+	 * We are not going to use the trampoline if we
+	 * are already in the desired paging mode.
+	 */
+	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
+		return;
+
 	trampoline_32bit = (unsigned long *)find_trampoline_placement();
 
 	/* Preserve trampoline memory */
@@ -155,18 +162,8 @@ asmlinkage void set_paging_levels(void *rmode)
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
@@ -189,7 +186,6 @@ asmlinkage void set_paging_levels(void *rmode)
 		       (void *)src, PAGE_SIZE);
 	}
 
-out:
 	toggle_la57(trampoline_32bit, l5_required);
 }
 
-- 
2.39.2

