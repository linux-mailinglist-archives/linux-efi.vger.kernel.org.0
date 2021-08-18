Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305953F0E0B
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 00:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhHRWUV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 18:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbhHRWUV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 18:20:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5D2C0613D9;
        Wed, 18 Aug 2021 15:19:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o10so7914138lfr.11;
        Wed, 18 Aug 2021 15:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xtGQgjxMEZMlhC/xeDEiMn9ep1RQCyByheCct7MRol4=;
        b=fqBqV/qWwyuboVt+vWtn58b/iJu8+z3vqWQuC9BB8si+QCQ3xNbWfZQrGBmGzwfNlk
         /zil+y5Svz6VxOIOCS8ZCr+tUNCYDLrRi/efgwwsN97hLg/mD9nAZ/L33DWmtEzEw4MT
         XHVRvEKRgAm1qsuVPbH182NyjXpvJQA9Tl9fw8kwc9gRpX931zIZHhoRMx+utU7Mxu51
         zMiqsdfGmYpBFOdx/3y8Jq4/zcIoSInKWKYYlSKZ9Z9MgMOFEzqv/f8xnzHkigt5uzBe
         15KNwSu8ePKYy6AdfLxkBQ5TZn2solVhnQopukQLaA+io7L0nvGY69CMd3u1iNqFR3+F
         Uf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtGQgjxMEZMlhC/xeDEiMn9ep1RQCyByheCct7MRol4=;
        b=T9Lo/UUwy8//nuislkHzYvYDRjcaycuXA8zQpTPK4vhy0k5Y1r0yB8yefiDZgpb8BK
         8JxSO9T9SSpbKUPLAzCOW1ljAxaYe5ccW1RBWI6vOISeddqYq5aGYzQiim9HIUh06w+3
         77Lt3D5u9C63ICo82pAT2nMxGXClxOM82ObfBlYZl9l4nZWjVLPYB7XaQbwTO10MSMmX
         pRuh+qI75WbtvVo9o0v/UEJ450G7TmUp+WP3IocOovciPUlwnGGlufrSQtkprV9CgoG6
         i6kiZm54MefyVIzC1UtwpvRHN/VrN5rpypRwU9ShJY3XwbvMChytWDTXxOVZej5kMT61
         BG2A==
X-Gm-Message-State: AOAM533zhjq0b/gmfSNVp5fEIlbp46DqnKhVaj5jZ8L+DYhv0bbnUNqd
        qZr0bLzAku2YSfezZ2hbX7On29sQ74g=
X-Google-Smtp-Source: ABdhPJzk8Bz3BIudvvqL9aNZo0PYlxdeHsaXV3MzYKZ+EdYIdH7reEaf1RQNTstLluu7sWur6PjKpA==
X-Received: by 2002:a05:6512:1518:: with SMTP id bq24mr7681150lfb.271.1629325184128;
        Wed, 18 Aug 2021 15:19:44 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id v23sm93300lfr.208.2021.08.18.15.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 15:19:43 -0700 (PDT)
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
Subject: [PATCH v6 5/5] mmc: sdhci-tegra: Enable MMC_CAP2_ALT_GPT_SECTOR
Date:   Thu, 19 Aug 2021 01:19:20 +0300
Message-Id: <20210818221920.3893-6-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818221920.3893-1-digetx@gmail.com>
References: <20210818221920.3893-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Tegra20/30/114/124 Android devices place GPT at a non-standard location.
Enable GPT entry scanning at that location.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/host/sdhci-tegra.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 387ce9cdbd7c..39cfbb28ccc3 100644
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
@@ -1616,6 +1622,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	tegra_host->pad_control_available = false;
 	tegra_host->soc_data = soc_data;
 
+	if (soc_data->nvquirks & NVQUIRK_HAS_ANDROID_GPT_SECTOR)
+		host->mmc->caps2 |= MMC_CAP2_ALT_GPT_SECTOR;
+
 	if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL) {
 		rc = tegra_sdhci_init_pinctrl_info(&pdev->dev, tegra_host);
 		if (rc == 0)
-- 
2.32.0

