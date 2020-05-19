Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E431D9C8A
	for <lists+linux-efi@lfdr.de>; Tue, 19 May 2020 18:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgESQ1C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 May 2020 12:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgESQ1C (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 19 May 2020 12:27:02 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD43020823;
        Tue, 19 May 2020 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905622;
        bh=s1wJAwkrmgG1XjwsUm3v1xaTI0ARm6WW9gEhCur/Ryw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mhf8scZPUYtvuTAvYm0QeYPePZdh7+Qux7I5nVnoKRYC68hXA3BXA0qAJ9dsc1p9r
         9FWz0qdGsTrIN4XttXlX8Ln5odkrizRT2Qrw3dLYhZy5x3dSB1TjRGi2F3wMH4HbX+
         eYqJSh29BI3rsCG/YQiRg9kmaUumjQ3a7f2MiwTU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 1/5] ARM: decompressor: move headroom variable out of LC0
Date:   Tue, 19 May 2020 18:26:41 +0200
Message-Id: <20200519162645.31065-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519162645.31065-1-ardb@kernel.org>
References: <20200519162645.31065-1-ardb@kernel.org>
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
index cabdd8f4a248..42b8d67beab6 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -287,7 +287,7 @@ not_angel:
 		 */
 		mov	r0, pc
 		cmp	r0, r4
-		ldrcc	r0, LC0+28
+		ldrcc	r0, .Lheadroom
 		addcc	r0, r0, pc
 		cmpcc	r4, r0
 		orrcc	r4, r4, #1		@ remember we skipped cache_on
@@ -664,9 +664,11 @@ LC0:		.word	LC0			@ r1
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

