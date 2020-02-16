Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 223EE160565
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 19:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgBPSYQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 13:24:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbgBPSYP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 13:24:15 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D489222522;
        Sun, 16 Feb 2020 18:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581877455;
        bh=bXkrKOA7dq4Cyhmz9HL+jaciVLSolWJkvW8yB2cdyLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BgokPXkrtcbNCOpP+2MimdKMp87TlwWCEoujot1ubbfPj71ZwBZJ/SzMBS9rwto/V
         ko/rtmMv6f5rYo16FkPDSPr8KMbkgSofIxk9Zn4YdH8h+XTc4HNmEP9yyeJ+Kz+nYj
         D44Gn+L1/I2EIIxQ0nEz0z3Ln02UMKAMA4CQsABU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        x86@kernel.org
Subject: [PATCH 17/18] efi/arm: drop unnecessary references to efi.systab
Date:   Sun, 16 Feb 2020 19:23:33 +0100
Message-Id: <20200216182334.8121-18-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200216182334.8121-1-ardb@kernel.org>
References: <20200216182334.8121-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of populating efi.systab very early during efi_init() with
a mapping that is released again before the function exits, use a
local variable here. Now that we use efi.runtime to access the runtime
services table, this removes the only reference efi.systab, so there is
no need to populate it anymore, or discover its virtually remapped
address. So drop the references entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/arm-init.c    | 33 +++++++++-----------
 drivers/firmware/efi/arm-runtime.c | 18 -----------
 2 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 77048f7a9659..76bf5b22e49e 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -22,8 +22,6 @@
 
 #include <asm/efi.h>
 
-u64 efi_system_table;
-
 static int __init is_memory(efi_memory_desc_t *md)
 {
 	if (md->attribute & (EFI_MEMORY_WB|EFI_MEMORY_WT|EFI_MEMORY_WC))
@@ -36,7 +34,7 @@ static int __init is_memory(efi_memory_desc_t *md)
  * as some data members of the EFI system table are virtually remapped after
  * SetVirtualAddressMap() has been called.
  */
-static phys_addr_t efi_to_phys(unsigned long addr)
+static phys_addr_t __init efi_to_phys(unsigned long addr)
 {
 	efi_memory_desc_t *md;
 
@@ -83,15 +81,15 @@ static void __init init_screen_info(void)
 		memblock_mark_nomap(screen_info.lfb_base, screen_info.lfb_size);
 }
 
-static int __init uefi_init(void)
+static int __init uefi_init(u64 efi_system_table)
 {
 	efi_config_table_t *config_tables;
+	efi_system_table_t *systab;
 	size_t table_size;
 	int retval;
 
-	efi.systab = early_memremap_ro(efi_system_table,
-				       sizeof(efi_system_table_t));
-	if (efi.systab == NULL) {
+	systab = early_memremap_ro(efi_system_table, sizeof(efi_system_table_t));
+	if (systab == NULL) {
 		pr_warn("Unable to map EFI system table.\n");
 		return -ENOMEM;
 	}
@@ -100,30 +98,29 @@ static int __init uefi_init(void)
 	if (IS_ENABLED(CONFIG_64BIT))
 		set_bit(EFI_64BIT, &efi.flags);
 
-	retval = efi_systab_check_header(&efi.systab->hdr, 2);
+	retval = efi_systab_check_header(&systab->hdr, 2);
 	if (retval)
 		goto out;
 
-	efi.runtime = efi.systab->runtime;
-	efi.runtime_version = efi.systab->hdr.revision;
+	efi.runtime = systab->runtime;
+	efi.runtime_version = systab->hdr.revision;
 
-	efi_systab_report_header(&efi.systab->hdr,
-				 efi_to_phys(efi.systab->fw_vendor));
+	efi_systab_report_header(&systab->hdr, efi_to_phys(systab->fw_vendor));
 
-	table_size = sizeof(efi_config_table_64_t) * efi.systab->nr_tables;
-	config_tables = early_memremap_ro(efi_to_phys(efi.systab->tables),
+	table_size = sizeof(efi_config_table_t) * systab->nr_tables;
+	config_tables = early_memremap_ro(efi_to_phys(systab->tables),
 					  table_size);
 	if (config_tables == NULL) {
 		pr_warn("Unable to map EFI config table array.\n");
 		retval = -ENOMEM;
 		goto out;
 	}
-	retval = efi_config_parse_tables(config_tables, efi.systab->nr_tables,
+	retval = efi_config_parse_tables(config_tables, systab->nr_tables,
 					 arch_tables);
 
 	early_memunmap(config_tables, table_size);
 out:
-	early_memunmap(efi.systab,  sizeof(efi_system_table_t));
+	early_memunmap(systab, sizeof(efi_system_table_t));
 	return retval;
 }
 
@@ -214,8 +211,6 @@ void __init efi_init(void)
 	if (!efi_get_fdt_params(&params))
 		return;
 
-	efi_system_table = params.system_table;
-
 	data.desc_version = params.desc_ver;
 	data.desc_size = params.desc_size;
 	data.size = params.mmap_size;
@@ -234,7 +229,7 @@ void __init efi_init(void)
 	     "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
 	      efi.memmap.desc_version);
 
-	if (uefi_init() < 0) {
+	if (uefi_init(params.system_table) < 0) {
 		efi_memmap_unmap();
 		return;
 	}
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 9dda2602c862..b876373f2297 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -25,8 +25,6 @@
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 
-extern u64 efi_system_table;
-
 #if defined(CONFIG_PTDUMP_DEBUGFS) && defined(CONFIG_ARM64)
 #include <asm/ptdump.h>
 
@@ -54,13 +52,11 @@ device_initcall(ptdump_init);
 static bool __init efi_virtmap_init(void)
 {
 	efi_memory_desc_t *md;
-	bool systab_found;
 
 	efi_mm.pgd = pgd_alloc(&efi_mm);
 	mm_init_cpumask(&efi_mm);
 	init_new_context(NULL, &efi_mm);
 
-	systab_found = false;
 	for_each_efi_memory_desc(md) {
 		phys_addr_t phys = md->phys_addr;
 		int ret;
@@ -76,20 +72,6 @@ static bool __init efi_virtmap_init(void)
 				&phys, ret);
 			return false;
 		}
-		/*
-		 * If this entry covers the address of the UEFI system table,
-		 * calculate and record its virtual address.
-		 */
-		if (efi_system_table >= phys &&
-		    efi_system_table < phys + (md->num_pages * EFI_PAGE_SIZE)) {
-			efi.systab = (void *)(unsigned long)(efi_system_table -
-							     phys + md->virt_addr);
-			systab_found = true;
-		}
-	}
-	if (!systab_found) {
-		pr_err("No virtual mapping found for the UEFI System Table\n");
-		return false;
 	}
 
 	if (efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_permissions))
-- 
2.17.1

