Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1A7634103
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiKVQLg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiKVQLG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:11:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6A2742F5;
        Tue, 22 Nov 2022 08:10:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE5E7B81BEE;
        Tue, 22 Nov 2022 16:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F77C433C1;
        Tue, 22 Nov 2022 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133450;
        bh=9jyxmHpzfRCJJf9xQ03iz+bA0Xb5QCrz4P3JHsC5SMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SiQbk7Da54coI7gkcSa+od6Hd1M1+JjCaNn0sFqcdZG0cdtYNtk4vB1aTINWnfSt9
         8rfTyvgy6vUlGqeeu5V9XjhwRYFk6HMOy3qCTv95SmUw5yT9d2q+aVSqDvls4VeF+X
         lsf6RLOVRNnFynZZZTkLyDyUO0XyFuDkCkvd8Pph1wBlGyUwdNnYA6Z6TQtrDqCNQw
         deqfbqofQxcCxHpuCxXeZIaoZ9daJ8BSrPgtgAVDx9kFudVMdf27mkrsWFvKRLD1gy
         TMFtctu/fcOjmw2cjOIIr+yUMzat1AipaE3kkWTNRTQobTcd8bdfxCZyltHtVEubWI
         QAjbhcijIwlUw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 08/17] x86/compressed: efi-mixed: simplify IDT/GDT preserve/restore
Date:   Tue, 22 Nov 2022 17:10:08 +0100
Message-Id: <20221122161017.2426828-9-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; i=ardb@kernel.org; h=from:subject; bh=9jyxmHpzfRCJJf9xQ03iz+bA0Xb5QCrz4P3JHsC5SMM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRabAmNoz2lPub2d3CamZQemKR8yASDbUtdoT/H Brr43omJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0WgAKCRDDTyI5ktmPJPUKC/ 4t4JhAxm00y83U+Wvv2lAqOINuqkTuhkErVDG15v2jHR+wYw30ix4IghLOwk1iSHqDv0w/bCgPztVD Vw40lqEejjuygLaA/IDUXmKps3vkdJ67GWwpm2mflPDVvXO9gkh9KcU5EmUbPNZIuzO8DBkI45Tfrx wPpTaTILzpbYKv3YH11CzTBHkd8rx8eE+rN4Gd6olfriIBjDReEb6sHyWZKk/kq8iGNDLiPrukp/+s ssN1Upypo9IgxpqwnBR/hAE4BU/uoGabIvrYVpZK7l9J8DiFa82SdRCyIzUcgGBUwkessJq8KMokyT htyKWur2fjznZRSYRAGPsP3xXAbciPsZQFTkTozwyeV3AuFdJldcTsLXLoIez2YElX/Epm0RhwOaUJ Zt5RvDMgD36pIqAN5xYqx/T40dY74SZaG9w4GQGMwUz+AX1gKo9DnYze0fxdNd2ATExubRqB7cv/i/ 2SxSKLq80PD+MvCg8gRWoksHrI7ioxnnKHmJrYSwvEj2c=
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

Tweak the asm and remove some redundant instructions. While at it,
fix the associated comment for style and correctness.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 8844d8ed4b1c7561..8b02e507d3bb055a 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -96,24 +96,20 @@ SYM_FUNC_START(__efi64_thunk)
 
 	leaq	0x20(%rsp), %rbx
 	sgdt	(%rbx)
-
-	addq	$16, %rbx
-	sidt	(%rbx)
+	sidt	16(%rbx)
 
 	leaq	1f(%rip), %rbp
 
 	/*
-	 * Switch to IDT and GDT with 32-bit segments. This is the firmware GDT
-	 * and IDT that was installed when the kernel started executing. The
-	 * pointers were saved by the efi32_entry() routine below.
+	 * Switch to IDT and GDT with 32-bit segments. These are the firmware
+	 * GDT and IDT that were installed when the kernel started executing.
+	 * The pointers were saved by the efi32_entry() routine below.
 	 *
 	 * Pass the saved DS selector to the 32-bit code, and use far return to
 	 * restore the saved CS selector.
 	 */
-	leaq	efi32_boot_idt(%rip), %rax
-	lidt	(%rax)
-	leaq	efi32_boot_gdt(%rip), %rax
-	lgdt	(%rax)
+	lidt	efi32_boot_idt(%rip)
+	lgdt	efi32_boot_gdt(%rip)
 
 	movzwl	efi32_boot_ds(%rip), %edx
 	movzwq	efi32_boot_cs(%rip), %rax
@@ -187,9 +183,7 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	 */
 	cli
 
-	lidtl	(%ebx)
-	subl	$16, %ebx
-
+	lidtl	16(%ebx)
 	lgdtl	(%ebx)
 
 	movl	%cr4, %eax
-- 
2.35.1

