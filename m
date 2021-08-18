Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57283EF71A
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 02:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhHRA5v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 20:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbhHRA5v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 20:57:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC3AC061764;
        Tue, 17 Aug 2021 17:57:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p38so1009676lfa.0;
        Tue, 17 Aug 2021 17:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I01H5a6uHWni87egbbK4J+JI32iz47EYQ+sGtHJn9C8=;
        b=N6JSsp07CpZCty+GpUO8Ix550NiKbjjfrr3MgQs6vBbp0jeZ2mo4YGpEwCfpOyU2fS
         XbLBOGzidYQAvvw8vr521Wfpl+G2A0uhBOv5Ao/+qI26ERIW6HSeqZLCqYDifZcjDq7V
         9pYnMVA8yeHjOAcvrbyHnCEaB6qUMYtaIpihhyQIVj5zwzxDkX3Ku8fXTkHrxv4yO0gd
         4gvZLn8FQk0/6d40xcXz0BDe5lbAZSWFO1PZ8yABdh2ImVq9iJ/txZD2BbBFpnRHtKx7
         Di2clJlPnhcSvfIcXGgy8BEivwI85p1b2C8e22q8TlT7KjTgiK9pzkW2eaUG1gSu6aps
         cQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I01H5a6uHWni87egbbK4J+JI32iz47EYQ+sGtHJn9C8=;
        b=ibwHReew4h90c7iobA+39RBGbbzJllBg5SHAflYA3TcYr+jl0OC/AVw4BxNwQtkT9k
         olC810k00mCjnf/HJMEz/xVY2WIVOeZX+XSlJVE/SkP+Y2JWV6g/GdsxQ9ij42HhfCvF
         BJWri+JrHZk7quRN69h0q7SQfT7SZV1VBCdRze6OKn/ab051GTtBWhE8U1IoVtlRBqWg
         H2v+7GURP6sm4HKYTod+dPiFiJJHp+3W5mUG2UMvg1WadJsHAvqWFmN8tMWW94ej5g2k
         BBMvLMT3pljQPTLfxixUcBfZrOUA+sXKTX0rbEHe7Zj7HA34BwzTWOoP8igkfYIrqhDw
         0JDg==
X-Gm-Message-State: AOAM533BZxYgAhdi2c9hyLxWYqt/vr2vMGVQtKAg1xMJliV/H28Qmu+Q
        JZGQKuKhEHs3nBJtqJl70kI=
X-Google-Smtp-Source: ABdhPJyM2Pw5uNedmsQZXhYwx6gDYixKDMuB77RrrxaMT/g2PWwc2DQwvCordjK6ChUFqDanxd6hBA==
X-Received: by 2002:ac2:428a:: with SMTP id m10mr4503044lfh.636.1629248235291;
        Tue, 17 Aug 2021 17:57:15 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id h19sm335879lfu.138.2021.08.17.17.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 17:57:14 -0700 (PDT)
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
Subject: [PATCH v5 5/5] partitions/efi: Support non-standard GPT location
Date:   Wed, 18 Aug 2021 03:55:47 +0300
Message-Id: <20210818005547.14497-6-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818005547.14497-1-digetx@gmail.com>
References: <20210818005547.14497-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Support looking up GPT at a non-standard location specified by a block
device driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 block/partitions/efi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index aaa3dc487cb5..b9509f445b3c 100644
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
 
@@ -619,6 +621,17 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
         if (!good_agpt && force_gpt)
                 good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
 
+	if (!good_agpt && force_gpt && fops->alternative_gpt_sector) {
+		struct block_device *bdev = disk->part0;
+		sector_t agpt_sector;
+		int err;
+
+		err = fops->alternative_gpt_sector(bdev, &agpt_sector);
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

