Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EA53F0E00
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 00:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhHRWUS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 18:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhHRWUR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 18:20:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E9DC0613CF;
        Wed, 18 Aug 2021 15:19:42 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l18so312309lji.12;
        Wed, 18 Aug 2021 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1uZZlco6eQq/HqnOfmLu683xT1D8kyQqDaHKpo2lnkI=;
        b=L5j6fWLECUk64iGSu82/m8pclA8wZ5I1TMpN43cAv7b0CGDs09iwoTh1z8f9MVyNBq
         fz8Xft9KpJAv0BTfl5Zd+9KxPxlOqj5qTMErLv7h6fZj7Ky+PK1ILBE42qevDBA7my6N
         wTFhIOsQYA1nUHOlWd6HaWvdYmPXAm42ml5uKLnbIW+DP5UjhON5ilFnnCfRuQcdaI2c
         jrljvxLxGmxLc0zXjtSIsZcjVQT4ZpjBIYYLBsyInJlhmALaWUzbtj19ZXZ+Yt454nPT
         QwLnjUcIUS0WM4i2t1k45CFyMSpaI2WP5Jf8suXoCzgjUqrF9rTFJ8RF0myzPBSlAuyX
         1IKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1uZZlco6eQq/HqnOfmLu683xT1D8kyQqDaHKpo2lnkI=;
        b=TIZhK8cjNFJjrH+Q1JNkszaPeetDaCI3bWA+nqwzlLOFhh9U1d7L7VKkE1L9pnXAwh
         z2Dq7QMymptSD1uvWmKia7gEwOiU2ylfXcHh4eQDRm6p8fV+77M1DFh8wGHlCRfHSQqA
         jKzkDxS+fb8rgXKE7uD3jPWrkONVBvF7fr8uh/FUluseua22uU3le0mIWyVYeNSy+RvB
         sneTX9l4zYGcbuvU4XBahrl5ZffglPp6ylH4Cqb8CLvFuGuDYDeuLjpcrOa7xkWwJxQ+
         a5I/VLicWD3IeVUtXUcuJdmsji95WNmCh9pRZw0H2PGGLAcZxWuJgM9gM589EPHr5joU
         sRSg==
X-Gm-Message-State: AOAM531E0Ss68mV23Zf2FBvaVITxo9q9a+YXSqnrA63pTvku93hvJqOn
        w1xT2wbdLVX4G67Yq6yOQDA=
X-Google-Smtp-Source: ABdhPJxbgdXy1i81skijA/xJRm2fiSBlefs/wkh/MKv1EkaiQ08WVRcChJB/HKNRo+EyXLFeqGlMvg==
X-Received: by 2002:a2e:8147:: with SMTP id t7mr9480074ljg.126.1629325180744;
        Wed, 18 Aug 2021 15:19:40 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id v23sm93300lfr.208.2021.08.18.15.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 15:19:40 -0700 (PDT)
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
Subject: [PATCH v6 1/5] block: Add alternative_gpt_sector() operation
Date:   Thu, 19 Aug 2021 01:19:16 +0300
Message-Id: <20210818221920.3893-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818221920.3893-1-digetx@gmail.com>
References: <20210818221920.3893-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add alternative_gpt_sector() block device operation which specifies
alternative location of a GPT entry. This allows us to support Android
devices that have GPT entry at a non-standard location and can't be
repartitioned easily.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/blkdev.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 111a3911c4d2..d65c8f60ad8e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1850,6 +1850,13 @@ struct block_device_operations {
 	char *(*devnode)(struct gendisk *disk, umode_t *mode);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
+
+	/*
+	 * Special callback for probing GPT entry at a given sector.
+	 * Needed by Android devices, used by GPT scanner and MMC blk
+	 * driver.
+	 */
+	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
 };
 
 #ifdef CONFIG_COMPAT
-- 
2.32.0

