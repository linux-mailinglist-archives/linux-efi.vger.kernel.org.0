Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6A313659F
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2020 04:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbgAJDBS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jan 2020 22:01:18 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:36743 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbgAJDBS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jan 2020 22:01:18 -0500
Received: by mail-pg1-f201.google.com with SMTP id i8so462436pgs.3
        for <linux-efi@vger.kernel.org>; Thu, 09 Jan 2020 19:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DnJt6kh0aGUVWb0xLd06fVCxkcizC6ZskKYdvVAtBnY=;
        b=Gh/Tzuzj0IXUAC+PeJ5gpwwjiQEWvlG05ugX1k3UhhcPz+XW1JMgH4prOJQdAs2KaM
         HcCZRLNIUISbv5kMSxR7/Qb5v9DAhnMtgZ87s6qfnek8ayNXvEWfHDTY5ea8oYAd7ukv
         LrORKZUIZVMeeE/IT1I1hAZVOpnTfKCbwTl5I+n1Iq/s0NsNL7+/6qxm05JnzpsT1fUo
         cKWx/AC9e2iulmA2L/B9pmVpm5i4ARMGbEVOHsLV9so0/T5pWdAY5ym2fEO/YO4q6a7z
         rIBYjT2mkC4MUxnEcpy+eI99jDxop/5TFDHR0rnxhv/hqXFy4vYPKDnE0qJKJUaa0a6o
         gQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DnJt6kh0aGUVWb0xLd06fVCxkcizC6ZskKYdvVAtBnY=;
        b=I9EbNwxxupIWDdtRTU6sIeqxkcfGLQDrITKQx0DqMYysg71NF2fVk37Yst89vmDgAw
         Dy41KyV3Sa0oRT0l1XJoYxHpoWO4LRGOuOpSy8QjeI1sm6X8CTj2LK1/V4IrOEf5W9FZ
         kq4CElxq0icfGX5vJJmWYwesjipepVUE9+4/t8n5dw+jsch0E8eS9obLhGzXo0nqwyrO
         UL3M+/qhoPMjdzIfPGsiUWYl0v1fcL6af2ZxQBc+hq+wqRP3ypL0YDY3P0zvMBYETO8B
         hksZhsYZgrBBBmwBf9BAb003EgHckhp5MJ8BsIG/flMfClJRttOQLLRZ+F7NL07rVQZd
         p0hA==
X-Gm-Message-State: APjAAAVaXwdl3a8OkLRkzaZvhJHIcYVVu8xF+CWNh7W6Z7VZbH00At/k
        NOuqs/YZKr0SxzOOGL0RMLDgNoQo3/9ch1k=
X-Google-Smtp-Source: APXvYqxAvSV90QbeIs2iZP+87eCL6XZYgyziMKCDAkncP7bUErJToa1qCy5JmINPe0ow59xylckCqSmvIsWEVWE=
X-Received: by 2002:a63:1210:: with SMTP id h16mr1450210pgl.171.1578625276730;
 Thu, 09 Jan 2020 19:01:16 -0800 (PST)
Date:   Thu,  9 Jan 2020 19:01:11 -0800
Message-Id: <20200110030112.188845-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v3] efi: arm: defer probe of PCIe backed efifb on DT systems
From:   Saravana Kannan <saravanak@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        bhelgaas@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

The new of_devlink support breaks PCIe probing on ARM platforms booting
via UEFI if the firmware exposes a EFI framebuffer that is backed by a
PCI device. The reason is that the probing order gets reversed,
resulting in a resource conflict on the framebuffer memory window when
the PCIe probes last, causing it to give up entirely.

Given that we rely on PCI quirks to deal with EFI framebuffers that get
moved around in memory, we cannot simply drop the memory reservation, so
instead, let's use the device link infrastructure to register this
dependency, and force the probing to occur in the expected order.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Co-developed-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---

v1 -> v2:
- Rewrote the device linking part to not depend on initcall ordering
v2 -> v3:
- Added const and check for CONFIG_PCI

 drivers/firmware/efi/arm-init.c | 107 ++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 904fa09e6a6b..d99f5b0c8a09 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -10,10 +10,12 @@
 #define pr_fmt(fmt)	"efi: " fmt
 
 #include <linux/efi.h>
+#include <linux/fwnode.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
 #include <linux/mm_types.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_fdt.h>
 #include <linux/platform_device.h>
 #include <linux/screen_info.h>
@@ -276,15 +278,112 @@ void __init efi_init(void)
 		efi_memmap_unmap();
 }
 
+static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
+{
+	u64 fb_base = screen_info.lfb_base;
+
+	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		fb_base |= (u64)(unsigned long)screen_info.ext_lfb_base << 32;
+
+	return fb_base >= range->cpu_addr &&
+	       fb_base < (range->cpu_addr + range->size);
+}
+
+static struct device_node *find_pci_overlap_node(void)
+{
+	struct device_node *np;
+
+	for_each_node_by_type(np, "pci") {
+		struct of_pci_range_parser parser;
+		struct of_pci_range range;
+		int err;
+
+		err = of_pci_range_parser_init(&parser, np);
+		if (err) {
+			pr_warn("of_pci_range_parser_init() failed: %d\n", err);
+			continue;
+		}
+
+		for_each_of_pci_range(&parser, &range)
+			if (efifb_overlaps_pci_range(&range))
+				return np;
+	}
+	return NULL;
+}
+
+/*
+ * If the efifb framebuffer is backed by a PCI graphics controller, we have
+ * to ensure that this relation is expressed using a device link when
+ * running in DT mode, or the probe order may be reversed, resulting in a
+ * resource reservation conflict on the memory window that the efifb
+ * framebuffer steals from the PCIe host bridge.
+ */
+static int efifb_add_links(const struct fwnode_handle *fwnode,
+			   struct device *dev)
+{
+	struct device_node *sup_np;
+	struct device *sup_dev;
+
+	sup_np = find_pci_overlap_node();
+
+	/*
+	 * If there's no PCI graphics controller backing the efifb, we are
+	 * done here.
+	 */
+	if (!sup_np)
+		return 0;
+
+	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
+	of_node_put(sup_np);
+
+	/*
+	 * Return -ENODEV if the PCI graphics controller device hasn't been
+	 * registered yet.  This ensures that efifb isn't allowed to probe
+	 * and this function is retried again when new devices are
+	 * registered.
+	 */
+	if (!sup_dev)
+		return -ENODEV;
+
+	/*
+	 * If this fails, retrying this function at a later point won't
+	 * change anything. So, don't return an error after this.
+	 */
+	if (!device_link_add(dev, sup_dev, 0))
+		dev_warn(dev, "device_link_add() failed\n");
+
+	put_device(sup_dev);
+
+	return 0;
+}
+
+static const struct fwnode_operations efifb_fwnode_ops = {
+	.add_links = efifb_add_links,
+};
+
+static struct fwnode_handle efifb_fwnode = {
+	.ops = &efifb_fwnode_ops,
+};
+
 static int __init register_gop_device(void)
 {
-	void *pd;
+	struct platform_device *pd;
+	int err;
 
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
 		return 0;
 
-	pd = platform_device_register_data(NULL, "efi-framebuffer", 0,
-					   &screen_info, sizeof(screen_info));
-	return PTR_ERR_OR_ZERO(pd);
+	pd = platform_device_alloc("efi-framebuffer", 0);
+	if (!pd)
+		return -ENOMEM;
+
+	if (IS_ENABLED(CONFIG_PCI))
+		pd->dev.fwnode = &efifb_fwnode;
+
+	err = platform_device_add_data(pd, &screen_info, sizeof(screen_info));
+	if (err)
+		return err;
+
+	return platform_device_add(pd);
 }
 subsys_initcall(register_gop_device);
-- 
2.25.0.rc1.283.g88dfdc4193-goog

