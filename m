Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A846C2CF2A4
	for <lists+linux-efi@lfdr.de>; Fri,  4 Dec 2020 18:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388521AbgLDRFr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Dec 2020 12:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388510AbgLDRFq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Dec 2020 12:05:46 -0500
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1612C08E85E;
        Fri,  4 Dec 2020 09:04:50 -0800 (PST)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CnfF12X1nz8shk;
        Fri,  4 Dec 2020 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1607101445;
        bh=CNSPo3rU73iLufUhzAAlkyJdrqDxV3HykhrbciRVVqg=;
        h=From:To:Cc:Subject:Date:From;
        b=CAj2903IlbaunC80bM+z7sehEdvvySRvMXF2B7QVSeGl9c1o2+R49o1Johhg6BSQ4
         Q4EMyEP3bIuGgoqirMK1uT98XPrJ1OTptjksAJf1V5Duw6RhXyRn+MKAiMRbwunKkr
         vE228J0uaZtyVw5ECCzsQr3hgtGk8lvECyg5M/Pg=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CnfDy1SRgz8sfb;
        Fri,  4 Dec 2020 17:04:02 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     Russell King <linux@armlinux.org.uk>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [RFC PATCH v1 00/12] Replace strstarts() by str_has_prefix()
Date:   Fri,  4 Dec 2020 18:03:06 +0100
Message-Id: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

Hi.


First, I hope you are fine and the same for your relatives.

In this patch set, I replaced all calls to strstarts() by calls to
str_has_prefix().
Indeed, the kernel has two functions to test if a string begins with an other:
1. strstarts() which returns a bool, so 1 if the string begins with the prefix,
0 otherwise.
2. str_has_prefix() which returns the length of the prefix or 0.

str_has_prefix() was introduced later than strstarts(), in commit 495d714ad140
which also stated that str_has_prefix() should replace strstarts().
This is what this patch set does.

Concerning the patches, the modifications cover different areas of the kernel.
I compiled all of them and they compile smoothly.
Unfortunately, I did not test all of them, so here are the status of the patches
regarding test:
1. Tested with qemu-system-arm using insmod.
2. I do not have access to a bcm47xx MIPS CPU an qemu-system-mips does not
emulate this board.
3. Tested with qemu-system-x86_64 calling
crypto_alloc_skcipher("essiv(authenc(hmac(sha256),cbc(aes)),sha256)", 0, 0)
through LKDTM.
4. Tested with qemu-system-x86_64 using crypsetup.
5. I do not have access to a renesas board and I lack some context to test it
with qemu-system-arm.
6. I do not have access to an OMAP board and I lack some context to test it with
qemu-system-arm.
7. I did not find how to boot from the EFI_STUB with qemu. If you know how to
do, I would be happy to try running this code.
8. I ran qemu-system-x86_64 with a floppy disk attached but impossible to go
through this module code...
9. I do not have access to a bcm63xx MIPS CPU an qemu-system-mips does not
emulate this board.
10. Tested with qemu-system-x86_64 using insmod.
11. I do not have access to an AM335x or DA8xx platforms and I lack some context
to test it with qemu-system-arm.

If you see a way to improve the patches or if I did something wrong with the
mail do not hesitate to ask.


Best regards.

Francis Laniel (12):
  arm: Replace strstarts() by str_has_prefix().
  mips: Replace strstarts() by str_has_prefix().
  crypto: Replace strstarts() by str_has_prefix().
  device-mapper: Replace strstarts() by str_has_prefix().
  renesas: Replace strstarts() by str_has_prefix().
  omap: Replace strstarts() by str_has_prefix().
  efi: Replace strstarts() by str_has_prefix().
  ide: Replace strstarts() by str_has_prefix().
  mips: Replace strstarts() by str_has_prefix().
  module: Replace strstarts() by str_has_prefix().
  musb: Replace strstarts() by str_has_prefix().
  string.h: Remove strstarts().

 arch/arm/kernel/module.c                      | 12 +++++------
 arch/mips/bcm47xx/board.c                     |  4 ++--
 arch/mips/bcm63xx/boards/board_bcm963xx.c     |  2 +-
 crypto/essiv.c                                |  2 +-
 .../firmware/efi/libstub/efi-stub-helper.c    |  2 +-
 drivers/firmware/efi/libstub/gop.c            | 10 +++++-----
 drivers/gpu/drm/omapdrm/dss/base.c            |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c        |  2 +-
 drivers/ide/ide-floppy.c                      |  4 ++--
 drivers/md/dm-crypt.c                         |  4 ++--
 drivers/usb/musb/musb_cppi41.c                |  4 ++--
 drivers/usb/musb/musb_debugfs.c               | 20 +++++++++----------
 include/linux/string.h                        | 10 ----------
 kernel/module.c                               |  6 +++---
 14 files changed, 37 insertions(+), 47 deletions(-)

-- 
2.20.1

