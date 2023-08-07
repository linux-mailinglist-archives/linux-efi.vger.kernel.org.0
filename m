Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C348F772AA9
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjHGQ1t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjHGQ1s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:27:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D855100;
        Mon,  7 Aug 2023 09:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDE8161F13;
        Mon,  7 Aug 2023 16:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38FDC433C7;
        Mon,  7 Aug 2023 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425666;
        bh=tQS7PfJafJ0SJdxODfB5fN8XXWgLsv+GDbghejqdqVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYwy9WvFTuvl5cBVunKMHcLzSjyW/67eMCxeN4hFvUm1JBkoO55/0wsGin/LMxmAp
         lO+SdCbgpVSPOvJEB8P1Svo1XT7tlrtuft/4PR4AzVg5T59w5g/4MN4INX7Y7RTOUR
         JlyUO9E5vd7el2JlHWQUhg6U6+NBfxP1no5s9vPdjyTtEO9ul9bSIewWY4Dht58/Bk
         HrJG9Zc6Ctlz4siD5N5c7I7ikY1WcLBRt37ZGymo41z0zY4Zw1WcADDz56JVAL0+C6
         frXUZ3H655jN9Sfc7dBN2MBU39DQO5VzrZ36ayze8tAf2UKGvhQyNm5g+K5wolqZMc
         YxJtPmLZEaDjQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v9 02/23] x86/head_64: Store boot_params pointer in callee save register
Date:   Mon,  7 Aug 2023 18:26:59 +0200
Message-Id: <20230807162720.545787-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807162720.545787-1-ardb@kernel.org>
References: <20230807162720.545787-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4192; i=ardb@kernel.org; h=from:subject; bh=tQS7PfJafJ0SJdxODfB5fN8XXWgLsv+GDbghejqdqVE=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWitK+Jo9K/L4/kdh3qjzFri7flm/ayc+u+62bl+3/5n 3zrbqPYUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACay7APD/7R5ARrTQ+p/qeRP 186YHnRn27/IjYr97x5XHJjJ22+TwsnIMN3suLaWpsjb7effZIbmOT1P/1zgEqrof6k1KOu6Pts 3fgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 arch/x86/kernel/head_64.S | 32 ++++++++------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index c5b9289837dcbad2..ea6995920b7aa920 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -51,7 +51,9 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * for us.  These identity mapped page tables map all of the
 	 * kernel pages and possibly all of memory.
 	 *
-	 * %rsi holds a physical pointer to real_mode_data.
+	 * %RSI holds the physical address of the boot_params structure
+	 * provided by the bootloader. Preserve it in %R15 so C function calls
+	 * will not clobber it.
 	 *
 	 * We come here either directly from a 64bit bootloader, or from
 	 * arch/x86/boot/compressed/head_64.S.
@@ -62,6 +64,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * compiled to run at we first fixup the physical addresses in our page
 	 * tables and then reload them.
 	 */
+	mov	%rsi, %r15
 
 	/* Set up the stack for verify_cpu() */
 	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
@@ -75,9 +78,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	shrq	$32,  %rdx
 	wrmsr
 
-	pushq	%rsi
 	call	startup_64_setup_env
-	popq	%rsi
 
 	/* Now switch to __KERNEL_CS so IRET works reliably */
 	pushq	$__KERNEL_CS
@@ -93,12 +94,10 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * Activate SEV/SME memory encryption if supported/enabled. This needs to
 	 * be done now, since this also includes setup of the SEV-SNP CPUID table,
 	 * which needs to be done before any CPUID instructions are executed in
-	 * subsequent code.
+	 * subsequent code. Pass the boot_params pointer as the first argument.
 	 */
-	movq	%rsi, %rdi
-	pushq	%rsi
+	movq	%r15, %rdi
 	call	sme_enable
-	popq	%rsi
 #endif
 
 	/* Sanitize CPU configuration */
@@ -111,9 +110,8 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * programmed into CR3.
 	 */
 	leaq	_text(%rip), %rdi
-	pushq	%rsi
+	movq	%r15, %rsi
 	call	__startup_64
-	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	addq	$(early_top_pgt - __START_KERNEL_map), %rax
@@ -127,8 +125,6 @@ SYM_CODE_START(secondary_startup_64)
 	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 0,
 	 * and someone has loaded a mapped page table.
 	 *
-	 * %rsi holds a physical pointer to real_mode_data.
-	 *
 	 * We come here either from startup_64 (using physical addresses)
 	 * or from trampoline.S (using virtual addresses).
 	 *
@@ -153,6 +149,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR
 
+	/* Clear %R15 which holds the boot_params pointer on the boot CPU */
+	xorq	%r15, %r15
+
 	/*
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
 	 * added to the initial pgdir entry that will be programmed into CR3.
@@ -199,13 +198,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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
@@ -365,9 +360,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	wrmsr
 
 	/* Setup and Load IDT */
-	pushq	%rsi
 	call	early_setup_idt
-	popq	%rsi
 
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
@@ -403,9 +396,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	pushq $0
 	popfq
 
-	/* rsi is pointer to real mode structure with interesting info.
-	   pass it to C */
-	movq	%rsi, %rdi
+	/* Pass the boot_params pointer as first argument */
+	movq	%r15, %rdi
 
 .Ljump_to_C_code:
 	/*
-- 
2.39.2

