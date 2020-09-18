Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0060A26FA9B
	for <lists+linux-efi@lfdr.de>; Fri, 18 Sep 2020 12:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgIRKbW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Sep 2020 06:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRKbW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 18 Sep 2020 06:31:22 -0400
Received: from e123331-lin.nice.arm.com (adsl-119.109.242.22.tellas.gr [109.242.22.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1EF021D92;
        Fri, 18 Sep 2020 10:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600425081;
        bh=IyE2vpWRuZWSnn1Z02drazCDd+O3utm6FRND0TFfK6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/kFXeueOEzZb4M7fszmLbpVIewUPJ9Doo5NOrpEz4EbPkJGDNBIJSVNs2ihGpLk5
         y0jAuffW04Z5JQF75bLPNNo/kAFbgWBsnF9qjeNlvFXDxX5+8O1S53RfoyJ/w+OOkD
         TRT8FFuEh05mHrN2JQBTMruEdFIjf+OHA/SZwTb4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [RFC/RFT PATCH 4/6] ARM: p2v: use relative references in patch site arrays
Date:   Fri, 18 Sep 2020 13:31:00 +0300
Message-Id: <20200918103102.18107-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918103102.18107-1-ardb@kernel.org>
References: <20200918103102.18107-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Free up a register in the p2v patching code by switching to relative
references, which don't require keeping the phys-to-virt displacement
live in a register.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/memory.h |  6 +++---
 arch/arm/kernel/head.S        | 15 ++++++++-------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index eb3c8e6e960a..4121662dea5a 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -187,7 +187,7 @@ extern const void *__pv_table_begin, *__pv_table_end;
 	__asm__("@ __pv_stub\n"				\
 	"1:	" instr "	%0, %1, %2\n"		\
 	"	.pushsection .pv_table,\"a\"\n"		\
-	"	.long	1b\n"				\
+	"	.long	1b - .\n"			\
 	"	.popsection\n"				\
 	: "=r" (to)					\
 	: "r" (from), "I" (__PV_BITS_31_24))
@@ -196,7 +196,7 @@ extern const void *__pv_table_begin, *__pv_table_end;
 	__asm__ volatile("@ __pv_stub_mov\n"		\
 	"1:	mov	%R0, %1\n"			\
 	"	.pushsection .pv_table,\"a\"\n"		\
-	"	.long	1b\n"				\
+	"	.long	1b - .\n"			\
 	"	.popsection\n"				\
 	: "=r" (t)					\
 	: "I" (__PV_BITS_7_0))
@@ -206,7 +206,7 @@ extern const void *__pv_table_begin, *__pv_table_end;
 	"1:	adds	%Q0, %1, %2\n"			\
 	"	adc	%R0, %R0, #0\n"			\
 	"	.pushsection .pv_table,\"a\"\n"		\
-	"	.long	1b\n"				\
+	"	.long	1b - .\n"			\
 	"	.popsection\n"				\
 	: "+r" (y)					\
 	: "r" (x), "I" (__PV_BITS_31_24)		\
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index c2a912121e3e..d2bd3b258386 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -633,7 +633,7 @@ ENDPROC(__fixup_pv_table)
 __fixup_a_pv_table:
 	adr	r0, 3f
 	ldr	r6, [r0]
-	add	r6, r6, r3
+	add	r6, r6, r0
 	ldr	r0, [r6, #HIGH_OFFSET]	@ pv_offset high word
 	ldr	r6, [r6, #LOW_OFFSET]	@ pv_offset low word
 	mov	r6, r6, lsr #24
@@ -651,7 +651,8 @@ __fixup_a_pv_table:
 	orr	r6, r6, r7, lsl #12
 	orr	r6, #0x4000
 	b	.Lnext
-.Lloop:	add	r7, r3
+.Lloop:	add	r7, r4
+	add	r4, #4
 	ldrh	ip, [r7, #2]
 ARM_BE8(rev16	ip, ip)
 	tst	ip, #0x4000
@@ -681,28 +682,28 @@ ARM_BE8(rev16	ip, ip)
 
 	moveq	r0, #PV_BIT22	@ set bit 22, mov to mvn instruction
 	b	.Lnext
-.Lloop:	ldr	ip, [r7, r3]
+.Lloop:	ldr	ip, [r7, r4]
 	bic	ip, ip, #PV_IMM8_MASK
 	tst	ip, #PV_ROT_MASK		@ check the rotation field
 	orrne	ip, ip, r6 ARM_BE8(, lsl #24)	@ mask in offset bits 31-24
 	biceq	ip, ip, #PV_BIT22		@ clear bit 22
 	orreq	ip, ip, r0			@ mask in offset bits 7-0
-	str	ip, [r7, r3]
+	str	ip, [r7, r4]
+	add	r4, r4, #4
 #endif
 
 .Lnext:
 	cmp	r4, r5
-	ldrcc	r7, [r4], #4	@ use branch for delay slot
+	ldrcc	r7, [r4]	@ use branch for delay slot
 	bcc	.Lloop
 	ret	lr
 ENDPROC(__fixup_a_pv_table)
 
 	.align
-3:	.long __pv_offset
+3:	.long __pv_offset - .
 
 ENTRY(fixup_pv_table)
 	stmfd	sp!, {r4 - r7, lr}
-	mov	r3, #0			@ no offset
 	mov	r4, r0			@ r0 = table start
 	add	r5, r0, r1		@ r1 = table size
 	bl	__fixup_a_pv_table
-- 
2.17.1

