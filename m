Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A991704FC
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 17:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgBZQ5s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 11:57:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgBZQ5r (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 26 Feb 2020 11:57:47 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42D2D21556;
        Wed, 26 Feb 2020 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582736267;
        bh=Snro6dewJjLv0IRXOXFhEpHZJxQtAuKLFzocHl4NYu0=;
        h=From:To:Cc:Subject:Date:From;
        b=QbkaaaoZusV5GN4xkIz9nl0KTwlVMJWOz/U0UGhMGMslxSGXIlqYGBBucWunuZ/Bi
         FhtgKLmotwCyNkQJVdwwxLaLcyZDbRiQen5vD3VKSD8LuRoKCkEYusfei8ECBkaebL
         mGw4gw3JvV+u8VPRKr4LlWXcfeREQztbJwGBiZQM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 0/5] ARM: decompressor: use by-VA cache maintenance for v7 cores
Date:   Wed, 26 Feb 2020 17:57:33 +0100
Message-Id: <20200226165738.11201-1-ardb@kernel.org>
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
core is running, as there usually is no system cache. But on systems
like SynQuacer, for which 32-bit firmware is available, the current cache
maintenance only pushes the data out to the L3 system cache, where it
is not visible to the CPU once it turns the MMU and caches off.

So instead, switch to the by-VA cache maintenance that the architecture
requires for v7 and later (and ARM1176, as a side effect).

Changes since v3:
- ensure that the region that is cleaned after self-relocation of the zImage
  covers the appended DTB, if present

Apologies to Linus, but due to this change, I decided not to take your
Tested-by into account, and I would appreciate it if you could retest
this version of the series? Thanks.

Changes since v2:
- add a patch to factor out the code sequence that obtains the inflated image
  size by doing an unaligned LE32 load from the end of the compressed data
- use new macro to load the inflated image size instead of doing a potentially
  unaligned load
- omit the stack for getting the base and size of the self-relocated zImage

Changes since v1:
- include the EFI patch that was sent out separately before (#1)
- split the preparatory work to pass the region to clean in r0/r1 in a EFI
  specific one and one for the decompressor - this way, the first two patches
  can go on a stable branch that is shared between the ARM tree and the EFI
  tree
- document the meaning of the values in r0/r1 upon entry to cache_clean_flush
- take care to treat the region end address as exclusive
- switch to clean+invalidate to align with the other implementations
- drop some code that manages the stack pointer value before calling
  cache_clean_flush(), which is no longer necessary
- take care to clean the entire region that is covered by the relocated zImage
  if it needs to relocate itself before decompressing

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm32-efi-cache-ops

[ Several people asked me offline why on earth I am running SynQuacer on 32 bit:
  the answer is that this is simply to prove that it is currently broken, and
  this implies that for 32-bit VMs running under KVM, we are relying on the
  special, non-architectural cache management done by the hypervisor on behalf
  of the guest to be able to run this code. ]

Cc: Russell King <linux@armlinux.org.uk>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

Ard Biesheuvel (5):
  efi/arm: Work around missing cache maintenance in decompressor
    handover
  efi/arm: Pass start and end addresses to cache_clean_flush()
  ARM: decompressor: factor out routine to obtain the inflated image
    size
  ARM: decompressor: prepare cache_clean_flush for doing by-VA
    maintenance
  ARM: decompressor: switch to by-VA cache maintenance for v7 cores

 arch/arm/boot/compressed/head.S | 162 +++++++++++---------
 1 file changed, 86 insertions(+), 76 deletions(-)

-- 
2.17.1

