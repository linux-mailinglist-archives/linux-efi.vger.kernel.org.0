Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24A82688E2
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 11:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgINJ5x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 05:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgINJ5w (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 05:57:52 -0400
Received: from e123331-lin.nice.arm.com (unknown [37.6.197.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5FFC2192A;
        Mon, 14 Sep 2020 09:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600077472;
        bh=u7TD29lBVdWQbA3GzMFPceuNUB1SGypYpG0ugzyHUTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=boLmDRWhAt/1DLUDpeKIogG0PvTDqM03bPhqB25bjN+vXNo3fg2FCxOSlrdW+Zdn5
         Zn9IxzEPtzvhJtWD5CgQa/M9adf+JT+LTefpfDkMqYE8AQNosAtkobipv7wzB8NUZ2
         IcoQ2zNt2Ugp7lqiYJAomyi5xlXXkZvEa3oC6134=
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
Subject: [PATCH 07/12] ARM: kernel: use relative references for UP/SMP alternatives
Date:   Mon, 14 Sep 2020 12:57:01 +0300
Message-Id: <20200914095706.3985-8-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914095706.3985-1-ardb@kernel.org>
References: <20200914095706.3985-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, the .alt.smp.init section contains the virtual addresses
of the patch sites. Since patching may occur both before and after
switching into virtual mode, this requires some manual handling of
the address when applying the UP alternative.

Let's simplify this by using relative offsets in the table entries:
this allows us to simply add each entry's address to its contents,
regardless of whether we are running in virtual mode or not.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/assembler.h |  4 ++--
 arch/arm/include/asm/processor.h |  2 +-
 arch/arm/kernel/head.S           | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 39e972eaaa3f..bf7501dfcb71 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -259,7 +259,7 @@
  */
 #define ALT_UP(instr...)					\
 	.pushsection ".alt.smp.init", "a"			;\
-	.long	9998b						;\
+	.long	9998b - .					;\
 9997:	instr							;\
 	.if . - 9997b == 2					;\
 		nop						;\
@@ -270,7 +270,7 @@
 	.popsection
 #define ALT_UP_B(label)					\
 	.pushsection ".alt.smp.init", "a"			;\
-	.long	9998b						;\
+	.long	9998b - .					;\
 	W(b)	. + (label - 9998b)					;\
 	.popsection
 #else
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index b9241051e5cb..9e6b97286307 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -96,7 +96,7 @@ unsigned long get_wchan(struct task_struct *p);
 #define __ALT_SMP_ASM(smp, up)						\
 	"9998:	" smp "\n"						\
 	"	.pushsection \".alt.smp.init\", \"a\"\n"		\
-	"	.long	9998b\n"					\
+	"	.long	9998b - .\n"					\
 	"	" up "\n"						\
 	"	.popsection\n"
 #else
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 40407a4727e0..3199d29f4480 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -546,14 +546,15 @@ smp_on_up:
 __do_fixup_smp_on_up:
 	cmp	r4, r5
 	reths	lr
-	ldmia	r4!, {r0, r6}
- ARM(	str	r6, [r0, r3]	)
- THUMB(	add	r0, r0, r3	)
+	ldmia	r4, {r0, r6}
+ ARM(	str	r6, [r0, r4]	)
+ THUMB(	add	r0, r0, r4	)
+	add	r4, r4, #8
 #ifdef __ARMEB__
  THUMB(	mov	r6, r6, ror #16	)	@ Convert word order for big-endian.
 #endif
  THUMB(	strh	r6, [r0], #2	)	@ For Thumb-2, store as two halfwords
- THUMB(	mov	r6, r6, lsr #16	)	@ to be robust against misaligned r3.
+ THUMB(	mov	r6, r6, lsr #16	)	@ to be robust against misaligned r0.
  THUMB(	strh	r6, [r0]	)
 	b	__do_fixup_smp_on_up
 ENDPROC(__do_fixup_smp_on_up)
@@ -562,7 +563,6 @@ ENTRY(fixup_smp)
 	stmfd	sp!, {r4 - r6, lr}
 	mov	r4, r0
 	add	r5, r0, r1
-	mov	r3, #0
 	bl	__do_fixup_smp_on_up
 	ldmfd	sp!, {r4 - r6, pc}
 ENDPROC(fixup_smp)
-- 
2.17.1

