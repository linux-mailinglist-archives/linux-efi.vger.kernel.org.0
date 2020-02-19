Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F4F16486C
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 16:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgBSPYu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 10:24:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgBSPYu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 10:24:50 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44E4E24654;
        Wed, 19 Feb 2020 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582125889;
        bh=PDvat8kqeig3BTT+VeV1np0/DyvF6xBQeL7xe9NzH90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VtSsGXifZA5RnZW/dPBhY07N+PB9khG0s6OLmhnznF/9pY/EO70fxGiclxOuG/8Xm
         nFjfpnZrM+5BWB0EULVD24qOOX6sgCcRWlG6ktv3fwoftsvZkG7TY8iM9377H4Y6AJ
         Nnp01MRNoJKenob3pOBPLL2i/161bFa/c6sLgSm4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, atish.patra@wdc.com,
        leif@nuviainc.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/3] efi/arm: move FDT specific definitions into fdtparams.c
Date:   Wed, 19 Feb 2020 16:24:39 +0100
Message-Id: <20200219152440.11561-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219152440.11561-1-ardb@kernel.org>
References: <20200219152440.11561-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Push the FDT params specific types and definition into fdtparams.c,
and instead, pass a reference to the memory map data structure and
populate it directly, and return the system table address as the
return value.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/arm-init.c  | 17 ++++-------
 drivers/firmware/efi/fdtparams.c | 30 +++++++++++++++-----
 include/linux/efi.h              | 10 +------
 3 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 76bf5b22e49e..2791a8048f30 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -205,17 +205,13 @@ static __init void reserve_regions(void)
 void __init efi_init(void)
 {
 	struct efi_memory_map_data data;
-	struct efi_fdt_params params;
+	u64 efi_system_table;
 
 	/* Grab UEFI information placed in FDT by stub */
-	if (!efi_get_fdt_params(&params))
+	efi_system_table = efi_get_fdt_params(&data);
+	if (!efi_system_table)
 		return;
 
-	data.desc_version = params.desc_ver;
-	data.desc_size = params.desc_size;
-	data.size = params.mmap_size;
-	data.phys_map = params.mmap;
-
 	if (efi_memmap_init_early(&data) < 0) {
 		/*
 		* If we are booting via UEFI, the UEFI memory map is the only
@@ -229,7 +225,7 @@ void __init efi_init(void)
 	     "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
 	      efi.memmap.desc_version);
 
-	if (uefi_init(params.system_table) < 0) {
+	if (uefi_init(efi_system_table) < 0) {
 		efi_memmap_unmap();
 		return;
 	}
@@ -237,9 +233,8 @@ void __init efi_init(void)
 	reserve_regions();
 	efi_esrt_init();
 
-	memblock_reserve(params.mmap & PAGE_MASK,
-			 PAGE_ALIGN(params.mmap_size +
-				    (params.mmap & ~PAGE_MASK)));
+	memblock_reserve(data.phys_map & PAGE_MASK,
+			 PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
 
 	init_screen_info();
 
diff --git a/drivers/firmware/efi/fdtparams.c b/drivers/firmware/efi/fdtparams.c
index 3de343faffc6..7a384b307c56 100644
--- a/drivers/firmware/efi/fdtparams.c
+++ b/drivers/firmware/efi/fdtparams.c
@@ -18,6 +18,14 @@
 		sizeof_field(struct efi_fdt_params, field) \
 	}
 
+struct efi_fdt_params {
+	u64 system_table;
+	u64 mmap;
+	u32 mmap_size;
+	u32 desc_size;
+	u32 desc_ver;
+};
+
 struct params {
 	const char name[32];
 	const char propname[32];
@@ -121,22 +129,30 @@ static int __init fdt_find_uefi_params(unsigned long node, const char *uname,
 	return 0;
 }
 
-int __init efi_get_fdt_params(struct efi_fdt_params *params)
+u64 __init efi_get_fdt_params(struct efi_memory_map_data *memmap)
 {
+	struct efi_fdt_params params;
 	struct param_info info;
 	int ret;
 
 	pr_info("Getting EFI parameters from FDT:\n");
 
 	info.found = 0;
-	info.params = params;
+	info.params = &params;
 
 	ret = of_scan_flat_dt(fdt_find_uefi_params, &info);
-	if (!info.found)
+	if (!info.found) {
 		pr_info("UEFI not found.\n");
-	else if (!ret)
-		pr_err("Can't find '%s' in device tree!\n",
-		       info.missing);
+		return 0;
+	} else if (!ret) {
+		pr_err("Can't find '%s' in device tree!\n", info.missing);
+		return 0;
+	}
+
+	memmap->desc_version	= params.desc_ver;
+	memmap->desc_size	= params.desc_size;
+	memmap->size		= params.mmap_size;
+	memmap->phys_map	= params.mmap;
 
-	return ret;
+	return params.system_table;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a36bbd20e3ac..2ab33d5d6ca5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -478,14 +478,6 @@ struct efi_mem_range {
 	u64 attribute;
 };
 
-struct efi_fdt_params {
-	u64 system_table;
-	u64 mmap;
-	u32 mmap_size;
-	u32 desc_size;
-	u32 desc_ver;
-};
-
 typedef struct {
 	u32 version;
 	u32 length;
@@ -661,7 +653,7 @@ extern void efi_mem_reserve(phys_addr_t addr, u64 size);
 extern int efi_mem_reserve_persistent(phys_addr_t addr, u64 size);
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 		struct resource *data_resource, struct resource *bss_resource);
-extern int efi_get_fdt_params(struct efi_fdt_params *params);
+extern u64 efi_get_fdt_params(struct efi_memory_map_data *data);
 extern struct kobject *efi_kobj;
 
 extern int efi_reboot_quirk_mode;
-- 
2.17.1

