Return-Path: <linux-efi+bounces-169-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DC680CF31
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 16:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDF21F219CA
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1244AF73;
	Mon, 11 Dec 2023 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VrzXpEEb"
X-Original-To: linux-efi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EC2DF;
	Mon, 11 Dec 2023 07:12:51 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8502AE000E;
	Mon, 11 Dec 2023 15:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702307570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZL+Ok+DrGFVb0w/xL+QP9Tdye38sT6TcArWDXMdC3U=;
	b=VrzXpEEbYkvP/2A4q27Kd2PttMT6x1PwMMvCQt0aKPHdixEI1DtEy0lxzK9ADTPXYkihBh
	6NhoCAEZhnnYnUQjCdL7IOKSJyQFQZqxbIt7DpWRWs4AfdGtAJ2KTKs1LPYtGyKKioiG/L
	n9ffeTZIxeMwyZtllXsm7F+hibLap2VbD3sWlzq0WZleFDFbZO3xw2y6WHQS5PtSl6eYGF
	GbEwrVOMDXggPEI3XQy48Wb3d+xRimJHq7C9LukbJW1ACJWz7dX+m7KJ6xA0IAsUIIktUy
	HCwM+hv3s3lH6hoAW/xzZnTY1ZC8UB0BNAjI1ZDvcTUUzH5i/gpymCk/0/DBrQ==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [RFC PATCH 5/6] drivers: mtd: introduce GPT parser for NOR flash devices
Date: Mon, 11 Dec 2023 16:12:41 +0100
Message-ID: <20231211151244.289349-6-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211151244.289349-1-romain.gantois@bootlin.com>
References: <20231211151244.289349-1-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com

MTD devices can be partitioned using a fixed partitioning scheme defined in
the relevant device tree node. Dynamic partitioning is also possible, using
MTD parsers. They are capable of parsing partition tables on the device at
boot time.

Add support for GPT parsing at the MTD layer. The parser logic makes use of
a common set of GPT helpers and typedefs that have previously been
extracted from the block layer parser.

The main issue with GPT partitioning are the userspace tools which are
already capable of writing a partition table. Not using them would require
re-inventing the wheel, but on the other side they are block-oriented tools
with absolutely no knowledge of the specificities of MTD flashes. Tools
such as parted or fdisk act upon block devices and not mtd devices, so we
need a block abstraction for writing the table. Thus, the only possible
solution so far is the use of mtdblock in-between, which raises two main
concerns: the lack of bad-block handling and wear-leveling. In order to
avoid risky situations, the parser will only parse NORs.

Example usage:

> echo "
device: /dev/mtdblock0
unit: sectors
first-lba: 40
last-lba: 32734
sector-size: 512

start=40, size=8
start=48, size=80
start=128, size=32600
" | sfdisk /dev/mtdblock0

After rebooting:
> lsmtd
DEVICE MAJ:MIN NAME   TYPE SIZE
mtd0    90:0   spi0.0 nor    16M
mtd1    90:2          nor     4K
mtd2    90:4          nor    40K
mtd3    90:6          nor  15.9M

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/mtd/parsers/Kconfig  |  10 ++
 drivers/mtd/parsers/Makefile |   1 +
 drivers/mtd/parsers/gpt.c    | 222 +++++++++++++++++++++++++++++++++++
 3 files changed, 233 insertions(+)
 create mode 100644 drivers/mtd/parsers/gpt.c

diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
index da03ab6efe04..3f34220c6fc3 100644
--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -118,6 +118,16 @@ config MTD_AFS_PARTS
 	  for your particular device. It won't happen automatically. The
 	  'physmap' map driver (CONFIG_MTD_PHYSMAP) does this, for example.
 
+config MTD_GPT_PARTS
+	tristate "GPT partition table parsing"
+	select GENERIC_LIB_GPT
+	help
+	  This allow specifying MTD partitions on a NOR Flash device using
+	  a fixed-location GPT partition table. No wear-leveling is done by
+	  this parser, and it cannot recover from bad blocks in critical GPT
+	  metadata locations. For these reasons, NAND Flash devices cannot
+	  make use of this partition parser.
+
 config MTD_PARSER_TPLINK_SAFELOADER
 	tristate "TP-Link Safeloader partitions parser"
 	depends on MTD && (ARCH_BCM_5301X || ATH79 || SOC_MT7620 || SOC_MT7621 || COMPILE_TEST)
diff --git a/drivers/mtd/parsers/Makefile b/drivers/mtd/parsers/Makefile
index 9b00c62b837a..eb31585f2dd1 100644
--- a/drivers/mtd/parsers/Makefile
+++ b/drivers/mtd/parsers/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_MTD_SERCOMM_PARTS)		+= scpart.o
 obj-$(CONFIG_MTD_SHARPSL_PARTS)		+= sharpslpart.o
 obj-$(CONFIG_MTD_REDBOOT_PARTS)		+= redboot.o
 obj-$(CONFIG_MTD_QCOMSMEM_PARTS)	+= qcomsmempart.o
+obj-$(CONFIG_MTD_GPT_PARTS)		+= gpt.o
diff --git a/drivers/mtd/parsers/gpt.c b/drivers/mtd/parsers/gpt.c
new file mode 100644
index 000000000000..c2fa9545b4b5
--- /dev/null
+++ b/drivers/mtd/parsers/gpt.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MTD parser for GPT partition tables.
+ *
+ * This parser supports GPT partition tables located at fixed standard sectors.
+ * Partitioning a raw flash device in this manner prevents wear-leveling and bad
+ * block handling at the whole-device level. Note that bad blocks on critical
+ * GPT sectors will completely break your partition table! Because of this, use
+ * of this parser is restricted to NOR flash devices, which are less susceptible
+ * to bad blocks than NAND flash devices.
+ *
+ * http://www.uefi.org/specs/
+ *
+ * Acronyms:
+ * PTE: Partition Table Entry
+ * LBA: Logical Block Address
+ *
+ * Copyright © 2023 Bootlin
+ *
+ * Author: Romain Gantois <romain.gantois@bootlin.com>
+ *
+ */
+
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/mtd.h>
+#include <linux/minmax.h>
+#include <linux/kernel.h>
+#include <linux/gpt.h>
+
+/*
+ * We assume that the GPT partition was written through an mtdblock device. This
+ * would make the LBA size 512.
+ */
+#define MTD_GPT_LBA_SIZE 512
+
+/*
+ * This value is pretty much arbitrary, it's in the range of typical MTD parser
+ * caps. Creating too many partitions on a raw Flash device is a bad idea
+ * anyway.
+ */
+#define MTD_GPT_MAX_PARTS 32
+
+#define mtd_gpt_lba_to_offset(x) ((x) * MTD_GPT_LBA_SIZE)
+#define mtd_gpt_lba_to_size(x)   ((size_t)(x) * MTD_GPT_LBA_SIZE)
+
+#define MTD_GPT_PARTNAME_SIZE sizeof(((gpt_entry *)0)->partition_name)
+
+static int mtd_gpt_read_header(struct mtd_info *mtd, gpt_header *gpt, int lba, u64 last_lba)
+{
+	loff_t read_offset = mtd_gpt_lba_to_offset(lba);
+	size_t retlen;
+	int ret;
+
+	dev_dbg(&mtd->dev, "reading GPT header at offset %lli\n", read_offset);
+
+	ret = mtd_read(mtd, read_offset, MTD_GPT_LBA_SIZE, &retlen, (u_char *)gpt);
+	if (ret) {
+		dev_err(&mtd->dev, "failed to read GPT header\n");
+		return -EIO;
+	}
+
+	if (retlen < MTD_GPT_LBA_SIZE) {
+		dev_err(&mtd->dev, "truncated read 0x%zx expected 0x%x\n",
+			retlen, MTD_GPT_LBA_SIZE);
+		return -EIO;
+	}
+
+	return gpt_validate_header(gpt, lba, MTD_GPT_LBA_SIZE, last_lba);
+}
+
+static int mtd_gpt_parse_partitions(struct mtd_info *mtd,
+				    const struct mtd_partition **pparts,
+				    struct mtd_part_parser_data *data)
+{
+	int ret = 0, valid_parts = 0, part_no;
+	u64 last_lba = div_u64(mtd->size, MTD_GPT_LBA_SIZE) - 1ULL;
+	struct mtd_partition *parts, *part;
+	size_t pte_read_size, retlen;
+	char *name_buf, *cur_name;
+	loff_t pte_read_offset;
+	gpt_header *gpt, *agpt;
+	gpt_entry *ptes, *pte;
+	unsigned int nr_parts;
+
+	if (mtd_type_is_nand(mtd)) {
+		/* NAND flash devices are too susceptible to bad blocks */
+		dev_err(&mtd->dev, "GPT parsing is forbidden on NAND devices!");
+		return -EPERM;
+	}
+
+	gpt = kzalloc(MTD_GPT_LBA_SIZE, GFP_KERNEL);
+	if (!gpt)
+		return -ENOMEM;
+
+	agpt = kzalloc(MTD_GPT_LBA_SIZE, GFP_KERNEL);
+	if (!agpt)
+		return -ENOMEM;
+
+	ret = mtd_gpt_read_header(mtd, gpt, GPT_PRIMARY_PARTITION_TABLE_LBA, last_lba);
+	if (ret) {
+		dev_warn(&mtd->dev,
+			 "invalid primary GPT header: error %d, trying alternate", ret);
+		ret = mtd_gpt_read_header(mtd, gpt, le64_to_cpu(gpt->alternate_lba), last_lba);
+		if (ret) {
+			dev_err(&mtd->dev, "invalid alternate GPT header: error %d\n", ret);
+			goto free_gpt;
+		}
+	} else {
+		/* Check alternate header and warn if it doesn't match primary header */
+		gpt_compare_alt(gpt, agpt, last_lba);
+	}
+
+	/* This should contain the PTE array */
+	pte_read_offset = mtd_gpt_lba_to_offset(le64_to_cpu(gpt->partition_entry_lba));
+	pte_read_size = get_pt_size(gpt);
+	ptes = kzalloc(pte_read_size, GFP_KERNEL);
+	if (!ptes) {
+		ret = -ENOMEM;
+		goto free_gpt;
+	}
+
+	dev_dbg(&mtd->dev, "reading PTE array offset %lli size 0x%zx\n",
+		pte_read_offset, pte_read_size);
+
+	ret = mtd_read(mtd, pte_read_offset, pte_read_size, &retlen, (u_char *)ptes);
+	if (ret)
+		goto free_ptes;
+
+	if (retlen < pte_read_size) {
+		ret = -EIO;
+		goto free_ptes;
+	}
+
+	ret = gpt_check_pte_array_crc(gpt, ptes);
+	if (ret) {
+		dev_err(&mtd->dev,
+			"CRC check failed for GPT Partition Table Entry array! error %d\n", ret);
+		goto free_ptes;
+	}
+
+	nr_parts = le32_to_cpu(gpt->num_partition_entries);
+	parts = kcalloc(min(nr_parts, MTD_GPT_MAX_PARTS),
+			sizeof(*parts),
+			GFP_KERNEL);
+	if (!parts) {
+		ret = -ENOMEM;
+		goto free_ptes;
+	}
+
+	name_buf = kcalloc(min(nr_parts, MTD_GPT_MAX_PARTS), (MTD_GPT_PARTNAME_SIZE + 1),
+			   GFP_KERNEL);
+	if (!name_buf) {
+		ret = -ENOMEM;
+		goto free_parts;
+	}
+
+	for (part_no = 0; part_no < nr_parts && valid_parts < MTD_GPT_MAX_PARTS; part_no++) {
+		pte = &ptes[part_no];
+		part = &parts[valid_parts];
+		cur_name = &name_buf[valid_parts * (MTD_GPT_PARTNAME_SIZE + 1)];
+
+		if (!gpt_is_pte_valid(pte, last_lba)) {
+			dev_warn(&mtd->dev, "skipping invalid partition entry %d!\n", part_no);
+			continue;
+		}
+
+		part->offset = mtd_gpt_lba_to_offset(le64_to_cpu(pte->starting_lba));
+		part->size = mtd_gpt_lba_to_size(le64_to_cpu(pte->ending_lba) -
+						 le64_to_cpu(pte->starting_lba) + 1ULL);
+		part->name = cur_name;
+
+		/* part->name is const so we can't pass it directly */
+		utf16_le_to_7bit(pte->partition_name,
+				 MTD_GPT_PARTNAME_SIZE / sizeof(__le16),
+				 cur_name);
+		valid_parts++;
+	}
+
+	if (valid_parts == MTD_GPT_MAX_PARTS)
+		dev_warn(&mtd->dev,
+			 "reached maximum allowed number of MTD partitions %d\n",
+			 MTD_GPT_MAX_PARTS);
+
+	*pparts = parts;
+	kfree(ptes);
+	kfree(gpt);
+	return valid_parts;
+
+free_parts:
+	kfree(parts);
+free_ptes:
+	kfree(ptes);
+free_gpt:
+	kfree(agpt);
+	kfree(gpt);
+
+	return ret;
+}
+
+static void mtd_gpt_cleanup_partitions(const struct mtd_partition *pparts, int nr_parts)
+{
+	kfree(pparts->name);
+	kfree(pparts);
+}
+
+static const struct of_device_id mtd_gpt_of_match_table[] = {
+	{ .compatible = "gpt" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtd_gpt_of_match_table);
+
+static struct mtd_part_parser mtd_gpt_parser = {
+	.parse_fn = mtd_gpt_parse_partitions,
+	.cleanup = mtd_gpt_cleanup_partitions,
+	.name = "GPT",
+	.of_match_table = mtd_gpt_of_match_table,
+};
+module_mtd_part_parser(mtd_gpt_parser);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Romain Gantois <romain.gantois@bootlin.com>");
+MODULE_DESCRIPTION("MTD parser for GPT partition tables");
-- 
2.43.0


