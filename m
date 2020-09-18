Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9239126FA97
	for <lists+linux-efi@lfdr.de>; Fri, 18 Sep 2020 12:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgIRKbL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Sep 2020 06:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRKbL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 18 Sep 2020 06:31:11 -0400
Received: from e123331-lin.nice.arm.com (adsl-119.109.242.22.tellas.gr [109.242.22.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68EC920771;
        Fri, 18 Sep 2020 10:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600425070;
        bh=TLXrobjiQlDGswky3yG7no5chAToDauzPz6FD8pw+TA=;
        h=From:To:Cc:Subject:Date:From;
        b=Br0X/BkoMg1i0pm/A91EfH/2QnYD1R8TcPXq7UH+ps1mTl9gPH1y9H7YVSorgx2hc
         p+ifu5p+AXyw/ikAFzGBlK6ssRu1OxiTLS8ydDjqguIbAYvYdSfSxnGltzvD9vQXvm
         aMGWyTREw6dYlGyYm8NlzUWdYB+EP2ahzry1TeAo=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [RFC/RFT PATCH 0/6] ARM: p2v: reduce min alignment to 2 MiB
Date:   Fri, 18 Sep 2020 13:30:56 +0300
Message-Id: <20200918103102.18107-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series is inspired by Zhei Len's series [0], which updates the
ARM p2v patching code to optionally support p2v relative alignments
of as little as 64 KiB.

Reducing this alignment is necessary for some specific Huawei boards,
but given that reducing this minimum alignment will make the boot
sequence more robust for all platforms, especially EFI boot, which
no longer relies on the 128 MB masking of the decompressor load address,
but uses firmware memory allocation routines to find a suitable spot
for the decompressed kernel.

This series is not based on Zhei Len's code, but addresses the same
problem, and takes some feedback given in the review into account:
- use of a MOVW instruction to avoid two adds/adcs sequences when dealing
  with the carry on LPAE
- add support for Thumb2 kernels as well
- make the change unconditional - it will bit rot otherwise, and has value
  for other platforms as well.

The first four patches are general cleanup and preparatory changes.
Patch #5 implements the switch to a MOVW instruction without changing
the minimum alignment.
Patch #6 reduces the minimum alignment to 2 MiB.

Tested on QEMU in ARM/!LPAE, ARM/LPAE, Thumb2/!LPAE and Thumb2/LPAE modes.

Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Nicolas Pitre <nico@fluxnic.net>

[0] https://lore.kernel.org/linux-arm-kernel/20200915015204.2971-1-thunder.leizhen@huawei.com/

Ard Biesheuvel (6):
  ARM: p2v: factor out shared loop processing
  ARM: p2v: factor out BE8 handling
  ARM: p2v: drop redundant 'type' argument from __pv_stub
  ARM: p2v: use relative references in patch site arrays
  ARM: p2v: switch to MOVW for Thumb2 and ARM/LPAE
  ARM: p2v: reduce p2v alignment requirement to 2 MiB

 arch/arm/Kconfig              |   2 +-
 arch/arm/include/asm/memory.h |  58 ++++++---
 arch/arm/kernel/head.S        | 136 ++++++++++++--------
 3 files changed, 123 insertions(+), 73 deletions(-)

-- 
2.17.1

