Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BBD272A66
	for <lists+linux-efi@lfdr.de>; Mon, 21 Sep 2020 17:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgIUPl0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Sep 2020 11:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgIUPl0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 21 Sep 2020 11:41:26 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFFA620BED;
        Mon, 21 Sep 2020 15:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600702885;
        bh=Dg5u2kf0doqXVb9GFWxO59d9DvOEiGCZBy9thesMlSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJc5BlNO3yk3JhdK7O2s7yZSGVvUI002GdZVbTAcGoDwhlUvPdtPeTed1mU8i7w69
         4KyvqJefOCo4DAnMvDgve9EvnAJswC0sAiA3nsXGfTZS3SL6QvCRtrOfyow5PtdVQb
         HoGR1l5ZFvu01F/N3LOJrQwVd8mtFhB1oVGIwxGo=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2 02/10] ARM: assembler: introduce adr_l, ldr_l and str_l macros
Date:   Mon, 21 Sep 2020 17:41:09 +0200
Message-Id: <20200921154117.757-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921154117.757-1-ardb@kernel.org>
References: <20200921154117.757-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Like arm64, ARM supports position independent code sequences that
produce symbol references with a greater reach than the ordinary
adr/ldr instructions. Since on ARM, the adrl pseudo-instruction is
only supported in ARM mode (and not at all when using Clang), having
a adr_l macro like we do on arm64 is useful, and increases symmetry
as well.

Currently, we use open coded instruction sequences involving literals
and arithmetic operations. Instead, we can use movw/movt pairs on v7
CPUs, circumventing the D-cache entirely.

E.g., on v7+ CPUs, we can emit a PC-relative reference as follows:

       movw         <reg>, #:lower16:<sym> - (1f + 8)
       movt         <reg>, #:upper16:<sym> - (1f + 8)
  1:   add          <reg>, <reg>, pc

For older CPUs, we can emit the literal into a subsection, allowing it
to be emitted out of line while retaining the ability to perform
arithmetic on label offsets.

E.g., on pre-v7 CPUs, we can emit a PC-relative reference as follows:

       ldr          <reg>, 2f
  1:   add          <reg>, <reg>, pc
       .subsection  1
  2:   .long        <sym> - (1b + 8)
       .previous

This is allowed by the assembler because, unlike ordinary sections,
subsections are combined into a single section in the object file, and
so the label references are not true cross-section references that are
visible as relocations. (Subsections have been available in binutils
since 2004 at least, so they should not cause any issues with older
toolchains.)

So use the above to implement the macros mov_l, adr_l, ldr_l and str_l,
all of which will use movw/movt pairs on v7 and later CPUs, and use
PC-relative literals otherwise.

Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/assembler.h | 84 ++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index feac2c8b86f2..72627c5fb3b2 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -494,4 +494,88 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #define _ASM_NOKPROBE(entry)
 #endif
 
+	.macro		__adldst_l, op, reg, sym, tmp, c
+	.if		__LINUX_ARM_ARCH__ < 7
+	ldr\c		\tmp, .La\@
+	.subsection	1
+	.align		2
+.La\@:	.long		\sym - .Lpc\@
+	.previous
+	.else
+	.ifnb		\c
+ THUMB(	ittt		\c			)
+	.endif
+	movw\c		\tmp, #:lower16:\sym - .Lpc\@
+	movt\c		\tmp, #:upper16:\sym - .Lpc\@
+	.endif
+
+#ifndef CONFIG_THUMB2_KERNEL
+	.set		.Lpc\@, . + 8			// PC bias
+	.ifc		\op, add
+	add\c		\reg, \tmp, pc
+	.else
+	\op\c		\reg, [pc, \tmp]
+	.endif
+#else
+.Lb\@:	add\c		\tmp, \tmp, pc
+	/*
+	 * In Thumb-2 builds, the PC bias depends on whether we are currently
+	 * emitting into a .arm or a .thumb section. The size of the add opcode
+	 * above will be 2 bytes when emitting in Thumb mode and 4 bytes when
+	 * emitting in ARM mode, so let's use this to account for the bias.
+	 */
+	.set		.Lpc\@, . + (. - .Lb\@)
+
+	.ifnc		\op, add
+	\op\c		\reg, [\tmp]
+	.endif
+#endif
+	.endm
+
+	/*
+	 * mov_l - move a constant value or [relocated] address into a register
+	 */
+	.macro		mov_l, dst:req, imm:req
+	.if		__LINUX_ARM_ARCH__ < 7
+	ldr		\dst, =\imm
+	.else
+	movw		\dst, #:lower16:\imm
+	movt		\dst, #:upper16:\imm
+	.endif
+	.endm
+
+	/*
+	 * adr_l - adr pseudo-op with unlimited range
+	 *
+	 * @dst: destination register
+	 * @sym: name of the symbol
+	 * @cond: conditional opcode suffix
+	 */
+	.macro		adr_l, dst:req, sym:req, cond
+	__adldst_l	add, \dst, \sym, \dst, \cond
+	.endm
+
+	/*
+	 * ldr_l - ldr <literal> pseudo-op with unlimited range
+	 *
+	 * @dst: destination register
+	 * @sym: name of the symbol
+	 * @cond: conditional opcode suffix
+	 */
+	.macro		ldr_l, dst:req, sym:req, cond
+	__adldst_l	ldr, \dst, \sym, \dst, \cond
+	.endm
+
+	/*
+	 * str_l - str <literal> pseudo-op with unlimited range
+	 *
+	 * @src: source register
+	 * @sym: name of the symbol
+	 * @tmp: mandatory scratch register
+	 * @cond: conditional opcode suffix
+	 */
+	.macro		str_l, src:req, sym:req, tmp:req, cond
+	__adldst_l	str, \src, \sym, \tmp, \cond
+	.endm
+
 #endif /* __ASM_ASSEMBLER_H__ */
-- 
2.17.1

