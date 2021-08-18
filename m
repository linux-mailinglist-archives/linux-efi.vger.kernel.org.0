Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117D23F0DFD
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 00:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhHRWUR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 18:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbhHRWUR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 18:20:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E41C061764;
        Wed, 18 Aug 2021 15:19:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r9so7987331lfn.3;
        Wed, 18 Aug 2021 15:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5BboEvAw/HXnB0UvGjpwIn05vh6cZYmjySlOfPuZwrE=;
        b=hgZIRiaXwImTjHwfFZuPHRnszNPvCAJDpqC4f1lrhXuxiaT+osmSgA3AmTOfw2Uo5w
         cQOGhWBaETsWQfDc2RZ8JNL4wGVJrHShTZsQXaYu/wEeU3h2FobGP+meifcvpz2pNrJ1
         YeGa49uSV8f4yCPh6zOR+BzruY1sTtKRGRC3hL0G1TCJs12Y1dFKKB1KfpF65RzVsBbS
         /A1RfELqzcdkyz3S+jY0VIBLj4TBRo43UPlRGNos5rMNfyM1fKqMT3pIbMGiHh2MjDvP
         q7vOVf4/T5mOrCv00Q6+h3DbC2LC4uNxCbLtVd4DIREGQQdlDxpCaosiqTI3P5tKe6dp
         X9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5BboEvAw/HXnB0UvGjpwIn05vh6cZYmjySlOfPuZwrE=;
        b=AtXVozjufvYJLZOXmW+Z9uuhC+vwvx8MkwWvWVbSldSiILxIasHjALpPq5pcgVBWLa
         FCkxbke9Oiw1YOrD0hcoZ2D7wSye9cDS/IcQ/ddcYJ3eeBj30YSESIzdESst2PocRF0R
         hIPaIcMuLZu9jJprylLdkPuoEH2p62MbikwICRFxn22h5VxhiLk0C4H6LlOy5n96KXbr
         LcWjw3b0cqnyoDisdj/G7GXl2/EUDG8WueTgc2w/4zIhABOhO2/SgUpsZM974pMWZ2yI
         PT3CqD9TzCSo+soaBgEt/vbi9bxuDgwRLqovYiv19pZ3slWMpEmNTcvoojQYOVptfAfh
         1IVg==
X-Gm-Message-State: AOAM533zO0822Y2EZUOayV3//2T6xE7CiYKrYQ4lyFtTwsrXYMXFssh1
        torLUB3AhPQc8GcWmQMY4Fg=
X-Google-Smtp-Source: ABdhPJw4cjJyL7VSkdfr2ReID0KqC3U9eHuPzSOYpi8CLcoeKk5QqBqylN1F+Y7MMSnPRz7In2yUIA==
X-Received: by 2002:a05:6512:3d16:: with SMTP id d22mr7938119lfv.132.1629325179946;
        Wed, 18 Aug 2021 15:19:39 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id v23sm93300lfr.208.2021.08.18.15.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 15:19:39 -0700 (PDT)
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
Subject: [PATCH v6 0/5] Support EFI partition on NVIDIA Tegra devices
Date:   Thu, 19 Aug 2021 01:19:15 +0300
Message-Id: <20210818221920.3893-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series adds the most minimal EFI partition support for NVIDIA Tegra
consumer devices, like Android tablets and game consoles, making theirs
eMMC accessible out-of-the-box using downstream bootloader and mainline
Linux kernel.  eMMC now works on Acer A500 tablet and Ouya game console
that are already well supported in mainline and internal storage is the
only biggest thing left to support.

Changelog:

v6: - Added comment for the alternative_gpt_sector() callback, which
      was asked by Christoph Hellwig.

    - Changed alternative_gpt_sector() to take disk for the argument
      instead of blkdev. This was asked by Christoph Hellwig.

    - Dropped mmc_bdops check as it was suggested by Christoph Hellwig.

    - Added missing mmc_blk_put() that was spotted by Christoph Hellwig.

    - Moved GPT calculation into MMC core and added MMC_CAP2_ALT_GPT_SECTOR
      flag, like it was asked by Ulf Hansson. Me and Thierry have concerns
      about whether it's better to have Tegra-specific function in a core
      instead of Tegra driver, but it also works, so I decided to try that
      variant.

v5: - Implemented alternative_gpt_sector() blk/mmc callback that was
      suggested by Christoph Hellwig in a comment to v4.

    - mmc_bdev_to_card() now checks blk fops instead of the major number,
      like it was suggested by Christoph Hellwig in a comment to v4.

    - Emailed Rob Herring, which was asked by Ulf Hansson in a comment
      to v4. Although the of-match change is gone now in v5, the matching
      is transformed into the new SDHCI quirk of the Tegra driver.

v4: - Rebased on top of recent linux-next.

v3: - Removed unnecessary v1 hunk that was left by accident in efi.c of v2.

v2: - This is continuation of [1] where Davidlohr Bueso suggested that it
      should be better to avoid supporting in mainline the custom gpt_sector
      kernel cmdline parameter that downstream Android kernels use.  We can
      do this for the devices that are already mainlined, so I dropped the
      cmdline from the v2 and left only the variant with a fixed GPT address.

[1] https://lore.kernel.org/linux-efi/20210327212100.3834-3-digetx@gmail.com/T/

Dmitry Osipenko (5):
  block: Add alternative_gpt_sector() operation
  partitions/efi: Support non-standard GPT location
  mmc: core: Add raw_boot_mult field to mmc_ext_csd
  mmc: block: Support alternative_gpt_sector() operation
  mmc: sdhci-tegra: Enable MMC_CAP2_ALT_GPT_SECTOR

 block/partitions/efi.c         | 12 ++++++++++++
 drivers/mmc/core/block.c       | 21 ++++++++++++++++++++
 drivers/mmc/core/core.c        | 35 ++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h        |  2 ++
 drivers/mmc/core/mmc.c         |  2 ++
 drivers/mmc/host/sdhci-tegra.c |  9 +++++++++
 include/linux/blkdev.h         |  7 +++++++
 include/linux/mmc/card.h       |  1 +
 include/linux/mmc/host.h       |  1 +
 9 files changed, 90 insertions(+)

-- 
2.32.0

