Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237593EF714
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 02:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbhHRA5t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 20:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbhHRA5t (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 20:57:49 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A96C061764;
        Tue, 17 Aug 2021 17:57:15 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id y6so1938489lje.2;
        Tue, 17 Aug 2021 17:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+PwoAn2TbsYyBgAUnjfJ0mPTEWF4OtaWk/OQ83AcWM=;
        b=OgIqTjQP/2I6zKJkTHxQkuLSFKrqUuLTgxY0ySO+ixz0jMUFqzcCT9xwsPxRVeLiKj
         AceLQOQ3vMGT+PU2pteuVzmYf93EIvZeoJRBh/2FjNaktiYpw7WNflnpR/BotzhYSGpB
         98jWS9W/kar1qWaeucQN7xYBko4zfdd3Hk1KeqjTXp/DeIkaB5JSXBpn4+h8nlmSlhgr
         V8+kJaJSczAeEfRjNIy4b5N86aTJtXp+295UQteah/EHX5bNFpRZXehcY1yFbQ+T03iX
         Zov05ZLQPrRkwhZ8P84I5kQoqhVD5lLT8pS46CvwYKMyvRuVsAtiOumIpO4Ni1mF2Dp/
         U4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+PwoAn2TbsYyBgAUnjfJ0mPTEWF4OtaWk/OQ83AcWM=;
        b=dl15Da78pdw/BAfVVj3hKsxjozdl7/ZCvt/42G0pdLStnb7i/2dA1Au1y6C7Q1QVvd
         ryklFwEQ31ZUzOc+W9ALvHKeFBsDCFbNihEP0TtEJJqsv4kux70/OQVnWFmVtAAeJE0v
         EwqwydOawrs8KBnE+60aY8y8oSVz5oDDe2bo/kG7gUJS52LohGIsb+sJhM1s+eD5NZO4
         8dB8GJYpWppX13NgRSFPBHrVzcxhWz+ut881pTVBlBe9ugcNd3sP+SevBo9Xj6YuN9C7
         9hEulNKTVWWNqvNQ/Zhpa1SpjRVH8a+6jz4Ur3kUzxahpjR4iCUg1uRG8pKce0Y3r/qQ
         D9yg==
X-Gm-Message-State: AOAM532j43Xv31ZfTkfuXPTISsN5LT1hMd6DXXJ7vNVJdA1eKl270QvJ
        F+iy0PI+Lefow3AooD2voao=
X-Google-Smtp-Source: ABdhPJyOKk5m9JTY/i1OECIuQzCEr/YJMBQXB5FhWA1QN/Cfa/eQrB2486zb/GmvIuRiJCqXOrKpjw==
X-Received: by 2002:a2e:557:: with SMTP id 84mr5516909ljf.507.1629248233491;
        Tue, 17 Aug 2021 17:57:13 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id h19sm335879lfu.138.2021.08.17.17.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 17:57:13 -0700 (PDT)
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
Subject: [PATCH v5 3/5] mmc: core: Add raw_boot_mult field to mmc_ext_csd
Date:   Wed, 18 Aug 2021 03:55:45 +0300
Message-Id: <20210818005547.14497-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818005547.14497-1-digetx@gmail.com>
References: <20210818005547.14497-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Bootloader of NVIDIA Tegra devices linearizes the boot0/boot1/main
partitions into a single virtual space, and thus, all partition addresses
are shifted by the size of boot0 + boot1 partitions.  The offset needs to
be known in order to find the EFI entry on eMMC storage of Tegra devices.
Add raw_boot_mult field to mmc_ext_csd which allows to get size of the
boot partitions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/mmc.c   | 2 ++
 include/linux/mmc/card.h | 1 +
 2 files changed, 3 insertions(+)

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
-- 
2.32.0

