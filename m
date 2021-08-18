Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EE63EF710
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 02:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhHRA5s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 20:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbhHRA5r (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 20:57:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474F2C061764;
        Tue, 17 Aug 2021 17:57:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x27so906268lfu.5;
        Tue, 17 Aug 2021 17:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FHpah2Dpj/TPubzzjmkmJuckncZAa3WMYxXsj2gsyts=;
        b=YSYnszVgE5PGV58mwWn67rQ0Qo3HjRDXp+af5aIntm1uZ8ToaPuKIcgg7+semEvT6o
         dUSAlnevDzeGlPupiIn5iTD0o/LdvbMteTvM2aALs7CrsxdElukm7Xr3J8RyUTapgeo0
         9eXOT38ZR/JjOQ0q+C96ps9+y5sYiDIpD2cg9rnWoeNn/xwGGZYuo7ZKpI+pLsvDvINj
         M0558BipCq8ETfsCHj4EJqr31sDeOKMhNmRyTWqYBDvbcTjiYIHFPZMmd0DR8+k0I80B
         1Er9XwH9kr2FOw3Mo5dmiBcqSz1LZ36b8Tst4F9POz1FBLLnpgBaxAWE3yDr3XzMWLcj
         Alsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHpah2Dpj/TPubzzjmkmJuckncZAa3WMYxXsj2gsyts=;
        b=ErLT+gWbeqUstHwdLPCnj8K7xcPUj/FXKRV/aSSqCLiJgnWCCpW50Uh1PWgIuL6jSh
         JMKw2tl8mtNnoJ9yvk20mgBpmaAnRLX0OyhYQHc+kUHKALjKk4VwGumVVv4h2P+3JdW+
         GGk0eqPecR8fp+GJ6GKXZDDrC8uM7vwu0vikFvIs2p6dVWIpUrxS76BaZnNSrSboLqEm
         xjVKpoarVpEvhfzTUg37kBVj4+7KEOghqeldfJ6GdGM6Bq9DJBTr/vNl5K90WjSdyMqI
         yWVsFvWOf/VmK70z0d4zlFwdd+BAZcJK/L/NnKBQMmYbEKgLxsl8MWeBmizqArHEKZrz
         upkA==
X-Gm-Message-State: AOAM533bSTj5kXtXndRGKp201lJdqFk15ni6jIalDRaZkXIKrSusuwiZ
        fNUcfDWJozhv8oXyhC5uWrQ=
X-Google-Smtp-Source: ABdhPJzHR1wMJp3yBjzWxkyYvY33vsGCKBmKN2ow3m7gwngkxK9Xdtf/PN36aCM0S5wPqlQVVECrbQ==
X-Received: by 2002:ac2:46ef:: with SMTP id q15mr4460085lfo.407.1629248231719;
        Tue, 17 Aug 2021 17:57:11 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id h19sm335879lfu.138.2021.08.17.17.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 17:57:11 -0700 (PDT)
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
Subject: [PATCH v5 1/5] block: Add alternative_gpt_sector() operation
Date:   Wed, 18 Aug 2021 03:55:43 +0300
Message-Id: <20210818005547.14497-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818005547.14497-1-digetx@gmail.com>
References: <20210818005547.14497-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add alternative_gpt_sector() block device operation which specifies
alternative location of a GPT entry. This allows us to support Android
devices which have GPT entry at a non-standard location and can't be
repartitioned easily.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/blkdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 111a3911c4d2..a662a8f5065f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1848,6 +1848,7 @@ struct block_device_operations {
 	int (*report_zones)(struct gendisk *, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
 	char *(*devnode)(struct gendisk *disk, umode_t *mode);
+	int (*alternative_gpt_sector)(struct block_device *, sector_t *);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 };
-- 
2.32.0

