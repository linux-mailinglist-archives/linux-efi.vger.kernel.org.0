Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821651D4322
	for <lists+linux-efi@lfdr.de>; Fri, 15 May 2020 03:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgEOBnC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 May 2020 21:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgEOBm4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 May 2020 21:42:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672DBC061A0C;
        Thu, 14 May 2020 18:42:55 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u15so489357ljd.3;
        Thu, 14 May 2020 18:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JVySzFwgY7e8nHIHJ3dU/d0fc76IF5fhtoXaTUTq3/w=;
        b=hoPx86lkMv329DILvtpon/Ajyu7+1OY5peruM7Vg7+OAXk+r+u7VTEqeBI+fmttHtB
         /RGZ79ojlFV98bYnoLGwRB/pr0w/iPGJwSJOp9NS05gIssx2cos+rU2DyX4HPL+66ohJ
         t5aFvt7PrCrUu79cvVD00vCpzZubK8MizHyf1rxztNhRROl1ur4byd/Hk5hTwEV3BcAr
         MTWn6M6FkwILuWpkHkHe1LFb3hqmhtxb1fSVCvWKmcisQLT46z6SY7ZfYE76Bx1W+kgK
         QdN5qSbO3gi55jgShl3JntW2B46hWZt8Y53TMnfC90PCN43Ge3X4GBPMA60lg3KqPek7
         3XUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVySzFwgY7e8nHIHJ3dU/d0fc76IF5fhtoXaTUTq3/w=;
        b=Y91qKHyJJ1+2F0lLEtzE4CPHTszddjUll+Wqro8VsZ5VldV6tRn5BKz7394S7mHhAB
         i1clpTBJJRB9wZ5OKfAaqq4Kll+ROvFI6kymhNFgBElk04KB3sZgz++oMoX8pjRdzuZR
         /533PDWi+Wnx0cPQ0CUN3rHjanUUYsXImWwpHxWXb62RJZXVynyaK2ElUYk5W6/40NUb
         f1shMm1nq9dRtvSLoYonnsUf7PA3OrbDyjlIGAN/7Koo0WcRULaDdQVuaI1O71dFjqDl
         4x5U7iWpcxLpizbCaehXfjvAXg6YSbcVHvYoD/teH/Daytkqrb3c1l/boGPDXXodpMaU
         UMow==
X-Gm-Message-State: AOAM531+DvwVMcj4VUU37viJR5LmfTlxKZ/FbdjgQP1fKnOdt1D1gJmt
        nrB7jIknkbpQ0VeQed5rkPA=
X-Google-Smtp-Source: ABdhPJxkl15/TS/h0JiR0KBnsPh+lDA/C79Y/X8zJyP/oDmmlGQXUNVcNHzTOB+r9/XLVL38oaoUpA==
X-Received: by 2002:a2e:b4a5:: with SMTP id q5mr701391ljm.58.1589506973705;
        Thu, 14 May 2020 18:42:53 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id i1sm309669lja.3.2020.05.14.18.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 18:42:53 -0700 (PDT)
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
Subject: [PATCH v4 5/6] partitions/tegra: Support gpt_sector= command line option
Date:   Fri, 15 May 2020 04:41:42 +0300
Message-Id: <20200515014143.12984-6-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200515014143.12984-1-digetx@gmail.com>
References: <20200515014143.12984-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The gpt_sector=<sector> causes the GPT partition parser to look at the
specified sector for a valid GPT header if the GPT is not found at the
beginning or the end of a block device.  This is needed by Tegra-based
devices that have TegraPT and GPT placed in inaccessible by kernel
locations.  The GPT entry duplicates TegraPT partitions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 block/partitions/check.h |  1 +
 block/partitions/core.c  |  1 +
 block/partitions/efi.c   |  6 ++++++
 block/partitions/tegra.c | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/block/partitions/check.h b/block/partitions/check.h
index ffa01cc4b0b0..ff07435b3ac3 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -67,5 +67,6 @@ int osf_partition(struct parsed_partitions *state);
 int sgi_partition(struct parsed_partitions *state);
 int sun_partition(struct parsed_partitions *state);
 int sysv68_partition(struct parsed_partitions *state);
+int tegra_partition_gpt(struct parsed_partitions *state);
 int tegra_partition(struct parsed_partitions *state);
 int ultrix_partition(struct parsed_partitions *state);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 0b4720372f07..ece70f15f24d 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -83,6 +83,7 @@ static int (*check_part[])(struct parsed_partitions *) = {
 	sysv68_partition,
 #endif
 #ifdef CONFIG_TEGRA_PARTITION
+	tegra_partition_gpt,
 	tegra_partition,
 #endif
 	NULL
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 48e4c2aeeded..f3b26be2bd6e 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -98,6 +98,12 @@ static int force_gpt;
 static int __init
 force_gpt_fn(char *str)
 {
+	/* This check allows to parse "gpt gpt_sector=" properly since
+	 * "gpt" overlaps with "gpt_sector", see tegra_gpt_sector_fn().
+	 */
+	if (force_gpt)
+		return 0;
+
 	force_gpt = 1;
 	return 1;
 }
diff --git a/block/partitions/tegra.c b/block/partitions/tegra.c
index d1b84fff362c..c2dae0f32c2a 100644
--- a/block/partitions/tegra.c
+++ b/block/partitions/tegra.c
@@ -30,6 +30,7 @@
 #include <soc/tegra/common.h>
 #include <soc/tegra/partition.h>
 
+#include "efi.h"
 #include "check.h"
 
 #define TEGRA_PT_SECTOR_SIZE(ptp)	((ptp)->logical_sector_size / SZ_512)
@@ -563,3 +564,40 @@ int tegra_partition(struct parsed_partitions *state)
 
 	return ret;
 }
+
+/*
+ * This allows a kernel command line option 'gpt_sector=<sector>' to
+ * enable GPT header lookup at a non-standard location. This option
+ * is given to kernel by a proprietary bootloader, which is used by
+ * *most* (but not all) of NVIDIA Tegra-based devices.
+ */
+static sector_t tegra_gpt_sector;
+static int __init tegra_gpt_sector_fn(char *str)
+{
+	WARN_ON(kstrtoull(str, 10, &tegra_gpt_sector) < 0);
+	return 1;
+}
+__setup("gpt_sector=", tegra_gpt_sector_fn);
+
+int tegra_partition_gpt(struct parsed_partitions *state)
+{
+	int ret = 0;
+
+#ifdef CONFIG_EFI_PARTITION
+	struct tegra_partition_table_parser ptp = {};
+
+	if (!soc_is_tegra() || !tegra_boot_sdmmc || !tegra_gpt_sector)
+		return 0;
+
+	ptp.state = state;
+
+	ptp.boot_offset = tegra_partition_table_emmc_boot_offset(&ptp);
+	if (ptp.boot_offset < 0)
+		return 0;
+
+	force_gpt_sector = tegra_gpt_sector;
+	ret = efi_partition(ptp.state);
+	force_gpt_sector = 0;
+#endif
+	return ret;
+}
-- 
2.26.0

