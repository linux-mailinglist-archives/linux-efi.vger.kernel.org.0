Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F54310A219
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2019 17:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfKZQ37 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Nov 2019 11:29:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfKZQ37 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 26 Nov 2019 11:29:59 -0500
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net [91.167.84.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 184572071A;
        Tue, 26 Nov 2019 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574785798;
        bh=qrvXuMHKCoQOdORxNJ+YbqsB49FLPqu3p1fW/+eSpZo=;
        h=From:To:Cc:Subject:Date:From;
        b=rNwTJiwpENG4ilu/hr3qpPAyWcnzAGOtNgVJBrxsMrEgkzWe0Ng+15ivaad2xTIvx
         yMTwWWetijnvVdKWKUlrh5QdY8wiellk32/tA6dpP1AjdcTEAoL2qjvN//Fb8u6qal
         YuLRlvReTloPuw1Grmkb393LOg6lU11gvYBcBctQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        will@kernel.org, bhelgaas@google.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH] efi: arm: defer probe of PCIe backed efifb on DT systems
Date:   Tue, 26 Nov 2019 17:29:02 +0100
Message-Id: <20191126162902.16788-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/arm-init.c | 66 ++++++++++++++++++--
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 311cd349a862..617226d50774 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -14,6 +14,7 @@
 #include <linux/memblock.h>
 #include <linux/mm_types.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_fdt.h>
 #include <linux/platform_device.h>
 #include <linux/screen_info.h>
@@ -267,15 +268,70 @@ void __init efi_init(void)
 		efi_memmap_unmap();
 }
 
+static bool __init efifb_overlaps_pci_range(const struct of_pci_range *range)
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
 static int __init register_gop_device(void)
 {
-	void *pd;
+	struct platform_device *pd;
+	struct device_node *np;
+	bool found = false;
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
+	err = platform_device_add_data(pd, &screen_info, sizeof(screen_info));
+	if (err)
+		return err;
+
+	/*
+	 * If the efifb framebuffer is backed by a PCI graphics controller, we
+	 * have to ensure that this relation is expressed using a device link
+	 * when running in DT mode, or the probe order may be reversed,
+	 * resulting in a resource reservation conflict on the memory window
+	 * that the efifb framebuffer steals from the PCIe host bridge.
+	 */
+	for_each_node_by_type(np, "pci") {
+		struct of_pci_range_parser parser;
+		struct of_pci_range range;
+		struct device *sup_dev;
+
+		if (found) {
+			of_node_put(np);
+			break;
+		}
+
+		err = of_pci_range_parser_init(&parser, np);
+		if (err) {
+			pr_warn("of_pci_range_parser_init() failed: %d\n", err);
+			continue;
+		}
+
+		sup_dev = get_dev_from_fwnode(&np->fwnode);
+
+		for_each_of_pci_range(&parser, &range) {
+			if (efifb_overlaps_pci_range(&range)) {
+				found = true;
+				if (!device_link_add(&pd->dev, sup_dev, 0))
+					pr_warn("device_link_add() failed\n");
+				break;
+			}
+		}
+		put_device(sup_dev);
+	}
+	return platform_device_add(pd);
 }
-subsys_initcall(register_gop_device);
+device_initcall(register_gop_device);
-- 
2.20.1

