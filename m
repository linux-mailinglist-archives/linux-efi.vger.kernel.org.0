Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD8A16486D
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 16:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgBSPYx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 10:24:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgBSPYx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 10:24:53 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43EC224671;
        Wed, 19 Feb 2020 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582125891;
        bh=2Yifru4+OPwrLC2fBvFPYWlusQrWYJhTcoUViaqei20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmvh1uFHrKb/9y86IWBe2/WFT5fhsXXm1bR0kRnF7Wjcd2LxxzQHUTfJlA4Q4dbPg
         kXg8vS8qGAyC+AY1UDBbz646bLwsc7kxVxhg0/6LxA653TJhQtLz6iLxIYnKklNSbL
         UViUXPRmvpVg8MAv38IcDRaJYhbjCWwqaL9kANBo=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, atish.patra@wdc.com,
        leif@nuviainc.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 3/3] efi/arm: rewrite FDT param discovery routines
Date:   Wed, 19 Feb 2020 16:24:40 +0100
Message-Id: <20200219152440.11561-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219152440.11561-1-ardb@kernel.org>
References: <20200219152440.11561-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The efi_get_fdt_params() routine uses the early OF device tree
traversal helpers, that iterate over each node in the DT and invoke
a caller provided callback that can inspect the node's contents and
look for the required data. This requires a special param struct to
be passed around, with pointers into param enumeration structs that
contain (and duplicate) property names and offsets into yet another
struct that carries the collected data.

Since we know the data we look for is either under /hypervisor/uefi
or under /chosen, it is much simpler to use the libfdt routines
directly, and try to grab a reference to either node directly, and
read each property in sequence.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/fdtparams.c | 203 ++++++++------------
 1 file changed, 85 insertions(+), 118 deletions(-)

diff --git a/drivers/firmware/efi/fdtparams.c b/drivers/firmware/efi/fdtparams.c
index 7a384b307c56..23af4062e913 100644
--- a/drivers/firmware/efi/fdtparams.c
+++ b/drivers/firmware/efi/fdtparams.c
@@ -5,154 +5,121 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/efi.h>
-#include <linux/of.h>
+#include <linux/libfdt.h>
 #include <linux/of_fdt.h>
 
-#include <asm/early_ioremap.h>
+#include <asm/unaligned.h>
 
-#define UEFI_PARAM(name, prop, field)			   \
-	{						   \
-		{ name },				   \
-		{ prop },				   \
-		offsetof(struct efi_fdt_params, field),    \
-		sizeof_field(struct efi_fdt_params, field) \
-	}
-
-struct efi_fdt_params {
-	u64 system_table;
-	u64 mmap;
-	u32 mmap_size;
-	u32 desc_size;
-	u32 desc_ver;
-};
-
-struct params {
-	const char name[32];
-	const char propname[32];
-	int offset;
-	int size;
+enum {
+	SYSTAB,
+	MMBASE,
+	MMSIZE,
+	DCSIZE,
+	DCVERS,
 };
 
-static __initdata struct params fdt_params[] = {
-	UEFI_PARAM("System Table", "linux,uefi-system-table", system_table),
-	UEFI_PARAM("MemMap Address", "linux,uefi-mmap-start", mmap),
-	UEFI_PARAM("MemMap Size", "linux,uefi-mmap-size", mmap_size),
-	UEFI_PARAM("MemMap Desc. Size", "linux,uefi-mmap-desc-size", desc_size),
-	UEFI_PARAM("MemMap Desc. Version", "linux,uefi-mmap-desc-ver", desc_ver)
+static __initconst const char name[][22] = {
+	[SYSTAB] = "System Table         ",
+	[MMBASE] = "MemMap Address       ",
+	[MMSIZE] = "MemMap Size          ",
+	[DCSIZE] = "MemMap Desc. Size    ",
+	[DCVERS] = "MemMap Desc. Version ",
 };
 
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
+static __initconst const struct {
+	const char	path[17];
+	const char	params[5][26];
 } dt_params[] = {
-	{ "hypervisor", "uefi", xen_fdt_params },
-	{ "chosen", NULL, fdt_params },
-};
-
-struct param_info {
-	int found;
-	void *params;
-	const char *missing;
+#ifdef CONFIG_XEN
+	{
+		"/hypervisor/uefi",
+		{
+			[SYSTAB] = "xen,uefi-system-table",
+			[MMBASE] = "xen,uefi-mmap-start",
+			[MMSIZE] = "xen,uefi-mmap-size",
+			[DCSIZE] = "xen,uefi-mmap-desc-size",
+			[DCVERS] = "xen,uefi-mmap-desc-ver",
+		}
+	},
+#endif
+	{
+		"/chosen",
+		{
+			[SYSTAB] = "linux,uefi-system-table",
+			[MMBASE] = "linux,uefi-mmap-start",
+			[MMSIZE] = "linux,uefi-mmap-size",
+			[DCSIZE] = "linux,uefi-mmap-desc-size",
+			[DCVERS] = "linux,uefi-mmap-desc-ver",
+		}
+	}
 };
 
-static int __init __find_uefi_params(unsigned long node,
-				     struct param_info *info,
-				     struct params *params)
+static int __init efi_get_fdt_prop(const void *fdt, int node, int dtp, int pp,
+				   void *var, int size)
 {
 	const void *prop;
-	void *dest;
+	int len;
 	u64 val;
-	int i, len;
 
-	for (i = 0; i < EFI_FDT_PARAMS_SIZE; i++) {
-		prop = of_get_flat_dt_prop(node, params[i].propname, &len);
-		if (!prop) {
-			info->missing = params[i].name;
-			return 0;
-		}
-
-		dest = info->params + params[i].offset;
-		info->found++;
+	prop = fdt_getprop(fdt, node, dt_params[dtp].params[pp], &len);
+	if (!prop) {
+		pr_err("Can't find property '%s' in device tree!\n",
+		       dt_params[dtp].params[pp]);
+		return 1;
+	}
 
-		val = of_read_number(prop, len / sizeof(u32));
+	val = (len == 4) ? (u64)be32_to_cpup(prop) : get_unaligned_be64(prop);
 
-		if (params[i].size == sizeof(u32))
-			*(u32 *)dest = val;
-		else
-			*(u64 *)dest = val;
+	if (size == 8)
+		*(u64 *)var = val;
+	else
+		*(u32 *)var = (val <= U32_MAX) ? val : U32_MAX; // saturate
 
-		if (efi_enabled(EFI_DBG))
-			pr_info("  %s: 0x%0*llx\n", params[i].name,
-				params[i].size * 2, val);
-	}
+	if (efi_enabled(EFI_DBG))
+		pr_info("  %s: 0x%0*llx\n", name[pp], size * 2, val);
 
-	return 1;
+	return 0;
 }
 
-static int __init fdt_find_uefi_params(unsigned long node, const char *uname,
-				       int depth, void *data)
+u64 __init efi_get_fdt_params(struct efi_memory_map_data *mm)
 {
-	struct param_info *info = data;
+	const void *fdt = initial_boot_params;
+	unsigned long systab;
+	struct {
+		void	*var;
+		int	size;
+	} target[] = {
+		[SYSTAB] = { &systab,		sizeof(systab) },
+		[MMBASE] = { &mm->phys_map,	sizeof(mm->phys_map) },
+		[MMSIZE] = { &mm->size,		sizeof(mm->size) },
+		[DCSIZE] = { &mm->desc_size,	sizeof(mm->desc_size) },
+		[DCVERS] = { &mm->desc_version,	sizeof(mm->desc_version) },
+	};
 	int i;
 
+	BUILD_BUG_ON(ARRAY_SIZE(target) != ARRAY_SIZE(name));
+	BUILD_BUG_ON(ARRAY_SIZE(target) != ARRAY_SIZE(dt_params[0].params));
+
 	for (i = 0; i < ARRAY_SIZE(dt_params); i++) {
-		const char *subnode = dt_params[i].subnode;
+		int node;
+		int j;
 
-		if (depth != 1 || strcmp(uname, dt_params[i].uname) != 0) {
-			info->missing = dt_params[i].params[0].name;
+		node = fdt_path_offset(fdt, dt_params[i].path);
+		if (node < 0)
 			continue;
-		}
 
-		if (subnode) {
-			int err = of_get_flat_dt_subnode_by_name(node, subnode);
+		if (efi_enabled(EFI_DBG))
+			pr_info("Getting UEFI parameters from %s in DT:\n",
+				dt_params[i].path);
 
-			if (err < 0)
+		for (j = 0; j < ARRAY_SIZE(target); j++) {
+			if (efi_get_fdt_prop(fdt, node, i, j, target[j].var,
+					     target[j].size)) {
 				return 0;
-
-			node = err;
+			}
 		}
-
-		return __find_uefi_params(node, info, dt_params[i].params);
+		return systab;
 	}
-
+	pr_info("UEFI not found.\n");
 	return 0;
 }
-
-u64 __init efi_get_fdt_params(struct efi_memory_map_data *memmap)
-{
-	struct efi_fdt_params params;
-	struct param_info info;
-	int ret;
-
-	pr_info("Getting EFI parameters from FDT:\n");
-
-	info.found = 0;
-	info.params = &params;
-
-	ret = of_scan_flat_dt(fdt_find_uefi_params, &info);
-	if (!info.found) {
-		pr_info("UEFI not found.\n");
-		return 0;
-	} else if (!ret) {
-		pr_err("Can't find '%s' in device tree!\n", info.missing);
-		return 0;
-	}
-
-	memmap->desc_version	= params.desc_ver;
-	memmap->desc_size	= params.desc_size;
-	memmap->size		= params.mmap_size;
-	memmap->phys_map	= params.mmap;
-
-	return params.system_table;
-}
-- 
2.17.1

