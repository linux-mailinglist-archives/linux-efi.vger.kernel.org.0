Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A5D3DC7B7
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jul 2021 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhGaSiG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 31 Jul 2021 14:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGaSiG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 31 Jul 2021 14:38:06 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BE1C0613D3;
        Sat, 31 Jul 2021 11:37:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b21so17746987ljo.13;
        Sat, 31 Jul 2021 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RWvwl8D8cTgFcx+4fHw3o3cHJEwxiQXIECV/bUKr4zM=;
        b=cA+wddHoup3g7CKDKb9rl8JNNFwDb1qR0PtdJwJ4ipid++WWOs62gQK0NF6S5VZmqv
         ts4UFvKAh+HwqHYeB0WeNnHjtgaimKxVKvwTBpNmBlDHjga3croZ0qT1maw/HcPAbjRL
         DOjoXfXHx9qeljvdG/DvoXVdlZDGGvgrMqnTVBxursRAfHz2ZCHS/535B2w3m2RAaV0X
         gmOO+86SljTnNfsM6EZ8QlYGgvnOM+fX5HaYQ5senueIXbX2bVKJpvuEeSy8wnUJ78Bm
         3GMniTq9h/Lu/btpQxd4FUAyoxAXBuiQsDdTk4TZtV6O82qZABiQFiLroiOrDtC/2ipt
         6yMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RWvwl8D8cTgFcx+4fHw3o3cHJEwxiQXIECV/bUKr4zM=;
        b=Cd+c+Cc9Q5EGIbIyfPjUnRQMxn+9UxAVBdPOCv3bWGOF7qJJhYuPwH3VlbSh0WO5iJ
         ju91O2lHciHv8+77FKNUu5Ce/1v1it29KqPp8z2k0PUBHgDjHzwWSKQwNj7fiOxzOC76
         2MMFT1U7cgT3qtrNCEURWNnbr797Z4ArvcFa5vr1xTczsVorqEUvM3mM8CyU7F0RUh7E
         SFvfETjPr17MYSbD2GaRhoBiw6UP0OP8Jxrz8T8kBOOX0JfETWwWM36N8GvpB10myVRy
         K8MTva4d5qYyq+wpC1KecCruQ43XVXF3IQ2BZsGK3oigeTB3Wbj5+QaRgbsolw1g4Inf
         f2EQ==
X-Gm-Message-State: AOAM533bcKmLsyBzr3qyVXYEk14T7NJ9G67XNMXd7ANghftSGWNW0MSi
        RN1hgQ795/Jojpqa3+mNIYs=
X-Google-Smtp-Source: ABdhPJzcOs2xpAmfU2xRebD4+0sjJp1claIvcV90/FBRHqNl/iRyve4FTVK8SvqMrsv8hAeHg0/Cag==
X-Received: by 2002:a2e:920f:: with SMTP id k15mr5892521ljg.357.1627756677817;
        Sat, 31 Jul 2021 11:37:57 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id s7sm456396lfg.297.2021.07.31.11.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 11:37:57 -0700 (PDT)
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
Subject: [PATCH v2 2/3] mmc: block: Add mmc_bdev_to_card() helper
Date:   Sat, 31 Jul 2021 21:36:25 +0300
Message-Id: <20210731183626.18568-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731183626.18568-1-digetx@gmail.com>
References: <20210731183626.18568-1-digetx@gmail.com>
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
index ce8aed562929..93ca25e97259 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -42,6 +42,7 @@
 #include <linux/debugfs.h>
 
 #include <linux/mmc/ioctl.h>
+#include <linux/mmc/blkdev.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -313,6 +314,20 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
 	return ret;
 }
 
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

