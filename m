Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1DF5197D76
	for <lists+linux-efi@lfdr.de>; Mon, 30 Mar 2020 15:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgC3NsI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Mar 2020 09:48:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52261 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgC3NsI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Mar 2020 09:48:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id z18so20032631wmk.2;
        Mon, 30 Mar 2020 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hwuKPKs0k++6QrtUjd58X27vib5INB+KX1JPiTUwCAo=;
        b=O+FLcAbMGsW3FW79R4VNlAFM5V7WJsjQa4AS6HfTff0/0bg4EnNuaaAKfChTOHUn/u
         fb6Q4h4KwgtGllczIg2l3jzDSO8o1L2CL5RacPz3UDNHvdERTQsqFYf3biESvrVpn7Qw
         xxk1VQuXj0Im2YZ03+iITMYNBck8qK814Pk9GMvXyPV37+Y7OGi04JUJDOaVntHndVIa
         iMU2JGEsKD4QAGlBufKlNw82QdVLmHWa3PQjpRrSxUrkXVm5Ng8RPJYta1fLPSNmtNb9
         fICpc0Bq7xxwn/YLRzKxK4NFygehv1tagmveD7Rrok0i7PWRKuY9ixNcKFa8mEGrNzGv
         R24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=hwuKPKs0k++6QrtUjd58X27vib5INB+KX1JPiTUwCAo=;
        b=T+LsZiktM6tB05NdX/tmivyMH9KOQTMm4kKkW5Yf/45OBGnn+5DJdQwpLipW2Yfc+s
         SLc7A3+6T9iCW1Nrw+a0PssarV5X3bHipfUXws8nf0jRqt/1S6J+6XD4nkD8sF9OWiwZ
         dtMMHsOV22uWT/hECtwD2chZ7H9h0CSMRqQC+n1CgfN4oI26TnG0mnXZHY9dOq/unvcN
         s1ZCs/Q5Dm6+S5WoboyI5dq3G+8ss6FGXLtgd+vQ77YNgTEYAvfU4dzWSoWGvm4xpo0l
         VgX8oJffQFPuZ7KTWDP07kpWuEctd77aqOdWozL4GH2ql+M3wBFDFdIsB1Ac//6CFNpy
         sx3g==
X-Gm-Message-State: ANhLgQ0gMgR5Z5M3ZsMp6zNmWSiyJkheHzBCgHQEV/RwZV+CcqKfCIG2
        xp6hzTxflbTSVti5aMFIg/0=
X-Google-Smtp-Source: ADFU+vuJmjwGKPJ4OzZbUNKLuMU2QdEbQ0t4GQDdcBD1INIRCREJuKrfugnJwenHcupbXkLTvziDtw==
X-Received: by 2002:a1c:7412:: with SMTP id p18mr6868410wmc.11.1585576085445;
        Mon, 30 Mar 2020 06:48:05 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u13sm22399738wru.88.2020.03.30.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 06:48:04 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:48:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Morse <james.morse@arm.com>, linux-efi@vger.kernel.org
Subject: [GIT PULL] EFI changes for v5.7
Message-ID: <20200330134803.GA45544@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linus,

Please pull the latest efi-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

   # HEAD: 594e576d4b93b8cda3247542366b47e1b2ddc4dc efi/libstub/arm: Fix spurious message that an initrd was loaded

The EFI changes in this cycle are much larger than usual, for two 
(positive) reasons:

 - The GRUB project is showing signs of life again, resulting in the 
   introduction of the generic Linux/UEFI boot protocol, instead of x86 
   specific hacks which are increasingly difficult to maintain. There's 
   hope that all future extensions will now go through that boot 
   protocol.

 - Preparatory work for RISC-V EFI support.

The main changes are:

 - Boot time GDT handling changes

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

 - Clean up the contents of 'struct efi', and move out everything that
   doesn't need to be stored there.

 - Incorporate support for UEFI spec v2.8A changes that permit firmware
   implementations to return EFI_UNSUPPORTED from UEFI runtime services at
   OS runtime, and expose a mask of which ones are supported or unsupported
   via a configuration table.

 - Partial fix for the lack of by-VA cache maintenance in the decompressor
   on 32-bit ARM.

 - Changes to load device firmware from EFI boot service memory regions

 - Various documentation updates and minor code cleanups and fixes.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (76):
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
      efi/arm: Clean EFI stub exit code from cache instead of avoiding it
      efi/arm64: Clean EFI stub exit code from cache instead of avoiding it
      efi: Mark all EFI runtime services as unsupported on non-EFI boot
      efi/libstub/x86: Deal with exit() boot service returning
      efi/x86: Ignore the memory attributes table on i386
      efi/x86: Preserve %ebx correctly in efi_set_virtual_address_map()
      efi/libstub/x86: Use ULONG_MAX as upper bound for all allocations
      efi/libstub/arm64: Avoid image_base value from efi_loaded_image
      efi/libstub/arm: Fix spurious message that an initrd was loaded

Arvind Sankar (20):
      x86/boot: Remove KEEP_SEGMENTS support
      efi/x86: Don't depend on firmware GDT layout
      x86/boot: Reload GDTR after copying to the end of the buffer
      x86/boot: Clear direction and interrupt flags in startup_64
      efi/x86: Remove GDT setup from efi_main
      x86/boot: GDT limit value should be size - 1
      x86/boot: Micro-optimize GDT loading instructions
      efi/x86: Mark setup_graphics static
      x86/boot/compressed: Fix reloading of GDTR post-relocation
      efi/x86: Annotate the LOADED_IMAGE_PROTOCOL_GUID with SYM_DATA
      efi/x86: Respect 32-bit ABI in efi32_pe_entry()
      efi/x86: Make efi32_pe_entry() more readable
      efi/x86: Avoid using code32_start
      x86/boot: Use unsigned comparison for addresses
      x86/boot/compressed/32: Save the output address instead of recalculating it
      efi/x86: Decompress at start of PE image load address
      efi/x86: Add kernel preferred address to PE header
      efi/x86: Remove extra headroom for setup block
      efi/x86: Don't relocate the kernel unless necessary
      efi/x86: Fix cast of image argument

Gustavo A. R. Silva (1):
      efi/apple-properties: Replace zero-length array with flexible-array member

Hans de Goede (3):
      efi/bgrt: Accept BGRT tables with a version of 0
      efi: Export boot-services code and data as debugfs-blobs
      efi: Add embedded peripheral firmware support

Heinrich Schuchardt (10):
      efi/libstub: Add function description of efi_allocate_pages()
      efi/libstub: Simplify efi_get_memory_map()
      efi/libstub: Describe memory functions
      efi/libstub: Describe efi_relocate_kernel()
      efi/libstub: Describe RNG functions
      efi/libstub: Fix error message in handle_cmdline_files()
      efi/esrt: Clean up efi_esrt_init
      efi/capsule-loader: Drop superfluous assignment
      efi: Don't shadow 'i' in efi_config_parse_tables()
      efi/libstub: Add libstub/mem.c to the documentation tree

Lukas Bulwahn (1):
      MAINTAINERS: Adjust EFI entry to removing eboot.c

Masahiro Yamada (1):
      efi/libstub: Avoid linking libstub/lib-ksyms.o into vmlinux

Nikolai Merinov (1):
      partitions/efi: Fix partition name parsing in GUID partition entry

Tom Lendacky (2):
      efi/x86: Add TPM related EFI tables to unencrypted mapping checks
      efi/x86: Add RNG seed EFI table to unencrypted mapping check

Vladis Dronov (1):
      efi: Fix a mistype in comments mentioning efivar_entry_iter_begin()


 Documentation/driver-api/firmware/efi/index.rst    |  11 +
 Documentation/driver-api/firmware/index.rst        |   1 +
 Documentation/x86/boot.rst                         |   8 +-
 MAINTAINERS                                        |   1 -
 arch/arm/boot/compressed/efi-header.S              |   6 +-
 arch/arm/boot/compressed/head.S                    |  58 +-
 arch/arm64/include/asm/efi.h                       |  10 -
 arch/arm64/kernel/efi-entry.S                      |  90 +--
 arch/arm64/kernel/efi-header.S                     |   6 +-
 arch/arm64/kernel/image-vars.h                     |   7 +-
 arch/ia64/kernel/efi.c                             |  55 +-
 arch/ia64/kernel/esi.c                             |  21 +-
 arch/x86/boot/Makefile                             |   2 +-
 arch/x86/boot/compressed/Makefile                  |   5 +-
 arch/x86/boot/compressed/eboot.h                   |  31 -
 arch/x86/boot/compressed/efi_thunk_64.S            |  29 +-
 arch/x86/boot/compressed/head_32.S                 |  92 ++-
 arch/x86/boot/compressed/head_64.S                 | 205 ++++-
 arch/x86/boot/header.S                             |  93 +--
 arch/x86/boot/tools/build.c                        | 106 ++-
 arch/x86/include/asm/efi.h                         |  23 +-
 arch/x86/kernel/asm-offsets.c                      |   1 -
 arch/x86/kernel/asm-offsets_32.c                   |   5 +
 arch/x86/kernel/head_32.S                          |   6 -
 arch/x86/kernel/ima_arch.c                         |   2 +-
 arch/x86/kernel/kexec-bzimage64.c                  |   5 +-
 arch/x86/platform/efi/efi.c                        | 288 ++++----
 arch/x86/platform/efi/efi_32.c                     |  13 +-
 arch/x86/platform/efi/efi_64.c                     |  14 +-
 arch/x86/platform/efi/efi_stub_32.S                |  21 +-
 arch/x86/platform/efi/quirks.c                     |   6 +-
 block/partitions/efi.c                             |  35 +-
 block/partitions/efi.h                             |   2 +-
 drivers/firmware/efi/Kconfig                       |   5 +
 drivers/firmware/efi/Makefile                      |   4 +-
 drivers/firmware/efi/apple-properties.c            |  12 +-
 drivers/firmware/efi/arm-init.c                    |  83 +--
 drivers/firmware/efi/arm-runtime.c                 |  18 -
 drivers/firmware/efi/capsule-loader.c              |   2 +-
 drivers/firmware/efi/dev-path-parser.c             |  38 +-
 drivers/firmware/efi/efi-bgrt.c                    |   7 +-
 drivers/firmware/efi/efi-pstore.c                  |   4 +-
 drivers/firmware/efi/efi.c                         | 476 +++++-------
 drivers/firmware/efi/efivars.c                     |   2 +-
 drivers/firmware/efi/embedded-firmware.c           | 147 ++++
 drivers/firmware/efi/esrt.c                        |   6 +-
 drivers/firmware/efi/fdtparams.c                   | 126 ++++
 drivers/firmware/efi/libstub/Makefile              |   6 +-
 drivers/firmware/efi/libstub/arm-stub.c            | 193 ++---
 drivers/firmware/efi/libstub/arm32-stub.c          |   1 +
 drivers/firmware/efi/libstub/arm64-stub.c          |  16 +-
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
 .../firmware/efi/libstub/x86-stub.c                | 298 +++-----
 drivers/firmware/efi/memattr.c                     |  13 +-
 drivers/firmware/efi/reboot.c                      |   4 +-
 drivers/firmware/efi/runtime-wrappers.c            |   4 +-
 drivers/firmware/efi/vars.c                        |   2 +-
 drivers/firmware/pcdp.c                            |   8 +-
 drivers/infiniband/hw/hfi1/efivar.c                |   2 +-
 drivers/rtc/Makefile                               |   4 -
 drivers/rtc/rtc-efi-platform.c                     |  35 -
 drivers/scsi/isci/init.c                           |   2 +-
 fs/efivarfs/super.c                                |   2 +-
 include/linux/efi.h                                | 700 +++---------------
 include/linux/efi_embedded_fw.h                    |  41 +
 include/linux/pe.h                                 |  21 +
 security/integrity/platform_certs/load_uefi.c      |   2 +-
 76 files changed, 3197 insertions(+), 2685 deletions(-)
 create mode 100644 Documentation/driver-api/firmware/efi/index.rst
 delete mode 100644 arch/x86/boot/compressed/eboot.h
 create mode 100644 drivers/firmware/efi/embedded-firmware.c
 create mode 100644 drivers/firmware/efi/fdtparams.c
 create mode 100644 drivers/firmware/efi/libstub/file.c
 create mode 100644 drivers/firmware/efi/libstub/hidden.h
 create mode 100644 drivers/firmware/efi/libstub/mem.c
 create mode 100644 drivers/firmware/efi/libstub/randomalloc.c
 create mode 100644 drivers/firmware/efi/libstub/skip_spaces.c
 rename arch/x86/boot/compressed/eboot.c => drivers/firmware/efi/libstub/x86-stub.c (80%)
 delete mode 100644 drivers/rtc/rtc-efi-platform.c
 create mode 100644 include/linux/efi_embedded_fw.h
