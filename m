Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95721272A6D
	for <lists+linux-efi@lfdr.de>; Mon, 21 Sep 2020 17:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgIUPlh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Sep 2020 11:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbgIUPlh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 21 Sep 2020 11:41:37 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88A4620BED;
        Mon, 21 Sep 2020 15:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600702897;
        bh=cD56uCL28utzy8X1gRZgksy9NZmlHrkCFa4SwNHOOqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sp1tl5igo7ciag5pmQ9GyBKpwEQK2XfJeH4x+UQgQg11vshTehi2LJ4fsX9VoZaPa
         hRwlkx0RsZMei5yjDooJc5AWzohmUlYOxLo2xU78W1SwcURN7pBerwce7vYDfYNcMI
         JAhSbxOrJoWtXAcB3YlZcKcURdaB3qpmuWvxep3Y=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2 08/10] ARM: p2v: simplify __fixup_pv_table()
Date:   Mon, 21 Sep 2020 17:41:15 +0200
Message-Id: <20200921154117.757-9-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921154117.757-1-ardb@kernel.org>
References: <20200921154117.757-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Declutter the code in __fixup_pv_table() by using the new adr_l/str_l
macros to take PC relative references to external symbols, and by
using the value of PHYS_OFFSET passed in r8 to calculate the p2v
offset.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/phys2virt.S | 34 ++++++++------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/phys2virt.S b/arch/arm/kernel/phys2virt.S
index 8e4be15e1559..be8fb0d89877 100644
--- a/arch/arm/kernel/phys2virt.S
+++ b/arch/arm/kernel/phys2virt.S
@@ -29,33 +29,27 @@
  */
 	__HEAD
 ENTRY(__fixup_pv_table)
-	adr	r0, 1f
-	ldmia	r0, {r3-r7}
-	mvn	ip, #0
-	subs	r3, r0, r3		@ PHYS_OFFSET - PAGE_OFFSET
-	add	r4, r4, r3		@ adjust table start address
-	add	r5, r5, r3		@ adjust table end address
-	add	r6, r6, r3		@ adjust __pv_phys_pfn_offset address
-	add	r7, r7, r3		@ adjust __pv_offset address
 	mov	r0, r8, lsr #PAGE_SHIFT	@ convert to PFN
-	str	r0, [r6]		@ save computed PHYS_OFFSET to __pv_phys_pfn_offset
-	strcc	ip, [r7, #HIGH_OFFSET]	@ save to __pv_offset high bits
-	mov	r6, r3, lsr #24		@ constant for add/sub instructions
-	teq	r3, r6, lsl #24 	@ must be 16MiB aligned
+	str_l	r0, __pv_phys_pfn_offset, r3
+
+	adr_l	r0, __pv_offset
+	subs	r3, r8, #PAGE_OFFSET	@ PHYS_OFFSET - PAGE_OFFSET
+	mvn	ip, #0
+	strcc	ip, [r0, #HIGH_OFFSET]	@ save to __pv_offset high bits
+	str	r3, [r0, #LOW_OFFSET]	@ save to __pv_offset low bits
+
+	mov	r0, r3, lsr #24		@ constant for add/sub instructions
+	teq	r3, r0, lsl #24 	@ must be 16MiB aligned
 	bne	0f
-	str	r3, [r7, #LOW_OFFSET]	@ save to __pv_offset low bits
+
+	adr_l	r4, __pv_table_begin
+	adr_l	r5, __pv_table_end
 	b	__fixup_a_pv_table
+
 0:	mov	r0, r0			@ deadloop on error
 	b	0b
 ENDPROC(__fixup_pv_table)
 
-	.align
-1:	.long	.
-	.long	__pv_table_begin
-	.long	__pv_table_end
-2:	.long	__pv_phys_pfn_offset
-	.long	__pv_offset
-
 	.text
 __fixup_a_pv_table:
 	adr_l	r6, __pv_offset
-- 
2.17.1

