Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7786C1EF6CD
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jun 2020 13:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgFELwI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jun 2020 07:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbgFELwI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Jun 2020 07:52:08 -0400
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A28952063A;
        Fri,  5 Jun 2020 11:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591357927;
        bh=9gkhKOjy2h7vbwv5PwKaL3fvJoy5px21Yf6PJcY4edo=;
        h=From:To:Cc:Subject:Date:From;
        b=io/0z295FcP3sYkbkD99oa10o3FmjmvCFlswXn4VqG1r3vLLxfwsuZ/lwfDD50pnv
         7BJ9BWjX8yVjhr9/bS6bZEHIc2fhcQX8yprmBaSTSIVRrR75L6yEh/QO90mPSHM1Ad
         dfSXRj9XH2zN0M9flcua/y+oAN3SVkK1Fe/vqfNk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        linux@armlinux.org.uk, xypron.glpk@gmx.de,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/arm: decompressor: deal with HYP mode boot gracefully
Date:   Fri,  5 Jun 2020 13:52:00 +0200
Message-Id: <20200605115200.413921-1-ardb@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

EFI on ARM only supports short descriptors, and given that it mandates
that the MMU and caches are on, it is implied that booting in HYP mode
is not supported.

However, implementations of EFI exist (i.e., U-Boot) that ignore this
requirement, which is not entirely unreasonable, given that it does
not make a lot of sense to begin with.

So let's make sure that we can deal with this condition gracefully.
We already tolerate booting the EFI stub with the caches off (even
though this violates the EFI spec as well), and so we should deal
with HYP mode boot with MMU and caches either on or off.

- When the MMU and caches are on, we can ignore the HYP stub altogether,
  since we can just use the existing mappings, and just branch into
  the decompressed kernel as usual after disabling MMU and caches.

- When the MMU and caches are off, we have to drop to SVC mode so that
  we can set up the page tables using short descriptors. In this case,
  we need to install the HYP stub so that we can return to HYP mode
  when handing over to the kernel proper.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/head.S | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index c79db44ba128..986db86ba334 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1436,6 +1436,35 @@ ENTRY(efi_enter_kernel)
 		mrc	p15, 0, r0, c1, c0, 0	@ read SCTLR
 		tst	r0, #0x1		@ MMU enabled?
 		orreq	r4, r4, #1		@ set LSB if not
+#ifdef CONFIG_ARM_VIRT_EXT
+		@
+		@ The EFI spec does not support booting on ARM in HYP mode,
+		@ since it mandates that the MMU and caches are on, with all
+		@ 32-bit addressable DRAM mapped 1:1 using short descriptors.
+		@ While the EDK2 reference implementation adheres to this,
+		@ U-Boot might decide to enter the EFI stub in HYP mode anyway,
+		@ with the MMU and caches either on or off.
+		@ In the former case, we're better off just carrying on using
+		@ the cached 1:1 mapping that the firmware provided, and pretend
+		@ that we are in SVC mode as far as the decompressor is
+		@ concerned. However, if the caches are off, we need to drop
+		@ into SVC mode now, and let the decompressor set up its cached
+		@ 1:1 mapping as usual.
+		@
+		mov	r0, #SVC_MODE
+		msr	spsr_cxsf, r0		@ record that we are in SVC mode
+		bne	1f			@ skip HYP stub install if MMU is on
+
+		mov	r9, r4			@ preserve image base
+		bl	__hyp_stub_install	@ returns boot mode in r4
+		cmp	r4, #HYP_MODE		@ did we boot in HYP?
+		bne	1f			@ skip drop to SVC if we did not
+
+		safe_svcmode_maskall	r0
+		msr	spsr_cxsf, r4		@ record boot mode
+		mov	r4, r9			@ restore image base
+1:
+#endif
 
 		mov	r0, r8			@ DT start
 		add	r1, r8, r2		@ DT end
-- 
2.26.2

