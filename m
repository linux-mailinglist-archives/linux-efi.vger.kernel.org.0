Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20B2634113
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiKVQMR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiKVQLh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:11:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC30E74AA4;
        Tue, 22 Nov 2022 08:11:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 856FEB81C10;
        Tue, 22 Nov 2022 16:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FFEC433D7;
        Tue, 22 Nov 2022 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133466;
        bh=WzgruzR/v1MEVPGvMfLbw7xCwZPOIioiFXKbArp2e20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hl5LV4DCJoQbDIyuHOaHIoqt7NLovhtjIM9BVLXENuDhZK8U/Tdr8ErYt6C8UGPRl
         ekPienlBAffkk4JnJy+2qvhrYbP2gIw03vtJ/qWdIV2T/iw1UNhOZVRrQPaSe7wyec
         4LIpSpGSaTFELxo/6SZIhqHYvmmy1KgODJ+rldbgCvUzYwbjduhynFHkGRS77txH8l
         wYS2NP3f0QlY9CY1O6eBScPmzdXJyQIAQiyiePRP3O1lAR57qEdGwM1aFF1ePpD/Tj
         TvCOZsATwQ9DIE8wMrDmAhJIbOh2MzvAq6axyZy9t39AP7DIpc1Q+bjzdXG3oGKbzE
         c3FXW9faPaYuw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 15/17] x86/compressed: adhere to calling convention in get_sev_encryption_bit()
Date:   Tue, 22 Nov 2022 17:10:15 +0100
Message-Id: <20221122161017.2426828-16-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909; i=ardb@kernel.org; h=from:subject; bh=WzgruzR/v1MEVPGvMfLbw7xCwZPOIioiFXKbArp2e20=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRlRjCxfUGcb8bUP8866wWUGhLDdGiyfHOFhXH7 xfd5BRmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0ZQAKCRDDTyI5ktmPJGPtC/ 91APxkHaUNp4yBkeDxwprSCH28epIzimrD0vGJf9LbPi5dn6uj76y3+T4vrgtHhAYZnNO/Nw4dwzzR 14AJNAGQmmU5stvmBSm9ioWr5fHNym/ks4TYcPtA2EGDDRERG4jMI//3JpMznmg+sAm6qmiG0x6/+R JRgAU2Bu1xVw8qvnfwz722rD9r9E1zo+StiSMIYFtmRwSeVHt0F1/StamR8Ct7NW79oWFfCpi3v8bj V/+VcvkxZDTDtUWsGMVdAjVQvwq/KJqcALXNynkjfkBZEkmdcvOCRYooQ/l8e6nW/3Ih6DAxGC3f7u J+5WZeZKMAUQWsXoLYEKLEIe2bXFRNuPrYIK45sn809agJgilov8zYP/zl70UYYgRHPBFXPBD+6BMB 9Dg9cXWdGNAkUyiqJAxtG4FBqShNzg96C3R1n91sJjUnFrZa6eQ8q5NGOXR21m33tF9+LJcFYqB9Rb +stxkVfyllEXg3zFeg2EuZ9D7WppYsUGfNVjuE6iMDmLY=
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
index 0cfc8ce273a2731c..dd18216cff5c37e0 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -188,12 +188,13 @@ SYM_FUNC_START(startup_32)
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
index 14cf04a1ed091655..e69674588a31c81f 100644
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

