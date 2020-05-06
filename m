Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5881C6B5C
	for <lists+linux-efi@lfdr.de>; Wed,  6 May 2020 10:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgEFITy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 May 2020 04:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbgEFITw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 6 May 2020 04:19:52 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF91D206E6;
        Wed,  6 May 2020 08:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588753192;
        bh=+SDKOkKg1ZVm776EJnD5TocZ5JZYu6XB9fPUJmWVkEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7RUbhXRbrB3Li/B6+aTYZBzPWW0zBHo8mlxoPYe9a4TsrqjmQEaYj0XG70gXkU4Y
         AMD+NV0UAgbLq/QCU3tVU6fAT8Oks+2vz+BcNtL0SkpHc2FfFabaITWdKO6O1g1ggL
         tKavAHWBRbeOownHlPTga6bo66nH6EA9Nrt96pEI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 1/5] ARM: decompressor: move headroom variable out of LC0
Date:   Wed,  6 May 2020 10:19:35 +0200
Message-Id: <20200506081939.8986-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506081939.8986-1-ardb@kernel.org>
References: <20200506081939.8986-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Before breaking up LC0 into different pieces, move out the variable
that is already place-relative (given that it subtracts 'restart' in
the expression) and so its value does not need to be added to the
runtime address of the LC0 symbol itself.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/boot/compressed/head.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 2d2a42865b39..bb674febf640 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -339,7 +339,7 @@ not_angel:
 		 */
 		mov	r0, pc
 		cmp	r0, r4
-		ldrcc	r0, LC0+28
+		ldrcc	r0, .Lheadroom
 		addcc	r0, r0, pc
 		cmpcc	r4, r0
 		orrcc	r4, r4, #1		@ remember we skipped cache_on
@@ -716,9 +716,11 @@ LC0:		.word	LC0			@ r1
 		.word	_got_start		@ r11
 		.word	_got_end		@ ip
 		.word	.L_user_stack_end	@ sp
-		.word	_end - restart + 16384 + 1024*1024
 		.size	LC0, . - LC0
 
+.Lheadroom:
+		.word	_end - restart + 16384 + 1024*1024
+
 .Linflated_image_size_offset:
 		.long	(input_data_end - 4) - .
 
-- 
2.17.1

