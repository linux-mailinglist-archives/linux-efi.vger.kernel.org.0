Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6697B26D519
	for <lists+linux-efi@lfdr.de>; Thu, 17 Sep 2020 09:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgIQHtM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Sep 2020 03:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgIQHtK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 17 Sep 2020 03:49:10 -0400
Received: from e123331-lin.nice.arm.com (unknown [91.140.120.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 949BB21973;
        Thu, 17 Sep 2020 07:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600328950;
        bh=fe11vJ5nLDhnnc4YY1V5J/gS9a1wAD9qSfRvYWpSuvE=;
        h=From:To:Cc:Subject:Date:From;
        b=pu1BCGWlwYO8B+Q4lU/mxkOdVO/qioHCtSB0z0prW9mm/h2qpIx9E0swFUZS2PyRl
         rVG8FAHhbn+PqblBvagU0EDw39/6e510awzMqxKJy+ls+LalBcATVC29hJXfuas8y0
         aR6bOpGXBpj3mUeTQ3sf6pS+SN9Cj95ezoowtnuY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI changes for v5.10
Date:   Thu, 17 Sep 2020 10:49:03 +0300
Message-Id: <20200917074904.15816-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.10

for you to fetch changes up to 612b5d506d066cdf0a739963e7cd28642d500ec1:

  cper,edac,efi: Memory Error Record: bank group/address and chip id (2020-09-17 10:19:52 +0300)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
EFI changes for v5.10:
- some preliminary changes related to RISC-V support - the bulk of it
  will arrive via the riscv tree
- relax decompressed image placement rules for 32-bit ARM
- add support for passing MOK certificate table contents via a config table
  rather than a EFI variable
- work around broken Dell firmware that passes the entire Boot#### variable
  contents as the command line
- add support for 18 bit DIMM row IDs in the CPER records.

----------------------------------------------------------------
Alex Kluver (2):
      edac,ghes,cper: Add Row Extension to Memory Error Record
      cper,edac,efi: Memory Error Record: bank group/address and chip id

Ard Biesheuvel (3):
      efi/libstub: arm32: Base FDT and initrd placement on image address
      efi/libstub: Export efi_low_alloc_above() to other units
      efi/libstub: arm32: Use low allocation for the uncompressed kernel

Arvind Sankar (2):
      efi/libstub: Add efi_warn and *_once logging helpers
      efi/x86: Add a quirk to support command line arguments on Dell EFI firmware

Atish Patra (2):
      include: pe.h: Add RISC-V related PE definition
      efi: Rename arm-init to efi-init common for all arch

Lenny Szubowicz (3):
      efi: Support for MOK variable config table
      integrity: Move import of MokListRT certs to a separate routine
      integrity: Load certs from the EFI MOK config table

Tian Tao (1):
      efi/printf: remove unneeded semicolon

 arch/arm/include/asm/efi.h                      |  23 +-
 arch/arm64/include/asm/efi.h                    |   5 +-
 arch/x86/kernel/setup.c                         |   1 +
 arch/x86/platform/efi/efi.c                     |   3 +
 drivers/edac/ghes_edac.c                        |  17 +-
 drivers/firmware/efi/Makefile                   |   3 +-
 drivers/firmware/efi/cper.c                     |  18 +-
 drivers/firmware/efi/{arm-init.c => efi-init.c} |   1 +
 drivers/firmware/efi/efi.c                      |   6 +
 drivers/firmware/efi/libstub/arm32-stub.c       | 178 +++---------
 drivers/firmware/efi/libstub/arm64-stub.c       |   1 -
 drivers/firmware/efi/libstub/efi-stub-helper.c  | 101 ++++++-
 drivers/firmware/efi/libstub/efi-stub.c         |  48 +---
 drivers/firmware/efi/libstub/efistub.h          |  61 +++-
 drivers/firmware/efi/libstub/file.c             |   5 +-
 drivers/firmware/efi/libstub/relocate.c         |   4 +-
 drivers/firmware/efi/libstub/vsprintf.c         |   2 +-
 drivers/firmware/efi/mokvar-table.c             | 360 ++++++++++++++++++++++++
 include/linux/cper.h                            |  24 +-
 include/linux/efi.h                             |  34 +++
 include/linux/pe.h                              |   3 +
 security/integrity/platform_certs/load_uefi.c   |  85 ++++--
 22 files changed, 746 insertions(+), 237 deletions(-)
 rename drivers/firmware/efi/{arm-init.c => efi-init.c} (99%)
 create mode 100644 drivers/firmware/efi/mokvar-table.c
