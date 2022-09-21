Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37CB5C005E
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiIUOys (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiIUOyk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:54:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848FE64CA;
        Wed, 21 Sep 2022 07:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0DD4B82FFB;
        Wed, 21 Sep 2022 14:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD05C43470;
        Wed, 21 Sep 2022 14:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772075;
        bh=f4hAaP+nZQiGjfEdHOfloyDSCBg7MiQpQpgjB8eSSLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qx9uT5gdNAZ+8XcoMzrMKWSAxEYyRB4B05jTvbm2uNa+xui/lTdSXF7GX2N+QE2Nv
         rlNtBzUgbF1wE249SbfGb/sTZTwWyZlwPLt2WalBpsbchtLRIPjrADCNTUM0b3Dc+8
         SGJFeMGzNj7m5nAImxr5HUdUqbONIZ/rlfdL8L0Vma4XNYL56ovesZtVVxZoSSQvVF
         eW+5PgrZt1yIXnJWCHeVeWuB7M3AusvsnO801MCiS2ghe+33qldA0k1EXGLuRtuZJP
         SwDTHEk1bHMBljSqxwglw8Gov6nisAvPOXSjUFZxqrJYteOJjn83WBAukIBigv+ziO
         H9o+eeqFTRKYA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 03/16] x86/compressed: efi-mixed: move bootargs parsing out of 32-bit startup code
Date:   Wed, 21 Sep 2022 16:54:09 +0200
Message-Id: <20220921145422.437618-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4615; i=ardb@kernel.org; h=from:subject; bh=f4hAaP+nZQiGjfEdHOfloyDSCBg7MiQpQpgjB8eSSLU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWHvdK1Lg7oMDR8exKa/vsM1svazbixC/Fq3jBe 9YXmSZeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyslhwAKCRDDTyI5ktmPJI8sDA CV2vV5iKwTQSd3XuGdHUY3eNptgd3hcn7rkx9I5PiI/RkRGuE21kgPg6OGcWgwQSL1kYjR7AxVKulD nU8x7L3wXd0By0CUqGqpxKCHX2Bg6R31HGjp7a9SPxNOnU5LRjPBiQ61IVgvFq8kKDsMCOrArnq8dY 7hdwOAXpwf30+QtJhAS3vE8BdQw9dbn8jeC2YpyI0hqkgwNPXBYKY+P4whsqlHxdtZyIXdAs8liTHD nbBn4OgagUSlgPsmVokLzEsQBe4QSjbd+Set1C/8EV5bNK0Sbjy/CdCdHy78leCaWgoGdvEULYdYh+ MIbsdcTfoYZ7H+4yFe+qz/dpJ3UBg/f5CHe5i/L2qqaRyXAn+eepLsqiCL74JjuncQSY/ok7RjVGWH 4q9j91L1uiiwO6VhbXbaAJ5da4750Y4wUk8rD5lmhlil/FqETbKf0X+GXU27ZEyF5M5lyKVuiekRJ7 Hz6qtIErrWzhNQRIYDIE0atcmhj1BqlhYzsoHTsr9V+so=
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
index 67e7edcdfea8..77e77c3ea393 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -22,6 +22,49 @@
 
 	.code64
 	.text
+/*
+ * When booting in 64-bit mode on 32-bit EFI firmware, startup_64_mixedmode()
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
+ *  +------------------+     |            |     +------+---------------+   |
+ *                           | startup_32 |---->| startup_64_mixedmode |   |
+ *  +------------------+     |            |     +------+---------------+   V
+ *  | efi32_stub_entry |---->|            |            |     +------------------+
+ *  +------------------+     +------------+            +---->| efi64_stub_entry |
+ *                                                           +-------------+----+
+ *                           +------------+     +----------+               |
+ *                           | startup_64 |<----| efi_main |<--------------+
+ *                           +------------+     +----------+
+ */
+SYM_FUNC_START(startup_64_mixedmode)
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
+SYM_FUNC_END(startup_64_mixedmode)
+
 SYM_FUNC_START(__efi64_thunk)
 	push	%rbp
 	push	%rbx
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1ba2fc2357e6..b51f0e107c2e 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -261,25 +261,9 @@ SYM_FUNC_START(startup_32)
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
+	leal	rva(startup_64_mixedmode)(%ebp), %eax
 1:
 #endif
 	/* Check if the C-bit position is correct when SEV is active */
@@ -766,7 +750,7 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
 SYM_DATA(image_offset, .long 0)
 #endif
 #ifdef CONFIG_EFI_MIXED
-SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
+SYM_DATA(efi32_boot_args, .long 0, 0, 0)
 SYM_DATA(efi_is64, .byte 1)
 
 #define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
-- 
2.35.1

