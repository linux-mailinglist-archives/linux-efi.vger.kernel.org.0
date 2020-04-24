Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016601B762D
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgDXNGN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgDXNGN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:13 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F317B20728;
        Fri, 24 Apr 2020 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733572;
        bh=MGfaKuTdiHMWXthLJG7QjKnDtjDnpF4Sbmv1jSHLBaw=;
        h=From:To:Cc:Subject:Date:From;
        b=mt2kNDVx0/Zn5SRqp6TTuvYKiha8u0LKNG4C0Mm81Hj/xmd4c+ipnN1bI8I9d/qOb
         L2eCkuDsXWm0krlV9vsSHbdia8h5wNwC35oKuuoSVq2yKgkghNaMw5cs9xqX7KALd4
         fv8J3CzfLL+l4brN8mLPIPSxQIZwcGLe3r+DSrMk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [GIT PULL 00/33] EFI updates for v5.8
Date:   Fri, 24 Apr 2020 15:04:58 +0200
Message-Id: <20200424130531.30518-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Ingo, Thomas,

Please pull the attached changes into tip/efi/next. There is some
coordination going on with the RISC-V tree this time, so please take the
patches in this exact order, and apply them onto v5.7-rc2 so the first
three patches can serve as a shared stable base between the efi/core
branch and the riscv tree.

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to 4eb8320bd1aaa7e69d039f2c251735e3ef0b9a38:

  efi: Move arch_tables check to caller (2020-04-24 14:52:16 +0200)

----------------------------------------------------------------
EFI changes for v5.8:
- preliminary changes for RISC-V
- add support for setting the resolution on the EFI framebuffer
- simplify kernel image loading for arm64
- Move .bss into .data via the linker script instead of relying on symbol
  annotations.
- Get rid of __pure getters to access global variables
- Clean up the config table matching arrays

----------------------------------------------------------------
Ard Biesheuvel (14):
      efi/libstub: Make initrd file loader configurable
      efi/libstub: Unify EFI call wrappers for non-x86
      efi/libstub/random: Align allocate size to EFI_ALLOC_ALIGN
      efi/libstub/random: Increase random alloc granularity
      efi/libstub/arm64: Replace 'preferred' offset with alignment check
      efi/libstub/arm64: Simplify randomized loading of kernel image
      efi/libstub: Add API function to allocate aligned memory
      efi/libstub/arm64: Switch to ordinary page allocator for kernel image
      efi/libstub: Move efi_relocate_kernel() into separate source file
      efi/libstub: Drop __pure getter for efi_system_table
      efi/libstub: Drop __pure getters for EFI stub options
      efi/libstub/x86: Avoid getter function for efi_is64
      efi: Clean up config table description arrays
      efi: Move arch_tables check to caller

Arvind Sankar (17):
      efi/gop: Remove redundant current_fb_base
      efi/gop: Move check for framebuffer before con_out
      efi/gop: Get mode information outside the loop
      efi/gop: Factor out locating the gop into a function
      efi/gop: Slightly re-arrange logic of find_gop
      efi/gop: Move variable declarations into loop block
      efi/gop: Use helper macros for populating lfb_base
      efi/gop: Use helper macros for find_bits
      efi/gop: Remove unreachable code from setup_pixel_info
      efi/gop: Add prototypes for query_mode and set_mode
      efi/gop: Allow specifying mode number on command line
      efi/gop: Allow specifying mode by <xres>x<yres>
      efi/gop: Allow specifying depth as well as resolution
      efi/gop: Allow automatically choosing the best mode
      efi/arm: Remove __efistub_global annotation
      efi/x86: Remove __efistub_global and add relocation check
      efi: Kill __efistub_global

Atish Patra (1):
      efi/libstub: Move arm-stub to a common file

Zou Wei (1):
      efi/libstub/arm: Make install_memreserve_table static

 Documentation/fb/efifb.rst                         |  33 +-
 arch/arm/Kconfig                                   |   2 +-
 arch/arm/boot/compressed/vmlinux.lds.S             |   2 +-
 arch/arm/include/asm/efi.h                         |   8 -
 arch/arm64/Kconfig                                 |   2 +-
 arch/arm64/include/asm/efi.h                       |   8 -
 arch/ia64/kernel/efi.c                             |  12 +-
 arch/x86/boot/compressed/vmlinux.lds.S             |   1 +
 arch/x86/include/asm/efi.h                         |  29 +-
 arch/x86/platform/efi/efi.c                        |   8 +-
 drivers/firmware/efi/Kconfig                       |  15 +-
 drivers/firmware/efi/arm-init.c                    |   4 +-
 drivers/firmware/efi/efi.c                         |  44 +-
 drivers/firmware/efi/libstub/Makefile              |  42 +-
 drivers/firmware/efi/libstub/alignedmem.c          |  57 +++
 drivers/firmware/efi/libstub/arm64-stub.c          |  94 ++--
 drivers/firmware/efi/libstub/efi-stub-helper.c     |  47 +-
 .../efi/libstub/{arm-stub.c => efi-stub.c}         |  23 +-
 drivers/firmware/efi/libstub/efistub.h             |  96 ++--
 drivers/firmware/efi/libstub/fdt.c                 |   8 +-
 drivers/firmware/efi/libstub/file.c                |  34 +-
 drivers/firmware/efi/libstub/gop.c                 | 492 ++++++++++++++++-----
 drivers/firmware/efi/libstub/mem.c                 | 191 +-------
 drivers/firmware/efi/libstub/randomalloc.c         |   6 +-
 drivers/firmware/efi/libstub/relocate.c            | 174 ++++++++
 drivers/firmware/efi/libstub/x86-stub.c            |  35 +-
 include/linux/efi.h                                |   2 +-
 27 files changed, 895 insertions(+), 574 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/alignedmem.c
 rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (96%)
 create mode 100644 drivers/firmware/efi/libstub/relocate.c
