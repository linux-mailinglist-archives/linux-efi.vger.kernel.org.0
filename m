Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003793F0E08
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 00:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhHRWUU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 18:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbhHRWUU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 18:20:20 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA883C0613CF;
        Wed, 18 Aug 2021 15:19:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s3so7816307ljp.11;
        Wed, 18 Aug 2021 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTMAdBrsvzeZ0XhMt9UfvK9bMaYh6LsNsjbXOlJB+Ig=;
        b=NntM3vLdzCxMrLF7C+hI26B8faT8xvNVL11KAi4biul8CG5JMNniayaW336AcEqaoY
         4tnU6YvdnxrAHXWI+5F9rigc5dKY7U8pbxwk0lf0FRh3Koj8bQY0wJK6/4pXJCXDoJw/
         8utjv9KF3jUwtjeXsY8UQzT6q5A92i5UTn+Ipy4Jah3rbWidPQNGNAscJlJpY+2IAmcx
         bW+WKVTlancG6gq7a9/P2u3SlHhCywKl8CmHOEDgGCjk+oaPwHiMixpuk5F0XO2B+lhc
         fXMieor1hHq5GRwwsdrZIIjbL5THHwB11yosn/NoBfv9dDGDvSa4hGHxP/IZEuw0+uRP
         P+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTMAdBrsvzeZ0XhMt9UfvK9bMaYh6LsNsjbXOlJB+Ig=;
        b=mGv3WX0qzy08awItdC/o8C+LdGtePiy5dIHgr/Y8jopOjUlYQqlZB3JXliu+JGLU+m
         QTsoN7YJNQQAZZEtb6jvakPDdu8v9MqzwFQEpUw3mQpVTFb8mgTMfUUNiQVLoY6DdeUc
         ON3+s7jXGgfukYh9FdN1pjycWqOsm1PmqdKH6wGtWUeGNSnRtZ67VoTOiHRWa6NH71qz
         qc5BvDamWazucn3xzGcgZOj1REuwDxjiikcXULz0yQuGwdpaUXhwy9VXcpm/fEKPp/EY
         AiTkV6PytsXqg+X8oPdNpUKvgOgQfDSecVvQScBp5yoGVKiw0ptqf7FY0f/qAfri4Hnx
         jw/Q==
X-Gm-Message-State: AOAM5326Ho6XN77rZW3HI76fnEtuajGKf0JR1csxlkbR8VCF9WHLkWeo
        tnvdoM5q1/Ou+DZ2lJSwo1A=
X-Google-Smtp-Source: ABdhPJymNdEVPfjksCygr2UStMVzSzB3PbF21BxGtLXEWM25oXisKQIrDSOhP4y9EBNoP92BBQ4PrA==
X-Received: by 2002:a2e:a785:: with SMTP id c5mr9499854ljf.434.1629325183279;
        Wed, 18 Aug 2021 15:19:43 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id v23sm93300lfr.208.2021.08.18.15.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 15:19:42 -0700 (PDT)
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
Subject: [PATCH v6 4/5] mmc: block: Support alternative_gpt_sector() operation
Date:   Thu, 19 Aug 2021 01:19:19 +0300
Message-Id: <20210818221920.3893-5-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818221920.3893-1-digetx@gmail.com>
References: <20210818221920.3893-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Support generic alternative_gpt_sector() block device operation which
calculates custom GPT location. Add new MMC_CAP2_ALTERNATIVE_GPT_SECTOR
flag that enables scanning of the alternative sector.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/block.c | 21 +++++++++++++++++++++
 drivers/mmc/core/core.c  | 35 +++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h  |  2 ++
 include/linux/mmc/host.h |  1 +
 4 files changed, 59 insertions(+)

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
index 6249c83d616f..c5cdd56051cb 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2150,6 +2150,41 @@ int mmc_detect_card_removed(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_detect_card_removed);
 
+int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
+{
+	unsigned int boot_sectors_num;
+
+	if ((!(card->host->caps2 & MMC_CAP2_ALT_GPT_SECTOR)))
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
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0abd47e9ef9b..73a4cc063bb0 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -398,6 +398,7 @@ struct mmc_host {
 #else
 #define MMC_CAP2_CRYPTO		0
 #endif
+#define MMC_CAP2_ALT_GPT_SECTOR	(1 << 28)	/* Host with eMMC card that has GPT entry at a non-standard location */
 
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
 
-- 
2.32.0

