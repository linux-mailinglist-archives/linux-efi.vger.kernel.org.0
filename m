Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA66826FA9D
	for <lists+linux-efi@lfdr.de>; Fri, 18 Sep 2020 12:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIRKb2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Sep 2020 06:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRKb2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 18 Sep 2020 06:31:28 -0400
Received: from e123331-lin.nice.arm.com (adsl-119.109.242.22.tellas.gr [109.242.22.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5036720C56;
        Fri, 18 Sep 2020 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600425087;
        bh=DF2uxIbtzp4I3gxuyPT2qFKSDW/qby8qCC3dudl1VR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDwsqLqZA7h+zWaGWboAncOcnIODXiTXz8nZgMbJ88xsfOS5FM4Vitdzpe0cgm+/J
         6qLKY/gqW7kehUDudVG67TjNAELQTX0skziHiXUsZcq6YH5dEdpWq3xRyeYOJkUAOf
         U2sz/tmH9yHyyWK4oZksEpNl4RXPD/z2RWPtgFtM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [RFC/RFT PATCH 6/6] ARM: p2v: reduce p2v alignment requirement to 2 MiB
Date:   Fri, 18 Sep 2020 13:31:02 +0300
Message-Id: <20200918103102.18107-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918103102.18107-1-ardb@kernel.org>
References: <20200918103102.18107-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Update the p2v patching code so we can deal with displacements that are
not a multiple of 16 MiB but of 2 MiB, to prevent wasting of up to 14 MiB
of physical RAM when running on a platform where the start of memory is
not correctly aligned.

For the ARM code path, this simply comes down to using two add/sub
instructions instead of one for the carryless version, and patching
each of them with the correct immediate depending on the rotation
field. For the LPAE calculation, it patches the MOVW instruction with
up to 12 bits of offset.

For the Thumb2 code path, patching more than 11 bits off displacement
is somewhat cumbersome, and given that 11 bits produce a minimum
alignment of 2 MiB, which is also the granularity for LPAE block
mappings, it makes sense to stick to 2 MiB for the new p2v requirement.

Suggested-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/Kconfig              |  2 +-
 arch/arm/include/asm/memory.h | 15 +++++++-----
 arch/arm/kernel/head.S        | 24 +++++++++++++++-----
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e00d94b16658..c4737a0e613b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -240,7 +240,7 @@ config ARM_PATCH_PHYS_VIRT
 	  kernel in system memory.
 
 	  This can only be used with non-XIP MMU kernels where the base
-	  of physical memory is at a 16MB boundary.
+	  of physical memory is at a 2MiB boundary.
 
 	  Only disable this option if you know that you do not require
 	  this feature (eg, building a kernel for a single machine) and
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 7184a2540816..5da01e7f0d8a 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -173,6 +173,7 @@ extern unsigned long vectors_base;
  * so that all we need to do is modify the 8-bit constant field.
  */
 #define __PV_BITS_31_24	0x81000000
+#define __PV_BITS_23_16	0x810000
 #define __PV_BITS_7_0	0x81
 
 extern unsigned long __pv_phys_pfn_offset;
@@ -187,16 +188,18 @@ extern const void *__pv_table_begin, *__pv_table_end;
 #define __pv_stub(from,to,instr)			\
 	__asm__("@ __pv_stub\n"				\
 	"1:	" instr "	%0, %1, %2\n"		\
+	"2:	" instr "	%0, %0, %3\n"		\
 	"	.pushsection .pv_table,\"a\"\n"		\
-	"	.long	1b - .\n"			\
+	"	.long	1b - ., 2b - .\n"		\
 	"	.popsection\n"				\
-	: "=r" (to)					\
-	: "r" (from), "I" (__PV_BITS_31_24))
+	: "=&r" (to)					\
+	: "r" (from), "I" (__PV_BITS_31_24),		\
+	  "I"(__PV_BITS_23_16))
 
 #define __pv_add_carry_stub(x, y)			\
 	__asm__ volatile("@ __pv_add_carry_stub\n"	\
 	"0:	movw	%R0, %2\n"			\
-	"1:	adds	%Q0, %1, %R0, lsl #24\n"	\
+	"1:	adds	%Q0, %1, %R0, lsl #20\n"	\
 	"2:	mov	%R0, %3\n"			\
 	"	adc	%R0, %R0, #0\n"			\
 	"	.pushsection .pv_table,\"a\"\n"		\
@@ -210,7 +213,7 @@ extern const void *__pv_table_begin, *__pv_table_end;
 #define __pv_stub(from,to,instr)			\
 	__asm__("@ __pv_stub\n"				\
 	"0:	movw	%0, %2\n"			\
-	"	lsls	%0, #24\n"			\
+	"	lsls	%0, #21\n"			\
 	"	" instr "s %0, %1, %0\n"		\
 	"	.pushsection .pv_table,\"a\"\n"		\
 	"	.long	0b - .\n"			\
@@ -222,7 +225,7 @@ extern const void *__pv_table_begin, *__pv_table_end;
 #define __pv_add_carry_stub(x, y)			\
 	__asm__ volatile("@ __pv_add_carry_stub\n"	\
 	"0:	movw	%R0, %2\n"			\
-	"	lsls	%R0, #24\n"			\
+	"	lsls	%R0, #21\n"			\
 	"	adds	%Q0, %1, %R0\n"			\
 	"1:	mvn	%R0, #0\n"			\
 	"	adc	%R0, %R0, #0\n"			\
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 86cea608a5ea..d08d506a0ccd 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -614,8 +614,8 @@ __fixup_pv_table:
 	mov	r0, r8, lsr #PAGE_SHIFT	@ convert to PFN
 	str	r0, [r6]	@ save computed PHYS_OFFSET to __pv_phys_pfn_offset
 	strcc	ip, [r7, #HIGH_OFFSET]	@ save to __pv_offset high bits
-	mov	r6, r3, lsr #24	@ constant for add/sub instructions
-	teq	r3, r6, lsl #24 @ must be 16MiB aligned
+	mov	r6, r3, lsr #21	@ constant for add/sub instructions
+	teq	r3, r6, lsl #21 @ must be 2MiB aligned
 THUMB(	it	ne		@ cross section branch )
 	bne	__error
 	str	r3, [r7, #LOW_OFFSET]	@ save to __pv_offset low bits
@@ -636,10 +636,13 @@ __fixup_a_pv_table:
 	add	r6, r6, r0
 	ldr	r0, [r6, #HIGH_OFFSET]	@ pv_offset high word
 	ldr	r6, [r6, #LOW_OFFSET]	@ pv_offset low word
-	mov	r6, r6, lsr #24
+	mov	r6, r6, lsr #16
 	cmn	r0, #1
 #ifdef CONFIG_THUMB2_KERNEL
 	moveq	r0, #0x200	@ bit 9, ADD to SUB instruction (T1 encoding)
+	mov	r3, r6, lsr #13	@ isolate top 3 bits of displacement
+	ubfx	r6, r6, #5, #8	@ put bits 28:21 into the imm8 field
+	bfi	r6, r3, #12, #3	@ put bits 31:29 into the imm3 field
 	b	.Lnext
 .Lloop:	add	r7, r4
 	add	r4, #4
@@ -658,7 +661,7 @@ ARM_BE8(rev16	ip, ip)
 #endif
 	ldrh	ip, [r7, #2]
 ARM_BE8(rev16	ip, ip)
-	orr	ip, r6	@ mask in offset bits 31-24
+	orr	ip, r6	@ mask in offset bits 31-21
 ARM_BE8(rev16	ip, ip)
 	strh	ip, [r7, #2]
 	ldrh	ip, [r7, #6]
@@ -674,21 +677,26 @@ ARM_BE8(rev16	ip, ip)
 #define PV_BIT23_22	0x0000c000
 #define PV_IMM8_MASK	0xff000000
 #define PV_ROT_MASK	0x000f0000
+#define PV_ROT16_MASK	0x00080000
 #else
 #define PV_BIT20	0x00100000
 #define PV_BIT22	0x00400000
 #define PV_BIT23_22	0x00c00000
 #define PV_IMM8_MASK	0x000000ff
 #define PV_ROT_MASK	0xf00
+#define PV_ROT16_MASK	0x800
 #endif
 
 	moveq	r0, #PV_BIT22	@ set bit 22, mov to mvn instruction
+	and	r3, r6, #0xf
+	mov	r6, r6, lsr #8
 	b	.Lnext
 .Lloop:	ldr	ip, [r7, r4]
 #ifdef CONFIG_ARM_LPAE
 	tst	ip, #PV_BIT23_22	@ MOVW has bit 23:22 clear, MOV/ADD/SUB have it set
 ARM_BE8(rev	ip, ip)
-	orreq	ip, ip, r6
+	orreq	ip, ip, r6, lsl #4
+	orreq	ip, ip, r3, lsr #4
 ARM_BE8(rev	ip, ip)
 	beq	2f
 	tst	ip, #PV_BIT20		@ ADDS has bit 20 set
@@ -701,9 +709,13 @@ ARM_BE8(rev	ip, ip)
 #endif
 	bic	ip, ip, #PV_IMM8_MASK
 	tst	ip, #PV_ROT_MASK		@ check the rotation field
-	orrne	ip, ip, r6 ARM_BE8(, lsl #24)	@ mask in offset bits 31-24
 	biceq	ip, ip, #PV_BIT22		@ clear bit 22
 	orreq	ip, ip, r0			@ mask in offset bits 7-0
+	beq	2f
+
+	tst	ip, #PV_ROT16_MASK		@ amount of shift?
+	orreq	ip, ip, r6 ARM_BE8(, lsl #24)	@ mask in offset bits 31-24
+	orrne	ip, ip, r3 ARM_BE8(, lsl #24)	@ mask in offset bits 23-16
 2:
 	str	ip, [r7, r4]
 	add	r4, r4, #4
-- 
2.17.1

