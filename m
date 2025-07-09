Return-Path: <linux-efi+bounces-4237-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3E4AFE568
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 12:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28C51C478FD
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55328288CAA;
	Wed,  9 Jul 2025 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJYVKtPz"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2423C01
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055888; cv=none; b=nq20qwZjHV+ykgoJupz+pgXcdBJ2/2TTo3R/HsP4nMpbfHC4p9cqnjWT2NQo9CO+wYXhzA2RQim1BFZ9GA5dsk+q6SkpoFeSSQVPKJnRTxm7S+Nv+kotEbYxJ0vey9Y4YSh1UnJ2TtIg5aislNgRg5RuPM172lj+smXfekpWIDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055888; c=relaxed/simple;
	bh=mOPkOrukG2Y239oOCufTagRLKNb8LP2t1L+ciZ22zGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OapywwifxUJZd34U21s8INIxLR8TE2eEWgVIBmY1L6EmtCMjRgvF9pgu9NuxCTarSL450xDZwwTZuM7miRs8sSRNeq7FX/LrlYOrfM6ZbcrLGXxjbpLSErWkFAcQm+FjDmll2skPL0NF2QOetbq4PVvnIo/SURikjoKRiEzZPzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJYVKtPz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752055885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F0LwotVAg6dvlb2u4HLohnwHaSnFFiXlXs6Bup/zLbc=;
	b=MJYVKtPzDbp07eNezikFFNiFEPoR7T6OAhXDHy4o2dj/FDcg4sMESAHWJqfz+AgxVNG6tX
	7Rhh0RtfqfPJj5ZfU5RJBWqQAJLOupoUg5hP9AV9WgrLOf6xL7q6NT4/9bphVIvcD6Betx
	DA8K/cdMJ2+3Cn+BvDf+Nrz5Et983p0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-_TuCxKyFOXOplWYcqt9etg-1; Wed,
 09 Jul 2025 06:11:23 -0400
X-MC-Unique: _TuCxKyFOXOplWYcqt9etg-1
X-Mimecast-MFC-AGG-ID: _TuCxKyFOXOplWYcqt9etg_1752055883
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB3A8193F05B;
	Wed,  9 Jul 2025 10:11:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19B373000198;
	Wed,  9 Jul 2025 10:11:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 7504218000B2; Wed, 09 Jul 2025 12:11:19 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: linux-efi@vger.kernel.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] efi: remove modular option for ovmf-debug-log
Date: Wed,  9 Jul 2025 12:11:18 +0200
Message-ID: <20250709101119.927808-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Flip the driver from tristate to bool, so it can not be built modular
any more.  Also drop the platform device boilerplate, simply call the
probe function directly instead.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507091432.rbbrjGoU-lkp@intel.com/
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/linux/efi.h                   |  2 ++
 drivers/firmware/efi/efi.c            |  2 +-
 drivers/firmware/efi/ovmf-debug-log.c | 43 ++++++---------------------
 drivers/firmware/efi/Kconfig          |  2 +-
 4 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index a71830608422..f6da5c226fda 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1346,6 +1346,8 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 
 umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
 
+int ovmf_log_probe(unsigned long ovmf_debug_log_table);
+
 /*
  * efivar ops event type
  */
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 3161f918ce53..1ce428e2ac8a 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -476,7 +476,7 @@ static int __init efisubsys_init(void)
 
 	if (IS_ENABLED(CONFIG_OVMF_DEBUG_LOG) &&
 	    efi.ovmf_debug_log != EFI_INVALID_TABLE_ADDR)
-		platform_device_register_simple("ovmf_debug_log", 0, NULL, 0);
+		ovmf_log_probe(efi.ovmf_debug_log);
 
 	return 0;
 
diff --git a/drivers/firmware/efi/ovmf-debug-log.c b/drivers/firmware/efi/ovmf-debug-log.c
index d4fec178fa9f..b292f35109b6 100644
--- a/drivers/firmware/efi/ovmf-debug-log.c
+++ b/drivers/firmware/efi/ovmf-debug-log.c
@@ -64,38 +64,33 @@ static struct bin_attribute ovmf_log_bin_attr = {
 	.read = ovmf_log_read,
 };
 
-static int ovmf_log_probe(struct platform_device *dev)
+__init int ovmf_log_probe(unsigned long ovmf_debug_log_table)
 {
 	u64 size;
 	int ret = -EINVAL;
 
-	if (efi.ovmf_debug_log == EFI_INVALID_TABLE_ADDR) {
-		dev_err(&dev->dev, "OVMF debug log: not available\n");
-		return -EINVAL;
-	}
-
 	/* map + verify header */
-	hdr = memremap(efi.ovmf_debug_log, sizeof(*hdr), MEMREMAP_WB);
+	hdr = memremap(ovmf_debug_log_table, sizeof(*hdr), MEMREMAP_WB);
 	if (!hdr) {
-		dev_err(&dev->dev, "OVMF debug log: header map failed\n");
+		printk(KERN_ERR "OVMF debug log: header map failed\n");
 		return -EINVAL;
 	}
 
 	if (hdr->magic1 != OVMF_DEBUG_LOG_MAGIC1 ||
 	    hdr->magic2 != OVMF_DEBUG_LOG_MAGIC2) {
-		dev_err(&dev->dev, "OVMF debug log: magic mismatch\n");
+		printk(KERN_ERR "OVMF debug log: magic mismatch\n");
 		goto err_unmap;
 	}
 
 	size = hdr->hdr_size + hdr->log_size;
-	dev_info(&dev->dev, "firmware version: \"%s\"\n", hdr->fw_version);
-	dev_info(&dev->dev, "log buffer size: %lluk\n", size / 1024);
+	printk(KERN_INFO "OVMF debug log: firmware version: \"%s\"\n", hdr->fw_version);
+	printk(KERN_INFO "OVMF debug log: buffer size: %lluk\n", size / 1024);
 
 	/* map complete log buffer */
 	memunmap(hdr);
-	hdr = memremap(efi.ovmf_debug_log, size, MEMREMAP_WB);
+	hdr = memremap(ovmf_debug_log_table, size, MEMREMAP_WB);
 	if (!hdr) {
-		dev_err(&dev->dev, "OVMF debug log: buffer map failed\n");
+		printk(KERN_ERR "OVMF debug log: buffer map failed\n");
 		return -EINVAL;
 	}
 	logbuf = (void *)hdr + hdr->hdr_size;
@@ -104,7 +99,7 @@ static int ovmf_log_probe(struct platform_device *dev)
 	ovmf_log_bin_attr.size = size;
 	ret = sysfs_create_bin_file(efi_kobj, &ovmf_log_bin_attr);
 	if (ret != 0) {
-		dev_err(&dev->dev, "OVMF debug log: sysfs register failed\n");
+		printk(KERN_ERR "OVMF debug log: sysfs register failed\n");
 		goto err_unmap;
 	}
 
@@ -114,23 +109,3 @@ static int ovmf_log_probe(struct platform_device *dev)
 	memunmap(hdr);
 	return ret;
 }
-
-static void ovmf_log_remove(struct platform_device *dev)
-{
-	memunmap(hdr);
-}
-
-static struct platform_driver ovmf_log_driver = {
-	.probe = ovmf_log_probe,
-	.remove = ovmf_log_remove,
-	.driver = {
-		.name = "ovmf_debug_log",
-	},
-};
-
-module_platform_driver(ovmf_log_driver);
-
-MODULE_DESCRIPTION("OVMF debug log");
-MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:ovmf_debug_log");
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index ac0a03ec3452..eb1bff6968a5 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -264,7 +264,7 @@ config EFI_COCO_SECRET
 	  allows userspace programs to access the injected secrets.
 
 config OVMF_DEBUG_LOG
-	tristate "Expose OVMF firmware debug log via sysfs"
+	bool "Expose OVMF firmware debug log via sysfs"
 	depends on EFI
 	help
 	  Recent OVMF versions (edk2-stable202508 + newer) can write
-- 
2.50.0


