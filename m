Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31153EE3BA
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 03:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhHQBhh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Aug 2021 21:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhHQBhg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Aug 2021 21:37:36 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B734C061764;
        Mon, 16 Aug 2021 18:37:04 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y7so30290790ljp.3;
        Mon, 16 Aug 2021 18:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kM2r3O6lLw7n0SLWPjQDjWc/9/9RRSabPEe6y/wgg7E=;
        b=sj15Xh/m3EoLFT7HXSjITxWtKIUNzGLW3fCpfpEOvJENkd9g6xyQYGrZkxvXJCgMgD
         09sF+ch5Kz5kjRpDPl5wkVqesdTxC+8K+seyv67yyiWKPZRf6SsTe4aptAL72k6y30cm
         kWubM9yo+7gn2wa6DEXnCglKN40dZ31iMBbRWLpAavDdAeD/ick+YNgYaspQqrAhlVfA
         IM0gjIYU7BfRmJ98IKWh7kkH1u8bok4dVh8DUVZqHbdeienFqI3LRsNb4SczizNSSqJN
         q593JSFxKzq0R3sYHja01oYQwNhhVX4wWEqasvdiGpjBdjlJiGWBgvgrhVV2OhyGZ4Or
         KOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kM2r3O6lLw7n0SLWPjQDjWc/9/9RRSabPEe6y/wgg7E=;
        b=gHozKv8xmGvrymiDHUsF4MsepTeeWcvaQlfoXi2Fb6pE0yBQIN0HZv51QRafuTL2G6
         KhDhHKMbmwHKIesX+brKmR3uAu9w+es3cyBbj8PT2m6xe0S5hu+MpOQyWqY9MIetAV15
         yYaL8A5mJEMHqfwhLz7QW5AE/jH+BvUiJwmwEejN/uaYoWDJkE6jplAM0WYc8TbzrlI/
         T/0lUE6oVCaHFodryN96Zy1kncXLAdooUDmunZ8lJ9DKQSXDTfqO1mOsk6aJ0k2EmF/j
         sJFWXAS2W3GT+sUo1U8DrCrbNHn7aCWiFW2ZC0ziG47Kw3371wDvlOXBp9vcwXcHcnom
         deZA==
X-Gm-Message-State: AOAM533b0w8PAHYKvt7KPMLARu1UsN51rb2ZBeH5fEWwBG/1gMew8kap
        dzD6HG8KgZA03ZX6uFTP23M=
X-Google-Smtp-Source: ABdhPJwTcz+bg/NGdCJjEr7SQ/YgmaLytRbt8w9eOka5Lea3KijckzbbslUhKHxWJPc6tYlcpfGslA==
X-Received: by 2002:a05:651c:160b:: with SMTP id f11mr921098ljq.496.1629164222548;
        Mon, 16 Aug 2021 18:37:02 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id br33sm49699lfb.46.2021.08.16.18.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:37:02 -0700 (PDT)
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
Subject: [PATCH v4 1/3] mmc: core: Add raw_boot_mult field to mmc_ext_csd
Date:   Tue, 17 Aug 2021 04:36:41 +0300
Message-Id: <20210817013643.13061-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817013643.13061-1-digetx@gmail.com>
References: <20210817013643.13061-1-digetx@gmail.com>
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

