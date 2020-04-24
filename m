Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694011B7661
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgDXNHT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgDXNHS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:07:18 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77D2F21582;
        Fri, 24 Apr 2020 13:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733637;
        bh=pZDLek65a4BFU9uhFDTfw0N0CAWf3NQxjP4QC3U79HA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvUkIOD2YpnBWVGMBQXUwFo0/RgLRR4H4d9/gzt4VOxNLfbZCzNY1PfE44yq7LuGr
         IaOe9GUruRikPtw1bCZv0viX8hrb0Tbh0py/diKrVxa0k+shmd7vxle4etWh7DxMgI
         ZP3n9lKqkbaC5gE8CesbdIyRVHdYAUN7DLIUAqjI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 30/33] efi/libstub: Drop __pure getters for EFI stub options
Date:   Fri, 24 Apr 2020 15:05:28 +0200
Message-Id: <20200424130531.30518-31-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The practice of using __pure getter functions to access global
variables in the EFI stub dates back to the time when we had to
carefully prevent GOT entries from being emitted, because we
could not rely on the toolchain to do this for us.

Today, we use the hidden visibility pragma for all EFI stub source
files, which now all live in the same subdirectory, and we apply a
sanity check on the objects, so we can get rid of these getter
functions and simply refer to global data objects directly.

So switch over the remaining boolean variables carrying options set
on the kernel command line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c     |  2 +-
 .../firmware/efi/libstub/efi-stub-helper.c    | 31 ++++---------------
 drivers/firmware/efi/libstub/efi-stub.c       |  6 ++--
 drivers/firmware/efi/libstub/efistub.h        | 12 +++----
 drivers/firmware/efi/libstub/fdt.c            |  2 +-
 drivers/firmware/efi/libstub/file.c           |  2 +-
 drivers/firmware/efi/libstub/x86-stub.c       |  4 +--
 7 files changed, 20 insertions(+), 39 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 99b67e88a33b..ba4db35015a3 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -55,7 +55,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	u32 phys_seed = 0;
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
-		if (!nokaslr()) {
+		if (!efi_nokaslr) {
 			status = efi_get_random_bytes(sizeof(phys_seed),
 						      (u8 *)&phys_seed);
 			if (status == EFI_NOT_FOUND) {
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 0b1688b10ddc..1c92ac231f94 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -12,34 +12,15 @@
 
 #include "efistub.h"
 
-static bool efi_nochunk;
-static bool efi_nokaslr;
-static bool efi_noinitrd;
-static bool efi_quiet;
-static bool efi_novamap;
+bool efi_nochunk;
+bool efi_nokaslr;
+bool efi_noinitrd;
+bool efi_quiet;
+bool efi_novamap;
+
 static bool efi_nosoftreserve;
 static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
 
-bool __pure nochunk(void)
-{
-	return efi_nochunk;
-}
-bool __pure nokaslr(void)
-{
-	return efi_nokaslr;
-}
-bool __pure noinitrd(void)
-{
-	return efi_noinitrd;
-}
-bool __pure is_quiet(void)
-{
-	return efi_quiet;
-}
-bool __pure novamap(void)
-{
-	return efi_novamap;
-}
 bool __pure __efi_soft_reserve_enabled(void)
 {
 	return !efi_nosoftreserve;
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 8edfd4022803..ee225b323687 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -263,7 +263,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 	if (!fdt_addr)
 		pr_efi("Generating empty DTB\n");
 
-	if (!noinitrd()) {
+	if (!efi_noinitrd) {
 		max_addr = efi_get_max_initrd_addr(dram_base, image_addr);
 		status = efi_load_initrd_dev_path(&initrd_addr, &initrd_size,
 						  max_addr);
@@ -294,7 +294,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 			   EFI_PROPERTIES_RUNTIME_MEMORY_PROTECTION_NON_EXECUTABLE_PE_DATA);
 
 	/* hibernation expects the runtime regions to stay in the same place */
-	if (!IS_ENABLED(CONFIG_HIBERNATION) && !nokaslr() && !flat_va_mapping) {
+	if (!IS_ENABLED(CONFIG_HIBERNATION) && !efi_nokaslr && !flat_va_mapping) {
 		/*
 		 * Randomize the base of the UEFI runtime services region.
 		 * Preserve the 2 MB alignment of the region by taking a
@@ -367,7 +367,7 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 		size = in->num_pages * EFI_PAGE_SIZE;
 
 		in->virt_addr = in->phys_addr;
-		if (novamap()) {
+		if (efi_novamap) {
 			continue;
 		}
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index c1481c5abea4..5ff63230a1f1 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -25,11 +25,11 @@
 #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
 #endif
 
-extern bool __pure nochunk(void);
-extern bool __pure nokaslr(void);
-extern bool __pure noinitrd(void);
-extern bool __pure is_quiet(void);
-extern bool __pure novamap(void);
+extern bool efi_nochunk;
+extern bool efi_nokaslr;
+extern bool efi_noinitrd;
+extern bool efi_quiet;
+extern bool efi_novamap;
 
 extern const efi_system_table_t *efi_system_table;
 
@@ -50,7 +50,7 @@ extern const efi_system_table_t *efi_system_table;
 #endif
 
 #define pr_efi(msg)		do {			\
-	if (!is_quiet()) efi_printk("EFI stub: "msg);	\
+	if (!efi_quiet) efi_printk("EFI stub: "msg);	\
 } while (0)
 
 #define pr_efi_err(msg) efi_printk("EFI stub: ERROR: "msg)
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 06d5e7fc8e34..3074a5e27c65 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -310,7 +310,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	if (status == EFI_SUCCESS) {
 		efi_set_virtual_address_map_t *svam;
 
-		if (novamap())
+		if (efi_novamap)
 			return EFI_SUCCESS;
 
 		/* Install the new virtual address map */
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 27e014ea4459..50aaf15f9ad5 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -142,7 +142,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 	if (!load_addr || !load_size)
 		return EFI_INVALID_PARAMETER;
 
-	if (IS_ENABLED(CONFIG_X86) && !nochunk())
+	if (IS_ENABLED(CONFIG_X86) && !efi_nochunk)
 		efi_chunk_size = EFI_READ_CHUNK_SIZE;
 
 	alloc_addr = alloc_size = 0;
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 3f132f51ab0f..bddbc103a34b 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -427,7 +427,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		if (status != EFI_SUCCESS)
 			goto fail2;
 
-		if (!noinitrd()) {
+		if (!efi_noinitrd) {
 			status = efi_load_initrd(image, &ramdisk_addr,
 						 &ramdisk_size,
 						 hdr->initrd_addr_max,
@@ -787,7 +787,7 @@ unsigned long efi_main(efi_handle_t handle,
 	 * permit an initrd loaded from the LINUX_EFI_INITRD_MEDIA_GUID device
 	 * path to supersede it.
 	 */
-	if (!noinitrd()) {
+	if (!efi_noinitrd) {
 		unsigned long addr, size;
 
 		status = efi_load_initrd_dev_path(&addr, &size, ULONG_MAX);
-- 
2.17.1

