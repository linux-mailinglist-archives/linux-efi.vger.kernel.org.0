Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1E61E0872
	for <lists+linux-efi@lfdr.de>; Mon, 25 May 2020 10:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgEYIH0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 May 2020 04:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgEYIH0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 25 May 2020 04:07:26 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9B34206B6;
        Mon, 25 May 2020 08:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590394045;
        bh=yEczq1eG0TAuLxffm05GiJiXcK0sP7HpAZsmTv2shSY=;
        h=From:To:Cc:Subject:Date:From;
        b=wuCP9lTQKFI/hDYSUTNv2zClhLFPdw8x5S6uNhmIFsvMPkvlqO5/VpwVhSBNXY+iT
         hdO8ukcl+M2JFEVkoy5oFz2DBMl6yto50yQEXKcOTYwGLVGnU7LCRs1ofbaM29+EhU
         WaUflpmVhCd4a5CLw0f2eXL2I+NI+5c2N/qlKvLg=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [GIT PULL] EFI changes for v5.8
Date:   Mon, 25 May 2020 10:07:14 +0200
Message-Id: <20200525080714.23228-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ingo, Thomsd, Boris,

Please pull the changes below. Note that I did not incorporate the GOT
handling changes for the x86 decompressor - Arvind has some changes on
top that might just as well go in at the same time, and they are not
really EFI changes anyway.

The following changes since commit 4da0b2b7e67524cc206067865666899bc02e1cb0:

  efi/libstub: Re-enable command line initrd loading for x86 (2020-04-25 12:26:32 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-changes-for-v5.8

for you to fetch changes up to 9241dfe7f2772fc73c82eb950afb1c795d2c012c:

  efi/x86: Drop the special GDT for the EFI thunk (2020-05-24 00:25:15 +0200)

Cc: Ingo Molnar <mingo@redhat.com>,
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arvind Sankar <nivedita@alum.mit.edu>

----------------------------------------------------------------
More EFI changes for v5.8:
- Rename pr_efi/pr_efi_err to efi_info/efi_err, and use them consistently
- Simplify and unify initrd loading
- Parse the builtin command line on x86 (if provided)
- Implement printk() support, including support for wide character strings
- Some fixes for issues introduced by the first batch of v5.8 changes
- Fix a missing prototypes warning
- Simplify GDT handling in early mixed mode thunking code
- Some other minor fixes and cleanups

----------------------------------------------------------------
Ard Biesheuvel (5):
      efi/libstub/x86: Work around LLVM ELF quirk build regression
      efi/libstub: Make efi_printk() input argument const char*
      efi/libstub: Use pool allocation for the command line
      efi/efivars: Add missing kobject_put() in sysfs entry creation error path
      efi/libstub: Add missing prototype for PE/COFF entry point

Arvind Sankar (38):
      efi/x86: Use correct size for boot_params
      efi/libstub: Add a helper function to split 64-bit values
      efi/libstub: Move pr_efi/pr_efi_err into efi namespace
      efi/x86: Use efi_err for error messages
      efi/gop: Use efi_err for error messages
      efi/tpm: Use efi_err for error messages
      efi/libstub: Upgrade ignored dtb= argument message to error
      efi/x86: Move command-line initrd loading to efi_main
      efi/libstub: Unify initrd loading across architectures
      efi/x86: Support builtin command line
      efi/libstub: Check return value of efi_parse_options
      efi/libstub: Fix mixed mode boot issue after macro refactor
      efi/libstub: Include dependencies of efistub.h
      efi/libstub: Rename efi_[char16_]printk to efi_[char16_]puts
      efi/libstub: Buffer output of efi_puts
      efi/libstub: Add a basic printf implementation
      efi/libstub: Optimize for size instead of speed
      efi/printf: Drop %n format and L qualifier
      efi/printf: Add 64-bit and 8-bit integer support
      efi/printf: Factor out flags parsing and handle '%' earlier
      efi/printf: Fix minor bug in precision handling
      efi/printf: Merge 'p' with the integer formats
      efi/printf: Factor out width/precision parsing
      efi/printf: Factor out integer argument retrieval
      efi/printf: Handle null string input
      efi/printf: Refactor code to consolidate padding and output
      efi/printf: Abort on invalid format
      efi/printf: Turn vsprintf into vsnprintf
      efi/libstub: Implement printk-style logging
      efi/libstub: Add definitions for console input and events
      efi/gop: Add an option to list out the available GOP modes
      efi/printf: Add support for wchar_t (UTF-16)
      efi/libstub: Add UTF-8 decoding to efi_puts
      efi/libstub: Use %ls for filename
      efi/libstub: Get the exact UTF-8 length
      efi/libstub: Use snprintf with %ls to convert the command line
      efi/libstub: Don't parse overlong command lines
      efi/x86: Drop the special GDT for the EFI thunk

Joe Perches (1):
      efi/libstub: Correct comment typos

 Documentation/fb/efifb.rst                     |   5 +
 arch/arm/boot/compressed/efi-header.S          |   2 +-
 arch/arm64/kernel/efi-entry.S                  |   2 +-
 arch/arm64/kernel/efi-header.S                 |   2 +-
 arch/x86/boot/compressed/efi_thunk_64.S        |  19 +-
 arch/x86/include/asm/efi.h                     |  29 +-
 arch/x86/xen/efi.c                             |   2 +-
 drivers/firmware/efi/efivars.c                 |   4 +-
 drivers/firmware/efi/libstub/Makefile          |   7 +-
 drivers/firmware/efi/libstub/arm32-stub.c      |  12 +-
 drivers/firmware/efi/libstub/arm64-stub.c      |  14 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 346 +++++++++++----
 drivers/firmware/efi/libstub/efi-stub.c        |  70 +--
 drivers/firmware/efi/libstub/efistub.h         | 155 +++++--
 drivers/firmware/efi/libstub/fdt.c             |  16 +-
 drivers/firmware/efi/libstub/file.c            |  14 +-
 drivers/firmware/efi/libstub/gop.c             | 113 ++++-
 drivers/firmware/efi/libstub/pci.c             |  10 +-
 drivers/firmware/efi/libstub/relocate.c        |   4 +-
 drivers/firmware/efi/libstub/secureboot.c      |   4 +-
 drivers/firmware/efi/libstub/tpm.c             |   2 +-
 drivers/firmware/efi/libstub/vsprintf.c        | 564 +++++++++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c        | 124 +++---
 include/linux/efi.h                            |   4 +-
 24 files changed, 1211 insertions(+), 313 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/vsprintf.c
