Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED28157F5C
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBJQDJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbgBJQDJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:09 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2789621569;
        Mon, 10 Feb 2020 16:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350588;
        bh=S2eliISg/+Q+9Odm/AMeFO2bH+WSNeQKwKkfIiZJxIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qyOYqEJZ6ldsKflV0QszkOeloTe0vXpup47Df3ncZ/mTIuzuhkNyhLVLx/V8HOEKx
         eV3/6QErcouGjC6Xqt+5cn+7oGvudGu+b2ResdNCUTSosj06iYFYiyzPme8DgcnxbJ
         ry6TxCE8HivuHkr8un0nJ+6ws50FWQefdvw9z10c=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 06/19] efi/libstub: Simplify efi_high_alloc() and rename to efi_allocate_pages()
Date:   Mon, 10 Feb 2020 17:02:35 +0100
Message-Id: <20200210160248.4889-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The implementation of efi_high_alloc() uses a complicated way of
traversing the memory map to find an available region that is located
as close as possible to the provided upper limit, and calls AllocatePages
subsequently to create the allocation at that exact address.

This is precisely what the EFI_ALLOCATE_MAX_ADDRESS allocation type
argument to AllocatePages() does, and considering that EFI_ALLOC_ALIGN
only exceeds EFI_PAGE_SIZE on arm64, let's use AllocatePages() directly
and implement the alignment using code that the compiler can remove if
it does not exceed EFI_PAGE_SIZE.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c |   5 +-
 drivers/firmware/efi/libstub/fdt.c             |   3 +-
 drivers/firmware/efi/libstub/mem.c             | 102 ++++----------------
 include/linux/efi.h                            |   4 +-
 4 files changed, 23 insertions(+), 91 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 60d13c7a2e92..7afe31357df3 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -385,8 +385,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 		 * so allocate enough memory for all the files.  This is used
 		 * for loading multiple files.
 		 */
-		status = efi_high_alloc(file_size_total, 0x1000, &file_addr,
-					max_addr);
+		status = efi_allocate_pages(file_size_total, &file_addr, max_addr);
 		if (status != EFI_SUCCESS) {
 			pr_efi_err("Failed to alloc highmem for files\n");
 			goto close_handles;
@@ -536,7 +535,7 @@ char *efi_convert_cmdline(efi_loaded_image_t *image,
 
 	options_bytes++;	/* NUL termination */
 
-	status = efi_high_alloc(options_bytes, 0, &cmdline_addr,
+	status = efi_allocate_pages(options_bytes, &cmdline_addr,
 				MAX_CMDLINE_ADDRESS);
 	if (status != EFI_SUCCESS)
 		return NULL;
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index f71cd54823b7..46cffac7a5f1 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -277,8 +277,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	pr_efi("Exiting boot services and installing virtual address map...\n");
 
 	map.map = &memory_map;
-	status = efi_high_alloc(MAX_FDT_SIZE, EFI_PAGE_SIZE,
-				new_fdt_addr, max_addr);
+	status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, max_addr);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Unable to allocate memory for new device tree.\n");
 		goto fail;
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 690648a7ca1e..5808c8764e64 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -68,100 +68,34 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
 /*
  * Allocate at the highest possible address that is not above 'max'.
  */
-efi_status_t efi_high_alloc(unsigned long size, unsigned long align,
-			    unsigned long *addr, unsigned long max)
+efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
+				unsigned long max)
 {
-	unsigned long map_size, desc_size, buff_size;
-	efi_memory_desc_t *map;
+	efi_physical_addr_t alloc_addr = ALIGN_DOWN(max + 1, EFI_ALLOC_ALIGN) - 1;
+	int slack = EFI_ALLOC_ALIGN / EFI_PAGE_SIZE - 1;
 	efi_status_t status;
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
 
 	size = round_up(size, EFI_ALLOC_ALIGN);
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
+	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
+			     EFI_LOADER_DATA, size / EFI_PAGE_SIZE + slack,
+			     &alloc_addr);
+	if (status != EFI_SUCCESS)
+		return status;
 
-		/*
-		 * Don't allocate at 0x0. It will confuse code that
-		 * checks pointers against NULL.
-		 */
-		if (start == 0x0)
-			continue;
+	*addr = ALIGN((unsigned long)alloc_addr, EFI_ALLOC_ALIGN);
 
-		if (start > max_addr)
-			max_addr = start;
-	}
+	if (slack > 0) {
+		int l = (alloc_addr % EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
 
-	if (!max_addr)
-		status = EFI_NOT_FOUND;
-	else {
-		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
-				     EFI_LOADER_DATA, nr_pages, &max_addr);
-		if (status != EFI_SUCCESS) {
-			max = max_addr;
-			max_addr = 0;
-			goto again;
+		if (l) {
+			efi_bs_call(free_pages, alloc_addr, slack - l + 1);
+			slack = l - 1;
 		}
-
-		*addr = max_addr;
+		if (slack)
+			efi_bs_call(free_pages, *addr + size, slack);
 	}
-
-	efi_bs_call(free_pool, map);
-fail:
-	return status;
+	return EFI_SUCCESS;
 }
-
 /*
  * Allocate at the lowest possible address that is not below 'min'.
  */
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7efd7072cca5..7e231c3cfb6f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1508,8 +1508,8 @@ efi_status_t efi_low_alloc(unsigned long size, unsigned long align,
 	return efi_low_alloc_above(size, align, addr, 0x8);
 }
 
-efi_status_t efi_high_alloc(unsigned long size, unsigned long align,
-			    unsigned long *addr, unsigned long max);
+efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
+				unsigned long max);
 
 efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 				 unsigned long image_size,
-- 
2.17.1

