Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DBE1D6527
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 04:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgEQCNW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 22:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgEQCNW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 22:13:22 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95463C05BD09;
        Sat, 16 May 2020 19:13:21 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c12so1535284lfc.10;
        Sat, 16 May 2020 19:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hY+h+hQNft22sbR2GRHdulgy1g8os6lzLdmN2sCZ1lE=;
        b=GPP3hSlo2wSqNyGaaNBBg/CYUQSC947sEWJo/EBTwgMA026FZUzYgtVzSp2ARC96Jr
         BFpGSQj6LJP6JWmX9r0Vqg5IFui8pixqCgFa+kdcvLVX5RjRGnjMKzaULQf8GgXoOBE+
         tTFUweVwUIL66wqPgTTrr5BrEnM7z3cNuoajF+HZZrDtoda3qOzwbxsnogoW4jUgR1GI
         9lK33cRMOL0vePFs+VxvgIsnkvixTAqWrybucs1hFIK+I27ucvUO4xU1aqZMjDGNvYxe
         LP7SJ9GpjD/LyBSINDeOeMJtDZOl30QazCK0wxUdHmMxjhyt+tU3xnYlystt1lMIgIRK
         F3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hY+h+hQNft22sbR2GRHdulgy1g8os6lzLdmN2sCZ1lE=;
        b=OsC2w+5I72iPPYxkODBThKXZocqeQsZMnd1GKLV20UuI5I6Nde+qOmoap6acjxzo3O
         1wQARU+YxwDe8a2laaPdaLglZlEke/4weJstx/+fdpdRSldhrrC2eR+yCPOy/WyZ1qQL
         4761HYxNs3Ys5LN67P/kEkcosuE6joFv1oMHNcLNbBqfwrTXZb2X9Qe5hg+51wrmrkOe
         zgTa58S2B5x/pCyI4ggIBQTMocB4jC13NXV+U7xwJRC3Ux9boCcWBs7UJ32nwailwpQf
         9FZnkPc5t92bFWdbQBzi/Dxu3DWiz6jChQdWmcx+i3CtZ9I15V9zuyZOaR+r1UZKeHuV
         IeoA==
X-Gm-Message-State: AOAM533irX4Oqcc3iyeycjFltQ615zbiqJDfWkoArKpcfKu/rX/8tNGY
        dYB8a0utywyiSSDM8udJJEQ=
X-Google-Smtp-Source: ABdhPJzWLG4SrgwuLfMGrs1OkODqENpWxx7JLW4U+iqms6vvO/Le8pvVJpm+CkAYvRzKRl4BJhmqNA==
X-Received: by 2002:ac2:48b2:: with SMTP id u18mr6825402lfg.122.1589681600108;
        Sat, 16 May 2020 19:13:20 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id z5sm3463149lji.30.2020.05.16.19.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:13:19 -0700 (PDT)
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
Subject: [PATCH v6 1/7] mmc: core: Add raw_boot_mult field to mmc_ext_csd
Date:   Sun, 17 May 2020 05:12:19 +0300
Message-Id: <20200517021225.22890-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200517021225.22890-1-digetx@gmail.com>
References: <20200517021225.22890-1-digetx@gmail.com>
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

