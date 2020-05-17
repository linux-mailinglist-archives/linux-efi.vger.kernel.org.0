Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3F71D652E
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 04:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgEQCNa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 22:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgEQCN0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 22:13:26 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2CC05BD09;
        Sat, 16 May 2020 19:13:25 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a9so4997786lfb.8;
        Sat, 16 May 2020 19:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KallzFe5PHP8WKC6w3Y1ZV5jSqdRXTFX1hZ7ZbWUtCM=;
        b=pjPhPHV1Z8aC3mwEB2N8NeHNGFvZU4kjSZmhb0d94o+xkSA9HHvLCtqa89GsYsyTn/
         tqzgIOJfzbCMo010SsMrj9fmSHI7HE3QLVfaMfvvJsMKY10dvZGY7ZzEjeQnw+dMpb7x
         nH9pqJR5kF1DBD01CJevjAekNXMi1OIB3s1zhSH5cbr0b36yzfl5/Ey6xy96u8aNNfkI
         uxel7v2iYRq5xOGryblWglIAehafcnalZJ2H2Q812QRvYlryNv3beVn1u4khTQYsJT4l
         dWY89XKQD/CjTw4HZTbe6xyEfYN3wsSZqBPs1vlAxRkOx+4eaQ6WSthlO1+8QbilGs4j
         uiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KallzFe5PHP8WKC6w3Y1ZV5jSqdRXTFX1hZ7ZbWUtCM=;
        b=NIyLzXOJg2Q1q8pJb5OzCyZ1jSnJdHXLrUW2pgAl2rnHFtwsnACmvqui3BulEGbwkN
         LnfMoPEJUI9Ha/xPnQgDeCpr7M5exhZ4yuk8+62nObTJ8bNxTxqqKHVMa8b9vJ590iSo
         VStDZ/i5Lu1YstRoZ/8usb+GvplUBzivp+51CFfx7+He0Ehx4pSPoXCtNQXEvvI18hYG
         x0vjhePQIm4SDw2YwLcdgnk8qSsmZLuLv8UTWB5cgx1yB+OdlFBf8mpzgifUijFF6inc
         idI/8PIbQRd4ERIdbzT1ZCfZF6EPrdjBVgoqrF9LUZDhjf4txSD8MMR5JMm5NAOh41zp
         OdOg==
X-Gm-Message-State: AOAM532cPe7PSgMC/PRNl00zEDGt9zqK3t9bqjGiIHJziMzG07kSvWky
        5GZK95JMp0fZYeuXoFE/SPw=
X-Google-Smtp-Source: ABdhPJxmFIvqxiikarjBtWwEMiEq8Kqlpp2QEpWcW23x9I06U8rUUUB1IIx3Zat+4MZ+SZT5Oibbqw==
X-Received: by 2002:a05:6512:31d1:: with SMTP id j17mr73605lfe.148.1589681604124;
        Sat, 16 May 2020 19:13:24 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id z5sm3463149lji.30.2020.05.16.19.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:13:23 -0700 (PDT)
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
Subject: [PATCH v6 4/7] partitions/efi: Support GPT entry lookup at a non-standard location
Date:   Sun, 17 May 2020 05:12:22 +0300
Message-Id: <20200517021225.22890-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200517021225.22890-1-digetx@gmail.com>
References: <20200517021225.22890-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Most of consumer-grade NVIDIA Tegra devices use a proprietary bootloader
that can't be easily replaced because it's locked down using Secure Boot
cryptography signing and the crypto keys aren't given to a device owner.
These devices usually have eMMC storage that is partitioned using a custom
NVIDIA Tegra partition table format.  Of course bootloader and other
"special things" are stored on the eMMC storage, and thus, the partition
format can't be changed.

The Tegra partition format has been reverse-engineered, but NVIDIA uses
a virtually merged "boot" and "main" eMMC HW partitions in theirs
bootloader. This is not supported by Linux kernel and can't be easily
implemented. Hence partition table entry isn't accessible by kernel if
it's located at the "boot" eMMC partition. Luckily this is a rare case in
practice and even if it's the case, likely that the proprietary bootloader
will supply kernel with a non-standard gpt_sector= cmdline option.  This
gpt_sector= argument points at a GPT entry which resides at a non-standard
location on the eMMC storage.

This patch allows to support the non-standard cmdline option for NVIDIA
Tegra devices without bothering any other platforms.  The force_gpt_sector
parser-state struct member should be set before invoking efi_partition()
and it should be unset after the invocation completion.  This new parser
member instructs GPT parser to look up GPT entry at the given sector if
state->force_gpt_sector != 0.

This patch is based on the original work done by Colin Cross for the
downstream Android kernel.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 block/partitions/check.h | 1 +
 block/partitions/efi.c   | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/block/partitions/check.h b/block/partitions/check.h
index ffa01cc4b0b0..55acf6340e5b 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -22,6 +22,7 @@ struct parsed_partitions {
 	int limit;
 	bool access_beyond_eod;
 	char *pp_buf;
+	sector_t force_gpt_sector;
 };
 
 typedef struct {
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index b64bfdd4326c..34c25f708733 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -621,6 +621,15 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
         if (!good_agpt && force_gpt)
                 good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
 
+	/*
+	 * The force_gpt_sector is used by NVIDIA Tegra partition parser in
+	 * order to convey a non-standard location of the GPT entry for lookup.
+	 * By default force_gpt_sector is set to 0 and has no effect.
+	 */
+	if (!good_agpt && force_gpt && state->force_gpt_sector)
+		good_agpt = is_gpt_valid(state, state->force_gpt_sector,
+					 &agpt, &aptes);
+
         /* The obviously unsuccessful case */
         if (!good_pgpt && !good_agpt)
                 goto fail;
-- 
2.26.0

