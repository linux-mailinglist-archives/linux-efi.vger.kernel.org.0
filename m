Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9233F242B
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 02:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhHTAqX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 20:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhHTAqW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 20:46:22 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3831AC061575;
        Thu, 19 Aug 2021 17:45:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z2so16792752lft.1;
        Thu, 19 Aug 2021 17:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I0SQDltzYh8NFZoykvdUZSbooBTcWKRrjtNUtUgEdVo=;
        b=QS56BoMaZhEv23Qfs39bLdbeeoOogiQj8PYFsI374lsIrIB8/VWnPKQ71j3Rl6mWr/
         PY0TgEguEH4Hnl1r8bdbvlztFlAuv8d697kPYjT+V4hg3tdLMzQ952QJkEqfcnQz1uPO
         xycCz4yhUtknfhRe//zsQHVmcSEMqufxywuRUyo3KmG61lAqlT56WrOyAf3CPGHPaLYT
         UkOWIc/mqaevxbVupBOACfn6yriWFlbQb4Fkiqa0aqY3MhR+9Te3ndMetPkaUFtocYZS
         Ivr2RiZMzCvYJA/kC71Yvk+Y6btDjwy/sAstZgOePn7q9PSj938E5o/dduAMSAhxeoCz
         JHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I0SQDltzYh8NFZoykvdUZSbooBTcWKRrjtNUtUgEdVo=;
        b=c4axumCR8QkkzQqmnneEiTBGNL2ybpSz3MeP6YiMaaq2+ffZ+eRjWe2jiUjgJLr/b7
         62bqJwYJjBJ/NUEGP8MLSemXCiCAhGs6Z1oUkTNlgEvH2xRz9l3iB0bPwCfzSpj/I+xg
         U4IdaGBFMZlj5ccDpqikseLLQ9MvzX4YrSxq4Xi+WQ+uZJIrn05kEt/KX7MqisuhoaNC
         iqQwPFLIYcdrl9GvXSDPllg6oUG+DFjB7vmEa+ctncfrSdPLRwyPB7YsyocLeWdzMjiq
         tlx1UHfL9A8V1yXHu1wkqhpd2KmGdcLa1ceZSk1l8+ptpMP2OHDQl8ES53TZojaVoHOU
         2EAg==
X-Gm-Message-State: AOAM532TwAj0fOdigOX3sJj32eFAx6wWXqDD1ta2EuBPTLfVTgJ/0VzW
        B8YynYBatVvjHcyJ94snSg0=
X-Google-Smtp-Source: ABdhPJwWCZ8kgM+zaMDPPpwx1Za3sqta22Sbc3ekE92bOgxDP00X7HGAlqQZcsCR1vYMlhzxn0+jKQ==
X-Received: by 2002:a05:6512:3889:: with SMTP id n9mr12333928lft.589.1629420343641;
        Thu, 19 Aug 2021 17:45:43 -0700 (PDT)
Received: from localhost.localdomain (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.gmail.com with ESMTPSA id h6sm507244lfu.230.2021.08.19.17.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:45:43 -0700 (PDT)
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
Subject: [PATCH v7 0/4] Support EFI partition on NVIDIA Tegra devices
Date:   Fri, 20 Aug 2021 03:45:32 +0300
Message-Id: <20210820004536.15791-1-digetx@gmail.com>
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

v7: - Added r-b from Christoph Hellwig.

    - Added ack from Davidlohr Bueso.

    - Renamed MMC_CAP2_ALT_GPT_SECTOR to MMC_CAP2_ALT_GPT_TEGRA,
      like it was suggested by Ulf Hansson and Thierry Reding.

    - Squashed MMC raw_boot_mult patch into alternative_gpt_sector()
      since both now belong to MMC core and it's cleaner to have them
      in a single change.

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

Dmitry Osipenko (4):
  block: Add alternative_gpt_sector() operation
  partitions/efi: Support non-standard GPT location
  mmc: block: Support alternative_gpt_sector() operation
  mmc: sdhci-tegra: Enable MMC_CAP2_ALT_GPT_TEGRA

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

