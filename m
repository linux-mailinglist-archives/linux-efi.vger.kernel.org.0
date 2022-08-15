Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05560593024
	for <lists+linux-efi@lfdr.de>; Mon, 15 Aug 2022 15:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiHONmu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Aug 2022 09:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiHONmo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Aug 2022 09:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E582229A;
        Mon, 15 Aug 2022 06:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9136C60ECD;
        Mon, 15 Aug 2022 13:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAC9C433D7;
        Mon, 15 Aug 2022 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570961;
        bh=iLZ/QdlEqOikKI8mubzHLev1D6XwzdHhOGlBP3RyGSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncQbKvFNR4GvZaQTrJoFL4uwRNOL++xVBJ/gZIPq1GjJ5+pG8NLOyGRDXSn7Krzvh
         QKmddlFBh/KwULsBxFcx8Jk+PNEFUS30iC0MqEARPUN23fdXhuqDnOedRvDKfXaaIa
         eSP+pRcItGRCbmVuhDrHlXekc97HczehZ4FvxmsrVsiRF/1Z62qOD1XM4rHmnN4Jjy
         4n5VDa6s8vgo/DZ4dcEDke+M5SNNfcAT+36OwXdCajEDNq23sPJHaEBjFCHs4bd/qo
         2BI0jh2zOeegjbfzpAFQA8lrOxPzqcrT4s7mhhbLXKfKjTWgXVp0/52Er6Q40BnFa2
         6epOWMCNwTDRw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH 5/6] x86/compressed: adhere to calling convention in get_sev_encryption_bit()
Date:   Mon, 15 Aug 2022 15:42:22 +0200
Message-Id: <20220815134223.740112-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815134223.740112-1-ardb@kernel.org>
References: <20220815134223.740112-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039; i=ardb@kernel.org; h=from:subject; bh=iLZ/QdlEqOikKI8mubzHLev1D6XwzdHhOGlBP3RyGSs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi+k07xFpdATaza7RxA3Aem61HCMPy0ZtsZWGaSeID EMnEt2WJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvpNOwAKCRDDTyI5ktmPJFwHDA Ce2cOoBH2t9EWQu1/TVHav9JmX1u5P6RGZQQKG7TKKIjLM3iOcpjrOdLOCv+CTT5s31G76RCNRlW1Z RvDdc3Uw+uPmCztutDQG3WxpZYMo/ex1ndX281yeHO9Jz1qT69WzX8oR24t6A9rEgX2K0mNJYg7Tuv EnoVTLHmsJtqLcdz82SSzPkuGyb6W2kTf+vbA1VQOPlcHuc+WCvCgzKr9HZyjzhtqHqLL30CTaL/oY m6PxNrj1iEf3ADlBEOf/kqKe059uC1va1bDg21QyXKw4NKZWpvsjFfje/GuwEJLYBhokiSLVWHMS23 +dIlKhuJ+q2hQrTV91TO1Up8KpblLUDJ0GCSVE/eCosoSprxcXw+2viEeh2nI7fnmBgigfYUFs15M9 R59CrDAWInKMdaTPUjoDcpgnBx8QrWLxMpHKkSi338OhuvY/ulfwO1NEnCOekd+DZuOPn13Z7VAjRv lHDWxxiTzQYr2WVvfEjGEUr5XThV3wVFygsayHkHNvrdM=
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

Make get_sev_encryption_bit() follow the ordinary x86 calling
convention, and only call it if CONFIG_AMD_MEM_ENCRYPT is actually
enabled. This clarifies the calling code, and makes it more
maintainable.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S     |  6 ++++--
 arch/x86/boot/compressed/mem_encrypt.S | 10 ----------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 382ed3d8b26a..4539e7c6d4c3 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -180,12 +180,12 @@ SYM_FUNC_START(startup_32)
   */
 	/*
 	 * If SEV is active then set the encryption mask in the page tables.
-	 * This will insure that when the kernel is copied and decompressed
+	 * This will ensure that when the kernel is copied and decompressed
 	 * it will be done so encrypted.
 	 */
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 	call	get_sev_encryption_bit
 	xorl	%edx, %edx
-#ifdef	CONFIG_AMD_MEM_ENCRYPT
 	testl	%eax, %eax
 	jz	1f
 	subl	$32, %eax	/* Encryption bit is always above bit 31 */
@@ -199,6 +199,8 @@ SYM_FUNC_START(startup_32)
 	 */
 	movl	$1, rva(sev_status)(%ebp)
 1:
+#else
+	xorl	%edx, %edx
 #endif
 
 	/* Initialize Page tables to 0 */
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index 3cd3db0da49d..b4a116283bd9 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -21,12 +21,7 @@
 
 	.code32
 SYM_FUNC_START(get_sev_encryption_bit)
-	xor	%eax, %eax
-
-#ifdef CONFIG_AMD_MEM_ENCRYPT
 	push	%ebx
-	push	%ecx
-	push	%edx
 
 	movl	$0x80000000, %eax	/* CPUID to check the highest leaf */
 	cpuid
@@ -57,12 +52,7 @@ SYM_FUNC_START(get_sev_encryption_bit)
 	xor	%eax, %eax
 
 .Lsev_exit:
-	pop	%edx
-	pop	%ecx
 	pop	%ebx
-
-#endif	/* CONFIG_AMD_MEM_ENCRYPT */
-
 	RET
 SYM_FUNC_END(get_sev_encryption_bit)
 
-- 
2.35.1

