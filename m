Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4C71D624F
	for <lists+linux-efi@lfdr.de>; Sat, 16 May 2020 17:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgEPPiB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 11:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgEPPhU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 11:37:20 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A9BC061A0C;
        Sat, 16 May 2020 08:37:20 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id v5so4285771lfp.13;
        Sat, 16 May 2020 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xOq5yyY/u+0O8ZudKc0fLqZJ0PgNfXdMDM0w1gmW1jw=;
        b=Hvo9451ScIWr4K2i4TFKAfJ8Hiky01fRhOM/PddE10qCDyhNai+374jwqLZ2J3nfs2
         p4OWzw9QrqZXo7s6npfHt5Alw65mJ9y08CSuIWyMuDBpum9inSTL8QUe7j5qhyD6o8Pq
         te+qSz/BQrDHrImbsGFaIfSsJkth/8yIEe5KECwITADdrGxxBXnoMj332SwXcUDnUdfW
         phHqcrAB/STUUcXItS+wcGF7NYpmQs9FQGMwYzECBje1d0h82O1FEr2/Ct/nwf64REDr
         q+HBH+9dJvTKa1yjSwKp+bBXG6Hy9UWfUcs9Sdo5wWIkQrHmdpEKXLxLGs3irtKOh2kx
         hq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xOq5yyY/u+0O8ZudKc0fLqZJ0PgNfXdMDM0w1gmW1jw=;
        b=fV2KPqsiim6wyDEOSiadtxwTCYDo85CtZfWqJRYT8PByUmjDKWptuMpD/OFWRBRUtx
         Ukh4NmpRReQdIFeZPqJQHz1eK6yqGuvwTaGNSVJtK2/OQl1zT2xaWWyJwGjAszQfEPwM
         JOT0E4FRQTwtDejw5uZkhbHHNFJKGaPBpIX/nDgIq/2L10FbpuGOYeufgFJ5s3gQCWoL
         zJLu8sERPaUNeA0EoOYwPv4usaUNs672hd+K3BdbNsfBvyBt/49lUrQDvXKRma8jg4wX
         QTwHIQlXsNKzWfkJHj1CwAVgmWI2hj8GdN6aHn+uFqqzIsQGBLjVBzjuGjY8AQK8CYtG
         nyGw==
X-Gm-Message-State: AOAM531DV/S6LCHm1/UpBSSivGKyvxfyCW3vFK2bUaSIdECCyYEetVK0
        nIBe8P/wYxZ09goMREfhoja+O2E/
X-Google-Smtp-Source: ABdhPJynQ4R+mgLh+UneyxWsLqsBhBI616esT9RwgpBEsbBMIY5gXqS4hIYzOiak7k5TTs33aK8KSw==
X-Received: by 2002:a05:6512:14c:: with SMTP id m12mr6008280lfo.165.1589643439009;
        Sat, 16 May 2020 08:37:19 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id a12sm2845356ljj.64.2020.05.16.08.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 08:37:18 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Steve McIntyre <steve@einval.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v5 2/6] mmc: block: Add mmc_bdev_to_card() helper
Date:   Sat, 16 May 2020 18:36:40 +0300
Message-Id: <20200516153644.13748-3-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200516153644.13748-1-digetx@gmail.com>
References: <20200516153644.13748-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

NVIDIA Tegra Partition Table takes into account MMC card's BOOT_SIZE_MULT
parameter, and thus, the partition parser needs to retrieve that EXT_CSD
value from the block device.  There are also some other parts of struct
mmc_card that are needed for the partition parser in order to calculate
the eMMC offset and verify different things.  This patch introduces new
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

