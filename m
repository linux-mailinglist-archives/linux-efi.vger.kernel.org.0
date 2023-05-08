Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA86FA07B
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 09:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjEHHFK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 03:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjEHHEg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 03:04:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B731C0D0;
        Mon,  8 May 2023 00:04:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6315561F93;
        Mon,  8 May 2023 07:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A21BC4339E;
        Mon,  8 May 2023 07:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529449;
        bh=B6tcBjxJdP5tSUcFhPzsS1qpmmFSeFD0AgivQH2wFw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGkYQ1dcY9vkCEigwIpAP4SetJp5ouS4HB3kkMNCHaF3WR4OwzALHjucnzLgwFYFH
         l5Q1OwJP6nXd5Nc5t3s9Sk75H21VD5DLeU42mXS8oXfHHlMnvGP9UGtCyfTJbOh8pF
         xrJ4pI+X56MxLkHdjXe5TIscFo+IbPV0ZyEUJJK+vKygWyK+nAgp8u8JMDG7Z6QbQs
         FK1fd1G7ceMnNa4oFSJWxieTRPPTnDUplGD/3HkDvzABz2hHekcAxuNSX1DuXbSMhR
         jeQTHilekptQEB8ANd2fLJ+VBubZXWPsZ9u+7glYLY2ahMl8tYPgjNSO1pkDY+xc8T
         ltnDOgtqyDXEA==
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
Subject: [PATCH v2 07/20] x86: decompressor: Only call the trampoline when changing paging levels
Date:   Mon,  8 May 2023 09:03:17 +0200
Message-Id: <20230508070330.582131-8-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508070330.582131-1-ardb@kernel.org>
References: <20230508070330.582131-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3661; i=ardb@kernel.org; h=from:subject; bh=B6tcBjxJdP5tSUcFhPzsS1qpmmFSeFD0AgivQH2wFw4=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3qZDmsqVvm9Z8pJSJ76a/7ZgloXwE/X/mYcZBBgOX y8VF9nUUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZyqJ6RYeIx731OO+41O8g8 5Pqq3b5kSUm7aErMdaF3TKt3Ok88MI+R4cyD9ZJHzi/fv9eKWVFl2/HPCYmfWDY0Miw+KceV/Hz vT1YA
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

Since we know the current and desired number of paging levels when
preparing the trampoline, let's not call the trampoline at all when we
know that calling it is not going to result in a change to the number of
paging levels. Given that we are already running in long mode, the PAE
and LA57 settings are necessarily consistent with the currently active
page tables - the only difference is that we will always preserve
CR4.MCE in this case, but this will be cleared by the real kernel
startup code if CONFIG_X86_MCE is not enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 21 +-------------------
 arch/x86/boot/compressed/pgtable_64.c | 18 +++++++----------
 2 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 94b614ecb7c2fd55..ccdfe7e55c36a40f 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -398,10 +398,6 @@ SYM_CODE_START(startup_64)
 	 * For the trampoline, we need the top page table to reside in lower
 	 * memory as we don't have a way to load 64-bit values into CR3 in
 	 * 32-bit mode.
-	 *
-	 * We go though the trampoline even if we don't have to: if we're
-	 * already in a desired paging mode. This way the trampoline code gets
-	 * tested on every boot.
 	 */
 
 	/* Make sure we have GDT with 32-bit code segment */
@@ -563,25 +559,10 @@ SYM_CODE_START(trampoline_32bit_src)
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

