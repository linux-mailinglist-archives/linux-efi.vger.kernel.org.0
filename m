Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DC95C0074
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiIUOzy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiIUOzJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:55:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919D92F38D;
        Wed, 21 Sep 2022 07:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 305FEB83016;
        Wed, 21 Sep 2022 14:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1DFC433B5;
        Wed, 21 Sep 2022 14:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772093;
        bh=XGOv1f+E6PQRclir8TXJx9cDwDQezaGlv4nQIiVk7vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoiETaFSwfGSaAXMxwffH9Xxis1cYu8jMM3VSD21rYwOLkhCRBMoYjSw2kp0yhmTQ
         UOAN0EvbOIyq1GEl7hhUal2Hh+a8ZsAWF05by41gbMyiMNZAiQqInwNVRFNnrLFXCA
         8/7G93J73LxoZRLJg5JATSgGLp+FnGHYzI/9k6bfF0CXWzx78I3RcnoUUurEhlb9Me
         4lL7QXASEZfIwX0TlSOCotK1NGVpiBLnyy4ujKyJXfZ/SAz1r0KrlszTGsidNux/4H
         CXa4q/lVPBnkH0AlIvPjGHyX0yslxu9apw6rCYtWhHPXK4MCmk8gs57asm3lSu+/FD
         3fQy6FGrXKSxw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 11/16] x86/compressed: move startup32_load_idt() into .text section
Date:   Wed, 21 Sep 2022 16:54:17 +0200
Message-Id: <20220921145422.437618-12-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2494; i=ardb@kernel.org; h=from:subject; bh=XGOv1f+E6PQRclir8TXJx9cDwDQezaGlv4nQIiVk7vs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWVnp/7Hjms7eUQhcYnrLlxJDyZ+gJO3OZu8xtm WwvUe0CJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYysllQAKCRDDTyI5ktmPJLTvC/ 98A6Cxj06piaelMbbPTO924O3aPixByu15CpFLSTm7st2dVCjR6M+XbGBmbC5FhFk0q7WJqohOcn3B 3Kuv1sUyabIe/lXHlUHiIXa9bBwoH8JtoHPN/qlvpk+wKbr36pruah0bvNkSVz5632Ozd3y91qZay5 iQJ9UZ3h+KDlxpFfggar3TXgltclQmzZlSWnkDye7SglY0W5lVf2pnWuhSC5+XnylBnetQB4QQsf3S tnDYnIgVEFnLQ7pcyfmlJKffAJR7nGTNN3BdrN/gpTSuMP2AbIDDADLgrALU7aDRn4kj8QfiXZ98TV JsnMZMQvlm7v9F745bYlgnSPtyANaeQnbkiDG14XJqWt59runSYtM8BdsiVHG5tpy75zjztt966l+H kyuI18QVhXYXkj9fyzVC4FuKT1GQycCGHpLKm1wEglU75FhyKuv4n4UYehue15SSRCQL9ab0e0xf+L 9z7BtNYmaWy1TSnM0c64NQTtcAAk0MPUtgsAfkRMA+W0Y=
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
 arch/x86/boot/compressed/head_64.S | 29 ++++++++++++++------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a1f893dd5bbf..b4b2b76ed1af 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -118,7 +118,9 @@ SYM_FUNC_START(startup_32)
 1:
 
 	/* Setup Exception handling for SEV-ES */
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 	call	startup32_load_idt
+#endif
 
 	/* Make sure cpu supports long mode. */
 	call	verify_cpu
@@ -719,7 +721,7 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
 #endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	__HEAD
+	.text
 	.code32
 /*
  * Write an IDT entry into boot32_idt
@@ -752,24 +754,32 @@ SYM_FUNC_START_LOCAL(startup32_set_idt_entry)
 
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
@@ -788,6 +798,7 @@ SYM_FUNC_END(startup32_load_idt)
  * succeed. An incorrect C-bit position will map all memory unencrypted, so that
  * the compare will use the encrypted random data and fail.
  */
+	__HEAD
 SYM_FUNC_START(startup32_check_sev_cbit)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	pushl	%eax
-- 
2.35.1

