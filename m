Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741181D6547
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 04:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgEQCNm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 22:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgEQCNa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 22:13:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EA5C061A0C;
        Sat, 16 May 2020 19:13:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z22so5019461lfd.0;
        Sat, 16 May 2020 19:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IP+BxwWBlUXPBXueysYxAs7IO8akrsULJxsrGPOeSI4=;
        b=alkOYhWoh0I4SWI+iJRQxVVq1CGW8TrvfXWvV30WKoUHOCg3r1qTvSq82tkNWTBZQf
         45c0vKhHCGVyaOd8ziMJPljE9XCwfy4A7YqXZimf/+oEGbevVMfGPG1iNDT0WznfhLyu
         ISQ25Ry5szHMAns2p86MDOnRw6EFvHpKOApKn8w8/uxGvKTOM58NaoOOFIsHHmTs1FJa
         n3y3nJFwpWOVJcQmm7yoFPEn4Bg1E22UIirhQ0dbwB/jglCZHpmNiO87X1gapuu4gZHg
         kCERjV//1XSAwpfVdO+6GxeHNsiaSKQvsHkkRKhh7E1Gc0F3m2nlNpP0fwuwOoiFQnBh
         9kwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IP+BxwWBlUXPBXueysYxAs7IO8akrsULJxsrGPOeSI4=;
        b=PgFUfe/03wfXg0ibYdj2lZ40tEjmu8FSMQ55H3vu8gotmkw/dukJUAAmIkVy/NX2l/
         zY3cDBg6pnbQYYo3XMm7hE9BbMHqCM10SX6X3GR1MYmrGDd67Vk49C4uTncKeQxrQ89x
         KE08pQ3K0t5h4ylHl/AFJj/bGzoYB9agm8AirKsK9ShOcYgs4OSoY68gWAKxj+DHKjFk
         L6YnxV6Qzql/ZtJL4R1a686o1+9z3Sxa5N1OplWaocCl5cvKBj8oPpJyO/796hNEZ8X+
         4cCNitVPBFLYEA2SClSnMBMkvedW+BLrAvLK0aMdF+XBmH4TALSScvqx7non2pDul3p9
         WCvQ==
X-Gm-Message-State: AOAM5313/B3CLniixNmGzfY1nkFTBwISm//rBa0D28VRsDf82cVM4B/q
        iBEJ1JREPvDQ3LxE7FF41Fk=
X-Google-Smtp-Source: ABdhPJw/bVQ87JUqY1gbJ5Zx5GeauhxKMkNWBv6w6r3pUsmAkL58Iy1NMM7z5kcFfr/P2a/OqJzhYA==
X-Received: by 2002:ac2:5e24:: with SMTP id o4mr7014363lfg.37.1589681607261;
        Sat, 16 May 2020 19:13:27 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id z5sm3463149lji.30.2020.05.16.19.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:13:26 -0700 (PDT)
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
Subject: [PATCH v6 6/7] partitions/tegra: Support enforced GPT scanning
Date:   Sun, 17 May 2020 05:12:24 +0300
Message-Id: <20200517021225.22890-7-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200517021225.22890-1-digetx@gmail.com>
References: <20200517021225.22890-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Downstream NVIDIA bootloader provides gpt_sector=<sector> kernel command
line option to the kernel. This option should instruct the GPT partition
parser to look at the specified sector for a valid GPT header if the GPT
is not found at the beginning or the end of a block device. Support of
this feature is needed by Tegra-based devices that have TegraPT and GPT
placed in inaccessible by kernel locations.  The GPT entry duplicates
TegraPT partitions.

Secondly, some Tegra-based devices have bootloader that enforces the GPT
scanning of the backup/alternative GPT entry by providing "gpt" cmdline
option to the kernel, but doesn't provide the "gpt_sector" option.
In this case GPT entry resides at a special offset from the end of eMMC
storage.  It is a common situation for older bootloader versions.

The offset is calculated as a total number of eMMC sectors minus number of
eMMC boot sectors minus 1.  This equation is explicitly defined and used
by the downstream Tegra kernels for locating GPT entry.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 block/partitions/check.h |  1 +
 block/partitions/core.c  |  1 +
 block/partitions/efi.c   |  9 +++++++
 block/partitions/tegra.c | 57 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/block/partitions/check.h b/block/partitions/check.h
index 55acf6340e5b..1ce445d1c7f0 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -68,5 +68,6 @@ int osf_partition(struct parsed_partitions *state);
 int sgi_partition(struct parsed_partitions *state);
 int sun_partition(struct parsed_partitions *state);
 int sysv68_partition(struct parsed_partitions *state);
+int tegra_partition_forced_gpt(struct parsed_partitions *state);
 int tegra_partition(struct parsed_partitions *state);
 int ultrix_partition(struct parsed_partitions *state);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 0b4720372f07..1931647d9742 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -83,6 +83,7 @@ static int (*check_part[])(struct parsed_partitions *) = {
 	sysv68_partition,
 #endif
 #ifdef CONFIG_TEGRA_PARTITION
+	tegra_partition_forced_gpt,
 	tegra_partition,
 #endif
 	NULL
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index f0229e7a6894..f8036fd55501 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -101,6 +101,15 @@ static int force_gpt;
 static int __init
 force_gpt_fn(char *str)
 {
+	/*
+	 * This check allows to properly parse cmdline variants like
+	 * "gpt gpt_sector=<sector>" and "gpt_sector=<sector> gpt" since
+	 * "gpt" overlaps with the "gpt_sector=", see tegra_gpt_sector_fn().
+	 * The argument should be absent for a boolean cmdline option.
+	 */
+	if (strlen(str))
+		return 0;
+
 	force_gpt = 1;
 	return 1;
 }
diff --git a/block/partitions/tegra.c b/block/partitions/tegra.c
index d3a00ade145a..831dedb9a11c 100644
--- a/block/partitions/tegra.c
+++ b/block/partitions/tegra.c
@@ -565,3 +565,60 @@ int tegra_partition(struct parsed_partitions *state)
 
 	return ret;
 }
+
+/*
+ * This allows a kernel command line option 'gpt_sector=<sector>' to
+ * enable GPT header lookup at a non-standard location. This option
+ * is provided to kernel by NVIDIA's proprietary bootloader.
+ */
+static sector_t tegra_gpt_sector;
+static int __init tegra_gpt_sector_fn(char *str)
+{
+	WARN_ON(kstrtoull(str, 10, &tegra_gpt_sector) < 0);
+	return 1;
+}
+__setup("gpt_sector=", tegra_gpt_sector_fn);
+
+int tegra_partition_forced_gpt(struct parsed_partitions *state)
+{
+	int ret = 0;
+
+#ifdef CONFIG_EFI_PARTITION
+	struct tegra_partition_table_parser ptp = {};
+
+	if (!soc_is_tegra() || !tegra_boot_sdmmc)
+		return 0;
+
+	ptp.state = state;
+
+	ptp.boot_offset = tegra_partition_table_emmc_boot_offset(&ptp);
+	if (ptp.boot_offset < 0)
+		return 0;
+
+	/*
+	 * Some Tegra devices do not use gpt_sector=<sector> kernel command
+	 * line option. In this case these devices usually have a GPT entry
+	 * at the end of the block device and the GPT entry address is
+	 * calculated this way for eMMC:
+	 *
+	 * gpt_sector = ext_csd.sectors_num - ext_csd.boot_sectors_num - 1
+	 *
+	 * This algorithm is defined and used by NVIDIA in the downstream
+	 * kernel of those devices.
+	 *
+	 * Please note that bootloader supplies the "gpt" cmdline option
+	 * which enforces the GPT scanning, meaning that the scanning will
+	 * be a NO-OP on devices that do not use GPT.
+	 */
+	if (tegra_gpt_sector) {
+		state->force_gpt_sector = tegra_gpt_sector;
+	} else {
+		state->force_gpt_sector  = get_capacity(state->bdev->bd_disk);
+		state->force_gpt_sector -= ptp.boot_offset + 1;
+	}
+
+	ret = efi_partition(state);
+	state->force_gpt_sector = 0;
+#endif
+	return ret;
+}
-- 
2.26.0

