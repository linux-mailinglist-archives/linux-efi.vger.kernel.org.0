Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0993D26FA9C
	for <lists+linux-efi@lfdr.de>; Fri, 18 Sep 2020 12:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgIRKbZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Sep 2020 06:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRKbZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 18 Sep 2020 06:31:25 -0400
Received: from e123331-lin.nice.arm.com (adsl-119.109.242.22.tellas.gr [109.242.22.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79A3322208;
        Fri, 18 Sep 2020 10:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600425084;
        bh=vyE2JMb5hyBMGie5mlmu3yKOjeGbz4WWo/MRJCaLl3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cl60EmcxqU3HqyvCSQHAWfp9g3gWOZh2QSWbCsIy/KykLLhI2haWVWeVa/83YgiDc
         lkNTWXm9/19oUDs2Ydzt+D1h5bTmfF9BBLW6w8OaYi2Ljpdl3JfJ5XcEm6l8LMH3s2
         Nl6ONVvDpXwVh6Yi93gmhV6cZsD5kznEZqH5aG0k=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [RFC/RFT PATCH 5/6] ARM: p2v: switch to MOVW for Thumb2 and ARM/LPAE
Date:   Fri, 18 Sep 2020 13:31:01 +0300
Message-Id: <20200918103102.18107-6-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918103102.18107-1-ardb@kernel.org>
References: <20200918103102.18107-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for reducing the phys-to-virt minimum relative alignment
from 16 MiB to 2 MiB, switch to patchable sequences involving MOVW
instructions that can more easily be manipulated to carry a 12-bit
immediate. Note that the non-LPAE ARM sequence is not updated: MOVW
may not be supported on non-LPAE platforms, and the sequence itself
can be updated more easily to apply the 12 bits of displacement.

For Thumb2, which has many more versions of opcodes, switch to a sequence
that can be patched by the same patching code for both versions, and use
asm constraints and S-suffixed opcodes to force narrow encodings to be
selected.

Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/memory.h | 43 +++++++++++----
 arch/arm/kernel/head.S        | 57 +++++++++++++-------
 2 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 4121662dea5a..7184a2540816 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -183,6 +183,7 @@ extern const void *__pv_table_begin, *__pv_table_end;
 #define PHYS_OFFSET	((phys_addr_t)__pv_phys_pfn_offset << PAGE_SHIFT)
 #define PHYS_PFN_OFFSET	(__pv_phys_pfn_offset)
 
+#ifndef CONFIG_THUMB2_KERNEL
 #define __pv_stub(from,to,instr)			\
 	__asm__("@ __pv_stub\n"				\
 	"1:	" instr "	%0, %1, %2\n"		\
@@ -192,25 +193,46 @@ extern const void *__pv_table_begin, *__pv_table_end;
 	: "=r" (to)					\
 	: "r" (from), "I" (__PV_BITS_31_24))
 
-#define __pv_stub_mov_hi(t)				\
-	__asm__ volatile("@ __pv_stub_mov\n"		\
-	"1:	mov	%R0, %1\n"			\
+#define __pv_add_carry_stub(x, y)			\
+	__asm__ volatile("@ __pv_add_carry_stub\n"	\
+	"0:	movw	%R0, %2\n"			\
+	"1:	adds	%Q0, %1, %R0, lsl #24\n"	\
+	"2:	mov	%R0, %3\n"			\
+	"	adc	%R0, %R0, #0\n"			\
 	"	.pushsection .pv_table,\"a\"\n"		\
-	"	.long	1b - .\n"			\
+	"	.long	0b - ., 1b - ., 2b - .\n"	\
 	"	.popsection\n"				\
-	: "=r" (t)					\
-	: "I" (__PV_BITS_7_0))
+	: "=&r" (y)					\
+	: "r" (x), "j" (0), "I" (__PV_BITS_7_0)		\
+	: "cc")
+
+#else
+#define __pv_stub(from,to,instr)			\
+	__asm__("@ __pv_stub\n"				\
+	"0:	movw	%0, %2\n"			\
+	"	lsls	%0, #24\n"			\
+	"	" instr "s %0, %1, %0\n"		\
+	"	.pushsection .pv_table,\"a\"\n"		\
+	"	.long	0b - .\n"			\
+	"	.popsection\n"				\
+	: "=&l" (to)					\
+	: "l" (from), "j" (0)				\
+	: "cc")
 
 #define __pv_add_carry_stub(x, y)			\
 	__asm__ volatile("@ __pv_add_carry_stub\n"	\
-	"1:	adds	%Q0, %1, %2\n"			\
+	"0:	movw	%R0, %2\n"			\
+	"	lsls	%R0, #24\n"			\
+	"	adds	%Q0, %1, %R0\n"			\
+	"1:	mvn	%R0, #0\n"			\
 	"	adc	%R0, %R0, #0\n"			\
 	"	.pushsection .pv_table,\"a\"\n"		\
-	"	.long	1b - .\n"			\
+	"	.long	0b - ., 1b - .\n"		\
 	"	.popsection\n"				\
-	: "+r" (y)					\
-	: "r" (x), "I" (__PV_BITS_31_24)		\
+	: "=&l" (y)					\
+	: "l" (x), "j" (0)				\
 	: "cc")
+#endif
 
 static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
 {
@@ -219,7 +241,6 @@ static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
 	if (sizeof(phys_addr_t) == 4) {
 		__pv_stub(x, t, "add");
 	} else {
-		__pv_stub_mov_hi(t);
 		__pv_add_carry_stub(x, t);
 	}
 	return t;
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index d2bd3b258386..86cea608a5ea 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -639,43 +639,45 @@ __fixup_a_pv_table:
 	mov	r6, r6, lsr #24
 	cmn	r0, #1
 #ifdef CONFIG_THUMB2_KERNEL
-	moveq	r0, #0x200000	@ set bit 21, mov to mvn instruction
-	lsls	r6, #24
-	beq	.Lnext
-	clz	r7, r6
-	lsr	r6, #24
-	lsl	r6, r7
-	bic	r6, #0x0080
-	lsrs	r7, #1
-	orrcs	r6, #0x0080
-	orr	r6, r6, r7, lsl #12
-	orr	r6, #0x4000
+	moveq	r0, #0x200	@ bit 9, ADD to SUB instruction (T1 encoding)
 	b	.Lnext
 .Lloop:	add	r7, r4
 	add	r4, #4
+#ifdef CONFIG_ARM_LPAE
+	ldrh	ip, [r7]
+ARM_BE8(rev16	ip, ip)
+	tst	ip, #0x200	@ MOVW has bit 9 set, MVN has it clear
+	bne	0f		@ skip if MOVW
+	tst	r0, #0x200	@ need to convert MVN to MOV ?
+	bne	.Lnext
+	eor	ip, ip, #0x20	@ flick bit #5
+ARM_BE8(rev16	ip, ip)
+	strh	ip, [r7]
+	b	.Lnext
+0:
+#endif
 	ldrh	ip, [r7, #2]
 ARM_BE8(rev16	ip, ip)
-	tst	ip, #0x4000
-	and	ip, #0x8f00
-	orrne	ip, r6	@ mask in offset bits 31-24
-	orreq	ip, r0	@ mask in offset bits 7-0
+	orr	ip, r6	@ mask in offset bits 31-24
 ARM_BE8(rev16	ip, ip)
 	strh	ip, [r7, #2]
-	bne	.Lnext
-	ldrh	ip, [r7]
+	ldrh	ip, [r7, #6]
 ARM_BE8(rev16	ip, ip)
-	bic	ip, #0x20
-	orr	ip, ip, r0, lsr #16
+	eor	ip, ip, r0
 ARM_BE8(rev16	ip, ip)
-	strh	ip, [r7]
+	strh	ip, [r7, #6]
 #else
 #ifdef CONFIG_CPU_ENDIAN_BE8
 @ in BE8, we load data in BE, but instructions still in LE
+#define PV_BIT20	0x00001000
 #define PV_BIT22	0x00004000
+#define PV_BIT23_22	0x0000c000
 #define PV_IMM8_MASK	0xff000000
 #define PV_ROT_MASK	0x000f0000
 #else
+#define PV_BIT20	0x00100000
 #define PV_BIT22	0x00400000
+#define PV_BIT23_22	0x00c00000
 #define PV_IMM8_MASK	0x000000ff
 #define PV_ROT_MASK	0xf00
 #endif
@@ -683,11 +685,26 @@ ARM_BE8(rev16	ip, ip)
 	moveq	r0, #PV_BIT22	@ set bit 22, mov to mvn instruction
 	b	.Lnext
 .Lloop:	ldr	ip, [r7, r4]
+#ifdef CONFIG_ARM_LPAE
+	tst	ip, #PV_BIT23_22	@ MOVW has bit 23:22 clear, MOV/ADD/SUB have it set
+ARM_BE8(rev	ip, ip)
+	orreq	ip, ip, r6
+ARM_BE8(rev	ip, ip)
+	beq	2f
+	tst	ip, #PV_BIT20		@ ADDS has bit 20 set
+	beq	1f
+	tst	r0, #PV_BIT22		@ check whether to invert bits 23:22 (ADD -> SUB)
+	beq	.Lnext
+	eor	ip, ip, #PV_BIT23_22
+	b	2f
+1:
+#endif
 	bic	ip, ip, #PV_IMM8_MASK
 	tst	ip, #PV_ROT_MASK		@ check the rotation field
 	orrne	ip, ip, r6 ARM_BE8(, lsl #24)	@ mask in offset bits 31-24
 	biceq	ip, ip, #PV_BIT22		@ clear bit 22
 	orreq	ip, ip, r0			@ mask in offset bits 7-0
+2:
 	str	ip, [r7, r4]
 	add	r4, r4, #4
 #endif
-- 
2.17.1

