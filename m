Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29043DC7CE
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jul 2021 20:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhGaS5Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 31 Jul 2021 14:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhGaS5Q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 31 Jul 2021 14:57:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC40C0613CF;
        Sat, 31 Jul 2021 11:57:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h14so25217261lfv.7;
        Sat, 31 Jul 2021 11:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RWvwl8D8cTgFcx+4fHw3o3cHJEwxiQXIECV/bUKr4zM=;
        b=QRcVs1hy7aCE1D4Bcoemyiuec6EMFJsjcccTLU2lId1tsYGE7u7yE14/zg14WHfIy/
         zb1jSicng1IXwQ8yQrzjGRmY9UJ13o4eHGC0dr88TSv1Bta/8wpZdLc8vFABC+pxQ99L
         034UhX0nyC+B/AgKbG67y5wvf3I6DKca6CEhPf+p+7bEmR8YyOUNSOHSrFDXvADUch5m
         i7MGp/nTYwH5c/fcht98y+3cloRpzMvHj8myfYHnPMj8AM7A4tM78no/tgdSAVPFBDl3
         wQzZ3KXT3y9Ra9yzku9HCqqp/rz+RoH6twaXCalqGys9C8IMObGp+cFikeidD/LhZXS2
         ERzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RWvwl8D8cTgFcx+4fHw3o3cHJEwxiQXIECV/bUKr4zM=;
        b=aKMqRWnxIvwoUtecHq6raeWKJqnTmylSDClXO1osZcrsweO4WJH6Rl2dnRKTfCOPqG
         DVbeFH0xzYFfpqumag1BQKrKrv2OdjgSgHVaz/EU1Q2pL7pm7eRmWyDz4bgjq9O1meNS
         MJOEXuNwg9jVwN5ujzA6H50G1HGCqVe/0OEly6OpR2BBbDfXdhQc9VNlpOJJtiIrakz2
         gNE00ef5lHwemKOc10G8UDNm4CaWoN5o93fpAD34Hx995a4S0z9djk5ywC9F04yAmDlu
         jjw+YAo87RB1fe+ea4DIRjWoK6fBhDFm0W5nHuUt9TCCUZhp4sqypdiG5ihfLncKfYss
         KLjw==
X-Gm-Message-State: AOAM530X+lBiCl9Fqvm9uKzVyY9lXaPEWwZ+eWSad/mH44tUwjXuoNJA
        /LWau16sKyi1Ghk7t4y/Qdo=
X-Google-Smtp-Source: ABdhPJzY8JjWKUWzhoEMQRWeoVUOcGLHRpkmxBTqqb+EIsJDSvB4fjs+AIKP62WZ6ZIie0lwRrqXGA==
X-Received: by 2002:a05:6512:ac5:: with SMTP id n5mr6404057lfu.434.1627757827879;
        Sat, 31 Jul 2021 11:57:07 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id c10sm507653lfv.10.2021.07.31.11.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 11:57:07 -0700 (PDT)
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
Subject: [PATCH v3 2/3] mmc: block: Add mmc_bdev_to_card() helper
Date:   Sat, 31 Jul 2021 21:56:51 +0300
Message-Id: <20210731185652.6421-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731185652.6421-1-digetx@gmail.com>
References: <20210731185652.6421-1-digetx@gmail.com>
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

