Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E0A272A6F
	for <lists+linux-efi@lfdr.de>; Mon, 21 Sep 2020 17:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgIUPlm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Sep 2020 11:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbgIUPlm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 21 Sep 2020 11:41:42 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 716C620888;
        Mon, 21 Sep 2020 15:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600702901;
        bh=N8bDeHCtyoDrpgNTB0A1qDbRWPwExauP62o6mh+mwAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5oO32ffgevCfaXkEi61d2LPdqp5/o6gyDFR3czFxnKJD+dwnuKHB61hRX+gK0rxN
         FIV25PKHgvMGdvjL+Uw+iosttySQhsAgy2HtznxCD6uXN4af0JxLpdZHW79uEJGD+H
         IyhYMxX1sbJ5znjKTXIl6xwDFuckWTfZ1j14KRJk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2 10/10] ARM: p2v: reduce p2v alignment requirement to 2 MiB
Date:   Mon, 21 Sep 2020 17:41:17 +0200
Message-Id: <20200921154117.757-11-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921154117.757-1-ardb@kernel.org>
References: <20200921154117.757-1-ardb@kernel.org>
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
 arch/arm/include/asm/memory.h | 13 ++++---
 arch/arm/kernel/phys2virt.S   | 40 +++++++++++++-------
 3 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e00d94b16658..d7531e161b85 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -240,7 +240,7 @@ config ARM_PATCH_PHYS_VIRT
 	  kernel in system memory.
 
 	  This can only be used with non-XIP MMU kernels where the base
-	  of physical memory is at a 16MB boundary.
+	  of physical memory is at a 2 MiB boundary.
 
 	  Only disable this option if you know that you do not require
 	  this feature (eg, building a kernel for a single machine) and
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index ccf55cef6ab9..2611be35f26b 100644
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
 	: "=r" (to)					\
-	: "r" (from), "I" (__PV_BITS_31_24))
+	: "r" (from), "I" (__PV_BITS_31_24),		\
+	  "I"(__PV_BITS_23_16))
 
 #define __pv_add_carry_stub(x, y)			\
 	__asm__("@ __pv_add_carry_stub\n"		\
 	"0:	movw	%R0, #0\n"			\
-	"	adds	%Q0, %1, %R0, lsl #24\n"	\
+	"	adds	%Q0, %1, %R0, lsl #20\n"	\
 	"1:	mov	%R0, %2\n"			\
 	"	adc	%R0, %R0, #0\n"			\
 	"	.pushsection .pv_table,\"a\"\n"		\
@@ -210,7 +213,7 @@ extern const void *__pv_table_begin, *__pv_table_end;
 #define __pv_stub(from,to,instr)			\
 	__asm__("@ __pv_stub\n"				\
 	"0:	movw	%0, #0\n"			\
-	"	lsl	%0, #24\n"			\
+	"	lsl	%0, #21\n"			\
 	"	" instr " %0, %1, %0\n"			\
 	"	.pushsection .pv_table,\"a\"\n"		\
 	"	.long	0b - .\n"			\
@@ -221,7 +224,7 @@ extern const void *__pv_table_begin, *__pv_table_end;
 #define __pv_add_carry_stub(x, y)			\
 	__asm__("@ __pv_add_carry_stub\n"		\
 	"0:	movw	%R0, #0\n"			\
-	"	lsls	%R0, #24\n"			\
+	"	lsls	%R0, #21\n"			\
 	"	adds	%Q0, %1, %R0\n"			\
 	"1:	mvn	%R0, #0\n"			\
 	"	adc	%R0, %R0, #0\n"			\
diff --git a/arch/arm/kernel/phys2virt.S b/arch/arm/kernel/phys2virt.S
index a4e364689663..fb53db78fe78 100644
--- a/arch/arm/kernel/phys2virt.S
+++ b/arch/arm/kernel/phys2virt.S
@@ -21,7 +21,7 @@
 /*
  * __fixup_pv_table - patch the stub instructions with the delta between
  *                    PHYS_OFFSET and PAGE_OFFSET, which is assumed to be
- *                    16MiB aligned.
+ *                    2 MiB aligned.
  *
  * Called from head.S, which expects the following registers to be preserved:
  *   r1 = machine no, r2 = atags or dtb,
@@ -38,8 +38,8 @@ ENTRY(__fixup_pv_table)
 	strcc	ip, [r0, #HIGH_OFFSET]	@ save to __pv_offset high bits
 	str	r3, [r0, #LOW_OFFSET]	@ save to __pv_offset low bits
 
-	mov	r0, r3, lsr #24		@ constant for add/sub instructions
-	teq	r3, r0, lsl #24 	@ must be 16MiB aligned
+	mov	r0, r3, lsr #21		@ constant for add/sub instructions
+	teq	r3, r0, lsl #21 	@ must be 2 MiB aligned
 	bne	0f
 
 	adr_l	r4, __pv_table_begin
@@ -55,22 +55,21 @@ __fixup_a_pv_table:
 	adr_l	r6, __pv_offset
 	ldr	r0, [r6, #HIGH_OFFSET]	@ pv_offset high word
 	ldr	r6, [r6, #LOW_OFFSET]	@ pv_offset low word
-	mov	r6, r6, lsr #24
 	cmn	r0, #1
 #ifdef CONFIG_THUMB2_KERNEL
 	@
 	@ The Thumb-2 versions of the patchable sequences are
 	@
-	@ phys-to-virt:			movw	<reg>, #offset<31:24>
-	@				lsl	<reg>, #24
+	@ phys-to-virt:			movw	<reg>, #offset<31:21>
+	@				lsl	<reg>, #21
 	@				sub	<VA>, <PA>, <reg>
 	@
-	@ virt-to-phys (non-LPAE):	movw	<reg>, #offset<31:24>
-	@				lsl	<reg>, #24
+	@ virt-to-phys (non-LPAE):	movw	<reg>, #offset<31:21>
+	@				lsl	<reg>, #21
 	@				add	<PA>, <VA>, <reg>
 	@
-	@ virt-to-phys (LPAE):		movw	<reg>, #offset<31:24>
-	@				lsl	<reg>, #24
+	@ virt-to-phys (LPAE):		movw	<reg>, #offset<31:21>
+	@				lsl	<reg>, #21
 	@				adds	<PAlo>, <VA>, <reg>
 	@				mov	<PAhi>, #offset<39:32>
 	@				adc	<PAhi>, <PAhi>, #0
@@ -102,6 +101,9 @@ __fixup_a_pv_table:
 	@     +-----------+---+---------------------++---+------+----+------+
 	@
 	moveq	r0, #0x200000		@ set bit 21, mov to mvn instruction
+	lsrs	r3, r6, #29		@ isolate top 3 bits of displacement
+	ubfx	r6, r6, #21, #8		@ put bits 28:21 into the MOVW imm8 field
+	bfi	r6, r3, #12, #3		@ put bits 31:29 into the MOVW imm3 field
 	b	.Lnext
 .Lloop:	add	r7, r4
 	adds	r4, #4			@ clears Z flag
@@ -129,20 +131,24 @@ ARM_BE8(rev16	ip, ip)
 @ in BE8, we load data in BE, but instructions still in LE
 #define PV_BIT24	0x00000001
 #define PV_IMM8_MASK	0xff000000
+#define PV_IMMR_MSB	0x00080000
 #else
 #define PV_BIT24	0x01000000
 #define PV_IMM8_MASK	0x000000ff
+#define PV_IMMR_MSB	0x00000800
 #endif
 
 	@
 	@ The ARM versions of the patchable sequences are
 	@
 	@ phys-to-virt:			sub	<VA>, <PA>, #offset<31:24>, lsl #24
+	@				sub	<VA>, <PA>, #offset<23:16>, lsl #16
 	@
 	@ virt-to-phys (non-LPAE):	add	<PA>, <VA>, #offset<31:24>, lsl #24
+	@				add	<PA>, <VA>, #offset<23:16>, lsl #16
 	@
-	@ virt-to-phys (LPAE):		movw	<reg>, #offset<31:24>
-	@				adds	<PAlo>, <VA>, <reg>, lsl #24
+	@ virt-to-phys (LPAE):		movw	<reg>, #offset<31:20>
+	@				adds	<PAlo>, <VA>, <reg>, lsl #20
 	@				mov	<PAhi>, #offset<39:32>
 	@				adc	<PAhi>, <PAhi>, #0
 	@
@@ -174,6 +180,9 @@ ARM_BE8(rev16	ip, ip)
 	@      +------+-----------------+------+------+-------+
 	@
 	moveq	r0, #0x400000		@ set bit 22, mov to mvn instruction
+	mov	r3, r6, lsr #16		@ put offset bits 31-16 into r3
+	mov	r6, r6, lsr #24		@ put offset bits 31-24 into r6
+	and	r3, r3, #0xf0		@ only keep offset bits 23-20 in r3
 	b	.Lnext
 .Lloop:	ldr	ip, [r7, r4]
 #ifdef CONFIG_ARM_LPAE
@@ -183,14 +192,17 @@ ARM_BE8(rev	ip, ip)
 	tst	ip, #0xc00000		@ MOVW has bits 23:22 clear
 	bic	ip, ip, #0x400000	@ clear bit 22
 	bfc	ip, #0, #12		@ clear imm12 field of MOV[W] instruction
-	orreq	ip, ip, r6		@ MOVW -> mask in offset bits 31-24
+	orreq	ip, ip, r6, lsl #4	@ MOVW -> mask in offset bits 31-24
+	orreq	ip, ip, r3, lsr #4	@ MOVW -> mask in offset bits 23-20
 	orrne	ip, ip, r0		@ MOV  -> mask in offset bits 7-0 (or bit 22)
 ARM_BE8(rev	ip, ip)
 	b	2f
 1:
 #endif
+	tst	ip, #PV_IMMR_MSB		@ rotation value >= 16 ?
 	bic	ip, ip, #PV_IMM8_MASK
-	orr	ip, ip, r6 ARM_BE8(, lsl #24)	@ mask in offset bits 31-24
+	orreq	ip, ip, r6 ARM_BE8(, lsl #24)	@ mask in offset bits 31-24
+	orrne	ip, ip, r3 ARM_BE8(, lsl #24)	@ mask in offset bits 23-20
 2:
 	str	ip, [r7, r4]
 	add	r4, r4, #4
-- 
2.17.1

