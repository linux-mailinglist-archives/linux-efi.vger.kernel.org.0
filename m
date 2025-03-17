Return-Path: <linux-efi+bounces-2999-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ED8A64923
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 11:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94A716D346
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 10:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5508E2376ED;
	Mon, 17 Mar 2025 10:14:00 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA2B23645D;
	Mon, 17 Mar 2025 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206440; cv=none; b=tQZtu9uL0uT8dGvNEuPQMZxCWf++lHJh5mfWzYeNX+5DfF5NS8C4gHRm+9v1dX6b9q4j05KgxvRSwFJrbwa2jvQPFsK+SB42BpS1S3eP1sOk+IpSPWMHpcwPr3b9t9M1g4u0EOWoeMm6yO4PJVfqqpQHgXDK/b7QxQrD3vsqTc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206440; c=relaxed/simple;
	bh=oY5sBJ+KkkG3u5X9v2vQKvNgoaMo5GzExyJV9eh/oKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cPImclo25qh+kvGRPoF23Xn7caJ5x+HNwMl2JSqoKJsx29BQu2eAiq14BEFQz/5V60RzRLNZnS9P7GymhtJOfoH8DJp1QrGmyXrYzLI2aVDmXAP5bQGg6xfthLqKWgGe/raYwWGjVsF9P/xALmvFwYc0ATfOVEbJ0Ky/QOwEuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6087E2576;
	Mon, 17 Mar 2025 03:14:07 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FAF93F673;
	Mon, 17 Mar 2025 03:13:57 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Mar 2025 10:13:17 +0000
Subject: [PATCH 5/9] virt: efi_secret: Transition to the faux device
 interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-plat2faux_dev-v1-5-5fe67c085ad5@arm.com>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
In-Reply-To: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4901; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=oY5sBJ+KkkG3u5X9v2vQKvNgoaMo5GzExyJV9eh/oKw=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn1/Xb9hLR34OMZ3kH3QO2MD2CArym3+Y0dZJx6
 F42iy2aR3SJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9f12wAKCRAAQbq8MX7i
 mFfrEADQiDjMjlGjIwyiZkhAey8tBlfgC76m6I+alJHVMAbKPl0FPDymiexP66PTKM7NRkpkYa6
 iJczYQDfPTrnGRwjJzcd54mp4SBaQhZSY8+CNHFdLrbeAdR0ab65ERhffXA9gzdTXR+sfDjlLfo
 3N43XyaEp9/A1u25XanYuP4MNAGx7ZJmfzEWwvm1ROpEA2X6gQtCkT5GjqK9IJFwdnj+Yfan4Xh
 fxx79tm653437zwNlzlXuFlafUx1p9F1wQ6+PNcPoArWh/mhieSioBFWjYh8qlSvfhJRqzn3x1e
 /KMOWCot5SFEFNv4Pa3AnbP0X1dHbbYqY0uKqS/0mRZHoz2jwuZbmCLZ6usfybMlHHyjkBAuSQO
 7e6/4FP9BoZzORnjIkltEFfAuoKqRKo6JTD3HoV3JP1DzoAF0lPrJAye6hvGHZ9gSMQI2WiPE3l
 ma1M0+H9W5w+WzAV3sow+n0pt0A6R5EV0IKOXjoECZDqWwvdvm4lGw34khXbSqEgg0mcIBy5QfL
 U7/Mm1g6mjK9hK7gDhJc8d7NM5Tk8kuLBc2Ih0YcgDazI7lzVfWrFTFV3rWBi+FOYsteyFqd/bY
 wlPiBpAZstoBRvhWNspMuOrC+e4t9T5A2z349dmlY5f4dY7Un36K/pzIJS4ReZmpZisg/e+M1Ij
 A/ra1efQ7SWi5Qw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The EFI secret area driver does not require the creation of a platform
device. Originally, this approach was chosen for simplicity when the
driver was first implemented.

With the introduction of the lightweight faux device interface, we now
have a more appropriate alternative. Migrate the driver to utilize the
faux bus, given that the platform device it previously created was not
a real one anyway. This will simplify the code, reducing its footprint
while maintaining functionality.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/efi/efi.c                |  6 -----
 drivers/virt/coco/efi_secret/efi_secret.c | 41 ++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 18deb2d212ce6944927f5e3a9a40bb6754e7ffa9..4654a88d4e12f354a891118edf9001755285c69a 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -24,7 +24,6 @@
 #include <linux/initrd.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
-#include <linux/platform_device.h>
 #include <linux/random.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
@@ -464,11 +463,6 @@ static int __init efisubsys_init(void)
 	if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
 		efi_debugfs_init();
 
-#ifdef CONFIG_EFI_COCO_SECRET
-	if (efi.coco_secret != EFI_INVALID_TABLE_ADDR)
-		platform_device_register_simple("efi_secret", 0, NULL, 0);
-#endif
-
 	return 0;
 
 err_remove_group:
diff --git a/drivers/virt/coco/efi_secret/efi_secret.c b/drivers/virt/coco/efi_secret/efi_secret.c
index 1864f9f80617e082feb574a15327949972c8cc1e..4ba1a9f3b8a90981795d296d0a8dfdc9edb22966 100644
--- a/drivers/virt/coco/efi_secret/efi_secret.c
+++ b/drivers/virt/coco/efi_secret/efi_secret.c
@@ -16,7 +16,7 @@
  * is the GUID of the secret entry, and its content is the secret data.
  */
 
-#include <linux/platform_device.h>
+#include <linux/device/faux.h>
 #include <linux/seq_file.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
@@ -152,17 +152,12 @@ static const struct inode_operations efi_secret_dir_inode_operations = {
 	.unlink         = efi_secret_unlink,
 };
 
-static int efi_secret_map_area(struct platform_device *dev)
+static int efi_secret_map_area(struct faux_device *dev)
 {
 	int ret;
 	struct efi_secret *s = efi_secret_get();
 	struct linux_efi_coco_secret_area *secret_area;
 
-	if (efi.coco_secret == EFI_INVALID_TABLE_ADDR) {
-		dev_err(&dev->dev, "Secret area address is not available\n");
-		return -EINVAL;
-	}
-
 	secret_area = memremap(efi.coco_secret, sizeof(*secret_area), MEMREMAP_WB);
 	if (secret_area == NULL) {
 		dev_err(&dev->dev, "Could not map secret area EFI config entry\n");
@@ -191,7 +186,7 @@ static int efi_secret_map_area(struct platform_device *dev)
 	return ret;
 }
 
-static void efi_secret_securityfs_teardown(struct platform_device *dev)
+static void efi_secret_securityfs_teardown(struct faux_device *dev)
 {
 	struct efi_secret *s = efi_secret_get();
 	int i;
@@ -210,7 +205,7 @@ static void efi_secret_securityfs_teardown(struct platform_device *dev)
 	dev_dbg(&dev->dev, "Removed securityfs entries\n");
 }
 
-static int efi_secret_securityfs_setup(struct platform_device *dev)
+static int efi_secret_securityfs_setup(struct faux_device *dev)
 {
 	struct efi_secret *s = efi_secret_get();
 	int ret = 0, i = 0, bytes_left;
@@ -307,7 +302,7 @@ static void efi_secret_unmap_area(void)
 	}
 }
 
-static int efi_secret_probe(struct platform_device *dev)
+static int efi_secret_probe(struct faux_device *dev)
 {
 	int ret;
 
@@ -326,23 +321,35 @@ static int efi_secret_probe(struct platform_device *dev)
 	return ret;
 }
 
-static void efi_secret_remove(struct platform_device *dev)
+static void efi_secret_remove(struct faux_device *dev)
 {
 	efi_secret_securityfs_teardown(dev);
 	efi_secret_unmap_area();
 }
 
-static struct platform_driver efi_secret_driver = {
+static struct faux_device_ops efi_secret_ops = {
 	.probe = efi_secret_probe,
 	.remove = efi_secret_remove,
-	.driver = {
-		.name = "efi_secret",
-	},
 };
 
-module_platform_driver(efi_secret_driver);
+static int __init efi_secret_init(void)
+{
+	struct faux_device *fdev;
+
+	if (efi.coco_secret == EFI_INVALID_TABLE_ADDR)
+		return 0;
+
+	fdev = faux_device_create("efi_secret", NULL, &efi_secret_ops);
+	if (!fdev) {
+		pr_err("efi_secret: could not create the device\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+device_initcall(efi_secret_init);
 
 MODULE_DESCRIPTION("Confidential computing EFI secret area access");
 MODULE_AUTHOR("IBM");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:efi_secret");
+MODULE_ALIAS("faux:efi_secret");

-- 
2.34.1


