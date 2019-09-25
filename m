Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18935BDACA
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2019 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfIYJSL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Sep 2019 05:18:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbfIYJSC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Sep 2019 05:18:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BDA5A25F422E5C2CE8A7;
        Wed, 25 Sep 2019 17:17:55 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Sep 2019
 17:17:50 +0800
To:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        <dvhart@infradead.org>, <andy@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <hpa@zytor.com>, <x86@kernel.org>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH 1/2] efi: Add efi_memmap_free() to free EFI memory map
CC:     <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <775bcf46-0f4e-a1a9-5a40-05f833cd7a1a@huawei.com>
Date:   Wed, 25 Sep 2019 17:17:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In efi_fake_memmap(), the commit 20b1e22d01a4 ("x86/efi: Don't allocate
memmap through memblock after mm_init()") replace memblock_alloc() with
efi_memmap_alloc(), but there is no matching modification of
memblock_free() when early_memremap() fail.

Fix this by adding efi_memmap_free() to instead of memblock_free().

Fixes: 20b1e22d01a4 ("x86/efi: Don't allocate memmap through memblock after mm_init()")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 drivers/firmware/efi/fake_mem.c |  2 +-
 drivers/firmware/efi/memmap.c   | 34 ++++++++++++++++++++++++++++++++++
 include/linux/efi.h             |  1 +
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index 9501edc..c2f69f6 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -65,7 +65,7 @@ void __init efi_fake_memmap(void)
 	new_memmap = early_memremap(new_memmap_phy,
 				    efi.memmap.desc_size * new_nr_map);
 	if (!new_memmap) {
-		memblock_free(new_memmap_phy, efi.memmap.desc_size * new_nr_map);
+		efi_memmap_free(new_memmap_phy, new_nr_map);
 		return;
 	}

diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 38b686c..35dc189 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -18,6 +18,11 @@ static phys_addr_t __init __efi_memmap_alloc_early(unsigned long size)
 	return memblock_phys_alloc(size, SMP_CACHE_BYTES);
 }

+static void __init __efi_memmap_free_early(phys_addr_t addr, unsigned long size)
+{
+	memblock_free(addr, size);
+}
+
 static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
 {
 	unsigned int order = get_order(size);
@@ -29,6 +34,15 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
 	return PFN_PHYS(page_to_pfn(p));
 }

+static void __init __efi_memmap_free_late(phys_addr_t addr, unsigned long size)
+{
+	unsigned int order = get_order(size);
+	struct page *p = pfn_to_page(PHYS_PFN(addr));
+
+	if (p)
+		__free_pages(p, order);
+}
+
 /**
  * efi_memmap_alloc - Allocate memory for the EFI memory map
  * @num_entries: Number of entries in the allocated map.
@@ -50,6 +64,26 @@ phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
 }

 /**
+ * efi_memmap_free - Free memory for the EFI memory map
+ * @addr: Physical address of the EFI memory map to be freed.
+ * @num_entries: Number of the EFI memory map entries.
+ *
+ * Depending on whether mm_init() has already been invoked or not,
+ * either memblock or "normal" page free is used.
+ */
+void __init efi_memmap_free(phys_addr_t addr, unsigned int num_entries)
+{
+	unsigned long size = num_entries * efi.memmap.desc_size;
+
+	if (slab_is_available()) {
+		__efi_memmap_free_late(addr, size);
+
+		return;
+	}
+	__efi_memmap_free_early(addr, size);
+}
+
+/**
  * __efi_memmap_init - Common code for mapping the EFI memory map
  * @data: EFI memory map data
  * @late: Use early or late mapping function?
diff --git a/include/linux/efi.h b/include/linux/efi.h
index bd38370..8bb741a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1057,6 +1057,7 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
 extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);

 extern phys_addr_t __init efi_memmap_alloc(unsigned int num_entries);
+extern void __init efi_memmap_free(phys_addr_t addr, unsigned int num_entries);
 extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size);
 extern void __init efi_memmap_unmap(void);
-- 
1.8.3.1

