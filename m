Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B07176686A
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jul 2023 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjG1JNU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jul 2023 05:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbjG1JMu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jul 2023 05:12:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959C83C0A;
        Fri, 28 Jul 2023 02:11:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 266B762080;
        Fri, 28 Jul 2023 09:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A56C433CB;
        Fri, 28 Jul 2023 09:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535497;
        bh=x7sq9MvecxCTDjHprBemwXOtByORtVHSFTMbKWRJUyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHfSKeDgIe+oX5c+31tp/kKxwQSI0AFG6hP+MTiJz/VtBXwwZwkRxmwIvahn8HvYR
         iNOwf1zyRTlD0f9nIBr77BDaHWz3v7LbcVdg0NWs3lEUb80X3Y7TDOVi3U3rANmAjE
         XQ0U/ZZplSofrLmiyA2aedQHOiSnNpwROjVDMiQykqZcI3N6CrTtMAeh1Z36Mg/Sgq
         BJMrDYbPqw5p0Y9apMR5ixq/JANyTnLeAWRBOxyIXu7z4nLcmLCeyzF2DIbC2SYgAF
         Hb+oDz7X5jv7/W3hUl4oKuPYvfW2YLb4nCVWnSt0QCH0uH093UqSeULrGRJ8hhdytP
         ItZtcWBYe0AlA==
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
Subject: [PATCH v7 13/22] x86/decompressor: Only call the trampoline when changing paging levels
Date:   Fri, 28 Jul 2023 11:09:07 +0200
Message-Id: <20230728090916.1538550-14-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728090916.1538550-1-ardb@kernel.org>
References: <20230728090916.1538550-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3740; i=ardb@kernel.org; h=from:subject; bh=x7sq9MvecxCTDjHprBemwXOtByORtVHSFTMbKWRJUyo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVw64Ys35j1/Bsl/k/aFeF/q//Z6Y15ngpxS8WOenDss qxza73VUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYyaxvDb/Y/hl8WR/GuW3Mi SfiGiHr9wiOOp97O7RUqTL12ca50kwQjwx6OXQyJM0p3botyEO0zEfkfcndLpX6Dkyab8mnNA3+ y2AA=
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
index 3f38db557112c155..88b5e45b8ecb490b 100644
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
@@ -564,25 +560,10 @@ SYM_CODE_START(trampoline_32bit_src)
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
index 649c51935fdec7ef..4016444e6788304f 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -128,6 +128,13 @@ asmlinkage void set_paging_levels(void *rmode)
 		l5_required = true;
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

