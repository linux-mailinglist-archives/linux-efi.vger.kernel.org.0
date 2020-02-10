Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E3D15824D
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 19:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgBJSaS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 13:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgBJSaS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 13:30:18 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8293220838;
        Mon, 10 Feb 2020 18:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581359417;
        bh=S2dPYF+pX5Zsxi/BD4n/ZCIIzKtCMYV2EuW0eeElZbo=;
        h=From:To:Cc:Subject:Date:From;
        b=lSriZeYS14Wi+4fsuiG6t3xfWv/nGGHCt1qCKCSiUSMRpdOPhFHacTj54csylhX9m
         cVGtor1fPQpEezl7/Ritq+2UwjjDSOaE+SNUjbAUUBTY4BXGNH7onjYGdvHYRURnYg
         D6HOEDYVO9pexUbxOACbQ0gfYPps3MKZ2LCkaku8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2] efi/libstub/arm64: Use 1:1 mapping of RT services if property table exists
Date:   Mon, 10 Feb 2020 19:29:36 +0100
Message-Id: <20200210182936.10453-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The UEFI spec defines (and deprecates) a misguided and shortlived
memory protection feature that is based on splitting memory regions
covering PE/COFF executables into separate code and data regions,
without annotating them as belonging to the same executable image.
When the OS assigns the virtual addresses of these regions, it may
move them around arbitrarily, without taking into account that the
PE/COFF code sections may contain relative references into the data
sections, which means the relative placement of these segments has
to be preserved or the executable image will be corrupted.

The original workaround on arm64 was to ensure that adjacent regions
of the same type were mapped adjacently in the virtual mapping, but
this requires sorting of the memory map, which we would prefer to
avoid.

Considering that the native physical mapping of the PE/COFF images
does not suffer from this issue, let's preserve it at runtime, and
install it as the virtual mapping as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2: call SetVirtualAddressMap() with 1:1 mapping rather than not calling it at
    all if the properties table exists and has the NX PE data attribute set

 drivers/firmware/efi/libstub/Makefile   |  1 -
 drivers/firmware/efi/libstub/arm-stub.c | 84 +++++---------------
 2 files changed, 22 insertions(+), 63 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 98a81576213d..f14b7636323a 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -43,7 +43,6 @@ lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
-arm-deps-$(CONFIG_ARM64) += sort.c
 
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 7bbef4a67350..d357393e680e 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/efi.h>
-#include <linux/sort.h>
 #include <asm/efi.h>
 
 #include "efistub.h"
@@ -36,6 +35,7 @@
 #endif
 
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
+static bool __efistub_global flat_va_mapping;
 
 static efi_system_table_t *__efistub_global sys_table;
 
@@ -126,6 +126,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	unsigned long reserve_size = 0;
 	enum efi_secureboot_mode secure_boot;
 	struct screen_info *si;
+	efi_properties_table_t *prop_tbl;
 
 	sys_table = sys_table_arg;
 
@@ -235,8 +236,20 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 
 	efi_random_get_seed();
 
+	/*
+	 * If the NX PE data feature is enabled in the properties table, we
+	 * should take care not to create a virtual mapping that changes the
+	 * relative placement of runtime services code and data regions, as
+	 * they may belong to the same PE/COFF executable image in memory.
+	 * The easiest way to achieve that is to simply use a 1:1 mapping.
+	 */
+	prop_tbl = get_efi_config_table(EFI_PROPERTIES_TABLE_GUID);
+	flat_va_mapping = prop_tbl &&
+			  (prop_tbl->memory_protection_attribute &
+			   EFI_PROPERTIES_RUNTIME_MEMORY_PROTECTION_NON_EXECUTABLE_PE_DATA);
+
 	/* hibernation expects the runtime regions to stay in the same place */
-	if (!IS_ENABLED(CONFIG_HIBERNATION) && !nokaslr()) {
+	if (!IS_ENABLED(CONFIG_HIBERNATION) && !nokaslr() && !flat_va_mapping) {
 		/*
 		 * Randomize the base of the UEFI runtime services region.
 		 * Preserve the 2 MB alignment of the region by taking a
@@ -286,44 +299,6 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	return EFI_ERROR;
 }
 
-static int cmp_mem_desc(const void *l, const void *r)
-{
-	const efi_memory_desc_t *left = l, *right = r;
-
-	return (left->phys_addr > right->phys_addr) ? 1 : -1;
-}
-
-/*
- * Returns whether region @left ends exactly where region @right starts,
- * or false if either argument is NULL.
- */
-static bool regions_are_adjacent(efi_memory_desc_t *left,
-				 efi_memory_desc_t *right)
-{
-	u64 left_end;
-
-	if (left == NULL || right == NULL)
-		return false;
-
-	left_end = left->phys_addr + left->num_pages * EFI_PAGE_SIZE;
-
-	return left_end == right->phys_addr;
-}
-
-/*
- * Returns whether region @left and region @right have compatible memory type
- * mapping attributes, and are both EFI_MEMORY_RUNTIME regions.
- */
-static bool regions_have_compatible_memory_type_attrs(efi_memory_desc_t *left,
-						      efi_memory_desc_t *right)
-{
-	static const u64 mem_type_mask = EFI_MEMORY_WB | EFI_MEMORY_WT |
-					 EFI_MEMORY_WC | EFI_MEMORY_UC |
-					 EFI_MEMORY_RUNTIME;
-
-	return ((left->attribute ^ right->attribute) & mem_type_mask) == 0;
-}
-
 /*
  * efi_get_virtmap() - create a virtual mapping for the EFI memory map
  *
@@ -336,23 +311,10 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 		     int *count)
 {
 	u64 efi_virt_base = virtmap_base;
-	efi_memory_desc_t *in, *prev = NULL, *out = runtime_map;
+	efi_memory_desc_t *in, *out = runtime_map;
 	int l;
 
-	/*
-	 * To work around potential issues with the Properties Table feature
-	 * introduced in UEFI 2.5, which may split PE/COFF executable images
-	 * in memory into several RuntimeServicesCode and RuntimeServicesData
-	 * regions, we need to preserve the relative offsets between adjacent
-	 * EFI_MEMORY_RUNTIME regions with the same memory type attributes.
-	 * The easiest way to find adjacent regions is to sort the memory map
-	 * before traversing it.
-	 */
-	if (IS_ENABLED(CONFIG_ARM64))
-		sort(memory_map, map_size / desc_size, desc_size, cmp_mem_desc,
-		     NULL);
-
-	for (l = 0; l < map_size; l += desc_size, prev = in) {
+	for (l = 0; l < map_size; l += desc_size) {
 		u64 paddr, size;
 
 		in = (void *)memory_map + l;
@@ -362,8 +324,8 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 		paddr = in->phys_addr;
 		size = in->num_pages * EFI_PAGE_SIZE;
 
+		in->virt_addr = in->phys_addr;
 		if (novamap()) {
-			in->virt_addr = in->phys_addr;
 			continue;
 		}
 
@@ -372,9 +334,7 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 		 * a 4k page size kernel to kexec a 64k page size kernel and
 		 * vice versa.
 		 */
-		if ((IS_ENABLED(CONFIG_ARM64) &&
-		     !regions_are_adjacent(prev, in)) ||
-		    !regions_have_compatible_memory_type_attrs(prev, in)) {
+		if (!flat_va_mapping) {
 
 			paddr = round_down(in->phys_addr, SZ_64K);
 			size += in->phys_addr - paddr;
@@ -389,10 +349,10 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 				efi_virt_base = round_up(efi_virt_base, SZ_2M);
 			else
 				efi_virt_base = round_up(efi_virt_base, SZ_64K);
-		}
 
-		in->virt_addr = efi_virt_base + in->phys_addr - paddr;
-		efi_virt_base += size;
+			in->virt_addr += efi_virt_base - paddr;
+			efi_virt_base += size;
+		}
 
 		memcpy(out, in, desc_size);
 		out = (void *)out + desc_size;
-- 
2.17.1

