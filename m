Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1472F2B0823
	for <lists+linux-efi@lfdr.de>; Thu, 12 Nov 2020 16:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgKLPIE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Nov 2020 10:08:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLPIA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 12 Nov 2020 10:08:00 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 878E322201;
        Thu, 12 Nov 2020 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605193680;
        bh=NY4kvmcMsgAmA89/9KafLtsAhyX3OahPXXsZr1N6j6I=;
        h=From:To:Cc:Subject:Date:From;
        b=R+H/6WHDXJCUb/E10YWsHAKVatnsEqWu6f45RP/xUXeAsRk/0RX/LcHMzE6bbNSff
         96WMdOZ7TJbpKo5MkmTDsnyZfT6RNHkeEGmhpegp0CtjQv/iJNSxa5JbwQdVBz7sRc
         jKChwxY5hIVrzCU6JUcIZ436WW4RKH4qFj8+eMTA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: arm: reduce minimum alignment of uncompressed kernel
Date:   Thu, 12 Nov 2020 16:07:52 +0100
Message-Id: <20201112150752.4770-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that we reduced the minimum relative alignment between PHYS_OFFSET
and PAGE_OFFSET to 2 MiB, we can take this into account when allocating
memory for the decompressed kernel when booting via EFI. This minimizes
the amount of unusable memory we may end up with due to the base of DRAM
being occupied by firmware.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 0496bc96a092..dd1736372de2 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -66,18 +66,17 @@ static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
 #define MAX_UNCOMP_KERNEL_SIZE	SZ_32M
 
 /*
- * phys-to-virt patching requires that the physical to virtual offset fits
- * into the immediate field of an add/sub instruction, which comes down to the
- * 24 least significant bits being zero, and so the offset should be a multiple
- * of 16 MB. Since PAGE_OFFSET itself is a multiple of 16 MB, the physical
- * base should be aligned to 16 MB as well.
+ * phys-to-virt patching requires that the physical to virtual offset is a
+ * multiple of 2 MiB. However, using an alignment smaller than TEXT_OFFSET
+ * here throws off the memory allocation logic, so let's use the lowest power
+ * of two greater than 2 MiB and greater than TEXT_OFFSET.
  */
-#define EFI_PHYS_ALIGN		SZ_16M
+#define EFI_PHYS_ALIGN		max(SZ_2M, roundup_pow_of_two(TEXT_OFFSET))
 
 /* on ARM, the initrd should be loaded in a lowmem region */
 static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 {
-	return round_down(image_addr, EFI_PHYS_ALIGN) + SZ_512M;
+	return round_down(image_addr, SZ_4M) + SZ_512M;
 }
 
 struct efi_arm_entry_state {
-- 
2.17.1

