Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C8A3F2434
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 02:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhHTAqZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 20:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbhHTAqY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 20:46:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D54C061575;
        Thu, 19 Aug 2021 17:45:47 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g13so16692249lfj.12;
        Thu, 19 Aug 2021 17:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r6Xh0CujMI9wMD0zQlVtfYsvhBrGImC9gDtwVhc4m3w=;
        b=C7CfrW9P7u0vsLUUds9swaoQiTuJ9ydBZJFoIex1zC7QmMqZx1lQXpP09CGfo963w+
         u7pzjyUOXQfK+9D99QyZ0oV7CfLDbfM3w8zgywMvH3VP0PEM3xgam8uDT0CORjP2/EtJ
         0a9VclTRuNuJXa+8yXKa0xCgjAXbnl6s3H13x34NPpOR4RTlUxVT/thpQv3VCVKx8N7g
         xdDFhpt3AiBa/pyTDG6lWVkV+AoayisPJKDOTFPaDjNAECMKGL0+XPl+HKe1C/TiZTLE
         KOgDvzaoRTnGXnY1PCW9rLZmFV8xT1hjKaX+KvsqF0uptMfLFciy/NApgVCSNVvqcZ45
         gbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6Xh0CujMI9wMD0zQlVtfYsvhBrGImC9gDtwVhc4m3w=;
        b=MeiYrAntLvlva6zy2G8jp+JEyyjgTfMcHGv9lxQkzBto9tpLoQWfeIMwDnBGOxmzRM
         e6ELepsA6L2r6S+7NqVz6n39XK0fpcaIb7UX6sV+3AsRzURFTSOnF03Zwqox9XiwO1VK
         4IOASXpG84hJOxTVlZucyOI9UJ1EdO2aDtVBLqUmifdX6OQ6A/W+IyAg1ibCln6qBLRa
         UdtxLYPpdgyr8vCraI2TQhVAX+U02XEnabDzwKjj4oXIZSap3jmoxtSTbModMjnqSYTu
         Dl9GBUuNnOgzRnLcAzOZ3+8TKmrqdoHRVjAyiXly7/9bje2yeb98fp7EhtObxkUM/pLv
         AuHw==
X-Gm-Message-State: AOAM531nIWs3OArT0O55vpKe0w8lWux36UJY7w73GpzIv8RWAwbyb8/z
        GG+uyGWYIo07s1Je3cEWqJQ=
X-Google-Smtp-Source: ABdhPJzAruM9xyDEqn3TJ1Vt7cdHp8C9dnzmDQP0tshzfjWVR4vCnFIeJdYeaCqPYT1HLNq9b3UVjg==
X-Received: by 2002:a19:6b03:: with SMTP id d3mr12657279lfa.139.1629420346140;
        Thu, 19 Aug 2021 17:45:46 -0700 (PDT)
Received: from localhost.localdomain (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.gmail.com with ESMTPSA id h6sm507244lfu.230.2021.08.19.17.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:45:45 -0700 (PDT)
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
        Rob Herring <robh+dt@kernel.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v7 3/4] mmc: block: Support alternative_gpt_sector() operation
Date:   Fri, 20 Aug 2021 03:45:35 +0300
Message-Id: <20210820004536.15791-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820004536.15791-1-digetx@gmail.com>
References: <20210820004536.15791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Support generic alternative_gpt_sector() block device operation.
It calculates location of GPT entry for eMMC of NVIDIA Tegra Android
devices. Add new MMC_CAP2_ALT_GPT_TEGRA flag that enables scanning of
alternative GPT sector and add raw_boot_mult field to mmc_ext_csd
which allows to get size of the boot partitions that is needed for
the calculation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/block.c | 21 +++++++++++++++++++++
 drivers/mmc/core/core.c  | 35 +++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h  |  2 ++
 drivers/mmc/core/mmc.c   |  2 ++
 include/linux/mmc/card.h |  1 +
 include/linux/mmc/host.h |  1 +
 6 files changed, 62 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 672cc505ce37..edd26164be06 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -801,6 +801,26 @@ static int mmc_blk_compat_ioctl(struct block_device *bdev, fmode_t mode,
 }
 #endif
 
+static int mmc_blk_alternative_gpt_sector(struct gendisk *disk,
+					  sector_t *sector)
+{
+	struct mmc_blk_data *md;
+	int ret;
+
+	md = mmc_blk_get(disk);
+	if (!md)
+		return -EINVAL;
+
+	if (md->queue.card)
+		ret = mmc_card_alternative_gpt_sector(md->queue.card, sector);
+	else
+		ret = -ENODEV;
+
+	mmc_blk_put(md);
+
+	return ret;
+}
+
 static const struct block_device_operations mmc_bdops = {
 	.open			= mmc_blk_open,
 	.release		= mmc_blk_release,
@@ -810,6 +830,7 @@ static const struct block_device_operations mmc_bdops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl		= mmc_blk_compat_ioctl,
 #endif
+	.alternative_gpt_sector	= mmc_blk_alternative_gpt_sector,
 };
 
 static int mmc_blk_part_switch_pre(struct mmc_card *card,
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6249c83d616f..240c5af793dc 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2150,6 +2150,41 @@ int mmc_detect_card_removed(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_detect_card_removed);
 
+int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
+{
+	unsigned int boot_sectors_num;
+
+	if ((!(card->host->caps2 & MMC_CAP2_ALT_GPT_TEGRA)))
+		return -EOPNOTSUPP;
+
+	/* filter out unrelated cards */
+	if (card->ext_csd.rev < 3 ||
+	    !mmc_card_mmc(card) ||
+	    !mmc_card_is_blockaddr(card) ||
+	     mmc_card_is_removable(card->host))
+		return -ENOENT;
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
+	 * Calculate number of sectors occupied by the both boot partitions.
+	 */
+	boot_sectors_num = card->ext_csd.raw_boot_mult * SZ_128K /
+			   SZ_512 * MMC_NUM_BOOT_PARTITION;
+
+	/* Defined by NVIDIA and used by Android devices. */
+	*gpt_sector = card->ext_csd.sectors - boot_sectors_num - 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
+
 void mmc_rescan(struct work_struct *work)
 {
 	struct mmc_host *host =
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 0c4de2030b3f..7931a4f0137d 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -119,6 +119,8 @@ void mmc_release_host(struct mmc_host *host);
 void mmc_get_card(struct mmc_card *card, struct mmc_ctx *ctx);
 void mmc_put_card(struct mmc_card *card, struct mmc_ctx *ctx);
 
+int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *sector);
+
 /**
  *	mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 838726b68ff3..29e58ffae379 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -418,6 +418,8 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT];
 	card->ext_csd.raw_hc_erase_grp_size =
 		ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE];
+	card->ext_csd.raw_boot_mult =
+		ext_csd[EXT_CSD_BOOT_MULT];
 	if (card->ext_csd.rev >= 3) {
 		u8 sa_shift = ext_csd[EXT_CSD_S_A_TIMEOUT];
 		card->ext_csd.part_config = ext_csd[EXT_CSD_PART_CONFIG];
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 74e6c0624d27..37f975875102 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -109,6 +109,7 @@ struct mmc_ext_csd {
 	u8			raw_hc_erase_gap_size;	/* 221 */
 	u8			raw_erase_timeout_mult;	/* 223 */
 	u8			raw_hc_erase_grp_size;	/* 224 */
+	u8			raw_boot_mult;		/* 226 */
 	u8			raw_sec_trim_mult;	/* 229 */
 	u8			raw_sec_erase_mult;	/* 230 */
 	u8			raw_sec_feature_support;/* 231 */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0abd47e9ef9b..78dadf86b38f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -398,6 +398,7 @@ struct mmc_host {
 #else
 #define MMC_CAP2_CRYPTO		0
 #endif
+#define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
 
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
 
-- 
2.32.0

