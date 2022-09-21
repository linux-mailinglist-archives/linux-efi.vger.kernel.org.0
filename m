Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59CC5C007C
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiIUO4D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiIUOzn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:55:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18681834C;
        Wed, 21 Sep 2022 07:55:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A981F630B4;
        Wed, 21 Sep 2022 14:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40560C433B5;
        Wed, 21 Sep 2022 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772103;
        bh=WbgVHaEsv5DRy1pEnyeBQ/OqX8UNa7Fs1hsnZgK0mbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2bc0kbCvcuAPSActZg/u0iWc9IK+6wA6qp3E6RksO7tBA12uIpO8X6MVHspBtSs8
         AuBdbZoSJ3cu8I0ThN0e0RLbPoss8DZNUdKSVs5eh9fcpaF6YzijJapfB6Psuv4xLD
         hcitweaOVUCj22DCGCTE+HRNZN7OdlQXL+7O9TFuVnG3qcCfof4xiKZNsfs/LEEP3D
         A/ocLuRwUfyCi+ypkK6V1FGPXRFO7Ya+LG4lTnDo2N3dUTM7AzTMbiyQ9J+8qUvbpg
         obfaDAOAH72/yVUhdnW6Pe3sk15SHpSIwlwY5Hhld85X2LS/xfRAVnJR28+5rg2DIw
         jYwuPapccNYPg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 15/16] x86/compressed: adhere to calling convention in get_sev_encryption_bit()
Date:   Wed, 21 Sep 2022 16:54:21 +0200
Message-Id: <20220921145422.437618-16-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=ardb@kernel.org; h=from:subject; bh=WbgVHaEsv5DRy1pEnyeBQ/OqX8UNa7Fs1hsnZgK0mbI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWcevoeMnFcfMXlfXHL30Iq3+wkmMmF/rwOYRei I6uhA3WJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyslnAAKCRDDTyI5ktmPJCUmC/ 9PIkfSMlPNkplXoVMIGJv1kha8yGwZcGkLAusvMD/tOWh7GhO77LFwxHgAdqqGV++BRskKw5CCpR7p kyWMqZVadBPVk36naHLD3eOwi1pI7IAbYVc8aCkY77OFZxd9kzWcfRzGNzQlrWo6tx1uFdV8q+jjIm VRdWFfI7z2vsnM28gg+DGlw+N1vPCJJ/V6tSqITg7aXuK7JHJW0Zjs5iz13DhC78gBaq4B+canV6Ps Uz/o/bt1X7suyIJA7CmCWMLr2bN4W7m99J/DCq2JiiU0Ilz0FCg9zDn18ssoIW5+QbSwP75WsTgNE7 aEPXOzap/8hRadAa6Cwr2Vy83CnkLPDmRFkJ0UOH5vRQ5c+ULFyYO9v4E8neTxCMNSmSDLdHsviI8x TXlfNp6egbZhFIxAufVJo1szP2/laiYOA22vETgDaCZGLyKWgh5bRxBkaIXOTNrvFmdaYFfZImsBqS hw262c2MifxwvCyt7C6xe7QVB+Nf5ox3Uie/lMPEtiQQA=
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

Make get_sev_encryption_bit() follow the ordinary i386 calling
convention, and only call it if CONFIG_AMD_MEM_ENCRYPT is actually
enabled. This clarifies the calling code, and makes it more
maintainable.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S     |  5 +++--
 arch/x86/boot/compressed/mem_encrypt.S | 10 ----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 232cd3fa3e84..a7bbc8d73a08 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -180,12 +180,13 @@ SYM_FUNC_START(startup_32)
   */
 	/*
 	 * If SEV is active then set the encryption mask in the page tables.
-	 * This will insure that when the kernel is copied and decompressed
+	 * This will ensure that when the kernel is copied and decompressed
 	 * it will be done so encrypted.
 	 */
-	call	get_sev_encryption_bit
 	xorl	%edx, %edx
 #ifdef	CONFIG_AMD_MEM_ENCRYPT
+	call	get_sev_encryption_bit
+	xorl	%edx, %edx
 	testl	%eax, %eax
 	jz	1f
 	subl	$32, %eax	/* Encryption bit is always above bit 31 */
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index 14cf04a1ed09..e69674588a31 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -18,12 +18,7 @@
 	.text
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
@@ -54,12 +49,7 @@ SYM_FUNC_START(get_sev_encryption_bit)
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

