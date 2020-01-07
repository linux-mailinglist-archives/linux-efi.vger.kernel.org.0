Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9EEF131CE2
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 01:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgAGA4g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jan 2020 19:56:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:44966 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbgAGA4f (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Jan 2020 19:56:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 16:56:35 -0800
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; 
   d="scan'208";a="215368078"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 16:56:34 -0800
Subject: [PATCH v4 2/4] efi: Add tracking for dynamically allocated memmaps
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Date:   Mon, 06 Jan 2020 16:40:32 -0800
Message-ID: <157835763268.1456824.905133588933269818.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for fixing efi_memmap_alloc() leaks, add support for
recording whether the memmap was dynamically allocated from slab,
memblock, or is the original physical memmap provided by the platform.

Given this tracking is established in efi_memmap_alloc() and needs to be
carried to efi_memmap_install(), use 'struct efi_memory_map_data' to
convey the flags.

Some small cleanups result from this reorganization, specifically the
removal of local variables for 'phys' and 'size' that are already
tracked in @data.

Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/platform/efi/efi.c     |   10 +++++++-
 arch/x86/platform/efi/quirks.c  |   23 +++++++------------
 drivers/firmware/efi/fake_mem.c |   14 +++++-------
 drivers/firmware/efi/memmap.c   |   47 ++++++++++++++++++++++-----------------
 include/linux/efi.h             |   11 ++++++---
 5 files changed, 56 insertions(+), 49 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 38d44f36d5ed..0bd45a988501 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -330,10 +330,16 @@ static void __init efi_clean_memmap(void)
 	}
 
 	if (n_removal > 0) {
-		u64 size = efi.memmap.nr_map - n_removal;
+		struct efi_memory_map_data data = {
+			.phys_map = efi.memmap.phys_map,
+			.desc_version = efi.memmap.desc_version,
+			.desc_size = efi.memmap.desc_size,
+			.size = data.desc_size * (efi.memmap.nr_map - n_removal),
+			.flags = 0,
+		};
 
 		pr_warn("Removing %d invalid memory map entries.\n", n_removal);
-		efi_memmap_install(efi.memmap.phys_map, size);
+		efi_memmap_install(&data);
 	}
 }
 
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f8f0220b6a66..a4f6c7176f24 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -243,7 +243,7 @@ EXPORT_SYMBOL_GPL(efi_query_variable_store);
  */
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 {
-	phys_addr_t new_phys, new_size;
+	struct efi_memory_map_data data = { 0 };
 	struct efi_mem_range mr;
 	efi_memory_desc_t md;
 	int num_entries;
@@ -271,24 +271,21 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	num_entries = efi_memmap_split_count(&md, &mr.range);
 	num_entries += efi.memmap.nr_map;
 
-	new_size = efi.memmap.desc_size * num_entries;
-
-	new_phys = efi_memmap_alloc(num_entries);
-	if (!new_phys) {
+	if (efi_memmap_alloc(num_entries, &data) != 0) {
 		pr_err("Could not allocate boot services memmap\n");
 		return;
 	}
 
-	new = early_memremap(new_phys, new_size);
+	new = early_memremap(data.phys_map, data.size);
 	if (!new) {
 		pr_err("Failed to map new boot services memmap\n");
 		return;
 	}
 
 	efi_memmap_insert(&efi.memmap, new, &mr);
-	early_memunmap(new, new_size);
+	early_memunmap(new, data.size);
 
-	efi_memmap_install(new_phys, num_entries);
+	efi_memmap_install(&data);
 	e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
 	e820__update_table(e820_table);
 }
@@ -407,7 +404,7 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
 
 void __init efi_free_boot_services(void)
 {
-	phys_addr_t new_phys, new_size;
+	struct efi_memory_map_data data = { 0 };
 	efi_memory_desc_t *md;
 	int num_entries = 0;
 	void *new, *new_md;
@@ -462,14 +459,12 @@ void __init efi_free_boot_services(void)
 	if (!num_entries)
 		return;
 
-	new_size = efi.memmap.desc_size * num_entries;
-	new_phys = efi_memmap_alloc(num_entries);
-	if (!new_phys) {
+	if (efi_memmap_alloc(num_entries, &data) != 0) {
 		pr_err("Failed to allocate new EFI memmap\n");
 		return;
 	}
 
-	new = memremap(new_phys, new_size, MEMREMAP_WB);
+	new = memremap(data.phys_map, data.size, MEMREMAP_WB);
 	if (!new) {
 		pr_err("Failed to map new EFI memmap\n");
 		return;
@@ -493,7 +488,7 @@ void __init efi_free_boot_services(void)
 
 	memunmap(new);
 
-	if (efi_memmap_install(new_phys, num_entries)) {
+	if (efi_memmap_install(&data) != 0) {
 		pr_err("Could not install new EFI memmap\n");
 		return;
 	}
diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index bb9fc70d0cfa..a8d20568d532 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -36,9 +36,9 @@ static int __init cmp_fake_mem(const void *x1, const void *x2)
 
 void __init efi_fake_memmap(void)
 {
+	struct efi_memory_map_data data = { 0 };
 	int new_nr_map = efi.memmap.nr_map;
 	efi_memory_desc_t *md;
-	phys_addr_t new_memmap_phy;
 	void *new_memmap;
 	int i;
 
@@ -55,15 +55,13 @@ void __init efi_fake_memmap(void)
 	}
 
 	/* allocate memory for new EFI memmap */
-	new_memmap_phy = efi_memmap_alloc(new_nr_map);
-	if (!new_memmap_phy)
+	if (efi_memmap_alloc(new_nr_map, &data) != 0)
 		return;
 
 	/* create new EFI memmap */
-	new_memmap = early_memremap(new_memmap_phy,
-				    efi.memmap.desc_size * new_nr_map);
+	new_memmap = early_memremap(data.phys_map, data.size);
 	if (!new_memmap) {
-		memblock_free(new_memmap_phy, efi.memmap.desc_size * new_nr_map);
+		memblock_free(data.phys_map, data.size);
 		return;
 	}
 
@@ -71,9 +69,9 @@ void __init efi_fake_memmap(void)
 		efi_memmap_insert(&efi.memmap, new_memmap, &efi_fake_mems[i]);
 
 	/* swap into new EFI memmap */
-	early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
+	early_memunmap(new_memmap, data.size);
 
-	efi_memmap_install(new_memmap_phy, new_nr_map);
+	efi_memmap_install(&data);
 
 	/* print new EFI memmap */
 	efi_print_memmap();
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 4f98eb12c172..04dfa56b994b 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -32,6 +32,7 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
 /**
  * efi_memmap_alloc - Allocate memory for the EFI memory map
  * @num_entries: Number of entries in the allocated map.
+ * @data: efi memmap installation parameters
  *
  * Depending on whether mm_init() has already been invoked or not,
  * either memblock or "normal" page allocation is used.
@@ -39,14 +40,29 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
  * Returns the physical address of the allocated memory map on
  * success, zero on failure.
  */
-phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
+int __init efi_memmap_alloc(unsigned int num_entries,
+		struct efi_memory_map_data *data)
 {
-	unsigned long size = num_entries * efi.memmap.desc_size;
-
-	if (slab_is_available())
-		return __efi_memmap_alloc_late(size);
+	/* Expect allocation parameters are zero initialized */
+	WARN_ON(data->phys_map || data->size);
+
+	data->size = num_entries * efi.memmap.desc_size;
+	data->desc_version = efi.memmap.desc_version;
+	data->desc_size = efi.memmap.desc_size;
+	data->flags &= ~(EFI_MEMMAP_SLAB | EFI_MEMMAP_MEMBLOCK);
+	data->flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
+
+	if (slab_is_available()) {
+		data->flags |= EFI_MEMMAP_SLAB;
+		data->phys_map = __efi_memmap_alloc_late(data->size);
+	} else {
+		data->flags |= EFI_MEMMAP_MEMBLOCK;
+		data->phys_map = __efi_memmap_alloc_early(data->size);
+	}
 
-	return __efi_memmap_alloc_early(size);
+	if (!data->phys_map)
+		return -ENOMEM;
+	return 0;
 }
 
 /**
@@ -64,8 +80,7 @@ phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
  *
  * Returns zero on success, a negative error code on failure.
  */
-static int __init
-__efi_memmap_init(struct efi_memory_map_data *data)
+static int __init __efi_memmap_init(struct efi_memory_map_data *data)
 {
 	struct efi_memory_map map;
 	phys_addr_t phys_map;
@@ -184,8 +199,7 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 
 /**
  * efi_memmap_install - Install a new EFI memory map in efi.memmap
- * @addr: Physical address of the memory map
- * @nr_map: Number of entries in the memory map
+ * @ctx: map allocation parameters (address, size, flags)
  *
  * Unlike efi_memmap_init_*(), this function does not allow the caller
  * to switch from early to late mappings. It simply uses the existing
@@ -193,20 +207,11 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
  *
  * Returns zero on success, a negative error code on failure.
  */
-int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map)
+int __init efi_memmap_install(struct efi_memory_map_data *data)
 {
-	struct efi_memory_map_data data;
-	unsigned long flags;
-
 	efi_memmap_unmap();
 
-	data.phys_map = addr;
-	data.size = efi.memmap.desc_size * nr_map;
-	data.desc_version = efi.memmap.desc_version;
-	data.desc_size = efi.memmap.desc_size;
-	data.flags = efi.memmap.flags & EFI_MEMMAP_LATE;
-
-	return __efi_memmap_init(&data);
+	return __efi_memmap_init(data);
 }
 
 /**
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e7e6c64469a7..416eac01b1a1 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -778,8 +778,8 @@ typedef struct {
 
 /*
  * Architecture independent structure for describing a memory map for the
- * benefit of efi_memmap_init_early(), saving us the need to pass four
- * parameters.
+ * benefit of efi_memmap_init_early(), and for passing context between
+ * efi_memmap_alloc() and efi_memmap_install().
  */
 struct efi_memory_map_data {
 	phys_addr_t phys_map;
@@ -797,6 +797,8 @@ struct efi_memory_map {
 	unsigned long desc_version;
 	unsigned long desc_size;
 #define EFI_MEMMAP_LATE (1UL << 0)
+#define EFI_MEMMAP_MEMBLOCK (1UL << 1)
+#define EFI_MEMMAP_SLAB (1UL << 2)
 	unsigned long flags;
 };
 
@@ -1058,11 +1060,12 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
 #endif
 extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
 
-extern phys_addr_t __init efi_memmap_alloc(unsigned int num_entries);
+extern int __init efi_memmap_alloc(unsigned int num_entries,
+				   struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size);
 extern void __init efi_memmap_unmap(void);
-extern int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map);
+extern int __init efi_memmap_install(struct efi_memory_map_data *data);
 extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
 					 struct range *range);
 extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,

