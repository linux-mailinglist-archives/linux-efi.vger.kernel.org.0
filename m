Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB24C1545B5
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2020 15:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgBFOE4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Feb 2020 09:04:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBFOE4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 6 Feb 2020 09:04:56 -0500
Received: from e123331-lin.cambridge.arm.com (fw-tnat-cam2.arm.com [217.140.106.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F124621775;
        Thu,  6 Feb 2020 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580997895;
        bh=1k9zgUyZTU16+bXR7Utty5v5GrnUMG0hLZQ+X8uSY8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=pbb1jolDpUgcKiuohwjrcr6bfOirRy3U7Y7AzZ6aCdIJiT1GjWUM23U9/cv7JW+9G
         4DsC9LYFOlBktgCYUcC28rgFYIeCnjM+JZWEiXH/a8wT0ru+TPHeE715LkQ8ZOqt3x
         teYp+ATKE8cwsO6H+UWr0lWK9YSj6AQv5lIH62Q0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
        daniel.kiper@oracle.com
Subject: [PATCH 0/2] arch-agnostic initrd loading method for EFI systems
Date:   Thu,  6 Feb 2020 14:03:50 +0000
Message-Id: <20200206140352.6300-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series introduces an arch agnostic way of loading the initrd into
memory from the EFI stub. This addresses a number of shortcomings that
affect the current implementations that exist across architectures:

- The initrd=<file> command line option can only load files that reside
  on the same file system that the kernel itself was loaded from, which
  requires the bootloader or firmware to expose that file system via the
  appropriate EFI protocol, which is not always feasible. From the kernel
  side, this protocol is problematic since it is incompatible with mixed
  mode on x86 (this is due to the fact that some of its methods have
  prototypes that are difficult to marshall)

- The approach that is ordinarily taken by GRUB is to load the initrd into
  memory, and pass it to the kernel proper via the bootparams structure or
  via the device tree. This requires the boot loader to have an understanding
  of those structures, which are not always set in stone, and of the policies
  around where the initrd may be loaded into memory. In the ARM case, it
  requires GRUB to modify the hardware description provided by the firmware,
  given that the initrd base and offset in memory are passed via the same
  data structure. It also creates a time window where the initrd data sits
  in memory, and can potentially be corrupted before the kernel is booted.

Considering that we will soon have new users of these interfaces (EFI for
kvmtool on ARM, RISC-V in u-boot, etc), it makes sense to add a generic
interface now, before having another wave of bespoke arch specific code
coming in.

Another aspect to take into account is that support for UEFI secure boot
and measured boot is being taken into the upstream, and being able to
rely on the PE entry point for booting any architecture makes the GRUB
vs shim story much cleaner, as we should be able to rely on LoadImage
and StartImage on all architectures, while retaining the ability to
load initrds from anywhere.

Note that these patches depend on a fair amount of cleanup work that I
am targetting for v5.7. Branch can be found at:
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efistub-unification2

An implementation for ArmVirtQemu (OVMF for ARM aka AAVMF) can be found
at https://github.com/ardbiesheuvel/edk2/commits/linux-efi-generic.
The change is for ARM only, but the exact same code could be used on x86.

Cc: lersek@redhat.com
Cc: leif@nuviainc.com
Cc: pjones@redhat.com
Cc: mjg59@google.com
Cc: agraf@csgraf.de
Cc: ilias.apalodimas@linaro.org
Cc: xypron.glpk@gmx.de 
Cc: daniel.kiper@oracle.com

Ard Biesheuvel (2):
  efi/libstub: add support for loading the initrd from a device path
  efi/libstub: take noinitrd cmdline argument into account for devpath
    initrd

 drivers/firmware/efi/libstub/arm-stub.c       | 21 ++++--
 .../firmware/efi/libstub/efi-stub-helper.c    | 74 +++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h        | 13 ++++
 drivers/firmware/efi/libstub/x86-stub.c       | 51 ++++++++++---
 include/linux/efi.h                           |  1 +
 5 files changed, 146 insertions(+), 14 deletions(-)

-- 
2.17.1

