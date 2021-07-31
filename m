Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20363DC7BD
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jul 2021 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhGaSiO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 31 Jul 2021 14:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhGaSiG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 31 Jul 2021 14:38:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243BBC06175F;
        Sat, 31 Jul 2021 11:37:59 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z2so25213665lft.1;
        Sat, 31 Jul 2021 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kM2r3O6lLw7n0SLWPjQDjWc/9/9RRSabPEe6y/wgg7E=;
        b=XEkqCEMePzc3DyOX93h/fXQ0QYmMDcwfB1n3cbRFUa3+dOjyEGlfvNpW0AmpWdGqR1
         sLjdYHvVZckMfN8oHfZI6+y+GTKs0MMh4dnW6/F3VwmCE1lnYQ0wNPH06lDMRhXKa5t8
         L2sKvAK3VtQHJnxlJqhCR6MqVR3DbcAB3/70DUys1WcyxErni0rdYidjZgzTZ2VpLq8B
         pnP44AoIeJ0bWb6LkXSoqpzWjL7O8EBrK5r1TtRHu8Vu6rI3l5NUTAOXqO3Q+eQSc0hE
         0Xe4/d6EPFcytsA7ROqPyR7AaEgdYKf+hfRQ9gC47CT4BWR6ISYq6IIHqDi7yS3lk/h8
         kX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kM2r3O6lLw7n0SLWPjQDjWc/9/9RRSabPEe6y/wgg7E=;
        b=fvBY/xf8WQ8cwCyrOK667sZDzteJDNqh8+B8nLE+Noy1CaACDIKqLJzR03KB6OkQKz
         ga0TIqXF+lCJCMMVb0I+IyWRdH0Yg3bAzruSMXQ4RhRAuISaPn3Wv6tsw9bbWvYuWrW+
         aSpVkxoJ6kxt9e8ALIBln5L+0GV/2Cop03LDvLzO/5oRBMEBWA7o7bMaUWrJefbJSfiK
         8V7f9HcQgkyVsFD/nY44KTFPlsDjk2LGn04kjr6NX40WJPGM35Ol3A49FMyCG5MiXrcF
         tGPyt3d5oNIjb58ZZPaQ0Nbb6THI62OhToTJdIyLipHuUC8p1f+QR6jzt+dxapBn2Tl4
         hZcw==
X-Gm-Message-State: AOAM530E2C6vS6mKnh86iokxrs/RLNOsDBEtLhYtLTEMsVF2Nazy5q2Q
        WmvVygZ/M2jmIxkADEMCdno=
X-Google-Smtp-Source: ABdhPJyT4pXvAYKOeRXsxYj/bX5/EhnjPSDlY7LNdqTS7a6IkJbtOGJBZDvuJVNnV6UUZB1skZ6Cig==
X-Received: by 2002:ac2:53a3:: with SMTP id j3mr6456611lfh.479.1627756677062;
        Sat, 31 Jul 2021 11:37:57 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id s7sm456396lfg.297.2021.07.31.11.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 11:37:56 -0700 (PDT)
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
Subject: [PATCH v2 1/3] mmc: core: Add raw_boot_mult field to mmc_ext_csd
Date:   Sat, 31 Jul 2021 21:36:24 +0300
Message-Id: <20210731183626.18568-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731183626.18568-1-digetx@gmail.com>
References: <20210731183626.18568-1-digetx@gmail.com>
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

