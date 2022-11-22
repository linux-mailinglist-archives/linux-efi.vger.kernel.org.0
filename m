Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2E863410A
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiKVQLm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiKVQLK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:11:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04194748FB;
        Tue, 22 Nov 2022 08:11:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85C39B81C13;
        Tue, 22 Nov 2022 16:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E52EC433C1;
        Tue, 22 Nov 2022 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133457;
        bh=SrH5jbYTxjPDhorKLJI/pQ/HZBcFhclTx5SIgKR45/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9Ejx0kbSXA96CEjy61IkPDqpmm1iw1V1KwL0o2BrG4acpyUjnYU9usTt6Ls8cLzD
         kMlFz8uxuQ6dZg87fNyuT0XWjepFVa2cyw6oM1OfAVOqlZ805x2tFTuC3g5ZkZ5iPy
         YBNDpze0/sxPDOrc4iRNXj87GS46gTDMSKudG7AxDcJX3Ndofcmsk2ve1HVVNDiMBE
         1iH8VIlxbPJqRATMm90hIlBRSKyQrTE+XiMnNwPSAVPSlfEDS20au70UuKKV9bKyuY
         gKYePZbTQ+MwyLH12YPPBIVy40anPo86w4EKJhWO9f2kzjFsgHQxaZmPBjhAXjhf8f
         xaOwx+Iv2igHw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 11/17] x86/compressed: move startup32_load_idt() into .text section
Date:   Tue, 22 Nov 2022 17:10:11 +0100
Message-Id: <20221122161017.2426828-12-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2553; i=ardb@kernel.org; h=from:subject; bh=SrH5jbYTxjPDhorKLJI/pQ/HZBcFhclTx5SIgKR45/I=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRegW+LXkyS9XpbbTToVmr/bYaRmK4xRgfZVjFu VylwNGuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0XgAKCRDDTyI5ktmPJPAbDA C1qWwSmTQMOLDl4vc3rYbsHc2TXkRVTM6lA1KrxI5apzzolEqlcBxQp7wlhWptFkcUfEl0u+eeFjK6 vqr+IMvzXMi3jC7BUkDw/FtaqOUhnJk4bFhgxcE36OqHyPrPDNh9iDUHjvGYpLZcQhyn128xnRxv18 Al1yWVFu3MisoXr4ZqRo3rkOvjrsNYLfVsTn6y3+kjr5msePHR5qxALRb9z/NClK/JYafkS8sFvRrN A3Nv9GhYBoR92f2W2hCM8zYUtdCXM2MsVwW3VBKcyBgHQROshPacOUXj3CYLhHcwJ7CMMpgBAQwMQG lVXjXzBtq16sj8KLefvjpeD256WhOa9kTr3m5RRhaI9P70TzkQcF0EHsd7MjPnvOI8Jkc1T/qkYRbA CYxgX+Nlq8EyMOD1Lfz5niaZG3m3sIPPh8vsnTDpju0EjAmvYDJNJYRb+h3pwazRvVUBU27kS+Kv2g Mz2MqRTCxZNCOgDxgYi4ANIbp3NLlBxa8IFHWUIcU2cmk=
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

Convert startup32_load_idt() into an ordinary function and move it into
the .text section. This involves turning the rva() immediates into ones
derived from a local label, and preserving/restoring the %ebp and %ebx
as per the calling convention.

Also move the #ifdef to the only existing call site. This makes it clear
that the function call does nothing if support for memory encryption is
not compiled in.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 31 +++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 82d7fab99422129f..2d42852d5b828209 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -126,7 +126,9 @@ SYM_FUNC_START(startup_32)
 1:
 
 	/* Setup Exception handling for SEV-ES */
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 	call	startup32_load_idt
+#endif
 
 	/* Make sure cpu supports long mode. */
 	call	verify_cpu
@@ -724,10 +726,8 @@ SYM_DATA_START(boot32_idt)
 	.quad 0
 	.endr
 SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
-#endif
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	__HEAD
+	.text
 	.code32
 /*
  * Write an IDT entry into boot32_idt
@@ -760,24 +760,32 @@ SYM_FUNC_START_LOCAL(startup32_set_idt_entry)
 
 	RET
 SYM_FUNC_END(startup32_set_idt_entry)
-#endif
 
 SYM_FUNC_START(startup32_load_idt)
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	leal    rva(boot32_idt)(%ebp), %ecx
+	push	%ebp
+	push	%ebx
+
+	call	1f
+1:	pop	%ebp
+
+	leal    (boot32_idt - 1b)(%ebp), %ebx
 
 	/* #VC handler */
-	leal    rva(startup32_vc_handler)(%ebp), %eax
+	leal    (startup32_vc_handler - 1b)(%ebp), %eax
 	movl    $X86_TRAP_VC, %edx
+	movl	%ebx, %ecx
 	call    startup32_set_idt_entry
 
 	/* Load IDT */
-	leal	rva(boot32_idt)(%ebp), %eax
-	movl	%eax, rva(boot32_idt_desc+2)(%ebp)
-	lidt    rva(boot32_idt_desc)(%ebp)
-#endif
+	leal	(boot32_idt_desc - 1b)(%ebp), %ecx
+	movl	%ebx, 2(%ecx)
+	lidt    (%ecx)
+
+	pop	%ebx
+	pop	%ebp
 	RET
 SYM_FUNC_END(startup32_load_idt)
+#endif
 
 /*
  * Check for the correct C-bit position when the startup_32 boot-path is used.
@@ -796,6 +804,7 @@ SYM_FUNC_END(startup32_load_idt)
  * succeed. An incorrect C-bit position will map all memory unencrypted, so that
  * the compare will use the encrypted random data and fail.
  */
+	__HEAD
 SYM_FUNC_START(startup32_check_sev_cbit)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	pushl	%eax
-- 
2.35.1

