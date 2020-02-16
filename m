Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E10D716043C
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 15:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBPOLw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 09:11:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:36394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgBPOLv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 09:11:51 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25E9E2086A;
        Sun, 16 Feb 2020 14:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581862310;
        bh=DKirdU0ufWfvPWErLTUkOEyE4AL9d2cSF3zd29hUQRk=;
        h=From:To:Cc:Subject:Date:From;
        b=o4u0xzwJR2Do3USyGEZc8LJsFAfEKOLRrx++LbJ8mP4ZEXJzX51+M1UnPvuSGA1aK
         uYa5jrKWmtACntcNXsdgpGCAeyDzVJwEoyW47K6nZJ2/Vs62A9ER9DxZfVR/6s6Nko
         vP5jXf09H/ah9rN8/KCU6zMiORJOkG0lEx7S+8hs=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        lersek@redhat.com, leif@nuviainc.com, pjones@redhat.com,
        mjg59@google.com, agraf@csgraf.de, ilias.apalodimas@linaro.org,
        xypron.glpk@gmx.de, daniel.kiper@oracle.com, nivedita@alum.mit.edu,
        James.Bottomley@hansenpartnership.com, lukas@wunner.de
Subject: [PATCH v2 0/3] arch-agnostic initrd loading method for EFI systems
Date:   Sun, 16 Feb 2020 15:11:01 +0100
Message-Id: <20200216141104.21477-1-ardb@kernel.org>
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
https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next

A PoC implementation for OVMF and ArmVirtQemu (OVMF for ARM aka AAVMF) can
be found at https://github.com/ardbiesheuvel/edk2/commits/linux-efi-generic.

A U-Boot implementation is under development as well, and can be found at
https://github.com/apalos/u-boot/commits/efi_load_file_8

Changes since v1:
- merge vendor media device path type definition with the existing device path
  definitions we already have, and rework the latter slightly to be more easily
  reusable
- use 'dev_path' not 'devpath' consistently
- pass correct FilePath value to LoadFile2 (i.e., the device path pointer that
  was advanced to point to the 'end' node by locate_device_path())
- add kerneldoc comment to efi_load_initrd_dev_path()
- take care to only return EFI_NOT_FOUND from efi_load_initrd_dev_path() if the
  LoadFile2 protocol does not exist on the LINUX_EFI_INITRD_MEDIA_GUID device
  path - this makes the logic whether to fallback to the command line method
  more robust

Cc: lersek@redhat.com
Cc: leif@nuviainc.com
Cc: pjones@redhat.com
Cc: mjg59@google.com
Cc: agraf@csgraf.de
Cc: ilias.apalodimas@linaro.org
Cc: xypron.glpk@gmx.de
Cc: daniel.kiper@oracle.com
Cc: nivedita@alum.mit.edu
Cc: James.Bottomley@hansenpartnership.com
Cc: lukas@wunner.de

Ard Biesheuvel (3):
  efi/dev-path-parser: Add struct definition for vendor type device path
    nodes
  efi/libstub: Add support for loading the initrd from a device path
  efi/libstub: Take noinitrd cmdline argument into account for devpath
    initrd

 drivers/firmware/efi/apple-properties.c       |  8 +-
 drivers/firmware/efi/dev-path-parser.c        | 38 ++++----
 drivers/firmware/efi/libstub/arm-stub.c       | 20 ++++-
 .../firmware/efi/libstub/efi-stub-helper.c    | 89 +++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h        |  5 ++
 drivers/firmware/efi/libstub/x86-stub.c       | 47 ++++++++--
 include/linux/efi.h                           | 49 ++++++----
 7 files changed, 201 insertions(+), 55 deletions(-)

-- 
2.17.1

