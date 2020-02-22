Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E25168FEE
	for <lists+linux-efi@lfdr.de>; Sat, 22 Feb 2020 16:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgBVP4h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Feb 2020 10:56:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbgBVP4h (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 22 Feb 2020 10:56:37 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02C6120702;
        Sat, 22 Feb 2020 15:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582386996;
        bh=NPfvKv08/4h8bw7ni853NBxcNjIzcs74IGF51WL5G08=;
        h=From:To:Cc:Subject:Date:From;
        b=hUBJCb19PJBjfvKZ31phNYEXsRfqJfR6AE28QDrX1zozWZIAEEjB3NMMs2A/elX8i
         pVMqq3TatPrfcamUogpyRBojqxYCdxXdBZHPzpsbSQDkUO/vbYstE9ZSQuqjxjcEqb
         4qTUq8cGbNMRt8UdohpuAM84aL6xyrTSVdF6IPJA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, hdegoede@redhat.com,
        nivedita@alum.mit.edu, x86@kernel.org
Subject: [PATCH v3 0/6] efi/x86: add support for generic EFI mixed mode boot
Date:   Sat, 22 Feb 2020 16:55:13 +0100
Message-Id: <20200222155519.23550-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series is another part of my effort to reduce the level of knowledge
on the part of the bootloader or firmware of internal per-architecture
details regarding where/how the kernel is loaded and where its initrd and
other context data are passed.

Changes since v2:
- add patch to correct the image size as reported in the PE/COFF header, which
  is slightly too small at the moment for images that happen to execute from
  the offset they were loaded at by UEFI,
- add even more slack to the image size for mixed mode, which may now run
  startup_32() misaligned with respect to the minimum alignment as reported
  in the bootparams struct
- check for long mode support in the 32-bit PE/COFF entrypoint, so we can
  fail gracefully instead of hang later on,
- simplify handover to efi_pe_entry() from startup_32()

Changes since v1:
- add mixed mode wrappers for the EFI loaded_image protocol (#2)
- expose Exit() boot service and invoke it on errors rather than doing and
  ordinary function return or entering a deadloop (#3)
- move code into .text and r/o data into .rodata where appropriate, and
  disentangle the mixed mode boot path and the ordinary one (#4)
- disable initrd load from file in mixed mode
- reorder patches #4 and #5

---- v1 blurb (cont'd) ---

The x86 architecture has a so-called 'EFI handover protocol', which defines
how the bootparams struct should be populated, and how it should be
interpreted to figure out where to load the kernel, and at which offset in
the binary the entrypoint is located. This scheme allows the initrd to be
loaded beforehand, and allows 32-bit firmware to invoke a 64-bit kernel
via a special entrypoint that manages the state transitions between the
two execution modes.

Due to this, x86 loaders currently do not rely on LoadImage and StartImage,
and therefore, are forced to re-implement things like image authentication
for secure boot and taking the measurements for measured boot in their open
coded clones of these routines.

My previous series on this topic [0][1] implements a generic way to load the
initrd from any source supported by the loader without relying on something
like a device tree or bootparams structure, and so native boot should not
need the EFI handover protocol anymore after those change are merged.

What remains is mixed mode boot, which also needs the EFI handover protocol
regardless of whether an initrd is loaded or not. So let's get rid of that
requirement, and take advantage of the fact that EDK2 based firmware does
support LoadImage() for X64 binaries on IA32 firmware, which means we can
rely on the secure boot and measured boot checks being performed by the
firmware. The only thing we need to put on top is a way to discover the
non-native entrypoint into the binary in a way that does not rely on x86
specific headers and data structures.

So let's introduce a new .compat header in the PE/COFF metadata of the
bzImage, and populate it with a <machine type, entrypoint> tuple, allowing
a generic EFI loader to decide whether the entrypoint supports its native
machine type, and invoke it as an ordinary EFI application entrypoint.
Since we will not be passing a bootparams structure, we need to discover
the base of the image (which contains the setup header) via the loaded
image protocol before we can enter the kernel in 32-bit mode at startup_32()

A loader implementation for OVMF can be found at [2]. Note that this loader
code is fully generic, and permits mixed mode images to be launched from
the UEFI shell or other generic components based on LoadImage/Startimage.
It could be used without modifications if other architectures ever emerge
that support kernels that can be invoked from a non-native (but cross-type
supported) loader.

[0] https://lore.kernel.org/linux-arm-kernel/20200206140352.6300-1-ardb@kernel.org/
[1] https://lore.kernel.org/linux-efi/20200216141104.21477-1-ardb@kernel.org/
[2] https://github.com/ardbiesheuvel/edk2/commits/linux-efi-generic

Cc: hdegoede@redhat.com
Cc: nivedita@alum.mit.edu
Cc: x86@kernel.org

Ard Biesheuvel (6):
  efi/x86: add headroom to decompressor BSS to account for setup block
  efi/x86: Drop redundant .bss section
  efi/libstub/x86: Make loaded_image protocol handling mixed mode safe
  efi/libstub/x86: Use Exit() boot service to exit the stub on errors
  efi/x86: Implement mixed mode boot without the handover protocol
  efi/x86: Add true mixed mode entry point into .compat section

 arch/x86/boot/Makefile                        |  2 +-
 arch/x86/boot/compressed/head_64.S            | 59 ++++++++++++-
 arch/x86/boot/header.S                        | 25 +++---
 arch/x86/boot/tools/build.c                   | 86 +++++++++++++------
 arch/x86/include/asm/efi.h                    |  8 ++
 .../firmware/efi/libstub/efi-stub-helper.c    |  4 +-
 drivers/firmware/efi/libstub/efistub.h        | 50 +++++++----
 drivers/firmware/efi/libstub/x86-stub.c       | 53 +++++++-----
 8 files changed, 207 insertions(+), 80 deletions(-)

-- 
2.17.1

