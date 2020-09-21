Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACC1272A67
	for <lists+linux-efi@lfdr.de>; Mon, 21 Sep 2020 17:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgIUPl2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Sep 2020 11:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgIUPl2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 21 Sep 2020 11:41:28 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7F9720C09;
        Mon, 21 Sep 2020 15:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600702887;
        bh=2Q2J3pkjPi9pwuuW3DZFXCRtzi9OH766xM3l7EfFRDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFeulH2amAfwq43LXr2Fa48sr4yaLBirZcyuqXOeOj4uhE9Xx5bP/AfQH1ey2bNAq
         buQJWBVaRsPD+Itdfejp/U2z5usgUeftsd1GBf2Gy/2RD0UwcmB41oCgfiXc/+CjVG
         wcbpQLRCTG5Tk9N4lC11zKAqlx1OlllsleCiDMWM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2 03/10] ARM: p2v: move patching code to separate assembler source file
Date:   Mon, 21 Sep 2020 17:41:10 +0200
Message-Id: <20200921154117.757-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921154117.757-1-ardb@kernel.org>
References: <20200921154117.757-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move the phys2virt patching code into a separate .S file before doing
some work on it.

Suggested-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/Makefile    |   1 +
 arch/arm/kernel/head.S      | 138 ------------------
 arch/arm/kernel/phys2virt.S | 151 ++++++++++++++++++++
 3 files changed, 152 insertions(+), 138 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 89e5d864e923..9e465efcc8b6 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_PARAVIRT)	+= paravirt.o
 head-y			:= head$(MMUEXT).o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_ARM_PATCH_PHYS_VIRT)	+= phys2virt.o
 
 # This is executed very early using a temporary stack when no memory allocator
 # nor global data is available. Everything has to be allocated on the stack.
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 98c1e68bdfcb..7e3f36809011 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -586,142 +586,4 @@ ENTRY(fixup_smp)
 	ldmfd	sp!, {r4 - r6, pc}
 ENDPROC(fixup_smp)
 
-#ifdef __ARMEB__
-#define LOW_OFFSET	0x4
-#define HIGH_OFFSET	0x0
-#else
-#define LOW_OFFSET	0x0
-#define HIGH_OFFSET	0x4
-#endif
-
-#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
-
-/* __fixup_pv_table - patch the stub instructions with the delta between
- * PHYS_OFFSET and PAGE_OFFSET, which is assumed to be 16MiB aligned and
- * can be expressed by an immediate shifter operand. The stub instruction
- * has a form of '(add|sub) rd, rn, #imm'.
- */
-	__HEAD
-__fixup_pv_table:
-	adr	r0, 1f
-	ldmia	r0, {r3-r7}
-	mvn	ip, #0
-	subs	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
-	add	r4, r4, r3	@ adjust table start address
-	add	r5, r5, r3	@ adjust table end address
-	add	r6, r6, r3	@ adjust __pv_phys_pfn_offset address
-	add	r7, r7, r3	@ adjust __pv_offset address
-	mov	r0, r8, lsr #PAGE_SHIFT	@ convert to PFN
-	str	r0, [r6]	@ save computed PHYS_OFFSET to __pv_phys_pfn_offset
-	strcc	ip, [r7, #HIGH_OFFSET]	@ save to __pv_offset high bits
-	mov	r6, r3, lsr #24	@ constant for add/sub instructions
-	teq	r3, r6, lsl #24 @ must be 16MiB aligned
-THUMB(	it	ne		@ cross section branch )
-	bne	__error
-	str	r3, [r7, #LOW_OFFSET]	@ save to __pv_offset low bits
-	b	__fixup_a_pv_table
-ENDPROC(__fixup_pv_table)
-
-	.align
-1:	.long	.
-	.long	__pv_table_begin
-	.long	__pv_table_end
-2:	.long	__pv_phys_pfn_offset
-	.long	__pv_offset
-
-	.text
-__fixup_a_pv_table:
-	adr	r0, 3f
-	ldr	r6, [r0]
-	add	r6, r6, r3
-	ldr	r0, [r6, #HIGH_OFFSET]	@ pv_offset high word
-	ldr	r6, [r6, #LOW_OFFSET]	@ pv_offset low word
-	mov	r6, r6, lsr #24
-	cmn	r0, #1
-#ifdef CONFIG_THUMB2_KERNEL
-	moveq	r0, #0x200000	@ set bit 21, mov to mvn instruction
-	lsls	r6, #24
-	beq	2f
-	clz	r7, r6
-	lsr	r6, #24
-	lsl	r6, r7
-	bic	r6, #0x0080
-	lsrs	r7, #1
-	orrcs	r6, #0x0080
-	orr	r6, r6, r7, lsl #12
-	orr	r6, #0x4000
-	b	2f
-1:	add     r7, r3
-	ldrh	ip, [r7, #2]
-ARM_BE8(rev16	ip, ip)
-	tst	ip, #0x4000
-	and	ip, #0x8f00
-	orrne	ip, r6	@ mask in offset bits 31-24
-	orreq	ip, r0	@ mask in offset bits 7-0
-ARM_BE8(rev16	ip, ip)
-	strh	ip, [r7, #2]
-	bne	2f
-	ldrh	ip, [r7]
-ARM_BE8(rev16	ip, ip)
-	bic	ip, #0x20
-	orr	ip, ip, r0, lsr #16
-ARM_BE8(rev16	ip, ip)
-	strh	ip, [r7]
-2:	cmp	r4, r5
-	ldrcc	r7, [r4], #4	@ use branch for delay slot
-	bcc	1b
-	bx	lr
-#else
-	moveq	r0, #0x400000	@ set bit 22, mov to mvn instruction
-	b	2f
-1:	ldr	ip, [r7, r3]
-#ifdef CONFIG_CPU_ENDIAN_BE8
-	@ in BE8, we load data in BE, but instructions still in LE
-	bic	ip, ip, #0xff000000
-	tst	ip, #0x000f0000	@ check the rotation field
-	orrne	ip, ip, r6, lsl #24 @ mask in offset bits 31-24
-	biceq	ip, ip, #0x00004000 @ clear bit 22
-	orreq	ip, ip, r0, ror #8  @ mask in offset bits 7-0
-#else
-	bic	ip, ip, #0x000000ff
-	tst	ip, #0xf00	@ check the rotation field
-	orrne	ip, ip, r6	@ mask in offset bits 31-24
-	biceq	ip, ip, #0x400000	@ clear bit 22
-	orreq	ip, ip, r0	@ mask in offset bits 7-0
-#endif
-	str	ip, [r7, r3]
-2:	cmp	r4, r5
-	ldrcc	r7, [r4], #4	@ use branch for delay slot
-	bcc	1b
-	ret	lr
-#endif
-ENDPROC(__fixup_a_pv_table)
-
-	.align
-3:	.long __pv_offset
-
-ENTRY(fixup_pv_table)
-	stmfd	sp!, {r4 - r7, lr}
-	mov	r3, #0			@ no offset
-	mov	r4, r0			@ r0 = table start
-	add	r5, r0, r1		@ r1 = table size
-	bl	__fixup_a_pv_table
-	ldmfd	sp!, {r4 - r7, pc}
-ENDPROC(fixup_pv_table)
-
-	.data
-	.align	2
-	.globl	__pv_phys_pfn_offset
-	.type	__pv_phys_pfn_offset, %object
-__pv_phys_pfn_offset:
-	.word	0
-	.size	__pv_phys_pfn_offset, . -__pv_phys_pfn_offset
-
-	.globl	__pv_offset
-	.type	__pv_offset, %object
-__pv_offset:
-	.quad	0
-	.size	__pv_offset, . -__pv_offset
-#endif
-
 #include "head-common.S"
diff --git a/arch/arm/kernel/phys2virt.S b/arch/arm/kernel/phys2virt.S
new file mode 100644
index 000000000000..7c17fbfeeedd
--- /dev/null
+++ b/arch/arm/kernel/phys2virt.S
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  Copyright (C) 1994-2002 Russell King
+ *  Copyright (c) 2003 ARM Limited
+ *  All Rights Reserved
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/page.h>
+
+#ifdef __ARMEB__
+#define LOW_OFFSET	0x4
+#define HIGH_OFFSET	0x0
+#else
+#define LOW_OFFSET	0x0
+#define HIGH_OFFSET	0x4
+#endif
+
+/*
+ * __fixup_pv_table - patch the stub instructions with the delta between
+ *                    PHYS_OFFSET and PAGE_OFFSET, which is assumed to be
+ *                    16MiB aligned.
+ *
+ * Called from head.S, which expects the following registers to be preserved:
+ *   r1 = machine no, r2 = atags or dtb,
+ *   r8 = phys_offset, r9 = cpuid, r10 = procinfo
+ */
+	__HEAD
+ENTRY(__fixup_pv_table)
+	adr	r0, 1f
+	ldmia	r0, {r3-r7}
+	mvn	ip, #0
+	subs	r3, r0, r3		@ PHYS_OFFSET - PAGE_OFFSET
+	add	r4, r4, r3		@ adjust table start address
+	add	r5, r5, r3		@ adjust table end address
+	add	r6, r6, r3		@ adjust __pv_phys_pfn_offset address
+	add	r7, r7, r3		@ adjust __pv_offset address
+	mov	r0, r8, lsr #PAGE_SHIFT	@ convert to PFN
+	str	r0, [r6]		@ save computed PHYS_OFFSET to __pv_phys_pfn_offset
+	strcc	ip, [r7, #HIGH_OFFSET]	@ save to __pv_offset high bits
+	mov	r6, r3, lsr #24		@ constant for add/sub instructions
+	teq	r3, r6, lsl #24 	@ must be 16MiB aligned
+	bne	0f
+	str	r3, [r7, #LOW_OFFSET]	@ save to __pv_offset low bits
+	b	__fixup_a_pv_table
+0:	mov	r0, r0			@ deadloop on error
+	b	0b
+ENDPROC(__fixup_pv_table)
+
+	.align
+1:	.long	.
+	.long	__pv_table_begin
+	.long	__pv_table_end
+2:	.long	__pv_phys_pfn_offset
+	.long	__pv_offset
+
+	.text
+__fixup_a_pv_table:
+	adr	r0, 3f
+	ldr	r6, [r0]
+	add	r6, r6, r3
+	ldr	r0, [r6, #HIGH_OFFSET]	@ pv_offset high word
+	ldr	r6, [r6, #LOW_OFFSET]	@ pv_offset low word
+	mov	r6, r6, lsr #24
+	cmn	r0, #1
+#ifdef CONFIG_THUMB2_KERNEL
+	moveq	r0, #0x200000		@ set bit 21, mov to mvn instruction
+	lsls	r6, #24
+	beq	2f
+	clz	r7, r6
+	lsr	r6, #24
+	lsl	r6, r7
+	bic	r6, #0x0080
+	lsrs	r7, #1
+	orrcs	r6, #0x0080
+	orr	r6, r6, r7, lsl #12
+	orr	r6, #0x4000
+	b	2f
+1:	add	r7, r3
+	ldrh	ip, [r7, #2]
+ARM_BE8(rev16	ip, ip)
+	tst	ip, #0x4000
+	and	ip, #0x8f00
+	orrne	ip, r6			@ mask in offset bits 31-24
+	orreq	ip, r0			@ mask in offset bits 7-0
+ARM_BE8(rev16	ip, ip)
+	strh	ip, [r7, #2]
+	bne	2f
+	ldrh	ip, [r7]
+ARM_BE8(rev16	ip, ip)
+	bic	ip, #0x20
+	orr	ip, ip, r0, lsr #16
+ARM_BE8(rev16	ip, ip)
+	strh	ip, [r7]
+2:	cmp	r4, r5
+	ldrcc	r7, [r4], #4		@ use branch for delay slot
+	bcc	1b
+	bx	lr
+#else
+	moveq	r0, #0x400000		@ set bit 22, mov to mvn instruction
+	b	2f
+1:	ldr	ip, [r7, r3]
+#ifdef CONFIG_CPU_ENDIAN_BE8
+	@ in BE8, we load data in BE, but instructions still in LE
+	bic	ip, ip, #0xff000000
+	tst	ip, #0x000f0000		@ check the rotation field
+	orrne	ip, ip, r6, lsl #24	@ mask in offset bits 31-24
+	biceq	ip, ip, #0x00004000	@ clear bit 22
+	orreq	ip, ip, r0, ror #8	@ mask in offset bits 7-0
+#else
+	bic	ip, ip, #0x000000ff
+	tst	ip, #0xf00		@ check the rotation field
+	orrne	ip, ip, r6		@ mask in offset bits 31-24
+	biceq	ip, ip, #0x400000	@ clear bit 22
+	orreq	ip, ip, r0		@ mask in offset bits 7-0
+#endif
+	str	ip, [r7, r3]
+2:	cmp	r4, r5
+	ldrcc	r7, [r4], #4		@ use branch for delay slot
+	bcc	1b
+	ret	lr
+#endif
+ENDPROC(__fixup_a_pv_table)
+
+	.align
+3:	.long __pv_offset
+
+ENTRY(fixup_pv_table)
+	stmfd	sp!, {r4 - r7, lr}
+	mov	r3, #0			@ no offset
+	mov	r4, r0			@ r0 = table start
+	add	r5, r0, r1		@ r1 = table size
+	bl	__fixup_a_pv_table
+	ldmfd	sp!, {r4 - r7, pc}
+ENDPROC(fixup_pv_table)
+
+	.data
+	.align	2
+	.globl	__pv_phys_pfn_offset
+	.type	__pv_phys_pfn_offset, %object
+__pv_phys_pfn_offset:
+	.word	0
+	.size	__pv_phys_pfn_offset, . -__pv_phys_pfn_offset
+
+	.globl	__pv_offset
+	.type	__pv_offset, %object
+__pv_offset:
+	.quad	0
+	.size	__pv_offset, . -__pv_offset
-- 
2.17.1

