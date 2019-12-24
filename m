Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E9912A2AE
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfLXPKr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:10:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfLXPKr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:10:47 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0FA206D3;
        Tue, 24 Dec 2019 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200245;
        bh=P1P3d45D4yYj4txibJRGvNfX8LMUJ2HDXlU0mOi5kj8=;
        h=From:To:Cc:Subject:Date:From;
        b=prRvTpKjaLXsmsJXe7ssz7nlP3ws8nPKsnklenEx8KqVnuU0wz3jEv/nscUXsfLjK
         LGHcOVL7+abLiYQL0QJWlG2pDa+/lFdq9Ju5hzEg+pCrvRUgN+6tZcUU/F6+MHm4WP
         GVDtnqWjSNmgiFx76pMBIHHYW8nD3muOoX1aoQxM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [GIT PULL 00/25] EFI updates for v5.6
Date:   Tue, 24 Dec 2019 16:10:00 +0100
Message-Id: <20191224151025.32482-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ingo, Thomas,

Please consider the pull request below. I am anticipating some more
changes for this cycle, but it would be good to get these queued up and
into -next sooner rather than later, since there is some risk of
breakage even though the changes have been tested on a variety of
hardware.

If you have the stomach to go over them in detail: please take into
account that these patches modify the same efi_call_xxx() macro
definitions multiple times, in order to be bisectable, so please
consider the end result first before commenting on coding style of the
intermediate changes.

NOTE: this series depends on the efi-urgent PR that I just sent out, so
please merge tip/efi/urgent into tip/efi/core before applying the
changes below.

Thanks and happy Christmas,
Ard.



The following changes since commit 77217fcc8e04f27127b32825376ed508705fd946:

  x86/efistub: disable paging at mixed mode entry (2019-12-23 16:25:21 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to c51a0735389b92cb0025137af0034773773ad7da:

  efi/libstub/x86: avoid globals to store context during mixed mode calls (2019-12-24 15:32:22 +0100)

----------------------------------------------------------------
EFI changes for v5.6:
- Cleanup of the GOP [graphics output] handling code in the EFI stub (Arvind)
- Inspired by the above, and with a little bit of Arvind's help, a complete
  refactor of the mixed mode handling in the x86 EFI stub, getting rid of a
  lot of ugly and unnecessary wrapping and typecasting. This is a worthwhile
  cleanup by itself, but it also addresses a recurring issue where stub code
  often fails to compile on non-x86 because all the casting and thunking via
  variadic wrapper routines is masking problems in the code.

----------------------------------------------------------------
Ard Biesheuvel (21):
      efi/libstub: remove unused __efi_call_early() macro
      efi/x86: rename efi_is_native() to efi_is_mixed()
      efi/libstub: use a helper to iterate over a EFI handle array
      efi/libstub: extend native protocol definitions with mixed_mode aliases
      efi/libstub: distinguish between native/mixed not 32/64 bit
      efi/libstub: drop explicit 32/64-bit protocol definitions
      efi/libstub: use stricter typing for firmware function pointers
      efi/libstub: annotate firmware routines as __efiapi
      efi/libstub/x86: avoid thunking for native firmware calls
      efi/libstub: avoid protocol wrapper for file I/O routines
      efi/libstub: get rid of 'sys_table_arg' macro parameter
      efi/libstub: unify the efi_char16_printk implementations
      efi/libstub/x86: drop __efi_early() export and efi_config struct
      efi/libstub: drop sys_table_arg from printk routines
      efi/libstub: remove 'sys_table_arg' from all function prototypes
      efi/libstub/x86: work around page freeing issue in mixed mode
      efi/libstub: drop protocol argument from efi_call_proto() macro
      efi/libstub: drop 'table' argument from efi_table_attr() macro
      efi/libstub: rename efi_call_early/_runtime macros to be more intuitive
      efi/libstub: tidy up types and names of global cmdline variables
      efi/libstub/x86: avoid globals to store context during mixed mode calls

Arvind Sankar (4):
      efi/gop: Remove bogus packed attribute from GOP structures
      efi/gop: Remove unused typedef
      efi/gop: Convert GOP structures to typedef and cleanup some types
      efi/gop: Unify 32/64-bit functions

 arch/arm/include/asm/efi.h                     |  17 +-
 arch/arm64/include/asm/efi.h                   |  16 +-
 arch/x86/Kconfig                               |  11 +-
 arch/x86/boot/compressed/Makefile              |   2 +-
 arch/x86/boot/compressed/eboot.c               | 290 +++++-----
 arch/x86/boot/compressed/eboot.h               |  30 +-
 arch/x86/boot/compressed/efi_stub_32.S         |  87 ---
 arch/x86/boot/compressed/efi_stub_64.S         |   5 -
 arch/x86/boot/compressed/efi_thunk_64.S        |  17 +-
 arch/x86/boot/compressed/head_32.S             |  64 +--
 arch/x86/boot/compressed/head_64.S             |  97 +---
 arch/x86/include/asm/efi.h                     |  77 ++-
 arch/x86/platform/efi/efi.c                    |  12 +-
 arch/x86/platform/efi/efi_64.c                 |   6 +-
 arch/x86/platform/efi/quirks.c                 |   2 +-
 arch/x86/xen/efi.c                             |   2 +-
 drivers/firmware/efi/libstub/arm-stub.c        | 110 ++--
 drivers/firmware/efi/libstub/arm32-stub.c      |  70 ++-
 drivers/firmware/efi/libstub/arm64-stub.c      |  32 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 278 +++++-----
 drivers/firmware/efi/libstub/efistub.h         |  48 +-
 drivers/firmware/efi/libstub/fdt.c             |  53 +-
 drivers/firmware/efi/libstub/gop.c             | 163 +-----
 drivers/firmware/efi/libstub/random.c          |  77 ++-
 drivers/firmware/efi/libstub/secureboot.c      |  11 +-
 drivers/firmware/efi/libstub/tpm.c             |  48 +-
 include/linux/efi.h                            | 730 +++++++++++--------------
 27 files changed, 914 insertions(+), 1441 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/efi_stub_32.S
 delete mode 100644 arch/x86/boot/compressed/efi_stub_64.S
