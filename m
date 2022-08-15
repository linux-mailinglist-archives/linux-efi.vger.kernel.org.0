Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D0B59301F
	for <lists+linux-efi@lfdr.de>; Mon, 15 Aug 2022 15:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiHONmr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Aug 2022 09:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiHONmm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Aug 2022 09:42:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0C714024;
        Mon, 15 Aug 2022 06:42:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18C41B80EC8;
        Mon, 15 Aug 2022 13:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1736BC43470;
        Mon, 15 Aug 2022 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570958;
        bh=xByW7dV9/cKzhYEh1j47j3lNV6Mk/c8vY36yCmya5aY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZvVtriXIiTjmkFS6s0H0YLJhi9UhLR9VrjjxFykRB6fiT8YxkYzAoUx9pD4e8ypVO
         JnlfXLpFyqXF7/n6xEh6VVtdyojxwC2RitwnuQgm2W4Dz25Mu31+m6jDbtF+AlcB2+
         6blkaAzx9AdKuX6IYPwarNUFp0Tr6gtM8dPGYtmq3814jyZbtg+0RuiaghVx6F+J70
         cMU+6GZBDVrQco24I3im8zJiYwzzLXpAqGOIIsh0DVWU9NhGKokbGS2eURaJ/FE9pE
         Sz0K3c37xgRqYTvMEhGa/OHaDJM+OOlJcaA13dxZ0ragywVoofs9YrK0G+iIHCRCqU
         KXXBuDJdFgJSg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH 4/6] x86/compressed: move startup32_check_sev_cbit out of startup code
Date:   Mon, 15 Aug 2022 15:42:21 +0200
Message-Id: <20220815134223.740112-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815134223.740112-1-ardb@kernel.org>
References: <20220815134223.740112-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6212; i=ardb@kernel.org; h=from:subject; bh=xByW7dV9/cKzhYEh1j47j3lNV6Mk/c8vY36yCmya5aY=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi+k055RbJI1XNVCRt1v3gqLP4M6j3z2aLhOS7EZ1R KrcDYSmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvpNOQAKCRDDTyI5ktmPJNJRDA CFmEczjWHfP1GDyWmA4vUVy22UHzsnTSg8ltznY2f33janw9HPtj92amX4WhnZLDHL/BWkmiA3++Up r0CmZatRl0E2iYUyoTUBqCpbPk+oqMLoPlh1xseLVU39k9WLSfkz4NsdxLTTj9HmMb10aO8EdVCfPE Aj40guOibk08Bpd0xublBYBkbx1tG7xzQdKeouInlrWCLJVNelfiRY4l6rIfOu6iIPo65HF5cOZkF2 GAcCC1A8skSaVQBOPNU5nWgtjnfiZpRzKnGf/MzJ5n33/rHbYubCR01UgWy9klWhbeXPs7QbwquDo8 qQpWHDBQ/210bumlorm/4cMYMBIiHwAiQ1O6cObIa3UJWhk3woEDgaQlhppkgAEKJ8OYA8DUfUXWI1 G0Ns12l9zmzr00410ioghWaK1Dh4RbsRyLbfvIOJUzgjFyr7JDMx117yY8cbh7RggLCWShQ7izgy3Q gCWrPaP17f7OtjCx7+vQTTFT+vnBYcI36LnFAahT5LYuc=
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

Move startup32_check_sev_cbit() out of head_64.S and turn it into an
ordinary function using the ordinary calling conventions, rather than
preserving and restoring the registers that are known to be live at the
call site.

Also reorder the call with the EFI mixed mode check, so we are not
omitting the call to startup32_check_sev_cbit() on mixed mode systems
implicitly, even if the set of machines supporting both features is
empty.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S     | 83 ++------------------
 arch/x86/boot/compressed/mem_encrypt.S | 65 +++++++++++++++
 2 files changed, 70 insertions(+), 78 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1ca2ed52f93c..382ed3d8b26a 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -251,6 +251,11 @@ SYM_FUNC_START(startup_32)
 	movl    $__BOOT_TSS, %eax
 	ltr	%ax
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/* Check if the C-bit position is correct when SEV is active */
+	call	startup32_check_sev_cbit
+#endif
+
 	/*
 	 * Setup for the jump to 64bit mode
 	 *
@@ -266,9 +271,6 @@ SYM_FUNC_START(startup_32)
 	leal	rva(startup_64_mixedmode)(%ebp), %eax
 	jne	1f
 #endif
-	/* Check if the C-bit position is correct when SEV is active */
-	call	startup32_check_sev_cbit
-
 	leal	rva(startup_64)(%ebp), %eax
 1:
 	pushl	$__KERNEL_CS
@@ -703,81 +705,6 @@ SYM_DATA_START(boot_idt)
 	.endr
 SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	__HEAD
-	.code32
-#endif
-
-/*
- * Check for the correct C-bit position when the startup_32 boot-path is used.
- *
- * The check makes use of the fact that all memory is encrypted when paging is
- * disabled. The function creates 64 bits of random data using the RDRAND
- * instruction. RDRAND is mandatory for SEV guests, so always available. If the
- * hypervisor violates that the kernel will crash right here.
- *
- * The 64 bits of random data are stored to a memory location and at the same
- * time kept in the %eax and %ebx registers. Since encryption is always active
- * when paging is off the random data will be stored encrypted in main memory.
- *
- * Then paging is enabled. When the C-bit position is correct all memory is
- * still mapped encrypted and comparing the register values with memory will
- * succeed. An incorrect C-bit position will map all memory unencrypted, so that
- * the compare will use the encrypted random data and fail.
- */
-SYM_FUNC_START(startup32_check_sev_cbit)
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	pushl	%eax
-	pushl	%ebx
-	pushl	%ecx
-	pushl	%edx
-
-	/* Check for non-zero sev_status */
-	movl	rva(sev_status)(%ebp), %eax
-	testl	%eax, %eax
-	jz	4f
-
-	/*
-	 * Get two 32-bit random values - Don't bail out if RDRAND fails
-	 * because it is better to prevent forward progress if no random value
-	 * can be gathered.
-	 */
-1:	rdrand	%eax
-	jnc	1b
-2:	rdrand	%ebx
-	jnc	2b
-
-	/* Store to memory and keep it in the registers */
-	movl	%eax, rva(sev_check_data)(%ebp)
-	movl	%ebx, rva(sev_check_data+4)(%ebp)
-
-	/* Enable paging to see if encryption is active */
-	movl	%cr0, %edx			 /* Backup %cr0 in %edx */
-	movl	$(X86_CR0_PG | X86_CR0_PE), %ecx /* Enable Paging and Protected mode */
-	movl	%ecx, %cr0
-
-	cmpl	%eax, rva(sev_check_data)(%ebp)
-	jne	3f
-	cmpl	%ebx, rva(sev_check_data+4)(%ebp)
-	jne	3f
-
-	movl	%edx, %cr0	/* Restore previous %cr0 */
-
-	jmp	4f
-
-3:	/* Check failed - hlt the machine */
-	hlt
-	jmp	3b
-
-4:
-	popl	%edx
-	popl	%ecx
-	popl	%ebx
-	popl	%eax
-#endif
-	RET
-SYM_FUNC_END(startup32_check_sev_cbit)
-
 /*
  * Stack and heap for uncompression
  */
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index 889450d073ea..3cd3db0da49d 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -241,6 +241,71 @@ SYM_FUNC_START(startup32_load_idt)
 	RET
 SYM_FUNC_END(startup32_load_idt)
 
+/*
+ * Check for the correct C-bit position when the startup_32 boot-path is used.
+ *
+ * The check makes use of the fact that all memory is encrypted when paging is
+ * disabled. The function creates 64 bits of random data using the RDRAND
+ * instruction. RDRAND is mandatory for SEV guests, so always available. If the
+ * hypervisor violates that the kernel will crash right here.
+ *
+ * The 64 bits of random data are stored to a memory location and at the same
+ * time kept in the %eax and %ebx registers. Since encryption is always active
+ * when paging is off the random data will be stored encrypted in main memory.
+ *
+ * Then paging is enabled. When the C-bit position is correct all memory is
+ * still mapped encrypted and comparing the register values with memory will
+ * succeed. An incorrect C-bit position will map all memory unencrypted, so that
+ * the compare will use the encrypted random data and fail.
+ */
+SYM_FUNC_START(startup32_check_sev_cbit)
+	push	%ebp
+	push	%ebx
+
+	call	0f
+0:	pop	%ebp
+
+	/* Check for non-zero sev_status */
+	movl	(sev_status - 0b)(%ebp), %eax
+	testl	%eax, %eax
+	jz	3f
+
+	/*
+	 * Get two 32-bit random values - Don't bail out if RDRAND fails
+	 * because it is better to prevent forward progress if no random value
+	 * can be gathered.
+	 */
+1:	rdrand	%eax
+	jnc	1b
+2:	rdrand	%ebx
+	jnc	2b
+
+	/* Store to memory and keep it in the registers */
+	leal	(sev_check_data - 0b)(%ebp), %ebp
+	movl	%eax, 0(%ebp)
+	movl	%ebx, 4(%ebp)
+
+	/* Enable paging to see if encryption is active */
+	movl	%cr0, %edx			 /* Backup %cr0 in %edx */
+	movl	$(X86_CR0_PG | X86_CR0_PE), %ecx /* Enable Paging and Protected mode */
+	movl	%ecx, %cr0
+
+	cmpl	%eax, 0(%ebp)
+	jne	4f
+	cmpl	%ebx, 4(%ebp)
+	jne	4f
+
+	movl	%edx, %cr0	/* Restore previous %cr0 */
+
+3:	pop	%ebx
+	pop	%ebp
+	RET
+
+4:	/* Check failed - hlt the machine */
+	hlt
+	jmp	4b
+SYM_FUNC_END(startup32_check_sev_cbit)
+
 	.data
 	.balign	8
 SYM_DATA(sme_me_mask,		.quad 0)
-- 
2.35.1

