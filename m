Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7311D432B
	for <lists+linux-efi@lfdr.de>; Fri, 15 May 2020 03:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgEOBmy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 May 2020 21:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgEOBmx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 May 2020 21:42:53 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A39C061A0C;
        Thu, 14 May 2020 18:42:52 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a4so422548lfh.12;
        Thu, 14 May 2020 18:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SGToYZIO8U3/obGvzcffFr/KOjbT4Cz30vB/ntIZqLk=;
        b=PNJczpcdssfoQ3Lzu+M7bECiDXAOk1my3Do9Wh83LPZ6r/ofgcnqd3WJtQhoQXBsKI
         KxOtZ1XhSjBw6VT3AmHbwmChtm6FuAAbBCnb0CeuHdYeG6Uaq7qjHPu2lLDaAqlBYsP0
         M/Tq8sP2GtAJ5cCUembrHagJ4sj9GSdt6RgaOObfTa/b1G7OAtXZtXQOZ2WNVkF2zVx1
         nD3FJkL0VGgw5Ox3gfEQJvVdJvTeW/Jnse26GyFgz72DeTc0IhehNWw/9TzEsiOYIm8a
         k4dak440J1qQA6EH0+a6/SYa/7jGTHk7yiVSlOkWf11Ozf55pKLQuoPLNWw6PH4nZAXk
         25VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SGToYZIO8U3/obGvzcffFr/KOjbT4Cz30vB/ntIZqLk=;
        b=mQc29VGjBe7mDopDb/46uYZtIzva3UbbEtMJrJ0YwYvre2ZSt5W0gMpeKsKT5Vwdls
         ZzfNPRYGWICjiISKdqRpD3QvW7UKopX8bbTKUjgiA3yPnTzL2HVAU9s0NCUGJ4obXvfs
         hQJkjpBEPoHhng16yjt20OvR8R/ubMSObVW1m6vt7b0ZlMO9Z7NH7X+pjGnVnG7Pv5sM
         5fbqvNOVjM6RBLN2mZ7Iulire3cuYo4cpJCIhmPQdQYiubBL9ug3OTLTjXpad84ypy14
         QcT0/o1fDy+N8d/XDN5enTz2T8BkouS+IAUSWorEYR7Q1k8g7oa5c3Eh9j5hw44moo6t
         x/OA==
X-Gm-Message-State: AOAM532M/FMho62JKHJSiljsaaxTcqaQxUAjcqepTOp704kPUHycn5E7
        RzYNs9RcbNlMujfD3zwStLo=
X-Google-Smtp-Source: ABdhPJy3DI034hMBxV+46OsFnSgzURtCD/HxB0Ka7447ixmY8EHyZpEFX9rxuKEsq6faXrPRPKEk7w==
X-Received: by 2002:a19:6554:: with SMTP id c20mr462823lfj.140.1589506971089;
        Thu, 14 May 2020 18:42:51 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id i1sm309669lja.3.2020.05.14.18.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 18:42:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>,
        =?UTF-8?q?Nils=20=C3=96stlund?= <nils@naltan.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v4 3/6] partitions: Introduce NVIDIA Tegra Partition Table
Date:   Fri, 15 May 2020 04:41:40 +0300
Message-Id: <20200515014143.12984-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200515014143.12984-1-digetx@gmail.com>
References: <20200515014143.12984-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

All NVIDIA Tegra devices use a special partition table format for the
internal storage partitioning. Most of Tegra devices have GPT partition
in addition to TegraPT, but some older Android consumer-grade devices do
not or GPT is placed in a wrong sector, and thus, the TegraPT is needed
in order to support these devices properly by the upstream kernel. This
patch adds support for NVIDIA Tegra Partition Table format that is used
at least by all NVIDIA Tegra20 and Tegra30 devices.

Tested-by: Nils Östlund <nils@naltan.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c   |  54 ++++
 block/partitions/Kconfig      |   8 +
 block/partitions/Makefile     |   1 +
 block/partitions/check.h      |   1 +
 block/partitions/core.c       |   3 +
 block/partitions/tegra.c      | 565 ++++++++++++++++++++++++++++++++++
 include/soc/tegra/bootdata.h  |  46 +++
 include/soc/tegra/common.h    |   9 +
 include/soc/tegra/partition.h |  83 +++++
 9 files changed, 770 insertions(+)
 create mode 100644 block/partitions/tegra.c
 create mode 100644 include/soc/tegra/bootdata.h
 create mode 100644 include/soc/tegra/partition.h

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index c011359bcdb4..da6bcd85398b 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -28,7 +28,9 @@
 
 #include <linux/firmware/trusted_foundations.h>
 
+#include <soc/tegra/bootdata.h>
 #include <soc/tegra/fuse.h>
+#include <soc/tegra/partition.h>
 #include <soc/tegra/pmc.h>
 
 #include <asm/firmware.h>
@@ -62,9 +64,61 @@ u32 tegra_uart_config[3] = {
 	0,
 };
 
+static void __init tegra_boot_config_table_init(void)
+{
+	struct tegra30_boot_config_table __iomem *t30_bct;
+	struct tegra20_boot_config_table __iomem *t20_bct;
+	struct tegra20_boot_info_table   __iomem *t20_bit;
+	u32 iram_end   = TEGRA_IRAM_BASE + TEGRA_IRAM_SIZE;
+	u32 iram_start = TEGRA_IRAM_BASE;
+	u32 pt_addr, pt_size, bct_size;
+
+	t20_bit = IO_ADDRESS(TEGRA_IRAM_BASE);
+
+	if (of_machine_is_compatible("nvidia,tegra20")) {
+		bct_size = sizeof(*t20_bct);
+
+		if (t20_bit->bct_size != bct_size ||
+		    t20_bit->bct_ptr < iram_start ||
+		    t20_bit->bct_ptr > iram_end - bct_size)
+			return;
+
+		t20_bct = IO_ADDRESS(t20_bit->bct_ptr);
+
+		if (t20_bct->boot_data_version != TEGRA_BOOTDATA_VERSION_T20)
+			return;
+
+		pt_addr = t20_bct->partition_table_logical_sector_address;
+		pt_size = t20_bct->partition_table_num_logical_sectors;
+
+	} else if (of_machine_is_compatible("nvidia,tegra30")) {
+		bct_size = sizeof(*t30_bct);
+
+		if (t20_bit->bct_size != bct_size ||
+		    t20_bit->bct_ptr < iram_start ||
+		    t20_bit->bct_ptr > iram_end - bct_size)
+			return;
+
+		t30_bct = IO_ADDRESS(t20_bit->bct_ptr);
+
+		if (t30_bct->boot_data_version != TEGRA_BOOTDATA_VERSION_T30)
+			return;
+
+		pt_addr = t30_bct->partition_table_logical_sector_address;
+		pt_size = t30_bct->partition_table_num_logical_sectors;
+	} else {
+		return;
+	}
+
+	pr_info("%s: BCT found in IRAM\n", __func__);
+
+	tegra_partition_table_setup(pt_addr, pt_size);
+}
+
 static void __init tegra_init_early(void)
 {
 	of_register_trusted_foundations();
+	tegra_boot_config_table_init();
 	tegra_cpu_reset_handler_init();
 	call_firmware_op(l2x0_init);
 }
diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
index 702689a628f0..2c1408cba1a6 100644
--- a/block/partitions/Kconfig
+++ b/block/partitions/Kconfig
@@ -268,3 +268,11 @@ config CMDLINE_PARTITION
 	help
 	  Say Y here if you want to read the partition table from bootargs.
 	  The format for the command line is just like mtdparts.
+
+config TEGRA_PARTITION
+	bool "NVIDIA Tegra Partition support" if PARTITION_ADVANCED
+	default y if ARCH_TEGRA
+	depends on (ARCH_TEGRA && MMC_BLOCK) || COMPILE_TEST
+	help
+	  Say Y here if you would like to be able to read the hard disk
+	  partition table format used by NVIDIA Tegra machines.
diff --git a/block/partitions/Makefile b/block/partitions/Makefile
index a7f05cdb02a8..83cb70c6d08d 100644
--- a/block/partitions/Makefile
+++ b/block/partitions/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_IBM_PARTITION) += ibm.o
 obj-$(CONFIG_EFI_PARTITION) += efi.o
 obj-$(CONFIG_KARMA_PARTITION) += karma.o
 obj-$(CONFIG_SYSV68_PARTITION) += sysv68.o
+obj-$(CONFIG_TEGRA_PARTITION) += tegra.o
diff --git a/block/partitions/check.h b/block/partitions/check.h
index c577e9ee67f0..ffa01cc4b0b0 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -67,4 +67,5 @@ int osf_partition(struct parsed_partitions *state);
 int sgi_partition(struct parsed_partitions *state);
 int sun_partition(struct parsed_partitions *state);
 int sysv68_partition(struct parsed_partitions *state);
+int tegra_partition(struct parsed_partitions *state);
 int ultrix_partition(struct parsed_partitions *state);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 297004fd2264..0b4720372f07 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -81,6 +81,9 @@ static int (*check_part[])(struct parsed_partitions *) = {
 #endif
 #ifdef CONFIG_SYSV68_PARTITION
 	sysv68_partition,
+#endif
+#ifdef CONFIG_TEGRA_PARTITION
+	tegra_partition,
 #endif
 	NULL
 };
diff --git a/block/partitions/tegra.c b/block/partitions/tegra.c
new file mode 100644
index 000000000000..d1b84fff362c
--- /dev/null
+++ b/block/partitions/tegra.c
@@ -0,0 +1,565 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVIDIA Tegra Partition Table
+ *
+ * Copyright (C) 2020 GRATE-DRIVER project
+ * Copyright (C) 2020 Dmitry Osipenko <digetx@gmail.com>
+ *
+ * Credits for the partition table format:
+ *
+ *   Andrey Danin <danindrey@mail.ru>       (Toshiba AC100 TegraPT format)
+ *   Gilles Grandou <gilles@grandou.net>    (Toshiba AC100 TegraPT format)
+ *   Ryan Grachek <ryan@edited.us>          (Google TV "Molly" TegraPT format)
+ *   Stephen Warren <swarren@wwwdotorg.org> (Useful suggestions about eMMC/etc)
+ */
+
+#define pr_fmt(fmt) "tegra-partition: " fmt
+
+#include <linux/blkdev.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include <linux/mmc/blkdev.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+
+#include <soc/tegra/common.h>
+#include <soc/tegra/partition.h>
+
+#include "check.h"
+
+#define TEGRA_PT_SECTOR_SIZE(ptp)	((ptp)->logical_sector_size / SZ_512)
+#define TEGRA_PT_SECTOR(ptp, s)		((s) * TEGRA_PT_SECTOR_SIZE(ptp))
+
+#define TEGRA_PT_HEADER_SIZE						\
+	(sizeof(struct tegra_partition_header_insecure) +		\
+	 sizeof(struct tegra_partition_header_secure))			\
+
+#define TEGRA_PT_MAX_PARTITIONS(ptp)					\
+	(((ptp)->logical_sector_size - TEGRA_PT_HEADER_SIZE) /		\
+	 sizeof(struct tegra_partition))
+
+#define TEGRA_PT_ERR(ptp, fmt, ...)					\
+	pr_debug("%s: " fmt,						\
+		 (ptp)->state->bdev->bd_disk->disk_name, ##__VA_ARGS__)	\
+
+#define TEGRA_PT_PARSE_ERR(ptp, fmt, ...)				\
+	TEGRA_PT_ERR(ptp, "sector %llu: invalid " fmt,			\
+		     (ptp)->sector, ##__VA_ARGS__)
+
+struct tegra_partition_table_parser {
+	struct tegra_partition_table *pt;
+	unsigned int logical_sector_size;
+	struct parsed_partitions *state;
+	bool pt_entry_checked;
+	sector_t sector;
+	int boot_offset;
+	u32 dev_instance;
+	u32 dev_id;
+};
+
+union tegra_partition_table_u {
+	struct tegra_partition_table pt;
+	u8 pt_parts[SZ_4K / SZ_512][SZ_512];
+};
+
+struct tegra_partition_type {
+	unsigned int type;
+	char *name;
+};
+
+static sector_t tegra_pt_logical_sector_address;
+static sector_t tegra_pt_logical_sectors_num;
+
+void tegra_partition_table_setup(unsigned int logical_sector_address,
+				 unsigned int logical_sectors_num)
+{
+	tegra_pt_logical_sector_address = logical_sector_address;
+	tegra_pt_logical_sectors_num    = logical_sectors_num;
+
+	pr_info("initialized to logical sector = %llu sectors_num = %llu\n",
+		tegra_pt_logical_sector_address, tegra_pt_logical_sectors_num);
+}
+
+/*
+ * Some partitions are very sensitive, changing data on them may brick device.
+ *
+ * For more details about partitions see:
+ *
+ *  "https://docs.nvidia.com/jetson/l4t/Tegra Linux Driver Package Development Guide/part_config.html"
+ */
+static const char * const partitions_blacklist[] = {
+	"BCT", "EBT", "EB2", "EKS", "GP1", "GPT", "MBR", "PT",
+};
+
+static bool tegra_partition_name_match(struct tegra_partition *p,
+				       const char *name)
+{
+	return !strncmp(p->partition_name, name, TEGRA_PT_NAME_SIZE);
+}
+
+static bool tegra_partition_skip(struct tegra_partition *p,
+				 struct tegra_partition_table_parser *ptp,
+				 sector_t sector)
+{
+	unsigned int i;
+
+	/* skip eMMC boot partitions */
+	if (sector < ptp->boot_offset)
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(partitions_blacklist); i++) {
+		if (tegra_partition_name_match(p, partitions_blacklist[i]))
+			return true;
+	}
+
+	return false;
+}
+
+static const struct tegra_partition_type tegra_partition_expected_types[] = {
+	{ .type = TEGRA_PT_PART_TYPE_BCT,	.name = "BCT", },
+	{ .type = TEGRA_PT_PART_TYPE_EBT,	.name = "EBT", },
+	{ .type = TEGRA_PT_PART_TYPE_EBT,	.name = "EB2", },
+	{ .type = TEGRA_PT_PART_TYPE_PT,	.name = "PT",  },
+	{ .type = TEGRA_PT_PART_TYPE_GP1,	.name = "GP1", },
+	{ .type = TEGRA_PT_PART_TYPE_GPT,	.name = "GPT", },
+	{ .type = TEGRA_PT_PART_TYPE_GENERIC,	.name = NULL,  },
+};
+
+static int tegra_partition_type_valid(struct tegra_partition_table_parser *ptp,
+				      struct tegra_partition *p)
+{
+	const struct tegra_partition_type *ptype;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tegra_partition_expected_types); i++) {
+		ptype = &tegra_partition_expected_types[i];
+
+		if (ptype->name && !tegra_partition_name_match(p, ptype->name))
+			continue;
+
+		if (p->part_info.partition_type == ptype->type)
+			return 0;
+
+		/*
+		 * Unsure about all possible types, let's emit error and
+		 * allow to continue for now.
+		 */
+		if (!ptype->name)
+			return 1;
+	}
+
+	return -1;
+}
+
+static bool tegra_partition_valid(struct tegra_partition_table_parser *ptp,
+				  struct tegra_partition *p,
+				  struct tegra_partition *prev,
+				  sector_t sector,
+				  sector_t size)
+{
+	struct tegra_partition_info *prev_pi = &prev->part_info;
+	sector_t sect_end = TEGRA_PT_SECTOR(ptp,
+					    prev_pi->logical_sector_address +
+					    prev_pi->logical_sectors_num);
+	char *type, name[2][TEGRA_PT_NAME_SIZE + 1];
+	int err;
+
+	strscpy(name[0], p->partition_name,    sizeof(name[0]));
+	strscpy(name[1], prev->partition_name, sizeof(name[1]));
+
+	/* validate expected partition name/type */
+	err = tegra_partition_type_valid(ptp, p);
+	if (err) {
+		TEGRA_PT_PARSE_ERR(ptp, "partition_type: [%s] partition_type=%u\n",
+				   name[0], p->part_info.partition_type);
+		if (err < 0)
+			return false;
+
+		TEGRA_PT_ERR(ptp, "continuing, please update list of expected types\n");
+	}
+
+	/* validate partition table BCT addresses */
+	if (tegra_partition_name_match(p, "PT")) {
+		if (sector != TEGRA_PT_SECTOR(ptp, tegra_pt_logical_sector_address) &&
+		    size   != TEGRA_PT_SECTOR(ptp, tegra_pt_logical_sectors_num)) {
+			TEGRA_PT_PARSE_ERR(ptp, "PT location: sector=%llu size=%llu\n",
+					   sector, size);
+			return false;
+		}
+
+		if (ptp->pt_entry_checked) {
+			TEGRA_PT_PARSE_ERR(ptp, "(duplicated) PT\n");
+			return false;
+		}
+
+		ptp->pt_entry_checked = true;
+	}
+
+	if (sector + size < sector) {
+		TEGRA_PT_PARSE_ERR(ptp, "size: [%s] integer overflow sector=%llu size=%llu\n",
+				   name[0], sector, size);
+		return false;
+	}
+
+	/* validate allocation_policy=sequential (absolute unsupported) */
+	if (p != prev && sect_end > sector) {
+		TEGRA_PT_PARSE_ERR(ptp, "allocation_policy: [%s] end=%llu [%s] sector=%llu size=%llu\n",
+				   name[1], sect_end, name[0], sector, size);
+		return false;
+	}
+
+	if (ptp->dev_instance != p->mount_info.device_instance) {
+		TEGRA_PT_PARSE_ERR(ptp, "device_instance: [%s] device_instance=%u|%u\n",
+				   name[0], ptp->dev_instance,
+				   p->mount_info.device_instance);
+		return false;
+	}
+
+	if (ptp->dev_id != p->mount_info.device_id) {
+		TEGRA_PT_PARSE_ERR(ptp, "device_id: [%s] device_id=%u|%u\n",
+				   name[0], ptp->dev_id,
+				   p->mount_info.device_id);
+		return false;
+	}
+
+	if (p->partition_id > 127) {
+		TEGRA_PT_PARSE_ERR(ptp, "partition_id: [%s] partition_id=%u\n",
+				   name[0], p->partition_id);
+		return false;
+	}
+
+	sect_end = get_capacity(ptp->state->bdev->bd_disk);
+
+	/* eMMC boot partitions are below ptp->boot_offset */
+	if (sector < ptp->boot_offset) {
+		sect_end += ptp->boot_offset;
+		type = "boot";
+	} else {
+		sector -= ptp->boot_offset;
+		type = "main";
+	}
+
+	/* validate size */
+	if (!size || sector + size > sect_end) {
+		TEGRA_PT_PARSE_ERR(ptp, "size: [%s] %s partition boot_offt=%d end=%llu sector=%llu size=%llu\n",
+				   name[0], type, ptp->boot_offset, sect_end,
+				   sector, size);
+		return false;
+	}
+
+	return true;
+}
+
+static bool tegra_partitions_parsed(struct tegra_partition_table_parser *ptp,
+				    bool check_only)
+{
+	struct parsed_partitions *state = ptp->state;
+	struct tegra_partition_table *pt = ptp->pt;
+	sector_t sector, size;
+	int i, slot = 1;
+
+	ptp->pt_entry_checked = false;
+
+	for (i = 0; i < pt->secure.num_partitions; i++) {
+		struct tegra_partition *p = &pt->partitions[i];
+		struct tegra_partition *prev = &pt->partitions[max(i - 1, 0)];
+		struct tegra_partition_info *pi = &p->part_info;
+
+		if (slot == state->limit && !check_only)
+			break;
+
+		sector = TEGRA_PT_SECTOR(ptp, pi->logical_sector_address);
+		size   = TEGRA_PT_SECTOR(ptp, pi->logical_sectors_num);
+
+		if (check_only &&
+		    !tegra_partition_valid(ptp, p, prev, sector, size))
+			return false;
+
+		if (check_only ||
+		    tegra_partition_skip(p, ptp, sector))
+			continue;
+
+		put_partition(state, slot++, sector - ptp->boot_offset, size);
+	}
+
+	if (check_only && !ptp->pt_entry_checked) {
+		TEGRA_PT_PARSE_ERR(ptp, "PT: table entry not found\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool
+tegra_partition_table_parsed(struct tegra_partition_table_parser *ptp)
+{
+	if (ptp->pt->secure.num_partitions == 0 ||
+	    ptp->pt->secure.num_partitions > TEGRA_PT_MAX_PARTITIONS(ptp)) {
+		TEGRA_PT_PARSE_ERR(ptp, "num_partitions=%u\n",
+				   ptp->pt->secure.num_partitions);
+		return false;
+	}
+
+	return tegra_partitions_parsed(ptp, true) &&
+	       tegra_partitions_parsed(ptp, false);
+}
+
+static int
+tegra_partition_table_insec_hdr_valid(struct tegra_partition_table_parser *ptp)
+{
+	if (ptp->pt->insecure.magic   != TEGRA_PT_MAGIC ||
+	    ptp->pt->insecure.version != TEGRA_PT_VERSION) {
+		TEGRA_PT_PARSE_ERR(ptp, "insecure header: magic=0x%llx ver=0x%x\n",
+				   ptp->pt->insecure.magic,
+				   ptp->pt->insecure.version);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int
+tegra_partition_table_sec_hdr_valid(struct tegra_partition_table_parser *ptp)
+{
+	size_t pt_size = ptp->pt->secure.num_partitions;
+
+	pt_size *= sizeof(ptp->pt->partitions[0]);
+	pt_size += TEGRA_PT_HEADER_SIZE;
+
+	if (ptp->pt->secure.magic   != TEGRA_PT_MAGIC ||
+	    ptp->pt->secure.version != TEGRA_PT_VERSION ||
+	    ptp->pt->secure.length  != ptp->pt->insecure.length ||
+	    ptp->pt->secure.length  < pt_size) {
+		TEGRA_PT_PARSE_ERR(ptp, "secure header: magic=0x%llx ver=0x%x length=%u|%u|%zu\n",
+				   ptp->pt->secure.magic,
+				   ptp->pt->secure.version,
+				   ptp->pt->secure.length,
+				   ptp->pt->insecure.length,
+				   pt_size);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int
+tegra_partition_table_unencrypted(struct tegra_partition_table_parser *ptp)
+{
+	/* AES IV, all zeros if unencrypted */
+	if (ptp->pt->secure.random_data[0] || ptp->pt->secure.random_data[1] ||
+	    ptp->pt->secure.random_data[2] || ptp->pt->secure.random_data[3]) {
+		pr_err_once("encrypted partition table unsupported\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+static int tegra_read_partition_table(struct tegra_partition_table_parser *ptp)
+{
+	union tegra_partition_table_u *ptu = (typeof(ptu))ptp->pt;
+	unsigned int i;
+	Sector sect;
+	void *part;
+
+	for (i = 0; i < ptp->logical_sector_size / SZ_512; i++) {
+		/*
+		 * Partition table takes at maximum 4096 bytes, but
+		 * read_part_sector() guarantees only that SECTOR_SIZE will
+		 * be read at minimum.
+		 */
+		part = read_part_sector(ptp->state, ptp->sector + i, &sect);
+		if (!part) {
+			TEGRA_PT_ERR(ptp, "failed to read sector %llu\n",
+				     ptp->sector + i);
+			return 0;
+		}
+
+		memcpy(ptu->pt_parts[i], part, SZ_512);
+		put_dev_sector(sect);
+	}
+
+	return 1;
+}
+
+static int tegra_partition_scan(struct tegra_partition_table_parser *ptp)
+{
+	sector_t start_sector, num_sectors;
+	int ret = 0;
+
+	num_sectors  = TEGRA_PT_SECTOR(ptp, tegra_pt_logical_sectors_num);
+	start_sector = TEGRA_PT_SECTOR(ptp, tegra_pt_logical_sector_address);
+
+	if (start_sector < ptp->boot_offset) {
+		TEGRA_PT_ERR(ptp,
+			     "scanning eMMC boot partitions unimplemented\n");
+		return 0;
+	}
+
+	ptp->sector = start_sector - ptp->boot_offset;
+
+	/*
+	 * Partition table is duplicated for num_sectors.
+	 * If first table is corrupted, we will try next.
+	 */
+	while (num_sectors--) {
+		ret = tegra_read_partition_table(ptp);
+		if (!ret)
+			goto next_sector;
+
+		ret = tegra_partition_table_insec_hdr_valid(ptp);
+		if (!ret)
+			goto next_sector;
+
+		ret = tegra_partition_table_unencrypted(ptp);
+		if (!ret)
+			goto next_sector;
+
+		ret = tegra_partition_table_sec_hdr_valid(ptp);
+		if (!ret)
+			goto next_sector;
+
+		ret = tegra_partition_table_parsed(ptp);
+		if (ret)
+			break;
+next_sector:
+		ptp->sector += TEGRA_PT_SECTOR_SIZE(ptp);
+	}
+
+	return ret;
+}
+
+static const u32 tegra20_sdhci_bases[TEGRA_PT_SDHCI_DEVICE_INSTANCES] = {
+	0xc8000000, 0xc8000200, 0xc8000400, 0xc8000600,
+};
+
+static const u32 tegra30_sdhci_bases[TEGRA_PT_SDHCI_DEVICE_INSTANCES] = {
+	0x78000000, 0x78000200, 0x78000400, 0x78000600,
+};
+
+static const struct of_device_id tegra_sdhci_match[] = {
+	{ .compatible = "nvidia,tegra20-sdhci", .data = tegra20_sdhci_bases, },
+	{ .compatible = "nvidia,tegra30-sdhci", .data = tegra30_sdhci_bases, },
+	{}
+};
+
+static int
+tegra_partition_table_emmc_boot_offset(struct tegra_partition_table_parser *ptp)
+{
+	struct mmc_card *card = mmc_bdev_to_card(ptp->state->bdev);
+	const struct of_device_id *matched;
+	const u32 *sdhci_bases;
+	u32 sdhci_base;
+	unsigned int i;
+	int err;
+
+	/* filter out unexpected/untested boot sources */
+	if (!card || card->ext_csd.rev < 3 ||
+	    !mmc_card_is_blockaddr(card) ||
+	     mmc_card_is_removable(card->host) ||
+	     bdev_logical_block_size(ptp->state->bdev) != SZ_512)
+		return -1;
+
+	/* skip everything unrelated to Tegra eMMC */
+	matched = of_match_node(tegra_sdhci_match, card->host->parent->of_node);
+	if (!matched)
+		return -1;
+
+	sdhci_bases = matched->data;
+
+	/* figure out SDHCI instance ID by the base address */
+	err = of_property_read_u32_index(card->host->parent->of_node,
+					 "reg", 0, &sdhci_base);
+	if (err)
+		return -1;
+
+	for (i = 0; i < TEGRA_PT_SDHCI_DEVICE_INSTANCES; i++) {
+		if (sdhci_base == sdhci_bases[i])
+			break;
+	}
+
+	if (i == TEGRA_PT_SDHCI_DEVICE_INSTANCES)
+		return -1;
+
+	ptp->dev_id       = TEGRA_PT_SDHCI_DEVICE_ID;
+	ptp->dev_instance = i;
+
+	/*
+	 * eMMC storage has two special boot partitions in addition to the
+	 * main one.  NVIDIA's bootloader linearizes eMMC boot0->boot1->main
+	 * accesses, this means that the partition table addresses are shifted
+	 * by the size of boot partitions.  In accordance with the eMMC
+	 * specification, the boot partition size is calculated as follows:
+	 *
+	 *	boot partition size = 128K byte x BOOT_SIZE_MULT
+	 *
+	 * This function returns number of sectors occupied by the both boot
+	 * partitions.
+	 */
+	return card->ext_csd.raw_boot_mult * SZ_128K /
+	       SZ_512 * MMC_NUM_BOOT_PARTITION;
+}
+
+/*
+ * Logical sector size may vary per device model and apparently there is no
+ * way to get information about the size from kernel. The info is hardcoded
+ * into bootloader and it doesn't tell us, so we'll just try all possible
+ * well-known sizes until succeed.
+ *
+ * For example Samsung Galaxy Tab 10.1 uses 2K sectors. While Acer A500,
+ * Nexus 7 and Ouya are using 4K sectors.
+ */
+static const unsigned int tegra_pt_logical_sector_sizes[] = {
+	SZ_4K, SZ_2K,
+};
+
+/*
+ * The 'tegraboot=<source>' command line option is supplied by NVIDIA
+ * bootloader.
+ */
+static bool tegra_boot_sdmmc;
+static int __init tegra_boot_fn(char *str)
+{
+	tegra_boot_sdmmc = !strcmp(str, "sdmmc");
+	return 1;
+}
+__setup("tegraboot=", tegra_boot_fn);
+
+int tegra_partition(struct parsed_partitions *state)
+{
+	struct tegra_partition_table_parser ptp = {};
+	unsigned int i;
+	int ret;
+
+	if (!soc_is_tegra() || !tegra_boot_sdmmc)
+		return 0;
+
+	ptp.state = state;
+
+	ptp.boot_offset = tegra_partition_table_emmc_boot_offset(&ptp);
+	if (ptp.boot_offset < 0)
+		return 0;
+
+	ptp.pt = kmalloc(SZ_4K, GFP_KERNEL);
+	if (!ptp.pt)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(tegra_pt_logical_sector_sizes); i++) {
+		ptp.logical_sector_size = tegra_pt_logical_sector_sizes[i];
+
+		ret = tegra_partition_scan(&ptp);
+		if (ret == 1) {
+			strlcat(state->pp_buf, "\n", PAGE_SIZE);
+			break;
+		}
+	}
+
+	kfree(ptp.pt);
+
+	return ret;
+}
diff --git a/include/soc/tegra/bootdata.h b/include/soc/tegra/bootdata.h
new file mode 100644
index 000000000000..7be207cb2519
--- /dev/null
+++ b/include/soc/tegra/bootdata.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_TEGRA_BOOTDATA_H__
+#define __SOC_TEGRA_BOOTDATA_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+#define TEGRA_BOOTDATA_VERSION_T20	NVBOOT_BOOTDATA_VERSION(0x2, 0x1)
+#define TEGRA_BOOTDATA_VERSION_T30	NVBOOT_BOOTDATA_VERSION(0x3, 0x1)
+
+#define NVBOOT_BOOTDATA_VERSION(a, b)	((((a) & 0xffff) << 16) | \
+					  ((b) & 0xffff))
+#define NVBOOT_CMAC_AES_HASH_LENGTH	4
+
+struct tegra20_boot_info_table {
+	u32 unused_data1[14];
+	u32 bct_size;
+	u32 bct_ptr;
+} __packed;
+
+struct tegra20_boot_config_table {
+	u32 crypto_hash[NVBOOT_CMAC_AES_HASH_LENGTH];
+	u32 random_aes_blk[NVBOOT_CMAC_AES_HASH_LENGTH];
+	u32 boot_data_version;
+	u32 unused_data1[712];
+	u32 unused_consumer_data1;
+	u16 partition_table_logical_sector_address;
+	u16 partition_table_num_logical_sectors;
+	u32 unused_consumer_data[294];
+	u32 unused_data[3];
+} __packed;
+
+struct tegra30_boot_config_table {
+	u32 crypto_hash[NVBOOT_CMAC_AES_HASH_LENGTH];
+	u32 random_aes_blk[NVBOOT_CMAC_AES_HASH_LENGTH];
+	u32 boot_data_version;
+	u32 unused_data1[1016];
+	u32 unused_consumer_data1;
+	u16 partition_table_logical_sector_address;
+	u16 partition_table_num_logical_sectors;
+	u32 unused_consumer_data[502];
+	u32 unused_data[3];
+} __packed;
+
+#endif /* __SOC_TEGRA_BOOTDATA_H__ */
diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
index 98027a76ce3d..744280ecab5f 100644
--- a/include/soc/tegra/common.h
+++ b/include/soc/tegra/common.h
@@ -6,6 +6,15 @@
 #ifndef __SOC_TEGRA_COMMON_H__
 #define __SOC_TEGRA_COMMON_H__
 
+#include <linux/types.h>
+
+#ifdef CONFIG_ARCH_TEGRA
 bool soc_is_tegra(void);
+#else
+static inline bool soc_is_tegra(void)
+{
+	return false;
+}
+#endif
 
 #endif /* __SOC_TEGRA_COMMON_H__ */
diff --git a/include/soc/tegra/partition.h b/include/soc/tegra/partition.h
new file mode 100644
index 000000000000..4e424543973c
--- /dev/null
+++ b/include/soc/tegra/partition.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_TEGRA_PARTITION_H__
+#define __SOC_TEGRA_PARTITION_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+#define TEGRA_PT_MAGIC				0xffffffff8f9e8d8bULL
+#define TEGRA_PT_VERSION			0x100
+#define TEGRA_PT_AES_HASH_SIZE			4
+#define TEGRA_PT_NAME_SIZE			4
+
+#define TEGRA_PT_SDHCI_DEVICE_ID		18
+#define TEGRA_PT_SDHCI_DEVICE_INSTANCES		4
+
+#define TEGRA_PT_PART_TYPE_BCT			1
+#define TEGRA_PT_PART_TYPE_EBT			2
+#define TEGRA_PT_PART_TYPE_PT			3
+#define TEGRA_PT_PART_TYPE_GENERIC		6
+#define TEGRA_PT_PART_TYPE_GP1			9
+#define TEGRA_PT_PART_TYPE_GPT			10
+
+struct tegra_partition_mount_info {
+	u32 device_id;
+	u32 device_instance;
+	u32 device_attr;
+	u8  mount_path[TEGRA_PT_NAME_SIZE];
+	u32 file_system_type;
+	u32 file_system_attr;
+} __packed;
+
+struct tegra_partition_info {
+	u32 partition_attr;
+	u32 __pad1;
+	u64 logical_sector_address;
+	u64 logical_sectors_num;
+	u64 __pad2[2];
+	u32 partition_type;
+	u32 __pad3;
+} __packed;
+
+struct tegra_partition {
+	u32 partition_id;
+	u8  partition_name[TEGRA_PT_NAME_SIZE];
+	struct tegra_partition_mount_info mount_info;
+	struct tegra_partition_info part_info;
+} __packed;
+
+struct tegra_partition_header_insecure {
+	u64 magic;
+	u32 version;
+	u32 length;
+	u32 signature[TEGRA_PT_AES_HASH_SIZE];
+} __packed;
+
+struct tegra_partition_header_secure {
+	u32 random_data[TEGRA_PT_AES_HASH_SIZE];
+	u64 magic;
+	u32 version;
+	u32 length;
+	u32 num_partitions;
+	u32 __pad;
+} __packed;
+
+struct tegra_partition_table {
+	struct tegra_partition_header_insecure insecure;
+	struct tegra_partition_header_secure secure;
+	struct tegra_partition partitions[];
+} __packed;
+
+#ifdef CONFIG_TEGRA_PARTITION
+void tegra_partition_table_setup(unsigned int logical_sector_address,
+				 unsigned int logical_sectors_num);
+#else
+static inline void
+tegra_partition_table_setup(unsigned int logical_sector_address,
+			    unsigned int logical_sectors_num)
+{
+}
+#endif
+
+#endif /* __SOC_TEGRA_PARTITION_H__ */
-- 
2.26.0

