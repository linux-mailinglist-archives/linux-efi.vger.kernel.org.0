Return-Path: <linux-efi+bounces-3024-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 510F5A67A49
	for <lists+linux-efi@lfdr.de>; Tue, 18 Mar 2025 18:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD166165078
	for <lists+linux-efi@lfdr.de>; Tue, 18 Mar 2025 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9EB213220;
	Tue, 18 Mar 2025 17:02:39 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1494120FA85;
	Tue, 18 Mar 2025 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317359; cv=none; b=Mq9v7PYxiGNId447+e8IYwEUharR2kivyBIocZUDix+29wWdS8GzPC/UMtoUJCzcMcQgJau+ml1HdEM8nn10VGAEuEm6rwEf2SHjcMBgsVH1guhi9QyLy2dgAlZwR2IWd5Br1X4DYD/Nzt4J4Tan+sMEhhuTGbOHbzLA/R7accE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317359; c=relaxed/simple;
	bh=k6j3DBsimegxPoU9UiZ9TSkg2hg0aryPCM5hJl5zw4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qm5mbT+mb2dAzUqdTXTNJjIpFVjAaQez5AWQ2CSlOWcFLdWXiBXRmzrrl6ewnav1A5zcJhkAFL1NRrcDLOUcOLqGTxtULGsJv7dYPq+wmWmEM+4Xur1/oladNseZK08VKnh/T2n28dMD0DtiSp3SKYxiHNkUEBpKjUCMFFqPak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A8001BF7;
	Tue, 18 Mar 2025 10:02:45 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A2A53F673;
	Tue, 18 Mar 2025 10:02:35 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 18 Mar 2025 17:01:43 +0000
Subject: [PATCH v2 5/8] virt: efi_secret: Transition to the faux device
 interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-plat2faux_dev-v2-5-e6cc73f78478@arm.com>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
In-Reply-To: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4350; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=k6j3DBsimegxPoU9UiZ9TSkg2hg0aryPCM5hJl5zw4g=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn2aciefH/zbE9cqyOtTLIfCPlafuR7jl/RVr/f
 rkxbVS6LgOJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9mnIgAKCRAAQbq8MX7i
 mJO4D/4wgOELwUSW3aUd98WcEmrln+VhUVv4IND46FmOMaLpLzOPpA4zIA0yrVUMS+iJO8HVy92
 nh4r27qvdgXBNORd3jej4FswWHuPHBV07OZrwVCEGDUQVPevirLb1FeT23ZSkCxchWsuWMgKtt9
 +GXgXqzI1RhXTyTmw3DRmzbWeSzjnrANxekYJOx1u8Qitn6DMSoYDktuaGiVH50kp4trjhQZo9k
 TQrAZQsEh30lk+18+uzjivnlpBeJgUN8CG/9m3f0OR9BHSoZbY9EWp0YhkfGmnVxFX10UvQacMq
 r0oDVhQIZ1xtKZja3tY2jO6omSIH3CxridohV7EMgjDJ3/pFjCN9KYdqeQrI7/+GJnk6eAEygUM
 wpunQDRO2iyjGmFUGuBj4JV5DN4+IVY5bXdAXQhdpFpxV8RG6N/OA4TxnmoMOABOCcd707gbtUi
 lm7Mw4e8CH1OZtdn/5Pb4rXUjykcNNtdirM/KKREGJmuT0j69LDcc8x2npo2TSh6HtQkm+W3LPQ
 2Z8zQo8BQN6DnFqJcu/7BDLeflK9Rg1yX2kqFRdKhgFZ5uEn7jICyTP5616vTZaORzucJsEtkQN
 zirUeRcMCC/B6+sJTmbhkq5l5AvQGOPB96Ldy93CcYriykU2xId03YvkziUD0BE+h67Z0B5p/2U
 1efnVjM+GiVDahg==
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
 drivers/firmware/efi/efi.c                |  5 -----
 drivers/virt/coco/efi_secret/efi_secret.c | 29 ++++++++---------------------
 2 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 8aebc747c65bc1b63d514a50fe6f35a9e3c1af0a..862b7744c28ecc9e5a64bbb3533c34119f50267f 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -465,11 +465,6 @@ static int __init efisubsys_init(void)
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
index 1864f9f80617e082feb574a15327949972c8cc1e..a60976750bef787c78401bf4569ee5d0c7d2b5f4 100644
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
 
@@ -326,23 +321,15 @@ static int efi_secret_probe(struct platform_device *dev)
 	return ret;
 }
 
-static void efi_secret_remove(struct platform_device *dev)
+static void efi_secret_remove(struct faux_device *dev)
 {
 	efi_secret_securityfs_teardown(dev);
 	efi_secret_unmap_area();
 }
 
-static struct platform_driver efi_secret_driver = {
-	.probe = efi_secret_probe,
-	.remove = efi_secret_remove,
-	.driver = {
-		.name = "efi_secret",
-	},
-};
-
-module_platform_driver(efi_secret_driver);
+module_faux_driver(efi_secret, efi_secret_probe, efi_secret_remove,
+		   efi.coco_secret != EFI_INVALID_TABLE_ADDR);
 
 MODULE_DESCRIPTION("Confidential computing EFI secret area access");
 MODULE_AUTHOR("IBM");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:efi_secret");

-- 
2.34.1


