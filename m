Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFD21D6539
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 04:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgEQCNX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 22:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgEQCNW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 22:13:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1B0C061A0C;
        Sat, 16 May 2020 19:13:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l19so6171284lje.10;
        Sat, 16 May 2020 19:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gUBCctdhHCu7sjP1tHa2z4pbf0aP2BkvowO8loRmkXU=;
        b=RfwuMFkqEJZgF19i+KxQfujKqus1CwEmSitLN1PFvs5+RgbQ/Z8H+DPEArTr4El+jX
         h7hBbjsiec8MN4fPHR2vyr4fpYdarLb4EXQfkkXVGeSxru5qoSqspTQ1SGxoAKm7ylBl
         nmp3jJGDZtMG1OYS2lvOZHt0Qiwapdf711BX5ZZqnlQsXlTJyJlJrv9zOk6hl96eiE1N
         8AkQ3/YwpvlripYEae/VERJkOcl5PIGoalzCBfilLOtB4N5EiuYvjY3isBbJjMktNcA5
         3UYhTWl9ICkQJFyDH7e42FArQfnvZrVCD36urE9GY2MUt3eND0U71oDx3FR8uFnenL2N
         FksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gUBCctdhHCu7sjP1tHa2z4pbf0aP2BkvowO8loRmkXU=;
        b=O6jyOzVkgU7ck2hnEVZ0l7QCvB05CMdXWnAqJnP9L+98z01uwsUBI1b6rDuViRJiA9
         PR/m2wxjGeS53p2J6JHdgaZyULOr8x5cnjEML+U/PIE+rmVQ0N1eBpaMm+WIfPwI0dtn
         xOJyAIhC2yjfQkAJeEnjMjcJomIwvV+pgp8/bEtO6cgAR/JuzzuSB4O1zYSE4nS095Io
         E/WJMg/zZE3EnuVHKdVA7nsbclaN0auFH1DYBjNOULPR7p3ZugbHkjfRisXeJHsq/n7f
         L8jEhCbb9fuuLeq3UWre9A3VdYWxsk26uvQEbBTj/AXZU4EZ7+RkuIBYKtBes2S801AI
         0kHQ==
X-Gm-Message-State: AOAM5317EWiDIBLXI65N5HaL+WchI1RP+wf2myQKmcDb9exLj1YZsFdK
        2rwgZtg8nTWyspn7GO+orzE=
X-Google-Smtp-Source: ABdhPJwM7xlqFDJcBdXtLqUpr9mX9cZkc2W5iujTI2aJcmy4KIMsEVivPu7gY54awe9bEQ0DZKYFbA==
X-Received: by 2002:a2e:9a0d:: with SMTP id o13mr5735512lji.15.1589681598745;
        Sat, 16 May 2020 19:13:18 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id z5sm3463149lji.30.2020.05.16.19.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:13:18 -0700 (PDT)
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
Subject: [PATCH v6 0/7] Introduce NVIDIA Tegra Partition Table
Date:   Sun, 17 May 2020 05:12:18 +0300
Message-Id: <20200517021225.22890-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello,

This series adds support for the NVIDIA Tegra Partition Table format,
which is needed in order to support consumer-grade Tegra-based devices
by the upstream kernel.  These devices have Secure Boot enabled and it
can't be disabled, and thus, it's not possible to easily modify bootloader
and eMMC storage partitioning.

Big thanks to everyone who helped with figuring out the TegraPT format
and with testing!

Changelog:

v6: - Now using a proper multi-line comments style in efi.c, thanks to
      Randy Dunlap for the suggestion.

    - Added new patch that improves coding style of partitions/efi.c

    - Now both "gpt gpt_sector=<sector>" and "gpt_sector=<sector> gpt"
      cmdline variants are parsed properly. I found that the second variant
      wasn't working in v5.

    - Fixed accidentally swapped GFP_KERNEL flag and allocation size passed
      to kmalloc() in the patch "Expose Boot Configuration Table via sysfs".
      Thanks to KASAN for reporting the problem.

v5: - Corrected Kconfig dependency, like it was suggested by Randy Dunlap
      in the review comment to v4.

    - Corrected a typo in the commit message, which was spotted by
      Steve McIntyre in v4.

    - The new force_gpt_sector variable has been moved out to the common
      parser state because I realized that multiple drives could be scanned
      simultaneously, and thus, a global shared variable isn't a suitable
      variant.

    - The Tegra's enforced GPT-scan now supports older bootloader versions,
      which do not provide the gpt_sector= command line option.  The gpt_sector
      should be calculated using NVIDIA's algorithm in this case.

v4: - Scanning of the eMMC boot partitions has been dropped because it
      requires a bit too messy hacks in the kernel.  We can live without
      this feature, at least for now it's not really needed.

    - Instead of the dropped boot partitions scanning, the "gpt_sector="
      command line option has been brought back [1].  But now it's done
      in a different way, not bothering platforms other than Tegra and
      not touching block devices other than eMMC, which was requested during
      of the [1] review.  The "gpt_sector=" usage is needed when partition
      table is inaccessible by kernel, which is the case for the Ouya game
      console device for example.  Please note that "gpt_sector=" is not
      available on all devices, such devices will fall back to the TegraPT,
      Samsung Galaxy Tab 10.1 is an example of a such device.

      [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200219162339.16192-1-digetx@gmail.com/

    - We got a bit more broad testing and discovered that Samsung Galaxy
      Tab 10.1 uses 2K logical sectors instead of 4K.  So the 2K sectors
      are supported now by the TegraPT parser.  Thanks to Nils Östlund for
      the testing!

    - TegraPT parser now utilizes "tegraboot=" cmdline option which is
      passed to kernel by the NVIDIA's bootloader.  It's used for verifying
      that SDMMC device is *the* boot source.

    - Added patch that exposes Boot Configuration Table to userspace via
      sysfs.  Thanks to Michał Mirosław for the suggestion!

    - Misc changes:
        - The EB2 (second bootloader) partition is added to the list of
          known partitions.  Used by the Galaxy Tab 10.

        - The blkdev logical sector size is checked now, for consistency.
          It always should be 512 bytes on the supported/tested devices.

        - Verbose error messages are replaced with pr_debug().

v3: - Fixed "BUG: KASAN: slab-out-of-bounds in tegra_partition".  Thanks to
      Peter Geis for noticing the problem.

    - The MMC boot partitions scanning is now opt-in. See this patch:

        mmc: block: Support partition-table scanning on boot partitions

    - The found MMC boot partitions won't be assigned to the MMC boot
      block device ever due to the new GENHD_FL_PART_SCAN_ONCE flag.

      This makes us to ensure that the old behavior of the MMC core is
      preserved for a non-Tegra MMC-block users.

    New patches in v3:

        block: Introduce GENHD_FL_PART_SCAN_ONCE
        mmc: sdhci-tegra: Enable boot partitions scanning on Tegra20 and Tegra30

v2: - Addressed v1 review comments from Stephen Warren by using BIT for
      locating BCT position in IRAM.

    - Added more validations to the TegraPT parser: partition type is
      verified, eMMC instance ID is verified.

    - TegraPT parser now doesn't touch any devices other than eMMC.

    - EKS (encrypted keys) partition is blacklisted now.

    - Implemented eMMC boot partitions scanning.  These new patches are
      added in a result:

        mmc: block: Add mmc_bdev_to_part_type() helper
        mmc: block: Add mmc_bdev_to_area_type() helper
        mmc: block: Add MMC_QUIRK_RESCAN_MAIN_BLKDEV
        mmc: block: Enable partition-table scanning for boot partitions
        partitions/tegra: Implement eMMC boot partitions scanning

Dmitry Osipenko (7):
  mmc: core: Add raw_boot_mult field to mmc_ext_csd
  mmc: block: Add mmc_bdev_to_card() helper
  partitions: Introduce NVIDIA Tegra Partition Table
  partitions/efi: Support GPT entry lookup at a non-standard location
  partitions/efi: Improve coding style
  partitions/tegra: Support enforced GPT scanning
  soc/tegra: Expose Boot Configuration Table via sysfs

 arch/arm/mach-tegra/tegra.c   |  58 ++++
 block/partitions/Kconfig      |   8 +
 block/partitions/Makefile     |   1 +
 block/partitions/check.h      |   3 +
 block/partitions/core.c       |   4 +
 block/partitions/efi.c        | 372 ++++++++++----------
 block/partitions/tegra.c      | 624 ++++++++++++++++++++++++++++++++++
 drivers/mmc/core/block.c      |  15 +
 drivers/mmc/core/mmc.c        |   2 +
 drivers/soc/tegra/Makefile    |   1 +
 drivers/soc/tegra/bootdata.c  |  51 +++
 drivers/soc/tegra/common.c    |  17 +
 include/linux/mmc/blkdev.h    |  13 +
 include/linux/mmc/card.h      |   1 +
 include/soc/tegra/bootdata.h  |  48 +++
 include/soc/tegra/common.h    |  12 +
 include/soc/tegra/partition.h |  84 +++++
 17 files changed, 1135 insertions(+), 179 deletions(-)
 create mode 100644 block/partitions/tegra.c
 create mode 100644 drivers/soc/tegra/bootdata.c
 create mode 100644 include/linux/mmc/blkdev.h
 create mode 100644 include/soc/tegra/bootdata.h
 create mode 100644 include/soc/tegra/partition.h

-- 
2.26.0

