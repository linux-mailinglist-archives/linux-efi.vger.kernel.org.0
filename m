Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCD227D5B5
	for <lists+linux-efi@lfdr.de>; Tue, 29 Sep 2020 20:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgI2SYR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Sep 2020 14:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728084AbgI2SYR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 29 Sep 2020 14:24:17 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F32208B8;
        Tue, 29 Sep 2020 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601403857;
        bh=VBF7oER3OXvqw3jPD63YJxye3I49ABCEVwfRLpfjJmM=;
        h=From:To:Cc:Subject:Date:From;
        b=coBTbdJoYu5ydR45NL5J/YcEhhQjOGpW3HbpH+CXOwEev0U12Wg1aeLrsgV62GyBo
         5xLhEEEtK6Y9X+yDKR7Wnl2md0kEX6rHR2xpVxtYmYo2ifnb1GR6tnpJy5/ifZ4jrL
         7NZoarFJl72n8rGRqvdJfHDAuNERwXO6k9nB2AEY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI fixes for v5.9
Date:   Tue, 29 Sep 2020 20:24:12 +0200
Message-Id: <20200929182412.31858-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 46908326c6b801201f1e46f5ed0db6e85bef74ae:

  efi: efibc: check for efivars write capability (2020-09-15 18:22:47 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.9-rc7

for you to fetch changes up to d32de9130f6c79533508e2c7879f18997bfbe2a0:

  efi/arm64: libstub: Deal gracefully with EFI_RNG_PROTOCOL failure (2020-09-29 15:41:52 +0200)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
EFI fixes for v5.9:
- add definition of the EFI_MEMORY_CPU_CRYPTO memory attribute so we can
  identify it in the memory map listings
- don't abort the boot on arm64 if the EFI RNG protocol is available but
  returns with an error
- replace slashes with exclamation marks in efivarfs file names
- a couple of cosmetic fixups

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi: Add definition of EFI_MEMORY_CPU_CRYPTO and ability to report it
      efi/arm64: libstub: Deal gracefully with EFI_RNG_PROTOCOL failure

Michael Schaller (1):
      efivarfs: Replace invalid slashes with exclamation marks in dentries.

Tian Tao (2):
      efi/libstub: Fix missing-prototypes in string.c
      efi: Delete deprecated parameter comments

 drivers/firmware/efi/efi.c                | 47 ++++++++++++++++---------------
 drivers/firmware/efi/libstub/arm64-stub.c |  8 ++++--
 drivers/firmware/efi/libstub/fdt.c        |  4 +--
 drivers/firmware/efi/libstub/string.c     |  1 +
 drivers/firmware/efi/vars.c               |  1 -
 fs/efivarfs/super.c                       |  3 ++
 include/linux/efi.h                       |  1 +
 7 files changed, 35 insertions(+), 30 deletions(-)
