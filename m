Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D627116043E
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 15:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgBPOLz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 09:11:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgBPOLy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 09:11:54 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C1DD208C4;
        Sun, 16 Feb 2020 14:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581862313;
        bh=4m/11AElb2dlfYV6V6rpF0DuECvVkJTLzQ7WYol5dlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=el4/vk/yd2XNSNwCrE59kUV3WkbJsLOfjY+9Mp4gyVtQwTt9/TKhulJs9uhfZSpjP
         otLjG/dIFhRe1BHY3DGady2LHwKgibXo2bbaWX3L72M28/cxBaGuZCQOX7XkEGaAeF
         ZYGjpVM8QdjgTjmnbHHPpmtXesIw+WAl7feYgpkQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        lersek@redhat.com, leif@nuviainc.com, pjones@redhat.com,
        mjg59@google.com, agraf@csgraf.de, ilias.apalodimas@linaro.org,
        xypron.glpk@gmx.de, daniel.kiper@oracle.com, nivedita@alum.mit.edu,
        James.Bottomley@hansenpartnership.com, lukas@wunner.de
Subject: [PATCH v2 1/3] efi/dev-path-parser: Add struct definition for vendor type device path nodes
Date:   Sun, 16 Feb 2020 15:11:02 +0100
Message-Id: <20200216141104.21477-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200216141104.21477-1-ardb@kernel.org>
References: <20200216141104.21477-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation of adding support for loading the initrd via a special
device path, add the struct definition of a vendor GUIDed device path
node to efi.h.

Since we will be producing these data structures rather than just
consumsing the ones instantiated by the firmware, refactor the various
device path node definitions so we can take the size of each node using
sizeof() rather than having to resort to opaque arithmetic in the static
initializers.

While at it, drop the #if IS_ENABLED() check for the declaration of
efi_get_device_by_path(), which is unnecessary, and constify its first
argument as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/apple-properties.c |  8 ++--
 drivers/firmware/efi/dev-path-parser.c  | 38 ++++++++--------
 include/linux/efi.h                     | 48 ++++++++++++--------
 3 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
index 084942846f4d..34f53d898acb 100644
--- a/drivers/firmware/efi/apple-properties.c
+++ b/drivers/firmware/efi/apple-properties.c
@@ -46,7 +46,7 @@ struct properties_header {
 };
 
 static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
-					     struct device *dev, void *ptr,
+					     struct device *dev, const void *ptr,
 					     struct property_entry entry[])
 {
 	int i;
@@ -117,10 +117,10 @@ static int __init unmarshal_devices(struct properties_header *properties)
 	while (offset + sizeof(struct dev_header) < properties->len) {
 		struct dev_header *dev_header = (void *)properties + offset;
 		struct property_entry *entry = NULL;
+		const struct efi_dev_path *ptr;
 		struct device *dev;
 		size_t len;
 		int ret, i;
-		void *ptr;
 
 		if (offset + dev_header->len > properties->len ||
 		    dev_header->len <= sizeof(*dev_header)) {
@@ -131,10 +131,10 @@ static int __init unmarshal_devices(struct properties_header *properties)
 		ptr = dev_header->path;
 		len = dev_header->len - sizeof(*dev_header);
 
-		dev = efi_get_device_by_path((struct efi_dev_path **)&ptr, &len);
+		dev = efi_get_device_by_path(&ptr, &len);
 		if (IS_ERR(dev)) {
 			pr_err("device path parse error %ld at %#zx:\n",
-			       PTR_ERR(dev), ptr - (void *)dev_header);
+			       PTR_ERR(dev), (void *)ptr - (void *)dev_header);
 			print_hex_dump(KERN_ERR, pr_fmt(), DUMP_PREFIX_OFFSET,
 			       16, 1, dev_header, dev_header->len, true);
 			dev = NULL;
diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
index 20123384271c..5c9625e552f4 100644
--- a/drivers/firmware/efi/dev-path-parser.c
+++ b/drivers/firmware/efi/dev-path-parser.c
@@ -31,13 +31,13 @@ static int __init match_acpi_dev(struct device *dev, const void *data)
 		return !strcmp("0", hid_uid.uid);
 }
 
-static long __init parse_acpi_path(struct efi_dev_path *node,
+static long __init parse_acpi_path(const struct efi_dev_path *node,
 				   struct device *parent, struct device **child)
 {
 	struct acpi_hid_uid hid_uid = {};
 	struct device *phys_dev;
 
-	if (node->length != 12)
+	if (node->header.length != 12)
 		return -EINVAL;
 
 	sprintf(hid_uid.hid[0].id, "%c%c%c%04X",
@@ -69,12 +69,12 @@ static int __init match_pci_dev(struct device *dev, void *data)
 	return dev_is_pci(dev) && to_pci_dev(dev)->devfn == devfn;
 }
 
-static long __init parse_pci_path(struct efi_dev_path *node,
+static long __init parse_pci_path(const struct efi_dev_path *node,
 				  struct device *parent, struct device **child)
 {
 	unsigned int devfn;
 
-	if (node->length != 6)
+	if (node->header.length != 6)
 		return -EINVAL;
 	if (!parent)
 		return -EINVAL;
@@ -105,19 +105,19 @@ static long __init parse_pci_path(struct efi_dev_path *node,
  * search for a device.
  */
 
-static long __init parse_end_path(struct efi_dev_path *node,
+static long __init parse_end_path(const struct efi_dev_path *node,
 				  struct device *parent, struct device **child)
 {
-	if (node->length != 4)
+	if (node->header.length != 4)
 		return -EINVAL;
-	if (node->sub_type != EFI_DEV_END_INSTANCE &&
-	    node->sub_type != EFI_DEV_END_ENTIRE)
+	if (node->header.sub_type != EFI_DEV_END_INSTANCE &&
+	    node->header.sub_type != EFI_DEV_END_ENTIRE)
 		return -EINVAL;
 	if (!parent)
 		return -ENODEV;
 
 	*child = get_device(parent);
-	return node->sub_type;
+	return node->header.sub_type;
 }
 
 /**
@@ -156,7 +156,7 @@ static long __init parse_end_path(struct efi_dev_path *node,
  *	%ERR_PTR(-EINVAL) if a node is malformed or exceeds @len,
  *	%ERR_PTR(-ENOTSUPP) if support for a node type is not yet implemented.
  */
-struct device * __init efi_get_device_by_path(struct efi_dev_path **node,
+struct device * __init efi_get_device_by_path(const struct efi_dev_path **node,
 					      size_t *len)
 {
 	struct device *parent = NULL, *child;
@@ -166,16 +166,16 @@ struct device * __init efi_get_device_by_path(struct efi_dev_path **node,
 		return NULL;
 
 	while (!ret) {
-		if (*len < 4 || *len < (*node)->length)
+		if (*len < 4 || *len < (*node)->header.length)
 			ret = -EINVAL;
-		else if ((*node)->type     == EFI_DEV_ACPI &&
-			 (*node)->sub_type == EFI_DEV_BASIC_ACPI)
+		else if ((*node)->header.type		== EFI_DEV_ACPI &&
+			 (*node)->header.sub_type	== EFI_DEV_BASIC_ACPI)
 			ret = parse_acpi_path(*node, parent, &child);
-		else if ((*node)->type     == EFI_DEV_HW &&
-			 (*node)->sub_type == EFI_DEV_PCI)
+		else if ((*node)->header.type		== EFI_DEV_HW &&
+			 (*node)->header.sub_type	== EFI_DEV_PCI)
 			ret = parse_pci_path(*node, parent, &child);
-		else if (((*node)->type    == EFI_DEV_END_PATH ||
-			  (*node)->type    == EFI_DEV_END_PATH2))
+		else if (((*node)->header.type		== EFI_DEV_END_PATH ||
+			  (*node)->header.type		== EFI_DEV_END_PATH2))
 			ret = parse_end_path(*node, parent, &child);
 		else
 			ret = -ENOTSUPP;
@@ -185,8 +185,8 @@ struct device * __init efi_get_device_by_path(struct efi_dev_path **node,
 			return ERR_PTR(ret);
 
 		parent = child;
-		*node  = (void *)*node + (*node)->length;
-		*len  -= (*node)->length;
+		*node  = (void *)*node + (*node)->header.length;
+		*len  -= (*node)->header.length;
 	}
 
 	if (ret == EFI_DEV_END_ENTIRE)
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 9ccf313fe9de..0976e57b4caa 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -855,30 +855,40 @@ extern int efi_status_to_err(efi_status_t status);
 #define   EFI_DEV_END_ENTIRE			0xFF
 
 struct efi_generic_dev_path {
-	u8 type;
-	u8 sub_type;
-	u16 length;
-} __attribute ((packed));
+	u8				type;
+	u8				sub_type;
+	u16				length;
+} __packed;
+
+struct efi_acpi_dev_path {
+	struct efi_generic_dev_path	header;
+	u32				hid;
+	u32				uid;
+} __packed;
+
+struct efi_pci_dev_path {
+	struct efi_generic_dev_path	header;
+	u8				fn;
+	u8				dev;
+} __packed;
+
+struct efi_vendor_dev_path {
+	struct efi_generic_dev_path	header;
+	efi_guid_t			vendorguid;
+	u8				vendordata[];
+} __packed;
 
 struct efi_dev_path {
-	u8 type;	/* can be replaced with unnamed */
-	u8 sub_type;	/* struct efi_generic_dev_path; */
-	u16 length;	/* once we've moved to -std=c11 */
 	union {
-		struct {
-			u32 hid;
-			u32 uid;
-		} acpi;
-		struct {
-			u8 fn;
-			u8 dev;
-		} pci;
+		struct efi_generic_dev_path	header;
+		struct efi_acpi_dev_path	acpi;
+		struct efi_pci_dev_path		pci;
+		struct efi_vendor_dev_path	vendor;
 	};
-} __attribute ((packed));
+} __packed;
 
-#if IS_ENABLED(CONFIG_EFI_DEV_PATH_PARSER)
-struct device *efi_get_device_by_path(struct efi_dev_path **node, size_t *len);
-#endif
+struct device *efi_get_device_by_path(const struct efi_dev_path **node,
+				      size_t *len);
 
 static inline void memrange_efi_to_native(u64 *addr, u64 *npages)
 {
-- 
2.17.1

