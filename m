Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B6E1D4335
	for <lists+linux-efi@lfdr.de>; Fri, 15 May 2020 03:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgEOBmv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 May 2020 21:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgEOBmu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 May 2020 21:42:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9070C061A0C;
        Thu, 14 May 2020 18:42:49 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e25so475450ljg.5;
        Thu, 14 May 2020 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hY+h+hQNft22sbR2GRHdulgy1g8os6lzLdmN2sCZ1lE=;
        b=hpYWXz9cOLo7O2IXWeM/JpwktEaIYJmYkUm63rJSdzrIZjaGXcK4WfSKmzz7w8TNW4
         pLM2wkRdRjyfJhO02BxNVSg52g1gi5peBx2hg0hoHOJIxiPMPHwvbfxGO44kMDv564jZ
         SBYLnd9x4lR3IzHMLryyc9FOq175xqOJrieCe4GmocyGfQuK1kfsYOrTxhKpO7Psy7Cj
         EXFL951nV0VHsMiKrX/ROuOHE4PWR2iiMhJ4wcwtF/M5fupE6nBLSyZjJstCwAvdk56G
         G9tIJDV6fp8jNeIUMWtBu5Pws0yi5zmKgfFz4WYizcsJohwQ2g5MwoGXCfp72gZv0dlA
         Ye0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hY+h+hQNft22sbR2GRHdulgy1g8os6lzLdmN2sCZ1lE=;
        b=cagLZ0b3Vt2JG+1O8Shbkjsy4XJ13WeLM5HzUwujYd8kyRoNxb6YUK7xPyp0hTdGam
         uMDWyP//KnMRQrTK+SMwJ4AXsnnnBDvKDBhUP6VV/3xbWuSnAP6IMHM81giVWNTD/xgu
         W7dpgpqM8KwmMgH7hgUS89/rtU+9K7VAen+5JF+iVWP5+JwJUQvv77CIPo5IrNMGnV1Q
         NOACXuORFkYQgmqxsG1C18gtEHdcUAaQaetIbTMvIPOL0Tp4vfeQ5YCADZ991QxnFKiu
         sQn3AHrT4gt/xWoLgWWAWTJ8FYb9MBWJ64wLhEb2ni/ZpRoKYkNXi3piTK+WrpyWUvdU
         Nl3g==
X-Gm-Message-State: AOAM53174e49C9uFEbJRocms/5u3Ug/GM61z+jz98Ysx2fSFxxXKkHCA
        djwKetYyLB/Rz1+XwTLoNQI=
X-Google-Smtp-Source: ABdhPJwXJTmffyGCIHEU0fLqa8XYSSYSNQU3NSvh1kPxhok4OLg+x9AfceTzW+o/4yurd0Tx+klhOA==
X-Received: by 2002:a2e:731a:: with SMTP id o26mr652912ljc.189.1589506968312;
        Thu, 14 May 2020 18:42:48 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id i1sm309669lja.3.2020.05.14.18.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 18:42:47 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v4 1/6] mmc: core: Add raw_boot_mult field to mmc_ext_csd
Date:   Fri, 15 May 2020 04:41:38 +0300
Message-Id: <20200515014143.12984-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200515014143.12984-1-digetx@gmail.com>
References: <20200515014143.12984-1-digetx@gmail.com>
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

