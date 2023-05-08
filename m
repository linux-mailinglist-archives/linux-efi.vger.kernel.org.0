Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974BF6FA08A
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 09:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjEHHF6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 03:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjEHHFP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 03:05:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FBC1A1E3;
        Mon,  8 May 2023 00:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE58661F98;
        Mon,  8 May 2023 07:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874FEC433EF;
        Mon,  8 May 2023 07:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529479;
        bh=RgKaN65vbfxpRIG/ejUZYCBYrcPUPZF6ystsCPDQ7Rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3LlLuRVN5uMD2fd8UqcE3lOgORz52I9N0Ssuenr3NCowef4f5wnza2DbafUlNOUe
         AjWBZNvockmtJT4Ioz5W/uzfqjrUZdAruuQnJoj1eX2QNaveDHymG39BcjTIhfS/sQ
         VpJFvUzeVAwXMjBKkQOkv7tlLeKusrZA8YFbFeHBzV7/YMzKah/D0gCuBdNKlB+pCf
         T2BUnMPE54o/6FzoIa4lOQeDeVbRm2DUObmEYBQPhllhSYAzKn/JR2U2SrhnfuI3rj
         llMFHcInfOBTpMLyHWY05znOYxJUZOSRzMi0WZ3zhJo3Aeg0U0WaTUxyfhx+tO0FH1
         3RFCrdi1qQytA==
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
Subject: [PATCH v2 14/20] x86: head_64: Store boot_params pointer in callee-preserved register
Date:   Mon,  8 May 2023 09:03:24 +0200
Message-Id: <20230508070330.582131-15-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508070330.582131-1-ardb@kernel.org>
References: <20230508070330.582131-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417; i=ardb@kernel.org; h=from:subject; bh=RgKaN65vbfxpRIG/ejUZYCBYrcPUPZF6ystsCPDQ7Rc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3m6fqRP3JLw1t71ma9maM/n/Ff/Jn8+XVdzWdMvXt ulgfJvTUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACai8J3hv+crjTrDVTZdTrI1 PuG+Kz1Fj6yweTf/6PMTRmq+3Vcqoxj+GQWmNnOvsFm+O7DkfhUTzzLD/xbBoc2/Q1dV9naVuvz mAwA=
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

Instead of pushing/popping %RSI to/from the stack every time we call a
function from startup_64(), just store it in a callee preserved register
until we're ready to pass it on.

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

