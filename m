Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD9A3EF70D
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 02:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhHRA5q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 20:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbhHRA5q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 20:57:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7394BC061764;
        Tue, 17 Aug 2021 17:57:12 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i9so850070lfg.10;
        Tue, 17 Aug 2021 17:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6oXFRATTxmrl3SJwMn5v8ibx/U35v05GN+b9HBgF4II=;
        b=Y7IwiZDEdy8gPIViPEbbMQjQXS5l4Erre5oEW4j/LI12gPxk3cibcrNItMNtR96tsx
         /hEJzyp0nadZgHFZU3YLI6CI3nVv+Vg4HrKskOrxzRp5X8P5hA7g/P/w9/OGPITxwZ16
         OBAMw4A+qH9oqjumL1dQLrQ63VnoLOFUmGsn939jf14yyC86nMjn8yIealtadn7fzCNs
         vKgjmto3Zo1yenrqWnp/AXTxeC/0CfaaxHROypDqEj8XaEjwiH67JJLK98i02hKjoy+m
         OuWNez6TdBoXup1jkXZkuZlZ6EKhVFzaCng0ZkuDFSliuH+wr7FyypbDmnTqWmcCF8NC
         nXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6oXFRATTxmrl3SJwMn5v8ibx/U35v05GN+b9HBgF4II=;
        b=tuXyZGbXSOArbGOdocxNLpOV6IpXYiEKpBoxsUPIM2aDzA7VmyMe9dx8Wj6k+wnp84
         uO7x0uNQMMLsOdZrZBrQaPOYflozD4YgoM8ZCgwjL68cEPeBJUnsiH0mz2HS/DSKDBgI
         NJYEBXiBN9JTUxr4ZPec/Ewwck2Sm9yQHhY1LGBf1YC2RMh/G7xGpSRxYg1VmIOH86pO
         pxwshu1HvRIEnyKV7gNhKuubdiVCuufYnhAuAcKLW/IrWz/2oMdeDJ3WabefUvYuWms8
         kpXurO8Fnb+vFqIDGj1eMc8zi4i5HYeFvSR+h/s/LawhGr9n965/tlMlY0jC4Wzj4k5Y
         0jvg==
X-Gm-Message-State: AOAM533dPqF6AcyM3VlOqrGrxGbx+WO9csufaULi2KywVxiztpq2fyWO
        nrE2zIgZfjp0qLTrvNf/6i8=
X-Google-Smtp-Source: ABdhPJw8Z/4ekKldrzBctMm8kW58h+zzRE3NliyLzY/6Vn0vOYvfANTZPW9ueqHKvEwJTjvphgCJQQ==
X-Received: by 2002:ac2:5e84:: with SMTP id b4mr4249474lfq.169.1629248230867;
        Tue, 17 Aug 2021 17:57:10 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id h19sm335879lfu.138.2021.08.17.17.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 17:57:10 -0700 (PDT)
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
Subject: [PATCH v5 0/5] Support EFI partition on NVIDIA Tegra devices
Date:   Wed, 18 Aug 2021 03:55:42 +0300
Message-Id: <20210818005547.14497-1-digetx@gmail.com>
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
  mmc: block: Support alternative_gpt_sector() operation
  mmc: core: Add raw_boot_mult field to mmc_ext_csd
  mmc: sdhci-tegra: Implement alternative_gpt_sector()
  partitions/efi: Support non-standard GPT location

 block/partitions/efi.c         | 13 +++++++++++
 drivers/mmc/core/block.c       | 30 ++++++++++++++++++++++++
 drivers/mmc/core/mmc.c         |  2 ++
 drivers/mmc/host/sdhci-tegra.c | 42 ++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h         |  1 +
 include/linux/mmc/card.h       |  1 +
 include/linux/mmc/host.h       |  4 ++++
 7 files changed, 93 insertions(+)

-- 
2.32.0

