Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173B41D4327
	for <lists+linux-efi@lfdr.de>; Fri, 15 May 2020 03:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgEOBnM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 May 2020 21:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbgEOBmy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 May 2020 21:42:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E371EC05BD43;
        Thu, 14 May 2020 18:42:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l19so453266lje.10;
        Thu, 14 May 2020 18:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXpSXkZ/8Hfb2Ijnh+LYOs0qAyDxWCL/20mt+D8uMOs=;
        b=RawQUcqCrY6FrUwunWV9jJ1fcJHOQgZ2Fi5I+37lY73PGpBBngX9TN+0xsN9yNRVrJ
         xRTrcz4FbAKvanXkCqlN1GPcpSWu+S6X1GtYDW1cyinoDTqCR3Gk/BM9M35lssG7ZA28
         6E0F1Y1RUIwT0rVyx/dcChZw3NAj6i482cIRqFp+hlXqDxIwUy2U2GyhKq4eKCKt+WQl
         LRrwhpm8ZG8yZEREeH2jtfYQVtwcNybyMpm5Df+VdcufYCmVBLUXyFM3d1ldXKFVhXsn
         pN0ZNKpv0l+SsaaoT62qYoq63Slleb4z3T4BP0Xb4Q3WgdJcJi8TuBm48rKs5KCus1vD
         WsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXpSXkZ/8Hfb2Ijnh+LYOs0qAyDxWCL/20mt+D8uMOs=;
        b=iPGGPnqrbbeP2gXF9dfRo8sGVOzfanVky8jGCqQ/XKL+Y6VQdovJoQw9QLV7526tR8
         MQNfJn+uG65T8BTQrf2MFnSy5X3g1y3eP6TDvZmNkpyQd+8vf//VaaDw1BI4j7gk9oU8
         dMCUHGblb+0/I+QDce4HqXBA2Hs191hix8R7pxLAeyh3TC1v2vJ7pDUjfemAaPyGkoEA
         6DESPP69zQ4ggGV6m6LRsvLl+QjBnlU4JrwCx0RQppXeebwQaq+K4JFthKy0Oxeq0eov
         dLQoD13dM01waUugZQewUajd4qTnOHsN9ZqfLjU+L4YPkYCrrM7Wtb6HKw2VqIgwY0nz
         g+xw==
X-Gm-Message-State: AOAM531aeK/htkcLzL4MIItGOZv2a7jXmzYGbErp+ox7ipIA+qUosz2E
        dcawe32QuAzXmnksHEq52R8=
X-Google-Smtp-Source: ABdhPJwr2EMETnVN2svJMlP8kCCTDQFS2h557wuuZzhTHrIFzk1EcO74ZC4ircAssigCeiAO03nwFA==
X-Received: by 2002:a2e:98c1:: with SMTP id s1mr704285ljj.9.1589506972397;
        Thu, 14 May 2020 18:42:52 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id i1sm309669lja.3.2020.05.14.18.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 18:42:51 -0700 (PDT)
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
Subject: [PATCH v4 4/6] partitions/efi: Support GPT entry lookup at a non-standard location
Date:   Fri, 15 May 2020 04:41:41 +0300
Message-Id: <20200515014143.12984-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200515014143.12984-1-digetx@gmail.com>
References: <20200515014143.12984-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Most of consumer-grade NVIDIA Tegra devices use a proprietary bootloader
that can't be easily replaced because it's locked down using Secure Boot
cryptography singing and the crypto keys aren't given to a device owner.
These devices usually have eMMC storage that is partitioned using a custom
NVIDIA Tegra partition table format.  Of course bootloader and other
"special things" are stored on the eMMC storage, and thus, the partition
format can't be changed.

The Tegra partition format has been reverse-engineered, but NVIDIA did
another odd thing by merging "boot" and "main" eMMC HW partitions into a
single virtual partition in theirs bootloader.  This is not supported by
Linux kernel and can't be easily implemented.  Hence partition table entry
isn't accessible by kernel if it's located at the "boot" eMMC partition.
Luckily this is a rare case in practice and even if it's the case, likely
that the proprietary bootloader will supply kernel with a non-standard
gpt_sector= cmdline option.  This gpt_sector= argument points at a GPT
entry that is placed at a non-standard location on the eMMC storage.

This patch allows to support the non-standard cmdline option for NVIDIA
Tegra devices without bothering any other platforms.  The force_gpt_sector
variable should be set before invoking efi_partition() and be unset after
the invocation completion.  This variable, if set, instructs GPT parser
to look up GPT entry at the given sector in addition to the standard GPT
locations.

This patch is based on the original work done by Colin Cross for the
downstream Android kernel.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 block/partitions/efi.c | 10 ++++++++++
 block/partitions/efi.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index b64bfdd4326c..48e4c2aeeded 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -103,6 +103,12 @@ force_gpt_fn(char *str)
 }
 __setup("gpt", force_gpt_fn);
 
+/* Used by NVIDIA Tegra partition parser in order to convey a non-standard
+ * location of the GPT entry for lookup. This variable should be set before
+ * efi_partition() invocation for instructing parser to look up GPT entry at
+ * the given sector, and it should be unset after completion of the invocation.
+ */
+sector_t force_gpt_sector;
 
 /**
  * efi_crc32() - EFI version of crc32 function
@@ -621,6 +627,10 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
         if (!good_agpt && force_gpt)
                 good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
 
+	if (!good_agpt && force_gpt && force_gpt_sector)
+		good_agpt = is_gpt_valid(state, force_gpt_sector,
+					 &agpt, &aptes);
+
         /* The obviously unsuccessful case */
         if (!good_pgpt && !good_agpt)
                 goto fail;
diff --git a/block/partitions/efi.h b/block/partitions/efi.h
index 8cc2b88d0aa8..630cf21439af 100644
--- a/block/partitions/efi.h
+++ b/block/partitions/efi.h
@@ -113,4 +113,6 @@ typedef struct _legacy_mbr {
 	__le16 signature;
 } __packed legacy_mbr;
 
+extern sector_t force_gpt_sector;
+
 #endif
-- 
2.26.0

