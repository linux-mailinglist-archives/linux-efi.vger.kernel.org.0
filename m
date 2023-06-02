Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60F771FF32
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 12:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjFBKYu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 06:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjFBKYD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 06:24:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624CC1702;
        Fri,  2 Jun 2023 03:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4E3D64E70;
        Fri,  2 Jun 2023 10:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0E9C4339E;
        Fri,  2 Jun 2023 10:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685701406;
        bh=XRnDiVEqXvkUypxOdLrzhfuiI1tjnMjnlxv76SViP7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nb8cdG+r1sdlV0apRdvce02oohM8CR0EvHFvqpfm3DH1KVSVehy/Y61E+mDv5bwSk
         1QJLdJLsskRV37lIubKeA+HS+dVI1mbbqM8u0VI4gBsDOBBUkjVZPIEk8KR7F37QJy
         URkBtMeAdd2UWM3tRVGrrOvgNZSnqK4dDNQwwJYoiDdKr1qRl1a6hGlIfT/h/CZGnm
         W+qVrZ5ShzYgkKdWTG+okyUaeWW1hqKngGSVk+AcRiVuOYly6dOzXTQsMygjnF2JnS
         RyZgCnMP01HhEshdc0KlTW+ZqtC1Pm8qEZ5mNn8WeodO78hLyudU5Z9LUk0bl9J5LM
         47cC7cpCVk/vA==
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
Subject: [PATCH v4 18/21] x86/head_64: Store boot_params pointer in callee-preserved register
Date:   Fri,  2 Jun 2023 12:13:10 +0200
Message-Id: <20230602101313.3557775-19-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230602101313.3557775-1-ardb@kernel.org>
References: <20230602101313.3557775-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2440; i=ardb@kernel.org; h=from:subject; bh=XRnDiVEqXvkUypxOdLrzhfuiI1tjnMjnlxv76SViP7E=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXywNYmuWOdi4WEwk+wdhR3/nt6SW2CpJWp+IZwqfNP7 yhsP3+ho5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEyk+hQjw9vOUIOu2tWv0vp/ r5AxM1CI1Tl36LvWq2BROx0XY/6ynwz/bHs3vOC5Pbt34irHu60P2mcfEueL2Xs65sCDF2Wn79S tYQQA
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

