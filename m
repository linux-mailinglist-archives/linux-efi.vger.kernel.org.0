Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36E663410D
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiKVQLp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiKVQLU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:11:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5926B73B99;
        Tue, 22 Nov 2022 08:11:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 050F8B81BEE;
        Tue, 22 Nov 2022 16:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB187C433D6;
        Tue, 22 Nov 2022 16:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133461;
        bh=85eC+ySfoxQeQEcBlvmMcXBwdjRppgUeZ0M247EDQDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I//ZrAZmTJ1txf5Y/1fGo5drBOkN5LfXiNxXkPgDHW9xs+Mwma6Paqk0dRAlCMezo
         pJRkZ21Q0uONcvkn6d/29R83VdXOJIZ5IDyBdiZ+bFi9zH+o0hQOIovG2qBMlFt8Ow
         /Ybg6mBDfBFhdxrr2hm8LB4/ZRjA7D2KohdILSamCXkVDX+0FbUVHBlSk52Hq3fd1H
         /kbo3bKmZb2Zot5CW7V1+PAV3P2CwfQgFP2Rzfz2rGCp4NWp2xfWu3a4aivzBaxjdh
         aajqA1Ie9SDomu5DJtlX7uqv2WIR82cU9x6zW+oPYz8v8rwaNFyiedmUdylQTRmELR
         WJRv2ROATtP/Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 13/17] x86/compressed: move startup32_check_sev_cbit() into .text
Date:   Tue, 22 Nov 2022 17:10:13 +0100
Message-Id: <20221122161017.2426828-14-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3035; i=ardb@kernel.org; h=from:subject; bh=85eC+ySfoxQeQEcBlvmMcXBwdjRppgUeZ0M247EDQDM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRhxAUgWKtkqItF3n9UJ4nYtoljvO9zCeQ4S9+k up0wnf+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0YQAKCRDDTyI5ktmPJJBSC/ 9q9Wltr368Rkd3nUNyrxiuLzJKyXgPONP0594v0bUzNK/F5fmL8ncG+SKYY1AkUj8IKUYm+4KGeSb5 jArtd/pqC03Go1JdiIkirTqiT1V+bD/2o1qsBxxe/D+ofktJAzDJ/0Gp2gf9dL/vRiIy4LTubQJoZY Fto2/7imcoAgpHwwoZ8j454Ryp3l3gwT+o+FVTSS2IHGtaW6USmH1VU1cfx21tOmDNbwD7GTNETBls UIW15ILLM/l1vdJBSrQC7Q8mbxv/Lg7ZAubZ4WWj0spI4b8dd5rVu3dOJOk1qdO9O9jsyPJXqVohxW ZXo3TQutG1SGLlQmwOPmklOdmoS0/Z5Kn56dG+S1oOvLaBImwSsETj1Pjsyvmel1nYtC1i4wSTZwe3 MEgLCDcDVeLUjNkvt7Kvb3ddq3Qug+6uD7frW6IEh37/ceW7+sDEG/RmFnGlKHQeEKiU0St7BldID8 a5TfvP5ufkzrtn+N6u7lu3RWn3JcmgwhLEKXvmVc3IQvw=
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

Move startup32_check_sev_cbit() into the .text section and turn it into
an ordinary function using the ordinary 32-bit calling convention,
instead of saving/restoring the registers that are known to be live at
the only call site. This improves maintainability, and makes it possible
to move this function out of head_64.S and into a separate compilation
unit that is specific to memory encryption.

Note that this requires the call site to be moved before the mixed mode
check, as %eax will be live otherwise.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 35 +++++++++++---------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 97b2167f128cbefe..272b2e97456f0dcf 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -259,6 +259,11 @@ SYM_FUNC_START(startup_32)
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
@@ -276,8 +281,6 @@ SYM_FUNC_START(startup_32)
 	leal	rva(startup_64_mixed_mode)(%ebp), %eax
 1:
 #endif
-	/* Check if the C-bit position is correct when SEV is active */
-	call	startup32_check_sev_cbit
 
 	pushl	$__KERNEL_CS
 	pushl	%eax
@@ -732,16 +735,17 @@ SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
  * succeed. An incorrect C-bit position will map all memory unencrypted, so that
  * the compare will use the encrypted random data and fail.
  */
-	__HEAD
-SYM_FUNC_START(startup32_check_sev_cbit)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	pushl	%eax
+	.text
+SYM_FUNC_START(startup32_check_sev_cbit)
 	pushl	%ebx
-	pushl	%ecx
-	pushl	%edx
+	pushl	%ebp
+
+	call	0f
+0:	popl	%ebp
 
 	/* Check for non-zero sev_status */
-	movl	rva(sev_status)(%ebp), %eax
+	movl	(sev_status - 0b)(%ebp), %eax
 	testl	%eax, %eax
 	jz	4f
 
@@ -756,17 +760,18 @@ SYM_FUNC_START(startup32_check_sev_cbit)
 	jnc	2b
 
 	/* Store to memory and keep it in the registers */
-	movl	%eax, rva(sev_check_data)(%ebp)
-	movl	%ebx, rva(sev_check_data+4)(%ebp)
+	leal	(sev_check_data - 0b)(%ebp), %ebp
+	movl	%eax, 0(%ebp)
+	movl	%ebx, 4(%ebp)
 
 	/* Enable paging to see if encryption is active */
 	movl	%cr0, %edx			 /* Backup %cr0 in %edx */
 	movl	$(X86_CR0_PG | X86_CR0_PE), %ecx /* Enable Paging and Protected mode */
 	movl	%ecx, %cr0
 
-	cmpl	%eax, rva(sev_check_data)(%ebp)
+	cmpl	%eax, 0(%ebp)
 	jne	3f
-	cmpl	%ebx, rva(sev_check_data+4)(%ebp)
+	cmpl	%ebx, 4(%ebp)
 	jne	3f
 
 	movl	%edx, %cr0	/* Restore previous %cr0 */
@@ -778,13 +783,11 @@ SYM_FUNC_START(startup32_check_sev_cbit)
 	jmp	3b
 
 4:
-	popl	%edx
-	popl	%ecx
+	popl	%ebp
 	popl	%ebx
-	popl	%eax
-#endif
 	RET
 SYM_FUNC_END(startup32_check_sev_cbit)
+#endif
 
 /*
  * Stack and heap for uncompression
-- 
2.35.1

