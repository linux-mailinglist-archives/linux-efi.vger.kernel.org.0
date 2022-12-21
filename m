Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574DC652FE4
	for <lists+linux-efi@lfdr.de>; Wed, 21 Dec 2022 11:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiLUKyh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Dec 2022 05:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiLUKyg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Dec 2022 05:54:36 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658591902F;
        Wed, 21 Dec 2022 02:54:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i7so14495569wrv.8;
        Wed, 21 Dec 2022 02:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dYF4aCoOjNocXMp5ObQdxM+1IiESaniY5tGPacmK2hI=;
        b=UPW7reYDRuGDUoiD+Lb3uTPFeJy8MKOAkABhUJagUeaIYU2k84h1Kbzb2indRGVCZ/
         +nH3idszhlY/oUm6Zvg6tHwqhKOVw6u5cipKErnxKQsnKJ8G4IvA3UyMnfjorA8szIBA
         I9JsUylJt8PX4aPDA8l4ich2/9lN6I4mEyMBRk5iXtA6hhfqo3IxHTZFJZRjqFMLKbsp
         dEzycxHUNgzX6Ur9PxTwGkpja06mu+WlioLu0T/qj0rgpVbaFCaQJJdD17J208t5tQ1c
         T3ywqFaYmQE6qB2qnWrGLYiyPdKqjcE/oxCRMdnGXpufnq9kZVHvaGfHYtDof2gIy8sE
         hSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYF4aCoOjNocXMp5ObQdxM+1IiESaniY5tGPacmK2hI=;
        b=rGkXSsGkQUFqrNl8Y6PB6rV6qGeF09jcwJIITNyimhs8vcI4JJHQd4RwPoObzcVSWy
         7G+ZU/ZjqjwW9PBz6hE6cwJBtxSowiIdxXbw0cyColOHqIeUX/HhEKFxCUrQna4H1Wjy
         SUvHMgSkfRZL7QRixBrBmYkSc7UWWPuOQwPvZhtKcnokiTeQQ31F+t7hrjIQ7Ym+M6yu
         t53yO9/Pwf14xcQ3xM9vOTZat8EuXPwOAfbr3ZmtGwpo3N83TmzsfYWXSgVZFCVZ9wUl
         iAQ7i4bzb3jp2i06NSwS28y+rDYwoMqE0ueN4VWG1bXBt14rFzS1zZMdVf+Zxkmj/rJL
         uufg==
X-Gm-Message-State: AFqh2kpibcl7xXPb6mtIkOrZ54fWUeQTiHMTj5EicASeu6P/QQgmgAxQ
        9Q1uCtBX4mv4r4icJadMbASROYrkSa1GVw==
X-Google-Smtp-Source: AMrXdXtIftRiBiFpiF6+MSGQS3GVWuGnzm/NgMFLOBRRFdQV+jBuHN9wNcOzPNqZa5/poEcZ9eVQBg==
X-Received: by 2002:adf:eecf:0:b0:24a:852d:e292 with SMTP id a15-20020adfeecf000000b0024a852de292mr779711wrp.46.1671620073626;
        Wed, 21 Dec 2022 02:54:33 -0800 (PST)
Received: from localhost.localdomain ([37.55.203.63])
        by smtp.gmail.com with ESMTPSA id y5-20020a056000108500b0023657e1b980sm15080156wrw.53.2022.12.21.02.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 02:54:33 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jami Kettunen <jami.kettunen@protonmail.com>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/3] Add generic framebuffer support to EFI earlycon driver
Date:   Wed, 21 Dec 2022 12:53:57 +0200
Message-Id: <20221221105402.6598-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
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


Markuss Broks (3):
  drivers: serial: earlycon: Pass device-tree node
  efi: earlycon: move to video/console to prepare for changes
  efi: earlycon: Add support for generic framebuffers

 .../admin-guide/kernel-parameters.txt         |  12 +-
 MAINTAINERS                                   |   5 +
 drivers/firmware/efi/Kconfig                  |   7 +-
 drivers/firmware/efi/Makefile                 |   1 -
 drivers/firmware/efi/earlycon.c               | 246 --------------
 drivers/tty/serial/earlycon.c                 |   3 +
 drivers/video/console/Kconfig                 |  11 +
 drivers/video/console/Makefile                |   1 +
 drivers/video/console/earlycon.c              | 305 ++++++++++++++++++
 include/linux/serial_core.h                   |   1 +
 10 files changed, 336 insertions(+), 256 deletions(-)
 delete mode 100644 drivers/firmware/efi/earlycon.c
 create mode 100644 drivers/video/console/earlycon.c

-- 
2.39.0

