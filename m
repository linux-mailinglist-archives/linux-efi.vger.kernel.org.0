Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 984F4157F56
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgBJQC7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:02:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbgBJQC7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:02:59 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E3022082F;
        Mon, 10 Feb 2020 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350578;
        bh=Q4ndgPGMWmRLWhwc0INCHB3kBDVfVNkFjyF571z6DHg=;
        h=From:To:Cc:Subject:Date:From;
        b=jTnB2q8egq9DMO5NUj57xR5Pk6YyDT/7IOBYkOg0lIJP7yyZdHaKaJjY8T9AQAT2O
         Osf7VUE4UOU7Ikhsvev3FsCI/ZylHSrwjXNZfggc08UpvU+Eb59E5z2kQBf/b636Mk
         qIpSFWq0T/OauWdxL7Jdj3H05pJqoCjgZ6lxAwm8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 00/19] EFI stub early spring cleaning part 2
Date:   Mon, 10 Feb 2020 17:02:29 +0100
Message-Id: <20200210160248.4889-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series is a second pass over the EFI stub code to clean it up and
prepare it for some future changes:
- loading the initrd in a different way, which should remove the need for
  bootloaders to have knowledge about the initrd allocation policies and
  about how to pass the base and size to the kernel proper,
- support for RISC-V will be arriving soon, which makes this a good time to
  do some janitorial work to avoid RISC-V from inheriting legacy that only
  exists for the benefit of other architectures.

First of all, code has been moved into separate source files where appropriate,
so that we can benefit from the fact that the EFI stub is a true static library,
and so only the objects that are needed to satisfy symbol dependencies are
incorporated into the final build. We also move x86's eboot.c into libstub/
so we can use the same cflags and make rules across the entire library.
(#5, #7, #9, #12, #13, #14)

Patches #6, #15 and #17 clean up the memory allocation, file I/O and command
line parsing routines that are shared by all architectures, to remove open
coded logic that is already implemented elsewhere, either in the firmware or
in code that we can incorporate from the kernel proper.

Patches #10, #11 and #16 deal with upper limits for memory allocations.

Patches #18 and #19 adds the plumbing to enable us to locate device paths and
invoke the EFI LoadFile2 protocol.

The remaining patches are cleanups or minor bug fixes across the board.

Note that this series applies onto Arvind's x86/boot cleanups [0]. Full
branch can be found here [1]

Cc: nivedita@alum.mit.edu
Cc: mingo@kernel.org
Cc: lukas@wunner.de
Cc: atish.patra@wdc.com

[0] https://lore.kernel.org/linux-efi/20200202171353.3736319-1-nivedita@alum.mit.edu/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-spring-cleaning-part2

Ard Biesheuvel (19):
  efi/libstub/x86: Remove pointless zeroing of apm_bios_info
  efi/libstub/x86: Avoid overflowing code32_start on PE entry
  efi/libstub: Use hidden visiblity for all source files
  efi/libstub/arm: Relax FDT alignment requirement
  efi/libstub: Move memory map handling and allocation routines to mem.c
  efi/libstub: Simplify efi_high_alloc() and rename to
    efi_allocate_pages()
  efi/libstub/x86: Incorporate eboot.c into libstub
  efi/libstub: Use consistent type names for file I/O protocols
  efi/libstub: Move stub specific declarations into efistub.h
  efi/libstub/x86: Permit bootparams struct to be allocated above 4 GB
  efi/libstub/x86: Permit cmdline data to be allocated above 4 GB
  efi/libstub: Move efi_random_alloc() into separate source file
  efi/libstub: Move get_dram_base() into arm-stub.c
  efi/libstub: Move file I/O support code into separate file
  efi/libstub: Rewrite file I/O routine
  efi/libstub: Take soft and hard memory limits into account for initrd
    loading
  efi/libstub: Clean up command line parsing routine
  efi/libstub: Expose LocateDevicePath boot service
  efi/libstub: Make the LoadFile EFI protocol accessible

 arch/arm64/include/asm/efi.h                  |  10 -
 arch/x86/boot/compressed/Makefile             |   5 +-
 arch/x86/boot/compressed/eboot.h              |  31 -
 arch/x86/include/asm/efi.h                    |   9 +-
 drivers/firmware/efi/libstub/Makefile         |   6 +-
 drivers/firmware/efi/libstub/arm-stub.c       |  47 +-
 drivers/firmware/efi/libstub/arm64-stub.c     |   8 +-
 .../firmware/efi/libstub/efi-stub-helper.c    | 725 +-----------------
 drivers/firmware/efi/libstub/efistub.h        | 586 +++++++++++++-
 drivers/firmware/efi/libstub/fdt.c            |   7 +-
 drivers/firmware/efi/libstub/file.c           | 258 +++++++
 drivers/firmware/efi/libstub/hidden.h         |   6 +
 drivers/firmware/efi/libstub/mem.c            | 253 ++++++
 drivers/firmware/efi/libstub/random.c         | 114 ---
 drivers/firmware/efi/libstub/randomalloc.c    | 124 +++
 drivers/firmware/efi/libstub/string.c         |  63 ++
 .../firmware/efi/libstub/x86-stub.c           |  79 +-
 include/linux/efi.h                           | 516 +------------
 18 files changed, 1389 insertions(+), 1458 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/eboot.h
 create mode 100644 drivers/firmware/efi/libstub/file.c
 create mode 100644 drivers/firmware/efi/libstub/hidden.h
 create mode 100644 drivers/firmware/efi/libstub/mem.c
 create mode 100644 drivers/firmware/efi/libstub/randomalloc.c
 rename arch/x86/boot/compressed/eboot.c => drivers/firmware/efi/libstub/x86-stub.c (94%)

-- 
2.17.1

