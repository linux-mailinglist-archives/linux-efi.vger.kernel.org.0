Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A777A3DC7B9
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jul 2021 20:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhGaSiO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 31 Jul 2021 14:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGaSiG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 31 Jul 2021 14:38:06 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33772C0613CF;
        Sat, 31 Jul 2021 11:38:00 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h9so17790185ljq.8;
        Sat, 31 Jul 2021 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Z2xj19fFZR3UM1wJkaYc818wokD+RUP2G9IQhb3Eq4=;
        b=pscp1bruxRnJ3da8+Gj0e+PjHKiRCC1Ih+Kk7ikF1gKeXFMWfqWfoUuM6+hzabgfNv
         ncrxVX1AX4DjIZ64qvyPAU3GdHZAehz4IOg9QbmO1u6JlTOPohXZQ+dK1m1j++gJ9xeT
         iUmEMKPmjjf4c7Wf2B7u/IfEDtAXIKgWDdQowcfGZ8LteXQfBbLc1h+4Zl4QmaL/5vUD
         Z1pKGjo3BgR7WeTH49LUUP2yQub1g3ji19lqU2Lp9DSA3x409O+lWxStRzfAM4KLNos8
         ADQ7I2z7hhCZRU7PH/DlMkkaC9szvKZu1esZKzeTVVdWJHrlWRkVpPdM+UFSHyt8J5PS
         OHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Z2xj19fFZR3UM1wJkaYc818wokD+RUP2G9IQhb3Eq4=;
        b=g/AzF+uweRuokZ5vqW2c29fz/JmzxmrOBCYarqQeCkgU+36kOnZ/SUwC5tpsqkWjRs
         onC+7iyeVOrlC2gc5SWec6btiRUxw/xOhXwlFNB2y0bExdqBNwk3AWOQEF9Z443EQqP6
         fzNZkZAaietNQmB5k/owcqBjVr99fATFyU89gC2DswUcpuujKd3i0hILMgkuWo/ODwi4
         ru/30Hc20J6cU9CiH4lcBNPNUrIsrHEts1jskcrKZbeoyaN0CtEJjoS5OwEJbvjIgxIk
         lxc6hhA96dqP4iCbpwf0z+viOKsqf1onpmSRvpDlBteBTILTxCwG84eBDyBpS/AUuRrt
         pnQQ==
X-Gm-Message-State: AOAM532fcmSoijTAveKST2bZjnHXOvkU3lLhMU9pSMwQwUrOiFeX1rkw
        0YyiYA/Jknk2FwFc2qxQsxY=
X-Google-Smtp-Source: ABdhPJxUX0sOEbQbnh1tvY+COPwZm93m8vu4aSaOdFEXxq0nz7kFdp2Y31XetFhwCWD9Z4nFd5Upbg==
X-Received: by 2002:a2e:7e05:: with SMTP id z5mr5927813ljc.342.1627756678600;
        Sat, 31 Jul 2021 11:37:58 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id s7sm456396lfg.297.2021.07.31.11.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 11:37:58 -0700 (PDT)
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
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v2 3/3] partitions/efi: Support NVIDIA Tegra devices
Date:   Sat, 31 Jul 2021 21:36:26 +0300
Message-Id: <20210731183626.18568-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731183626.18568-1-digetx@gmail.com>
References: <20210731183626.18568-1-digetx@gmail.com>
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
 block/partitions/Kconfig  |  8 ++++
 block/partitions/Makefile |  1 +
 block/partitions/check.h  |  2 +
 block/partitions/core.c   |  3 ++
 block/partitions/efi.c    | 18 ++++++++
 block/partitions/tegra.c  | 86 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 118 insertions(+)
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
index fb3a556cacce..2fb6db3134ee 100644
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
index e2716792ecc1..dced55c0d2e1 100644
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
index 000000000000..d8801a885a62
--- /dev/null
+++ b/block/partitions/tegra.c
@@ -0,0 +1,86 @@
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
+	/*
+	 * The fixed GPT entry address is calculated like this:
+	 *
+	 * gpt_sector = ext_csd.sectors_num - ext_csd.boot_sectors_num - 1
+	 *
+	 * This algorithm is defined by NVIDIA and used by Android devices.
+	 */
+	state->force_gpt_sector  = get_capacity(state->bdev->bd_disk);
+	state->force_gpt_sector -= boot_offset + 1;
+
+	ret = efi_partition(state);
+	state->force_gpt_sector = 0;
+
+	return ret;
+}
-- 
2.32.0

