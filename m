Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3364F3EE3C1
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 03:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbhHQBhi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Aug 2021 21:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbhHQBhi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Aug 2021 21:37:38 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC20C061764;
        Mon, 16 Aug 2021 18:37:05 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h9so30241491ljq.8;
        Mon, 16 Aug 2021 18:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QlON8BMCDUDtLl4Dwj//VdNgR1mbqL1M7bCROFZfcuo=;
        b=kYG/KVNa8B296+/5Tleq7WuByYDAfSnsemaC4zPkQe6mVS2aycoBVxuTs2aoMb1i4q
         A/4AryALJgUJlZhnp8RVX4kevFTgtCtF4YZY9SFOwM69BrphxjGVi+pMFF/sJRdX2a//
         gZkAfxCrpaK7eD2SUDxmhhS8rgnZ8sjyDP1Fi+Zo4KEgRECzjhGBofDMXBPcwJZRuITF
         q8qDUwJ6wgwu9DgkdTvyCQsdPn3pO18sLXze3RpeJmNCHtTtjKcgcBL2oMXa88fNypDr
         nUHIud46TRKf1nP9ncvp51C6DNTrDMlDiPCdSPmL6JAnOJQm0eRB5RwWswDWRSoCn5tr
         odWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QlON8BMCDUDtLl4Dwj//VdNgR1mbqL1M7bCROFZfcuo=;
        b=TonzYZjEicM0Mr5jzeNjlOQ8CIIDUo1lA870mnY1ocUX40muOjdu2R8unyz+e67g0O
         p8AahDld1GkncMSg2w9WSAzGFdZFxCb7fQx7HJG+Ta5NaR723PJoBgtpc+t8glVkhb/R
         pcjSUyInhhJtKr8kdg0buuLBX6tAeD4q+/lJg6wQDkXRksJTdMxfjozc1PgS0r6ugfFL
         7tJ7L+3A/OyjdhCgIuKS9G5KPvRwAJIR/OA1FuDd3l2OwaG56hAo649rgNlxcF8MLfkV
         ITCtI2UikV5IyktJITWWJWW5ZEXYrl1kyiYd5+dK2yasYKb2xN8YuFIpC3K2RfeRViTC
         9uDg==
X-Gm-Message-State: AOAM531xSGhSheUYQwx1dwDG92n/GJFCXm9ifYixQ93pJJPHx9PzV1Da
        cD3/lXn6KtZOZHqm5l4H5Cs=
X-Google-Smtp-Source: ABdhPJyHLvzKbjg8I2G+jgERHfBq2A/5+Ob8HUfLaAcCVl/foTUOCcOSaiEMth4da1X0ubFDMpVl6g==
X-Received: by 2002:a05:651c:33b:: with SMTP id b27mr925838ljp.314.1629164224031;
        Mon, 16 Aug 2021 18:37:04 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id br33sm49699lfb.46.2021.08.16.18.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:37:03 -0700 (PDT)
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
        Davidlohr Bueso <dave@stgolabs.net>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v4 3/3] partitions/efi: Support NVIDIA Tegra devices
Date:   Tue, 17 Aug 2021 04:36:43 +0300
Message-Id: <20210817013643.13061-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817013643.13061-1-digetx@gmail.com>
References: <20210817013643.13061-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

NVIDIA Tegra consumer devices have EMMC storage that has GPT entry at a
non-standard location. Support looking up GPT entry at a special sector
to enable such devices.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 block/partitions/Kconfig  |  8 +++++
 block/partitions/Makefile |  1 +
 block/partitions/check.h  |  2 ++
 block/partitions/core.c   |  3 ++
 block/partitions/efi.c    |  9 +++++
 block/partitions/tegra.c  | 75 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 98 insertions(+)
 create mode 100644 block/partitions/tegra.c

diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
index 278593b8e4e9..5db25e7efbb7 100644
--- a/block/partitions/Kconfig
+++ b/block/partitions/Kconfig
@@ -267,3 +267,11 @@ config CMDLINE_PARTITION
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
index d5b28e309d64..bd4b66443cf4 100644
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
index 9265936df77e..bbfbb1621581 100644
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
index aaa3dc487cb5..4ad151176204 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -619,6 +619,15 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
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
index 000000000000..4937e9f62398
--- /dev/null
+++ b/block/partitions/tegra.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "tegra-partition: " fmt
+
+#include <linux/blkdev.h>
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
+static const struct of_device_id tegra_sdhci_match[] = {
+	{ .compatible = "nvidia,tegra20-sdhci", },
+	{ .compatible = "nvidia,tegra30-sdhci", },
+	{ .compatible = "nvidia,tegra114-sdhci", },
+	{ .compatible = "nvidia,tegra124-sdhci", },
+	{}
+};
+
+int tegra_partition_forced_gpt(struct parsed_partitions *state)
+{
+	struct gendisk *disk = state->disk;
+	struct block_device *bdev = disk->part0;
+	struct mmc_card *card = mmc_bdev_to_card(bdev);
+	int ret, boot_offset;
+
+	if (!soc_is_tegra())
+		return 0;
+
+	/* filter out unrelated and untested boot sources */
+	if (!card || card->ext_csd.rev < 3 ||
+	    !mmc_card_is_blockaddr(card) ||
+	     mmc_card_is_removable(card->host) ||
+	     bdev_logical_block_size(bdev) != SZ_512 ||
+	    !of_match_node(tegra_sdhci_match, card->host->parent->of_node)) {
+		pr_debug("%s: unexpected boot source\n", disk->disk_name);
+		return 0;
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
+	boot_offset = card->ext_csd.raw_boot_mult * SZ_128K /
+		      SZ_512 * MMC_NUM_BOOT_PARTITION;
+
+	/*
+	 * The fixed GPT entry address is calculated like this:
+	 *
+	 * gpt_sector = ext_csd.sectors_num - ext_csd.boot_sectors_num - 1
+	 *
+	 * This algorithm is defined by NVIDIA and used by Android devices.
+	 */
+	state->force_gpt_sector  = get_capacity(disk);
+	state->force_gpt_sector -= boot_offset + 1;
+
+	ret = efi_partition(state);
+	state->force_gpt_sector = 0;
+
+	return ret;
+}
-- 
2.32.0

