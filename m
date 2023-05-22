Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC75D70B648
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 09:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjEVHR0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 03:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjEVHQ7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 03:16:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA313198E;
        Mon, 22 May 2023 00:15:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66F3F61DFD;
        Mon, 22 May 2023 07:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219F7C433A1;
        Mon, 22 May 2023 07:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684739748;
        bh=XRnDiVEqXvkUypxOdLrzhfuiI1tjnMjnlxv76SViP7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MeHO95+fyW7ojbM1paHarGzzSqOBIfjxJ+yuheV73DAwvKeV08JYidpNzHaWZwuEg
         JsSeNEaKKmsXAw4HKwtOf5/AbOoeBxeRgkYcrkagdrmYxA8BFQyONaXX9ccphwv/s+
         6Ve8Wrvb5VjOKUh854UpOzm3GlqZavvhxINXZek4X+Aj6O2fKo05MXnihbwHMp/LDW
         8EzhuHUU3XFVvk8yDQ6eMa12fYUToQbz9Xy3WDR+7Su3ITXzfPxAwR0DtgBKBA4gxP
         nJakjQDwZPHQ2RGHwTQvUGfTuf83W4djYeQkiSVqFtAeuDruz1hRuiwhE7+TkmIn47
         MLycnjwgkG3Pg==
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
Subject: [PATCH v3 18/21] x86/head_64: Store boot_params pointer in callee-preserved register
Date:   Mon, 22 May 2023 09:14:12 +0200
Message-Id: <20230522071415.501717-19-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522071415.501717-1-ardb@kernel.org>
References: <20230522071415.501717-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2440; i=ardb@kernel.org; h=from:subject; bh=XRnDiVEqXvkUypxOdLrzhfuiI1tjnMjnlxv76SViP7E=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVbzLlJ7ljnYiGh8BOsHcWd/55eUpsgaWUqviFc6vzTO wrbz1/oKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNpYmb4p5rbsdXfZndEyfJ/ kzQzpFoTKtpDvRQETDetu66UVX7lPMM/g/ezCpJcgz48fdXGI9W4aKn/5k1HdnQf6T4nrar5ZY4 FMwA=
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

Instead of pushing/popping %RSI to/from the stack every time a function
is called from startup_64(), store it in a callee preserved register
and grab it from there when its value is actualled needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index a5df3e994f04f10f..95b12fdae10e1dc9 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -60,6 +60,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * compiled to run at we first fixup the physical addresses in our page
 	 * tables and then reload them.
 	 */
+	mov	%rsi, %r15		/* Preserve boot_params pointer */
 
 	/* Set up the stack for verify_cpu() */
 	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
@@ -73,9 +74,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	shrq	$32,  %rdx
 	wrmsr
 
-	pushq	%rsi
 	call	startup_64_setup_env
-	popq	%rsi
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/*
@@ -84,10 +83,8 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * which needs to be done before any CPUID instructions are executed in
 	 * subsequent code.
 	 */
-	movq	%rsi, %rdi
-	pushq	%rsi
+	movq	%r15, %rdi
 	call	sme_enable
-	popq	%rsi
 #endif
 
 	/* Now switch to __KERNEL_CS so IRET works reliably */
@@ -109,9 +106,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * programmed into CR3.
 	 */
 	leaq	_text(%rip), %rdi
-	pushq	%rsi
 	call	__startup_64
-	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	addq	$(early_top_pgt - __START_KERNEL_map), %rax
@@ -200,10 +195,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * %rsi carries pointer to realmode data and is callee-clobbered. Save
 	 * and restore it.
 	 */
-	pushq	%rsi
 	movq	%rax, %rdi
 	call	sev_verify_cbit
-	popq	%rsi
 
 	/*
 	 * Switch to new page-table
@@ -294,9 +287,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	wrmsr
 
 	/* Setup and Load IDT */
-	pushq	%rsi
 	call	early_setup_idt
-	popq	%rsi
 
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
@@ -334,7 +325,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 	/* rsi is pointer to real mode structure with interesting info.
 	   pass it to C */
-	movq	%rsi, %rdi
+	movq	%r15, %rdi
 
 .Ljump_to_C_code:
 	/*
-- 
2.39.2

