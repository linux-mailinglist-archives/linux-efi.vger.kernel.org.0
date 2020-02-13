Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A4A15C0D3
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 15:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgBMO7s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 09:59:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbgBMO7r (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Feb 2020 09:59:47 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABDEC2073C;
        Thu, 13 Feb 2020 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581605987;
        bh=IcRJ/Me61ijvLgGOJorb0nKbfCHKp/zbCYR37MOjuqU=;
        h=From:To:Cc:Subject:Date:From;
        b=cwyKTe5ElfhRicIxsWWdd3rJIwNxT5Q2BQKGNP/kEAiN9Q0g4YVxLgET7ASqQlHZW
         HWxUYhEkajGnkyBTrNI+2dW4ArD3clinB/6oFDigb16OTOkyMKZfjAo27eVqnTJoGN
         BSVB0NprK70wIW1epV89Pq5jz1WG2/5pkoMAIo6M=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, daniel.kiper@oracle.com, hdegoede@redhat.com,
        nivedita@alum.mit.edu, mbrown@fensystems.co.uk, mingo@kernel.org
Subject: [RFC PATCH 0/3] efi/x86: add support for generic EFI mixed mode boot
Date:   Thu, 13 Feb 2020 15:59:25 +0100
Message-Id: <20200213145928.7047-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series is another part of my effort to reduce the level of knowledge
on the part of the bootloader or firmware of internal per-architecture
details regarding where/how the kernel is loaded and where its initrd and
other context data are passed.

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

My previous series on this topic [0] implements a generic way to load the
initrd from any source supported by the loader without relying on something
like device trees or bootparams structures, and so native boot should not
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

A loader implementation for OVMF can be found at [1]. Note that this loader
code is fully generic, and could be used without modifications if other
architectures ever emerge that support kernels that can be invoked from a
non-native (but cross-type supported) loader.

[0] https://lore.kernel.org/linux-arm-kernel/20200206140352.6300-1-ardb@kernel.org/
[1] https://github.com/ardbiesheuvel/edk2/commits/linux-efi-generic

Cc: lersek@redhat.com
Cc: leif@nuviainc.com
Cc: pjones@redhat.com
Cc: mjg59@google.com
Cc: agraf@csgraf.de
Cc: daniel.kiper@oracle.com
Cc: hdegoede@redhat.com
Cc: nivedita@alum.mit.edu
Cc: mbrown@fensystems.co.uk
Cc: mingo@kernel.org

Ard Biesheuvel (3):
  efi/x86: drop redundant .bss section
  efi/x86: add true mixed mode entry point into .compat section
  efi/x86: implement mixed mode boot without the handover protocol

 arch/x86/boot/Makefile             |  2 +-
 arch/x86/boot/compressed/head_64.S | 61 +++++++++++++++++-
 arch/x86/boot/header.S             | 23 ++++---
 arch/x86/boot/tools/build.c        | 67 +++++++++++++-------
 4 files changed, 115 insertions(+), 38 deletions(-)

-- 
2.17.1

