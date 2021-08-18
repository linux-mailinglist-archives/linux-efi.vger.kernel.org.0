Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932F13F0E03
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 00:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhHRWUT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 18:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhHRWUS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 18:20:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF6EC061764;
        Wed, 18 Aug 2021 15:19:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w20so7951820lfu.7;
        Wed, 18 Aug 2021 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I8m3A5ojjjGr4tuZYoRH+9ybdfTR7NPts/xjHNXW+cg=;
        b=gCDGdNdaWu8hdnPG/tggLoVZlPxn7OWnfGa9sPTodCjCVf3q8a7+t9uzPYNJfNgvCS
         iW5l2Z5JYtzWy/3wnZ8ZT373nNP9qioBBw2HO1j9mO1zO6m+TWvMy6oaEW5BYWkZ9iV1
         sAyNsQmpznLGwWYDSf1jOmSO6I8E5RtPiJ7va8DDcFeAnaDjJnVZCPZfNRi9Q6O+W7oJ
         y88+yCZu67CL8A3ANxogqBWmfNOcC0oGsiq+8IZ7/4mF1lydpk5ztuk3ReZv3HjnX6D8
         7khYZn6djJBl7bffqNPIb+Wm7U10IDKn5avHJ5BMh6AuxBHzK13qdA6hRNIXa65Lup9F
         wdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I8m3A5ojjjGr4tuZYoRH+9ybdfTR7NPts/xjHNXW+cg=;
        b=Bx8QKodg0+rdelS4N7amuxk8sHQkyAyaviVsDlwYpbzq6D1hbrHvenb45VxJNoRGQi
         U3CmWMc3mPjoAXKBSIW7QfuMvyZf5EUi2PN7bLztt/fttMRrCyieqtFjg2/mXl0iSrov
         CoLAW985flD6Vj2pJ8t45mu75e4qH2C8CarW/CDJ5RpKkJgxXrfHz6PfWIVIPy69XfFV
         GIiT08UH3mBrCvZKCXvg/4Izc4mLpNjJT3sobkekgdV2ajTgVEBi55cKzoX5zb/Q6htw
         7X+EQNIWEpu3x/gck6hWqu7oZppBhYHt2z0yIzkaoAM/3ysDlIteg+o1D0h2NaRFOXjz
         +azg==
X-Gm-Message-State: AOAM531lWkKLznK3fxKq3/hQ6JJ5ubRi7Pvzl+/aj1ViUAN0LWnTfsJ0
        wLvUpFps1emv2KsQkFwWNDU=
X-Google-Smtp-Source: ABdhPJxoavpH2kVL2BHylmnUL2aT6+FMjqUA6wXolJmwoncdXvHbyt6lQ7+oxUEaMeiXoXTxeNgIQA==
X-Received: by 2002:a05:6512:401a:: with SMTP id br26mr3654435lfb.539.1629325181601;
        Wed, 18 Aug 2021 15:19:41 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id v23sm93300lfr.208.2021.08.18.15.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 15:19:41 -0700 (PDT)
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
Subject: [PATCH v6 2/5] partitions/efi: Support non-standard GPT location
Date:   Thu, 19 Aug 2021 01:19:17 +0300
Message-Id: <20210818221920.3893-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818221920.3893-1-digetx@gmail.com>
References: <20210818221920.3893-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Support looking up GPT at a non-standard location specified by a block
device driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 block/partitions/efi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index aaa3dc487cb5..7ca5c4c374d4 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -585,6 +585,8 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
 	gpt_header *pgpt = NULL, *agpt = NULL;
 	gpt_entry *pptes = NULL, *aptes = NULL;
 	legacy_mbr *legacymbr;
+	struct gendisk *disk = state->disk;
+	const struct block_device_operations *fops = disk->fops;
 	sector_t total_sectors = get_capacity(state->disk);
 	u64 lastlba;
 
@@ -619,6 +621,16 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
         if (!good_agpt && force_gpt)
                 good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
 
+	if (!good_agpt && force_gpt && fops->alternative_gpt_sector) {
+		sector_t agpt_sector;
+		int err;
+
+		err = fops->alternative_gpt_sector(disk, &agpt_sector);
+		if (!err)
+			good_agpt = is_gpt_valid(state, agpt_sector,
+						 &agpt, &aptes);
+	}
+
         /* The obviously unsuccessful case */
         if (!good_pgpt && !good_agpt)
                 goto fail;
-- 
2.32.0

