Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3B58B6DB
	for <lists+linux-efi@lfdr.de>; Sat,  6 Aug 2022 18:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiHFQeD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 6 Aug 2022 12:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiHFQeC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 6 Aug 2022 12:34:02 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A37FD22;
        Sat,  6 Aug 2022 09:34:01 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id p10so2739313ile.5;
        Sat, 06 Aug 2022 09:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=CrJZA7OyrjgVNT2yluOnXy9DkAQBVd94845d/Gv6tLM=;
        b=BBnD1fZYV9L2qmB93O8uuBM7b56i/6rpHB39Gt4NkxShp0AsrpWMBGl/hy/vBshktb
         uqT7gsS2icCt8SfpYN2cW6sPvBtB/02bOxI5UVcvvsI/8/XBDUx7U4iufh68Zr1Vyx0U
         XvNmYYOCkUDsh5TTrbb9bEEjDI+H/1OLOc0H1OlLUGHf9BtWfGLsiDMZMr/jTUTb0gmn
         yGOy1qm7kpSH4/DUDZ1T6G81Bd6zON/uxEygpVzX3b1VL4aJi8ob277QNJZpYb1V0xo0
         pf/bRHA4vutnBu8e7AerEFWX2zS+hrsbt2OeIkRRfDjTTVllZumPKga35ZYUcjwZIZp7
         aOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CrJZA7OyrjgVNT2yluOnXy9DkAQBVd94845d/Gv6tLM=;
        b=T2GHP5MRfLr/qE5C7SU/xy2qZFIasNgxb7LXrXD7mcjc9ZyBrToCFeaUQh0sCly0GN
         cL9PaZMEjtq7yUP0Pm8yPUZ0xZ0LNG4AUSWO0ONYLuE09boHpVwUc0wld0HrMXphkbQY
         oqqp7KwSbDikmqAHqYb5P9GTjx7wW4DrtSqU2XX60u8GaMPoAdNArnApZZAnOqohndM9
         SCzL4Jj+VfNALd5JmFOLimNXQOGlr8wrfw+cvpHnFe4Cm/r5l+cDhbZNqnozKWFKIk0K
         ah3IekXYCuyqX1GztM2Js5j8qHuXR57+Ja/QfzdABjuy1SFf4R9Bhl7sUyPIHPvRud+6
         TDpw==
X-Gm-Message-State: ACgBeo0JRZBxxgvYtl24KQtKUpDLZJv9ZIQCGDPKK3V8wCEi1ZLS26kC
        NEYUTGslHJv+bKmYUeNSuJkGCa921DUb4hEU
X-Google-Smtp-Source: AA6agR4ik2yLjyl4JGzH05jPebblOZOGEbVYo9YxyJpbB8q+HpxUbT/8PJmzG5GbANnhrZXBdyKDhQ==
X-Received: by 2002:a05:6e02:1a61:b0:2e0:c417:4cb0 with SMTP id w1-20020a056e021a6100b002e0c4174cb0mr1025014ilv.186.1659803640515;
        Sat, 06 Aug 2022 09:34:00 -0700 (PDT)
Received: from nergzd-desktop.localdomain (tor-exit-50.for-privacy.net. [185.220.101.50])
        by smtp.gmail.com with ESMTPSA id a20-20020a056e020e1400b002de6fa0d0c0sm2908009ilk.63.2022.08.06.09.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:34:00 -0700 (PDT)
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
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/3] Add generic framebuffer support to EFI earlycon driver
Date:   Sat,  6 Aug 2022 19:32:21 +0300
Message-Id: <20220806163255.10404-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
console was disabled on IA64 previously because of missing early_memremap_prot,
and this is inherited to this driver.

This patch also changes behavior on EFI systems, by selecting the mapping type
based on if the framebuffer region intersects with system RAM. If it does, it's
common sense that it should be in RAM as a whole, and so the system RAM mapping is
used. It was tested to be working on my PC (Intel Z490 platform), as well as several
ARM64 boards (Samsung Galaxy S9 (Exynos), iPad Air 2, Xiaomi Mi Pad 4, ...).

Markuss Broks (2):
  drivers: serial: earlycon: Pass device-tree node
  efi: earlycon: Add support for generic framebuffers and move to fbdev
    subsystem


v1 -> v2:

- a new patch correcting serial/earlycon.c argument name to "offset" instead
  of "node"
- move IA64 exclusion from EFI earlycon Kconfig to earlycon driver Kconfig
  (IA64 has no early_memremap_prot)
- move driver from fbdev to console subsystem
- select EFI earlycon by default
- fetch stride manually from device-tree, as on some devices it seems stride
  doesn't match the horizontal resolution * bpp.
- use saner format (e.g. 1920x1080x32 instead of 1920,1080,32).

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

