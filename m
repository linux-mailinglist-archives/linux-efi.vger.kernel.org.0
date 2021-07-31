Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32B73DC7CA
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jul 2021 20:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhGaS5P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 31 Jul 2021 14:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhGaS5P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 31 Jul 2021 14:57:15 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C143FC0613CF;
        Sat, 31 Jul 2021 11:57:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id n6so17806291ljp.9;
        Sat, 31 Jul 2021 11:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+obj5GrZr83iiBc3FGUT58tIa7AGQd7uAAiSvebjq8=;
        b=LbWb3eocuhIkUbXbccz4umVOpSy249IQDZKpoqSBWh1YDfaHTBhkjg4HvbJigYGGig
         /fVy5NsvHqEJtRMaKXe440u0T6lQXGgzgulBO9o1ORRJGL5MQLOR0YWdmxlXtitOFEfZ
         7DHK/HnRln9lZsKFLE062Lpk+/LOg4nzo0B8/tUncqaDEFa17UlyMFpYD0ZeLhzL2Na7
         kN65PZPGb/aHfF5P1qedKNozniu0stvbsSX+sHkAZI0Fo6dU2qN8rJB4Sf7VNYVxDImU
         mju5I7aCawrpSQiUZKMg+dssOJ5DyOp7ixmq9RDq0bI8YCeO6PLimbYhx4A9S7vtQX4/
         uRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+obj5GrZr83iiBc3FGUT58tIa7AGQd7uAAiSvebjq8=;
        b=l0Wgc9o+d+r1UckrIUstgwdCsZa1WPT7/GDfb4XavIGvdKY8QQzpXipoLy8LjLIr8D
         BD4f4wg/baUHOKSg8av6S5C7EAv3Rq0PU04BOoSZ6mEvZ51vXegljfzE2Kqzw+LVEuE1
         EoAd73SGgQsw4aqM6YXTO33ua33SCatR587tweVk5RiA6nTI0ONlzq7w6cCYX02jG/7Q
         VOnZ5j8T1+IZe554Oer99lc08cYhkckd7HiVM/+zsdT3+5MkuY/U5GnQkCt/Fy7EyoD7
         KeDW4KNtcc5iRx2Wu0wvbMjaSKZlNZ9kjSloqFxiPa7rFOXD0M8DUHvXCCzdPSsCPjxI
         TjfQ==
X-Gm-Message-State: AOAM533+pJeiQSfRGASTkWPS8nowc4jysP77vGV6PlBdcv/dmuSjmg6N
        ePQ7O9mXvvfh15hEV+QDuK0=
X-Google-Smtp-Source: ABdhPJxxz6vYab6e4iT5uly1ygMAO3SmvMPYGbIBJgtJqML12DT2n/KwhFKTUsgEKq1N0Vk+fTA3gg==
X-Received: by 2002:a2e:a164:: with SMTP id u4mr5766475ljl.121.1627757826264;
        Sat, 31 Jul 2021 11:57:06 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id c10sm507653lfv.10.2021.07.31.11.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 11:57:05 -0700 (PDT)
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
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v3 0/3] Support EFI partition on NVIDIA Tegra devices
Date:   Sat, 31 Jul 2021 21:56:49 +0300
Message-Id: <20210731185652.6421-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series adds the most minimal EFI partition support for NVIDIA Tegra
consumer devices, like Android tablets and game consoles, making theirs
EMMC accessible out-of-the-box using downstream bootloader and mainline
Linux kernel.  EMMC now works on Acer A500 tablet and Ouya game console
that are already well supported in mainline and internal storage is the
only biggest thing left to support.

Changelog:

v3: - Removed unnecessary v1 hunk that was left by accident in efi.c of v2.

v2: - This is continuation of [1] where Davidlohr Bueso suggested that it
      should be better to avoid supporting in mainline the custom gpt_sector
      kernel cmdline parameter that downstream Android kernels use.  We can
      do this for the devices that are already mainlined, so I dropped the
      cmdline from the v2 and left only the variant with a fixed GPT address.

[1] https://lore.kernel.org/linux-efi/20210327212100.3834-3-digetx@gmail.com/T/

Dmitry Osipenko (3):
  mmc: core: Add raw_boot_mult field to mmc_ext_csd
  mmc: block: Add mmc_bdev_to_card() helper
  partitions/efi: Support NVIDIA Tegra devices

 block/partitions/Kconfig   |  8 ++++
 block/partitions/Makefile  |  1 +
 block/partitions/check.h   |  2 +
 block/partitions/core.c    |  3 ++
 block/partitions/efi.c     |  9 ++++
 block/partitions/tegra.c   | 86 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/block.c   | 15 +++++++
 drivers/mmc/core/mmc.c     |  2 +
 include/linux/mmc/blkdev.h | 13 ++++++
 include/linux/mmc/card.h   |  1 +
 10 files changed, 140 insertions(+)
 create mode 100644 block/partitions/tegra.c
 create mode 100644 include/linux/mmc/blkdev.h

-- 
2.32.0

