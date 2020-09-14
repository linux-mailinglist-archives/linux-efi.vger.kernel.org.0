Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A4C2688E5
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgINJ6G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 05:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgINJ6F (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 05:58:05 -0400
Received: from e123331-lin.nice.arm.com (unknown [37.6.197.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A7E420732;
        Mon, 14 Sep 2020 09:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600077484;
        bh=rDotRQsUER7JLdwSfGEMxdL7nO34me7IugF3nMXAYlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1HPTfiHuliPl4mO/sR3G+2DeNSY4A+fgylwco9iQXzL+vujkIn0fG31nrxl+i/rt
         fj70N4gmv9suVWiBm+i0FrPJwcnFMdAVvhrJAl4VQyTY2Xm0GrxzoJ52b5GGyZsJQN
         5ZmS5fs2Dlfy6278xlt9tb47omIJ7pU812cV5yg8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: [PATCH 10/12] ARM: head.S: use PC-relative insn sequences for __fixup_pv_table
Date:   Mon, 14 Sep 2020 12:57:04 +0300
Message-Id: <20200914095706.3985-11-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914095706.3985-1-ardb@kernel.org>
References: <20200914095706.3985-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Replace the open coded PC relative offset calculations with adr_l
and mov_l invocations. This removes some open coded arithmetic involving
virtual addresses and avoids literal pools on v7+. Note that the footprint
of the code increases slightly, but the resulting code is a bit easier to
follow.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/head.S | 27 ++++++--------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 5f6436a40db1..6f334df5d3b9 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -576,14 +576,11 @@ ENDPROC(fixup_smp)
  */
 	__HEAD
 __fixup_pv_table:
-	adr	r0, 1f
-	ldmia	r0, {r3-r7}
+	adr_l	r6, __pv_phys_pfn_offset
+	adr_l	r7, __pv_offset			@ __pa(__pv_offset)
+	mov_l	r3, __pv_offset			@ __va(__pv_offset)
 	mvn	ip, #0
-	subs	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
-	add	r4, r4, r3	@ adjust table start address
-	add	r5, r5, r3	@ adjust table end address
-	add	r6, r6, r3	@ adjust __pv_phys_pfn_offset address
-	add	r7, r7, r3	@ adjust __pv_offset address
+	subs	r3, r7, r3	@ PHYS_OFFSET - PAGE_OFFSET
 	mov	r0, r8, lsr #PAGE_SHIFT	@ convert to PFN
 	str	r0, [r6]	@ save computed PHYS_OFFSET to __pv_phys_pfn_offset
 	strcc	ip, [r7, #HIGH_OFFSET]	@ save to __pv_offset high bits
@@ -592,20 +589,15 @@ __fixup_pv_table:
 THUMB(	it	ne		@ cross section branch )
 	bne	__error
 	str	r3, [r7, #LOW_OFFSET]	@ save to __pv_offset low bits
+	adr_l	r4, __pv_table_begin
+	adr_l	r5, __pv_table_end
 	b	__fixup_a_pv_table
 ENDPROC(__fixup_pv_table)
-
-	.align
-1:	.long	.
-	.long	__pv_table_begin
-	.long	__pv_table_end
-2:	.long	__pv_phys_pfn_offset
-	.long	__pv_offset
+	.ltorg
 
 	.text
 __fixup_a_pv_table:
-	adr	r0, 3f
-	ldr	r6, [r0]
+	mov_l	r6, __pv_offset
 	add	r6, r6, r3
 	ldr	r0, [r6, #HIGH_OFFSET]	@ pv_offset high word
 	ldr	r6, [r6, #LOW_OFFSET]	@ pv_offset low word
@@ -674,9 +666,6 @@ ARM_BE8(rev16	ip, ip)
 #endif
 ENDPROC(__fixup_a_pv_table)
 
-	.align
-3:	.long __pv_offset
-
 ENTRY(fixup_pv_table)
 	stmfd	sp!, {r4 - r7, lr}
 	mov	r3, #0			@ no offset
-- 
2.17.1

