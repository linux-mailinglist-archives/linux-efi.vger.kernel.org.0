Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965BA5C007F
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiIUO4X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiIUOzr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:55:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A23B3D5BB;
        Wed, 21 Sep 2022 07:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 85136CE1D97;
        Wed, 21 Sep 2022 14:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE773C4314D;
        Wed, 21 Sep 2022 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772100;
        bh=wGMXGGR/LSLMUL86xmhmJr93fjH2ByIOKwd/q4PBA1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lhz8rM0rsHrh7/NDCcd/kSFYDLk5kzGIlx3MoI97OFyqptKYLFpd76rivLPgBu/3S
         HbGNy6R3j+ClPJskCwX4sK2/9HOSEJzwE8sEvmQx0rae/bT4REp5uAQTRuqhpJKEqB
         7U/aYpMTvkcKLMAd9omVLbRZ7TleNUw4VKI8XhnFPuwK5KDpJuKPW8mFVc5twJYbfc
         thakF3BCyk43rHibvb0dLm2oT3OzDWeHYlG36BxFU0C2vF7wIyOowDHcVjQgt0JzLl
         OroaNy5V9vP5Lnub6+LEcNgPCEDqS4jzOJ++YZF+K6T8QqI7v3YBp26u0gZvHFMV2m
         bdSOPEreB54gw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 14/16] x86/compressed: move startup32_check_sev_cbit() out of head_64.S
Date:   Wed, 21 Sep 2022 16:54:20 +0200
Message-Id: <20220921145422.437618-15-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5275; i=ardb@kernel.org; h=from:subject; bh=wGMXGGR/LSLMUL86xmhmJr93fjH2ByIOKwd/q4PBA1k=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWaPY1SJA8qCJZi2MDi/OmCM8P0Cjs4fG4+n96x wJd0dW+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyslmgAKCRDDTyI5ktmPJAMvDA CvAKgw0ju+TsjnsYBAFzqoCLreVONbNkxrzKXwwSZwrkCOdOA/3j/3fECaKQaiwPIokeINsR7zcYQ4 Z53wbKrFZjQVcpzW3E9+ftmFpR4MkzpdLoSIq+lu9NYH7e1QfOxy0PxbeziKEC8LEOt9vQwDC1qxcn Lv9On4FQofAffNUjY6oVBlU+kKgbu1ldLUIM9xXjwLi6x52SzPuvLydM/rBVzAru/ih6VVrmw8WWaG ThudXRfIMkonMzw8HHbpZiC9v65apPa8HSdkncQj1Dl197ck0V850jYE4325jm05HKx/+3Gx0cpVNJ KfTP+K/kTct2RFzslr8xPIk7UcmbhQRbaDciqLaOwOUd3ge8Qq3XgEy0tVKcPlqmBaIprWsuTzzyF8 GvfwfMQoy1QGFmEFS4O1DVjyoOc/9A3a9Nk+50MsQTR+DRHSuSb/HeNBWW4fjtIhmh9yh/gwDoMgBb UUCKleTQmf1lOAqBMzGWvPBHs2u9uvxjaLqFrFZjlayPE=
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
index 639f688e4949..232cd3fa3e84 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -710,77 +710,6 @@ SYM_DATA_START(boot_idt)
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
index 6747e5e4c696..14cf04a1ed09 100644
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

