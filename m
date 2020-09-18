Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F2F26FA98
	for <lists+linux-efi@lfdr.de>; Fri, 18 Sep 2020 12:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIRKbO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Sep 2020 06:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgIRKbO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 18 Sep 2020 06:31:14 -0400
Received: from e123331-lin.nice.arm.com (adsl-119.109.242.22.tellas.gr [109.242.22.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C81521D7B;
        Fri, 18 Sep 2020 10:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600425073;
        bh=gXEI0K94ZLHTKD9CTQuR42Sz0ZjAWV2FGKqZB+3AZSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MkTDqxog8wLjJVdScrwORGELoIv02cUmGsgIaDt2ZdmN9ksTp4oyKOqUNtXrO2Yue
         RhZggVtNZlitaMRTBor0CVEIDxIQJWAEjG3TAdGcoQMdTJC6tHGW6sn0YzL9KvyF74
         TIrwD/pzozhUe5/FhHYkmO/Ehn31eSfkVSZt+JFY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [RFC/RFT PATCH 1/6] ARM: p2v: factor out shared loop processing
Date:   Fri, 18 Sep 2020 13:30:57 +0300
Message-Id: <20200918103102.18107-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918103102.18107-1-ardb@kernel.org>
References: <20200918103102.18107-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/head.S | 24 +++++++++-----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f8904227e7fd..9a0c11ac8281 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -641,7 +641,7 @@ __fixup_a_pv_table:
 #ifdef CONFIG_THUMB2_KERNEL
 	moveq	r0, #0x200000	@ set bit 21, mov to mvn instruction
 	lsls	r6, #24
-	beq	2f
+	beq	.Lnext
 	clz	r7, r6
 	lsr	r6, #24
 	lsl	r6, r7
@@ -650,8 +650,8 @@ __fixup_a_pv_table:
 	orrcs	r6, #0x0080
 	orr	r6, r6, r7, lsl #12
 	orr	r6, #0x4000
-	b	2f
-1:	add     r7, r3
+	b	.Lnext
+.Lloop:	add	r7, r3
 	ldrh	ip, [r7, #2]
 ARM_BE8(rev16	ip, ip)
 	tst	ip, #0x4000
@@ -660,25 +660,21 @@ ARM_BE8(rev16	ip, ip)
 	orreq	ip, r0	@ mask in offset bits 7-0
 ARM_BE8(rev16	ip, ip)
 	strh	ip, [r7, #2]
-	bne	2f
+	bne	.Lnext
 	ldrh	ip, [r7]
 ARM_BE8(rev16	ip, ip)
 	bic	ip, #0x20
 	orr	ip, ip, r0, lsr #16
 ARM_BE8(rev16	ip, ip)
 	strh	ip, [r7]
-2:	cmp	r4, r5
-	ldrcc	r7, [r4], #4	@ use branch for delay slot
-	bcc	1b
-	bx	lr
 #else
 #ifdef CONFIG_CPU_ENDIAN_BE8
 	moveq	r0, #0x00004000	@ set bit 22, mov to mvn instruction
 #else
 	moveq	r0, #0x400000	@ set bit 22, mov to mvn instruction
 #endif
-	b	2f
-1:	ldr	ip, [r7, r3]
+	b	.Lnext
+.Lloop:	ldr	ip, [r7, r3]
 #ifdef CONFIG_CPU_ENDIAN_BE8
 	@ in BE8, we load data in BE, but instructions still in LE
 	bic	ip, ip, #0xff000000
@@ -694,11 +690,13 @@ ARM_BE8(rev16	ip, ip)
 	orreq	ip, ip, r0	@ mask in offset bits 7-0
 #endif
 	str	ip, [r7, r3]
-2:	cmp	r4, r5
+#endif
+
+.Lnext:
+	cmp	r4, r5
 	ldrcc	r7, [r4], #4	@ use branch for delay slot
-	bcc	1b
+	bcc	.Lloop
 	ret	lr
-#endif
 ENDPROC(__fixup_a_pv_table)
 
 	.align
-- 
2.17.1

