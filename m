Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA41C2688E0
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 11:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgINJ5q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 05:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgINJ5o (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 05:57:44 -0400
Received: from e123331-lin.nice.arm.com (unknown [37.6.197.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5F7A20735;
        Mon, 14 Sep 2020 09:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600077464;
        bh=mU9/9x1O6YKMA2zUjk1QSnbr763vPH9pqbMnLzcEujo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kIowCm0B0ooiGfLVD9EW6E2VubGM00hkW4OKyTzCn2TC78NIJNm/+WZFRijr0Q6hX
         5QEHjEr/vu7ZoA+MIkalnoyl3xsfSaKLWG0HBhzpb9cfj6P1eoQ6id+rhUIaHeKOQn
         0ljxPT3uDHU73yyas78LY2h8FLKET3Yz6ITJsFpw=
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
Subject: [PATCH 05/12] ARM: head-common.S: use PC-relative insn sequence for idmap creation
Date:   Mon, 14 Sep 2020 12:56:59 +0300
Message-Id: <20200914095706.3985-6-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914095706.3985-1-ardb@kernel.org>
References: <20200914095706.3985-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Replace the open coded PC relative offset calculations involving
__turn_mmu_on and __turn_mmu_on_end with a pair of adr_l invocations.
This removes some open coded arithmetic involving virtual addresses,
avoids literal pools on v7+, and slightly reduces the footprint of the
code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/head.S | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f8904227e7fd..7d8e2a296216 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -224,11 +224,8 @@ __create_page_tables:
 	 * Create identity mapping to cater for __enable_mmu.
 	 * This identity mapping will be removed by paging_init().
 	 */
-	adr	r0, __turn_mmu_on_loc
-	ldmia	r0, {r3, r5, r6}
-	sub	r0, r0, r3			@ virt->phys offset
-	add	r5, r5, r0			@ phys __turn_mmu_on
-	add	r6, r6, r0			@ phys __turn_mmu_on_end
+	adr_l	r5, __turn_mmu_on		@ _pa(__turn_mmu_on)
+	adr_l	r6, __turn_mmu_on_end		@ _pa(__turn_mmu_on_end)
 	mov	r5, r5, lsr #SECTION_SHIFT
 	mov	r6, r6, lsr #SECTION_SHIFT
 
@@ -351,11 +348,6 @@ __create_page_tables:
 	ret	lr
 ENDPROC(__create_page_tables)
 	.ltorg
-	.align
-__turn_mmu_on_loc:
-	.long	.
-	.long	__turn_mmu_on
-	.long	__turn_mmu_on_end
 
 #if defined(CONFIG_SMP)
 	.text
-- 
2.17.1

