Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6080B3EE3BC
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 03:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhHQBhh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Aug 2021 21:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbhHQBhh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Aug 2021 21:37:37 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A89C061764;
        Mon, 16 Aug 2021 18:37:04 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id c12so17191668ljr.5;
        Mon, 16 Aug 2021 18:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=epz5hIEfcZWefFNXUO9u5VneKbvgYW0xfKT7eYaUy3c=;
        b=CJi/9bFTsi43mAGl74cxiUR6IeB5HdzOZBF8QmtF/wb0Lcoc2K4moxrKzIMUjfsG8h
         x22ju4PxnCVYp3R5IuCQYR6P0CKrIjVwNhcpaWXuAxcP2xTOisNyK2r3FlOZtwFgYFXR
         gosd6i/g0Rk0MlFpFnAyQnjLcLfVOiKeuE6Oq3NGKMrDZZq3M782i4+HxLMCYWQXBVAS
         fDrCwp5P38bDhjw/flRuHarlIxm4pfP/ggIFrGC4qY7BRxdsZCBZRTohK2s50Ie1vSfX
         9+aqijSY3henkKfE4+WSUyVOnr9rUoRiP0Udo8/c4Gtn0z9n899VJcHSfSUeUWu6BUwF
         iOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=epz5hIEfcZWefFNXUO9u5VneKbvgYW0xfKT7eYaUy3c=;
        b=t/aadCt6OMY9hb1jcS0mQJk3JjtyJd5I3KCX4lb2dS0bdg080jc8WC8lUyzaWY9kAs
         Gjeo8JHXtUX6lUrOfBHCYaHIQcC2g2GGab3V1Pv8fhvMM/cQfA16XtyN+hHyVvjU7Ib3
         toohVXEPnSzkIMhMz5471KqoF90CHdaxDvGvhAlibJkWWZKuHoGw6zaECyb7uuRhHhai
         DePfLnSCDnHO6PIyNDRDBvdqlm4JoWVkEb4Ujs0bMnMq60GwlPLILrEn64wOjzzv2pyk
         oT96/f4fJnZoMGH2oGgelpyf1Ivk8F7s3NvxkHgotJ9ib2v5GVCcfc5bSIITEnav4xxo
         R+8g==
X-Gm-Message-State: AOAM532aVljK5h/v7bqZdyi1u2V2w5SIYVrgXdsQUdgdM+ksqmCVj2Hw
        NYZ512QdEluMlDwLvMKlKdY=
X-Google-Smtp-Source: ABdhPJxDIf5h9kbJ0vgT1oPnwvs9EiOGbT9JiiZA0k2oLO1j+3PxHpB2utUxyZQ3EW+T3JPRoMdIRQ==
X-Received: by 2002:a05:651c:542:: with SMTP id q2mr902083ljp.192.1629164223294;
        Mon, 16 Aug 2021 18:37:03 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id br33sm49699lfb.46.2021.08.16.18.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:37:03 -0700 (PDT)
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
Subject: [PATCH v4 2/3] mmc: block: Add mmc_bdev_to_card() helper
Date:   Tue, 17 Aug 2021 04:36:42 +0300
Message-Id: <20210817013643.13061-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817013643.13061-1-digetx@gmail.com>
References: <20210817013643.13061-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add mmc_bdev_to_card() helper which is needed for checking EMMC
parameters by partition table parser in order to find EFI entry
on NVIDIA Tegra devices.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/block.c   | 15 +++++++++++++++
 include/linux/mmc/blkdev.h | 13 +++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 include/linux/mmc/blkdev.h

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 672cc505ce37..7e9a486073fd 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -42,6 +42,7 @@
 #include <linux/debugfs.h>
 
 #include <linux/mmc/ioctl.h>
+#include <linux/mmc/blkdev.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -357,6 +358,20 @@ static const struct attribute_group *mmc_disk_attr_groups[] = {
 	NULL,
 };
 
+struct mmc_card *mmc_bdev_to_card(struct block_device *bdev)
+{
+	struct mmc_blk_data *md;
+
+	if (bdev->bd_disk->major != MMC_BLOCK_MAJOR)
+		return NULL;
+
+	md = mmc_blk_get(bdev->bd_disk);
+	if (!md)
+		return NULL;
+
+	return md->queue.card;
+}
+
 static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
 {
 	struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
diff --git a/include/linux/mmc/blkdev.h b/include/linux/mmc/blkdev.h
new file mode 100644
index 000000000000..67608c58de70
--- /dev/null
+++ b/include/linux/mmc/blkdev.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  linux/include/linux/mmc/blkdev.h
+ */
+#ifndef LINUX_MMC_BLOCK_DEVICE_H
+#define LINUX_MMC_BLOCK_DEVICE_H
+
+struct block_device;
+struct mmc_card;
+
+struct mmc_card *mmc_bdev_to_card(struct block_device *bdev);
+
+#endif /* LINUX_MMC_BLOCK_DEVICE_H */
-- 
2.32.0

