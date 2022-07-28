Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4780F584116
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 16:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiG1O2o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 10:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiG1O2n (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 10:28:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE3065D48;
        Thu, 28 Jul 2022 07:28:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sz17so3446369ejc.9;
        Thu, 28 Jul 2022 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gvXbeuK/nDPmsZZTRnDVNdv3SfvIgHhFwFU2kIzHG68=;
        b=UUn+zotXHe6ND+iqyztenRNM6eQqekQZejLSPdmR7TqJ/qPLS7+rJB6KdPHJxTiZK+
         q3BotwxEHcUR0oxFWmR8c3559LeGfizKqWvCE/alvuJctwxRL+0/gyKCu9GT2leHLrOY
         x6tXIjp7tGWh5atJIbhoXTGnFxQq658fGLd3SHG4ZCyiHaQh+hZLHXksYqUzfQJzK2cv
         Y0LACEGoBZWEGxcBTk5kV+NcgEpQ30wdddhf+ysl1YBNQjYAYClayxzS9uXCs2IkNZnR
         OOT27cxCpxgBMtOTuQyLc9fuI8ymnflO2gnBwmGQSNljurU5u2C3BQ7S9PDmoZyfO6h9
         e0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gvXbeuK/nDPmsZZTRnDVNdv3SfvIgHhFwFU2kIzHG68=;
        b=A+k/JTpdFYWttticERrj01uw8e9nqMOqqqpofWA0LmqhYEaJXKjcRmBHKv0OL9XvJ4
         iQ6S/42SF1CQXTZ9GX0xoVzW6rL3i2GO4v2SJ684AOoBvvViD2ONAcxI6te3CtrBX25k
         ih/skHD17aNktL81ZVopS7p2wMdhfVXn23sS0Y+7xQwbL2sEKkk5bQNPkwAnNV8H+Z3Y
         uzGNQDarxtp2JSrY+zIMGDTSRPOdDWaITFeabPHqMHv0nU1/nZniYd33Auc7dARAYnmV
         zZbENdAHNJYm+LICSaxUh74cMdt9/Y0g8LpWGvL5KkYs91KbuAbyHMicIxrjeL1Ow8jK
         a11A==
X-Gm-Message-State: AJIora/6Pq+lV3lD5k8eX79+IjxQTbXHAxNj/d7To7xG6sYa5BTjeEzO
        rOLPITw9Dw4JAWEDoTEtUC4AuxP/qecyApbz
X-Google-Smtp-Source: AGRyM1usb4SPM3cGqtqin0Wwas0cy7iM0Lq2zERxvCAmcTEakP2TyeXIbIB/uwiXZ00pIE3dJWi/UQ==
X-Received: by 2002:a17:907:6d01:b0:72f:53f:7a25 with SMTP id sa1-20020a1709076d0100b0072f053f7a25mr20932970ejc.126.1659018519713;
        Thu, 28 Jul 2022 07:28:39 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([23.154.177.9])
        by smtp.gmail.com with ESMTPSA id y1-20020aa7d501000000b0043cce1d3a0fsm755949edq.87.2022.07.28.07.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 07:28:39 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] Add generic framebuffer support to EFI earlycon driver
Date:   Thu, 28 Jul 2022 17:28:17 +0300
Message-Id: <20220728142824.3836-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Make the EFI earlycon driver be suitable for any linear framebuffers.
This should be helpful for early porting of boards with no other means of
output, like smartphones/tablets. There seems to be an issue with early_ioremap
function on ARM32, but I am unable to find the exact cause. It appears the mappings
returned by it are somehow incorrect, thus the driver is disabled on ARM. EFI early
console was disabled on IA64 previously, so I kept it in EFI earlycon Kconfig.

This patch also changes behavior on EFI systems, by selecting the mapping type
based on if the framebuffer region intersects with system RAM. If it does, it's
common sense that it should be in RAM as a whole, and so the system RAM mapping is
used. It was tested to be working on my PC (Intel Z490 platform).

Markuss Broks (2):
  drivers: serial: earlycon: Pass device-tree node
  efi: earlycon: Add support for generic framebuffers and move to fbdev
    subsystem

 .../admin-guide/kernel-parameters.txt         |  12 +-
 MAINTAINERS                                   |   5 +
 drivers/firmware/efi/Kconfig                  |   6 +-
 drivers/firmware/efi/Makefile                 |   1 -
 drivers/firmware/efi/earlycon.c               | 246 --------------
 drivers/tty/serial/earlycon.c                 |   3 +
 drivers/video/fbdev/Kconfig                   |  11 +
 drivers/video/fbdev/Makefile                  |   1 +
 drivers/video/fbdev/earlycon.c                | 301 ++++++++++++++++++
 include/linux/serial_core.h                   |   1 +
 10 files changed, 331 insertions(+), 256 deletions(-)
 delete mode 100644 drivers/firmware/efi/earlycon.c
 create mode 100644 drivers/video/fbdev/earlycon.c

-- 
2.37.0

