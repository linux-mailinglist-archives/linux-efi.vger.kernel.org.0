Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE96534B975
	for <lists+linux-efi@lfdr.de>; Sat, 27 Mar 2021 22:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhC0VXr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Mar 2021 17:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhC0VX1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Mar 2021 17:23:27 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530ACC0613B2;
        Sat, 27 Mar 2021 14:23:26 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u10so11459889lju.7;
        Sat, 27 Mar 2021 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CcEJAWSSbm1JFhZGxEz23WyOc/TBORSZzsvbfWv5DLY=;
        b=AabR7NKqnV94dlIxy7Cvkm3DeMPQuh/7+QCCpNfFcRcNca7BPA1u25mkcm/c9MROgM
         MC1Zofh4H+BfQA3IwRwNUehnTJlufyHNX9Lx3pwJlIVNysC127DT/jh+txxrATVOhXVN
         OVQHJTsbQkVPW8BZgSRKSteE6Tp0Cfi9NqTkpk5GA+TeVvBLUBVFIP8JpGqqavDtEvdZ
         UF/3Bzk/kYypbrnLaAq9h9roHnUmt2qsBW/pw/WpEg2ZXEpsjupDSFHcOMb7N0CGtWvb
         W10/c8DrHl2AI8gl23svnsAVaDEBpuK2LUwpusjmi/dtjAUXQiqCRFtxxmyrPkP8Uf8v
         uOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CcEJAWSSbm1JFhZGxEz23WyOc/TBORSZzsvbfWv5DLY=;
        b=K0i6SllZQgj/xlTiT+mK9G+jmY9VQokyS/6APhcrJQpF9n1HvWEZ03aRqePl5bzwgO
         eVMT99GPdGX669vaoBc2CxVCAqo1kJjY/Vl94C0AHOoGNy3/u+iEmCqMYV0TEsBemBXt
         5Btyv+ycwo7Zu+RgBUkpG3jUfD9+monCbOWHhoapIaWwswVa0Hw6D0CgYYSuxxUDrY2B
         a76AkZ1ZILQu/a06gkUNVtYxW8qQ3EF9Tuu47BSlFUjhpsodZ4tdVE2sVHxiatvV0rOF
         VLAYXzmLbSt9iiRV5KfiimCpF6FeB3zDveom4oMMdrN+BWZaJaczNFVr1oWU8S++GIES
         KXAw==
X-Gm-Message-State: AOAM531YbdEwyqG1z9SaJ4GVyktgk7/jJdaJKj8upjDkaaclKPbEd812
        BlrYOLtcqgV10EXRcV5c0tE=
X-Google-Smtp-Source: ABdhPJxpQ3Of1eoPUnXix8BBxFRIDdLBWyCclKcGE77GaNOdUoR3o1oKl/ywO6Wr4S2nCgnb8tzLtg==
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr13574659ljj.284.1616880203815;
        Sat, 27 Mar 2021 14:23:23 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-66.dynamic.spd-mgts.ru. [109.252.193.66])
        by smtp.gmail.com with ESMTPSA id x7sm1300626lfe.182.2021.03.27.14.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 14:23:23 -0700 (PDT)
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
        Randy Dunlap <rdunlap@infradead.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH v1 0/3] Support EFI partition on NVIDIA Tegra devices
Date:   Sun, 28 Mar 2021 00:20:57 +0300
Message-Id: <20210327212100.3834-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

This series adds support for gpt_sector=<sector> kernel parameter used
specifically by Android devices that are based on NVIDIA Tegra SoCs.
This parameter is supplied by downstream bootloader, it tells the
number of a sector where EFI entry is located on EMMC storage.

A year ago we tried to upstream the support of gpt_sector and then the
support of NVIDIA's proprietary partition table, which was suggested by
Christoph Hellwig, but that effort didn't get enough attention.

Now, a year later, we have more Tegra devices running mainline kernel
and the situation hasn't changed, we still need to support the quirks
needed for accessing internal EMMC storage of the Tegra devices.  This
time I'm trying to get back to variant with supporting the gpt_sector
parameter, but in a way which doesn't disturb anything other than the
EMMC of NVIDIA Tegra devices, which previously was suggested by
Christoph Hellwig as well.

Dmitry Osipenko (3):
  mmc: core: Add raw_boot_mult field to mmc_ext_csd
  mmc: block: Add mmc_bdev_to_card() helper
  partitions/efi: Support gpt_sector parameter needed by NVIDIA Tegra
    devices

 block/partitions/Kconfig   |   8 +++
 block/partitions/Makefile  |   1 +
 block/partitions/check.h   |   2 +
 block/partitions/core.c    |   3 ++
 block/partitions/efi.c     |  18 +++++++
 block/partitions/tegra.c   | 108 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/block.c   |  15 ++++++
 drivers/mmc/core/mmc.c     |   2 +
 include/linux/mmc/blkdev.h |  13 +++++
 include/linux/mmc/card.h   |   1 +
 10 files changed, 171 insertions(+)
 create mode 100644 block/partitions/tegra.c
 create mode 100644 include/linux/mmc/blkdev.h

-- 
2.30.2

