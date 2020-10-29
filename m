Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9B129ED84
	for <lists+linux-efi@lfdr.de>; Thu, 29 Oct 2020 14:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgJ2NtK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 29 Oct 2020 09:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgJ2NtJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 29 Oct 2020 09:49:09 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FD762076A;
        Thu, 29 Oct 2020 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603979349;
        bh=rZL136yHpcK3ne8gnz6h6Y9W2J0q7UBu4PPsmTKFOf0=;
        h=From:To:Cc:Subject:Date:From;
        b=PFHA7oGhy4a7dVN+Wpxjn4iVizkrg9GspHqL2BAzs/v7LQaDgxcQnbdafbqOGb6GJ
         jJMMJ3OhN2Fnvd7zInMAMlTvUzMxFsxDrXMlzfT8Vic6L6JCjo1cZ/2pfVNE6aOK+s
         w5lBA/+pAXg8B7hu5t6ZfaDynLJzoNgO9jgMa96I=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     atish.patra@wdc.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: stub: get rid of efi_get_max_fdt_addr()
Date:   Thu, 29 Oct 2020 14:49:01 +0100
Message-Id: <20201029134901.9773-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that ARM started following the example of arm64 and RISC-V, and
no longer imposes any restrictions on the placement of the FDT in
memory at boot, we no longer need per-arch implementations of
efi_get_max_fdt_addr() to factor out the differences. So get rid of
it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h              | 6 ------
 arch/arm64/include/asm/efi.h            | 6 ------
 arch/riscv/include/asm/efi.h            | 6 ------
 drivers/firmware/efi/libstub/efi-stub.c | 1 -
 drivers/firmware/efi/libstub/efistub.h  | 1 -
 drivers/firmware/efi/libstub/fdt.c      | 3 +--
 6 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 3ee4f4381985..0496bc96a092 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -74,12 +74,6 @@ static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
  */
 #define EFI_PHYS_ALIGN		SZ_16M
 
-/* on ARM, the FDT should be located in a lowmem region */
-static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
-{
-	return round_down(image_addr, EFI_PHYS_ALIGN) + SZ_512M;
-}
-
 /* on ARM, the initrd should be loaded in a lowmem region */
 static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 {
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 973b14415271..01446a073b2e 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -64,12 +64,6 @@ efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 #define EFI_KIMG_ALIGN	\
 	(SEGMENT_ALIGN > THREAD_ALIGN ? SEGMENT_ALIGN : THREAD_ALIGN)
 
-/* on arm64, the FDT may be located anywhere in system RAM */
-static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
-{
-	return ULONG_MAX;
-}
-
 /*
  * On arm64, we have to ensure that the initrd ends up in the linear region,
  * which is a 1 GB aligned region of size '1UL << (VA_BITS_MIN - 1)' that is
diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index 7542282f1141..6d98cd999680 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -27,12 +27,6 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 
 #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
 
-/* on RISC-V, the FDT may be located anywhere in system RAM */
-static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
-{
-	return ULONG_MAX;
-}
-
 /* Load initrd at enough distance from DRAM start */
 static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 {
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 914a343c7785..ec2f3985bef3 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -273,7 +273,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	install_memreserve_table();
 
 	status = allocate_new_fdt_and_exit_boot(handle, &fdt_addr,
-						efi_get_max_fdt_addr(image_addr),
 						initrd_addr, initrd_size,
 						cmdline_ptr, fdt_addr, fdt_size);
 	if (status != EFI_SUCCESS)
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 2d7abcd99de9..c1c63e847481 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -750,7 +750,6 @@ efi_status_t efi_exit_boot_services(void *handle,
 
 efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 					    unsigned long *new_fdt_addr,
-					    unsigned long max_addr,
 					    u64 initrd_addr, u64 initrd_size,
 					    char *cmdline_ptr,
 					    unsigned long fdt_addr,
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 368cd60000ee..365c3a43a198 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -238,7 +238,6 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
 
 efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 					    unsigned long *new_fdt_addr,
-					    unsigned long max_addr,
 					    u64 initrd_addr, u64 initrd_size,
 					    char *cmdline_ptr,
 					    unsigned long fdt_addr,
@@ -275,7 +274,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	efi_info("Exiting boot services and installing virtual address map...\n");
 
 	map.map = &memory_map;
-	status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, max_addr);
+	status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, ULONG_MAX);
 	if (status != EFI_SUCCESS) {
 		efi_err("Unable to allocate memory for new device tree.\n");
 		goto fail;
-- 
2.17.1

