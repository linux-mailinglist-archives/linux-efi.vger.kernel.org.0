Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8780E26308B
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 17:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgIIP3M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 11:29:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbgIIP1Z (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:25 -0400
Received: from e123331-lin.nice.arm.com (adsl-204.109.242.29.tellas.gr [109.242.29.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85C1A2226B;
        Wed,  9 Sep 2020 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599664613;
        bh=PnbFTr3DTAVHLV/Zp4Z5GFMApu7cekP2Ty8raISft1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMu7XqLOkj8vCZ+4T7O79KhKzp96wTRlSa+XNM1URMcJutEbDTxHeUmWE/O+VkWtH
         XR7M1gsqbTvbEpkEUVSXMCAJFlhiHm7VQEMwUGy8b3uXhrIkoVkuuzdQaEF5BIJP+V
         mjjeO+sl56ODukfrR55WCbwuDvFlv6/RHQvjZDZQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Francois Ozog <francois.ozog@linaro.org>,
        Etienne CARRIERE <etienne.carriere@st.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Grant Likely <Grant.Likely@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Christophe Priouzeau <christophe.priouzeau@linaro.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Patrick DELAUNAY <patrick.delaunay@st.com>
Subject: [PATCH RFC/RFT 2/3] efi/libstub: Use low allocation for the uncompressed kernel
Date:   Wed,  9 Sep 2020 18:16:22 +0300
Message-Id: <20200909151623.16153-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909151623.16153-1-ardb@kernel.org>
References: <20200909151623.16153-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Before commit

  d0f9ca9be11f25ef ("ARM: decompressor: run decompressor in place if loaded via UEFI")

we were rather limited in the choice of base address for the uncompressed
kernel, as we were relying on the logic in the decompressor that blindly
rounds down the decompressor execution address to the next multiple of 128
MiB, and decompresses the kernel there. For this reason, we have a lot of
complicated memory region handling code, to ensure that this memory window
is available, even though it could be occupied by reserved regions or
other allocations that may or may not collide with the uncompressed image.

Today, we simply pass the target address for the decompressed image to the
decompressor directly, and so we can choose a suitable window just by
finding a 16 MiB aligned region, while taking TEXT_OFFSET and the region
for the swapper page tables into account.

So let's get rid of the complicated logic, and instead, use the existing
bottom up allocation routine to allocate a suitable window as low as
possible, and carve out a memory region that has the right properties.

Note that this removes any dependencies on the 'dram_base' argument to
handle_kernel_image(), which we will hopefully be able to remove entirely
in a future patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm32-stub.c | 177 ++++----------------
 1 file changed, 37 insertions(+), 140 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index d08e5d55838c..a9a4da98c7a0 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -113,134 +113,6 @@ void free_screen_info(struct screen_info *si)
 	efi_bs_call(free_pool, si);
 }
 
-static efi_status_t reserve_kernel_base(unsigned long dram_base,
-					unsigned long *reserve_addr,
-					unsigned long *reserve_size)
-{
-	efi_physical_addr_t alloc_addr;
-	efi_memory_desc_t *memory_map;
-	unsigned long nr_pages, map_size, desc_size, buff_size;
-	efi_status_t status;
-	unsigned long l;
-
-	struct efi_boot_memmap map = {
-		.map		= &memory_map,
-		.map_size	= &map_size,
-		.desc_size	= &desc_size,
-		.desc_ver	= NULL,
-		.key_ptr	= NULL,
-		.buff_size	= &buff_size,
-	};
-
-	/*
-	 * Reserve memory for the uncompressed kernel image. This is
-	 * all that prevents any future allocations from conflicting
-	 * with the kernel. Since we can't tell from the compressed
-	 * image how much DRAM the kernel actually uses (due to BSS
-	 * size uncertainty) we allocate the maximum possible size.
-	 * Do this very early, as prints can cause memory allocations
-	 * that may conflict with this.
-	 */
-	alloc_addr = dram_base + MAX_UNCOMP_KERNEL_SIZE;
-	nr_pages = MAX_UNCOMP_KERNEL_SIZE / EFI_PAGE_SIZE;
-	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
-			     EFI_BOOT_SERVICES_DATA, nr_pages, &alloc_addr);
-	if (status == EFI_SUCCESS) {
-		if (alloc_addr == dram_base) {
-			*reserve_addr = alloc_addr;
-			*reserve_size = MAX_UNCOMP_KERNEL_SIZE;
-			return EFI_SUCCESS;
-		}
-		/*
-		 * If we end up here, the allocation succeeded but starts below
-		 * dram_base. This can only occur if the real base of DRAM is
-		 * not a multiple of 128 MB, in which case dram_base will have
-		 * been rounded up. Since this implies that a part of the region
-		 * was already occupied, we need to fall through to the code
-		 * below to ensure that the existing allocations don't conflict.
-		 * For this reason, we use EFI_BOOT_SERVICES_DATA above and not
-		 * EFI_LOADER_DATA, which we wouldn't able to distinguish from
-		 * allocations that we want to disallow.
-		 */
-	}
-
-	/*
-	 * If the allocation above failed, we may still be able to proceed:
-	 * if the only allocations in the region are of types that will be
-	 * released to the OS after ExitBootServices(), the decompressor can
-	 * safely overwrite them.
-	 */
-	status = efi_get_memory_map(&map);
-	if (status != EFI_SUCCESS) {
-		efi_err("reserve_kernel_base(): Unable to retrieve memory map.\n");
-		return status;
-	}
-
-	for (l = 0; l < map_size; l += desc_size) {
-		efi_memory_desc_t *desc;
-		u64 start, end;
-
-		desc = (void *)memory_map + l;
-		start = desc->phys_addr;
-		end = start + desc->num_pages * EFI_PAGE_SIZE;
-
-		/* Skip if entry does not intersect with region */
-		if (start >= dram_base + MAX_UNCOMP_KERNEL_SIZE ||
-		    end <= dram_base)
-			continue;
-
-		switch (desc->type) {
-		case EFI_BOOT_SERVICES_CODE:
-		case EFI_BOOT_SERVICES_DATA:
-			/* Ignore types that are released to the OS anyway */
-			continue;
-
-		case EFI_CONVENTIONAL_MEMORY:
-			/* Skip soft reserved conventional memory */
-			if (efi_soft_reserve_enabled() &&
-			    (desc->attribute & EFI_MEMORY_SP))
-				continue;
-
-			/*
-			 * Reserve the intersection between this entry and the
-			 * region.
-			 */
-			start = max(start, (u64)dram_base);
-			end = min(end, (u64)dram_base + MAX_UNCOMP_KERNEL_SIZE);
-
-			status = efi_bs_call(allocate_pages,
-					     EFI_ALLOCATE_ADDRESS,
-					     EFI_LOADER_DATA,
-					     (end - start) / EFI_PAGE_SIZE,
-					     &start);
-			if (status != EFI_SUCCESS) {
-				efi_err("reserve_kernel_base(): alloc failed.\n");
-				goto out;
-			}
-			break;
-
-		case EFI_LOADER_CODE:
-		case EFI_LOADER_DATA:
-			/*
-			 * These regions may be released and reallocated for
-			 * another purpose (including EFI_RUNTIME_SERVICE_DATA)
-			 * at any time during the execution of the OS loader,
-			 * so we cannot consider them as safe.
-			 */
-		default:
-			/*
-			 * Treat any other allocation in the region as unsafe */
-			status = EFI_OUT_OF_RESOURCES;
-			goto out;
-		}
-	}
-
-	status = EFI_SUCCESS;
-out:
-	efi_bs_call(free_pool, memory_map);
-	return status;
-}
-
 efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
@@ -248,27 +120,52 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long dram_base,
 				 efi_loaded_image_t *image)
 {
-	unsigned long kernel_base;
+	const int slack = TEXT_OFFSET - 5 * PAGE_SIZE;
+	int alloc_size = MAX_UNCOMP_KERNEL_SIZE + SZ_16M + slack;
+	unsigned long alloc_base, kernel_base;
 	efi_status_t status;
 
-	/* use a 16 MiB aligned base for the decompressed kernel */
-	kernel_base = round_up(dram_base, SZ_16M) + TEXT_OFFSET;
-
 	/*
-	 * Note that some platforms (notably, the Raspberry Pi 2) put
-	 * spin-tables and other pieces of firmware at the base of RAM,
-	 * abusing the fact that the window of TEXT_OFFSET bytes at the
-	 * base of the kernel image is only partially used at the moment.
-	 * (Up to 5 pages are used for the swapper page tables)
+	 * Allocate space for the decompressed kernel as low as possible.
+	 * The region should be 16 MiB aligned, but the first 'slack' bytes
+	 * are not used by Linux, so we allow those to be occupied by the
+	 * firmware.
 	 */
-	status = reserve_kernel_base(kernel_base - 5 * PAGE_SIZE, reserve_addr,
-				     reserve_size);
+	status = efi_low_alloc_above(alloc_size, EFI_PAGE_SIZE, &alloc_base, 0x0);
 	if (status != EFI_SUCCESS) {
 		efi_err("Unable to allocate memory for uncompressed kernel.\n");
 		return status;
 	}
 
-	*image_addr = kernel_base;
+	if ((alloc_base % SZ_16M) > slack) {
+		/*
+		 * More than 'slack' bytes are already occupied at the base of
+		 * the allocation, so we need to advance to the next 16 MiB block.
+		 */
+		kernel_base = round_up(alloc_base, SZ_16M);
+		efi_info("Free memory starts at 0x%lx, setting kernel_base to 0x%lx\n",
+			 alloc_base, kernel_base);
+	} else {
+		kernel_base = round_down(alloc_base, SZ_16M);
+	}
+
+	*reserve_addr = kernel_base + slack;
+	*reserve_size = MAX_UNCOMP_KERNEL_SIZE;
+
+	/* now free the parts that we will not use */
+	if (*reserve_addr > alloc_base) {
+		efi_bs_call(free_pages, alloc_base,
+			    (*reserve_addr - alloc_base) / EFI_PAGE_SIZE);
+		alloc_size -= *reserve_addr - alloc_base;
+	}
+	efi_bs_call(free_pages, *reserve_addr + MAX_UNCOMP_KERNEL_SIZE,
+		    (alloc_size - MAX_UNCOMP_KERNEL_SIZE) / EFI_PAGE_SIZE);
+
+	*image_addr = kernel_base + TEXT_OFFSET;
 	*image_size = 0;
+
+	efi_debug("image addr == 0x%lx, reserve_addr == 0x%lx\n",
+		  *image_addr, *reserve_addr);
+
 	return EFI_SUCCESS;
 }
-- 
2.17.1

