Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6416A75D
	for <lists+linux-efi@lfdr.de>; Mon, 24 Feb 2020 14:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgBXNj0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Feb 2020 08:39:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgBXNj0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 24 Feb 2020 08:39:26 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1F62080D;
        Mon, 24 Feb 2020 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582551564;
        bh=3w/VtACI2QAAXGDWkNJPyIOton6yEKctkoL3PqKFyA4=;
        h=From:To:Cc:Subject:Date:From;
        b=oki+T32ZZkQZpYaoF0J7KqF2yBVuDWyt5f4jw8HWq80Idg2ZNnOdWHaE6Sh/Ywgka
         dAYcEcTEld31nftNGOlPLEDWL19/Maq7TcojaIZuJKAy5gv9gVqEtwhCoAKBnDL4Dm
         LI/Sl42XtpXk90GiEGzj3uV66oooQEMYoy3i0L+4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL v2] EFI updates for v5.7
Date:   Mon, 24 Feb 2020 14:38:56 +0100
Message-Id: <20200224133856.12832-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Ingo, Thomas,

I am sending this as an ordinary PR again, given the size. Please let me
know if instead, you prefer me to send it out piecemeal as usual. Either
works for me, I was just reluctant to spam people unsolicited.

Note that EFI for RISC-V may still arrive this cycle as well. 

Please take special note of the GDT changes by Arvind. They were posted to
the list without any feedback, and they look fine to me, but I know very
little about these x86 CPU low level details.

This was all build and boot tested on various different kinds of hardware,
and all minor issues that were reported by the robots were fixed along the way.

Please pull,
Ard.


The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to dc235d62fc60a6549238eda7ff29769457fe5663:

  efi: Bump the Linux EFI stub major version number to #1 (2020-02-23 21:59:42 +0100)

----------------------------------------------------------------
EFI updates for v5.7:

This time, the set of changes for the EFI subsystem is much larger than
usual. The main reasons are:
- Get things cleaned up before EFI support for RISC-V arrives, which will
  increase the size of the validation matrix, and therefore the threshold to
  making drastic changes,
- After years of defunct maintainership, the GRUB project has finally started
  to consider changes from the distros regarding UEFI boot, some of which are
  highly specific to the way x86 does UEFI secure boot and measured boot,
  based on knowledge of both shim internals and the layout of bootparams and
  the x86 setup header. Having this maintenance burden on other architectures
  (which don't need shim in the first place) is hard to justify, so instead,
  we are introducing a generic Linux/UEFI boot protocol.

Summary of changes:
- Boot time GDT handling changes (Arvind)
- Simplify handling of EFI properties table on arm64
- Generic EFI stub cleanups, to improve command line handling, file I/O,
  memory allocation, etc.
- Introduce a generic initrd loading method based on calling back into
  the firmware, instead of relying on the x86 EFI handover protocol or
  device tree.
- Introduce a mixed mode boot method that does not rely on the x86 EFI
  handover protocol either, and could potentially be adopted by other
  architectures (if another one ever surfaces where one execution mode
  is a superset of another)
- Clean up the contents of struct efi, and move out everything that
  doesn't need to be stored there.
- Incorporate support for UEFI spec v2.8A changes that permit firmware
  implementations to return EFI_UNSUPPORTED from UEFI runtime services at
  OS runtime, and expose a mask of which ones are supported or unsupported
  via a configuration table.
- Various documentation updates and minor code cleanups (Heinrich)
- Partial fix for the lack of by-VA cache maintenance in the decompressor
  on 32-bit ARM. Note that these patches were deliberately put at the
  beginning so they can be used as a stable branch that will be shared with
  a PR containing the complete fix, which I will send to the ARM tree.

----------------------------------------------------------------
Ard Biesheuvel (67):
      efi/arm: Work around missing cache maintenance in decompressor handover
      efi/arm: Pass start and end addresses to cache_clean_flush()
      efi/libstub/arm: Make efi_entry() an ordinary PE/COFF entrypoint
      efi/libstub/arm64: Use 1:1 mapping of RT services if property table exists
      efi/libstub/x86: Remove pointless zeroing of apm_bios_info
      efi/libstub/x86: Avoid overflowing code32_start on PE entry
      efi/libstub: Use hidden visibility for all source files
      efi/libstub/arm: Relax FDT alignment requirement
      efi/libstub: Move memory map handling and allocation routines to mem.c
      efi/libstub: Simplify efi_high_alloc() and rename to efi_allocate_pages()
      efi/libstub/x86: Incorporate eboot.c into libstub
      efi/libstub: Use consistent type names for file I/O protocols
      efi/libstub/x86: Permit bootparams struct to be allocated above 4 GB
      efi/libstub: Move stub specific declarations into efistub.h
      efi/libstub/x86: Permit cmdline data to be allocated above 4 GB
      efi/libstub: Move efi_random_alloc() into separate source file
      efi/libstub: Move get_dram_base() into arm-stub.c
      efi/libstub: Move file I/O support code into separate file
      efi/libstub: Rewrite file I/O routine
      efi/libstub: Take soft and hard memory limits into account for initrd loading
      efi/libstub: Clean up command line parsing routine
      efi/libstub: Expose LocateDevicePath boot service
      efi/libstub: Make the LoadFile EFI protocol accessible
      efi/x86: Reindent struct initializer for legibility
      efi/x86: Replace #ifdefs with IS_ENABLED() checks
      efi/dev-path-parser: Add struct definition for vendor type device path nodes
      efi/libstub: Add support for loading the initrd from a device path
      efi/libstub: Take noinitrd cmdline argument into account for devpath initrd
      efi: Drop handling of 'boot_info' configuration table
      efi/ia64: Move HCDP and MPS table handling into IA64 arch code
      efi: Move UGA and PROP table handling to x86 code
      efi: Make rng_seed table handling local to efi.c
      efi: Move mem_attr_table out of struct efi
      efi: Make memreserve table handling local to efi.c
      efi: Merge EFI system table revision and vendor checks
      efi/ia64: Use existing helpers to locate ESI table
      efi/ia64: Use local variable for EFI system table address
      efi/ia64: Switch to efi_config_parse_tables()
      efi: Make efi_config_init() x86 only
      efi: Clean up config_parse_tables()
      efi/x86: Remove runtime table address from kexec EFI setup data
      efi/x86: Make fw_vendor, config_table and runtime sysfs nodes x86 specific
      efi/x86: Merge assignments of efi.runtime_version
      efi: Add 'runtime' pointer to struct efi
      efi/arm: Drop unnecessary references to efi.systab
      efi/x86: Drop 'systab' member from struct efi
      efi/x86: add headroom to decompressor BSS to account for setup block
      efi/x86: Drop redundant .bss section
      efi/libstub/x86: Make loaded_image protocol handling mixed mode safe
      efi/libstub/x86: Use Exit() boot service to exit the stub on errors
      efi/x86: Implement mixed mode boot without the handover protocol
      efi/x86: Add true mixed mode entry point into .compat section
      efi/arm: Move FDT param discovery code out of efi.c
      efi/arm: Move FDT specific definitions into fdtparams.c
      efi/arm: Rewrite FDT param discovery routines
      efi: Store mask of supported runtime services in struct efi
      efi: Add support for EFI_RT_PROPERTIES table
      efi: Use more granular check for availability for variable services
      efi: Register EFI rtc platform device only when available
      infiniband: hfi1: Use EFI GetVariable only when available
      scsi: iscsi: Use EFI GetVariable only when available
      efi: Use EFI ResetSystem only when available
      x86/ima: Use EFI GetVariable only when available
      integrity: Check properly whether EFI GetVariable() is available
      efi/x86: Use symbolic constants in PE header instead of bare numbers
      efi/libstub: Introduce symbolic constants for the stub major/minor version
      efi: Bump the Linux EFI stub major version number to #1

Arvind Sankar (8):
      x86/boot: Remove KEEP_SEGMENTS support
      efi/x86: Don't depend on firmware GDT layout
      x86/boot: Reload GDTR after copying to the end of the buffer
      x86/boot: Clear direction and interrupt flags in startup_64
      efi/x86: Remove GDT setup from efi_main
      x86/boot: GDT limit value should be size - 1
      x86/boot: Micro-optimize GDT loading instructions
      efi/x86: Mark setup_graphics static

Gustavo A. R. Silva (1):
      efi/apple-properties: Replace zero-length array with flexible-array member

Hans de Goede (1):
      efi/bgrt: Accept BGRT tables with a version of 0

Heinrich Schuchardt (8):
      efi/libstub: Add function description of efi_allocate_pages()
      efi/libstub: Simplify efi_get_memory_map()
      efi/libstub: Describe memory functions
      efi/libstub: Describe efi_relocate_kernel()
      efi/libstub: Describe RNG functions
      efi/libstub: Fix error message in handle_cmdline_files()
      efi/esrt: Clean up efi_esrt_init
      efi/capsule-loader: Drop superfluous assignment

 Documentation/x86/boot.rst                         |   8 +-
 arch/arm/boot/compressed/efi-header.S              |   6 +-
 arch/arm/boot/compressed/head.S                    |  60 +-
 arch/arm64/include/asm/efi.h                       |  10 -
 arch/arm64/kernel/efi-entry.S                      |  86 +--
 arch/arm64/kernel/efi-header.S                     |   6 +-
 arch/arm64/kernel/image-vars.h                     |   5 +-
 arch/ia64/kernel/efi.c                             |  55 +-
 arch/ia64/kernel/esi.c                             |  21 +-
 arch/x86/boot/Makefile                             |   2 +-
 arch/x86/boot/compressed/Makefile                  |   5 +-
 arch/x86/boot/compressed/eboot.h                   |  31 -
 arch/x86/boot/compressed/efi_thunk_64.S            |  29 +-
 arch/x86/boot/compressed/head_32.S                 |  48 +-
 arch/x86/boot/compressed/head_64.S                 | 125 +++-
 arch/x86/boot/header.S                             |  87 +--
 arch/x86/boot/tools/build.c                        |  86 ++-
 arch/x86/include/asm/efi.h                         |  23 +-
 arch/x86/kernel/asm-offsets_32.c                   |   5 +
 arch/x86/kernel/head_32.S                          |   6 -
 arch/x86/kernel/ima_arch.c                         |   2 +-
 arch/x86/kernel/kexec-bzimage64.c                  |   5 +-
 arch/x86/platform/efi/efi.c                        | 283 ++++---
 arch/x86/platform/efi/efi_32.c                     |  13 +-
 arch/x86/platform/efi/efi_64.c                     |  14 +-
 arch/x86/platform/efi/efi_stub_32.S                |  21 +-
 arch/x86/platform/efi/quirks.c                     |   2 +-
 drivers/firmware/efi/Makefile                      |   1 +
 drivers/firmware/efi/apple-properties.c            |  12 +-
 drivers/firmware/efi/arm-init.c                    |  83 +--
 drivers/firmware/efi/arm-runtime.c                 |  18 -
 drivers/firmware/efi/capsule-loader.c              |   2 +-
 drivers/firmware/efi/dev-path-parser.c             |  38 +-
 drivers/firmware/efi/efi-bgrt.c                    |   7 +-
 drivers/firmware/efi/efi-pstore.c                  |   2 +-
 drivers/firmware/efi/efi.c                         | 418 ++++-------
 drivers/firmware/efi/efivars.c                     |   2 +-
 drivers/firmware/efi/esrt.c                        |   6 +-
 drivers/firmware/efi/fdtparams.c                   | 126 ++++
 drivers/firmware/efi/libstub/Makefile              |   6 +-
 drivers/firmware/efi/libstub/arm-stub.c            | 193 ++---
 drivers/firmware/efi/libstub/arm32-stub.c          |   1 +
 drivers/firmware/efi/libstub/arm64-stub.c          |  11 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c     | 822 ++++-----------------
 drivers/firmware/efi/libstub/efistub.h             | 611 ++++++++++++++-
 drivers/firmware/efi/libstub/fdt.c                 |   7 +-
 drivers/firmware/efi/libstub/file.c                | 258 +++++++
 drivers/firmware/efi/libstub/hidden.h              |   6 +
 drivers/firmware/efi/libstub/mem.c                 | 309 ++++++++
 drivers/firmware/efi/libstub/random.c              | 136 +---
 drivers/firmware/efi/libstub/randomalloc.c         | 124 ++++
 drivers/firmware/efi/libstub/skip_spaces.c         |  11 +
 drivers/firmware/efi/libstub/string.c              |  56 ++
 .../firmware/efi/libstub/x86-stub.c                | 258 +++----
 drivers/firmware/efi/memattr.c                     |  13 +-
 drivers/firmware/efi/reboot.c                      |   4 +-
 drivers/firmware/efi/runtime-wrappers.c            |   4 +-
 drivers/firmware/pcdp.c                            |   8 +-
 drivers/infiniband/hw/hfi1/efivar.c                |   2 +-
 drivers/rtc/Makefile                               |   4 -
 drivers/rtc/rtc-efi-platform.c                     |  35 -
 drivers/scsi/isci/init.c                           |   2 +-
 fs/efivarfs/super.c                                |   2 +-
 include/linux/efi.h                                | 691 +++--------------
 include/linux/pe.h                                 |  21 +
 security/integrity/platform_certs/load_uefi.c      |   2 +-
 66 files changed, 2718 insertions(+), 2638 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/eboot.h
 create mode 100644 drivers/firmware/efi/fdtparams.c
 create mode 100644 drivers/firmware/efi/libstub/file.c
 create mode 100644 drivers/firmware/efi/libstub/hidden.h
 create mode 100644 drivers/firmware/efi/libstub/mem.c
 create mode 100644 drivers/firmware/efi/libstub/randomalloc.c
 create mode 100644 drivers/firmware/efi/libstub/skip_spaces.c
 rename arch/x86/boot/compressed/eboot.c => drivers/firmware/efi/libstub/x86-stub.c (82%)
 delete mode 100644 drivers/rtc/rtc-efi-platform.c
