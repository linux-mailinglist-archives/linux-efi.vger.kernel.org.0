Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB7C63410E
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiKVQLr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiKVQLU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:11:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6FB74A89;
        Tue, 22 Nov 2022 08:11:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8948461767;
        Tue, 22 Nov 2022 16:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2F6C433C1;
        Tue, 22 Nov 2022 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133463;
        bh=iYbIjrknrGRSBysYjlJW1iQdlzPwOmOOE6edC0L0zHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=InX5b41Lk7aO+j7mr91zm2S094vIgHGRu96RW42bGv7bTu209E7UZ/BemYc3mANJr
         JmVMGJLFjRElkY3sL+cAaHNXRv1ZXmkIiVs8XQzLiLkUiTe8YlV4Vykdomvd0QdcMj
         r5bUYIFsLOCv0dxQo4GetJL75n9C59S+zN/muNWveo9WerIqqca9MSfaJ8t1GUhgoT
         0aYLeI/E9zItK+NIsdTC8YkMdtmPtshl+TQIZQOwNgyeE3CENgcVU0/Jf1k3/aJpja
         OAKGjIjAbBzCR+YERcFP85AxH6IezpgbufDzYWEyFxDtcgZKJoGhCElZCqaaWUlIEA
         3WZfxWT8tVcfA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 14/17] x86/compressed: move startup32_check_sev_cbit() out of head_64.S
Date:   Tue, 22 Nov 2022 17:10:14 +0100
Message-Id: <20221122161017.2426828-15-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5291; i=ardb@kernel.org; h=from:subject; bh=iYbIjrknrGRSBysYjlJW1iQdlzPwOmOOE6edC0L0zHc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRjYXZDaUISly8JZvkN6lWigmkVa29XxkMwdVUp 3JxEe9mJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0YwAKCRDDTyI5ktmPJOWuDA CyuwiYOaZkQCmzL2X7SSqPNjEpNsTbNtIsntl6ESJ6uEYBcUbZEMVksW98EGtXOlE1vRyxi2NgJwML D7Qdtl8+mVR8lXEv12WOXVyz9A38ycBSAt+TLdNlG0mwVyROKiMZflyfNPKGGlwtaaJ2Nryg2ugyKP uTcoBYaLegt4jDGDHWZN66opymyizekQf1qaO9bEiMlfdmbzCAGS/ieTGfLURHwBGDJkuHv27WHWeb gpYgSp39fD1cvY4xckmBwTg5aC+D/QiUQ1xv31X7WBoX5/eFRj7wGdIkwg+5lC1yPDdJyb9DmuVlo9 WRkBAazwQNWbBOhB3aU/aQ6OaAzmCSl9yqECBEAM8PNMX/Ftn/k67FAfLIOCyqlTA0W050mdry+Svn 4q8svDEvfyYTkbOxtGz/b4zQ/3RsoD3BywJdz/tELS3GRYsyjBdOgxr6IMGOqUYmuLOz9WrKIV92GR pfykD6yymOP+I4htLWJP3EKGf/QqtA7ilmrDc05ukFXBs=
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

Now that the startup32_check_sev_cbit() routine can execute from
anywhere and behaves like an ordinary function, we no longer need to
keep it in head_64.S.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S     | 71 --------------------
 arch/x86/boot/compressed/mem_encrypt.S | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 71 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 272b2e97456f0dcf..0cfc8ce273a2731c 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -718,77 +718,6 @@ SYM_DATA_START(boot_idt)
 	.endr
 SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
 
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
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	.text
-SYM_FUNC_START(startup32_check_sev_cbit)
-	pushl	%ebx
-	pushl	%ebp
-
-	call	0f
-0:	popl	%ebp
-
-	/* Check for non-zero sev_status */
-	movl	(sev_status - 0b)(%ebp), %eax
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
-	leal	(sev_check_data - 0b)(%ebp), %ebp
-	movl	%eax, 0(%ebp)
-	movl	%ebx, 4(%ebp)
-
-	/* Enable paging to see if encryption is active */
-	movl	%cr0, %edx			 /* Backup %cr0 in %edx */
-	movl	$(X86_CR0_PG | X86_CR0_PE), %ecx /* Enable Paging and Protected mode */
-	movl	%ecx, %cr0
-
-	cmpl	%eax, 0(%ebp)
-	jne	3f
-	cmpl	%ebx, 4(%ebp)
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
-	popl	%ebp
-	popl	%ebx
-	RET
-SYM_FUNC_END(startup32_check_sev_cbit)
-#endif
-
 /*
  * Stack and heap for uncompression
  */
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index 6747e5e4c696637c..14cf04a1ed091655 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -243,6 +243,74 @@ SYM_FUNC_START(startup32_load_idt)
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
+	pushl	%ebx
+	pushl	%ebp
+
+	call	0f
+0:	popl	%ebp
+
+	/* Check for non-zero sev_status */
+	movl	(sev_status - 0b)(%ebp), %eax
+	testl	%eax, %eax
+	jz	4f
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
+	jne	3f
+	cmpl	%ebx, 4(%ebp)
+	jne	3f
+
+	movl	%edx, %cr0	/* Restore previous %cr0 */
+
+	jmp	4f
+
+3:	/* Check failed - hlt the machine */
+	hlt
+	jmp	3b
+
+4:
+	popl	%ebp
+	popl	%ebx
+	RET
+SYM_FUNC_END(startup32_check_sev_cbit)
+
 	.code64
 
 #include "../../kernel/sev_verify_cbit.S"
-- 
2.35.1

