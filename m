Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7C164BA1A
	for <lists+linux-efi@lfdr.de>; Tue, 13 Dec 2022 17:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiLMQrA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Dec 2022 11:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiLMQqd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Dec 2022 11:46:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDAB62E3
        for <linux-efi@vger.kernel.org>; Tue, 13 Dec 2022 08:46:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24A2961615
        for <linux-efi@vger.kernel.org>; Tue, 13 Dec 2022 16:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F2EC433D2;
        Tue, 13 Dec 2022 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670949990;
        bh=zp66oCIIW597tX16kc28dFXtSbYuFy74h45ZpHSxVos=;
        h=From:To:Cc:Subject:Date:From;
        b=ede8JKicAeWumGeU03w6dGKtUOp2+/EpdX5w1y35IXmt2oY8I7p8LtLVbhfZkdULW
         mXJcl4y3QsAP4kYDrbF/M2aYXcisuiiNnfmBrRxUiBwcY8nf8eIzmlCSGa452nyqzk
         g6BQdxEuqmKCFFFuVc6ZELVDYZhYbCyfGLm5y4x9QEegKzoaZBCKHxqdUDPQqm4mvc
         zg4/7mYCURKUAYbhhjTQ6wOol8fk9M5JHi51Svn9IDrsNKgnCzkTH2PUDGfej1ZTkT
         /j1pePZgemWsnogL7P1mQJ2/qirrJZQ/x1l4uF/81cB4u836hw6DxRVja/60LiNQuV
         VefgRMNFtg3lA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI updates for v6.2
Date:   Tue, 13 Dec 2022 17:46:22 +0100
Message-Id: <20221213164622.2213946-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11241; i=ardb@kernel.org; h=from:subject; bh=zp66oCIIW597tX16kc28dFXtSbYuFy74h45ZpHSxVos=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjmKxdLoJwF+UhFhw/rKXf8ERJcXCSAasYmzS8h16B KwHaadeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY5isXQAKCRDDTyI5ktmPJKirDA DDn4uwujgFKrH+AsiJiQpOSRDiXDgOqRSHQxu7jMkKff110IJsM1O7fZkBSBmIxdsnSdW/NmVxggG5 hXrnSxFntLKsK/aeoAwo1AJxRkHPJdOaqHviyZmkNvXUPeR6kq47pofIKKteQ735NCQV4e4U1TauCN +jE9f50x5Z/ioC/RAuoqEp7VK35Z15dFnME/wwwSqoEErX4Kea2KP2Lf+RxUn9NtiAWd3zBPNxR2SZ KJKUQHMhZKI5jJ+1900GD/nOBO4x7auM8NSoSvlK2N2qFzLTmv8SV0OWeIJFiVKs4Aa0dJKqntmBJ3 RA2M/Hkv8IjlZzPk9COXI6dJEmzehKpHStVEDi38Uef32gSnXZvn5+N4/ucojUXY8UElKb67Au7upD WfnjbaVcSGHPO+i/G/MDd8KY1VCaC6LnMinDO6GK7QkEPByDJft/y6qKM0FYonV/4Jd1cfmIh9IDuX PuBRsYjjQfSHox3Of/S9roT2vq82u1pfsVTVn3XdcMfS4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Linus,

Another fairly sizable PR for v6.2 this time, by EFI subsystem standards. Most
of the work was done by me, some of it in collaboration with the distro and
bootloader folks (GRUB, systemd-boot), where the main focus has been on
removing pointless per-arch differences in the way EFI boots a Linux kernel.

There were a few conflicts reported, with the arm64 and tip trees, but nothing
too hairy. Some of the conflicts were with some of my own work landing via a
different tree, but in those cases, the changes in question were mostly
unrelated, had been on the list for a while and simply happened to land now so
I don't think there is much I could have done about that.

Please pull.


The following changes since commit 76dcd734eca23168cb008912c0f69ff408905235:

  Linux 6.1-rc8 (2022-12-04 14:48:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.2

for you to fetch changes up to e8dfdf3162eb549d064b8c10b1564f7e8ee82591:

  arm64: efi: Recover from synchronous exceptions occurring in firmware (2022-12-08 18:33:34 +0100)

----------------------------------------------------------------
EFI updates for v6.2:

- Refactor the zboot code so that it incorporates all the EFI stub
  logic, rather than calling the decompressed kernel as a EFI app.
- Add support for initrd= command line option to x86 mixed mode.
- Allow initrd= to be used with arbitrary EFI accessible file systems
  instead of just the one the kernel itself was loaded from.
- Move some x86-only handling and manipulation of the EFI memory map
  into arch/x86, as it is not used anywhere else.
- More flexible handling of any random seeds provided by the boot
  environment (i.e., systemd-boot) so that it becomes available much
  earlier during the boot.
- Allow improved arch-agnostic EFI support in loaders, by setting a
  uniform baseline of supported features, and adding a generic magic
  number to the DOS/PE header. This should allow loaders such as GRUB or
  systemd-boot to reduce the amount of arch-specific handling
  substantially.
- (arm64) Run EFI runtime services from a dedicated stack, and use it to
  recover from synchronous exceptions that might occur in the firmware
  code.
- (arm64) Ensure that we don't allocate memory outside of the 48-bit
  addressable physical range.
- Make EFI pstore record size configurable
- Add support for decoding CXL specific CPER records

----------------------------------------------------------------
Ard Biesheuvel (38):
      efi: libstub: Drop randomization of runtime memory map
      efi: libstub: Drop handling of EFI properties table
      efi: libstub: Deduplicate ftrace command line argument filtering
      arm64: efi: Move dcache cleaning of loaded image out of efi_enter_kernel()
      arm64: efi: Avoid dcache_clean_poc() altogether in efi_enter_kernel()
      arm64: efi: Move efi-entry.S into the libstub source directory
      efi: libstub: Use local strncmp() implementation unconditionally
      efi: libstub: Clone memcmp() into the stub
      efi: libstub: Enable efi_printk() in zboot decompressor
      efi: loongarch: Drop exports of unused string routines
      efi: libstub: Move screen_info handling to common code
      efi: libstub: Provide local implementations of strrchr() and memchr()
      efi: libstub: Factor out EFI stub entrypoint into separate file
      efi: libstub: Add image code and data size to the zimage metadata
      efi: libstub: Factor out min alignment and preferred kernel load address
      efi/riscv: libstub: Split off kernel image relocation for builtin stub
      efi/arm64: libstub: Split off kernel image relocation for builtin stub
      efi/loongarch: Don't jump to kernel entry via the old image
      efi/loongarch: libstub: Split off kernel image relocation for builtin stub
      efi: libstub: Merge zboot decompressor with the ordinary stub
      Merge tag 'efi-zboot-direct-for-v6.2' into efi/next
      efi: libstub: use EFI_LOADER_CODE region when moving the kernel in memory
      efi: libstub: Implement devicepath support for initrd commandline loader
      efi: libstub: Permit mixed mode return types other than efi_status_t
      efi: libstub: Add mixed mode support to command line initrd loader
      efi: libstub: Undeprecate the command line initrd loader
      efi: memmap: Move EFI fake memmap support into x86 arch tree
      efi: memmap: Move manipulation routines into x86 arch tree
      efi: xen: Set EFI_PARAVIRT for Xen dom0 boot on all architectures
      efi: runtime-maps: Clarify purpose and enable by default for kexec
      efi: x86: Move EFI runtime map sysfs code to arch/x86
      efi: random: combine bootloader provided RNG seed with RNG protocol output
      efi: libstub: Always enable initrd command line loader and bump version
      efi: Put Linux specific magic number in the DOS header
      Merge tag 'v6.1-rc8' into efi/next
      arm64: efi: Limit allocations to 48-bit addressable physical region
      arm64: efi: Execute runtime services from a dedicated stack
      arm64: efi: Recover from synchronous exceptions occurring in firmware

Guilherme G. Piccoli (1):
      efi: pstore: Add module parameter for setting the record size

Jason A. Donenfeld (2):
      efi: vars: prohibit reading random seed variables
      efi: stub: use random seed from EFI variable

Jialin Zhang (1):
      efi: libstub: fix efi_load_initrd_dev_path() kernel-doc comment

Lukas Bulwahn (1):
      MAINTAINERS: adjust entry after arm64 efi-entry.S file movement

Smita Koralahalli (2):
      efi/cper, cxl: Decode CXL Protocol Error Section
      efi/cper, cxl: Decode CXL Error Log

 MAINTAINERS                                        |   1 -
 arch/arm/include/asm/efi.h                         |   3 -
 arch/arm/kernel/efi.c                              |  31 +--
 arch/arm64/include/asm/efi.h                       |  27 +-
 arch/arm64/kernel/Makefile                         |   9 +-
 arch/arm64/kernel/efi-entry.S                      |  69 -----
 arch/arm64/kernel/efi-rt-wrapper.S                 |  39 ++-
 arch/arm64/kernel/efi.c                            |  49 ++++
 arch/arm64/kernel/image-vars.h                     |   8 -
 arch/arm64/mm/fault.c                              |   4 +
 arch/loongarch/include/asm/efi.h                   |  14 +-
 arch/loongarch/kernel/efi.c                        |  24 +-
 arch/loongarch/kernel/head.S                       |   3 +-
 arch/loongarch/kernel/image-vars.h                 |   8 -
 arch/riscv/include/asm/efi.h                       |  13 +-
 arch/riscv/kernel/image-vars.h                     |   6 -
 arch/x86/Kconfig                                   |  31 +++
 arch/x86/boot/compressed/efi_thunk_64.S            |   6 -
 arch/x86/boot/header.S                             |   3 +-
 arch/x86/include/asm/efi.h                         | 109 +++++---
 arch/x86/kernel/setup.c                            |   1 +
 arch/x86/platform/efi/Makefile                     |   5 +-
 arch/x86/platform/efi/efi.c                        |   8 +-
 .../firmware => arch/x86/platform}/efi/fake_mem.c  |  79 +++++-
 arch/x86/platform/efi/memmap.c                     | 239 ++++++++++++++++
 .../x86/platform}/efi/runtime-map.c                |   7 +-
 drivers/firmware/efi/Kconfig                       |  45 ---
 drivers/firmware/efi/Makefile                      |   7 +-
 drivers/firmware/efi/cper.c                        |   9 +
 drivers/firmware/efi/cper_cxl.c                    | 179 ++++++++++++
 drivers/firmware/efi/cper_cxl.h                    |  66 +++++
 drivers/firmware/efi/efi-init.c                    |  21 +-
 drivers/firmware/efi/efi-pstore.c                  |  23 +-
 drivers/firmware/efi/efi.c                         |  14 +-
 drivers/firmware/efi/fake_mem.h                    |  10 -
 drivers/firmware/efi/fdtparams.c                   |   4 +
 drivers/firmware/efi/libstub/Makefile              |  34 ++-
 drivers/firmware/efi/libstub/Makefile.zboot        |  22 +-
 drivers/firmware/efi/libstub/alignedmem.c          |   7 +-
 drivers/firmware/efi/libstub/arm32-stub.c          |  37 ---
 drivers/firmware/efi/libstub/arm64-entry.S         |  67 +++++
 drivers/firmware/efi/libstub/arm64-stub.c          |  75 ++---
 drivers/firmware/efi/libstub/arm64.c               |  76 +++++
 drivers/firmware/efi/libstub/efi-stub-entry.c      |  65 +++++
 drivers/firmware/efi/libstub/efi-stub-helper.c     | 150 +---------
 drivers/firmware/efi/libstub/efi-stub.c            | 140 +++-------
 drivers/firmware/efi/libstub/efistub.h             | 143 +++++++---
 drivers/firmware/efi/libstub/file.c                | 122 +++++---
 drivers/firmware/efi/libstub/intrinsics.c          |  18 ++
 drivers/firmware/efi/libstub/loongarch-stub.c      |  89 ++----
 drivers/firmware/efi/libstub/loongarch.c           |  80 ++++++
 drivers/firmware/efi/libstub/mem.c                 |   5 +-
 drivers/firmware/efi/libstub/printk.c              | 154 +++++++++++
 drivers/firmware/efi/libstub/random.c              |  96 ++++++-
 drivers/firmware/efi/libstub/randomalloc.c         |   7 +-
 drivers/firmware/efi/libstub/riscv-stub.c          |  96 +------
 drivers/firmware/efi/libstub/riscv.c               |  98 +++++++
 drivers/firmware/efi/libstub/screen_info.c         |  56 ++++
 drivers/firmware/efi/libstub/string.c              |  95 ++++++-
 drivers/firmware/efi/libstub/zboot-header.S        |   5 +-
 drivers/firmware/efi/libstub/zboot.c               | 307 +++++----------------
 drivers/firmware/efi/memmap.c                      | 243 +---------------
 drivers/firmware/efi/runtime-wrappers.c            |   1 +
 drivers/firmware/efi/x86_fake_mem.c                |  75 -----
 fs/efivarfs/inode.c                                |   4 +
 fs/efivarfs/super.c                                |   3 +
 include/linux/cxl_err.h                            |  22 ++
 include/linux/efi.h                                |  55 +---
 include/linux/pe.h                                 |   9 +-
 69 files changed, 2138 insertions(+), 1492 deletions(-)
 delete mode 100644 arch/arm64/kernel/efi-entry.S
 rename {drivers/firmware => arch/x86/platform}/efi/fake_mem.c (58%)
 create mode 100644 arch/x86/platform/efi/memmap.c
 rename {drivers/firmware => arch/x86/platform}/efi/runtime-map.c (96%)
 create mode 100644 drivers/firmware/efi/cper_cxl.c
 create mode 100644 drivers/firmware/efi/cper_cxl.h
 delete mode 100644 drivers/firmware/efi/fake_mem.h
 create mode 100644 drivers/firmware/efi/libstub/arm64-entry.S
 create mode 100644 drivers/firmware/efi/libstub/arm64.c
 create mode 100644 drivers/firmware/efi/libstub/efi-stub-entry.c
 create mode 100644 drivers/firmware/efi/libstub/loongarch.c
 create mode 100644 drivers/firmware/efi/libstub/printk.c
 create mode 100644 drivers/firmware/efi/libstub/riscv.c
 create mode 100644 drivers/firmware/efi/libstub/screen_info.c
 delete mode 100644 drivers/firmware/efi/x86_fake_mem.c
 create mode 100644 include/linux/cxl_err.h
