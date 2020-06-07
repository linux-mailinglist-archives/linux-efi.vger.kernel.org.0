Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E284E1F0B8F
	for <lists+linux-efi@lfdr.de>; Sun,  7 Jun 2020 15:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgFGN6u (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Jun 2020 09:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgFGN6t (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 7 Jun 2020 09:58:49 -0400
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58CDB2075A;
        Sun,  7 Jun 2020 13:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591538329;
        bh=+I7+Y9xcYGUsBj8ke7ISq801A0SS4udp6aU7ow79qpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPI2nsZzJJxKsmNOdP8YnABoKLer0jT2K5waAsthEvMijyLXPBZ8FYHxwwqeleZ3Q
         uGqfqOA6217NcQnbpHJZobhqqC/LHfoMIyvvUlG1ZCotap4hOwm7i7e9LUtxgb1GTG
         sEOXeTDkYZjtNSegUIJsL1SRpCexyks2wuAFhoIY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        linux@armlinux.org.uk, xypron.glpk@gmx.de,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 2/2] efi/arm: libstub: print boot mode and MMU state at boot
Date:   Sun,  7 Jun 2020 15:58:34 +0200
Message-Id: <20200607135834.898294-3-ardb@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200607135834.898294-1-ardb@kernel.org>
References: <20200607135834.898294-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 32-bit ARM, we may boot at HYP mode, or with the MMU and caches off
(or both), even though the EFI spec actually does not support this.
Take note of this in the EFI stub diagnostic output so that we can
easily see whether this is the case or not.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm32-stub.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index 40243f524556..659aaa5003a2 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -9,8 +9,19 @@
 
 efi_status_t check_platform_features(void)
 {
+	u32 cpsr, sctlr;
 	int block;
 
+	asm("mrs %0, cpsr" : "=r"(cpsr));
+	if ((cpsr & MODE_MASK) == HYP_MODE)
+		asm("mrc p15, 4, %0, c1, c0, 0" : "=r"(sctlr));
+	else
+		asm("mrc p15, 0, %0, c1, c0, 0" : "=r"(sctlr));
+
+	efi_info("Running in %s mode with MMU %sabled\n",
+		 ((cpsr & MODE_MASK) == HYP_MODE) ? "HYP" : "SVC",
+		 (sctlr & 1) ? "en" : "dis");
+
 	/* non-LPAE kernels can run anywhere */
 	if (!IS_ENABLED(CONFIG_ARM_LPAE))
 		return EFI_SUCCESS;
-- 
2.26.2

