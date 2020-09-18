Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC4C26FA99
	for <lists+linux-efi@lfdr.de>; Fri, 18 Sep 2020 12:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIRKbR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Sep 2020 06:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRKbQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 18 Sep 2020 06:31:16 -0400
Received: from e123331-lin.nice.arm.com (adsl-119.109.242.22.tellas.gr [109.242.22.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19BE321D92;
        Fri, 18 Sep 2020 10:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600425076;
        bh=8gU0ai9cxzUF92a9lzW8kCl46shP0CmuPk9ZEpvhNFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1LxIet9m7vLFSaL/8TDpwkhqXc3EUzNssB9vhD6OX/xQMshOKa6KhZ50v86/jfUIj
         DQZQtD8wGtYRLggw6HvPzKakMsiPz1qenpsBHUkbtVpTgVMxv+QgXfunnGMhDgAD3D
         2hohLDv6mqOE/eLY8CxDxyb9Gh1cobxcnA+8VJL0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [RFC/RFT PATCH 2/6] ARM: p2v: factor out BE8 handling
Date:   Fri, 18 Sep 2020 13:30:58 +0300
Message-Id: <20200918103102.18107-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918103102.18107-1-ardb@kernel.org>
References: <20200918103102.18107-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/head.S | 30 +++++++++-----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 9a0c11ac8281..c2a912121e3e 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -669,26 +669,24 @@ ARM_BE8(rev16	ip, ip)
 	strh	ip, [r7]
 #else
 #ifdef CONFIG_CPU_ENDIAN_BE8
-	moveq	r0, #0x00004000	@ set bit 22, mov to mvn instruction
+@ in BE8, we load data in BE, but instructions still in LE
+#define PV_BIT22	0x00004000
+#define PV_IMM8_MASK	0xff000000
+#define PV_ROT_MASK	0x000f0000
 #else
-	moveq	r0, #0x400000	@ set bit 22, mov to mvn instruction
+#define PV_BIT22	0x00400000
+#define PV_IMM8_MASK	0x000000ff
+#define PV_ROT_MASK	0xf00
 #endif
+
+	moveq	r0, #PV_BIT22	@ set bit 22, mov to mvn instruction
 	b	.Lnext
 .Lloop:	ldr	ip, [r7, r3]
-#ifdef CONFIG_CPU_ENDIAN_BE8
-	@ in BE8, we load data in BE, but instructions still in LE
-	bic	ip, ip, #0xff000000
-	tst	ip, #0x000f0000	@ check the rotation field
-	orrne	ip, ip, r6, lsl #24 @ mask in offset bits 31-24
-	biceq	ip, ip, #0x00004000 @ clear bit 22
-	orreq	ip, ip, r0      @ mask in offset bits 7-0
-#else
-	bic	ip, ip, #0x000000ff
-	tst	ip, #0xf00	@ check the rotation field
-	orrne	ip, ip, r6	@ mask in offset bits 31-24
-	biceq	ip, ip, #0x400000	@ clear bit 22
-	orreq	ip, ip, r0	@ mask in offset bits 7-0
-#endif
+	bic	ip, ip, #PV_IMM8_MASK
+	tst	ip, #PV_ROT_MASK		@ check the rotation field
+	orrne	ip, ip, r6 ARM_BE8(, lsl #24)	@ mask in offset bits 31-24
+	biceq	ip, ip, #PV_BIT22		@ clear bit 22
+	orreq	ip, ip, r0			@ mask in offset bits 7-0
 	str	ip, [r7, r3]
 #endif
 
-- 
2.17.1

