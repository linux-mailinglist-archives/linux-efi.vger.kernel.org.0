Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C25D1655CC
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 04:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBTDn2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 22:43:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39494 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727370AbgBTDn2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 22:43:28 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 78527DA8C0C61125B1F1;
        Thu, 20 Feb 2020 11:43:26 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 20 Feb 2020 11:43:16 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <ardb@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <hpa@zytor.com>, <x86@kernel.org>,
        <dvhart@infradead.org>, <andy@infradead.org>
CC:     <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-mm@kvack.org>,
        <wangkefeng.wang@huawei.com>, <jingxiangfeng@huawei.com>
Subject: [PATCH 1/2] efi: allow EFI_FAKE_MEMMAP on arm64 platform
Date:   Fri, 21 Feb 2020 07:52:59 -0500
Message-ID: <1582289580-24045-2-git-send-email-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582289580-24045-1-git-send-email-jingxiangfeng@huawei.com>
References: <1582289580-24045-1-git-send-email-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a efi_fake_memmap call in efi_init on arm64.This is useful for
debugging of Address Range Mirroring feature on arm64 platform.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 arch/x86/include/asm/efi.h      |  1 -
 arch/x86/platform/efi/efi.c     | 16 ----------------
 drivers/firmware/efi/Kconfig    |  2 +-
 drivers/firmware/efi/arm-init.c |  1 +
 drivers/firmware/efi/memmap.c   | 16 ++++++++++++++++
 include/linux/efi.h             |  1 +
 6 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 86169a2..127977f 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -158,7 +158,6 @@ extern void __iomem *__init efi_ioremap(unsigned long addr, unsigned long size,
 extern struct efi_scratch efi_scratch;
 extern void __init efi_set_executable(efi_memory_desc_t *md, bool executable);
 extern int __init efi_memblock_x86_reserve_range(void);
-extern void __init efi_print_memmap(void);
 extern void __init efi_memory_uc(u64 addr, unsigned long size);
 extern void __init efi_map_region(efi_memory_desc_t *md);
 extern void __init efi_map_region_fixed(efi_memory_desc_t *md);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index ae923ee..4c8793d 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -317,22 +317,6 @@ static void __init efi_clean_memmap(void)
 	}
 }
 
-void __init efi_print_memmap(void)
-{
-	efi_memory_desc_t *md;
-	int i = 0;
-
-	for_each_efi_memory_desc(md) {
-		char buf[64];
-
-		pr_info("mem%02u: %s range=[0x%016llx-0x%016llx] (%lluMB)\n",
-			i++, efi_md_typeattr_format(buf, sizeof(buf), md),
-			md->phys_addr,
-			md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1,
-			(md->num_pages >> (20 - EFI_PAGE_SHIFT)));
-	}
-}
-
 static int __init efi_systab_init(u64 phys)
 {
 	int size = efi_enabled(EFI_64BIT) ? sizeof(efi_system_table_64_t)
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index ecc83e2..9cf9a96 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -55,7 +55,7 @@ config EFI_RUNTIME_MAP
 
 config EFI_FAKE_MEMMAP
 	bool "Enable EFI fake memory map"
-	depends on EFI && X86
+	depends on EFI && (X86 || ARM64)
 	default n
 	help
 	  Saying Y here will enable "efi_fake_mem" boot option.
diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index d99f5b0..ac00e7c 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -265,6 +265,7 @@ void __init efi_init(void)
 	}
 
 	reserve_regions();
+	efi_fake_memmap();
 	efi_esrt_init();
 
 	memblock_reserve(params.mmap & PAGE_MASK,
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 2ff1883..0155bf0 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -376,3 +376,19 @@ void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
 		}
 	}
 }
+
+void __init efi_print_memmap(void)
+{
+	efi_memory_desc_t *md;
+	int i = 0;
+
+	for_each_efi_memory_desc(md) {
+		char buf[64];
+
+		pr_info("mem%02u: %s range=[0x%016llx-0x%016llx] (%lluMB)\n",
+			i++, efi_md_typeattr_format(buf, sizeof(buf), md),
+			md->phys_addr,
+			md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1,
+			(md->num_pages >> (20 - EFI_PAGE_SHIFT)));
+	}
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7efd707..bf101e5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1142,6 +1142,7 @@ static inline bool __pure efi_soft_reserve_enabled(void)
 	return IS_ENABLED(CONFIG_EFI_SOFT_RESERVE)
 		&& __efi_soft_reserve_enabled();
 }
+extern void __init efi_print_memmap(void);
 #else
 static inline bool efi_enabled(int feature)
 {
-- 
1.8.3.1

