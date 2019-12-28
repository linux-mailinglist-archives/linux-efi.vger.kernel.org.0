Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4AE112BDEB
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2019 16:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfL1PWH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Dec 2019 10:22:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfL1PWH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 28 Dec 2019 10:22:07 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B993C2173E;
        Sat, 28 Dec 2019 15:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577546526;
        bh=cT0MFrU3EhHetTKHDkrl0VeDLOY426VM+msV8Fe9/88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VR+hOtg+jRyW/b5qubv7pQCkCSRZZf67dSkQq7agnVgEpU16bgKjMOEXLglEBbjnY
         PLZwGSMCleMh9vhuXj2A7NzGmAawveMr09mv2sQrPmlkt+zY+d7hUEoaN6xA25g6sr
         af71o9Dq3P+kQCdYkaSUzfraNXb77BBeeWT96hrw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 7/7] efi/x86: clean up efi_systab_init() routine for legibility
Date:   Sat, 28 Dec 2019 16:21:09 +0100
Message-Id: <20191228152109.6301-8-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191228152109.6301-1-ardb@kernel.org>
References: <20191228152109.6301-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Clean up the efi_systab_init() routine which maps the EFI system
table and copies the relevant pieces of data out of it.

The current routine is very difficult to read, so let's clean that
up. Also, switch to a R/O mapping of the system table since that is
all we need.

Finally, use a plain u64 variable to record the physical address of
the system table instead of pointlessly stashing it in a struct efi
that is never used for anything else.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c | 166 ++++++++++----------
 1 file changed, 82 insertions(+), 84 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index aa6d9438fa89..b905f867b811 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -54,7 +54,7 @@
 #include <asm/x86_init.h>
 #include <asm/uv/uv.h>
 
-static struct efi efi_phys __initdata;
+static u64 efi_systab_phys __initdata;
 static efi_system_table_t efi_systab __initdata;
 static efi_set_virtual_address_map_t __efiapi *set_virtual_address_map __initdata;
 
@@ -354,89 +354,90 @@ void __init efi_print_memmap(void)
 	}
 }
 
-static int __init efi_systab_init(void *phys)
+static int __init efi_systab_init(u64 phys)
 {
+	int size = efi_enabled(EFI_64BIT) ? sizeof(efi_system_table_64_t)
+					  : sizeof(efi_system_table_32_t);
+	bool over4g = false;
+	void *p;
+
+	p = early_memremap_ro(phys, size);
+	if (p == NULL) {
+		pr_err("Couldn't map the system table!\n");
+		return -ENOMEM;
+	}
+
 	if (efi_enabled(EFI_64BIT)) {
-		efi_system_table_64_t *systab64;
-		struct efi_setup_data *data = NULL;
-		u64 tmp = 0;
+		const efi_system_table_64_t *systab64 = p;
+
+		efi_systab.hdr			= systab64->hdr;
+		efi_systab.fw_vendor		= systab64->fw_vendor;
+		efi_systab.fw_revision		= systab64->fw_revision;
+		efi_systab.con_in_handle	= systab64->con_in_handle;
+		efi_systab.con_in		= systab64->con_in;
+		efi_systab.con_out_handle	= systab64->con_out_handle;
+		efi_systab.con_out		= (void *)(unsigned long)systab64->con_out;
+		efi_systab.stderr_handle	= systab64->stderr_handle;
+		efi_systab.stderr		= systab64->stderr;
+		efi_systab.runtime		= (void *)(unsigned long)systab64->runtime;
+		efi_systab.boottime		= (void *)(unsigned long)systab64->boottime;
+		efi_systab.nr_tables		= systab64->nr_tables;
+		efi_systab.tables		= systab64->tables;
+
+		over4g = systab64->con_in_handle	> U32_MAX ||
+			 systab64->con_in		> U32_MAX ||
+			 systab64->con_out_handle	> U32_MAX ||
+			 systab64->con_out		> U32_MAX ||
+			 systab64->stderr_handle	> U32_MAX ||
+			 systab64->stderr		> U32_MAX ||
+			 systab64->boottime		> U32_MAX;
 
 		if (efi_setup) {
-			data = early_memremap(efi_setup, sizeof(*data));
-			if (!data)
+			struct efi_setup_data *data;
+
+			data = early_memremap_ro(efi_setup, sizeof(*data));
+			if (!data) {
+				early_memunmap(p, size);
 				return -ENOMEM;
-		}
-		systab64 = early_memremap((unsigned long)phys,
-					 sizeof(*systab64));
-		if (systab64 == NULL) {
-			pr_err("Couldn't map the system table!\n");
-			if (data)
-				early_memunmap(data, sizeof(*data));
-			return -ENOMEM;
-		}
+			}
+
+			efi_systab.fw_vendor	= (unsigned long)data->fw_vendor;
+			efi_systab.runtime	= (void *)(unsigned long)data->runtime;
+			efi_systab.tables	= (unsigned long)data->tables;
+
+			over4g |= data->fw_vendor	> U32_MAX ||
+				  data->runtime		> U32_MAX ||
+				  data->tables		> U32_MAX;
 
-		efi_systab.hdr = systab64->hdr;
-		efi_systab.fw_vendor = data ? (unsigned long)data->fw_vendor :
-					      systab64->fw_vendor;
-		tmp |= data ? data->fw_vendor : systab64->fw_vendor;
-		efi_systab.fw_revision = systab64->fw_revision;
-		efi_systab.con_in_handle = systab64->con_in_handle;
-		tmp |= systab64->con_in_handle;
-		efi_systab.con_in = systab64->con_in;
-		tmp |= systab64->con_in;
-		efi_systab.con_out_handle = systab64->con_out_handle;
-		tmp |= systab64->con_out_handle;
-		efi_systab.con_out = (void *)(unsigned long)systab64->con_out;
-		tmp |= systab64->con_out;
-		efi_systab.stderr_handle = systab64->stderr_handle;
-		tmp |= systab64->stderr_handle;
-		efi_systab.stderr = systab64->stderr;
-		tmp |= systab64->stderr;
-		efi_systab.runtime = data ?
-				     (void *)(unsigned long)data->runtime :
-				     (void *)(unsigned long)systab64->runtime;
-		tmp |= data ? data->runtime : systab64->runtime;
-		efi_systab.boottime = (void *)(unsigned long)systab64->boottime;
-		tmp |= systab64->boottime;
-		efi_systab.nr_tables = systab64->nr_tables;
-		efi_systab.tables = data ? (unsigned long)data->tables :
-					   systab64->tables;
-		tmp |= data ? data->tables : systab64->tables;
-
-		early_memunmap(systab64, sizeof(*systab64));
-		if (data)
 			early_memunmap(data, sizeof(*data));
-#ifdef CONFIG_X86_32
-		if (tmp >> 32) {
-			pr_err("EFI data located above 4GB, disabling EFI.\n");
-			return -EINVAL;
+		} else {
+			over4g |= systab64->fw_vendor	> U32_MAX ||
+				  systab64->runtime	> U32_MAX ||
+				  systab64->tables	> U32_MAX;
 		}
-#endif
 	} else {
-		efi_system_table_32_t *systab32;
+		const efi_system_table_32_t *systab32 = p;
+
+		efi_systab.hdr			= systab32->hdr;
+		efi_systab.fw_vendor		= systab32->fw_vendor;
+		efi_systab.fw_revision		= systab32->fw_revision;
+		efi_systab.con_in_handle	= systab32->con_in_handle;
+		efi_systab.con_in		= systab32->con_in;
+		efi_systab.con_out_handle	= systab32->con_out_handle;
+		efi_systab.con_out		= (void *)(unsigned long)systab32->con_out;
+		efi_systab.stderr_handle	= systab32->stderr_handle;
+		efi_systab.stderr		= systab32->stderr;
+		efi_systab.runtime		= (void *)(unsigned long)systab32->runtime;
+		efi_systab.boottime		= (void *)(unsigned long)systab32->boottime;
+		efi_systab.nr_tables		= systab32->nr_tables;
+		efi_systab.tables		= systab32->tables;
+	}
 
-		systab32 = early_memremap((unsigned long)phys,
-					 sizeof(*systab32));
-		if (systab32 == NULL) {
-			pr_err("Couldn't map the system table!\n");
-			return -ENOMEM;
-		}
+	early_memunmap(p, size);
 
-		efi_systab.hdr = systab32->hdr;
-		efi_systab.fw_vendor = systab32->fw_vendor;
-		efi_systab.fw_revision = systab32->fw_revision;
-		efi_systab.con_in_handle = systab32->con_in_handle;
-		efi_systab.con_in = systab32->con_in;
-		efi_systab.con_out_handle = systab32->con_out_handle;
-		efi_systab.con_out = (void *)(unsigned long)systab32->con_out;
-		efi_systab.stderr_handle = systab32->stderr_handle;
-		efi_systab.stderr = systab32->stderr;
-		efi_systab.runtime = (void *)(unsigned long)systab32->runtime;
-		efi_systab.boottime = (void *)(unsigned long)systab32->boottime;
-		efi_systab.nr_tables = systab32->nr_tables;
-		efi_systab.tables = systab32->tables;
-
-		early_memunmap(systab32, sizeof(*systab32));
+	if (IS_ENABLED(CONFIG_X86_32) && over4g) {
+		pr_err("EFI data located above 4GB, disabling EFI.\n");
+		return -EINVAL;
 	}
 
 	efi.systab = &efi_systab;
@@ -507,20 +508,17 @@ void __init efi_init(void)
 	char vendor[100] = "unknown";
 	int i = 0;
 
-#ifdef CONFIG_X86_32
-	if (boot_params.efi_info.efi_systab_hi ||
-	    boot_params.efi_info.efi_memmap_hi) {
+	if (IS_ENABLED(CONFIG_X86_32) &&
+	    (boot_params.efi_info.efi_systab_hi ||
+	     boot_params.efi_info.efi_memmap_hi)) {
 		pr_info("Table located above 4GB, disabling EFI.\n");
 		return;
 	}
-	efi_phys.systab = (efi_system_table_t *)boot_params.efi_info.efi_systab;
-#else
-	efi_phys.systab = (efi_system_table_t *)
-			  (boot_params.efi_info.efi_systab |
-			  ((__u64)boot_params.efi_info.efi_systab_hi<<32));
-#endif
 
-	if (efi_systab_init(efi_phys.systab))
+	efi_systab_phys = boot_params.efi_info.efi_systab |
+			  ((__u64)boot_params.efi_info.efi_systab_hi << 32);
+
+	if (efi_systab_init(efi_systab_phys))
 		return;
 
 	efi.config_table = (unsigned long)efi.systab->tables;
@@ -673,7 +671,7 @@ static void __init get_systab_virt_addr(efi_memory_desc_t *md)
 
 	size = md->num_pages << EFI_PAGE_SHIFT;
 	end = md->phys_addr + size;
-	systab = (u64)(unsigned long)efi_phys.systab;
+	systab = efi_systab_phys;
 	if (md->phys_addr <= systab && systab < end) {
 		systab += md->virt_addr - md->phys_addr;
 		efi.systab = (efi_system_table_t *)(unsigned long)systab;
-- 
2.17.1

