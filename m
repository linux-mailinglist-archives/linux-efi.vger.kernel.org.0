Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5195328BBB3
	for <lists+linux-efi@lfdr.de>; Mon, 12 Oct 2020 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389332AbgJLPVX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Oct 2020 11:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389142AbgJLPVX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Oct 2020 11:21:23 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B2DC0613D0;
        Mon, 12 Oct 2020 08:21:23 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id t25so23671446ejd.13;
        Mon, 12 Oct 2020 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mDHkO+ShV9R79gDvb/BSzjPZAmNc+g+poz3n5bkVv3M=;
        b=AOqxsvfWKCcAjcrHl7GaSMMZHEFtwsQfWV3iuPAryCvmzHHi27Fs6eObvLa+0C7HgN
         J8eiSIBvxiRyowOUopx5iss2oChcFPCkA3rbXhlPl20CcRoTZh6IJEE8Fo3RERXWohZo
         uYY/UT5qBkN3AeD3qW6ESGytLPEaeqaxolWDcM503gopZzosji9TzA0BBrJRvjqUXk64
         lLXvd8iTzsi4eCTpY15w0t+hRwLxvxo5ZzwpqcogUvVCsZPwwhNyITudUVTd3INQGfYv
         MfXR/1kp7P4gynvfLCbRR4G3hLtXWkONwquIGzWW1vpqP7A3MtPRTSQaTbebSPg8/nHj
         9fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=mDHkO+ShV9R79gDvb/BSzjPZAmNc+g+poz3n5bkVv3M=;
        b=RfWEUFCjefGTS/M1r57o1bOKEwYmpoLEBaymKp2x0yvyPeIwNEyvoQ3rarXwD/XIp7
         KVDNxh1PDgYHoAHRKD3RTjJ7Qsi4eEOMDYr0yn96YfJ93vDHw9PYotCOC/P92iJ0OLpH
         BpcK4V86jI7Qwha6UMwNkrRjxcsyE/v5ILStryrDfjDLBSyoJjm+J9fLzUuw2nGGmCLW
         ElFp2wNgvKzDNLo/DLOB3q+nSmBb38n+ITE7+CUUbylJdzExUi4Cbt+L3bAwDn1KI2Z4
         uL4cVDD4zR01EkNm1NJexVVR6KU7EA1TIOt4ZMCAQQDxjOZx7dLqvJYQRKRfXLuuFLRT
         Z5EA==
X-Gm-Message-State: AOAM530VYUYz6UXLYKsVU0u/G3RZ2/yJFBxfZy3F4kJJdvsqPUCP8/nr
        M8a4rbNpIdasB+B1iVIdJFw=
X-Google-Smtp-Source: ABdhPJxqrQAawDp5W2uDMvu5yfJL2udrBJjX87rSpEVY1akJj79p+13KwIiriPg9qczz75d/Ny9JOg==
X-Received: by 2002:a17:906:a289:: with SMTP id i9mr11291595ejz.193.1602516081981;
        Mon, 12 Oct 2020 08:21:21 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id z22sm10703583ejw.107.2020.10.12.08.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 08:21:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 17:21:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] EFI changes for v5.10
Message-ID: <20201012152119.GA3476595@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linus,

Please pull the latest efi/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2020-10-12

   # HEAD: 4d0a4388ccdd9482fef6b26f879d0f6099143f80 Merge branch 'efi/urgent' into efi/core, to pick up fixes

EFI changes for v5.10:

 - Preliminary RISC-V enablement - the bulk of it will arrive via the RISCV tree.

 - Relax decompressed image placement rules for 32-bit ARM

 - Add support for passing MOK certificate table contents via a config table
   rather than a EFI variable.

 - Add support for 18 bit DIMM row IDs in the CPER records.

 - Work around broken Dell firmware that passes the entire Boot#### variable
   contents as the command line

 - Add definition of the EFI_MEMORY_CPU_CRYPTO memory attribute so we can
   identify it in the memory map listings.

 - Don't abort the boot on arm64 if the EFI RNG protocol is available but
   returns with an error

 - Replace slashes with exclamation marks in efivarfs file names

 - Split efi-pstore from the deprecated efivars sysfs code, so we can
   disable the latter on !x86.

 - Misc fixes, cleanups and updates.

 Thanks,

	Ingo

------------------>
Alex Kluver (2):
      edac,ghes,cper: Add Row Extension to Memory Error Record
      cper,edac,efi: Memory Error Record: bank group/address and chip id

Ard Biesheuvel (13):
      efi/libstub: arm32: Base FDT and initrd placement on image address
      efi/libstub: Export efi_low_alloc_above() to other units
      efi/libstub: arm32: Use low allocation for the uncompressed kernel
      efi: Add definition of EFI_MEMORY_CPU_CRYPTO and ability to report it
      efi/arm64: libstub: Deal gracefully with EFI_RNG_PROTOCOL failure
      efi: mokvar-table: fix some issues in new code
      efi: pstore: disentangle from deprecated efivars module
      efi: pstore: move workqueue handling out of efivars
      efi: efivars: un-export efivars_sysfs_init()
      efi: gsmi: fix false dependency on CONFIG_EFI_VARS
      efi: remove some false dependencies on CONFIG_EFI_VARS
      efi: efivars: limit availability to X86 builds
      efi: mokvar: add missing include of asm/early_ioremap.h

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

Michael Schaller (1):
      efivarfs: Replace invalid slashes with exclamation marks in dentries.

Tian Tao (3):
      efi/printf: remove unneeded semicolon
      efi/libstub: Fix missing-prototypes in string.c
      efi: Delete deprecated parameter comments


 Documentation/arm/uefi.rst                      |   2 +-
 arch/arm/include/asm/efi.h                      |  23 +-
 arch/arm64/include/asm/efi.h                    |   5 +-
 arch/x86/kernel/setup.c                         |   1 +
 arch/x86/platform/efi/efi.c                     |   3 +
 drivers/edac/ghes_edac.c                        |  17 +-
 drivers/firmware/efi/Kconfig                    |  18 +-
 drivers/firmware/efi/Makefile                   |   3 +-
 drivers/firmware/efi/cper.c                     |  18 +-
 drivers/firmware/efi/{arm-init.c => efi-init.c} |   1 +
 drivers/firmware/efi/efi-pstore.c               |  83 +++++-
 drivers/firmware/efi/efi.c                      |  53 ++--
 drivers/firmware/efi/efivars.c                  |  45 +--
 drivers/firmware/efi/libstub/arm32-stub.c       | 178 +++---------
 drivers/firmware/efi/libstub/arm64-stub.c       |   9 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c  | 101 ++++++-
 drivers/firmware/efi/libstub/efi-stub.c         |  48 +---
 drivers/firmware/efi/libstub/efistub.h          |  61 +++-
 drivers/firmware/efi/libstub/fdt.c              |   4 +-
 drivers/firmware/efi/libstub/file.c             |   5 +-
 drivers/firmware/efi/libstub/relocate.c         |   4 +-
 drivers/firmware/efi/libstub/string.c           |   1 +
 drivers/firmware/efi/libstub/vsprintf.c         |   2 +-
 drivers/firmware/efi/mokvar-table.c             | 359 ++++++++++++++++++++++++
 drivers/firmware/efi/vars.c                     |  22 --
 drivers/firmware/google/Kconfig                 |   2 +-
 drivers/firmware/google/gsmi.c                  |   8 +-
 fs/efivarfs/super.c                             |   3 +
 include/linux/cper.h                            |  24 +-
 include/linux/efi.h                             |  46 ++-
 include/linux/pe.h                              |   3 +
 security/integrity/platform_certs/load_uefi.c   |  85 ++++--
 32 files changed, 871 insertions(+), 366 deletions(-)
 rename drivers/firmware/efi/{arm-init.c => efi-init.c} (99%)
 create mode 100644 drivers/firmware/efi/mokvar-table.c
