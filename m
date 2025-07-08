Return-Path: <linux-efi+bounces-4191-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0236AFCB12
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 14:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3265116ABD7
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BF82DCBF9;
	Tue,  8 Jul 2025 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipv+sGsh"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027752D8DC8
	for <linux-efi@vger.kernel.org>; Tue,  8 Jul 2025 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979393; cv=none; b=HGCQGS+e20kknB/qGAuSvhXy1uZOTGWR4K7mH6wmE17NhODRdcrZ2B9cB0sqdoLZE3o27cISTNDAl4XXz2jNWk0fkWKCM5i7DZtF9ESvKD+aMeC346xkBLKusi6Hqito2Y7r4hu9+f5DlK4XQRAr29Cedfiqo7qtWSctD9PJ6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979393; c=relaxed/simple;
	bh=k0+kuM8Cz5ViKY95vOHHlaBqnsa27iueNbzExq+qfe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ljny9G7og1NOMuKgX5QZKs1V2V0GNAbp2Lqe7k9ekjioomD6hRNvq1aB6nWFCOdMRdzzRkhoMZHd1hr1/tCUH0Wfz1ySD3q4xpnFK7AzqA4NM4oHQrXn19PlIyabp4njwfRjhP6E7nbOt3xdHrauXEn0IXsbi+GA0/YPXxIoPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipv+sGsh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751979390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4enkuUM/Iqg8u3LUOVhlUlkEjtxCVEV8ARt1lHw3cJw=;
	b=ipv+sGshsdFf1tUGOuJOb4p5ogzLGZ88gWhk71Dx+Od1xc3W2hFdwvOQKuTPTI6UV/412k
	sBsfegqFODbBruujhP8ZqQ1u4LFmP7rDco9GL/KLl1JEU0YzC4M2mcn1hqKpggakkR89OQ
	pbEdpLj7LXvcZsVTNktZxLrVINzIbB0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-uZOlekq8MOKZPh91CrH7SQ-1; Tue,
 08 Jul 2025 08:56:28 -0400
X-MC-Unique: uZOlekq8MOKZPh91CrH7SQ-1
X-Mimecast-MFC-AGG-ID: uZOlekq8MOKZPh91CrH7SQ_1751979387
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7B7218DA5C0;
	Tue,  8 Jul 2025 12:56:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.100])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2CCA18003FC;
	Tue,  8 Jul 2025 12:56:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 384A218000B2; Tue, 08 Jul 2025 14:56:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: linux-efi@vger.kernel.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] efi: add ovmf debug log driver
Date: Tue,  8 Jul 2025 14:56:23 +0200
Message-ID: <20250708125624.734132-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Recent OVMF versions (edk2-stable202508 + newer) can write their debug
log to a memory buffer.  This driver exposes the log content via sysfs
(/sys/firmware/efi/ovmf_debug_log).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/linux/efi.h                   |   2 +
 drivers/firmware/efi/efi.c            |   8 ++
 drivers/firmware/efi/ovmf-debug-log.c | 136 ++++++++++++++++++++++++++
 drivers/firmware/efi/Kconfig          |   8 ++
 drivers/firmware/efi/Makefile         |   1 +
 5 files changed, 155 insertions(+)
 create mode 100644 drivers/firmware/efi/ovmf-debug-log.c

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7d63d1d75f22..a71830608422 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -439,6 +439,7 @@ void efi_native_runtime_setup(void);
 
 /* OVMF protocol GUIDs */
 #define OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID	EFI_GUID(0xc5a010fe, 0x38a7, 0x4531,  0x8a, 0x4a, 0x05, 0x00, 0xd2, 0xfd, 0x16, 0x49)
+#define OVMF_MEMORY_LOG_TABLE_GUID		EFI_GUID(0x95305139, 0xb20f, 0x4723, 0x84, 0x25, 0x62, 0x7c, 0x88, 0x8f, 0xf1, 0x21)
 
 typedef struct {
 	efi_guid_t guid;
@@ -642,6 +643,7 @@ extern struct efi {
 	unsigned long			esrt;			/* ESRT table */
 	unsigned long			tpm_log;		/* TPM2 Event Log table */
 	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
+	unsigned long                   ovmf_debug_log;
 	unsigned long			mokvar_table;		/* MOK variable config table */
 	unsigned long			coco_secret;		/* Confidential computing secret table */
 	unsigned long			unaccepted;		/* Unaccepted memory table */
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index e57bff702b5f..3161f918ce53 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -45,6 +45,7 @@ struct efi __read_mostly efi = {
 	.esrt			= EFI_INVALID_TABLE_ADDR,
 	.tpm_log		= EFI_INVALID_TABLE_ADDR,
 	.tpm_final_log		= EFI_INVALID_TABLE_ADDR,
+	.ovmf_debug_log         = EFI_INVALID_TABLE_ADDR,
 #ifdef CONFIG_LOAD_UEFI_KEYS
 	.mokvar_table		= EFI_INVALID_TABLE_ADDR,
 #endif
@@ -473,6 +474,10 @@ static int __init efisubsys_init(void)
 		platform_device_register_simple("efi_secret", 0, NULL, 0);
 #endif
 
+	if (IS_ENABLED(CONFIG_OVMF_DEBUG_LOG) &&
+	    efi.ovmf_debug_log != EFI_INVALID_TABLE_ADDR)
+		platform_device_register_simple("ovmf_debug_log", 0, NULL, 0);
+
 	return 0;
 
 err_remove_group:
@@ -617,6 +622,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 	{LINUX_EFI_MEMRESERVE_TABLE_GUID,	&mem_reserve,		"MEMRESERVE"	},
 	{LINUX_EFI_INITRD_MEDIA_GUID,		&initrd,		"INITRD"	},
 	{EFI_RT_PROPERTIES_TABLE_GUID,		&rt_prop,		"RTPROP"	},
+#ifdef CONFIG_OVMF_DEBUG_LOG
+	{OVMF_MEMORY_LOG_TABLE_GUID,		&efi.ovmf_debug_log,	"OvmfDebugLog"	},
+#endif
 #ifdef CONFIG_EFI_RCI2_TABLE
 	{DELLEMC_EFI_RCI2_TABLE_GUID,		&rci2_table_phys			},
 #endif
diff --git a/drivers/firmware/efi/ovmf-debug-log.c b/drivers/firmware/efi/ovmf-debug-log.c
new file mode 100644
index 000000000000..d4fec178fa9f
--- /dev/null
+++ b/drivers/firmware/efi/ovmf-debug-log.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
+
+#define OVMF_DEBUG_LOG_MAGIC1  0x3167646d666d766f  // "ovmfmdg1"
+#define OVMF_DEBUG_LOG_MAGIC2  0x3267646d666d766f  // "ovmfmdg2"
+
+struct ovmf_debug_log_header {
+	u64    magic1;
+	u64    magic2;
+	u64    hdr_size;
+	u64    log_size;
+	u64    lock; // edk2 spinlock
+	u64    head_off;
+	u64    tail_off;
+	u64    truncated;
+	u8     fw_version[128];
+};
+
+static struct ovmf_debug_log_header *hdr;
+static u8 *logbuf;
+static u64 logbufsize;
+
+static ssize_t ovmf_log_read(struct file *filp, struct kobject *kobj,
+			     const struct bin_attribute *attr, char *buf,
+			     loff_t offset, size_t count)
+{
+	u64 start, end;
+
+	start = hdr->head_off + offset;
+	if (hdr->head_off > hdr->tail_off && start >= hdr->log_size)
+		start -= hdr->log_size;
+
+	end = start + count;
+	if (start > hdr->tail_off) {
+		if (end > hdr->log_size)
+			end = hdr->log_size;
+	} else {
+		if (end > hdr->tail_off)
+			end = hdr->tail_off;
+	}
+
+	if (start > logbufsize || end > logbufsize)
+		return 0;
+	if (start >= end)
+		return 0;
+
+	memcpy(buf, logbuf + start, end - start);
+	return end - start;
+}
+
+static struct bin_attribute ovmf_log_bin_attr = {
+	.attr = {
+		.name = "ovmf_debug_log",
+		.mode = 0444,
+	},
+	.read = ovmf_log_read,
+};
+
+static int ovmf_log_probe(struct platform_device *dev)
+{
+	u64 size;
+	int ret = -EINVAL;
+
+	if (efi.ovmf_debug_log == EFI_INVALID_TABLE_ADDR) {
+		dev_err(&dev->dev, "OVMF debug log: not available\n");
+		return -EINVAL;
+	}
+
+	/* map + verify header */
+	hdr = memremap(efi.ovmf_debug_log, sizeof(*hdr), MEMREMAP_WB);
+	if (!hdr) {
+		dev_err(&dev->dev, "OVMF debug log: header map failed\n");
+		return -EINVAL;
+	}
+
+	if (hdr->magic1 != OVMF_DEBUG_LOG_MAGIC1 ||
+	    hdr->magic2 != OVMF_DEBUG_LOG_MAGIC2) {
+		dev_err(&dev->dev, "OVMF debug log: magic mismatch\n");
+		goto err_unmap;
+	}
+
+	size = hdr->hdr_size + hdr->log_size;
+	dev_info(&dev->dev, "firmware version: \"%s\"\n", hdr->fw_version);
+	dev_info(&dev->dev, "log buffer size: %lluk\n", size / 1024);
+
+	/* map complete log buffer */
+	memunmap(hdr);
+	hdr = memremap(efi.ovmf_debug_log, size, MEMREMAP_WB);
+	if (!hdr) {
+		dev_err(&dev->dev, "OVMF debug log: buffer map failed\n");
+		return -EINVAL;
+	}
+	logbuf = (void *)hdr + hdr->hdr_size;
+	logbufsize = hdr->log_size;
+
+	ovmf_log_bin_attr.size = size;
+	ret = sysfs_create_bin_file(efi_kobj, &ovmf_log_bin_attr);
+	if (ret != 0) {
+		dev_err(&dev->dev, "OVMF debug log: sysfs register failed\n");
+		goto err_unmap;
+	}
+
+	return 0;
+
+err_unmap:
+	memunmap(hdr);
+	return ret;
+}
+
+static void ovmf_log_remove(struct platform_device *dev)
+{
+	memunmap(hdr);
+}
+
+static struct platform_driver ovmf_log_driver = {
+	.probe = ovmf_log_probe,
+	.remove = ovmf_log_remove,
+	.driver = {
+		.name = "ovmf_debug_log",
+	},
+};
+
+module_platform_driver(ovmf_log_driver);
+
+MODULE_DESCRIPTION("OVMF debug log");
+MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ovmf_debug_log");
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index db8c5c03d3a2..ac0a03ec3452 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -263,6 +263,14 @@ config EFI_COCO_SECRET
 	  virt/coco/efi_secret module to access the secrets, which in turn
 	  allows userspace programs to access the injected secrets.
 
+config OVMF_DEBUG_LOG
+	tristate "Expose OVMF firmware debug log via sysfs"
+	depends on EFI
+	help
+	  Recent OVMF versions (edk2-stable202508 + newer) can write
+	  their debug log to a memory buffer.  This driver exposes the
+	  log content via sysfs (/sys/firmware/efi/ovmf_debug_log).
+
 config UNACCEPTED_MEMORY
 	bool
 	depends on EFI_STUB
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index a2d0009560d0..8efbcf699e4f 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
 obj-$(CONFIG_EFI_RCI2_TABLE)		+= rci2-table.o
 obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)	+= embedded-firmware.o
 obj-$(CONFIG_LOAD_UEFI_KEYS)		+= mokvar-table.o
+obj-$(CONFIG_OVMF_DEBUG_LOG)		+= ovmf-debug-log.o
 
 obj-$(CONFIG_SYSFB)			+= sysfb_efi.o
 
-- 
2.50.0


