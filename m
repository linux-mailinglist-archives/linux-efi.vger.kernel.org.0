Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37346129D81
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 05:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfLXElx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Dec 2019 23:41:53 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:42283 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfLXElw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Dec 2019 23:41:52 -0500
Received: by mail-vk1-f202.google.com with SMTP id 198so7409868vkz.9
        for <linux-efi@vger.kernel.org>; Mon, 23 Dec 2019 20:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yroEW0xn9BihGZeuB+O1xglR6PYA2TBreCzWoEGLf04=;
        b=iUJt8dtMk5q41cRHbGDUJSVoeMRh/TeNE3JSDVCIQCm5jmHzA9JNOr0swbMu4OMGdF
         7dwbygk3CplLVRta3GhMkvz1YMEEymrE0fUvrkm1h2aIJAYYk00+JgIfnXIEE+vU/UaF
         bUyfBYh8Hv7P+2cpiFberWsRznAFqxiKequyel8lJiFGMFH8fTAI5V/ellPt/rx/x5r3
         c9/uzthGSjR0PJ/WRHl0kWKPojE/MIgcNMqC29l8EqWieorRo8hilN/5QANCQ7pXJ7uq
         kEhG/cMc6g2YqzTN0b99riYSLxAnuC4EBksULWiE7Jl45kjECJHdFFOrIvcroLbAVrzb
         pfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yroEW0xn9BihGZeuB+O1xglR6PYA2TBreCzWoEGLf04=;
        b=IX/bNAAUShGynU2omvHU4gTQHDgfza/QHLtcRv25Q3I1UCr615dWOnmO3Nn9NQJdCS
         rpXpGJIwyHHnXhz9+ZjDF/xicj4jJmPPxwUk9hPGfMVMpT/BRi0SykiyziW4893h9yio
         P0uom4JjSBCDzRNpwS8GV+WKT7e9bhnF6QcEw66/8T0nrZ5pN616Epdx9Nm/T8oQvCvk
         RrR4d8zifamaGSb8BLlJXKtht3KspiiTEvhwJAo7wSFrKP0W8Cp+Sc098ozUB/Wcj19Q
         j8C7nmb57fR3cdJtpwia8ucm5FK41DxScGdkuDEu1a8FATpPXZ6++CbdxLUUe7Gs/GXI
         Nu/Q==
X-Gm-Message-State: APjAAAX99fDUQRGQWWMXi6Ihv72tYz/FT7DouthDeadyBYiUBMMjS7A7
        VAMHGhroyo3dSjD4dEFKNbloXO49d4ElAow=
X-Google-Smtp-Source: APXvYqxh9ATFeQANX8izAqqM7SHQ6Zqc8GWH2ft8gGY6oxG1HaOF75/GKCifSdlsUoByWqAmw3OPbieHzyq3lNQ=
X-Received: by 2002:a9f:222d:: with SMTP id 42mr20116882uad.6.1577162511178;
 Mon, 23 Dec 2019 20:41:51 -0800 (PST)
Date:   Mon, 23 Dec 2019 20:41:46 -0800
Message-Id: <20191224044146.232713-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2] efi: arm: defer probe of PCIe backed efifb on DT systems
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
---

Hi Ard,

I compile tested it and I think it should work. If you can actually run
and test it, that'd be nice.

You can also optimize find_pci_overlap_node() by caching the result if
you think that's necessary.

Right now this code will run always just like your code did. But once I
rename of_devlink to fw_devlink, this code won't be run if fw_devlink is
disabled.

v1 -> v2:
- Rewrote the device linking part to not depend on initcall ordering

 drivers/firmware/efi/arm-init.c | 106 ++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 904fa09e6a6b..8b789ff83af0 100644
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
@@ -276,15 +278,111 @@ void __init efi_init(void)
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
+static struct fwnode_operations efifb_fwnode_ops = {
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
+	pd->dev.fwnode = &efifb_fwnode;
+
+	err = platform_device_add_data(pd, &screen_info, sizeof(screen_info));
+	if (err)
+		return err;
+
+	return platform_device_add(pd);
 }
 subsys_initcall(register_gop_device);
-- 
2.24.1.735.g03f4e72817-goog

