Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7751D1CB67B
	for <lists+linux-efi@lfdr.de>; Fri,  8 May 2020 20:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgEHSCU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 May 2020 14:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgEHSCU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 May 2020 14:02:20 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C054D2184D;
        Fri,  8 May 2020 18:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588960939;
        bh=yLLUpJk0Z9ZGaLhcLvyYZ1XcJddjocCtFyTjuRCXOrg=;
        h=From:To:Cc:Subject:Date:From;
        b=B2UutJ1vKPy8QwuUbmRuzDSjQGb2LrPYMfDoRmxWT57KhFwWx0spsdH6QH0U+yUhd
         akuMRObfbelrINVrZQNqwGPkT0cOGDxPAfLhwmT1JWUviCPGZVTOHSrAIdLqJypNm4
         8lednG3x90cJEfXivEqC8BmnUWCTRhsKLfqOPOvk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: [GIT PULL 00/15] More EFI changes for v5.8
Date:   Fri,  8 May 2020 20:01:42 +0200
Message-Id: <20200508180157.1816-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 4da0b2b7e67524cc206067865666899bc02e1cb0:

  efi/libstub: Re-enable command line initrd loading for x86 (2020-04-25 12:26:32 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-next

for you to fetch changes up to 4026229934f6ca0cb44af7b9df00e647b2f1f787:

  efi/libstub: Correct comment typos (2020-05-06 11:27:55 +0200)

----------------------------------------------------------------
More EFI changes for v5.8:
- Rename pr_efi/pr_efi_err to efi_info/efi_err, and use them consistently
- Simplify and unify initrd loading
- Parse the builtin command line on x86 (if provided)
- Some fixes for issues introduced by the first batch of v5.8 changes

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi/libstub/x86: Work around LLVM ELF quirk build regression
      efi/libstub: Make efi_printk() input argument const char*

Arvind Sankar (12):
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

Joe Perches (1):
      efi/libstub: Correct comment typos

 arch/x86/include/asm/efi.h                     |  19 +++-
 drivers/firmware/efi/libstub/Makefile          |   1 +
 drivers/firmware/efi/libstub/arm32-stub.c      |  12 +--
 drivers/firmware/efi/libstub/arm64-stub.c      |  14 +--
 drivers/firmware/efi/libstub/efi-stub-helper.c |  65 ++++++++++---
 drivers/firmware/efi/libstub/efi-stub.c        |  63 +++++++------
 drivers/firmware/efi/libstub/efistub.h         |  48 ++++------
 drivers/firmware/efi/libstub/fdt.c             |  16 ++--
 drivers/firmware/efi/libstub/file.c            |  12 +--
 drivers/firmware/efi/libstub/gop.c             |  16 ++--
 drivers/firmware/efi/libstub/pci.c             |  10 +-
 drivers/firmware/efi/libstub/relocate.c        |   4 +-
 drivers/firmware/efi/libstub/secureboot.c      |   4 +-
 drivers/firmware/efi/libstub/tpm.c             |   2 +-
 drivers/firmware/efi/libstub/x86-stub.c        | 122 +++++++++++--------------
 15 files changed, 216 insertions(+), 192 deletions(-)
