Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3591D654D
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 04:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgEQCNv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 22:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgEQCNX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 22:13:23 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF134C061A0C;
        Sat, 16 May 2020 19:13:22 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u6so6175203ljl.6;
        Sat, 16 May 2020 19:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xOq5yyY/u+0O8ZudKc0fLqZJ0PgNfXdMDM0w1gmW1jw=;
        b=NdW+KTGePpb1F/7NPdBU6M0SLKqzKRvW1r5p/XS9cQwbJijB6jHoDQjYNRZXoveSEx
         nX/L+YW5IMStWAijgpYsgBPI/oJBa9U/va0hjIUfBv7o+9YGMn2OFGKfMqMs6elL9gh+
         oOeS0CZSAz8pBx3gg2VsGD53qnyd5G4bBVbNgj68JcvVSZQ19jCkUOqiXRXbEpA3IiBQ
         JUMREOgMhkbyORHkbtFEaDk31oNVzyPrswIIjuQpnVzRGFcGT6+JnN/nUMW6+FNvOF/l
         95rqW4TY55jJv0gOsJ2AGSgZSKY92ki6PrMz6ekt6myyJmZMHcl6jqndzZByRGaFnLvr
         tbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xOq5yyY/u+0O8ZudKc0fLqZJ0PgNfXdMDM0w1gmW1jw=;
        b=L8Rd9CdrvkseIE7wRyyOJP79mty9wgHU1E+VZYhVP+eABunTQJqTA3aXKBTCmCJapi
         W6NKN3M7Ry09X8Q6BOQTa0lv5bg/AAnwW+YYInHXqqEm/pcCEPiJmEY7N7HLGNtsWR47
         z/7Ey+dRXSCgVj8p5wJLqoB2Ri7dFRmleSQftZlHZgpz+FO1Ej4BuciiuvSoQZZRx4OZ
         t836chwyJgSO6gNnSVykCjm52k4Dh6Q1pBcMtV97ViXycEK2MeqOp5Hwes8qSvhJ8fyw
         LX0py7jQzF5u1XbvqHv99iLECRQhOU+8EDHnnpL7W++LJWa8Pb1AIGWCSXt0D03pCP44
         hq8w==
X-Gm-Message-State: AOAM533lW1IVexX2NjN1yqFTu+joNBnJnQUikQx+6BPr7KG7YojIutqj
        50QxAa/6zcFMf0/QCwB2F6U=
X-Google-Smtp-Source: ABdhPJwNTnCRnGEzwWDtys0C350gFVYZafJyGxx10kmH9E/ezrlftQ5uNzOWVv7fIQIj/73s/2utSg==
X-Received: by 2002:a2e:700a:: with SMTP id l10mr6079423ljc.88.1589681601391;
        Sat, 16 May 2020 19:13:21 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id z5sm3463149lji.30.2020.05.16.19.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:13:20 -0700 (PDT)
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
        Davidlohr Bueso <dave@stgolabs.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve McIntyre <steve@einval.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v6 2/7] mmc: block: Add mmc_bdev_to_card() helper
Date:   Sun, 17 May 2020 05:12:20 +0300
Message-Id: <20200517021225.22890-3-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200517021225.22890-1-digetx@gmail.com>
References: <20200517021225.22890-1-digetx@gmail.com>
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

