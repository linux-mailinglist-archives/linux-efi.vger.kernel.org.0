Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185D23EE3C3
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 03:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhHQBhg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Aug 2021 21:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhHQBhf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Aug 2021 21:37:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF90C061764;
        Mon, 16 Aug 2021 18:37:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d4so38130866lfk.9;
        Mon, 16 Aug 2021 18:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y13ssgfr6sKUkeUKlxkE5t/sIHmN7oG9hneGkaoPog4=;
        b=HTmG7uMHTcKj2CNO6v36hEPhj00NFrlE80NEDH+zHeojdyZkWVuhZQGZEmlNEkvH7g
         ew1SZpIbNk/bq8iaMwRKJ4v8rhdwFOrZm6RaoPePji0ndGR49VTsJ0UT2P2TvlSgeMhq
         tXOyB6AATcz9/VTt0yOUotQYEkWUKQbGbG/wuz/+3kwi8gTY73HMpHtZ0XanhQeoS9xA
         ugXME5zkTuelXZewyXLZ9jGBJSsAqJxxC0mXhV0b9QUtdWxJGxXSd3bKhJmjn8h6V9EQ
         keOa9wODuQDutNVdQuDqeRwONO5eYpDm46ieeVH9RnvVve/mZErBs47x294li+7Zgnl7
         jVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y13ssgfr6sKUkeUKlxkE5t/sIHmN7oG9hneGkaoPog4=;
        b=a0pKftuHZYpDxlDbBXZfj9/23rUmuF1fxJziCeC6gwF2d99pCPD0ftHVrGP0LlGOm7
         bpY7wvzS2YHde8B7wKpIAee2JSmMNcCjnzQ4XB9MIi3Q36MmvIP7l19x1JlMqgwwiekd
         R+VucG6ZrEnXxWz0I+3FoI62Y4LVktR2yvF3bdat6K9diZ9eqGpusjZ3LJM8T1srak4D
         jCuFBq8yPCt7QL166XjkJU3UcxKysD07eNoieslWmfIh0L8pFe05mXT3s1OYSR8i321y
         2UPbHjMFv7tFHB12vkmb8s4acLZ+KVXjkQ6y2b7EJZhrt9aeijkoGZkB+tB1BmZIT9Lp
         t5Kw==
X-Gm-Message-State: AOAM532Vsc9EeIS7fAg3p12XDOYJy8RSL7782GEN1DQGJWxRtZ4SaM9R
        F4ig+Wpj/uxb64RKXydcN/w=
X-Google-Smtp-Source: ABdhPJxRPENKda40qWNOWkQl41qMWmI0e+3KTqYXF5TovPBTtKNHJHlY+Pur3Wdx0urrmcdihJX+aw==
X-Received: by 2002:ac2:4c2a:: with SMTP id u10mr511478lfq.631.1629164221740;
        Mon, 16 Aug 2021 18:37:01 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id br33sm49699lfb.46.2021.08.16.18.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:37:01 -0700 (PDT)
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
Subject: [PATCH v4 0/3] Support EFI partition on NVIDIA Tegra devices
Date:   Tue, 17 Aug 2021 04:36:40 +0300
Message-Id: <20210817013643.13061-1-digetx@gmail.com>
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

v4: - Rebased on top of recent linux-next.

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
 block/partitions/efi.c     |  9 +++++
 block/partitions/tegra.c   | 75 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/block.c   | 15 ++++++++
 drivers/mmc/core/mmc.c     |  2 +
 include/linux/mmc/blkdev.h | 13 +++++++
 include/linux/mmc/card.h   |  1 +
 10 files changed, 129 insertions(+)
 create mode 100644 block/partitions/tegra.c
 create mode 100644 include/linux/mmc/blkdev.h

-- 
2.32.0

