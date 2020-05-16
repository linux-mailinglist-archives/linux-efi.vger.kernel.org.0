Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473201D6237
	for <lists+linux-efi@lfdr.de>; Sat, 16 May 2020 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgEPPh2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 11:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEPPhY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 11:37:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A179DC05BD09;
        Sat, 16 May 2020 08:37:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f18so5333212lja.13;
        Sat, 16 May 2020 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DphE2nru8seGNBj+2DlwSofEvoZcn/+YUXOvNykfsiA=;
        b=OSdcxKwtbFa/nJZp8XhJ/6pmSfpIYc8T1Inne6GGlCmm7mIehZQrJV5twsuffFobQ+
         /RJPhNY8Otq4cwBVIpAgX2bqm7Ktr8KeWszSqKCJQmGVRRkp0C1XSH++gx523QT54J1z
         ql5lxEdnI+imfKU99vQUg0lS526zJNdELTVaAryHEZ+lWZkXMsLwWMChmJ7im11R+lET
         DYb69gaPkFH7eUG1MYF8Yc7ars897rgVJ3YpqFr/jPb2CouMyqyITSIpWCNTfzNGd3QN
         Im7zZiP65IlewRhKqfPqsVPKzwyvw4H9tImZv+Fdro8G2UXNnfrNuG7td+qwqL1NwSKP
         WMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DphE2nru8seGNBj+2DlwSofEvoZcn/+YUXOvNykfsiA=;
        b=ujsJoWzwiYNj2EtQzj1WN/r4Yz/qtVujiSRyKEjDopzikYCMk7IRwL/Ae/4Zu0wXBz
         mMmLowKUIndeaerygokZwAYR0xbE343yJLiLZaITc1LFljAy5O0N6Wj+JP7V3LK0W0JL
         RMVcjLe/E1q4J6TKrhSw5nIqoz3kv+6ROPS+ADp4VmsomovwGyk4Kj5oE8+7OH9R6MDq
         LJOEwD4rkgNNf+D0CzaFuOOg9b+B4lifFDObcBNxd4+U9macW3ewfdVmaPMxEUhCtLCb
         md3Ye/91+7yZM2iH1C7sirBmnhTZ/wxqxqMgVchDodUPdUGnb9uwC8yiWn60OLdn6mwS
         J1EA==
X-Gm-Message-State: AOAM5310lbmSzwtx0WWxYR3F7AGcJjpVGaXUeI5/Q9pp36G1H6H/BigX
        6/jNTHrN7aCqHd1yk04BQGs=
X-Google-Smtp-Source: ABdhPJxDecFzuhnokZ2yW1fqYI8YBMbAJPUIi9NCG0nyg1Sz1rX0AWo+3KZbT1STBMsugq99zXHlow==
X-Received: by 2002:a2e:9a41:: with SMTP id k1mr2857432ljj.143.1589643442035;
        Sat, 16 May 2020 08:37:22 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id a12sm2845356ljj.64.2020.05.16.08.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 08:37:21 -0700 (PDT)
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
Subject: [PATCH v5 4/6] partitions/efi: Support GPT entry lookup at a non-standard location
Date:   Sat, 16 May 2020 18:36:42 +0300
Message-Id: <20200516153644.13748-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200516153644.13748-1-digetx@gmail.com>
References: <20200516153644.13748-1-digetx@gmail.com>
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
 block/partitions/efi.c   | 8 ++++++++
 2 files changed, 9 insertions(+)

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
index b64bfdd4326c..3af4660bc11f 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -621,6 +621,14 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
         if (!good_agpt && force_gpt)
                 good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
 
+	/* The force_gpt_sector is used by NVIDIA Tegra partition parser in
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

