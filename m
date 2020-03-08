Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B14C417D25B
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgCHIJH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgCHIJH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:09:07 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 876482072A;
        Sun,  8 Mar 2020 08:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583654946;
        bh=hLJ9CFsbuXNnSzqxjOWOGdWMTLJvW1pCNuIWPtWSRSA=;
        h=From:To:Cc:Subject:Date:From;
        b=Tryqldz5P1wtvDZjuO4CPKkvwUQ2KYptlEuE3dGD6KtQO1AeLzkCSLO4OzFMoxml/
         RoPLH9wUPHz2ucP1VUNv/VmE8EgMXc5I2zlXIYsnCEBzE6GFcgFwOf79Dyov1XFKWw
         t1h5SsKdmeccIxBaHfaTNyeDM0z8zsbTvCw+OxG8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [GIT PULL 00/28] More EFI fixes for v5.7
Date:   Sun,  8 Mar 2020 09:08:31 +0100
Message-Id: <20200308080859.21568-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit b9d8b63e340392d7f3ad79881f36a550566cbbbe:

  Merge tag 'stable-shared-branch-for-driver-tree' into HEAD (2020-03-05 09:58:20 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to dfb2a1c61fcdc8be5dd74608c411c78008a0f078:

  partitions/efi: Fix partition name parsing in GUID partition entry (2020-03-06 11:17:42 +0100)

----------------------------------------------------------------
More EFI updates for v5.7

- a fix for a boot regression in the IMA code on x86 booting without UEFI
- memory encryption fixes for x86, so that the TPM tables and the RNG
  config table created by the stub are correctly identified as living in
  unencrypted memory
- style tweak and doc update from Heinrich
- followup to the ARM EFI entry code simplifications to ensure that we
  don't rely on EFI_LOADER_DATA memory being RWX
- fixes from Arvind to ensure that the new mixed mode approach works as
  expected regardless of where the image is loaded in memory by the UEFI
  PE/COFF loader
- more fixes from Arvind to make it more likely that the image can be
  decompressed in place, regardless of where it was loaded in memory
- efivars bugfix and some cleanup from Vladis
- incorporate a stable branch with the EFI pieces of Hans's work on
  loading device firmware from EFI boot service memory regions
- some followup fixes for the EFI stub changes that are queued for
  v5.7 already
- an endianness fix for the EFI GPT partition table driver

----------------------------------------------------------------
Ard Biesheuvel (7):
      efi/arm: clean EFI stub exit code from cache instead of avoiding it
      efi/arm64: clean EFI stub exit code from cache instead of avoiding it
      efi: mark all EFI runtime services as unsupported on non-EFI boot
      efi/libstub/x86: deal with exit() boot service returning
      efi/x86: ignore memory attributes table on i386
      efi/x86: preserve %ebx correctly in efi_set_virtual_address_map()
      efi/libstub/x86: use ULONG_MAX as upper bound for all allocations

Arvind Sankar (11):
      efi/x86: Annotate the LOADED_IMAGE_PROTOCOL_GUID with SYM_DATA
      efi/x86: Respect 32-bit ABI in efi32_pe_entry
      efi/x86: Make efi32_pe_entry more readable
      efi/x86: Avoid using code32_start
      x86/boot: Use unsigned comparison for addresses
      x86/boot/compressed/32: Save the output address instead of recalculating it
      efi/x86: Decompress at start of PE image load address
      efi/x86: Add kernel preferred address to PE header
      efi/x86: Remove extra headroom for setup block
      efi/x86: Don't relocate the kernel unless necessary
      efi/x86: Fix cast of image argument

Heinrich Schuchardt (2):
      efi: don't shadow i in efi_config_parse_tables()
      efi/libstub: add libstub/mem.c to documentation tree

Lukas Bulwahn (1):
      MAINTAINERS: adjust EFI entry to removing eboot.c

Masahiro Yamada (1):
      efi/libstub: avoid linking libstub/lib-ksyms.o into vmlinux

Nikolai Merinov (1):
      partitions/efi: Fix partition name parsing in GUID partition entry

Tom Lendacky (2):
      efi/x86: Add TPM related EFI tables to unencrypted mapping checks
      efi/x86: Add RNG seed EFI table to unencrypted mapping check

Vladis Dronov (3):
      efi: fix a race and a buffer overflow while reading efivars via sysfs
      efi: add a sanity check to efivar_store_raw()
      efi: fix a mistype in comments mentioning efivar_entry_iter_begin()

 Documentation/driver-api/firmware/efi/index.rst |  11 +++
 Documentation/driver-api/firmware/index.rst     |   1 +
 MAINTAINERS                                     |   1 -
 arch/arm/boot/compressed/head.S                 |  18 ++--
 arch/arm64/kernel/efi-entry.S                   |  26 +++---
 arch/arm64/kernel/image-vars.h                  |   4 +-
 arch/x86/boot/compressed/head_32.S              |  47 ++++++----
 arch/x86/boot/compressed/head_64.S              | 112 +++++++++++++++++++-----
 arch/x86/boot/header.S                          |   6 +-
 arch/x86/boot/tools/build.c                     |  44 +++++++---
 arch/x86/kernel/asm-offsets.c                   |   1 -
 arch/x86/platform/efi/efi.c                     |   3 +
 arch/x86/platform/efi/efi_stub_32.S             |   2 +-
 block/partitions/efi.c                          |  35 ++++++--
 block/partitions/efi.h                          |   2 +-
 drivers/firmware/efi/Makefile                   |   2 +-
 drivers/firmware/efi/efi-pstore.c               |   2 +-
 drivers/firmware/efi/efi.c                      |  27 +++---
 drivers/firmware/efi/efivars.c                  |  32 +++++--
 drivers/firmware/efi/libstub/x86-stub.c         |  80 +++++++++++------
 drivers/firmware/efi/vars.c                     |   2 +-
 include/linux/efi.h                             |   2 +
 22 files changed, 319 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/driver-api/firmware/efi/index.rst
