Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E3D3F242E
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 02:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhHTAqY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 20:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhHTAqX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 20:46:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B26EC061756;
        Thu, 19 Aug 2021 17:45:46 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u22so16661496lfq.13;
        Thu, 19 Aug 2021 17:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B6UUQn1STc8n5RrdDxFwFkbni5E05Ry4L1wrDm4nucI=;
        b=dhkGyKrDTxCmgNMpFAgz2WaKrPg+CSNyRzAiYB43kl6yeQbDahjDIJ/TK/2J2ic8Ll
         E2tl/9qxs8RYvN4PPGcHA1Ex6c3GjgntwvefOX0TFFvTZ7l1GYIxWvasKP+OAzZwdZkC
         PqJ1KVNXkSaItGQpnDSkp9gvsz41asPKl1JlwDyzyesc31Wu2VSgo6dBERENv02hfr/l
         m1VYxrdGY+YibyLUax39cPpuGAqspn4+P+KWtfzAZ/706qExZ2C77+XDhYN/AmwCpqmy
         1B8KJ3DoL5EIORt4/lMkgRCIu2TgZ6YHoxYnj36vKyXTdK/WfDwMASrwhSmJueSL86Zt
         SeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B6UUQn1STc8n5RrdDxFwFkbni5E05Ry4L1wrDm4nucI=;
        b=bKSUXJf/NxE+putE4QcabmvrchRS1ig+G9noWGukVlsisIachTAPcz02M6eFvVDLMV
         crHY7wPMK1UbgNlJyQqQm2tScCPVmRiY9BEFi4Hh5BsMsmJwXPKmZUka38DwrjgMIgoc
         m7Qqjc/lsD0IVbb95Tq2MGlgeu7Axq0F+KZnH3nHWXK0U2J429nElS7pdJChAsF0ttck
         7RIICiV9oqAwW43wg2ktn+1wQXTqIzorcmQvJkI0+Qt1bRxgN5QCdjZAWeZWhsoQX6OS
         ENdZ+CiMwxE7p1e0zRxqtkRXHSJJ0gSd3LAuVDrd5sqcNarE+Dv7DOCF5oW1hSvhjno8
         QhmA==
X-Gm-Message-State: AOAM533sDpjimjrO/PNAlwWmDF8PFqlFMXuv4+7yEBFAPIhAiOpBUMmu
        0nGh8SE7qzwikC2ULQMQ/XQ=
X-Google-Smtp-Source: ABdhPJyVvnbH1BCym2tJ3sGtkrKop75NuFrCUEOo+55tRDFW6KA/97W5KanEUBQJQTbhfP+YeRItZg==
X-Received: by 2002:a05:6512:234e:: with SMTP id p14mr12108170lfu.298.1629420344460;
        Thu, 19 Aug 2021 17:45:44 -0700 (PDT)
Received: from localhost.localdomain (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.gmail.com with ESMTPSA id h6sm507244lfu.230.2021.08.19.17.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:45:44 -0700 (PDT)
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
        Davidlohr Bueso <dave@stgolabs.net>,
        Rob Herring <robh+dt@kernel.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v7 1/4] block: Add alternative_gpt_sector() operation
Date:   Fri, 20 Aug 2021 03:45:33 +0300
Message-Id: <20210820004536.15791-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820004536.15791-1-digetx@gmail.com>
References: <20210820004536.15791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add alternative_gpt_sector() block device operation which specifies
alternative location of a GPT entry. This allows us to support Android
devices that have GPT entry at a non-standard location and can't be
repartitioned easily.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/blkdev.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 111a3911c4d2..d65c8f60ad8e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1850,6 +1850,13 @@ struct block_device_operations {
 	char *(*devnode)(struct gendisk *disk, umode_t *mode);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
+
+	/*
+	 * Special callback for probing GPT entry at a given sector.
+	 * Needed by Android devices, used by GPT scanner and MMC blk
+	 * driver.
+	 */
+	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
 };
 
 #ifdef CONFIG_COMPAT
-- 
2.32.0

