Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAF374E9FA
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jul 2023 11:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjGKJPK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jul 2023 05:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjGKJPJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jul 2023 05:15:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B5BB7;
        Tue, 11 Jul 2023 02:15:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1C4461418;
        Tue, 11 Jul 2023 09:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796F8C433CB;
        Tue, 11 Jul 2023 09:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689066907;
        bh=LsonN6EFYWNHTyh2VqSp3Tgm/usNg6vNJvM1yGPTkDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5gTkJgTcZyBE6WO2hR9BtcFv3Wxra0x1YA5agVtnim2pm174Jv6cvgqidixim+hb
         2Nu3A86ydag0JiG5NgkJZDkeAcuW4KJv2Rwr39XwaG71CPod/IdaJuJoH389/kTtxb
         niOGduStgdf9qftLpp+1A/wG366GeBsaOgAk2U3ONXMGGrzPO5kZRjG767fexC1GvJ
         EHz9qIx3tINKe9o95O4Giaz8fQSzj6+pU/UOfK/1bnKI4yCyxoEkXjc47n8tT3Ha3+
         5DowCpDRKShTJRzbZZxcs8oDkl8xx5OF/KafjFgqnc5RJsS0ez7JgM30lk5roIuZHx
         3GUGGCrSlhYtg==
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
Subject: [PATCH v6 01/21] x86/head_64: Store boot_params pointer in callee save register
Date:   Tue, 11 Jul 2023 11:14:33 +0200
Message-Id: <20230711091453.2543622-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711091453.2543622-1-ardb@kernel.org>
References: <20230711091453.2543622-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3709; i=ardb@kernel.org; h=from:subject; bh=LsonN6EFYWNHTyh2VqSp3Tgm/usNg6vNJvM1yGPTkDk=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWWtbLnWtPwJbkICW6cf2GB7KMm3Sdl+mnDfnZq+vtN3l qq9jb/eUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaidY6R4eMbn50Btb+kFi8z 3PogQGHfomXJ7ZN7Ip02p3x/X75rHS8jw12bCerVzg+k2/vW5U2/9N8krqDFxShjA7t3nszKMyF LmAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of pushing/popping %RSI to/from the stack every time a function
is called from startup_64(), store it in callee preserved register R15
and grab it from there when its value is actually needed.

Secondary boot does not and should not care about the value of %RSI at
entry, and all the C handlers except the primary boot C entrypoint all
ignore the function arguments entirely. Avoid inadvertent surprises by
zeroing R15 on the secondary boot path explicitly.
 
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 23 +++++---------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index c5b9289837dcbad2..dbc80fe098f86860 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -62,6 +62,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * compiled to run at we first fixup the physical addresses in our page
 	 * tables and then reload them.
 	 */
+	mov	%rsi, %r15		/* Preserve boot_params pointer */
 
 	/* Set up the stack for verify_cpu() */
 	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
@@ -75,9 +76,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	shrq	$32,  %rdx
 	wrmsr
 
-	pushq	%rsi
 	call	startup_64_setup_env
-	popq	%rsi
 
 	/* Now switch to __KERNEL_CS so IRET works reliably */
 	pushq	$__KERNEL_CS
@@ -95,10 +94,8 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * which needs to be done before any CPUID instructions are executed in
 	 * subsequent code.
 	 */
-	movq	%rsi, %rdi
-	pushq	%rsi
+	movq	%r15, %rdi		/* Pass boot_params pointer */
 	call	sme_enable
-	popq	%rsi
 #endif
 
 	/* Sanitize CPU configuration */
@@ -111,9 +108,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * programmed into CR3.
 	 */
 	leaq	_text(%rip), %rdi
-	pushq	%rsi
 	call	__startup_64
-	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	addq	$(early_top_pgt - __START_KERNEL_map), %rax
@@ -127,8 +122,6 @@ SYM_CODE_START(secondary_startup_64)
 	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 0,
 	 * and someone has loaded a mapped page table.
 	 *
-	 * %rsi holds a physical pointer to real_mode_data.
-	 *
 	 * We come here either from startup_64 (using physical addresses)
 	 * or from trampoline.S (using virtual addresses).
 	 *
@@ -153,6 +146,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR
 
+	xorq	%r15, %r15		/* Clear boot_params pointer */
+
 	/*
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
 	 * added to the initial pgdir entry that will be programmed into CR3.
@@ -199,13 +194,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * hypervisor could lie about the C-bit position to perform a ROP
 	 * attack on the guest by writing to the unencrypted stack and wait for
 	 * the next RET instruction.
-	 * %rsi carries pointer to realmode data and is callee-clobbered. Save
-	 * and restore it.
 	 */
-	pushq	%rsi
 	movq	%rax, %rdi
 	call	sev_verify_cbit
-	popq	%rsi
 
 	/*
 	 * Switch to new page-table
@@ -365,9 +356,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	wrmsr
 
 	/* Setup and Load IDT */
-	pushq	%rsi
 	call	early_setup_idt
-	popq	%rsi
 
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
@@ -403,9 +392,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	pushq $0
 	popfq
 
-	/* rsi is pointer to real mode structure with interesting info.
-	   pass it to C */
-	movq	%rsi, %rdi
+	movq	%r15, %rdi		/* Pass boot_params pointer */
 
 .Ljump_to_C_code:
 	/*
-- 
2.39.2

