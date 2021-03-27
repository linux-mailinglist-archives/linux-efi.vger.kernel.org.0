Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3FA34B972
	for <lists+linux-efi@lfdr.de>; Sat, 27 Mar 2021 22:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhC0VXs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Mar 2021 17:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhC0VX1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Mar 2021 17:23:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C750C0613B1;
        Sat, 27 Mar 2021 14:23:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b4so12830224lfi.6;
        Sat, 27 Mar 2021 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58S4X7JxMmetPUnkJUn5hJXElYMwpzhg1naqTswJrNE=;
        b=TrAfuz8zS+s2uhKyacOPzZmAcdf9SyqCmnzlxgFhxX1yem0elFBkQH1UiVCBvjmGxL
         3SJAhYTuia+6h/Vm0AOYH1w4X5kBJpvlff572OORu38shDba4FV3d2qmfH1T527k/bJ+
         FFXofGea+/JQ8NSB1GG/berPS/KIEselOs0jSSuoUD0D+DVJwDiEj3yqaQiravQ4jam7
         PwBs5JwddKvgXclv+zKjvjjp0m33kkMk9HjLbAbeunntwVXYwsz8UM72qK8PKwJg8p9y
         7xVXEX1NeHiDAL+Kw/8/4SS2VSVO39nqOyknjAp31DLKJgqjOgQZmuEcLxFm9hyshnz3
         E5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58S4X7JxMmetPUnkJUn5hJXElYMwpzhg1naqTswJrNE=;
        b=WLX7Y2SBLSXHqAj2TCo0BKT2OzNhrByQg4ulZQCr3OCNf4FD23v1y1BDS/0U89x4EU
         r+HU26kgVb6dGAQAwAeRPwFpK9Y4/VKpIWcloAtwyQolsLeZ4L7ttXA8w0xycwqdV3wk
         Jt5eodV09Wwehy36tY584wNkBg2g7tORBfT+FnUZnIAIPRq5QlQqS0XXQMwodQ0F3xMu
         ycWCl3oKM2x3RGDs4UB42klOi01jgpspY1/+AkXbyZrlDiZHUEZT/a1ctEGXHquowvIB
         kSY3KzGnVcTqmE9BqM+FESaY6IRWOndG+X42Ivmeew3AcEokBsfbGH82z8blBAUItrlJ
         PyLQ==
X-Gm-Message-State: AOAM533RnaMzVauqUUnJyU5VoU15MPfxbCxumKBKHPPovFc6b7q9yGI0
        HMOTw8EdZV5HeK1CPpYeC0E=
X-Google-Smtp-Source: ABdhPJyeBHQvW6VWseVPNi6sZ4qmpW+9sf9/yy7WZw2xl9b+dzuBPKO9+1f2sv0rmlX2hb/BJakjkQ==
X-Received: by 2002:a05:6512:ac6:: with SMTP id n6mr12117150lfu.471.1616880204584;
        Sat, 27 Mar 2021 14:23:24 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-66.dynamic.spd-mgts.ru. [109.252.193.66])
        by smtp.gmail.com with ESMTPSA id x7sm1300626lfe.182.2021.03.27.14.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 14:23:24 -0700 (PDT)
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
Subject: [PATCH v1 1/3] mmc: core: Add raw_boot_mult field to mmc_ext_csd
Date:   Sun, 28 Mar 2021 00:20:58 +0300
Message-Id: <20210327212100.3834-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210327212100.3834-1-digetx@gmail.com>
References: <20210327212100.3834-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Bootloader of NVIDIA Tegra devices linearizes the boot0/boot1/main
partitions into a single virtual space, and thus, all partition addresses
are shifted by the size of boot0 + boot1 partitions.  The offset needs to
be known in order to find the EFI entry on internal EMMC storage of Tegra
devices.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/mmc.c   | 2 ++
 include/linux/mmc/card.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8741271d3971..ed29f6076472 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -417,6 +417,8 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT];
 	card->ext_csd.raw_hc_erase_grp_size =
 		ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE];
+	card->ext_csd.raw_boot_mult =
+		ext_csd[EXT_CSD_BOOT_MULT];
 	if (card->ext_csd.rev >= 3) {
 		u8 sa_shift = ext_csd[EXT_CSD_S_A_TIMEOUT];
 		card->ext_csd.part_config = ext_csd[EXT_CSD_PART_CONFIG];
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f9ad35dd6012..720e2a1ac1cd 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -109,6 +109,7 @@ struct mmc_ext_csd {
 	u8			raw_hc_erase_gap_size;	/* 221 */
 	u8			raw_erase_timeout_mult;	/* 223 */
 	u8			raw_hc_erase_grp_size;	/* 224 */
+	u8			raw_boot_mult;		/* 226 */
 	u8			raw_sec_trim_mult;	/* 229 */
 	u8			raw_sec_erase_mult;	/* 230 */
 	u8			raw_sec_feature_support;/* 231 */
-- 
2.30.2

