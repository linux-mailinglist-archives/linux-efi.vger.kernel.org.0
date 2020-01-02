Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 205B012E252
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 05:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgABE30 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jan 2020 23:29:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:10262 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgABE30 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 1 Jan 2020 23:29:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2020 20:29:25 -0800
X-IronPort-AV: E=Sophos;i="5.69,385,1571727600"; 
   d="scan'208";a="221274665"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2020 20:29:25 -0800
Subject: [PATCH v3 1/4] efi: Add a flags parameter to efi_memory_map
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org
Date:   Wed, 01 Jan 2020 20:13:23 -0800
Message-ID: <157793840352.977550.5176906606902330845.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157793839827.977550.7845382457971215205.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157793839827.977550.7845382457971215205.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for garbage collecting dynamically allocated efi memory
maps, where the allocation method of memblock vs slab needs to be
recalled, convert the existing 'late' flag into a 'flags' bitmask.

Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/firmware/efi/memmap.c |   24 +++++++++++++-----------
 include/linux/efi.h           |    3 ++-
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 38b686c67b17..813674ef9000 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -52,7 +52,7 @@ phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
 /**
  * __efi_memmap_init - Common code for mapping the EFI memory map
  * @data: EFI memory map data
- * @late: Use early or late mapping function?
+ * @flags: Use early or late mapping function?
  *
  * This function takes care of figuring out which function to use to
  * map the EFI memory map in efi.memmap based on how far into the boot
@@ -66,9 +66,9 @@ phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
  * Returns zero on success, a negative error code on failure.
  */
 static int __init
-__efi_memmap_init(struct efi_memory_map_data *data, bool late)
+__efi_memmap_init(struct efi_memory_map_data *data, unsigned long flags)
 {
-	struct efi_memory_map map;
+	struct efi_memory_map map = { 0 };
 	phys_addr_t phys_map;
 
 	if (efi_enabled(EFI_PARAVIRT))
@@ -76,7 +76,7 @@ __efi_memmap_init(struct efi_memory_map_data *data, bool late)
 
 	phys_map = data->phys_map;
 
-	if (late)
+	if (flags & EFI_MEMMAP_LATE)
 		map.map = memremap(phys_map, data->size, MEMREMAP_WB);
 	else
 		map.map = early_memremap(phys_map, data->size);
@@ -92,7 +92,7 @@ __efi_memmap_init(struct efi_memory_map_data *data, bool late)
 
 	map.desc_version = data->desc_version;
 	map.desc_size = data->desc_size;
-	map.late = late;
+	map.flags |= flags;
 
 	set_bit(EFI_MEMMAP, &efi.flags);
 
@@ -111,9 +111,9 @@ __efi_memmap_init(struct efi_memory_map_data *data, bool late)
 int __init efi_memmap_init_early(struct efi_memory_map_data *data)
 {
 	/* Cannot go backwards */
-	WARN_ON(efi.memmap.late);
+	WARN_ON(efi.memmap.flags & EFI_MEMMAP_LATE);
 
-	return __efi_memmap_init(data, false);
+	return __efi_memmap_init(data, 0);
 }
 
 void __init efi_memmap_unmap(void)
@@ -121,7 +121,7 @@ void __init efi_memmap_unmap(void)
 	if (!efi_enabled(EFI_MEMMAP))
 		return;
 
-	if (!efi.memmap.late) {
+	if (!(efi.memmap.flags & EFI_MEMMAP_LATE)) {
 		unsigned long size;
 
 		size = efi.memmap.desc_size * efi.memmap.nr_map;
@@ -168,7 +168,7 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 	WARN_ON(efi.memmap.map);
 
 	/* Were we already called? */
-	WARN_ON(efi.memmap.late);
+	WARN_ON(efi.memmap.flags & EFI_MEMMAP_LATE);
 
 	/*
 	 * It makes no sense to allow callers to register different
@@ -178,7 +178,7 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 	data.desc_version = efi.memmap.desc_version;
 	data.desc_size = efi.memmap.desc_size;
 
-	return __efi_memmap_init(&data, true);
+	return __efi_memmap_init(&data, EFI_MEMMAP_LATE);
 }
 
 /**
@@ -195,6 +195,7 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map)
 {
 	struct efi_memory_map_data data;
+	unsigned long flags;
 
 	efi_memmap_unmap();
 
@@ -202,8 +203,9 @@ int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map)
 	data.size = efi.memmap.desc_size * nr_map;
 	data.desc_version = efi.memmap.desc_version;
 	data.desc_size = efi.memmap.desc_size;
+	flags = efi.memmap.flags & EFI_MEMMAP_LATE;
 
-	return __efi_memmap_init(&data, efi.memmap.late);
+	return __efi_memmap_init(&data, flags);
 }
 
 /**
diff --git a/include/linux/efi.h b/include/linux/efi.h
index aa54586db7a5..b8e930f5ff77 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -795,7 +795,8 @@ struct efi_memory_map {
 	int nr_map;
 	unsigned long desc_version;
 	unsigned long desc_size;
-	bool late;
+#define EFI_MEMMAP_LATE (1UL << 0)
+	unsigned long flags;
 };
 
 struct efi_mem_range {

