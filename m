Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A522716486B
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 16:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgBSPYt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 10:24:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgBSPYt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 10:24:49 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24D6D24670;
        Wed, 19 Feb 2020 15:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582125887;
        bh=p6quxa+3E1BfuMVMn0x0SwwnZ3l7CEP0hQbWAuv0qCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1jVDtel0N9HhxINANEq48Icp6Exc9PIYAypzVzF6G//GZTvaBBZVRZwl2DWtNYCF0
         aAqhznkAtkxMAmooWgMec5bpAlLzRrnXFHPicbgRRigANfthD3bXTFTKUrXaYPG3M2
         17sT8GJul4EXa08RmFfx3JNdMjfHf/D2wRXLbWjY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, atish.patra@wdc.com,
        leif@nuviainc.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/3] efi/arm: move FDT param discovery code out of efi.c
Date:   Wed, 19 Feb 2020 16:24:38 +0100
Message-Id: <20200219152440.11561-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219152440.11561-1-ardb@kernel.org>
References: <20200219152440.11561-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On ARM systems, we discover the UEFI system table address and memory
map address from the /chosen node in the device tree, or in the Xen
case, from a similar node under /hypervisor.

Before making some functional changes to that code, move it into its
own file that only gets built if CONFIG_EFI_PARAMS_FROM_FDT=y.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Makefile    |   1 +
 drivers/firmware/efi/efi.c       | 135 -------------------
 drivers/firmware/efi/fdtparams.c | 142 ++++++++++++++++++++
 3 files changed, 143 insertions(+), 135 deletions(-)

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 554d795270d9..3c5a9690de04 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -13,6 +13,7 @@ KASAN_SANITIZE_runtime-wrappers.o	:= n
 obj-$(CONFIG_ACPI_BGRT) 		+= efi-bgrt.o
 obj-$(CONFIG_EFI)			+= efi.o vars.o reboot.o memattr.o tpm.o
 obj-$(CONFIG_EFI)			+= capsule.o memmap.o
+obj-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= fdtparams.o
 obj-$(CONFIG_EFI_VARS)			+= efivars.o
 obj-$(CONFIG_EFI_ESRT)			+= esrt.o
 obj-$(CONFIG_EFI_VARS_PSTORE)		+= efi-pstore.o
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 55570ed751e8..69a585106d30 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -20,7 +20,6 @@
 #include <linux/device.h>
 #include <linux/efi.h>
 #include <linux/of.h>
-#include <linux/of_fdt.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
 #include <linux/platform_device.h>
@@ -656,140 +655,6 @@ void __init efi_systab_report_header(const efi_table_hdr_t *systab_hdr,
 		vendor);
 }
 
-#ifdef CONFIG_EFI_PARAMS_FROM_FDT
-
-#define UEFI_PARAM(name, prop, field)			   \
-	{						   \
-		{ name },				   \
-		{ prop },				   \
-		offsetof(struct efi_fdt_params, field),    \
-		sizeof_field(struct efi_fdt_params, field) \
-	}
-
-struct params {
-	const char name[32];
-	const char propname[32];
-	int offset;
-	int size;
-};
-
-static __initdata struct params fdt_params[] = {
-	UEFI_PARAM("System Table", "linux,uefi-system-table", system_table),
-	UEFI_PARAM("MemMap Address", "linux,uefi-mmap-start", mmap),
-	UEFI_PARAM("MemMap Size", "linux,uefi-mmap-size", mmap_size),
-	UEFI_PARAM("MemMap Desc. Size", "linux,uefi-mmap-desc-size", desc_size),
-	UEFI_PARAM("MemMap Desc. Version", "linux,uefi-mmap-desc-ver", desc_ver)
-};
-
-static __initdata struct params xen_fdt_params[] = {
-	UEFI_PARAM("System Table", "xen,uefi-system-table", system_table),
-	UEFI_PARAM("MemMap Address", "xen,uefi-mmap-start", mmap),
-	UEFI_PARAM("MemMap Size", "xen,uefi-mmap-size", mmap_size),
-	UEFI_PARAM("MemMap Desc. Size", "xen,uefi-mmap-desc-size", desc_size),
-	UEFI_PARAM("MemMap Desc. Version", "xen,uefi-mmap-desc-ver", desc_ver)
-};
-
-#define EFI_FDT_PARAMS_SIZE	ARRAY_SIZE(fdt_params)
-
-static __initdata struct {
-	const char *uname;
-	const char *subnode;
-	struct params *params;
-} dt_params[] = {
-	{ "hypervisor", "uefi", xen_fdt_params },
-	{ "chosen", NULL, fdt_params },
-};
-
-struct param_info {
-	int found;
-	void *params;
-	const char *missing;
-};
-
-static int __init __find_uefi_params(unsigned long node,
-				     struct param_info *info,
-				     struct params *params)
-{
-	const void *prop;
-	void *dest;
-	u64 val;
-	int i, len;
-
-	for (i = 0; i < EFI_FDT_PARAMS_SIZE; i++) {
-		prop = of_get_flat_dt_prop(node, params[i].propname, &len);
-		if (!prop) {
-			info->missing = params[i].name;
-			return 0;
-		}
-
-		dest = info->params + params[i].offset;
-		info->found++;
-
-		val = of_read_number(prop, len / sizeof(u32));
-
-		if (params[i].size == sizeof(u32))
-			*(u32 *)dest = val;
-		else
-			*(u64 *)dest = val;
-
-		if (efi_enabled(EFI_DBG))
-			pr_info("  %s: 0x%0*llx\n", params[i].name,
-				params[i].size * 2, val);
-	}
-
-	return 1;
-}
-
-static int __init fdt_find_uefi_params(unsigned long node, const char *uname,
-				       int depth, void *data)
-{
-	struct param_info *info = data;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(dt_params); i++) {
-		const char *subnode = dt_params[i].subnode;
-
-		if (depth != 1 || strcmp(uname, dt_params[i].uname) != 0) {
-			info->missing = dt_params[i].params[0].name;
-			continue;
-		}
-
-		if (subnode) {
-			int err = of_get_flat_dt_subnode_by_name(node, subnode);
-
-			if (err < 0)
-				return 0;
-
-			node = err;
-		}
-
-		return __find_uefi_params(node, info, dt_params[i].params);
-	}
-
-	return 0;
-}
-
-int __init efi_get_fdt_params(struct efi_fdt_params *params)
-{
-	struct param_info info;
-	int ret;
-
-	pr_info("Getting EFI parameters from FDT:\n");
-
-	info.found = 0;
-	info.params = params;
-
-	ret = of_scan_flat_dt(fdt_find_uefi_params, &info);
-	if (!info.found)
-		pr_info("UEFI not found.\n");
-	else if (!ret)
-		pr_err("Can't find '%s' in device tree!\n",
-		       info.missing);
-
-	return ret;
-}
-#endif /* CONFIG_EFI_PARAMS_FROM_FDT */
-
 static __initdata char memory_type_name[][20] = {
 	"Reserved",
 	"Loader Code",
diff --git a/drivers/firmware/efi/fdtparams.c b/drivers/firmware/efi/fdtparams.c
new file mode 100644
index 000000000000..3de343faffc6
--- /dev/null
+++ b/drivers/firmware/efi/fdtparams.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) "efi: " fmt
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/efi.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+
+#include <asm/early_ioremap.h>
+
+#define UEFI_PARAM(name, prop, field)			   \
+	{						   \
+		{ name },				   \
+		{ prop },				   \
+		offsetof(struct efi_fdt_params, field),    \
+		sizeof_field(struct efi_fdt_params, field) \
+	}
+
+struct params {
+	const char name[32];
+	const char propname[32];
+	int offset;
+	int size;
+};
+
+static __initdata struct params fdt_params[] = {
+	UEFI_PARAM("System Table", "linux,uefi-system-table", system_table),
+	UEFI_PARAM("MemMap Address", "linux,uefi-mmap-start", mmap),
+	UEFI_PARAM("MemMap Size", "linux,uefi-mmap-size", mmap_size),
+	UEFI_PARAM("MemMap Desc. Size", "linux,uefi-mmap-desc-size", desc_size),
+	UEFI_PARAM("MemMap Desc. Version", "linux,uefi-mmap-desc-ver", desc_ver)
+};
+
+static __initdata struct params xen_fdt_params[] = {
+	UEFI_PARAM("System Table", "xen,uefi-system-table", system_table),
+	UEFI_PARAM("MemMap Address", "xen,uefi-mmap-start", mmap),
+	UEFI_PARAM("MemMap Size", "xen,uefi-mmap-size", mmap_size),
+	UEFI_PARAM("MemMap Desc. Size", "xen,uefi-mmap-desc-size", desc_size),
+	UEFI_PARAM("MemMap Desc. Version", "xen,uefi-mmap-desc-ver", desc_ver)
+};
+
+#define EFI_FDT_PARAMS_SIZE	ARRAY_SIZE(fdt_params)
+
+static __initdata struct {
+	const char *uname;
+	const char *subnode;
+	struct params *params;
+} dt_params[] = {
+	{ "hypervisor", "uefi", xen_fdt_params },
+	{ "chosen", NULL, fdt_params },
+};
+
+struct param_info {
+	int found;
+	void *params;
+	const char *missing;
+};
+
+static int __init __find_uefi_params(unsigned long node,
+				     struct param_info *info,
+				     struct params *params)
+{
+	const void *prop;
+	void *dest;
+	u64 val;
+	int i, len;
+
+	for (i = 0; i < EFI_FDT_PARAMS_SIZE; i++) {
+		prop = of_get_flat_dt_prop(node, params[i].propname, &len);
+		if (!prop) {
+			info->missing = params[i].name;
+			return 0;
+		}
+
+		dest = info->params + params[i].offset;
+		info->found++;
+
+		val = of_read_number(prop, len / sizeof(u32));
+
+		if (params[i].size == sizeof(u32))
+			*(u32 *)dest = val;
+		else
+			*(u64 *)dest = val;
+
+		if (efi_enabled(EFI_DBG))
+			pr_info("  %s: 0x%0*llx\n", params[i].name,
+				params[i].size * 2, val);
+	}
+
+	return 1;
+}
+
+static int __init fdt_find_uefi_params(unsigned long node, const char *uname,
+				       int depth, void *data)
+{
+	struct param_info *info = data;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dt_params); i++) {
+		const char *subnode = dt_params[i].subnode;
+
+		if (depth != 1 || strcmp(uname, dt_params[i].uname) != 0) {
+			info->missing = dt_params[i].params[0].name;
+			continue;
+		}
+
+		if (subnode) {
+			int err = of_get_flat_dt_subnode_by_name(node, subnode);
+
+			if (err < 0)
+				return 0;
+
+			node = err;
+		}
+
+		return __find_uefi_params(node, info, dt_params[i].params);
+	}
+
+	return 0;
+}
+
+int __init efi_get_fdt_params(struct efi_fdt_params *params)
+{
+	struct param_info info;
+	int ret;
+
+	pr_info("Getting EFI parameters from FDT:\n");
+
+	info.found = 0;
+	info.params = params;
+
+	ret = of_scan_flat_dt(fdt_find_uefi_params, &info);
+	if (!info.found)
+		pr_info("UEFI not found.\n");
+	else if (!ret)
+		pr_err("Can't find '%s' in device tree!\n",
+		       info.missing);
+
+	return ret;
+}
-- 
2.17.1

