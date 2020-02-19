Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9928D164A37
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 17:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgBSQZ3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 11:25:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46566 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgBSQZ3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Feb 2020 11:25:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id x14so958693ljd.13;
        Wed, 19 Feb 2020 08:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LGUcIpTbEbd2gKzVZah8ywZm+EFWRECsbgMwE4dPkmc=;
        b=q0KvBn7A14JQWVR1QGa6Q4b8U95+mkJ2Huoy2MrpQLM+x3CC3hwCOoVa/kQCAa2W7e
         3kjdB16EuvFpGvPNgwlDpVjhHCwgfyWIiw1IaGYXn1MSNL8IF1a1JjNAYTJc+172PpxZ
         5Z7vqbxPTifdCh9BU79UqIkJLfQlOn9qwxbCAR6Y6bIYX48nmkIJrhr87EWUuP0cRAb1
         nPTwI8k4maeYJnZeaHiA4yp3J1yLLkAkwPGFGHeMP8H9vTGdP7OdDBpI4g3rkVJ/FpVq
         d9m3b/L3RLClnokebu6bmvS9R0qn1q+RO2Ih2ptmAuXi2bVjMCusV2prdez3VivLhmuN
         AoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LGUcIpTbEbd2gKzVZah8ywZm+EFWRECsbgMwE4dPkmc=;
        b=g5WZT/6mRjPY9xhI6zebnx+kYzTg0le6DugGvUo70NNVjyPNa0zMLoxZClzlyxziW2
         K1xhLlBStU32Y/543boK6ghgI9CSmWJQrqfWxHSGw+FQfuaOAsDdGchZg/E88mhCgRN0
         wnjpZQMQzoaxobpB8ObsBA06n0x9ICK8rg0YRTSLY0FFvirUJKcRBPfq0AAVhLyd+GN9
         ldRWpkLun/T41fwlHO5cbl87VoB1dvx9jD/wj8o8oHkefcmX4CdYffwSb69ZZx3Gmy83
         kdEGJ8UWvR/OPoQkQl4j1DdBn8HLIysSD7kvL7dNIU1I7TlYW0EWR+K11WIvpKuqrqor
         LErA==
X-Gm-Message-State: APjAAAUaWjwToWqca0sUCObsG/gyBjzrWFYQWHAV0XZYOOp19uxiWDqQ
        vlO1QklsqYo0cW/lAh9Iv+jVrNUN
X-Google-Smtp-Source: APXvYqzgQTpVrzmYj7+xZaS9PwsyHhb4+lZha07RnRL0jtLKr12a2UhG+kDKXAbBvaNwDh566wCCjg==
X-Received: by 2002:a2e:b536:: with SMTP id z22mr15860746ljm.259.1582129526316;
        Wed, 19 Feb 2020 08:25:26 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id i67sm26819lfd.38.2020.02.19.08.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 08:25:25 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>,
        Colin Cross <ccross@android.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-efi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] partitions/efi: Add 'gpt_sector' kernel cmdline parameter
Date:   Wed, 19 Feb 2020 19:23:39 +0300
Message-Id: <20200219162339.16192-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The gpt_sector=<sector> causes the GPT partition search to look at the
specified sector for a valid GPT header if the GPT is not found at the
beginning or the end of block device.

In particular this is needed for NVIDIA Tegra consumer-grade Android
devices in order to make them usable with the upstream kernel because
these devices use a proprietary / closed-source partition table format
for the EMMC and it's impossible to change the partition's format. Luckily
there is a GPT table in addition to the proprietary table, which is placed
in uncommon location of the EMMC storage and bootloader passes the
location to kernel using "gpt gpt_sector=<sector>" cmdline parameters.

This patch is based on the original work done by Colin Cross for the
downstream Android kernel.

Cc: Colin Cross <ccross@android.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 block/partitions/efi.c                          | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 50138e6826a1..ee4781daa379 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1382,6 +1382,11 @@
 			primary GPT is corrupted, it enables the backup/alternate
 			GPT to be used instead.
 
+	gpt_sector	[EFI] Forces GPT partition search to look at the
+			specified sector for a valid GPT header if the GPT is
+			not found at the beginning or the end of the block
+			device.
+
 	grcan.enable0=	[HW] Configuration of physical interface 0. Determines
 			the "Enable 0" bit of the configuration register.
 			Format: 0 | 1
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index db2fef7dfc47..0c8926d76d7a 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -103,6 +103,17 @@ force_gpt_fn(char *str)
 }
 __setup("gpt", force_gpt_fn);
 
+/* This allows a kernel command line option 'gpt_sector=<sector>' to
+ * enable GPT header lookup at a non-standard location.
+ */
+static u64 force_gpt_sector;
+static int __init
+force_gpt_sector_fn(char *str)
+{
+	WARN_ON(kstrtoull(str, 10, &force_gpt_sector) < 0);
+	return 1;
+}
+__setup("gpt_sector=", force_gpt_sector_fn);
 
 /**
  * efi_crc32() - EFI version of crc32 function
@@ -621,6 +632,10 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
         if (!good_agpt && force_gpt)
                 good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
 
+	if (!good_agpt && force_gpt && force_gpt_sector)
+		good_agpt = is_gpt_valid(state, force_gpt_sector,
+					 &agpt, &aptes);
+
         /* The obviously unsuccessful case */
         if (!good_pgpt && !good_agpt)
                 goto fail;
-- 
2.24.0

