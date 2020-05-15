Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7F51D432D
	for <lists+linux-efi@lfdr.de>; Fri, 15 May 2020 03:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgEOBmx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 May 2020 21:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgEOBmw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 May 2020 21:42:52 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A2AC05BD43;
        Thu, 14 May 2020 18:42:51 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a9so436529lfb.8;
        Thu, 14 May 2020 18:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xOq5yyY/u+0O8ZudKc0fLqZJ0PgNfXdMDM0w1gmW1jw=;
        b=HizLxqe9cbA7I89vVR0kH8cDoiTOaqqkcABXr7Qc3JWYeOpKSfuAq84PQWKpHS6xTb
         pEkhH41ezKMGz9Bx06+q2arg8e0zvi4n0/tVr8QB7P5bL2ZtY/plVznDU6c75Wsb/iz3
         DA1mrUnU5cYS5fzcx10E345AHgsjMpnDbpOIlxO12lTE21snp93spwXOZ47SMTdpcZRZ
         n1giWf19JCvOaZZ5o4dUW6zsLEwKari9r0a7yoTkKeiEJKHQYKRFaVGRaUlQpLo1K5Q5
         XKv+kuYUk/4LzAH9v5HanoRULHkq+z+w3eQXY5JhpV3KyfFr70117wzMfZ/kJknddxMA
         5uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xOq5yyY/u+0O8ZudKc0fLqZJ0PgNfXdMDM0w1gmW1jw=;
        b=ZapVmULAKc2oS52llH9cGPoj1vKAe6EnnuEDmNDSXBhFW/LrEMN9Wn7iAHfR1uiT47
         khWctVmAqnmzNjtQIjEMGZAntY4gcYULQjM5jdgvyCnWroqMnrDK2PHWzGH+HtL4K3ti
         Ai5DrpPJ4qeGYAR78fhnoYk89Q0T4AqTrX6DspBxCIRiwB0Jegdqc6vYvlY/VhD8Bgda
         YB7hrHKShOxjastrTKj4qmoDpmtLxtS7h+4hpoN69+ksxPOLs0qCgrP3tnqDudoDg/89
         4bNSuuYeL9+nHHa+yuRc34WKjOkH+l82gPwZueGNN2zTjRqf83CyM7lesYmCkPAJ5NaD
         CqIw==
X-Gm-Message-State: AOAM532vaGe6O034k6ya3LKM8HimdaXhPCxReWu4QjpglPoBJQ8VOsyk
        Z9lXOOjzUL5h+M81+/J6iFc=
X-Google-Smtp-Source: ABdhPJyn2AB2ezg+28YzyfC8sKKmzSJ0tCVsEm3GVCDu3mVEnnRNRX38Gk2mKPG/lul462lAoHmanQ==
X-Received: by 2002:ac2:5091:: with SMTP id f17mr683365lfm.166.1589506969603;
        Thu, 14 May 2020 18:42:49 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id i1sm309669lja.3.2020.05.14.18.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 18:42:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>,
        =?UTF-8?q?Nils=20=C3=96stlund?= <nils@naltan.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v4 2/6] mmc: block: Add mmc_bdev_to_card() helper
Date:   Fri, 15 May 2020 04:41:39 +0300
Message-Id: <20200515014143.12984-3-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200515014143.12984-1-digetx@gmail.com>
References: <20200515014143.12984-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

NVIDIA Tegra Partition Table takes into account MMC card's BOOT_SIZE_MULT
parameter, and thus, the partition parser needs to retrieve that EXT_CSD
value from the block device. There are also some other parts of struct
mmc_card that are needed for the partition parser in order to calculate
the eMMC offset and verify different things. This patch introduces new
helper which takes block device for the input argument and returns the
corresponding MMC card.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/block.c   | 15 +++++++++++++++
 include/linux/mmc/blkdev.h | 13 +++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 include/linux/mmc/blkdev.h

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index c5367e2c8487..99298e888381 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -40,6 +40,7 @@
 #include <linux/debugfs.h>
 
 #include <linux/mmc/ioctl.h>
+#include <linux/mmc/blkdev.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -305,6 +306,20 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
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
2.26.0

