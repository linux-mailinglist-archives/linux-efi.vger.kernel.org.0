Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B323F2430
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 02:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhHTAqY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 20:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbhHTAqY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 20:46:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB6EC061575;
        Thu, 19 Aug 2021 17:45:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g13so16692178lfj.12;
        Thu, 19 Aug 2021 17:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k6iYz/mO+HJ071E6AUAEWO35gGd46ISYzy2GCl/m2MU=;
        b=Z+kZwTWa/Oguu4j8PeKNqG+REpJzHKAcaradJWnGu4zQNqyb9S2Rzz7LbdsmIhxwDy
         ER2HpdzPRYVGOy/3ghCaV+2xj6wBSTZkfG+qM4MBKLX1SN9jVb5fi2Yvoe/CKJ1iZE8D
         MqzszEpT92cf6dNF5eVyTU5F+m7ak773/2tYUdxK1Sl+ePt+fCkpEYj6v75CGlRvSJ/l
         DR3iI5ceEh3js5tkqIougWohZokW/SzWgKD/VgDhwJU84DaWSaPFcuzJiCCzZV2HYith
         Oh4wwtJsQKIkjmD6GOXrSvsWCpB1xCRSzKP4d3XGHv9wsUhcYWfyaWCSPiOIXcbV9WKY
         FfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6iYz/mO+HJ071E6AUAEWO35gGd46ISYzy2GCl/m2MU=;
        b=h+V1Nl3fB+6gZc6SwNQ7msq4fA9UveSiFSDxCYe1TRF0w/89IfUHp2qQkO9saAoqGG
         IQsgo55GPeILut6NIyBpbf90FH+BCxf8+2lSaVYsCJdn82R6QMq2qvNsHA3m9bvEHfHw
         TsOw8CK2wTfygf8F+tMDKkPNcwMLelO0OwWz1m48B56gMMS9qMQ86aQAuP3ZbPVaGR5B
         LjgOUrNThyrlbhw6umdT/4RCBUj7uN8cCL9C9vYfIrhNS/C3aj7YeBdc4YNp4P7mvJw8
         Xn4jzEyUzNQ90l0fnhp8SE/KLq0J0PA0QHOlAgBEj9ZwZsUx36TA4CH1Vxzxt8fvumq+
         h8hw==
X-Gm-Message-State: AOAM531L+Jqsnnsl4pzvpfExQlCjKTvvS0aznAbCbCoQiWBJ+RjwnEB4
        BFQx4S8UPL0B65q61lFTgKY=
X-Google-Smtp-Source: ABdhPJw7Ede3RoqrrSb/6didgGleIOeULzqlblu7Ft8Cuj0HQ3xFyXuE89MUeuGh25cKDmr+WZdhPg==
X-Received: by 2002:a05:6512:ac3:: with SMTP id n3mr12435712lfu.583.1629420345244;
        Thu, 19 Aug 2021 17:45:45 -0700 (PDT)
Received: from localhost.localdomain (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.gmail.com with ESMTPSA id h6sm507244lfu.230.2021.08.19.17.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:45:45 -0700 (PDT)
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
Subject: [PATCH v7 2/4] partitions/efi: Support non-standard GPT location
Date:   Fri, 20 Aug 2021 03:45:34 +0300
Message-Id: <20210820004536.15791-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820004536.15791-1-digetx@gmail.com>
References: <20210820004536.15791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Support looking up GPT at a non-standard location specified by a block
device driver.

Acked-by: Davidlohr Bueso <dbueso@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

