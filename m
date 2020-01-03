Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E892D12F797
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 12:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgACLkR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 06:40:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbgACLkR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:17 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46DC121835;
        Fri,  3 Jan 2020 11:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051616;
        bh=YCnh2bjtvzMK85XmelAkUX2fnI8ywWKdYa01Y5hGEEA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZZHjYvVgDKlrsQ5Dg3YaObOyT98JEx4nPrcu8A+xi4qeRtgwhRwoavCLU22BMW1OR
         rkpJS/s4F6Mc3/dOhoXH4ZN68uzBSIvhGaXDPl9EeMJwos22JanQ08iymqyrYu6+80
         mwyWClffeti/UjEARFyD5PP/KWl8wlXJLUhpoqFk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [GIT PULL 00/20] More EFI updates for v5.6
Date:   Fri,  3 Jan 2020 12:39:33 +0100
Message-Id: <20200103113953.9571-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ingo, Thomas,

This is the second batch of EFI updates for v5.6. Two things are still
under discussion, so I'll probably have a few more changes for this
cycle in a week or so.

The following changes since commit 0679715e714345d273c0e1eb78078535ffc4b2a1:

  efi/libstub/x86: Avoid globals to store context during mixed mode calls (2019-12-25 10:49:26 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to d95e4feae5368a91775c4597a8f298ba84f31535:

  efi/x86: avoid RWX mappings for all of DRAM (2020-01-03 11:46:15 +0100)

----------------------------------------------------------------
Second batch of EFI updates for v5.6:
- Some followup fixes for the EFI stub changes that have been queued up
  already.
- Overhaul of the x86 EFI boot/runtime code, to peel off layers of pointer
  casting and type mangling via variadic macros and asm wrappers that made
  the code fragile and ugly.
- Increase robustness for mixed mode code, by using argmaps to annotate and
  translate function prototypes that are not mixed mode safe. (Arvind)
- Add the ability to disable DMA at the root port level in the EFI stub, to
  avoid booting into the kernel proper with IOMMUs in pass through and DMA
  enabled (suggested by Matthew)
- Get rid of RWX mappings in the EFI memory map, where possible.

----------------------------------------------------------------
Ard Biesheuvel (17):
      efi/libstub: fix boot argument handling in mixed mode entry code
      efi/libstub/x86: force 'hidden' visibility for extern declarations
      efi/x86: re-disable RT services for 32-bit kernels running on 64-bit EFI
      efi/x86: map the entire EFI vendor string before copying it
      efi/x86: avoid redundant cast of EFI firmware service pointer
      efi/x86: split off some old memmap handling into separate routines
      efi/x86: split SetVirtualAddresMap() wrappers into 32 and 64 bit versions
      efi/x86: simplify i386 efi_call_phys() firmware call wrapper
      efi/x86: simplify 64-bit EFI firmware call wrapper
      efi/x86: simplify mixed mode call wrapper
      efi/x86: drop two near identical versions of efi_runtime_init()
      efi/x86: clean up efi_systab_init() routine for legibility
      efi/x86: don't panic or BUG() on non-critical error conditions
      efi/x86: remove unreachable code in kexec_enter_virtual_mode()
      x86/mm: fix NX bit clearing issue in kernel_map_pages_in_pgd
      efi/x86: don't map the entire kernel text RW for mixed mode
      efi/x86: avoid RWX mappings for all of DRAM

Arvind Sankar (2):
      efi/x86: Check number of arguments to variadic functions
      efi/x86: Allow translating 64-bit arguments for mixed mode calls

Matthew Garrett (1):
      efi: Allow disabling PCI busmastering on bridges during boot

 Documentation/admin-guide/kernel-parameters.txt |   7 +-
 arch/x86/boot/compressed/eboot.c                |  18 +-
 arch/x86/boot/compressed/efi_thunk_64.S         |   4 +-
 arch/x86/boot/compressed/head_64.S              |  17 +-
 arch/x86/include/asm/efi.h                      | 169 ++++++++---
 arch/x86/mm/pageattr.c                          |   8 +-
 arch/x86/platform/efi/Makefile                  |   1 -
 arch/x86/platform/efi/efi.c                     | 354 ++++++++----------------
 arch/x86/platform/efi/efi_32.c                  |  22 +-
 arch/x86/platform/efi/efi_64.c                  | 157 +++++++----
 arch/x86/platform/efi/efi_stub_32.S             | 109 ++------
 arch/x86/platform/efi/efi_stub_64.S             |  43 +--
 arch/x86/platform/efi/efi_thunk_64.S            | 121 ++------
 arch/x86/platform/uv/bios_uv.c                  |   7 +-
 drivers/firmware/efi/Kconfig                    |  22 ++
 drivers/firmware/efi/libstub/Makefile           |   2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c  |  20 +-
 drivers/firmware/efi/libstub/pci.c              | 114 ++++++++
 include/linux/efi.h                             |  29 +-
 19 files changed, 597 insertions(+), 627 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/pci.c
