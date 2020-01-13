Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B2513977C
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2020 18:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgAMRX0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jan 2020 12:23:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbgAMRX0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Jan 2020 12:23:26 -0500
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A7362081E;
        Mon, 13 Jan 2020 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578936204;
        bh=niQyp4EepwCvKwoSufe5yiv+s5x2vxpqwbY5ju16TJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ihGdTwRnrXKCjNJa1vpmzhFgqBGE410liZy96yELhFVNl0SAKU6zFIe1QYJqOQ4wK
         0TCrsVYbBNzL+1l6TiNvNzZ7TJcR16b71tZAxIF8UPqHANh/haWrC9XvhjkTQWSpsf
         ayz1+HQb5xlpGf0n47ba7hhNHb1I8HQAd+g3EXoA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 08/13] efi/arm: defer probe of PCIe backed efifb on DT systems
Date:   Mon, 13 Jan 2020 18:22:40 +0100
Message-Id: <20200113172245.27925-9-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113172245.27925-1-ardb@kernel.org>
References: <20200113172245.27925-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The new of_devlink support breaks PCIe probing on ARM platforms booting
via UEFI if the firmware exposes a EFI framebuffer that is backed by a
PCI device. The reason is that the probing order gets reversed,
resulting in a resource conflict on the framebuffer memory window when
the PCIe probes last, causing it to give up entirely.

Given that we rely on PCI quirks to deal with EFI framebuffers that get
moved around in memory, we cannot simply drop the memory reservation, so
instead, let's use the device link infrastructure to register this
dependency, and force the probing to occur in the expected order.

Co-developed-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
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
2.20.1

