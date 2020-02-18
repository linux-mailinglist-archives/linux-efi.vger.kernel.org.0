Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78362162AEB
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2020 17:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgBRQpV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Feb 2020 11:45:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgBRQpU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 Feb 2020 11:45:20 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECB2E208C4;
        Tue, 18 Feb 2020 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582044320;
        bh=+2SpNmyfTUVe42vgI91DR/e37g2sr67kx9vcvXWW0lc=;
        h=From:To:Cc:Subject:Date:From;
        b=nhAS1Hyv2EQypIp639Vw4nrmp/Z3SP/k2ESjVpvsJPlVfu4Y44HoPJ5VOV0lbB9Mo
         3MrfkrMpa/5N/WK2Bbu8oRk1eaO5t7SS+Kbv5pmZ9r7rHFBmaBUboZhEPWCuDS0nl1
         Rx8GwnCntbHCLyxUyT+YiVB4460t1Zq2PqmJCLoY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 0/2] ARM: decompressor: use by-VA cache maintenance for v7 cores
Date:   Tue, 18 Feb 2020 17:44:28 +0100
Message-Id: <20200218164430.32671-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

While making changes to the EFI stub startup code, I noticed that we are
still doing set/way maintenance on the caches when booting on v7 cores.
This works today on VMs by virtue of the fact that KVM traps set/way ops
and cleans the whole address space by VA on behalf of the guest, and on
most v7 hardware, the set/way ops are in fact sufficient when only one
core is running, as there usually is no system cache.

But let's make this code a bit more future proof, by switching to by-VA
ops for the v7 code paths (and for ARM1176, as a side effect).

Note that these patches are based on an EFI stub fix that I have omitted
here, and which can be found at

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=arm32-efi-cache-ops&id=01d742dcf0a3dce6f6db9e4661750129bc3d3216

Cc: Russell King <linux@armlinux.org.uk>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>

Ard Biesheuvel (2):
  ARM: decompressor: prepare cache_clean_flush for doing by-VA
    maintenance
  ARM: decompressor: switch to by-VA cache maintenance for v7 cores

 arch/arm/boot/compressed/head.S | 105 ++++++++++----------
 1 file changed, 54 insertions(+), 51 deletions(-)

-- 
2.17.1

