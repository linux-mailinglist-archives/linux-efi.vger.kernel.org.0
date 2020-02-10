Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7616157F5B
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgBJQDH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbgBJQDH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:07 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 752E8208C3;
        Mon, 10 Feb 2020 16:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350586;
        bh=G5Hb7D4LipVoYwEwhFEzcn/Cg2Z3OoAHPF9hAqW5Aos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9bEEE7mMlFNosv/+DE5XXsQ1Z2yXZWZQzKMF7ZwzH3xNEqKch+o5S8rEbapyRubZ
         uAyqvPUI1SyhKXGulIjq1IHJZ0gBP6nao71djmfP42hwAfpwzCgSv64EwNsTiXsiVQ
         JfYJDD9HkVAB1kiAsL8pCYypMGh3kvHV+w7gAMtU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 05/19] efi/libstub: Move memory map handling and allocation routines to mem.c
Date:   Mon, 10 Feb 2020 17:02:34 +0100
Message-Id: <20200210160248.4889-6-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Create a new source file mem.c to keep the routines involved in memory
allocation and deallocation and manipulation of the EFI memory map.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile          |   2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 313 -------------------
 drivers/firmware/efi/libstub/mem.c             | 319 ++++++++++++++++++++
 3 files changed, 320 insertions(+), 314 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 4efdbd711e8e..45d6eb657437 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -39,7 +39,7 @@ OBJECT_FILES_NON_STANDARD	:= y
 KCOV_INSTRUMENT			:= n
 
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
-				   random.o pci.o
+				   mem.o random.o pci.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 74ddfb496140..60d13c7a2e92 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -53,8 +53,6 @@ bool __pure __efi_soft_reserve_enabled(void)
 	return !efi_nosoftreserve;
 }
 
-#define EFI_MMAP_NR_SLACK_SLOTS	8
-
 struct file_info {
 	efi_file_handle_t *handle;
 	u64 size;
@@ -77,64 +75,6 @@ void efi_printk(char *str)
 	}
 }
 
-static inline bool mmap_has_headroom(unsigned long buff_size,
-				     unsigned long map_size,
-				     unsigned long desc_size)
-{
-	unsigned long slack = buff_size - map_size;
-
-	return slack / desc_size >= EFI_MMAP_NR_SLACK_SLOTS;
-}
-
-efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
-{
-	efi_memory_desc_t *m = NULL;
-	efi_status_t status;
-	unsigned long key;
-	u32 desc_version;
-
-	*map->desc_size =	sizeof(*m);
-	*map->map_size =	*map->desc_size * 32;
-	*map->buff_size =	*map->map_size;
-again:
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
-			     *map->map_size, (void **)&m);
-	if (status != EFI_SUCCESS)
-		goto fail;
-
-	*map->desc_size = 0;
-	key = 0;
-	status = efi_bs_call(get_memory_map, map->map_size, m,
-			     &key, map->desc_size, &desc_version);
-	if (status == EFI_BUFFER_TOO_SMALL ||
-	    !mmap_has_headroom(*map->buff_size, *map->map_size,
-			       *map->desc_size)) {
-		efi_bs_call(free_pool, m);
-		/*
-		 * Make sure there is some entries of headroom so that the
-		 * buffer can be reused for a new map after allocations are
-		 * no longer permitted.  Its unlikely that the map will grow to
-		 * exceed this headroom once we are ready to trigger
-		 * ExitBootServices()
-		 */
-		*map->map_size += *map->desc_size * EFI_MMAP_NR_SLACK_SLOTS;
-		*map->buff_size = *map->map_size;
-		goto again;
-	}
-
-	if (status != EFI_SUCCESS)
-		efi_bs_call(free_pool, m);
-
-	if (map->key_ptr && status == EFI_SUCCESS)
-		*map->key_ptr = key;
-	if (map->desc_ver && status == EFI_SUCCESS)
-		*map->desc_ver = desc_version;
-
-fail:
-	*map->map = m;
-	return status;
-}
-
 
 unsigned long get_dram_base(void)
 {
@@ -170,192 +110,6 @@ unsigned long get_dram_base(void)
 	return membase;
 }
 
-/*
- * Allocate at the highest possible address that is not above 'max'.
- */
-efi_status_t efi_high_alloc(unsigned long size, unsigned long align,
-			    unsigned long *addr, unsigned long max)
-{
-	unsigned long map_size, desc_size, buff_size;
-	efi_memory_desc_t *map;
-	efi_status_t status;
-	unsigned long nr_pages;
-	u64 max_addr = 0;
-	int i;
-	struct efi_boot_memmap boot_map;
-
-	boot_map.map =		&map;
-	boot_map.map_size =	&map_size;
-	boot_map.desc_size =	&desc_size;
-	boot_map.desc_ver =	NULL;
-	boot_map.key_ptr =	NULL;
-	boot_map.buff_size =	&buff_size;
-
-	status = efi_get_memory_map(&boot_map);
-	if (status != EFI_SUCCESS)
-		goto fail;
-
-	/*
-	 * Enforce minimum alignment that EFI or Linux requires when
-	 * requesting a specific address.  We are doing page-based (or
-	 * larger) allocations, and both the address and size must meet
-	 * alignment constraints.
-	 */
-	if (align < EFI_ALLOC_ALIGN)
-		align = EFI_ALLOC_ALIGN;
-
-	size = round_up(size, EFI_ALLOC_ALIGN);
-	nr_pages = size / EFI_PAGE_SIZE;
-again:
-	for (i = 0; i < map_size / desc_size; i++) {
-		efi_memory_desc_t *desc;
-		unsigned long m = (unsigned long)map;
-		u64 start, end;
-
-		desc = efi_early_memdesc_ptr(m, desc_size, i);
-		if (desc->type != EFI_CONVENTIONAL_MEMORY)
-			continue;
-
-		if (efi_soft_reserve_enabled() &&
-		    (desc->attribute & EFI_MEMORY_SP))
-			continue;
-
-		if (desc->num_pages < nr_pages)
-			continue;
-
-		start = desc->phys_addr;
-		end = start + desc->num_pages * EFI_PAGE_SIZE;
-
-		if (end > max)
-			end = max;
-
-		if ((start + size) > end)
-			continue;
-
-		if (round_down(end - size, align) < start)
-			continue;
-
-		start = round_down(end - size, align);
-
-		/*
-		 * Don't allocate at 0x0. It will confuse code that
-		 * checks pointers against NULL.
-		 */
-		if (start == 0x0)
-			continue;
-
-		if (start > max_addr)
-			max_addr = start;
-	}
-
-	if (!max_addr)
-		status = EFI_NOT_FOUND;
-	else {
-		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
-				     EFI_LOADER_DATA, nr_pages, &max_addr);
-		if (status != EFI_SUCCESS) {
-			max = max_addr;
-			max_addr = 0;
-			goto again;
-		}
-
-		*addr = max_addr;
-	}
-
-	efi_bs_call(free_pool, map);
-fail:
-	return status;
-}
-
-/*
- * Allocate at the lowest possible address that is not below 'min'.
- */
-efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
-				 unsigned long *addr, unsigned long min)
-{
-	unsigned long map_size, desc_size, buff_size;
-	efi_memory_desc_t *map;
-	efi_status_t status;
-	unsigned long nr_pages;
-	int i;
-	struct efi_boot_memmap boot_map;
-
-	boot_map.map =		&map;
-	boot_map.map_size =	&map_size;
-	boot_map.desc_size =	&desc_size;
-	boot_map.desc_ver =	NULL;
-	boot_map.key_ptr =	NULL;
-	boot_map.buff_size =	&buff_size;
-
-	status = efi_get_memory_map(&boot_map);
-	if (status != EFI_SUCCESS)
-		goto fail;
-
-	/*
-	 * Enforce minimum alignment that EFI or Linux requires when
-	 * requesting a specific address.  We are doing page-based (or
-	 * larger) allocations, and both the address and size must meet
-	 * alignment constraints.
-	 */
-	if (align < EFI_ALLOC_ALIGN)
-		align = EFI_ALLOC_ALIGN;
-
-	size = round_up(size, EFI_ALLOC_ALIGN);
-	nr_pages = size / EFI_PAGE_SIZE;
-	for (i = 0; i < map_size / desc_size; i++) {
-		efi_memory_desc_t *desc;
-		unsigned long m = (unsigned long)map;
-		u64 start, end;
-
-		desc = efi_early_memdesc_ptr(m, desc_size, i);
-
-		if (desc->type != EFI_CONVENTIONAL_MEMORY)
-			continue;
-
-		if (efi_soft_reserve_enabled() &&
-		    (desc->attribute & EFI_MEMORY_SP))
-			continue;
-
-		if (desc->num_pages < nr_pages)
-			continue;
-
-		start = desc->phys_addr;
-		end = start + desc->num_pages * EFI_PAGE_SIZE;
-
-		if (start < min)
-			start = min;
-
-		start = round_up(start, align);
-		if ((start + size) > end)
-			continue;
-
-		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
-				     EFI_LOADER_DATA, nr_pages, &start);
-		if (status == EFI_SUCCESS) {
-			*addr = start;
-			break;
-		}
-	}
-
-	if (i == map_size / desc_size)
-		status = EFI_NOT_FOUND;
-
-	efi_bs_call(free_pool, map);
-fail:
-	return status;
-}
-
-void efi_free(unsigned long size, unsigned long addr)
-{
-	unsigned long nr_pages;
-
-	if (!size)
-		return;
-
-	nr_pages = round_up(size, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
-	efi_bs_call(free_pages, addr, nr_pages);
-}
-
 static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
 				  void **handle, u64 *file_sz)
 {
@@ -695,73 +449,6 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 
 	return status;
 }
-/*
- * Relocate a kernel image, either compressed or uncompressed.
- * In the ARM64 case, all kernel images are currently
- * uncompressed, and as such when we relocate it we need to
- * allocate additional space for the BSS segment. Any low
- * memory that this function should avoid needs to be
- * unavailable in the EFI memory map, as if the preferred
- * address is not available the lowest available address will
- * be used.
- */
-efi_status_t efi_relocate_kernel(unsigned long *image_addr,
-				 unsigned long image_size,
-				 unsigned long alloc_size,
-				 unsigned long preferred_addr,
-				 unsigned long alignment,
-				 unsigned long min_addr)
-{
-	unsigned long cur_image_addr;
-	unsigned long new_addr = 0;
-	efi_status_t status;
-	unsigned long nr_pages;
-	efi_physical_addr_t efi_addr = preferred_addr;
-
-	if (!image_addr || !image_size || !alloc_size)
-		return EFI_INVALID_PARAMETER;
-	if (alloc_size < image_size)
-		return EFI_INVALID_PARAMETER;
-
-	cur_image_addr = *image_addr;
-
-	/*
-	 * The EFI firmware loader could have placed the kernel image
-	 * anywhere in memory, but the kernel has restrictions on the
-	 * max physical address it can run at.  Some architectures
-	 * also have a prefered address, so first try to relocate
-	 * to the preferred address.  If that fails, allocate as low
-	 * as possible while respecting the required alignment.
-	 */
-	nr_pages = round_up(alloc_size, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
-	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
-			     EFI_LOADER_DATA, nr_pages, &efi_addr);
-	new_addr = efi_addr;
-	/*
-	 * If preferred address allocation failed allocate as low as
-	 * possible.
-	 */
-	if (status != EFI_SUCCESS) {
-		status = efi_low_alloc_above(alloc_size, alignment, &new_addr,
-					     min_addr);
-	}
-	if (status != EFI_SUCCESS) {
-		pr_efi_err("Failed to allocate usable memory for kernel.\n");
-		return status;
-	}
-
-	/*
-	 * We know source/dest won't overlap since both memory ranges
-	 * have been allocated by UEFI, so we can safely use memcpy.
-	 */
-	memcpy((void *)new_addr, (void *)cur_image_addr, image_size);
-
-	/* Return the new address of the relocated image. */
-	*image_addr = new_addr;
-
-	return status;
-}
-
 /*
  * Get the number of UTF-8 bytes corresponding to an UTF-16 character.
  * This overestimates for surrogates, but that is okay.
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
new file mode 100644
index 000000000000..690648a7ca1e
--- /dev/null
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+#define EFI_MMAP_NR_SLACK_SLOTS	8
+
+static inline bool mmap_has_headroom(unsigned long buff_size,
+				     unsigned long map_size,
+				     unsigned long desc_size)
+{
+	unsigned long slack = buff_size - map_size;
+
+	return slack / desc_size >= EFI_MMAP_NR_SLACK_SLOTS;
+}
+
+efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
+{
+	efi_memory_desc_t *m = NULL;
+	efi_status_t status;
+	unsigned long key;
+	u32 desc_version;
+
+	*map->desc_size =	sizeof(*m);
+	*map->map_size =	*map->desc_size * 32;
+	*map->buff_size =	*map->map_size;
+again:
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+			     *map->map_size, (void **)&m);
+	if (status != EFI_SUCCESS)
+		goto fail;
+
+	*map->desc_size = 0;
+	key = 0;
+	status = efi_bs_call(get_memory_map, map->map_size, m,
+			     &key, map->desc_size, &desc_version);
+	if (status == EFI_BUFFER_TOO_SMALL ||
+	    !mmap_has_headroom(*map->buff_size, *map->map_size,
+			       *map->desc_size)) {
+		efi_bs_call(free_pool, m);
+		/*
+		 * Make sure there is some entries of headroom so that the
+		 * buffer can be reused for a new map after allocations are
+		 * no longer permitted.  Its unlikely that the map will grow to
+		 * exceed this headroom once we are ready to trigger
+		 * ExitBootServices()
+		 */
+		*map->map_size += *map->desc_size * EFI_MMAP_NR_SLACK_SLOTS;
+		*map->buff_size = *map->map_size;
+		goto again;
+	}
+
+	if (status != EFI_SUCCESS)
+		efi_bs_call(free_pool, m);
+
+	if (map->key_ptr && status == EFI_SUCCESS)
+		*map->key_ptr = key;
+	if (map->desc_ver && status == EFI_SUCCESS)
+		*map->desc_ver = desc_version;
+
+fail:
+	*map->map = m;
+	return status;
+}
+
+/*
+ * Allocate at the highest possible address that is not above 'max'.
+ */
+efi_status_t efi_high_alloc(unsigned long size, unsigned long align,
+			    unsigned long *addr, unsigned long max)
+{
+	unsigned long map_size, desc_size, buff_size;
+	efi_memory_desc_t *map;
+	efi_status_t status;
+	unsigned long nr_pages;
+	u64 max_addr = 0;
+	int i;
+	struct efi_boot_memmap boot_map;
+
+	boot_map.map =		&map;
+	boot_map.map_size =	&map_size;
+	boot_map.desc_size =	&desc_size;
+	boot_map.desc_ver =	NULL;
+	boot_map.key_ptr =	NULL;
+	boot_map.buff_size =	&buff_size;
+
+	status = efi_get_memory_map(&boot_map);
+	if (status != EFI_SUCCESS)
+		goto fail;
+
+	/*
+	 * Enforce minimum alignment that EFI or Linux requires when
+	 * requesting a specific address.  We are doing page-based (or
+	 * larger) allocations, and both the address and size must meet
+	 * alignment constraints.
+	 */
+	if (align < EFI_ALLOC_ALIGN)
+		align = EFI_ALLOC_ALIGN;
+
+	size = round_up(size, EFI_ALLOC_ALIGN);
+	nr_pages = size / EFI_PAGE_SIZE;
+again:
+	for (i = 0; i < map_size / desc_size; i++) {
+		efi_memory_desc_t *desc;
+		unsigned long m = (unsigned long)map;
+		u64 start, end;
+
+		desc = efi_early_memdesc_ptr(m, desc_size, i);
+		if (desc->type != EFI_CONVENTIONAL_MEMORY)
+			continue;
+
+		if (efi_soft_reserve_enabled() &&
+		    (desc->attribute & EFI_MEMORY_SP))
+			continue;
+
+		if (desc->num_pages < nr_pages)
+			continue;
+
+		start = desc->phys_addr;
+		end = start + desc->num_pages * EFI_PAGE_SIZE;
+
+		if (end > max)
+			end = max;
+
+		if ((start + size) > end)
+			continue;
+
+		if (round_down(end - size, align) < start)
+			continue;
+
+		start = round_down(end - size, align);
+
+		/*
+		 * Don't allocate at 0x0. It will confuse code that
+		 * checks pointers against NULL.
+		 */
+		if (start == 0x0)
+			continue;
+
+		if (start > max_addr)
+			max_addr = start;
+	}
+
+	if (!max_addr)
+		status = EFI_NOT_FOUND;
+	else {
+		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
+				     EFI_LOADER_DATA, nr_pages, &max_addr);
+		if (status != EFI_SUCCESS) {
+			max = max_addr;
+			max_addr = 0;
+			goto again;
+		}
+
+		*addr = max_addr;
+	}
+
+	efi_bs_call(free_pool, map);
+fail:
+	return status;
+}
+
+/*
+ * Allocate at the lowest possible address that is not below 'min'.
+ */
+efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
+				 unsigned long *addr, unsigned long min)
+{
+	unsigned long map_size, desc_size, buff_size;
+	efi_memory_desc_t *map;
+	efi_status_t status;
+	unsigned long nr_pages;
+	int i;
+	struct efi_boot_memmap boot_map;
+
+	boot_map.map		= &map;
+	boot_map.map_size	= &map_size;
+	boot_map.desc_size	= &desc_size;
+	boot_map.desc_ver	= NULL;
+	boot_map.key_ptr	= NULL;
+	boot_map.buff_size	= &buff_size;
+
+	status = efi_get_memory_map(&boot_map);
+	if (status != EFI_SUCCESS)
+		goto fail;
+
+	/*
+	 * Enforce minimum alignment that EFI or Linux requires when
+	 * requesting a specific address.  We are doing page-based (or
+	 * larger) allocations, and both the address and size must meet
+	 * alignment constraints.
+	 */
+	if (align < EFI_ALLOC_ALIGN)
+		align = EFI_ALLOC_ALIGN;
+
+	size = round_up(size, EFI_ALLOC_ALIGN);
+	nr_pages = size / EFI_PAGE_SIZE;
+	for (i = 0; i < map_size / desc_size; i++) {
+		efi_memory_desc_t *desc;
+		unsigned long m = (unsigned long)map;
+		u64 start, end;
+
+		desc = efi_early_memdesc_ptr(m, desc_size, i);
+
+		if (desc->type != EFI_CONVENTIONAL_MEMORY)
+			continue;
+
+		if (efi_soft_reserve_enabled() &&
+		    (desc->attribute & EFI_MEMORY_SP))
+			continue;
+
+		if (desc->num_pages < nr_pages)
+			continue;
+
+		start = desc->phys_addr;
+		end = start + desc->num_pages * EFI_PAGE_SIZE;
+
+		if (start < min)
+			start = min;
+
+		start = round_up(start, align);
+		if ((start + size) > end)
+			continue;
+
+		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
+				     EFI_LOADER_DATA, nr_pages, &start);
+		if (status == EFI_SUCCESS) {
+			*addr = start;
+			break;
+		}
+	}
+
+	if (i == map_size / desc_size)
+		status = EFI_NOT_FOUND;
+
+	efi_bs_call(free_pool, map);
+fail:
+	return status;
+}
+
+void efi_free(unsigned long size, unsigned long addr)
+{
+	unsigned long nr_pages;
+
+	if (!size)
+		return;
+
+	nr_pages = round_up(size, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
+	efi_bs_call(free_pages, addr, nr_pages);
+}
+
+/*
+ * Relocate a kernel image, either compressed or uncompressed.
+ * In the ARM64 case, all kernel images are currently
+ * uncompressed, and as such when we relocate it we need to
+ * allocate additional space for the BSS segment. Any low
+ * memory that this function should avoid needs to be
+ * unavailable in the EFI memory map, as if the preferred
+ * address is not available the lowest available address will
+ * be used.
+ */
+efi_status_t efi_relocate_kernel(unsigned long *image_addr,
+				 unsigned long image_size,
+				 unsigned long alloc_size,
+				 unsigned long preferred_addr,
+				 unsigned long alignment,
+				 unsigned long min_addr)
+{
+	unsigned long cur_image_addr;
+	unsigned long new_addr = 0;
+	efi_status_t status;
+	unsigned long nr_pages;
+	efi_physical_addr_t efi_addr = preferred_addr;
+
+	if (!image_addr || !image_size || !alloc_size)
+		return EFI_INVALID_PARAMETER;
+	if (alloc_size < image_size)
+		return EFI_INVALID_PARAMETER;
+
+	cur_image_addr = *image_addr;
+
+	/*
+	 * The EFI firmware loader could have placed the kernel image
+	 * anywhere in memory, but the kernel has restrictions on the
+	 * max physical address it can run at.  Some architectures
+	 * also have a prefered address, so first try to relocate
+	 * to the preferred address.  If that fails, allocate as low
+	 * as possible while respecting the required alignment.
+	 */
+	nr_pages = round_up(alloc_size, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
+	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
+			     EFI_LOADER_DATA, nr_pages, &efi_addr);
+	new_addr = efi_addr;
+	/*
+	 * If preferred address allocation failed allocate as low as
+	 * possible.
+	 */
+	if (status != EFI_SUCCESS) {
+		status = efi_low_alloc_above(alloc_size, alignment, &new_addr,
+					     min_addr);
+	}
+	if (status != EFI_SUCCESS) {
+		pr_efi_err("Failed to allocate usable memory for kernel.\n");
+		return status;
+	}
+
+	/*
+	 * We know source/dest won't overlap since both memory ranges
+	 * have been allocated by UEFI, so we can safely use memcpy.
+	 */
+	memcpy((void *)new_addr, (void *)cur_image_addr, image_size);
+
+	/* Return the new address of the relocated image. */
+	*image_addr = new_addr;
+
+	return status;
+}
-- 
2.17.1

