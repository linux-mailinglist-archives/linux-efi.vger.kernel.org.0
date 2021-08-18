Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A94A3EF717
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 02:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbhHRA5u (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 20:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbhHRA5t (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 20:57:49 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9491C061764;
        Tue, 17 Aug 2021 17:57:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z2so947988lft.1;
        Tue, 17 Aug 2021 17:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jb8ONuZrLSTX5nrNt5iZbaPVBcdEQEKZDB8VnBowyRQ=;
        b=fEby/6An7FHD0Mmy6Kb78PCT9cdYLrmqaT67k1qevHu6EwTOmtPmps7blJtVpFOBbM
         nqdFi1kyaCyOEuPt6Ah8W/D+5aQEfNZaOP/EvPePyyEx2F6cWPrfqQF9LmFtTKtxvi6h
         v49Q0zth4aW64B03QFb7kcO2lZzKRcqfBiYxU8dPp5pqpOFB+QJhTY78YxPvqLJ5M0Ay
         +jHKNFgQkf+tFFsUdZudos9vNwRC7t3aU+nugH53qrMqUVJx1hk5kA3hjT+OTIApzoQH
         vb2rLBIAQHIvHmOaUGNvldioovL+ctv/bp5CxBD4wKxSpOBTo0Qo8qfbBDhQi2s8zev9
         ZGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jb8ONuZrLSTX5nrNt5iZbaPVBcdEQEKZDB8VnBowyRQ=;
        b=bqJbKcwsf3Yji+fGvBS0lEE+SsyGdjpM66Ix2FTvuLcZlqd+eflfi1PAsBj90gBl4G
         cceK2YPFnqADc4tCYqdDRXwXTjwHBS91RmeIIvEODTWSHC8N033vrsv8E7GJAjqEZpV/
         GXp9n/DeFxqO6HqloUJ9mXVkI6ATO+fMll4XhHhU4XFVkhT4ln9KzygU7FZpSRFDXIUL
         gxCjEBPLYc+7Lmn1gkZ1zDcZd1QdX82VuEUP9D7/iJ5JuXY3Eo8vVusAXpjzNEEsoLgu
         E/kDk9o2fhHG4sz8w+fVbqI6mZFoI7XmLQO4wNjt6HPu687phncHBS2tLIbnjRodZ9Go
         6OpA==
X-Gm-Message-State: AOAM531muNJQrZCS08h7ADO/iDuObsdwtPFP229M4w5xhPiGfszo3rEZ
        u2UcMO+AU8/ONj+WswJdLCA=
X-Google-Smtp-Source: ABdhPJynee7m2Gi3rS6YccjCsxhmk9gdk3eIOqSz+KU7xgorcTAVU8K1ZJUUmgelnOh3cEgFMx1E6A==
X-Received: by 2002:ac2:4c2a:: with SMTP id u10mr4435697lfq.631.1629248234298;
        Tue, 17 Aug 2021 17:57:14 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id h19sm335879lfu.138.2021.08.17.17.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 17:57:14 -0700 (PDT)
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
Subject: [PATCH v5 4/5] mmc: sdhci-tegra: Implement alternative_gpt_sector()
Date:   Wed, 18 Aug 2021 03:55:46 +0300
Message-Id: <20210818005547.14497-5-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818005547.14497-1-digetx@gmail.com>
References: <20210818005547.14497-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Tegra20/30/114/124 Android devices place GPT at a non-standard location.
Implement alternative_gpt_sector() callback of the MMC host ops which
specifies that GPT location for the partition scanner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/host/sdhci-tegra.c | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 387ce9cdbd7c..24a713689d5b 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -116,6 +116,8 @@
  */
 #define NVQUIRK_HAS_TMCLK				BIT(10)
 
+#define NVQUIRK_HAS_ANDROID_GPT_SECTOR			BIT(11)
+
 /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
 #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
 
@@ -1361,6 +1363,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra20 = {
 	.pdata = &sdhci_tegra20_pdata,
 	.dma_mask = DMA_BIT_MASK(32),
 	.nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
+		    NVQUIRK_HAS_ANDROID_GPT_SECTOR |
 		    NVQUIRK_ENABLE_BLOCK_GAP_DET,
 };
 
@@ -1390,6 +1393,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
 	.nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_HAS_ANDROID_GPT_SECTOR |
 		    NVQUIRK_HAS_PADCALIB,
 };
 
@@ -1422,6 +1426,7 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
 static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
 	.pdata = &sdhci_tegra114_pdata,
 	.dma_mask = DMA_BIT_MASK(32),
+	.nvquirks = NVQUIRK_HAS_ANDROID_GPT_SECTOR,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
@@ -1438,6 +1443,7 @@ static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
 static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
 	.pdata = &sdhci_tegra124_pdata,
 	.dma_mask = DMA_BIT_MASK(34),
+	.nvquirks = NVQUIRK_HAS_ANDROID_GPT_SECTOR,
 };
 
 static const struct sdhci_ops tegra210_sdhci_ops = {
@@ -1590,6 +1596,38 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
 	return ret;
 }
 
+static int sdhci_tegra_alternative_gpt_sector(struct mmc_card *card,
+					      sector_t *gpt_sector)
+{
+	unsigned int boot_sectors_num;
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
+
 static int sdhci_tegra_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -1616,6 +1654,10 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	tegra_host->pad_control_available = false;
 	tegra_host->soc_data = soc_data;
 
+	if (soc_data->nvquirks & NVQUIRK_HAS_ANDROID_GPT_SECTOR)
+		host->mmc_host_ops.alternative_gpt_sector =
+				sdhci_tegra_alternative_gpt_sector;
+
 	if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL) {
 		rc = tegra_sdhci_init_pinctrl_info(&pdev->dev, tegra_host);
 		if (rc == 0)
-- 
2.32.0

