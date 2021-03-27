Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE85C34B97A
	for <lists+linux-efi@lfdr.de>; Sat, 27 Mar 2021 22:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhC0VXs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Mar 2021 17:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhC0VX2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Mar 2021 17:23:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70D4C0613B1;
        Sat, 27 Mar 2021 14:23:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q29so12785591lfb.4;
        Sat, 27 Mar 2021 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=53SGraBL7FXNKozE0lKFGp0fguTnmST9yHQfYjxpKXQ=;
        b=CHQieGLjBiING3mc7CQI4FtZ7Xmd9Bl0rTRpfU6GfAEHwH9PwXsx9eD5Yod8639I4l
         S0PeT9vVdarsBD5eSC2BW6GDzZTVXgjISvoFwyMJv8EHgnoSOgnMUb+LJlxOFZCbuvbr
         yt7jU116Y1kgeiyONS09gSfgJYdvJYMD4Meob3wT9Zpqg+0fcwDs2kOVXdRchMwTVBnr
         4hiAs8kt7CCktGQC97gc/g4g3SCVbzhpDbzz3gjmMd24uLJy/4LwIQQ5ASM0IFvoIMAL
         aDGgx7c+BCUCcqMqQ91gdClr/pq1wJuRIoFTzddTm5/yU/Lj9FMN+0ppWp7i2paphT/9
         Kyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=53SGraBL7FXNKozE0lKFGp0fguTnmST9yHQfYjxpKXQ=;
        b=kSgQOcV7wJD2DMA1QfPvOGVz9Z5uD77JuDJ4SdGzk5zQRj/VJJtfOcZLG+PexEwi0c
         VtQGqL7jfL4XPZ/S5afcbJDUHJTj7gRGXbE5BvV39t2kLe3Tj+vEoqdl4QSC3WE8w4Bb
         XfZ/YdWxOw+4gQp9bg/Rzozzijbqy7EpOThquaiBPiA1EQvHJp+EsJL538WdzPgg4kMq
         k6BCK1LECukEOG3RAlXXLscx9YWv/8VkvSWQxMZL8Zv32fRz4c0fY46aq/uGNt+a/s/t
         Z2SnCXdumgJd9KO1eFjVo0KGBDseWlVdsMEpiSE36oFOBsQJQL0xxBN78blspU8nwhnA
         BeCg==
X-Gm-Message-State: AOAM531JJgL49sdmoZan63GTWsd8eJ9649ow1QCuAvZJY1vfJMyTqgpy
        dTuC5OUhGJdu9XlpWW6YGG0=
X-Google-Smtp-Source: ABdhPJzkxz1Azw2sFeuCW110BiLD2JkdgKC6kfZhjqI19A4D8tesDlXOGA9LK7LUlEjKTU/1tzuMUA==
X-Received: by 2002:a19:f608:: with SMTP id x8mr11928849lfe.380.1616880206130;
        Sat, 27 Mar 2021 14:23:26 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-66.dynamic.spd-mgts.ru. [109.252.193.66])
        by smtp.gmail.com with ESMTPSA id x7sm1300626lfe.182.2021.03.27.14.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 14:23:25 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v1 3/3] partitions/efi: Support gpt_sector parameter needed by NVIDIA Tegra devices
Date:   Sun, 28 Mar 2021 00:21:00 +0300
Message-Id: <20210327212100.3834-4-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210327212100.3834-1-digetx@gmail.com>
References: <20210327212100.3834-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

All NVIDIA Tegra20..124 Android devices use proprietary bootloader
which supplies the gpt_sector=<sector> kernel cmdline parameter that
should be used for looking up the EFI partition table on internal EMMC
storage.  If the kernel cmdline parameter isn't supplied, then the
partition is expected to be placed around the last but one sector of EMMC.

Apparently this was done in order to hide the PT from a usual userspace
tools since EFI entry exists only for compatibility with a Linux kernel,
while a custom proprietary partition table is what is really used by
these Android devices, thus these tools may corrupt the real PT, making
device unbootable and very difficult to restore.

Add support for the gpt_sector cmdline parameter which will be used
for finding EFI entry on internal EMMC storage of NVIDIA Tegra20+ devices.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 block/partitions/Kconfig  |   8 +++
 block/partitions/Makefile |   1 +
 block/partitions/check.h  |   2 +
 block/partitions/core.c   |   3 ++
 block/partitions/efi.c    |  18 +++++++
 block/partitions/tegra.c  | 108 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 140 insertions(+)
 create mode 100644 block/partitions/tegra.c

diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
index 6e2a649669e5..be086916c6a6 100644
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
+	depends on EFI_PARTITION && MMC_BLOCK && (ARCH_TEGRA || COMPILE_TEST)
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
index c577e9ee67f0..5fcc85087465 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -22,6 +22,7 @@ struct parsed_partitions {
 	int limit;
 	bool access_beyond_eod;
 	char *pp_buf;
+	sector_t force_gpt_sector;
 };
 
 typedef struct {
@@ -67,4 +68,5 @@ int osf_partition(struct parsed_partitions *state);
 int sgi_partition(struct parsed_partitions *state);
 int sun_partition(struct parsed_partitions *state);
 int sysv68_partition(struct parsed_partitions *state);
+int tegra_partition_forced_gpt(struct parsed_partitions *state);
 int ultrix_partition(struct parsed_partitions *state);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 1a7558917c47..1a0247f3354c 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -82,6 +82,9 @@ static int (*check_part[])(struct parsed_partitions *) = {
 #endif
 #ifdef CONFIG_SYSV68_PARTITION
 	sysv68_partition,
+#endif
+#ifdef CONFIG_TEGRA_PARTITION
+	tegra_partition_forced_gpt,
 #endif
 	NULL
 };
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index b64bfdd4326c..f016a7f11239 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -98,6 +98,15 @@ static int force_gpt;
 static int __init
 force_gpt_fn(char *str)
 {
+	/*
+	 * This check allows to properly parse cmdline variants like
+	 * "gpt gpt_sector=<sector>" and "gpt_sector=<sector> gpt" since
+	 * "gpt" overlaps with the "gpt_sector=", see tegra_gpt_sector_fn().
+	 * The argument is absent for a boolean cmdline option.
+	 */
+	if (strlen(str))
+		return 0;
+
 	force_gpt = 1;
 	return 1;
 }
@@ -621,6 +630,15 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
         if (!good_agpt && force_gpt)
                 good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
 
+	/*
+	 * The force_gpt_sector is used by NVIDIA Tegra partition parser in
+	 * order to convey a non-standard location of the GPT entry for lookup.
+	 * By default force_gpt_sector is set to 0 and has no effect.
+	 */
+	if (!good_agpt && force_gpt && state->force_gpt_sector)
+		good_agpt = is_gpt_valid(state, state->force_gpt_sector,
+					 &agpt, &aptes);
+
         /* The obviously unsuccessful case */
         if (!good_pgpt && !good_agpt)
                 goto fail;
diff --git a/block/partitions/tegra.c b/block/partitions/tegra.c
new file mode 100644
index 000000000000..585a2778ecc4
--- /dev/null
+++ b/block/partitions/tegra.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "tegra-partition: " fmt
+
+#include <linux/blkdev.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/sizes.h>
+
+#include <linux/mmc/blkdev.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+
+#include <soc/tegra/common.h>
+
+#include "check.h"
+
+#define TEGRA_PT_ERR(_state, fmt, ...)					\
+	pr_debug("%s: " fmt,						\
+		 (_state)->bdev->bd_disk->disk_name, ##__VA_ARGS__)
+
+static const struct of_device_id tegra_sdhci_match[] = {
+	{ .compatible = "nvidia,tegra20-sdhci", },
+	{ .compatible = "nvidia,tegra30-sdhci", },
+	{ .compatible = "nvidia,tegra114-sdhci", },
+	{ .compatible = "nvidia,tegra124-sdhci", },
+	{}
+};
+
+static int
+tegra_partition_table_emmc_boot_offset(struct parsed_partitions *state)
+{
+	struct mmc_card *card = mmc_bdev_to_card(state->bdev);
+
+	/* filter out unrelated and untested boot sources */
+	if (!card || card->ext_csd.rev < 3 ||
+	    !mmc_card_is_blockaddr(card) ||
+	     mmc_card_is_removable(card->host) ||
+	     bdev_logical_block_size(state->bdev) != SZ_512 ||
+	    !of_match_node(tegra_sdhci_match, card->host->parent->of_node)) {
+		TEGRA_PT_ERR(state, "unexpected boot source\n");
+		return -1;
+	}
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
+ * This allows a kernel command line option 'gpt_sector=<sector>' to
+ * enable GPT header lookup at a non-standard location. This option
+ * is provided to kernel by NVIDIA's proprietary bootloader.
+ */
+static sector_t tegra_gpt_sector;
+static int __init tegra_gpt_sector_fn(char *str)
+{
+	WARN_ON(kstrtoull(str, 10, &tegra_gpt_sector) < 0);
+	return 1;
+}
+__setup("gpt_sector=", tegra_gpt_sector_fn);
+
+int tegra_partition_forced_gpt(struct parsed_partitions *state)
+{
+	int ret, boot_offset;
+
+	if (!soc_is_tegra())
+		return 0;
+
+	boot_offset = tegra_partition_table_emmc_boot_offset(state);
+	if (boot_offset < 0)
+		return 0;
+
+	if (tegra_gpt_sector) {
+		state->force_gpt_sector = tegra_gpt_sector;
+	} else {
+		/*
+		 * Some Tegra devices do not use gpt_sector=<sector> kernel
+		 * command line option.  In this case these devices should
+		 * have a GPT entry at the end of the block device and then
+		 * the GPT entry address is calculated like this:
+		 *
+		 * gpt_sector = ext_csd.sectors_num - ext_csd.boot_sectors_num - 1
+		 *
+		 * This algorithm is defined by NVIDIA and used on Android
+		 * devices.
+		 */
+		state->force_gpt_sector  = get_capacity(state->bdev->bd_disk);
+		state->force_gpt_sector -= boot_offset + 1;
+	}
+
+	ret = efi_partition(state);
+	state->force_gpt_sector = 0;
+
+	return ret;
+}
-- 
2.30.2

