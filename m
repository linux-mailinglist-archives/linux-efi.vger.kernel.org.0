Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472555C0079
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiIUOz6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiIUOz1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:55:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0A13C8F0;
        Wed, 21 Sep 2022 07:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B51B9B83034;
        Wed, 21 Sep 2022 14:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BD9C433D7;
        Wed, 21 Sep 2022 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772098;
        bh=x9QO33G0fBHlsuj0aKM/8I+ExRaFzYG1mzjARFUKdJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ewcr9Qou6blbp16BAOckV+lTnOAxrp/LCppV9UzzKOt2fXy/Uomr6shLKwNWYUYxc
         hq9fqz7+/ew/5uF86IyfllLNU+26mZvOtDmI7xlEwbMPRxExCqrAlW5S25udqcwhXS
         t9TmSU8GB57UEo2xlvnvqQrN6E4lLrR50AVegXNqhvU7bgJlx2PtCgIaCaHrQUOouf
         t3zQMS/VQvlqCBFDZXg74rM3ecGDt1NkZUHYKSqC6ss/tA3+e5qoyx46W1TzEwmONg
         HJoOGhw3AF0xBYvUM48HXdLIdxBI5HhG/4qZE3ph2cn0H573i56/u1ijih5phwhSed
         XnnNqGmaVdUrw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 13/16] x86/compressed: move startup32_check_sev_cbit() into .text
Date:   Wed, 21 Sep 2022 16:54:19 +0200
Message-Id: <20220921145422.437618-14-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3026; i=ardb@kernel.org; h=from:subject; bh=x9QO33G0fBHlsuj0aKM/8I+ExRaFzYG1mzjARFUKdJo=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWYJKX7uFQWXpZctogrnphhHrnCH05LWnz8ZuZ1 RZI5PVaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyslmAAKCRDDTyI5ktmPJAcPDA CPpNdahgItmk3RFn+NLP19E2XOFiv7zhzJ8YkkaHjNi3Yx5bpz+TLdt3nZAJ2SsUh39m0fRfY739TK bFzAF9FkJQAOEw+XFkIPzIG9YZKbjdTZjY5AdBw6bYyPR6QtfCauxBFnpE4+3wTiHffXT5M0kpWgyn ejCeRpPqafLj6OvPoGynsWijtjCamIXVghDiVJt8hxotku4enQwP2YQnL6SQiNnrvM33dOeZjchpO3 1NTGyPhWYRV3fyBQtq4Nh9BMHtwL91t3lS6u8T9OUqF5XvudEFzfx/SecrzTvbyGKmWycqr6SHztDY 6/6EXq758Epl9oz435crIz7qNts6fnF+UPz07+0naAWB+qT4rl476oNEQPCs3OPqbwmeawIAxNQvfo m7DHellT6Pcx2M8GCu2HFF87J+fGSiPZtKe9nPPr8XJGQGaZ/AytLXoJyjVBjPxqOFQP6I8vvhzWxe 9RgcJhLDCGAwfE8/50jBP9YxRfzX8lpgJ6rzQle/1Y6V0=
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
index abb5a650a816..639f688e4949 100644
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
@@ -268,8 +273,6 @@ SYM_FUNC_START(startup_32)
 	leal	rva(startup_64_mixedmode)(%ebp), %eax
 1:
 #endif
-	/* Check if the C-bit position is correct when SEV is active */
-	call	startup32_check_sev_cbit
 
 	pushl	$__KERNEL_CS
 	pushl	%eax
@@ -724,16 +727,17 @@ SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
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
 
@@ -748,17 +752,18 @@ SYM_FUNC_START(startup32_check_sev_cbit)
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
@@ -770,13 +775,11 @@ SYM_FUNC_START(startup32_check_sev_cbit)
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

