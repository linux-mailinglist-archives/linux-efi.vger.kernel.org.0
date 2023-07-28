Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAE6766873
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jul 2023 11:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjG1JN0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jul 2023 05:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjG1JMm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jul 2023 05:12:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618FB3AA9;
        Fri, 28 Jul 2023 02:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F142F62065;
        Fri, 28 Jul 2023 09:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F004C433CA;
        Fri, 28 Jul 2023 09:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535451;
        bh=GiCy7yIiezNP9O3s2voCLFojzJjs56vFwR7z8S7pXpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejm2ZqqV2sV+JVX0EmkKX6NmyvVhfNnNfjDfMG8QzrqsepyoZFerNUozj0v4F8sUs
         keBHZBco8bL+Tt/kFAEpUYYXvHDF9rJocmkFqQYa7vsfAWeNpN/UBu8o2o+KwVywME
         gr2aw+KeHlFD9k+JQb36WFR03e46s6eCbUEKteI9KV4GiKS/BTafVoVJLZzcWRoUsW
         unj5cVKwKck6RDFIdUmhiIEzbH79TSMIivnUCMSV46mF7470IGned26agJ7LSLGN20
         edGEic9x/JmLDkQ2xzJDwMLD9ylX2WSLbQKQGfjB1XsltBR8UkWYpbeGN3iaZiB9fi
         N+i/hToNeWPEQ==
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
Subject: [PATCH v7 02/22] x86/head_64: Store boot_params pointer in callee save register
Date:   Fri, 28 Jul 2023 11:08:56 +0200
Message-Id: <20230728090916.1538550-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728090916.1538550-1-ardb@kernel.org>
References: <20230728090916.1538550-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3436; i=ardb@kernel.org; h=from:subject; bh=GiCy7yIiezNP9O3s2voCLFojzJjs56vFwR7z8S7pXpQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVw6+IPHMILpyvPdZAR4xXfPqdcweD8jAeMGRFMfDc2P 5L9yc7bUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbC2cTIsEh6Y3PpqoUiW1M2 VrauKlkZ/HDy6pqrXlf7+iZoebSLfWD4K8i6St9L4iHbNi71ZfIz9liws5y6Ej7dodx7osm3Ze2 S3AA=
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

Instead of pushing/popping %RSI to/from the stack every time a function
is called from startup_64(), store it in a callee preserved register
and grab it from there when its value is actually needed.

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

