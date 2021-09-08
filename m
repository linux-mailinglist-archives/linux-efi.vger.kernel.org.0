Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C93403D90
	for <lists+linux-efi@lfdr.de>; Wed,  8 Sep 2021 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347729AbhIHQ1d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Sep 2021 12:27:33 -0400
Received: from foss.arm.com ([217.140.110.172]:48646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238352AbhIHQ1c (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 8 Sep 2021 12:27:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64B231FB;
        Wed,  8 Sep 2021 09:26:24 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 108923F766;
        Wed,  8 Sep 2021 09:26:22 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Adam Lackorzynski <adam@l4re.org>,
        Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] ARM: decompressor: Avoid UNPREDICTABLE NOP encoding
Date:   Wed,  8 Sep 2021 17:26:17 +0100
Message-Id: <20210908162617.104962-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In the decompressor's head.S we need to start with an instruction that
is some kind of NOP, but also mimics as the PE/COFF header, when the
kernel is linked as an UEFI application. The clever solution here is
"tstne r0, #0x4d000", which in the worst case just clobbers the
condition flags, and bears the magic "MZ" signature in the lowest 16 bits.

However the encoding used (0x13105a4d) is actually not valid, since bits
[15:12] are supposed to be 0 (written as "(0)" in the ARM ARM).
Violating this is UNPREDICTABLE, and *can* trigger an UNDEFINED
exception. Common Cortex cores seem to ignore those bits, but QEMU
chooses to trap, so the code goes fishing because of a missing exception
handler at this point. We are just saved by the fact that commonly (with
-kernel or when running from U-Boot) the "Z" bit is set, so the
instruction is never executed. See [0] for more details.

To make things more robust and avoid UNPREDICTABLE behaviour in the
kernel code, lets replace this with a "two-instruction NOP":
The first instruction is an exclusive OR, the effect of which the second
instruction reverts. This does not leave any trace, neither in a
register nor in the condition flags. Also it's a perfectly valid
encoding. Kudos to Peter Maydell for coming up with this gem.

[0] https://lore.kernel.org/qemu-devel/YTPIdbUCmwagL5%2FD@os.inf.tu-dresden.de/T/

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reported-by: Adam Lackorzynski <adam@l4re.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
---
 arch/arm/boot/compressed/efi-header.S | 22 ++++++++++++++--------
 arch/arm/boot/compressed/head.S       |  3 ++-
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
index c0e7a745103e..230030c13085 100644
--- a/arch/arm/boot/compressed/efi-header.S
+++ b/arch/arm/boot/compressed/efi-header.S
@@ -9,16 +9,22 @@
 #include <linux/sizes.h>
 
 		.macro	__nop
-#ifdef CONFIG_EFI_STUB
-		@ This is almost but not quite a NOP, since it does clobber the
-		@ condition flags. But it is the best we can do for EFI, since
-		@ PE/COFF expects the magic string "MZ" at offset 0, while the
-		@ ARM/Linux boot protocol expects an executable instruction
-		@ there.
-		.inst	MZ_MAGIC | (0x1310 << 16)	@ tstne r0, #0x4d000
-#else
  AR_CLASS(	mov	r0, r0		)
   M_CLASS(	nop.w			)
+		.endm
+
+		.macro __initial_nops
+#ifdef CONFIG_EFI_STUB
+		@ This is a two-instruction NOP, which happens to bear the
+		@ PE/COFF signature "MZ" in the first two bytes, so the kernel
+		@ is accepted as an EFI binary. Booting via the UEFI stub
+		@ will not execute those instructions, but the ARM/Linux
+		@ boot protocol does, so we need some NOPs here.
+		.inst	MZ_MAGIC | (0xe225 << 16)	@ eor r5, r5, 0x4d000
+		eor	r5, r5, 0x4d000			@ undo previous insn
+#else
+		__nop
+		__nop
 #endif
 		.endm
 
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index b1cb1972361b..bf79f2f78d23 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -203,7 +203,8 @@ start:
 		 * were patching the initial instructions of the kernel, i.e
 		 * had started to exploit this "patch area".
 		 */
-		.rept	7
+		__initial_nops
+		.rept	5
 		__nop
 		.endr
 #ifndef CONFIG_THUMB2_KERNEL
-- 
2.17.1

