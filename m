Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FAD1D9C89
	for <lists+linux-efi@lfdr.de>; Tue, 19 May 2020 18:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgESQ1A (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 May 2020 12:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgESQ07 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 19 May 2020 12:26:59 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44CCC207FB;
        Tue, 19 May 2020 16:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905619;
        bh=gttWjWL8xYUb+Tczx1HyO/+yr0UIgrXN4QhVzeWuWTM=;
        h=From:To:Cc:Subject:Date:From;
        b=Ma8Zr/G3N0gedcDU0dr5mkD9VXaBjHskBb4EmZOa33JzzQSAUkkLOsfSJezIQDsJ2
         IypGGtY3QWzhUXdlC28Kkmjjp+kVy/OBH3aUN2FMaDUjX27AiBImLsUGEw1CLJbjbD
         Y//AhLldSzBF8jDWcuaB2PnbgqloHDW+Ko73qepE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 0/5] ARM: simplify handover from UEFI to decompressor
Date:   Tue, 19 May 2020 18:26:40 +0200
Message-Id: <20200519162645.31065-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI stub in the ARM kernel runs in the context of the firmware, which
means it usually runs with the caches and MMU on. Currently, we relocate
the zImage so it appears in the first 128 MiB, disable the MMU and caches
and invoke the decompressor via its ordinary entry point. However, since we
can pass the base of DRAM directly, there is no need to relocate the zImage,
which also means there is no need to disable and re-enable the caches and
create new page tables etc.

This simplification is implemented by patch #5. Patches #1 - #4 are
prerequisite changes to permit the decompressor startup code to be invoked
past its ordinary entry point, and execute from the offset where the UEFI
firmware happened to load it.

Note that this applies onto rmk/for-next as of today.

Changes since v3:
- rebase onto rmk/for-next with Geert's DT memory node patch [0] removed, as
  it has been reverted again due to regressions

Changes since v2:
- Set the LSB of the image address if we are entering with MMU and caches off,
  so that the decompressor will install its own page tables as it usually
  does. This might happen on U-Boot platforms that call 'bootefi' without
  enabling the caches (which technically violates the UEFI spec, but might
  be working fine today)
- Add Nico's ack to the series

Changes since v1:
- Tweak some asm sequences in #2 to fix the Thumb2 build
- Switch immediately to the new stack in #5

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>

[0] https://lore.kernel.org/linux-arm-kernel/20200429082120.16259-1-geert+renesas@glider.be/

Ard Biesheuvel (5):
  ARM: decompressor: move headroom variable out of LC0
  ARM: decompressor: split off _edata and stack base into separate
    object
  ARM: decompressor: defer loading of the contents of the LC0 structure
  ARM: decompressor: move GOT into .data for EFI enabled builds
  ARM: decompressor: run decompressor in place if loaded via UEFI

 arch/arm/boot/compressed/head.S           | 79 ++++++++------------
 arch/arm/boot/compressed/vmlinux.lds.S    |  5 ++
 drivers/firmware/efi/libstub/arm32-stub.c | 45 ++---------
 3 files changed, 43 insertions(+), 86 deletions(-)

-- 
2.17.1

