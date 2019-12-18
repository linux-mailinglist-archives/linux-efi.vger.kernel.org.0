Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88A124E9C
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2019 18:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLRRCK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Dec 2019 12:02:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfLRRCK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Dec 2019 12:02:10 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58DE82176D;
        Wed, 18 Dec 2019 17:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576688529;
        bh=oh8ljtWNbV991SHuP9aRXiwPJLuBX5D4nflfaOj7CrA=;
        h=From:To:Cc:Subject:Date:From;
        b=I/oJwmHihrlxH3KJeTSTldI6VwwQYQCaxMGW7a3jNkejAVOCqmZF/v5mfD+j9161f
         VEb2yj6m4zl3WN9EGVWiZV34ICJJg+ScikXD34i2/AjdQkLwPCID5O7FeSrIUAANm0
         QAmu6UnNOKrubfppf6vpbwPGNB8iiUV9cMcCod9Y=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH v2 00/21] efi/x86: confine type unsafe casting to mixed mode
Date:   Wed, 18 Dec 2019 19:01:18 +0200
Message-Id: <20191218170139.9468-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, we support mixed mode (64-bit Linux running on 32-bit firmware)
by explicitly reasoning about pointer sizes for every call into the
firmware: on x86, there are 32-bit and 64-bit versions of each protocol
interface, and each call gets routed via one of the two, depending on the
native size of the firmware.

There is a lot of casting and pointer mangling involved in this, and as
a result, we end up with much less coverage in terms of type checking by
the compiler, due to the indirection via an anonymous, variadic thunking
routine.

This peculiarity of x86 is also leaking into generic EFI code, which is
shared with ia64, arm64, ARM and likely RiscV in the future. So let's
try to clean this up a bit.

The approach taken by this series is to replace the 32/64 bit distinction
with a distinction between native calls and mixed mode calls, where the
former can be either 32 or 64 bit [depending on the platform] and use
the ordinary native protocol definitions, while mixed mode calls retain
the existing casting/thunking approach based on the 32-bit protocol
definitions.

Given that GCC now supports emitting function calls using the MS calling
convention, we can get rid of all the wrapping and casting, and emit the
indirect calls directly.

Changes since v1:
- Substantially more cleanup work to simplify and hide the mixed mode handling
  in generic EFI code.
- Get rid of all the pointless passing around of sys_table_arg
- Incorporate an updated version of Matthew's PCI DMA disable patch using EFI
  events to defer poking the busmaster bits until after all the ordinary
  ExitBootServices() callbacks have executed.

Code can be found here
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efistub-x86-cleanup-v2

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Matthew Garrett <matthewgarrett@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arvind Sankar <nivedita@alum.mit.edu>

Ard Biesheuvel (20):
  efi/libstub: remove unused __efi_call_early() macro
  efi/x86: rename efi_is_native() to efi_is_mixed()
  efi/libstub: use a helper to iterate over a EFI handle array
  efi/libstub: extend native protocol definitions with mixed_mode
    aliases
  efi/libstub: distinguish between native/mixed not 32/64 bit
  efi/libstub/x86: use mixed mode helpers to populate efi_config
  efi/libstub: drop explicit 32/64-bit protocol definitions
  efi/libstub: use stricter typing for firmware function pointers
  efi/libstub: annotate firmware routines as __efiapi
  efi/libstub/x86: avoid thunking for native firmware calls
  efi/libstub: get rid of 'sys_table_arg' macro parameter
  efi/libstub: unify the efi_char16_printk implementations
  efi/libstub/x86: drop __efi_early() export of efi_config struct
  efi/libstub: drop sys_table_arg from printk routines
  efi/libstub: remove 'sys_table_arg' from all function prototypes
  efi/libstub: drop protocol argument from efi_call_proto() macro
  efi/libstub: drop 'table' argument from efi_table_attr() macro
  efi/libstub: use 'func' not 'f' as macro parameter
  efi/libstub: tidy up types and names of global cmdline variables
  efi/libstub: import type definitions for creating and signalling
    events

Matthew Garrett (1):
  efi: Allow disabling PCI busmastering on bridges during boot

 .../admin-guide/kernel-parameters.txt         |   4 +
 arch/arm/include/asm/efi.h                    |  17 +-
 arch/arm64/include/asm/efi.h                  |  16 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/boot/compressed/Makefile             |   2 +-
 arch/x86/boot/compressed/eboot.c              | 180 ++--
 arch/x86/boot/compressed/eboot.h              |  30 +-
 arch/x86/boot/compressed/efi_stub_32.S        |  87 --
 arch/x86/boot/compressed/efi_stub_64.S        |   5 -
 arch/x86/boot/compressed/head_32.S            |   8 +-
 arch/x86/boot/compressed/head_64.S            |  16 +-
 arch/x86/include/asm/efi.h                    |  76 +-
 arch/x86/platform/efi/efi.c                   |  12 +-
 arch/x86/platform/efi/efi_64.c                |   6 +-
 arch/x86/platform/efi/quirks.c                |   2 +-
 drivers/firmware/efi/Kconfig                  |  22 +
 drivers/firmware/efi/libstub/Makefile         |   2 +-
 drivers/firmware/efi/libstub/arm-stub.c       |  98 ++-
 drivers/firmware/efi/libstub/arm32-stub.c     |  40 +-
 drivers/firmware/efi/libstub/arm64-stub.c     |  24 +-
 .../firmware/efi/libstub/efi-stub-helper.c    | 226 +++--
 drivers/firmware/efi/libstub/efistub.h        |  35 +-
 drivers/firmware/efi/libstub/fdt.c            |  53 +-
 drivers/firmware/efi/libstub/gop.c            |  30 +-
 drivers/firmware/efi/libstub/pci.c            | 116 +++
 drivers/firmware/efi/libstub/random.c         |  54 +-
 drivers/firmware/efi/libstub/secureboot.c     |   6 +-
 drivers/firmware/efi/libstub/tpm.c            |  23 +-
 include/linux/efi.h                           | 816 +++++++++---------
 29 files changed, 980 insertions(+), 1027 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/efi_stub_32.S
 delete mode 100644 arch/x86/boot/compressed/efi_stub_64.S
 create mode 100644 drivers/firmware/efi/libstub/pci.c

-- 
2.17.1

