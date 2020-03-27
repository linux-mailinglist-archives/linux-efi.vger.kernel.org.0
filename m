Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 112241955CF
	for <lists+linux-efi@lfdr.de>; Fri, 27 Mar 2020 11:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgC0K7X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Mar 2020 06:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgC0K7X (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Mar 2020 06:59:23 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94EFB20705;
        Fri, 27 Mar 2020 10:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585306762;
        bh=90UfxI5OVQUnvcKw/oB6o3ZeklCir3nEiRKTl6IJlks=;
        h=From:To:Cc:Subject:Date:From;
        b=eXsrgFV/FedQh+Ab0iPY74W5JQKaPYaoZNLPZ9g2ELiuM4S84AsWvChXP+xKj/wNg
         wIHTZHzCq7Q99xQVoBEt88aEiNRBeqckbDuMkHFPhH/cH9Fitk63iNCSd1Ko6lnn2p
         hmYn0zRfSs2Y8zxZY6VQjwYex5qzecAKKrahmmoQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 0/5] ARM: simplify handover from UEFI to decompressor
Date:   Fri, 27 Mar 2020 11:59:01 +0100
Message-Id: <20200327105906.2665-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI stub in the ARM kernel runs in the context of the firmware, which
means it runs with the caches and MMU on. Currently, we relocate the zImage
so it appears in the first 128 MiB, disable the MMU and caches and invoke
the decompressor via its ordinary entry point. However, since we can pass
the base of DRAM directly, there is no need to relocate the zImage, which
also means there is no need to disable and re-enable the caches and create
new page tables etc.

This simplification is implemented by patch #5. Patches #1 - #4 are
prerequisite changes to permit the decompressor to execute from the
offset chosen by the UEFI firmware.

Note that this applies onto linux-next with Geert's patch 'ARM: boot: Obtain
start of physical memory from DTB' applied [0]

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>

[0] https://lore.kernel.org/linux-arm-kernel/20200320144348.12865-1-geert+renesas@glider.be/

Ard Biesheuvel (5):
  ARM: decompressor: move headroom variable out of LC0
  ARM: decompressor: split off _edata and stack base into separate
    object
  ARM: decompressor: defer loading of the contents of the LC0 structure
  ARM: decompressor: move GOT into .data for EFI enabled builds
  ARM: decompressor: run decompressor in place if loaded via UEFI

 arch/arm/boot/compressed/head.S           | 84 +++++++-------------
 arch/arm/boot/compressed/vmlinux.lds.S    |  5 ++
 drivers/firmware/efi/libstub/arm32-stub.c | 41 ++--------
 3 files changed, 38 insertions(+), 92 deletions(-)

-- 
2.17.1

