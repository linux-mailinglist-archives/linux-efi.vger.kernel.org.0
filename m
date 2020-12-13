Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C2B2D8E32
	for <lists+linux-efi@lfdr.de>; Sun, 13 Dec 2020 16:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgLMPOB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Dec 2020 10:14:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437012AbgLMPNz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 13 Dec 2020 10:13:55 -0500
From:   Ard Biesheuvel <ardb@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: arm: force use of unsigned type for EFI_PHYS_ALIGN
Date:   Sun, 13 Dec 2020 16:13:06 +0100
Message-Id: <20201213151306.73558-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ensure that EFI_PHYS_ALIGN is an unsigned type, to prevent spurious
warnings from the type checks in the definition of the max() macro.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index abae071a02e1..9de7ab2ce05d 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -71,7 +71,7 @@ static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
  * here throws off the memory allocation logic, so let's use the lowest power
  * of two greater than 2 MiB and greater than TEXT_OFFSET.
  */
-#define EFI_PHYS_ALIGN		max(SZ_2M, roundup_pow_of_two(TEXT_OFFSET))
+#define EFI_PHYS_ALIGN		max(UL(SZ_2M), roundup_pow_of_two(TEXT_OFFSET))
 
 /* on ARM, the initrd should be loaded in a lowmem region */
 static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
-- 
2.20.1

