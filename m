Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA3F282BD6
	for <lists+linux-efi@lfdr.de>; Sun,  4 Oct 2020 18:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgJDQay (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 4 Oct 2020 12:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgJDQay (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 4 Oct 2020 12:30:54 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D302068E;
        Sun,  4 Oct 2020 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601829053;
        bh=Wly3IIUTFpZXHJCYnPO2T/YmqJEyWrysoY8Vpyiyquo=;
        h=From:To:Cc:Subject:Date:From;
        b=SHkEYCmEZzQiIJtKGwQ/w4WRDH9qAYFJIPGy9YcV3QKd9wB8ccpIKtU1TZTw5/KUf
         vY++NNC1VcQlrXj81Z4FpB4SDZUQfwftMjagYzU8D/9tQHrNZxe+SUZm5+voOhugYt
         F9OqDWeM3XUI5Us/FmDDj7ErGCtFZG+wZs9+i0z0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/arm: set HSCTLR Thumb2 bit correctly for HVC calls from HYP
Date:   Sun,  4 Oct 2020 18:30:49 +0200
Message-Id: <20201004163049.7659-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit

  db227c19e68db353 ("ARM: 8985/1: efi/decompressor: deal with HYP mode boot gracefully")

updated the EFI entry code to permit firmware to invoke the EFI stub
loader in HYP mode, with the MMU either enabled or disabled, neither
of which is permitted by the EFI spec, but which does happen in the
field.

In the MMU on case, we remain in HYP mode as configured by the firmware,
and rely on the fact that any HVC instruction issued in this mode will
be dispatched via the SVC slot in the HYP vector table. However, this
slot will point to a Thumb2 symbol if the kernel is built in Thumb2
mode, and so we have to configure HSCTLR to ensure that the exception
handlers are invoked in Thumb2 mode as well.

Fixes: db227c19e68db353 ("ARM: 8985/1: efi/decompressor: deal with HYP mode boot gracefully")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/head.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 434a16982e34..19499d636bc8 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1476,6 +1476,9 @@ ENTRY(efi_enter_kernel)
 		@ issued from HYP mode take us to the correct handler code. We
 		@ will disable the MMU before jumping to the kernel proper.
 		@
+ ARM(		bic	r1, r1, #(1 << 30)	) @ clear HSCTLR.TE
+ THUMB(		orr	r1, r1, #(1 << 30)	) @ set HSCTLR.TE
+		mcr	p15, 4, r1, c1, c0, 0
 		adr	r0, __hyp_reentry_vectors
 		mcr	p15, 4, r0, c12, c0, 0	@ set HYP vector base (HVBAR)
 		isb
-- 
2.17.1

