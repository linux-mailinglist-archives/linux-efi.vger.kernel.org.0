Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308FB2688E3
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgINJ6A (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 05:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgINJ54 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 05:57:56 -0400
Received: from e123331-lin.nice.arm.com (unknown [37.6.197.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAF0620732;
        Mon, 14 Sep 2020 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600077476;
        bh=NieCvGRheFFDbEqkhq2wZXvPlHLF2jc+r0dsBAFUpts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrTJe8wuKdcrh7xrNMc0YSktFTDDzj+c+yI2G+rxxmUXFmnSKkCuEEhenYNlYa53F
         ichgvGT2PD2zpwx3Ft9oV9fdgmugIi3xY769bkJO9T1N8Iv7DlkOXZxq6Ki9WN1w1E
         l6La3wbzAz4w+QT/eYKCXYS8+czinU9wCbX2WOQ0=
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
Subject: [PATCH 08/12] ARM: head: use PC-relative insn sequence for __smp_alt
Date:   Mon, 14 Sep 2020 12:57:02 +0300
Message-Id: <20200914095706.3985-9-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914095706.3985-1-ardb@kernel.org>
References: <20200914095706.3985-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that calling __do_fixup_smp_on_up() can be done without passing
the physical-to-virtual offset in r3, we can replace the open coded
PC relative offset calculations with a pair of adr_l invocations. This
removes some open coded arithmetic involving virtual addresses, avoids
literal pools on v7+, and slightly reduces the footprint of the code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/head.S | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 3199d29f4480..5f6436a40db1 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -520,19 +520,11 @@ ARM_BE8(rev	r0, r0)			@ byteswap if big endian
 	retne	lr
 
 __fixup_smp_on_up:
-	adr	r0, 1f
-	ldmia	r0, {r3 - r5}
-	sub	r3, r0, r3
-	add	r4, r4, r3
-	add	r5, r5, r3
+	adr_l	r4, __smpalt_begin
+	adr_l	r5, __smpalt_end
 	b	__do_fixup_smp_on_up
 ENDPROC(__fixup_smp)
 
-	.align
-1:	.word	.
-	.word	__smpalt_begin
-	.word	__smpalt_end
-
 	.pushsection .data
 	.align	2
 	.globl	smp_on_up
-- 
2.17.1

