Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65C61FF333
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jun 2020 15:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgFRNhT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Jun 2020 09:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbgFRNhS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Jun 2020 09:37:18 -0400
Received: from dogfood.home (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE57B207D8;
        Thu, 18 Jun 2020 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592487437;
        bh=pec/O/I4RH7I8OCdzel7EhoV5x66TexZsFfO+Qc0kx8=;
        h=From:To:Cc:Subject:Date:From;
        b=kABHa/zGWusC98sbpmBAlhIkhKnCscYW4ULJeqhRX6hybuSFrLNn8Qc7uoIcdXEDf
         T9KNRv3QRGc+oFGmtY6P/CTZFU6iSQpNyxEh0u4SEesqQagoK6T3lD9rl2J2OeEnrv
         MqneTEif+6LMfSmTTgwJzvJJU3TCF/9VF+eLm9E0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] EFI fixes for v5.8
Date:   Thu, 18 Jun 2020 15:37:14 +0200
Message-Id: <20200618133714.1227453-1-ardb@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.8-rc1

for you to fetch changes up to 2a55280a3675203496d302463b941834228b9875:

  efi/libstub: arm: Print CPU boot mode and MMU state at boot (2020-06-17 15:29:11 +0200)

----------------------------------------------------------------
EFI fixes for v5.8-rc1:
- Fix build regression on v4.8 and older
- Robustness fix for TPM log parsing code
- kobject refcount fix for the ESRT parsing code
- Two efivarfs fixes to make it behave more like an ordinary file system
- Style fixup for zero length arrays
- Fix a regression in path separator handling in the initrd loader
- Fix a missing prototype warning
- Add some kerneldoc headers for newly introduced stub routines
- Allow support for SSDT overrides via EFI variables to be disabled
- Report CPU mode and MMU state upon entry for 32-bit ARM
- Use the correct stack pointer alignment when entering from mixed mode

----------------------------------------------------------------
Ard Biesheuvel (3):
      efi/libstub: Fix missing-prototype warning for skip_spaces()
      efi/libstub: arm: Omit arch specific config table matching array on arm64
      efi/libstub: arm: Print CPU boot mode and MMU state at boot

Arvind Sankar (2):
      efi/x86: Fix build with gcc 4
      efi/x86: Setup stack correctly for efi_pe_entry

Fabian Vogt (1):
      efi/tpm: Verify event log header before parsing

Gustavo A. R. Silva (1):
      efi: Replace zero-length array and use struct_size() helper

Heinrich Schuchardt (1):
      efi/libstub: Descriptions for stub helper functions

Peter Jones (1):
      efi: Make it possible to disable efivar_ssdt entirely

Philipp Fent (1):
      efi/libstub: Fix path separator regression

Qiushi Wu (1):
      efi/esrt: Fix reference count leak in esre_create_sysfs_entry.

Tony Luck (2):
      efivarfs: Update inode modification time for successful writes
      efivarfs: Don't return -EINTR when rate-limiting reads

 arch/arm/include/asm/efi.h                     |  7 +++
 arch/x86/boot/compressed/head_64.S             | 11 +++-
 drivers/firmware/efi/Kconfig                   | 11 ++++
 drivers/firmware/efi/arm-init.c                | 40 +++++++++++--
 drivers/firmware/efi/efi.c                     |  5 +-
 drivers/firmware/efi/esrt.c                    |  2 +-
 drivers/firmware/efi/libstub/Makefile          |  3 +-
 drivers/firmware/efi/libstub/arm32-stub.c      | 54 +++++++++++++++++-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 78 ++++++++++++++++++++++----
 drivers/firmware/efi/libstub/efi-stub.c        |  3 +
 drivers/firmware/efi/libstub/efistub.h         | 12 +++-
 drivers/firmware/efi/libstub/file.c            | 16 ++++--
 drivers/firmware/efi/libstub/skip_spaces.c     |  1 +
 fs/efivarfs/file.c                             |  7 +--
 include/linux/efi.h                            |  8 +--
 include/linux/tpm_eventlog.h                   | 14 ++++-
 16 files changed, 235 insertions(+), 37 deletions(-)
