Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE88A3EF713
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 02:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbhHRA5s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 20:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbhHRA5s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 20:57:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35772C061764;
        Tue, 17 Aug 2021 17:57:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u22so820649lfq.13;
        Tue, 17 Aug 2021 17:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s3Vv60zrqT++YyiYanL+6/G2oO/cuU/RaWrweHuPjcg=;
        b=fx+/BJFxPb5FnS0XPHkrkv8GVMf2mOUi2DX/ZOp9mE+mBJfi1il7r7xzdcrzQcJErD
         ROVIOZzuKcqX+nctTE9qrOESpTFo8b3pcwW/VvgE/pV9fMgULYa0fhp//bQaxAgRaRUm
         pW99AJCDDxASyFMVGuI/rX7hgqTv2O7PPmKfvZt0rzh930kwwXXe9jdIZlUPpYF/KIOh
         vLxVo0P7rZPKJgqq6MjlVK+cITNLWLRYUzKFeMSpFvb5iXKFWRf+SGQF6fBf9SQgBhrN
         xZoedh3A3vXvUSQ1r9cUxrhAzOogpENZxaPE9IemX+aeAYH/5Sqdmzi19RnUxilEyYrC
         W0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s3Vv60zrqT++YyiYanL+6/G2oO/cuU/RaWrweHuPjcg=;
        b=nMtUMJ/qPZCeOPQ7FtI4uwSsXi5GaXFacDgiByXGdj3dXJgnU/pGAEQ5HVp0yPwNSf
         QpWLQwMRaoXYmu48DnwL/3yJSC+1iuPV7tjYirtB6r2VcRAoYzSkI62gsdg5+ks18sEx
         k5dqPF4mXAHLRgdQ6xXpT6szTB4tM7rvQ20irdsel0gJOHwokITvAF1eqEYmbtWO7Bmm
         8/rTwWzFloKVAbTOM8GAzVtvCKOqkkG5ypormsmEx6gx3HhIHbceQUS3TPhW43sg5ysN
         009s8YGsWDwMKjrdhNkmVL85cG/8sf2dfELdkbg6sJTC//Oc5+V57e4m7DrRoUP3ZwGj
         APkg==
X-Gm-Message-State: AOAM531Zu1rz62/B83Bxj2r1U1ZgfV6PLlPeP66IfBG5uX0DE03a7T2P
        PAemry+tzmOe/hAH0zl9Y7o=
X-Google-Smtp-Source: ABdhPJzGr9MXh4M2KzMSknIcRtkfl6GPJENUJYuGpo5rcW+TJEEkwmuLAGPRbIWoz6PPUsXtY3+p3w==
X-Received: by 2002:a05:6512:3b85:: with SMTP id g5mr4226680lfv.249.1629248232607;
        Tue, 17 Aug 2021 17:57:12 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id h19sm335879lfu.138.2021.08.17.17.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 17:57:12 -0700 (PDT)
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
Subject: [PATCH v5 2/5] mmc: block: Support alternative_gpt_sector() operation
Date:   Wed, 18 Aug 2021 03:55:44 +0300
Message-Id: <20210818005547.14497-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818005547.14497-1-digetx@gmail.com>
References: <20210818005547.14497-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Support generic alternative_gpt_sector() block device operation by
invoking a new platform-specific MMC host hook that is also named
alternative_gpt_sector().

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/block.c | 30 ++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |  4 ++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 672cc505ce37..8ad1841f0dbd 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -178,6 +178,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       int disable_multi,
 			       struct mmc_queue *mq);
 static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
+static struct mmc_card *mmc_bdev_to_card(struct block_device *bdev);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
@@ -801,6 +802,20 @@ static int mmc_blk_compat_ioctl(struct block_device *bdev, fmode_t mode,
 }
 #endif
 
+static int mmc_blk_alternative_gpt_sector(struct block_device *bdev,
+					  sector_t *sector)
+{
+	struct mmc_card *card = mmc_bdev_to_card(bdev);
+
+	if (!card)
+		return -ENODEV;
+
+	if (!card->host->ops->alternative_gpt_sector)
+		return -EOPNOTSUPP;
+
+	return card->host->ops->alternative_gpt_sector(card, sector);
+}
+
 static const struct block_device_operations mmc_bdops = {
 	.open			= mmc_blk_open,
 	.release		= mmc_blk_release,
@@ -810,8 +825,23 @@ static const struct block_device_operations mmc_bdops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl		= mmc_blk_compat_ioctl,
 #endif
+	.alternative_gpt_sector	= mmc_blk_alternative_gpt_sector,
 };
 
+static struct mmc_card *mmc_bdev_to_card(struct block_device *bdev)
+{
+	struct mmc_blk_data *md;
+
+	if (bdev->bd_disk->fops != &mmc_bdops)
+		return NULL;
+
+	md = mmc_blk_get(bdev->bd_disk);
+	if (!md)
+		return NULL;
+
+	return md->queue.card;
+}
+
 static int mmc_blk_part_switch_pre(struct mmc_card *card,
 				   unsigned int part_type)
 {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0abd47e9ef9b..18281c444bf6 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -190,6 +190,10 @@ struct mmc_host_ops {
 
 	/* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
 	int	(*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
+
+	/* Get platform-specific GPT entry location */
+	int	(*alternative_gpt_sector)(struct mmc_card *card,
+					  sector_t *sector);
 };
 
 struct mmc_cqe_ops {
-- 
2.32.0

