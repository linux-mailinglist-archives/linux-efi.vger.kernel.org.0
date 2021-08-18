Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2163F0E05
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 00:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhHRWUU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 18:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbhHRWUT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 18:20:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BDEC061764;
        Wed, 18 Aug 2021 15:19:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id o10so7914016lfr.11;
        Wed, 18 Aug 2021 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6QaUUEp/rXx/wbK2KzXouwYq97hW25f84jkRB+ohcc=;
        b=nEC/ae0PSXn3p2MGe5DnoL7vkt3QJaPxeWhD8TJwrQqMQ5xL8BWZqZAWoPtdmRf1od
         zUK17L5rIxTEgAbLXoRQ821/ICWmMe9F2iGE5nqMxi9svauZad84Tman6b0RqQWunAny
         jw0Emh2UMseZUHOARo6fXEgSAMQWFXY3J3X6gpYCS5qAZJCsWX5UkC94PCjPVfpqXXbP
         5OkZmzpH66NmZJDgyjiJVEwgHya2h/15viJqX/eK/lrmqibl663EKx+2JLqqoGnDJkOJ
         QJQ5e/Dhy7jYJQ0+EibjYuIZMbw+QyVQoZHjzIO14XfFZOAjO4+OD2umb2svdIxC41nm
         rvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6QaUUEp/rXx/wbK2KzXouwYq97hW25f84jkRB+ohcc=;
        b=aQsp/yG+cn17FMhDWeAsR6rEQI3O9Xyk95+I2G/0Qaj3BYlU2TjOo26ZLvkXY1Uity
         +WnZ9SAVjZt9cavN2YkHAsFJdOkXZGQlSL8WqiL36YMnoTACPhcAQ+qHoeMQgHaq068d
         2k+iXSttfYkoc/YSQg1lxsAFVg5olnygeYk73hql55pY3/ZCBxMPX7bSL9tqQKqsLezf
         qbYU/PYVwCJurk0QBcM9MvQp/F73VmX9FQahhuocdoM3sPkN4i2W12lJFozDjvLtkTt6
         WfjD5T2mbg8XvCrfXq/qqI9gV/zTuJvR0X85zS4loxfNr3qL2rKQQ6YzENIrXjJd//TN
         sK2A==
X-Gm-Message-State: AOAM533uCGNGLAKQqRz3PEKphgrdetWnPDk+dPgL2qoRNb098qlAdVmr
        0Hz9tgoRcq9D27byDNzX/mU=
X-Google-Smtp-Source: ABdhPJw61jbm0S7IN9ZczlF8RfksF6FWUZWrqS1E0uwTp8wNHQig9KXHWNgjz1gPoy7l7CZImFTzwQ==
X-Received: by 2002:ac2:4182:: with SMTP id z2mr8396353lfh.503.1629325182412;
        Wed, 18 Aug 2021 15:19:42 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id v23sm93300lfr.208.2021.08.18.15.19.41
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
Subject: [PATCH v6 3/5] mmc: core: Add raw_boot_mult field to mmc_ext_csd
Date:   Thu, 19 Aug 2021 01:19:18 +0300
Message-Id: <20210818221920.3893-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818221920.3893-1-digetx@gmail.com>
References: <20210818221920.3893-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Bootloader of NVIDIA Tegra devices linearizes the boot0/boot1/main
partitions into a single virtual space, and thus, all partition addresses
are shifted by the size of boot0 + boot1 partitions. The offset needs to
be known in order to find the GPT entry on eMMC storage of Tegra devices.
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

