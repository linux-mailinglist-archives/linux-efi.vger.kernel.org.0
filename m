Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABDF2D181E
	for <lists+linux-efi@lfdr.de>; Mon,  7 Dec 2020 19:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgLGSDH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Dec 2020 13:03:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgLGSDH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 7 Dec 2020 13:03:07 -0500
From:   Ard Biesheuvel <ardb@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
Subject: [PATCH 2/2] efi: capsule: clean scatter-gather entries from the D-cache
Date:   Mon,  7 Dec 2020 19:02:15 +0100
Message-Id: <20201207180216.3349-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201207180216.3349-1-ardb@kernel.org>
References: <20201207180216.3349-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The UEFI spec 2.9 has recently been updated to include a requirement
that scatter-gather lists passed to UpdateCapsule() should be cleaned
from the D-cache to ensure that they are visible to the CPU after a
warm reboot before it enables the MMU. On ARM and arm64 systems, this
implies a D-cache clean by virtual address to the point of coherency.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h     |  5 +++++
 arch/arm64/include/asm/efi.h   |  5 +++++
 drivers/firmware/efi/capsule.c | 12 ++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 3ee4f4381985..e9a06e164e06 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -93,4 +93,9 @@ struct efi_arm_entry_state {
 	u32	sctlr_after_ebs;
 };
 
+static inline void efi_capsule_flush_cache_range(void *addr, int size)
+{
+	__cpuc_flush_dcache_area(addr, size);
+}
+
 #endif /* _ASM_ARM_EFI_H */
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 973b14415271..00bd1e179d36 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -141,4 +141,9 @@ static inline void efi_set_pgd(struct mm_struct *mm)
 void efi_virtmap_load(void);
 void efi_virtmap_unload(void);
 
+static inline void efi_capsule_flush_cache_range(void *addr, int size)
+{
+	__flush_dcache_area(addr, size);
+}
+
 #endif /* _ASM_EFI_H */
diff --git a/drivers/firmware/efi/capsule.c b/drivers/firmware/efi/capsule.c
index 43f6fe7bfe80..768430293669 100644
--- a/drivers/firmware/efi/capsule.c
+++ b/drivers/firmware/efi/capsule.c
@@ -12,6 +12,7 @@
 #include <linux/highmem.h>
 #include <linux/efi.h>
 #include <linux/vmalloc.h>
+#include <asm/efi.h>
 #include <asm/io.h>
 
 typedef struct {
@@ -265,6 +266,17 @@ int efi_capsule_update(efi_capsule_header_t *capsule, phys_addr_t *pages)
 		else
 			sglist[j].data = page_to_phys(sg_pages[i + 1]);
 
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+		/*
+		 * At runtime, the firmware has no way to find out where the
+		 * sglist elements are mapped, if they are mapped in the first
+		 * place. Therefore, on architectures that can only perform
+		 * cache maintenance by virtual address, the firmware is unable
+		 * to perform this maintenance, and so it is up to the OS to do
+		 * it instead.
+		 */
+		efi_capsule_flush_cache_range(sglist, PAGE_SIZE);
+#endif
 		kunmap_atomic(sglist);
 	}
 
-- 
2.17.1

