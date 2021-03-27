Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329CE34B970
	for <lists+linux-efi@lfdr.de>; Sat, 27 Mar 2021 22:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhC0VXq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Mar 2021 17:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhC0VX1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Mar 2021 17:23:27 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8F6C0613B3;
        Sat, 27 Mar 2021 14:23:26 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s17so11457317ljc.5;
        Sat, 27 Mar 2021 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYSgmhDDJeU60WZ2qkj3eYgQcVqlfr0Yv38NQkuYdoM=;
        b=duGQwc5aT3ZrdSRXFebNpJToMJ6rZyhUe54R3il99SAm9E3t1uc+KMSz5oaYIbHyFc
         lqZh/IrKc/7v//zT5KYtrsOqqmbGUQWN3fFn2GxcYt8OswzqiJlRlb3X4iDQSG7JV4fm
         MMya+HlqZCieqW5AICk+U3ya1/tLMgVGp2ii77GoUHAlZH7ePBj1q/8hHhIqiWE/reOq
         cobCTjOGYwp6Xf26VnkyDNHejskhVEW1PQKQN2ftPNPaFzDyDxhRcr9qByno9SXxOopV
         hJmP1PiQFjVgnEw2BPPxbwKI4Xz3OBbjLeI2vszR7K8KtPhHKE6r3Q/NVNckxXdN43JW
         LX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYSgmhDDJeU60WZ2qkj3eYgQcVqlfr0Yv38NQkuYdoM=;
        b=lkhyYVL7GhZcgGGIJSAsKwitlXMOiSCLLwAe32V4e2ZPZnWH1M3tYYvPDPhvawS5BC
         QHhT/7QoiVnGzYN35UDpRAlylu/Pi9rKW/oHff3JRB2yeAacRDlkZ98idBv+eiKpNdMM
         erLNDN9h4XYmMYJZPNj5RXTHDqJo0m2Cv7UIVbch6dzGFqj6KR8oVIPOtZ9GsFO+63e2
         kP1hQkoQhAIVDc5r9ZiB14R3VNAaXFzUuVC6V3uvB4plefG8GN2PeneDKstjUqAc0VCL
         HLirjHJWePcN/+hIWRSpQ8TPN+pPEfHCxGgHSTXaTE+HNQw9UmBPS5ckQhbtN46OtDn3
         xf1g==
X-Gm-Message-State: AOAM5304aLQA6pX96MNmH1H3ChNV6dxzxtYR2D2zb4c1wuZS8X8/7KWO
        t6rAE3o2xD/hd7Un3yrONsI=
X-Google-Smtp-Source: ABdhPJw9ZU8ydYvThuoMbMN2MoKDQog6WsWizag6KBMfyHXWr0dLqRTVPLUxpxD4ryCW7tRP87rdrw==
X-Received: by 2002:a2e:2d02:: with SMTP id t2mr12552119ljt.488.1616880205353;
        Sat, 27 Mar 2021 14:23:25 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-66.dynamic.spd-mgts.ru. [109.252.193.66])
        by smtp.gmail.com with ESMTPSA id x7sm1300626lfe.182.2021.03.27.14.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 14:23:25 -0700 (PDT)
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
        Randy Dunlap <rdunlap@infradead.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v1 2/3] mmc: block: Add mmc_bdev_to_card() helper
Date:   Sun, 28 Mar 2021 00:20:59 +0300
Message-Id: <20210327212100.3834-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210327212100.3834-1-digetx@gmail.com>
References: <20210327212100.3834-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add mmc_bdev_to_card() helper which is needed for finding EFI entry
on EMMC of NVIDIA Tegra devices.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/block.c   | 15 +++++++++++++++
 include/linux/mmc/blkdev.h | 13 +++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 include/linux/mmc/blkdev.h

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index fe5892d30778..666066fd6037 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -40,6 +40,7 @@
 #include <linux/debugfs.h>
 
 #include <linux/mmc/ioctl.h>
+#include <linux/mmc/blkdev.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -306,6 +307,20 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
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
2.30.2

