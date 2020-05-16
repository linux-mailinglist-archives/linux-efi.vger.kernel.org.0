Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A421D6231
	for <lists+linux-efi@lfdr.de>; Sat, 16 May 2020 17:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgEPPhV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEPPhT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 11:37:19 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1CCC05BD09;
        Sat, 16 May 2020 08:37:18 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g1so5344888ljk.7;
        Sat, 16 May 2020 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hY+h+hQNft22sbR2GRHdulgy1g8os6lzLdmN2sCZ1lE=;
        b=W5o9sYz66CM1jaHftKzu53qc4tndJdJyEpks307TEOIhx05twGZL58yXzc2rm/fmF3
         gY+hiG81x5eadB2JrGXiyQ5Pq9PAXhWZofEox+oFkF/7Bn+lejFkpC4rLVPpJ+nPmh43
         uaigifY9LwaZYHMqzEfUPVFF8mVByFQuvsQ2aPip/YUZh6H7pCeMxsI5Q9R1tco0uwrk
         sy2C4dM/p6PSHVmiQt2LqUeXks8DkEoh8SBfwUKf5Hb/8Kjyd/cALFqIJw2s8rMOpfLq
         HngheLBsMaWMVMEAYbcsaeT40D1K3bT/1pwCQDOaLHzmJmCDklXf+rfs+bUp0Hw7oCZT
         GowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hY+h+hQNft22sbR2GRHdulgy1g8os6lzLdmN2sCZ1lE=;
        b=lzV85Z9YK6LtsbMB3HhgxWxa4Jrp6oZw/r0Q6SGID2MixM+leUj4KHvrlxjbO9MG6y
         OZIifyR9EdNc+Yje/6pLU05rK29ajelts7aPjdkzByIJGFnCQIdIc+8je4oIEbVojeCZ
         obJMy/hiEG91mWEx1t2vmgGhff7RDKKDedC5UqIC1q4UQXRKrzTwKHx4hSBVljeyTczk
         T2wDt3EWALfiVddY0kw+3YHfvbhMR5sThzgxlXYN+8KJWXGgtv1L5yfHxFjHL9pyaULi
         T+aeOWR/b4IYu/6ulzQ1d7U7J4k8lYhLxCFVCv/uXWllAqQeCxqdeUnbYcNkYn5ng5Ou
         7X7Q==
X-Gm-Message-State: AOAM5313RNTLMFwAgkoCF6VeDxZ9l+H6BcbQHkuwUM8x5bLSPkI3hldO
        ELoD2vBJq4CSyORUpCXzi0uTzHlJ
X-Google-Smtp-Source: ABdhPJyf4prqs2e1qsAwyKo3RPBy4DbONUEjYYWDpAq4jeUWnpTlFo7a2DK8Y1jb12R6CVG+yCAcfg==
X-Received: by 2002:a2e:8997:: with SMTP id c23mr845199lji.22.1589643437449;
        Sat, 16 May 2020 08:37:17 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id a12sm2845356ljj.64.2020.05.16.08.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 08:37:16 -0700 (PDT)
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
Subject: [PATCH v5 1/6] mmc: core: Add raw_boot_mult field to mmc_ext_csd
Date:   Sat, 16 May 2020 18:36:39 +0300
Message-Id: <20200516153644.13748-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200516153644.13748-1-digetx@gmail.com>
References: <20200516153644.13748-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In order to support parsing of NVIDIA Tegra Partition Table format, we
need to know the BOOT_SIZE_MULT value of the Extended CSD register because
NVIDIA's bootloader linearizes the boot0/boot1/main partitions into a
single virtual space, and thus, all partition addresses are shifted by
the size of boot0 + boot1 partitions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/mmc.c   | 2 ++
 include/linux/mmc/card.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4203303f946a..112edfb1eb1d 100644
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
index 7d46411ffaa2..cd6b58b66010 100644
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
2.26.0

