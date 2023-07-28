Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC74766872
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jul 2023 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjG1JNZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jul 2023 05:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjG1JMo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jul 2023 05:12:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917B33AB1;
        Fri, 28 Jul 2023 02:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2552462086;
        Fri, 28 Jul 2023 09:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D61C433CA;
        Fri, 28 Jul 2023 09:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535476;
        bh=xM6E+o+gqTcjujhtlo5FJ3wiOXU3YYAUj9BM3Rb4ExY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quYWRlcA0de48wcuyoVCBeZSbCV0nbkgmP7mHqKOTNA34UVeqBg8dRYNT5WLSL64A
         PD2J4HbkSyMTSQgXkCmhLwgLdcWcoPCMMz5BN3eCkXkbL+3pSjtNIrubNA6bNGsSVb
         UBFrzKKtkZx6gEihLXXR+M0Fs17R7yEhH21P895framYxBzvJkuhFOsHDtu3mbd0YX
         KbpYlq0YFg1L0AMzPF2ac+COilAgTifv1uKz237RPtxAVxR9Vtgzo148it69XUp7oY
         PXF6zsYDLrJ2WvA9MBOHSsbPi0tMg8kDY0uVfvL3UBvALv3sXcyKi33QGzfRA9jg8Y
         VPdOd1ONtYrUQ==
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
Subject: [PATCH v7 08/22] x86/decompressor: Store boot_params pointer in callee save register
Date:   Fri, 28 Jul 2023 11:09:02 +0200
Message-Id: <20230728090916.1538550-9-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728090916.1538550-1-ardb@kernel.org>
References: <20230728090916.1538550-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4134; i=ardb@kernel.org; h=from:subject; bh=xM6E+o+gqTcjujhtlo5FJ3wiOXU3YYAUj9BM3Rb4ExY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVw6ypTjx+uea7f3USiOCbKtWnZGspLLrHyddqqs+rYi jdaAYwdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCL57xn+mVbvuPFXtTLtd6Xe dR3XuY+WdRyLse2ZIhHMEm8yTyyqhJGh/Yze815XQ+6TWTs77GOCFspcjyoTPXFrrV7gepeOeQX sAA==
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

Instead of pushing and popping %RSI several times to preserve the struct
boot_params pointer across the execution of the startup code, move it
into a callee save register before the first call into C, and copy it
back when needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 38 +++++++-------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index b1367f34e2881fc7..2ccddec2220ce914 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -405,10 +405,14 @@ SYM_CODE_START(startup_64)
 	lretq
 
 .Lon_kernel_cs:
+	/*
+	 * RSI holds a pointer to a boot_params structure provided by the
+	 * loader, and this needs to be preserved across C function calls. So
+	 * move it into a callee saved register.
+	 */
+	movq	%rsi, %r15
 
-	pushq	%rsi
 	call	load_stage1_idt
-	popq	%rsi
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/*
@@ -421,10 +425,8 @@ SYM_CODE_START(startup_64)
 	 * detection/setup to ensure that has been done in advance of any dependent
 	 * code.
 	 */
-	pushq	%rsi
-	movq	%rsi, %rdi		/* real mode address */
+	movq	%r15, %rdi		/* pass struct boot_params pointer */
 	call	sev_enable
-	popq	%rsi
 #endif
 
 	/*
@@ -437,13 +439,9 @@ SYM_CODE_START(startup_64)
 	 *   - Non zero RDX means trampoline needs to enable 5-level
 	 *     paging.
 	 *
-	 * RSI holds real mode data and needs to be preserved across
-	 * this function call.
 	 */
-	pushq	%rsi
-	movq	%rsi, %rdi		/* real mode address */
+	movq	%r15, %rdi		/* pass struct boot_params pointer */
 	call	paging_prepare
-	popq	%rsi
 
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
@@ -461,9 +459,9 @@ SYM_CODE_START(startup_64)
 	pushq	%rdi
 
 	/* Preserve other live 64-bit registers */
+	pushq	%r15
 	pushq	%rbp
 	pushq	%rbx
-	pushq	%rsi
 
 	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
 	pushq	$__KERNEL32_CS
@@ -479,14 +477,9 @@ trampoline_return:
 	 *
 	 * RDI is address of the page table to use instead of page table
 	 * in trampoline memory (if required).
-	 *
-	 * RSI holds real mode data and needs to be preserved across
-	 * this function call.
 	 */
-	pushq	%rsi
 	leaq	rva(top_pgtable)(%rbx), %rdi
 	call	cleanup_trampoline
-	popq	%rsi
 
 	/* Zero EFLAGS */
 	pushq	$0
@@ -496,7 +489,6 @@ trampoline_return:
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
  */
-	pushq	%rsi
 	leaq	(_bss-8)(%rip), %rsi
 	leaq	rva(_bss-8)(%rbx), %rdi
 	movl	$(_bss - startup_32), %ecx
@@ -504,7 +496,6 @@ trampoline_return:
 	std
 	rep	movsq
 	cld
-	popq	%rsi
 
 	/*
 	 * The GDT may get overwritten either during the copy we just did or
@@ -536,30 +527,27 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	shrq	$3, %rcx
 	rep	stosq
 
-	pushq	%rsi
 	call	load_stage2_idt
 
 	/* Pass boot_params to initialize_identity_maps() */
-	movq	(%rsp), %rdi
+	movq	%r15, %rdi		/* pass struct boot_params pointer */
 	call	initialize_identity_maps
-	popq	%rsi
 
 /*
  * Do the extraction, and jump to the new kernel..
  */
-	pushq	%rsi			/* Save the real mode argument */
-	movq	%rsi, %rdi		/* real mode address */
+	movq	%r15, %rdi		/* pass struct boot_params pointer */
 	leaq	boot_heap(%rip), %rsi	/* malloc area for uncompression */
 	leaq	input_data(%rip), %rdx  /* input_data */
 	movl	input_len(%rip), %ecx	/* input_len */
 	movq	%rbp, %r8		/* output target address */
 	movl	output_len(%rip), %r9d	/* decompressed length, end of relocs */
 	call	extract_kernel		/* returns kernel entry point in %rax */
-	popq	%rsi
 
 /*
  * Jump to the decompressed kernel.
  */
+	movq	%r15, %rsi
 	jmp	*%rax
 SYM_FUNC_END(.Lrelocated)
 
@@ -653,9 +641,9 @@ SYM_CODE_END(trampoline_32bit_src)
 	.code64
 SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
 	/* Return from the trampoline */
-	popq	%rsi
 	popq	%rbx
 	popq	%rbp
+	popq	%r15
 	retq
 SYM_FUNC_END(.Lpaging_enabled)
 
-- 
2.39.2

