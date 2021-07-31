Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5D93DC7B4
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jul 2021 20:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhGaSiF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 31 Jul 2021 14:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGaSiF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 31 Jul 2021 14:38:05 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAABC0613CF;
        Sat, 31 Jul 2021 11:37:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id l17so17841626ljn.2;
        Sat, 31 Jul 2021 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KxFpJWQtK9xa0w5gLWUipHSVysNghEYt1w+9Q+Sruzk=;
        b=U0XbTqkiexQT8dIpEgS5EPcVLq4FcRc4Pe3geUoKP77s03RswnDuv7Ug0KTudzcBrj
         Z9XnmrejpP2GwC1m13qZD16Ko5n8yVqhk+vqMUJ6FBKtbFvx96qOOWfz5bhNk89Ozx1c
         aDCJzwP9HeK6ORID97iIawwu3zfw10GKo6p+E4XKEMhya4Cyg2mmnUIXGFjRTbR0y3lj
         e4QlTNhOnxuk1uQTku76KVSCj09hNpf4plVP9kiNrPq5Xl0Hqr64gB8aAyQ2raCbw97i
         fK9VEnSxSvnrmzWqEqn/uFfi9+LKSLs316cv8T4pTiZ2bM/mEYWyUQUxmrcGdC38UPOR
         8eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KxFpJWQtK9xa0w5gLWUipHSVysNghEYt1w+9Q+Sruzk=;
        b=docUTVUFI9JVNxOoqcWbVEZYaPHMtoEbyX08IQ0FMmdfO6yVvyWtLjV27cUFA+3HaF
         jrM2nPxlrA6Tipcr8sS5RE0rA9txbk4lhlaVObsH0NpXK3laBb/jh8UmyflfHjmJ6Gqz
         6b5SJm+lVnxqc0DryvGy4sgFptxl9CWftiwXfzI4dxkdVdYyCMGypFlGNXvdzSuSE9K8
         jQJChcZ2EI9ll6y2CXJldsjaXlhBhbU0xPIZRd8aW8zshO5eTgDlTf9LUspIjXiD7dR5
         s/1fDsCyIddqm54Ot2SDdPtrx+5WkvL4SA50+wlN0A/RJT3nB1EjE+V6ztz2e0KVlFvx
         UkiQ==
X-Gm-Message-State: AOAM531qSY3mvxyaNGD9loqoxuUzgMW5rcvjf/Sxsfe5mzNHRVOYl4we
        R0RHGKMtELgrBexHei64gvo=
X-Google-Smtp-Source: ABdhPJzbs1TlgquigMiOkPiIVqMR8Kjdsh66zmbC/Zx6ZBeNqvgGg6+gKf9gk751vNjN1/EvzI3rZQ==
X-Received: by 2002:a2e:9ecd:: with SMTP id h13mr6060906ljk.162.1627756676219;
        Sat, 31 Jul 2021 11:37:56 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id s7sm456396lfg.297.2021.07.31.11.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 11:37:55 -0700 (PDT)
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
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v2 0/3] Support EFI partition on NVIDIA Tegra devices
Date:   Sat, 31 Jul 2021 21:36:23 +0300
Message-Id: <20210731183626.18568-1-digetx@gmail.com>
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
 block/partitions/efi.c     | 18 ++++++++
 block/partitions/tegra.c   | 86 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/block.c   | 15 +++++++
 drivers/mmc/core/mmc.c     |  2 +
 include/linux/mmc/blkdev.h | 13 ++++++
 include/linux/mmc/card.h   |  1 +
 10 files changed, 149 insertions(+)
 create mode 100644 block/partitions/tegra.c
 create mode 100644 include/linux/mmc/blkdev.h

-- 
2.32.0

