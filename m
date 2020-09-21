Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334EA272A69
	for <lists+linux-efi@lfdr.de>; Mon, 21 Sep 2020 17:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgIUPlc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Sep 2020 11:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbgIUPlb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 21 Sep 2020 11:41:31 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC912151B;
        Mon, 21 Sep 2020 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600702891;
        bh=5SqLf3ky4DctxaYjoXFAJllzzYlMRIzHE5aY+ufILiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DlmsunmZL/YkxNg28/XtHE6o9AacKV3wv0GsaiEk4pqNKh+iWTbmumYvIjYliJBUq
         4RV7oj5eFkR0sHCzl0KaEHLOOid9ohl+0T1GukdGhEE1VaDx5+PeMM9il/mE1iuAwP
         ltD++QqPWRpnswGbx1kKodfDYICE1Qj3mmahGrNY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2 05/10] ARM: p2v: factor out BE8 handling
Date:   Mon, 21 Sep 2020 17:41:12 +0200
Message-Id: <20200921154117.757-6-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921154117.757-1-ardb@kernel.org>
References: <20200921154117.757-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The big and little endian versions of the ARM p2v patching routine only
differ in the values of the constants, so factor those out into macros
so that we only have one version of the logic sequence to maintain.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/phys2virt.S | 30 +++++++++++---------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/phys2virt.S b/arch/arm/kernel/phys2virt.S
index 8fb1f7bcc720..5031e5a2e78b 100644
--- a/arch/arm/kernel/phys2virt.S
+++ b/arch/arm/kernel/phys2virt.S
@@ -95,23 +95,25 @@ ARM_BE8(rev16	ip, ip)
 ARM_BE8(rev16	ip, ip)
 	strh	ip, [r7]
 #else
-	moveq	r0, #0x400000		@ set bit 22, mov to mvn instruction
-	b	.Lnext
-.Lloop:	ldr	ip, [r7, r3]
 #ifdef CONFIG_CPU_ENDIAN_BE8
-	@ in BE8, we load data in BE, but instructions still in LE
-	bic	ip, ip, #0xff000000
-	tst	ip, #0x000f0000		@ check the rotation field
-	orrne	ip, ip, r6, lsl #24	@ mask in offset bits 31-24
-	biceq	ip, ip, #0x00004000	@ clear bit 22
-	orreq	ip, ip, r0, ror #8	@ mask in offset bits 7-0
+@ in BE8, we load data in BE, but instructions still in LE
+#define PV_BIT22	0x00004000
+#define PV_IMM8_MASK	0xff000000
+#define PV_ROT_MASK	0x000f0000
 #else
-	bic	ip, ip, #0x000000ff
-	tst	ip, #0xf00		@ check the rotation field
-	orrne	ip, ip, r6		@ mask in offset bits 31-24
-	biceq	ip, ip, #0x400000	@ clear bit 22
-	orreq	ip, ip, r0		@ mask in offset bits 7-0
+#define PV_BIT22	0x00400000
+#define PV_IMM8_MASK	0x000000ff
+#define PV_ROT_MASK	0xf00
 #endif
+
+	moveq	r0, #0x400000		@ set bit 22, mov to mvn instruction
+	b	.Lnext
+.Lloop:	ldr	ip, [r7, r3]
+	bic	ip, ip, #PV_IMM8_MASK
+	tst	ip, #PV_ROT_MASK		@ check the rotation field
+	orrne	ip, ip, r6 ARM_BE8(, lsl #24)	@ mask in offset bits 31-24
+	biceq	ip, ip, #PV_BIT22		@ clear bit 22
+	orreq	ip, ip, r0 ARM_BE8(, ror #8)	@ mask in offset bits 7-0 (or bit 22)
 	str	ip, [r7, r3]
 #endif
 
-- 
2.17.1

