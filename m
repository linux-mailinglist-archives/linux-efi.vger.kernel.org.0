Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7C92981F0
	for <lists+linux-efi@lfdr.de>; Sun, 25 Oct 2020 14:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416427AbgJYNty (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Oct 2020 09:49:54 -0400
Received: from foss.arm.com ([217.140.110.172]:46280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416426AbgJYNtx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 25 Oct 2020 09:49:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BECC30E;
        Sun, 25 Oct 2020 06:49:53 -0700 (PDT)
Received: from e123331-lin.nice.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 923673F68F;
        Sun, 25 Oct 2020 06:49:51 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>, grub-devel@gnu.org,
        daniel.kiper@oracle.com, leif@nuviainc.com
Subject: [PATCH v2 0/8] linux: implement LoadFile2 initrd loading
Date:   Sun, 25 Oct 2020 14:49:33 +0100
Message-Id: <20201025134941.4805-1-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This implements the LoadFile2 initrd loading protocol, which is
essentially a callback face into the bootloader to load the initrd
data into a caller provided buffer. This means the bootloader no
longer has to contain any policy regarding where to load the initrd
(which differs between architectures and kernel versions) and no
longer has to manipulate arch specific data structures such as DT
or struct bootparams to inform the OS where the initrd resides in
memory.

Sample output from booting a recent Linux/arm64 kernel:

  grub> insmod part_msdos
  grub> linux (hd0,msdos1)/Image
  grub> initrd (hd0,msdos1)/initrd.img
  grub> boot
  EFI stub: Booting Linux Kernel...
  EFI stub: EFI_RNG_PROTOCOL unavailable, KASLR will be disabled
  EFI stub: Generating empty DTB
  EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
  EFI stub: Exiting boot services and installing virtual address map...
  [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd070]

Cc: grub-devel@gnu.org
Cc: daniel.kiper@oracle.com
Cc: leif@nuviainc.com

Changes since v1:
- add Leif's ack to #2, #6 and #8
- add patch #1 to fix the ARM Linux image header definition
- add patches #3, #4 and #5 to unify and reuse the COFF header loading routines
  from Xen (and the absence of which from v1 was causing garbage to be read and
  interpreted as the image major version)

Ard Biesheuvel (8):
  linux/arm: fix ARM Linux header layout
  loader/linux: permit NULL argument for argv[] in grub_initrd_load()
  efi: move MS-DOS stub out of generic PE header definition
  linux/arm: unify ARM/arm64 vs Xen PE/COFF header handling
  linux/arm: account for COFF headers appearing at unexpected offsets
  efi: add definition of LoadFile2 protocol
  efi: implement LoadFile2 initrd loading protocol for Linux
  linux: ignore FDT unless we need to modify it

 grub-core/commands/efi/lsefi.c    |   1 +
 grub-core/kern/efi/efi.c          |   5 +-
 grub-core/loader/arm64/linux.c    | 158 +++++++++++++++++---
 grub-core/loader/arm64/xen_boot.c |  23 +--
 grub-core/loader/efi/fdt.c        |   7 +-
 grub-core/loader/linux.c          |   2 +-
 include/grub/arm/linux.h          |   8 +-
 include/grub/arm64/linux.h        |   4 +
 include/grub/efi/api.h            |  15 ++
 include/grub/efi/efi.h            |   4 +-
 include/grub/efi/pe32.h           |   5 +-
 11 files changed, 185 insertions(+), 47 deletions(-)

-- 
2.17.1

