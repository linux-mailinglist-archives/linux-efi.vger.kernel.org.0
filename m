Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7D4272A68
	for <lists+linux-efi@lfdr.de>; Mon, 21 Sep 2020 17:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgIUPla (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Sep 2020 11:41:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgIUPla (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 21 Sep 2020 11:41:30 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0EC220888;
        Mon, 21 Sep 2020 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600702889;
        bh=HrsjVp+h3xnv54aC+fvBGs9Fp0x8o8jkOa/diDWQzp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W6qYsoxbpnqqu8VSlHFsoGiTv455daCnolYIQYwC4nUM29VIsLk7rSfZ3M4+7rX/e
         O9pGISwwWaFrFo1uBWZzG3DtAJBHX64MACkP+hSBsgdFtalevecI7EsLDmS8uVZ2dn
         KsGk+Vaa9p5yRI3vxiQP0QorWW9EfTBMuyOO7e6k=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2 04/10] ARM: p2v: factor out shared loop processing
Date:   Mon, 21 Sep 2020 17:41:11 +0200
Message-Id: <20200921154117.757-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921154117.757-1-ardb@kernel.org>
References: <20200921154117.757-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The ARM and Thumb2 versions of the p2v patching loop have some overlap
at the end of the loop, so factor that out.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/phys2virt.S | 24 +++++++++-----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/phys2virt.S b/arch/arm/kernel/phys2virt.S
index 7c17fbfeeedd..8fb1f7bcc720 100644
--- a/arch/arm/kernel/phys2virt.S
+++ b/arch/arm/kernel/phys2virt.S
@@ -68,7 +68,7 @@ __fixup_a_pv_table:
 #ifdef CONFIG_THUMB2_KERNEL
 	moveq	r0, #0x200000		@ set bit 21, mov to mvn instruction
 	lsls	r6, #24
-	beq	2f
+	beq	.Lnext
 	clz	r7, r6
 	lsr	r6, #24
 	lsl	r6, r7
@@ -77,8 +77,8 @@ __fixup_a_pv_table:
 	orrcs	r6, #0x0080
 	orr	r6, r6, r7, lsl #12
 	orr	r6, #0x4000
-	b	2f
-1:	add	r7, r3
+	b	.Lnext
+.Lloop:	add	r7, r3
 	ldrh	ip, [r7, #2]
 ARM_BE8(rev16	ip, ip)
 	tst	ip, #0x4000
@@ -87,21 +87,17 @@ ARM_BE8(rev16	ip, ip)
 	orreq	ip, r0			@ mask in offset bits 7-0
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
-	ldrcc	r7, [r4], #4		@ use branch for delay slot
-	bcc	1b
-	bx	lr
 #else
 	moveq	r0, #0x400000		@ set bit 22, mov to mvn instruction
-	b	2f
-1:	ldr	ip, [r7, r3]
+	b	.Lnext
+.Lloop:	ldr	ip, [r7, r3]
 #ifdef CONFIG_CPU_ENDIAN_BE8
 	@ in BE8, we load data in BE, but instructions still in LE
 	bic	ip, ip, #0xff000000
@@ -117,11 +113,13 @@ ARM_BE8(rev16	ip, ip)
 	orreq	ip, ip, r0		@ mask in offset bits 7-0
 #endif
 	str	ip, [r7, r3]
-2:	cmp	r4, r5
+#endif
+
+.Lnext:
+	cmp	r4, r5
 	ldrcc	r7, [r4], #4		@ use branch for delay slot
-	bcc	1b
+	bcc	.Lloop
 	ret	lr
-#endif
 ENDPROC(__fixup_a_pv_table)
 
 	.align
-- 
2.17.1

