Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209EA3DC7CF
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jul 2021 20:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhGaS5R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 31 Jul 2021 14:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhGaS5Q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 31 Jul 2021 14:57:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEDFC06175F;
        Sat, 31 Jul 2021 11:57:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y34so25232993lfa.8;
        Sat, 31 Jul 2021 11:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kM2r3O6lLw7n0SLWPjQDjWc/9/9RRSabPEe6y/wgg7E=;
        b=PvcX17+X3rpy8w/8tasEr1w5Abx0vQLXD60n3ox9OVzkkOFlc+++YmTXuGLiU8NhB4
         eeCjprYBDGw72JEibxPSCfRsjHwtAJHncBXHZBJKFgxnvcU9FYbdUmvFH4xBj3s1NDVs
         adGe1DtbMZp5yXiSmJPqOfKn9S+KK+7VoI5x9/NTAIs0a01dE3Hc7GLKVWGU6BW9/Us5
         HOHcYNWzIwHsBYOr4dmKWq59GH32NQnR3rb2QfpBKxhd6IkCjvQcUedaojWAPQUwPxxg
         A1BHiKkjGBpI+xqt5o0e8Www/g+8tic7IBKI5IKKd9lFgehUJyG5UCJ+k2smc9P3Mt0l
         UwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kM2r3O6lLw7n0SLWPjQDjWc/9/9RRSabPEe6y/wgg7E=;
        b=C0fWhNG47hdp3pc9N3RbFFPidLfYy76ZJai5LlUn4uyc4ArQhIySUubA/vMTkuvM4/
         vOjLDlRZjucWzfNfjaDOnisaOmlbY5puLTYfL+dm8DUcR7IC9+lIb1ZsrNYOP/qWyuhc
         R+TnUj8crODRCm3kf5fQqL3q/laigQgkkziBiLMIaVhrkmHbxfThav93L4RCNnF4HUPO
         eS/brluP8Fe2II7w0188aytUh22HxXHmLUU3abM3Fs7ZBqmS2YVhppmQHyI23iaBxDZ/
         H5oYWmpn8xumKl1wF6l0TRyqkOSDgec+lswcOY6FOAHTi5VhnCT1PFlAgVK7h9pAP5G6
         FQvQ==
X-Gm-Message-State: AOAM530WXvJXwMvQHobmbdtY51aLhOzzzkUnLNpQdfTAz29z76I4KcIb
        fqsb+WnKhp57W0wzdtcK+5U=
X-Google-Smtp-Source: ABdhPJybtfNorsr7GQdOEWKtveiofLlLzegfYXzAQMDBJimcgLPAgQ7toGDT1H30tLLqF1KU6Ac4gg==
X-Received: by 2002:a05:6512:3253:: with SMTP id c19mr6259774lfr.568.1627757827054;
        Sat, 31 Jul 2021 11:57:07 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id c10sm507653lfv.10.2021.07.31.11.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 11:57:06 -0700 (PDT)
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
Subject: [PATCH v3 1/3] mmc: core: Add raw_boot_mult field to mmc_ext_csd
Date:   Sat, 31 Jul 2021 21:56:50 +0300
Message-Id: <20210731185652.6421-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731185652.6421-1-digetx@gmail.com>
References: <20210731185652.6421-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Bootloader of NVIDIA Tegra devices linearizes the boot0/boot1/main
partitions into a single virtual space, and thus, all partition addresses
are shifted by the size of boot0 + boot1 partitions.  The offset needs to
be known in order to find the EFI entry on EMMC storage of Tegra devices.

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

