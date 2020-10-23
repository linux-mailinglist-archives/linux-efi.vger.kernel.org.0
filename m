Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD54296E30
	for <lists+linux-efi@lfdr.de>; Fri, 23 Oct 2020 14:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463440AbgJWMIc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Oct 2020 08:08:32 -0400
Received: from foss.arm.com ([217.140.110.172]:50716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463439AbgJWMIc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 23 Oct 2020 08:08:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4555101E;
        Fri, 23 Oct 2020 05:08:31 -0700 (PDT)
Received: from e123331-lin.nice.arm.com (unknown [10.37.8.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FD373F66B;
        Fri, 23 Oct 2020 05:08:30 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>, grub-devel@gnu.org,
        daniel.kiper@oracle.com, leif@nuviainc.com
Subject: [PATCH 0/4] linux: implement LoadFile2 initrd loading
Date:   Fri, 23 Oct 2020 14:08:21 +0200
Message-Id: <20201023120825.30466-1-ard.biesheuvel@arm.com>
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

Ard Biesheuvel (4):
  loader/linux: permit NULL argument for argv[] in grub_initrd_load()
  efi: add definition of LoadFile2 protocol
  efi: implemented LoadFile2 initr loading protocol for Linux
  linux: ignore FDT unless we need to modify it

 grub-core/commands/efi/lsefi.c |   1 +
 grub-core/loader/arm64/linux.c | 139 ++++++++++++++++++--
 grub-core/loader/efi/fdt.c     |   7 +-
 grub-core/loader/linux.c       |   2 +-
 include/grub/efi/api.h         |  15 +++
 5 files changed, 149 insertions(+), 15 deletions(-)

-- 
2.17.1

