Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE3E139773
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2020 18:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAMRXH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jan 2020 12:23:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgAMRXH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Jan 2020 12:23:07 -0500
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 720DF206DA;
        Mon, 13 Jan 2020 17:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578936186;
        bh=Mc+JBGwCS17q1ERYia2qc0tuxix0IR/XU/AuycW3Tak=;
        h=From:To:Cc:Subject:Date:From;
        b=YiulQq2q+pCvuCIE7mZCgZhC+xq2YI2nRT+26mWV01zvZ9nKQPV6tlg1R8I1BxxUo
         ocluvZmD/lYvCX+QAwp5T56O5Mr3Mm7cgOXmiugSrInz8mNwzjWZJbILANJLX+JRpR
         h3XacNENLDSi/oAFeNw4QyKu7GYRG6MBv5vVabUs=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL 00/13] More EFI updates for v5.6
Date:   Mon, 13 Jan 2020 18:22:32 +0100
Message-Id: <20200113172245.27925-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 4444f8541dad16fefd9b8807ad1451e806ef1d94:

  efi: Allow disabling PCI busmastering on bridges during boot (2020-01-10 18:55:04 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to 743c5dd59f7e4b9e7a28be6a8f0e8d03271a98ab:

  efi: Fix handling of multiple efi_fake_mem= entries (2020-01-13 10:41:53 +0100)

----------------------------------------------------------------
Third and final batch of EFI updates for v5.6:
- A few touchups for the x86 libstub changes that have already been queued
  up.
- Fix memory leaks and crash bugs in the EFI fake_mem driver, which may be
  used more heavily in the future for device-dax soft reservation (Dan)
- Avoid RWX mappings in the EFI page tables when possible.
- Avoid PCIe probing failures if the EFI framebuffer is probed first when
  the new of_devlink feature is active.
- Move the support code for the old EFI memory mapping style into its only
  user, the SGI UV1+ support code.

----------------------------------------------------------------
Anshuman Khandual (1):
      efi: Fix comment for efi_mem_type() wrt absent physical addresses

Ard Biesheuvel (7):
      efi/libstub/x86: use const attribute for efi_is_64bit()
      efi/libstub/x86: use mandatory 16-byte stack alignment in mixed mode
      x86/mm: fix NX bit clearing issue in kernel_map_pages_in_pgd
      efi/x86: don't map the entire kernel text RW for mixed mode
      efi/x86: avoid RWX mappings for all of DRAM
      efi/x86: limit EFI old memory map to SGI UV machines
      efi/arm: defer probe of PCIe backed efifb on DT systems

Arnd Bergmann (1):
      efi/libstub/x86: fix unused-variable warning

Dan Williams (4):
      efi: Add a flags parameter to efi_memory_map
      efi: Add tracking for dynamically allocated memmaps
      efi: Fix efi_memmap_alloc() leaks
      efi: Fix handling of multiple efi_fake_mem= entries

 Documentation/admin-guide/kernel-parameters.txt |   3 +-
 arch/x86/boot/compressed/eboot.c                |  16 +-
 arch/x86/boot/compressed/efi_thunk_64.S         |  46 ++----
 arch/x86/boot/compressed/head_64.S              |   7 +-
 arch/x86/include/asm/efi.h                      |  28 ++--
 arch/x86/kernel/kexec-bzimage64.c               |   2 +-
 arch/x86/mm/pat/set_memory.c                    |   8 +-
 arch/x86/platform/efi/efi.c                     |  40 +++--
 arch/x86/platform/efi/efi_64.c                  | 190 ++++--------------------
 arch/x86/platform/efi/quirks.c                  |  44 +++---
 arch/x86/platform/uv/bios_uv.c                  | 164 +++++++++++++++++++-
 drivers/firmware/efi/arm-init.c                 | 107 ++++++++++++-
 drivers/firmware/efi/efi.c                      |   2 +-
 drivers/firmware/efi/fake_mem.c                 |  43 +++---
 drivers/firmware/efi/memmap.c                   |  95 ++++++++----
 include/linux/efi.h                             |  17 ++-
 16 files changed, 471 insertions(+), 341 deletions(-)
