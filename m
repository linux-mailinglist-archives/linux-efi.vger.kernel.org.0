Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6C61B765A
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgDXNHI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgDXNHH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:07:07 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4B1020736;
        Fri, 24 Apr 2020 13:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733626;
        bh=7KAnblsMPEX8fNveCLVX4SlaOtYuZcYiuTwICv9E6vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ndxR6fQma74mzrIPDYaNa6sqhLfWACo1lHwdYj/NvTR0e39FtL1X3uwtG6AqnoMI0
         zK4RUE0uonJEcqUR9JtABJ2wUBuBhtxsPKGM508eUN1ZfoLSmDtGB+8IW9fvRQ85pQ
         F1YvEnvsj63nhObQUZD0Y8lxv2O5JScm7GdV0fvw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 25/33] efi/libstub: Move efi_relocate_kernel() into separate source file
Date:   Fri, 24 Apr 2020 15:05:23 +0200
Message-Id: <20200424130531.30518-26-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move efi_relocate_kernel() into a separate source file, so that it
only gets pulled into builds for architectures that use it. Since
efi_relocate_kernel() is the only user of efi_low_alloc(), let's
move that over as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile   |   2 +-
 drivers/firmware/efi/libstub/efistub.h  |  15 --
 drivers/firmware/efi/libstub/mem.c      | 168 -----------------------
 drivers/firmware/efi/libstub/relocate.c | 174 ++++++++++++++++++++++++
 4 files changed, 175 insertions(+), 184 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/relocate.c

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index bb8af2b16c49..9a712a6e2f87 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -43,7 +43,7 @@ KCOV_INSTRUMENT			:= n
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
-				   alignedmem.o
+				   alignedmem.o relocate.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index baa0bc166074..2a0698d9dc78 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -639,21 +639,6 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len,
 
 efi_status_t efi_get_memory_map(struct efi_boot_memmap *map);
 
-efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
-				 unsigned long *addr, unsigned long min);
-
-static inline
-efi_status_t efi_low_alloc(unsigned long size, unsigned long align,
-			   unsigned long *addr)
-{
-	/*
-	 * Don't allocate at 0x0. It will confuse code that
-	 * checks pointers against NULL. Skip the first 8
-	 * bytes so we start at a nice even number.
-	 */
-	return efi_low_alloc_above(size, align, addr, 0x8);
-}
-
 efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 				unsigned long max);
 
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 0020b0fa9587..6e0ee6b3d897 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -111,96 +111,6 @@ efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 	return EFI_SUCCESS;
 }
 
-/**
- * efi_low_alloc_above() - allocate pages at or above given address
- * @size:	size of the memory area to allocate
- * @align:	minimum alignment of the allocated memory area. It should
- *		a power of two.
- * @addr:	on exit the address of the allocated memory
- * @min:	minimum address to used for the memory allocation
- *
- * Allocate at the lowest possible address that is not below @min as
- * EFI_LOADER_DATA. The allocated pages are aligned according to @align but at
- * least EFI_ALLOC_ALIGN. The first allocated page will not below the address
- * given by @min.
- *
- * Return:	status code
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
-	boot_map.map		= &map;
-	boot_map.map_size	= &map_size;
-	boot_map.desc_size	= &desc_size;
-	boot_map.desc_ver	= NULL;
-	boot_map.key_ptr	= NULL;
-	boot_map.buff_size	= &buff_size;
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
 /**
  * efi_free() - free memory pages
  * @size:	size of the memory area to free in bytes
@@ -222,81 +132,3 @@ void efi_free(unsigned long size, unsigned long addr)
 	nr_pages = round_up(size, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
 	efi_bs_call(free_pages, addr, nr_pages);
 }
-
-/**
- * efi_relocate_kernel() - copy memory area
- * @image_addr:		pointer to address of memory area to copy
- * @image_size:		size of memory area to copy
- * @alloc_size:		minimum size of memory to allocate, must be greater or
- *			equal to image_size
- * @preferred_addr:	preferred target address
- * @alignment:		minimum alignment of the allocated memory area. It
- *			should be a power of two.
- * @min_addr:		minimum target address
- *
- * Copy a memory area to a newly allocated memory area aligned according
- * to @alignment but at least EFI_ALLOC_ALIGN. If the preferred address
- * is not available, the allocated address will not be below @min_addr.
- * On exit, @image_addr is updated to the target copy address that was used.
- *
- * This function is used to copy the Linux kernel verbatim. It does not apply
- * any relocation changes.
- *
- * Return:		status code
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
diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
new file mode 100644
index 000000000000..1507d3c82884
--- /dev/null
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+/**
+ * efi_low_alloc_above() - allocate pages at or above given address
+ * @size:	size of the memory area to allocate
+ * @align:	minimum alignment of the allocated memory area. It should
+ *		a power of two.
+ * @addr:	on exit the address of the allocated memory
+ * @min:	minimum address to used for the memory allocation
+ *
+ * Allocate at the lowest possible address that is not below @min as
+ * EFI_LOADER_DATA. The allocated pages are aligned according to @align but at
+ * least EFI_ALLOC_ALIGN. The first allocated page will not below the address
+ * given by @min.
+ *
+ * Return:	status code
+ */
+static efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
+					unsigned long *addr, unsigned long min)
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
+/**
+ * efi_relocate_kernel() - copy memory area
+ * @image_addr:		pointer to address of memory area to copy
+ * @image_size:		size of memory area to copy
+ * @alloc_size:		minimum size of memory to allocate, must be greater or
+ *			equal to image_size
+ * @preferred_addr:	preferred target address
+ * @alignment:		minimum alignment of the allocated memory area. It
+ *			should be a power of two.
+ * @min_addr:		minimum target address
+ *
+ * Copy a memory area to a newly allocated memory area aligned according
+ * to @alignment but at least EFI_ALLOC_ALIGN. If the preferred address
+ * is not available, the allocated address will not be below @min_addr.
+ * On exit, @image_addr is updated to the target copy address that was used.
+ *
+ * This function is used to copy the Linux kernel verbatim. It does not apply
+ * any relocation changes.
+ *
+ * Return:		status code
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

