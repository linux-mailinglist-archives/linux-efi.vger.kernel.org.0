Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C38A1D4316
	for <lists+linux-efi@lfdr.de>; Fri, 15 May 2020 03:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEOBmt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 May 2020 21:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgEOBms (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 May 2020 21:42:48 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F42C061A0C;
        Thu, 14 May 2020 18:42:48 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so489098ljl.2;
        Thu, 14 May 2020 18:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7y6P20mSjIlOn2i5eYB9QskqPv8tZPzDkHJ3IuuNaoY=;
        b=o0D23+tFHO0Vk+1ZbsDxhvxetGhvfbisXBeInmtob2JiocHgdsVZLNc3LZEnTApYUi
         LjAK02hRyTg1TQ2Ow1FISZsYBi6Jbork6ea2SIdaLNlXDg2eofxkAsbCSaG4rgpaF+kr
         HUbLRY/nd0kwqYTYut0MRt9okNN65z+pFLpap/Bw+wcX6Zr6Kx2XTXGbMmCUPjvTF1C4
         XNQ35HWHz6eTATmeFKP0T1NVcPPdSyJhCR2uWnnMpB3EK4N1F2cUUcSHWV7gscgBrhHA
         /9ZsxpVUg6djnZOJ3ukP6lIwlS8apmqB4sY0FN1iGsXi4TknFafNoQzUBQ4cU9MYyLq1
         spHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7y6P20mSjIlOn2i5eYB9QskqPv8tZPzDkHJ3IuuNaoY=;
        b=a8QAUPLbnGb1w6UZGbzlkFWtHJteNmLK02L8XQ/5/schvFaMLawY69ha/HLa7oWXBe
         7FWpMXrtTa+FvR1es+Y5zKprsQsqph6+6UFWAtX+inHk7oYFagjuHTqkrtib5Y03WHKL
         b87xalbmoGvumZdJXtSW1ASmcNPxZNFz4y+uBFV79KKykOr38gcnCG/+nMMrePvVIYSi
         ugaz0O5eWfFHeddYoJiblkak5kJLsNs1fkHDLbywZ/nylcN6856Espu4Mxo6qWfJNqOc
         Ua7miVOt8kcUTTqNgExTXhnmGHM/3fbWwLB2C5FS4pkUduSxIehlG4MEUBkGX7VJsruH
         faFg==
X-Gm-Message-State: AOAM532tFCde2Ghx64N2AJIHnO+Ae+bckxSbTlSCW2MlK7Kfwah3afW6
        jGcBck7u7MjcSUJjfy4eWe4=
X-Google-Smtp-Source: ABdhPJwOyQG8gqtgWYpCM76VtPVOdZuJG/tE2LYnDij4UZ/uWlNv7vguADc6LSGP/yRKtnyIAjl0dg==
X-Received: by 2002:a2e:8347:: with SMTP id l7mr677120ljh.243.1589506966899;
        Thu, 14 May 2020 18:42:46 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id i1sm309669lja.3.2020.05.14.18.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 18:42:46 -0700 (PDT)
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
Subject: [PATCH v4 0/6] Introduce NVIDIA Tegra Partition Table
Date:   Fri, 15 May 2020 04:41:37 +0300
Message-Id: <20200515014143.12984-1-digetx@gmail.com>
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

v4: - Scanning of the eMMC boot partitions has been dropped because it
      requires a bit too messy hacks in the kernel. We can live without
      this feature, at least for now it's not really needed.

    - Instead of the dropped boot partitions scanning, the "gpt_sector="
      command line option has been brought back [1]. But now it's done
      in a different way, not bothering platforms other than Tegra and
      not touching block devices other than eMMC, which was requested during
      of the [1] review. The "gpt_sector=" usage is needed when partition
      table is inaccessible by kernel, which is the case for the Ouya game
      console device for example. Please note that "gpt_sector=" is not
      available on all devices, such devices will fall back to the TegraPT,
      Samsung Galaxy Tab 10.1 is an example of a such device.

      [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200219162339.16192-1-digetx@gmail.com/

    - We got a bit more broad testing and discovered that Samsung Galaxy
      Tab 10.1 uses 2K logical sectors instead of 4K. So the 2K sectors
      are supported now by the TegraPT parser. Thanks to Nils Östlund for
      the testing!

    - TegraPT parser now utilizes "tegraboot=" cmdline option which is
      passed to kernel by the NVIDIA's bootloader. It's used for verifying
      that SDMMC device is *the* boot source.

    - Added patch that exposes Boot Configuration Table to userspace via
      sysfs. Thanks to Michał Mirosław for the suggestion!

    - Misc changes:
        - The EB2 (second bootloader) partition is added to the list of
          known partitions. Used by the Galaxy Tab 10.

        - The blkdev logical sector size is checked now, for consistency.
          It always should be 512 bytes on the supported/tested devices.

        - Verbose error messages are replaced with pr_debug().

v3: - Fixed "BUG: KASAN: slab-out-of-bounds in tegra_partition". Thanks to
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

    - Implemented eMMC boot partitions scanning. These new patches are
      added in a result:

        mmc: block: Add mmc_bdev_to_part_type() helper
        mmc: block: Add mmc_bdev_to_area_type() helper
        mmc: block: Add MMC_QUIRK_RESCAN_MAIN_BLKDEV
        mmc: block: Enable partition-table scanning for boot partitions
        partitions/tegra: Implement eMMC boot partitions scanning

Dmitry Osipenko (6):
  mmc: core: Add raw_boot_mult field to mmc_ext_csd
  mmc: block: Add mmc_bdev_to_card() helper
  partitions: Introduce NVIDIA Tegra Partition Table
  partitions/efi: Support GPT entry lookup at a non-standard location
  partitions/tegra: Support gpt_sector= command line option
  soc/tegra: Expose Boot Configuration Table via sysfs

 arch/arm/mach-tegra/tegra.c   |  58 ++++
 block/partitions/Kconfig      |   8 +
 block/partitions/Makefile     |   1 +
 block/partitions/check.h      |   2 +
 block/partitions/core.c       |   4 +
 block/partitions/efi.c        |  16 +
 block/partitions/efi.h        |   2 +
 block/partitions/tegra.c      | 603 ++++++++++++++++++++++++++++++++++
 drivers/mmc/core/block.c      |  15 +
 drivers/mmc/core/mmc.c        |   2 +
 drivers/soc/tegra/Makefile    |   1 +
 drivers/soc/tegra/bootdata.c  |  51 +++
 drivers/soc/tegra/common.c    |  17 +
 include/linux/mmc/blkdev.h    |  13 +
 include/linux/mmc/card.h      |   1 +
 include/soc/tegra/bootdata.h  |  48 +++
 include/soc/tegra/common.h    |  12 +
 include/soc/tegra/partition.h |  83 +++++
 18 files changed, 937 insertions(+)
 create mode 100644 block/partitions/tegra.c
 create mode 100644 drivers/soc/tegra/bootdata.c
 create mode 100644 include/linux/mmc/blkdev.h
 create mode 100644 include/soc/tegra/bootdata.h
 create mode 100644 include/soc/tegra/partition.h

-- 
2.26.0

