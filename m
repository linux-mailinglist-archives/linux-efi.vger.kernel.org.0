Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04FF1C6B6B
	for <lists+linux-efi@lfdr.de>; Wed,  6 May 2020 10:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgEFITv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 May 2020 04:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbgEFITu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 6 May 2020 04:19:50 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3152120714;
        Wed,  6 May 2020 08:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588753190;
        bh=PWMM3kT0ABXGqymWpNLRYqWaQ9HTNg5EFVcVWwoEfTI=;
        h=From:To:Cc:Subject:Date:From;
        b=mCOBUa6HCaA8B2xUAoRUx93cdBJCOGSepe3slTife/7F580tWhjC9iUMC2WxrLqow
         d1dS/bPUGt4ihEBPgM04D8q2vrmyDUvZJx/i5P3QUYKA7tRHC2Pez7VSUllhFMfQKR
         cOPDZOIlobWcPQsEoAW4/M6N1vbOxKEyTFR89vr8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 0/5] ARM: simplify handover from UEFI to decompressor
Date:   Wed,  6 May 2020 10:19:34 +0200
Message-Id: <20200506081939.8986-1-ardb@kernel.org>
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

Ard Biesheuvel (5):
  ARM: decompressor: move headroom variable out of LC0
  ARM: decompressor: split off _edata and stack base into separate
    object
  ARM: decompressor: defer loading of the contents of the LC0 structure
  ARM: decompressor: move GOT into .data for EFI enabled builds
  ARM: decompressor: run decompressor in place if loaded via UEFI

 arch/arm/boot/compressed/head.S           | 91 ++++++++------------
 arch/arm/boot/compressed/vmlinux.lds.S    |  5 ++
 drivers/firmware/efi/libstub/arm32-stub.c | 45 ++--------
 3 files changed, 48 insertions(+), 93 deletions(-)

-- 
2.17.1

