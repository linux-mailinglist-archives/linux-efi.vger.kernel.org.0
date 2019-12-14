Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2528711F335
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 18:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfLNR5l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 12:57:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfLNR5l (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 14 Dec 2019 12:57:41 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF4E20724;
        Sat, 14 Dec 2019 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576346260;
        bh=jus25Rf83MkRqCWDILe7u65yRwf/8zffQBj/3myz95U=;
        h=From:To:Cc:Subject:Date:From;
        b=ZwGNNAC6xsTjiBfR8qFIEbdr7xISdVWktqPbQ8YST3u/j+ECDuWmbEAcydJoL5y6H
         OYrh27gaarC4FKpX95+6J6qufqT0Qkkfq+aF20YGQ4UF0nmSIld/8FcUq3mesidFTN
         4JxAfA4cm0hXjY93walqagFGf7sQw+zQr9Rl1YDI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 00/10] efi/x86: confine type unsafe casting to mixed mode
Date:   Sat, 14 Dec 2019 18:57:25 +0100
Message-Id: <20191214175735.22518-1-ardb@kernel.org>
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

Code can be found here
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efistub-x86-cleanup

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Matthew Garrett <matthewgarrett@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arvind Sankar <nivedita@alum.mit.edu>

Ard Biesheuvel (10):
  efi/libstub: remove unused __efi_call_early() macro
  efi/x86: rename efi_is_native() to efi_is_mixed()
  efi/libstub: use a helper to iterate over a EFI handle array
  efi/libstub: add missing apple_properties_protocol_t definition
  efi/libstub: distinguish between native/mixed not 32/64 bit
  efi/libstub/x86: use mixed mode helpers to populate efi_config
  efi/libstub: drop explicit 64-bit protocol definitions
  efi/libstub: use stricter typing for firmware function pointers
  efi/libstub: annotate firmware routines as __efiapi
  efi/libstub/x86: avoid thunking for native firmware calls

 arch/arm/include/asm/efi.h                    |   3 +-
 arch/arm64/include/asm/efi.h                  |   3 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/boot/compressed/Makefile             |   2 +-
 arch/x86/boot/compressed/eboot.c              |  51 ++--
 arch/x86/boot/compressed/eboot.h              |  11 +-
 arch/x86/boot/compressed/efi_stub_32.S        |  87 ------
 arch/x86/boot/compressed/efi_stub_64.S        |   5 -
 arch/x86/boot/compressed/head_32.S            |   8 +-
 arch/x86/boot/compressed/head_64.S            |  12 -
 arch/x86/include/asm/efi.h                    |  64 ++--
 arch/x86/platform/efi/efi.c                   |  12 +-
 arch/x86/platform/efi/efi_64.c                |   6 +-
 arch/x86/platform/efi/quirks.c                |   2 +-
 .../firmware/efi/libstub/efi-stub-helper.c    |  46 ++-
 drivers/firmware/efi/libstub/gop.c            |   9 +-
 drivers/firmware/efi/libstub/pci.c            |   9 +-
 drivers/firmware/efi/libstub/random.c         |  13 +-
 drivers/firmware/efi/libstub/tpm.c            |   4 +-
 include/linux/efi.h                           | 278 ++++++------------
 20 files changed, 195 insertions(+), 431 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/efi_stub_32.S
 delete mode 100644 arch/x86/boot/compressed/efi_stub_64.S

-- 
2.17.1

