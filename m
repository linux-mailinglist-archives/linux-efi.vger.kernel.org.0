Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F5F157F63
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgBJQDT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbgBJQDT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:19 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64BB52467A;
        Mon, 10 Feb 2020 16:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350598;
        bh=xDY5ywegpIQfMf5Jxe7n7RKZXAOGf2hdpZjQZmUp8Qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1oEJNCawnyNBAXNM+SvTCwxDrvzIHxM3p5vZEW94L3xOLBN8JhmJfQXwMJ3VW5EUS
         qup5b9A/tGXfYAl4X2SS20FBDMjQNZK83rUmwxKcuISe6jXIxIw5Gr+BjHNBDKJud7
         /WjU3sHHzFp5SZRm18KdK4glZ+j4qdon73oMkcto=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 12/19] efi/libstub: Move efi_random_alloc() into separate source file
Date:   Mon, 10 Feb 2020 17:02:41 +0100
Message-Id: <20200210160248.4889-13-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efi_random_alloc() is only used on arm64, but as it shares a source
file with efi_random_get_seed(), the latter will pull in the former
on other architectures as well.

Let's take advantage of the fact that libstub is a static library,
and so the linker will only incorporate objects that are needed to
satisfy dependencies in other objects. This means we can move the
random alloc code to a separate source file that gets built
unconditionally, but only used when needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile      |   2 +-
 drivers/firmware/efi/libstub/random.c      | 114 ------------------
 drivers/firmware/efi/libstub/randomalloc.c | 124 ++++++++++++++++++++
 3 files changed, 125 insertions(+), 115 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 8e15634fa929..ac0d0e1ef32d 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -39,7 +39,7 @@ OBJECT_FILES_NON_STANDARD	:= y
 KCOV_INSTRUMENT			:= n
 
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
-				   mem.o random.o pci.o
+				   mem.o random.o randomalloc.o pci.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 316ce9ff0193..21e7e9325219 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/efi.h>
-#include <linux/log2.h>
 #include <asm/efi.h>
 
 #include "efistub.h"
@@ -39,119 +38,6 @@ efi_status_t efi_get_random_bytes(unsigned long size, u8 *out)
 	return efi_call_proto(rng, get_rng, NULL, size, out);
 }
 
-/*
- * Return the number of slots covered by this entry, i.e., the number of
- * addresses it covers that are suitably aligned and supply enough room
- * for the allocation.
- */
-static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
-					 unsigned long size,
-					 unsigned long align_shift)
-{
-	unsigned long align = 1UL << align_shift;
-	u64 first_slot, last_slot, region_end;
-
-	if (md->type != EFI_CONVENTIONAL_MEMORY)
-		return 0;
-
-	if (efi_soft_reserve_enabled() &&
-	    (md->attribute & EFI_MEMORY_SP))
-		return 0;
-
-	region_end = min((u64)ULONG_MAX, md->phys_addr + md->num_pages*EFI_PAGE_SIZE - 1);
-
-	first_slot = round_up(md->phys_addr, align);
-	last_slot = round_down(region_end - size + 1, align);
-
-	if (first_slot > last_slot)
-		return 0;
-
-	return ((unsigned long)(last_slot - first_slot) >> align_shift) + 1;
-}
-
-/*
- * The UEFI memory descriptors have a virtual address field that is only used
- * when installing the virtual mapping using SetVirtualAddressMap(). Since it
- * is unused here, we can reuse it to keep track of each descriptor's slot
- * count.
- */
-#define MD_NUM_SLOTS(md)	((md)->virt_addr)
-
-efi_status_t efi_random_alloc(unsigned long size,
-			      unsigned long align,
-			      unsigned long *addr,
-			      unsigned long random_seed)
-{
-	unsigned long map_size, desc_size, total_slots = 0, target_slot;
-	unsigned long buff_size;
-	efi_status_t status;
-	efi_memory_desc_t *memory_map;
-	int map_offset;
-	struct efi_boot_memmap map;
-
-	map.map =	&memory_map;
-	map.map_size =	&map_size;
-	map.desc_size =	&desc_size;
-	map.desc_ver =	NULL;
-	map.key_ptr =	NULL;
-	map.buff_size =	&buff_size;
-
-	status = efi_get_memory_map(&map);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	if (align < EFI_ALLOC_ALIGN)
-		align = EFI_ALLOC_ALIGN;
-
-	/* count the suitable slots in each memory map entry */
-	for (map_offset = 0; map_offset < map_size; map_offset += desc_size) {
-		efi_memory_desc_t *md = (void *)memory_map + map_offset;
-		unsigned long slots;
-
-		slots = get_entry_num_slots(md, size, ilog2(align));
-		MD_NUM_SLOTS(md) = slots;
-		total_slots += slots;
-	}
-
-	/* find a random number between 0 and total_slots */
-	target_slot = (total_slots * (u16)random_seed) >> 16;
-
-	/*
-	 * target_slot is now a value in the range [0, total_slots), and so
-	 * it corresponds with exactly one of the suitable slots we recorded
-	 * when iterating over the memory map the first time around.
-	 *
-	 * So iterate over the memory map again, subtracting the number of
-	 * slots of each entry at each iteration, until we have found the entry
-	 * that covers our chosen slot. Use the residual value of target_slot
-	 * to calculate the randomly chosen address, and allocate it directly
-	 * using EFI_ALLOCATE_ADDRESS.
-	 */
-	for (map_offset = 0; map_offset < map_size; map_offset += desc_size) {
-		efi_memory_desc_t *md = (void *)memory_map + map_offset;
-		efi_physical_addr_t target;
-		unsigned long pages;
-
-		if (target_slot >= MD_NUM_SLOTS(md)) {
-			target_slot -= MD_NUM_SLOTS(md);
-			continue;
-		}
-
-		target = round_up(md->phys_addr, align) + target_slot * align;
-		pages = round_up(size, EFI_PAGE_SIZE) / EFI_PAGE_SIZE;
-
-		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
-				     EFI_LOADER_DATA, pages, &target);
-		if (status == EFI_SUCCESS)
-			*addr = target;
-		break;
-	}
-
-	efi_bs_call(free_pool, memory_map);
-
-	return status;
-}
-
 efi_status_t efi_random_get_seed(void)
 {
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
new file mode 100644
index 000000000000..4578f59e160c
--- /dev/null
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Linaro Ltd;  <ard.biesheuvel@linaro.org>
+ */
+
+#include <linux/efi.h>
+#include <linux/log2.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+/*
+ * Return the number of slots covered by this entry, i.e., the number of
+ * addresses it covers that are suitably aligned and supply enough room
+ * for the allocation.
+ */
+static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
+					 unsigned long size,
+					 unsigned long align_shift)
+{
+	unsigned long align = 1UL << align_shift;
+	u64 first_slot, last_slot, region_end;
+
+	if (md->type != EFI_CONVENTIONAL_MEMORY)
+		return 0;
+
+	if (efi_soft_reserve_enabled() &&
+	    (md->attribute & EFI_MEMORY_SP))
+		return 0;
+
+	region_end = min(md->phys_addr + md->num_pages * EFI_PAGE_SIZE - 1,
+			 (u64)ULONG_MAX);
+
+	first_slot = round_up(md->phys_addr, align);
+	last_slot = round_down(region_end - size + 1, align);
+
+	if (first_slot > last_slot)
+		return 0;
+
+	return ((unsigned long)(last_slot - first_slot) >> align_shift) + 1;
+}
+
+/*
+ * The UEFI memory descriptors have a virtual address field that is only used
+ * when installing the virtual mapping using SetVirtualAddressMap(). Since it
+ * is unused here, we can reuse it to keep track of each descriptor's slot
+ * count.
+ */
+#define MD_NUM_SLOTS(md)	((md)->virt_addr)
+
+efi_status_t efi_random_alloc(unsigned long size,
+			      unsigned long align,
+			      unsigned long *addr,
+			      unsigned long random_seed)
+{
+	unsigned long map_size, desc_size, total_slots = 0, target_slot;
+	unsigned long buff_size;
+	efi_status_t status;
+	efi_memory_desc_t *memory_map;
+	int map_offset;
+	struct efi_boot_memmap map;
+
+	map.map =	&memory_map;
+	map.map_size =	&map_size;
+	map.desc_size =	&desc_size;
+	map.desc_ver =	NULL;
+	map.key_ptr =	NULL;
+	map.buff_size =	&buff_size;
+
+	status = efi_get_memory_map(&map);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	if (align < EFI_ALLOC_ALIGN)
+		align = EFI_ALLOC_ALIGN;
+
+	/* count the suitable slots in each memory map entry */
+	for (map_offset = 0; map_offset < map_size; map_offset += desc_size) {
+		efi_memory_desc_t *md = (void *)memory_map + map_offset;
+		unsigned long slots;
+
+		slots = get_entry_num_slots(md, size, ilog2(align));
+		MD_NUM_SLOTS(md) = slots;
+		total_slots += slots;
+	}
+
+	/* find a random number between 0 and total_slots */
+	target_slot = (total_slots * (u16)random_seed) >> 16;
+
+	/*
+	 * target_slot is now a value in the range [0, total_slots), and so
+	 * it corresponds with exactly one of the suitable slots we recorded
+	 * when iterating over the memory map the first time around.
+	 *
+	 * So iterate over the memory map again, subtracting the number of
+	 * slots of each entry at each iteration, until we have found the entry
+	 * that covers our chosen slot. Use the residual value of target_slot
+	 * to calculate the randomly chosen address, and allocate it directly
+	 * using EFI_ALLOCATE_ADDRESS.
+	 */
+	for (map_offset = 0; map_offset < map_size; map_offset += desc_size) {
+		efi_memory_desc_t *md = (void *)memory_map + map_offset;
+		efi_physical_addr_t target;
+		unsigned long pages;
+
+		if (target_slot >= MD_NUM_SLOTS(md)) {
+			target_slot -= MD_NUM_SLOTS(md);
+			continue;
+		}
+
+		target = round_up(md->phys_addr, align) + target_slot * align;
+		pages = round_up(size, EFI_PAGE_SIZE) / EFI_PAGE_SIZE;
+
+		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
+				     EFI_LOADER_DATA, pages, &target);
+		if (status == EFI_SUCCESS)
+			*addr = target;
+		break;
+	}
+
+	efi_bs_call(free_pool, memory_map);
+
+	return status;
+}
-- 
2.17.1

