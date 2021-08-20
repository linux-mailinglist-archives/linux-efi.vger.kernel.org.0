Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8D63F2437
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 02:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbhHTAq0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 20:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbhHTAqZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 20:46:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B5C061575;
        Thu, 19 Aug 2021 17:45:48 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id y7so14472352ljp.3;
        Thu, 19 Aug 2021 17:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=45NSAdZItfn0nrRg1M4dKjbQF5aEU+K3NPHFkyu/0gY=;
        b=iAf54oxoBaCloDKN+LiOz8wjQ46KiVJzdzZWyUAZFIKdHPqfFkN+MCjoYpug7y0hkp
         DS29bfX0MD340M9IPxwaxv7onvHpK2V3RBUIXUjyikBUhagI3nzizHBdbhBX2+MpZfCV
         68AT5iPlirWt64+Ut9GMR948I6DR6QoGwOxFQ/ugmzj5RS0MLB6qvmg+44b2AM5z9TOR
         vyhiuDCnSYNhPrn1xZfod8yvSjGi1B4EhZ16Y4pxWe609v8plsInX8vG6s3QLB5Wpjtb
         n9QLBaM0ygKEpPDdj7uJFbJjlHUimGm1jewIhNrC6WeNgGQwrXn+M79JzKNDkk1iKTUG
         6HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45NSAdZItfn0nrRg1M4dKjbQF5aEU+K3NPHFkyu/0gY=;
        b=LfBwnYBSMQACk2OGu1UOBJ6PRXo4eqPZ68lxfyAUCL9qcelow1sAqjAIs7TGRZg0GS
         uTmix3wFmIe70/DqXzR3TaKscr5Oc3UHAI6QTQBZde6Wcpg6rhfcsd+d3w9tfM2BtMBE
         X3RnTkvhP5L7zNS17Bk98IIqJK85NbPxpn4Tim455x1pOoDLaduExQBd/Qsz4lSGRB3Y
         tQWXkt1OMWwbMFSljyL38GFBYzVsznELN3mhOHa5rB57wu1qchMycvGtJ8EL8v98uWM6
         vo303VEH5l32fXh8V201MPXswuNw/d4+xau2XC28Z8RPAby3rDyRd8Ce9IO6jyHQvAsm
         hZag==
X-Gm-Message-State: AOAM530U8KSzNmYnmy9tgqYxyMx5bvdmgzl6rtr2PaNCGDPzYopPjmD+
        0CJNquZUt9rh0waLQWFOQIY=
X-Google-Smtp-Source: ABdhPJzypc6AAdhpGF4AhXyJV1DhBOUnecglxgdQO/9GuDqg81TxIV7Je/gIWFi+U/gg9qxgUtkRSQ==
X-Received: by 2002:a2e:9e4a:: with SMTP id g10mr14513445ljk.54.1629420346956;
        Thu, 19 Aug 2021 17:45:46 -0700 (PDT)
Received: from localhost.localdomain (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.gmail.com with ESMTPSA id h6sm507244lfu.230.2021.08.19.17.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:45:46 -0700 (PDT)
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
Subject: [PATCH v7 4/4] mmc: sdhci-tegra: Enable MMC_CAP2_ALT_GPT_TEGRA
Date:   Fri, 20 Aug 2021 03:45:36 +0300
Message-Id: <20210820004536.15791-5-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820004536.15791-1-digetx@gmail.com>
References: <20210820004536.15791-1-digetx@gmail.com>
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
index 387ce9cdbd7c..a5001875876b 100644
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
+		host->mmc->caps2 |= MMC_CAP2_ALT_GPT_TEGRA;
+
 	if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL) {
 		rc = tegra_sdhci_init_pinctrl_info(&pdev->dev, tegra_host);
 		if (rc == 0)
-- 
2.32.0

