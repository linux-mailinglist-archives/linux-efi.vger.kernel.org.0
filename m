Return-Path: <linux-efi+bounces-928-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A5B89AB2E
	for <lists+linux-efi@lfdr.de>; Sat,  6 Apr 2024 15:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD1C2821C5
	for <lists+linux-efi@lfdr.de>; Sat,  6 Apr 2024 13:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE983374F5;
	Sat,  6 Apr 2024 13:54:21 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C96C2D05E;
	Sat,  6 Apr 2024 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712411661; cv=none; b=jBPrjJY2Psv4Resl/TlgFsetGc8sDS2uQOSSXsNHEa7QeyFTm8AlWF1kLHiK1xiZjY9hcPhx/CDcYXxSAZRfA4VMY/YBxHUfvnq+dEbkbY0mnFpa6/F/vMbqy6nv/LIbPo9pgwHer3bz51sqrAYst+tV+0EWyHsIMfLeoLU0yK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712411661; c=relaxed/simple;
	bh=++C446erfBmkIadT7UESxN+hRSqQcV8WtV6QE89m0GM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc; b=Ri2tzIyzkDCL/JJtYu9lpo++jFAQJHcEbYk9RS5VZCXSXSqOCCPNc+vAWn87TIRjxtxSoiR9UOxRtANhN6xxiZ9EzQWC8TSsnoJCLZBPyiV7YVOHV4Wu0cEDi7fJAHL90K9tNnAeyBbzj0Z3Mkton1aBsnhEtWx6xYCL+FJH2E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 879992800B3F1;
	Sat,  6 Apr 2024 15:54:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8084A9926B3; Sat,  6 Apr 2024 15:54:16 +0200 (CEST)
Message-Id: <92ee0a0e83a5a3f3474845db6c8575297698933a.1712410202.git.lukas@wunner.de>
In-Reply-To: <cover.1712410202.git.lukas@wunner.de>
References: <cover.1712410202.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 6 Apr 2024 15:52:02 +0200
Subject: [PATCH 2/2] treewide: Use sysfs_bin_attr_simple_read() helper
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>, intel-gvt-dev@lists.freedesktop.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

Deduplicate ->read() callbacks of bin_attributes which are backed by a
simple buffer in memory:

Use the newly introduced sysfs_bin_attr_simple_read() helper instead,
either by referencing it directly or by declaring such bin_attributes
with BIN_ATTR_SIMPLE_RO() or BIN_ATTR_SIMPLE_ADMIN_RO().

Aside from a reduction of LoC, this shaves off a few bytes from vmlinux
(304 bytes on an x86_64 allyesconfig).

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 arch/powerpc/platforms/powernv/opal.c              | 10 +--------
 drivers/acpi/bgrt.c                                |  9 +-------
 drivers/firmware/dmi_scan.c                        | 12 ++--------
 drivers/firmware/efi/rci2-table.c                  | 10 +--------
 drivers/gpu/drm/i915/gvt/firmware.c                | 26 +++++-----------------
 .../intel/int340x_thermal/int3400_thermal.c        |  9 +-------
 init/initramfs.c                                   | 10 +--------
 kernel/module/sysfs.c                              | 13 +----------
 8 files changed, 14 insertions(+), 85 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 45dd77e..5d0f35b 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -792,14 +792,6 @@ static int __init opal_sysfs_init(void)
 	return 0;
 }
 
-static ssize_t export_attr_read(struct file *fp, struct kobject *kobj,
-				struct bin_attribute *bin_attr, char *buf,
-				loff_t off, size_t count)
-{
-	return memory_read_from_buffer(buf, count, &off, bin_attr->private,
-				       bin_attr->size);
-}
-
 static int opal_add_one_export(struct kobject *parent, const char *export_name,
 			       struct device_node *np, const char *prop_name)
 {
@@ -826,7 +818,7 @@ static int opal_add_one_export(struct kobject *parent, const char *export_name,
 	sysfs_bin_attr_init(attr);
 	attr->attr.name = name;
 	attr->attr.mode = 0400;
-	attr->read = export_attr_read;
+	attr->read = sysfs_bin_attr_simple_read;
 	attr->private = __va(vals[0]);
 	attr->size = vals[1];
 
diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
index e4fb9e2..d1d9c92 100644
--- a/drivers/acpi/bgrt.c
+++ b/drivers/acpi/bgrt.c
@@ -29,14 +29,7 @@
 BGRT_SHOW(xoffset, image_offset_x);
 BGRT_SHOW(yoffset, image_offset_y);
 
-static ssize_t image_read(struct file *file, struct kobject *kobj,
-	       struct bin_attribute *attr, char *buf, loff_t off, size_t count)
-{
-	memcpy(buf, attr->private + off, count);
-	return count;
-}
-
-static BIN_ATTR_RO(image, 0);	/* size gets filled in later */
+static BIN_ATTR_SIMPLE_RO(image);
 
 static struct attribute *bgrt_attributes[] = {
 	&bgrt_attr_version.attr,
diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 015c95a..3d0f773 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -746,16 +746,8 @@ static void __init dmi_scan_machine(void)
 	pr_info("DMI not present or invalid.\n");
 }
 
-static ssize_t raw_table_read(struct file *file, struct kobject *kobj,
-			      struct bin_attribute *attr, char *buf,
-			      loff_t pos, size_t count)
-{
-	memcpy(buf, attr->private + pos, count);
-	return count;
-}
-
-static BIN_ATTR(smbios_entry_point, S_IRUSR, raw_table_read, NULL, 0);
-static BIN_ATTR(DMI, S_IRUSR, raw_table_read, NULL, 0);
+static BIN_ATTR_SIMPLE_ADMIN_RO(smbios_entry_point);
+static BIN_ATTR_SIMPLE_ADMIN_RO(DMI);
 
 static int __init dmi_init(void)
 {
diff --git a/drivers/firmware/efi/rci2-table.c b/drivers/firmware/efi/rci2-table.c
index de1a9a1..4fd45d6 100644
--- a/drivers/firmware/efi/rci2-table.c
+++ b/drivers/firmware/efi/rci2-table.c
@@ -40,15 +40,7 @@ struct rci2_table_global_hdr {
 static u32 rci2_table_len;
 unsigned long rci2_table_phys __ro_after_init = EFI_INVALID_TABLE_ADDR;
 
-static ssize_t raw_table_read(struct file *file, struct kobject *kobj,
-			      struct bin_attribute *attr, char *buf,
-			      loff_t pos, size_t count)
-{
-	memcpy(buf, attr->private + pos, count);
-	return count;
-}
-
-static BIN_ATTR(rci2, S_IRUSR, raw_table_read, NULL, 0);
+static BIN_ATTR_SIMPLE_ADMIN_RO(rci2);
 
 static u16 checksum(void)
 {
diff --git a/drivers/gpu/drm/i915/gvt/firmware.c b/drivers/gpu/drm/i915/gvt/firmware.c
index 4dd52ac..5e66a26 100644
--- a/drivers/gpu/drm/i915/gvt/firmware.c
+++ b/drivers/gpu/drm/i915/gvt/firmware.c
@@ -50,21 +50,7 @@ struct gvt_firmware_header {
 
 #define dev_to_drm_minor(d) dev_get_drvdata((d))
 
-static ssize_t
-gvt_firmware_read(struct file *filp, struct kobject *kobj,
-	     struct bin_attribute *attr, char *buf,
-	     loff_t offset, size_t count)
-{
-	memcpy(buf, attr->private + offset, count);
-	return count;
-}
-
-static struct bin_attribute firmware_attr = {
-	.attr = {.name = "gvt_firmware", .mode = (S_IRUSR)},
-	.read = gvt_firmware_read,
-	.write = NULL,
-	.mmap = NULL,
-};
+static BIN_ATTR_SIMPLE_ADMIN_RO(gvt_firmware);
 
 static int expose_firmware_sysfs(struct intel_gvt *gvt)
 {
@@ -107,10 +93,10 @@ static int expose_firmware_sysfs(struct intel_gvt *gvt)
 	crc32_start = offsetof(struct gvt_firmware_header, version);
 	h->crc32 = crc32_le(0, firmware + crc32_start, size - crc32_start);
 
-	firmware_attr.size = size;
-	firmware_attr.private = firmware;
+	bin_attr_gvt_firmware.size = size;
+	bin_attr_gvt_firmware.private = firmware;
 
-	ret = device_create_bin_file(&pdev->dev, &firmware_attr);
+	ret = device_create_bin_file(&pdev->dev, &bin_attr_gvt_firmware);
 	if (ret) {
 		vfree(firmware);
 		return ret;
@@ -122,8 +108,8 @@ static void clean_firmware_sysfs(struct intel_gvt *gvt)
 {
 	struct pci_dev *pdev = to_pci_dev(gvt->gt->i915->drm.dev);
 
-	device_remove_bin_file(&pdev->dev, &firmware_attr);
-	vfree(firmware_attr.private);
+	device_remove_bin_file(&pdev->dev, &bin_attr_gvt_firmware);
+	vfree(bin_attr_gvt_firmware.private);
 }
 
 /**
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 427d370..6d4b51a 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -73,14 +73,7 @@ struct odvp_attr {
 	struct device_attribute attr;
 };
 
-static ssize_t data_vault_read(struct file *file, struct kobject *kobj,
-	     struct bin_attribute *attr, char *buf, loff_t off, size_t count)
-{
-	memcpy(buf, attr->private + off, count);
-	return count;
-}
-
-static BIN_ATTR_RO(data_vault, 0);
+static BIN_ATTR_SIMPLE_RO(data_vault);
 
 static struct bin_attribute *data_attributes[] = {
 	&bin_attr_data_vault,
diff --git a/init/initramfs.c b/init/initramfs.c
index da79760..5193fae 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -575,15 +575,7 @@ static int __init initramfs_async_setup(char *str)
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
-static ssize_t raw_read(struct file *file, struct kobject *kobj,
-			struct bin_attribute *attr, char *buf,
-			loff_t pos, size_t count)
-{
-	memcpy(buf, attr->private + pos, count);
-	return count;
-}
-
-static BIN_ATTR(initrd, 0440, raw_read, NULL, 0);
+static BIN_ATTR(initrd, 0440, sysfs_bin_attr_simple_read, NULL, 0);
 
 void __init reserve_initrd_mem(void)
 {
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index d964167..26efe13 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -146,17 +146,6 @@ struct module_notes_attrs {
 	struct bin_attribute attrs[] __counted_by(notes);
 };
 
-static ssize_t module_notes_read(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *bin_attr,
-				 char *buf, loff_t pos, size_t count)
-{
-	/*
-	 * The caller checked the pos and count against our size.
-	 */
-	memcpy(buf, bin_attr->private + pos, count);
-	return count;
-}
-
 static void free_notes_attrs(struct module_notes_attrs *notes_attrs,
 			     unsigned int i)
 {
@@ -205,7 +194,7 @@ static void add_notes_attrs(struct module *mod, const struct load_info *info)
 			nattr->attr.mode = 0444;
 			nattr->size = info->sechdrs[i].sh_size;
 			nattr->private = (void *)info->sechdrs[i].sh_addr;
-			nattr->read = module_notes_read;
+			nattr->read = sysfs_bin_attr_simple_read;
 			++nattr;
 		}
 		++loaded;
-- 
2.43.0


