Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8293DE988
	for <lists+linux-efi@lfdr.de>; Tue,  3 Aug 2021 11:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhHCJMf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Aug 2021 05:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234631AbhHCJMf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Aug 2021 05:12:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC38360F0F;
        Tue,  3 Aug 2021 09:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627981945;
        bh=ikodFRDQvHUYP3E1u0R4c0duHBA9UAOf5d+tyRKjPI4=;
        h=From:To:Cc:Subject:Date:From;
        b=du34ftk16zsShtkeW5bCBXrmjyIBXehS8HVqJ4RdRYMr6Pi2xx8vDsjPRRUalsrl2
         LG4anTZYAWcdAR4WqWpeLHiiJy4NyzrdTmpmyV0xiAbGRO8vRS1Ot38DQWLjVni981
         xv9wu6Lu//g0vM+HzHYIdKfiR/KdSJ7RLZq0LJWM/2nDp+dyLMowK1KBACu1phHn8u
         t7e1S86sXRwYiMLiR/SqVYVIUT2rc4rXcIoMhkz+V59GAywrba60Cs/wH18mRP9Y6k
         Z2DA45i/o86e7AgbacdnJYseSSv0Y1dlVbRIL/4Eyk3tV7gdUaTqpRXSJEwStnHFmv
         G3yKnBX1FtM0g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [GIT PULL] EFI fixes for v5.14-rc4
Date:   Tue,  3 Aug 2021 11:12:15 +0200
Message-Id: <20210803091215.2566-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 47e1e233e9d822dfda068383fb9a616451bda703:

  efi/mokvar: Reserve the table only if it is in boot services data (2021-07-20 09:28:09 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.14-rc4

for you to fetch changes up to c32ac11da3f83bb42b986702a9b92f0a14ed4182:

  efi/libstub: arm64: Double check image alignment at entry (2021-08-03 07:43:13 +0200)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

----------------------------------------------------------------
EFI fixes for v5.14-rc2:

A batch of fixes for the arm64 stub image loader:
- fix a logic bug that can make the random page allocator fail
spuriously
- force reallocation of the Image when it overlaps with firmware
reserved memory regions
- fix an oversight that defeated on optimization introduced earlier
where images loaded at a suitable offset are never moved if booting
without randomization
- complain about images that were not loaded at the right offset by the
firmware image loader.

----------------------------------------------------------------
Ard Biesheuvel (4):
      efi/libstub: arm64: Force Image reallocation if BSS was not reserved
      efi/libstub: arm64: Relax 2M alignment again for relocatable kernels
      efi/libstub: arm64: Warn when efi_random_alloc() fails
      efi/libstub: arm64: Double check image alignment at entry

Benjamin Herrenschmidt (1):
      arm64: efi: kaslr: Fix occasional random alloc (and boot) failure

 drivers/firmware/efi/libstub/arm64-stub.c  | 71 +++++++++++++++++++++++++-----
 drivers/firmware/efi/libstub/randomalloc.c |  2 +
 2 files changed, 63 insertions(+), 10 deletions(-)
