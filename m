Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFB7E21C4
	for <lists+linux-efi@lfdr.de>; Wed, 23 Oct 2019 19:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfJWRcD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Oct 2019 13:32:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38173 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfJWRcD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Oct 2019 13:32:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so20476696wmi.3
        for <linux-efi@vger.kernel.org>; Wed, 23 Oct 2019 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dmtFsSUBWA54jB5wbZR7TL/ePVjER+sBaUCUBdLRxXM=;
        b=x6ROYP7fQnUWXi7GomAjmzViOaiRf4rEu2CVqKuswbfpWXqv40LiLqN/Eg94rawgyb
         zfXZ5hSKFTk2Up6JdnCD1FYkuKwTL32r+TbfVH6AmSgoOGG5sBM0Rnm+k14ieZ3qhJOO
         JWZlSgfcBVsyOhb5kG2YnCjItfXoSU7aIM+8DABOW0XbziSqB86q2LnPaoQ1bKqhgIH8
         akwKAcbwQl69DKFd9/sRxkTd99DsVW5XMglsRSyJSl2OR3OklDESQOUDdlNA1IvavfwF
         cet7YlMT3pjXyHyXx6AIQVTnxkFoE00naoHSTo98s8dAKlz+ZDvA0A/KN0esS8cKuHp1
         067Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dmtFsSUBWA54jB5wbZR7TL/ePVjER+sBaUCUBdLRxXM=;
        b=PORerK9N7B6s1KBTOjxpPumxKDFLnKF7UsMngOGh9qxy7wlDFr8RkqfML+rSNtrMTH
         FZw/x5r47yqAPhpqeKCWhXHDK0E7oxVvJdtEjO9cSH7prSbqC//2qlXiw6BhglwjKKMS
         X2pBbm/QftyUPg66zG9swJAKS0xPgsHm3+oDnDyqzzIRkhWldjNn5iroNz6PFWhXE2kG
         s2AtvcBP1xK3Jru3Z9CauHuDfQNRcCJD0KLAQFW8GKiddKkMbujX/5IzIKvCXZ5p1ngu
         czjK6nUJAYNaCs0m9ERX53DpbigC25Tz8mOWdel1h/ewAswG/JmYIMU5H4wxbF6MIXyP
         /c4A==
X-Gm-Message-State: APjAAAUeQrTLQO/j+76L0J6xGxqzJEBkWeHsFjb8QjiCJ2TwgqwpqklM
        Cygi/7x//tlxz9oMmQIUtcw44xLVVc0K2Y4q
X-Google-Smtp-Source: APXvYqwpg48qOMHAuNtyyvSmuZgoDwb0BYtWY3fWDcD0ur3NTmDRxKFO5PFgey3pimscOkk/uSduog==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr985909wms.166.1571851920625;
        Wed, 23 Oct 2019 10:32:00 -0700 (PDT)
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr. [90.118.215.104])
        by smtp.gmail.com with ESMTPSA id f7sm14900374wre.68.2019.10.23.10.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 10:31:59 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Chester Lin <clin@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Kairui Song <kasong@redhat.com>,
        Narendra K <Narendra.K@dell.com>
Subject: [GIT PULL 0/5] EFI fixes for v5.4
Date:   Wed, 23 Oct 2019 19:31:56 +0200
Message-Id: <20191023173201.6607-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
X-ARM-No-Footer: FoSSMail
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-urgent

for you to fetch changes up to 0d0013109c849cccb16560df213b5d6115a2d206:

  x86, efi: never relocate kernel below lowest acceptable address (2019-10-23 09:00:10 +0200)

----------------------------------------------------------------
Some more fixes for the EFI subsystem:
- Prevent boot problems on HyperV due to incorrect placement of the kernel
- Classify UEFI randomness as bootloader randomness
- Fix EFI boot for the Raspberry Pi2 running U-boot
- Some more odd fixes.

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi: libstub/arm: account for firmware reserved memory at the base of RAM

Dominik Brodowski (1):
      efi/random: treat EFI_RNG_PROTOCOL output as bootloader randomness

Jerry Snitselaar (1):
      efi/tpm: return -EINVAL when determining tpm final events log size fails

Kairui Song (1):
      x86, efi: never relocate kernel below lowest acceptable address

Narendra K (1):
      efi: Make CONFIG_EFI_RCI2_TABLE selectable on x86 only

 arch/x86/boot/compressed/eboot.c               |  4 +++-
 drivers/firmware/efi/Kconfig                   |  1 +
 drivers/firmware/efi/efi.c                     |  2 +-
 drivers/firmware/efi/libstub/Makefile          |  1 +
 drivers/firmware/efi/libstub/arm32-stub.c      | 16 +++++++++++++---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 24 ++++++++++--------------
 drivers/firmware/efi/tpm.c                     |  1 +
 include/linux/efi.h                            | 18 ++++++++++++++++--
 8 files changed, 46 insertions(+), 21 deletions(-)
