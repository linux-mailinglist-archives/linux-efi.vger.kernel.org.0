Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14D96340F8
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiKVQKs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiKVQKl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:10:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3CC73429;
        Tue, 22 Nov 2022 08:10:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1787A61791;
        Tue, 22 Nov 2022 16:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAD1C433D7;
        Tue, 22 Nov 2022 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133439;
        bh=KfvrPoaWkzJRvf0XbOy9qU26LYABFuWZ+uOX59kfanM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EK5sUHYbCPyg44a5QEdcfzPTUijM/x+sAhz1052brecEma88JVGdzct71DQVNIMcd
         S6S0S4NqwvlZylQTyj1eY1w5vC34plwGdN0hy5vl7wzSVf4W1RGcdor+W9bG0F+tgz
         pWXvaZ8NAJ1Gm2/v42TRqTiT+dmgMLLYZ08PVVZO+/51GmCT6B+jX5xj+6IVsDKMGW
         VDML93SJ/pB5c8TXzGDO6x+VNkXG52Ss26p7h0w1lUx0+mY3QwZv/LgznxJ0OLyplE
         mlu8owWhf8yMVKo9XtbT8vIvjpowaqKCu24IpVo9Dm7vq0ssJTE9b3M2gTTnKdkAC8
         F/GS9+y5Pi/uA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 03/17] x86/compressed: efi-mixed: move bootargs parsing out of 32-bit startup code
Date:   Tue, 22 Nov 2022 17:10:03 +0100
Message-Id: <20221122161017.2426828-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4635; i=ardb@kernel.org; h=from:subject; bh=KfvrPoaWkzJRvf0XbOy9qU26LYABFuWZ+uOX59kfanM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRShXyE1GvhFiSLXTLUcUldPrqnDBDLhfLxB4Aa F9dYrG+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0UgAKCRDDTyI5ktmPJDu9C/ 9ESxGwyIL6L1ilqx93mfMCQz6rAjCDYRrhkNB15R9N9XJtfEewGixWk2sE8Nac5z/X1RaXXeIs+6O5 TT7RUk2K9mm3lPDk3Vm8jiR7NVu7xV5ZEX9Cus+3y3v9xmUJArOfr7Lv97nrASuJpNG4BPiwDQjXny 2Zk77aQfOVBc3ryGOXWpArOWKQxQBNUeYwWpRX2iGhg8dG4ufZdEt26dAq1MZYW1N8TlmI7R37jaCT b/pZ93YYFPsiyx9IGE0vqBLoxj1FLighmYq0elMdO4OuEAxiMb8/8bLSJfsFokRttwQZL+jemY5Xg5 VK0TH+CzAhq7joaEm+yCczEd6atxKC1EHzgaLpfikCRkHyi6+XsFpBE55awF1zO9MOFvAYRTMWyKRG bhy+2g6Y60Pvf6ACoy0BUfa2fg7QXou6m+5+ayLvapEtWO2+3pglJps9RiikqccJ/CH2dRaxas/XSi oDV1tZpwsg6paewplofTbvLKpxPjNw5cRWRO2gK9nL/a0=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move the logic that chooses between the different EFI entrypoints out of
the 32-bit boot path, and into a 64-bit helper that can perform the same
task much more cleanly. While at it, document the mixed mode boot flow
in a code comment.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 43 ++++++++++++++++++++
 arch/x86/boot/compressed/head_64.S   | 24 ++---------
 2 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 67e7edcdfea8fa44..58ab2e1ffd92afbc 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -22,6 +22,49 @@
 
 	.code64
 	.text
+/*
+ * When booting in 64-bit mode on 32-bit EFI firmware, startup_64_mixed_mode()
+ * is the first thing that runs after switching to long mode. Depending on
+ * whether the EFI handover protocol or the compat entry point was used to
+ * enter the kernel, it will either branch to the 64-bit EFI handover
+ * entrypoint at offset 0x390 in the image, or to the 64-bit EFI PE/COFF
+ * entrypoint efi_pe_entry(). In the former case, the bootloader must provide a
+ * struct bootparams pointer as the third argument, so the presence of such a
+ * pointer is used to disambiguate.
+ *
+ *                                                             +--------------+
+ *  +------------------+     +------------+            +------>| efi_pe_entry |
+ *  | efi32_pe_entry   |---->|            |            |       +-----------+--+
+ *  +------------------+     |            |     +------+----------------+  |
+ *                           | startup_32 |---->| startup_64_mixed_mode |  |
+ *  +------------------+     |            |     +------+----------------+  V
+ *  | efi32_stub_entry |---->|            |            |     +------------------+
+ *  +------------------+     +------------+            +---->| efi64_stub_entry |
+ *                                                           +-------------+----+
+ *                           +------------+     +----------+               |
+ *                           | startup_64 |<----| efi_main |<--------------+
+ *                           +------------+     +----------+
+ */
+SYM_FUNC_START(startup_64_mixed_mode)
+	lea	efi32_boot_args(%rip), %rdx
+	mov	0(%rdx), %edi
+	mov	4(%rdx), %esi
+	mov	8(%rdx), %edx		// saved bootparams pointer
+	test	%edx, %edx
+	jnz	efi64_stub_entry
+	/*
+	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
+	 * shadow space on the stack even if all arguments are passed in
+	 * registers. We also need an additional 8 bytes for the space that
+	 * would be occupied by the return address, and this also results in
+	 * the correct stack alignment for entry.
+	 */
+	sub	$40, %rsp
+	mov	%rdi, %rcx		// MS calling convention
+	mov	%rsi, %rdx
+	jmp	efi_pe_entry
+SYM_FUNC_END(startup_64_mixed_mode)
+
 SYM_FUNC_START(__efi64_thunk)
 	push	%rbp
 	push	%rbx
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 74aaffd22b7425f4..b9dbc8127038c315 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -269,25 +269,9 @@ SYM_FUNC_START(startup_32)
 	 */
 	leal	rva(startup_64)(%ebp), %eax
 #ifdef CONFIG_EFI_MIXED
-	movl	rva(efi32_boot_args)(%ebp), %edi
-	testl	%edi, %edi
-	jz	1f
-	leal	rva(efi64_stub_entry)(%ebp), %eax
-	movl	rva(efi32_boot_args+4)(%ebp), %esi
-	movl	rva(efi32_boot_args+8)(%ebp), %edx	// saved bootparams pointer
-	testl	%edx, %edx
-	jnz	1f
-	/*
-	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
-	 * shadow space on the stack even if all arguments are passed in
-	 * registers. We also need an additional 8 bytes for the space that
-	 * would be occupied by the return address, and this also results in
-	 * the correct stack alignment for entry.
-	 */
-	subl	$40, %esp
-	leal	rva(efi_pe_entry)(%ebp), %eax
-	movl	%edi, %ecx			// MS calling convention
-	movl	%esi, %edx
+	cmpb	$1, rva(efi_is64)(%ebp)
+	je	1f
+	leal	rva(startup_64_mixed_mode)(%ebp), %eax
 1:
 #endif
 	/* Check if the C-bit position is correct when SEV is active */
@@ -787,7 +771,7 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
 SYM_DATA(image_offset, .long 0)
 #endif
 #ifdef CONFIG_EFI_MIXED
-SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
+SYM_DATA(efi32_boot_args, .long 0, 0, 0)
 SYM_DATA(efi_is64, .byte 1)
 
 #define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
-- 
2.35.1

