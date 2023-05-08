Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628F96FA08C
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 09:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjEHHGC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 03:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjEHHF2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 03:05:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151221A624;
        Mon,  8 May 2023 00:04:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C3A461F94;
        Mon,  8 May 2023 07:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA35C4339E;
        Mon,  8 May 2023 07:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529483;
        bh=pOa0uLaUQL7guzGpAfdDsFjGbf6C6UXPFUPb62ISdKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MV7+bAoMq5TAPFw31XJPnDEkdUatdL34ctMBvUACIDpuRCOIQxcv+cN/fP7ZodXf0
         gOEE+FpmtfxP4aUbUKQeWKvA4ei6eyh1fVC/D7JGOPc6yYKBKoqEZCaWgsl5YTQ9yW
         N/88DSSx10p7kdCFoonhniqFcxDqBFvVi29/SLa54MQp45eXYT1KqZEF/tK86jsno9
         ToHNSl7xjju+mjwvvGVfSe08BXB/s5Rwp2sOFK3wDPbbMikayQZp7EjgP5soEjJMUo
         56dTotecWxzGNGQYRBDrSEqJlRSs4HxPqfc5X/98Dr+kYI4wDUiTA31yguu5keD/nv
         jglyCJqT6Rqrg==
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
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 15/20] x86: head_64: Switch to kernel CS before enabling memory encryption
Date:   Mon,  8 May 2023 09:03:25 +0200
Message-Id: <20230508070330.582131-16-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508070330.582131-1-ardb@kernel.org>
References: <20230508070330.582131-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=ardb@kernel.org; h=from:subject; bh=pOa0uLaUQL7guzGpAfdDsFjGbf6C6UXPFUPb62ISdKo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3p5L2//eS8mLWR1Vc7Go4HNebujRny93XNr8vmr6W nOJ9WcTO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEjt9mZPiyxNAv8PrbkOz5 Ey1z2rK7PW887NTq/fNOhIE1+6u5jC0jwzUfW7MwB4fv+6/4zvfYoHOyTognumiRo2m0bNPrFUs CuAE=
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

The SME initialization triggers #VC exceptions due to the use of CPUID
instructions, and returning from an exception restores the code segment
that was active when the exception was taken.

This means we should ensure that we switch the code segment to one that
is described in the GDT we just loaded before running the SME init code.

Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 95b12fdae10e1dc9..a128ac62956ff7c4 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -76,6 +76,15 @@ SYM_CODE_START_NOALIGN(startup_64)
 
 	call	startup_64_setup_env
 
+	/* Now switch to __KERNEL_CS so IRET works reliably */
+	pushq	$__KERNEL_CS
+	leaq	.Lon_kernel_cs(%rip), %rax
+	pushq	%rax
+	lretq
+
+.Lon_kernel_cs:
+	UNWIND_HINT_END_OF_STACK
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/*
 	 * Activate SEV/SME memory encryption if supported/enabled. This needs to
@@ -87,15 +96,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	sme_enable
 #endif
 
-	/* Now switch to __KERNEL_CS so IRET works reliably */
-	pushq	$__KERNEL_CS
-	leaq	.Lon_kernel_cs(%rip), %rax
-	pushq	%rax
-	lretq
-
-.Lon_kernel_cs:
-	UNWIND_HINT_END_OF_STACK
-
 	/* Sanitize CPU configuration */
 	call verify_cpu
 
-- 
2.39.2

