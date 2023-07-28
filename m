Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E62D766876
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jul 2023 11:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbjG1JNb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jul 2023 05:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbjG1JMm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jul 2023 05:12:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3EE44BF;
        Fri, 28 Jul 2023 02:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD7EE62062;
        Fri, 28 Jul 2023 09:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CFDC433CB;
        Fri, 28 Jul 2023 09:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535447;
        bh=hibE7jKtrMux83Pvwk9QstVTuiv7CM3Jzai9eRpuEP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qI4tofurHWpj9gd8uKwBmHSebcXG++apCwLKaBZQ13xB/1aew+iMV7SlWluBXpteI
         1FPHHuIOuhjAK1Npjtu6v8NwEEnc0AH9vueorM+6jy19HKvYfhDwkqep66dS+X03RO
         SiDb94nW7exxNrhM8gKbzRqSUHKJBwhyjjjybAOaRNWwml8GLMhh8p6o07WKnVzTFJ
         feWeSysdqrft1KqMrFhX089fM1XaOZdyPBMcrBppZEKHo/c5xtqZ5QkW82Lkh1SPK/
         u4nC1WYY0jYqxgxI31VufQs74QFNaBhXKpXnby8JZ4ATU451Th4ZjE4TPAmX9qGwgs
         FW0P+o06KDofg==
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
Subject: [PATCH v7 01/22] x86/decompressor: Don't rely on upper 32 bits of GPRs being preserved
Date:   Fri, 28 Jul 2023 11:08:55 +0200
Message-Id: <20230728090916.1538550-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728090916.1538550-1-ardb@kernel.org>
References: <20230728090916.1538550-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2755; i=ardb@kernel.org; h=from:subject; bh=hibE7jKtrMux83Pvwk9QstVTuiv7CM3Jzai9eRpuEP8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVw6yKWquMJUu4nXVxDzcuZrs58vFdA8P0dxq5LbMasj V/+rmTpKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABORSmZkOCt+59vVK08b99ke 25BSHxxf4rHpX3fnjwUB/0/N7DR1O8jI0PKo8t//d/F32rg2KJ9Lb9CUuN8+R5ZrTSy/k5W32sG NnAA=
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

The 4-to-5 level mode switch trampoline disables long mode and paging in
order to be able to flick the LA57 bit. According to section 3.4.1.1 of
the x86 architecture manual [0], we should not rely on 64-bit GPRs
retaining the upper 32 bits of their contents across such a mode switch.

Given that RBP, RBX and RSI are live at this point, let's preserve them
on the stack, along with the return address that might be above 4G as
well.

[0] Intel® 64 and IA-32 Architectures Software Developer’s Manual, Volume 1: Basic Architecture

  "Because the upper 32 bits of 64-bit general-purpose registers are
   undefined in 32-bit modes, the upper 32 bits of any general-purpose
   register are not preserved when switching from 64-bit mode to a 32-bit
   mode (to protected mode or compatibility mode). Software must not
   depend on these bits to maintain a value after a 64-bit to 32-bit
   mode switch."

Fixes: 194a9749c73d650c ("x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 23 +++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 03c4328a88cbd5d0..f7c11a0018477de8 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -459,11 +459,22 @@ SYM_CODE_START(startup_64)
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
 
+	/* Set up 32-bit addressable stack */
+	leaq	TRAMPOLINE_32BIT_STACK_END(%rcx), %rsp
+
 	/*
-	 * Load the address of trampoline_return() into RDI.
-	 * It will be used by the trampoline to return to the main code.
+	 * Load the address of trampoline_return() into RDI and push it onto
+	 * the stack so it will survive 32-bit truncation due to the 32-bit
+	 * protected mode switch. It will be used by the trampoline to return
+	 * to the main code.
 	 */
 	leaq	trampoline_return(%rip), %rdi
+	pushq	%rdi
+
+	/* Preserve other live 64-bit registers */
+	pushq	%rbp
+	pushq	%rbx
+	pushq	%rsi
 
 	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
 	pushq	$__KERNEL32_CS
@@ -592,9 +603,6 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	%eax, %ds
 	movl	%eax, %ss
 
-	/* Set up new stack */
-	leal	TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
-
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -671,7 +679,10 @@ SYM_CODE_END(trampoline_32bit_src)
 	.code64
 SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
 	/* Return from the trampoline */
-	jmp	*%rdi
+	popq	%rsi
+	popq	%rbx
+	popq	%rbp
+	retq
 SYM_FUNC_END(.Lpaging_enabled)
 
 	/*
-- 
2.39.2

