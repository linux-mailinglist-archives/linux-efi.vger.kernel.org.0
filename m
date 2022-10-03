Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A3B5F2FF3
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 13:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJCL7Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 07:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJCL7Y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 07:59:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F6F4F3B9
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 04:59:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7115561043
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 11:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB489C433C1;
        Mon,  3 Oct 2022 11:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664798361;
        bh=y/utiBpdVfN9hNJ68N7EFycsItXJcdVtrvr3aoBs6NY=;
        h=From:To:Cc:Subject:Date:From;
        b=EJ8lubFI1dI3qikwfhtSb3Jx+/iJWyscBp5ZvKqnIaYWDkIgcjBuN6UgQZ8s3qmBD
         Sw8fKi8NgxAzzLHMNw6SZMxHF7yZuzmQWBnrbrvKzURjqZ5xOYHTluioz0w0HItZId
         saS9m2JH+83KMdq5184VvthOBz2ka3cUWAPFT3tEnyvYM7fIQA4Xd9oxR07gZfMAYZ
         rKcuVbFOmxezHtZlq2uvc3PSpD2VBGdA+RWfqu7YezbEjSpbnI6TKK5qUbh4myaDqI
         wRqLDFA1ALr2bQZHycf9BpJ0e/gX2sleXpp69sRWNKlV/6HbhD6kk0bBz35w/zHIYb
         qtoldnxz/0Cyw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [GIT PULL] EFI updates for v6.1
Date:   Mon,  3 Oct 2022 13:59:10 +0200
Message-Id: <20221003115910.973547-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9627; i=ardb@kernel.org; h=from:subject; bh=y/utiBpdVfN9hNJ68N7EFycsItXJcdVtrvr3aoBs6NY=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjOs6NdrB+4TY6OdTQRbTU7gXPW1RAYECkGaw8H/3r T7QzKYSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYzrOjQAKCRDDTyI5ktmPJP+kC/ 9G5GUU0PMfHJ1H07Dku4CMCYLWU6F7Vx1R50yVYEUbOr8oMBcpX/0CiZrWwRf2eJJR6wa/KdbWzAS1 S/0FfeVmpTs+xinPksbZI/Za8Qbd/p8qQtaDGUyVIBTlc/rpcLDHb/U0rvcP3fCe/XKlmQTAzm5nxA wq11OPiOHLvukDLEEO8yA2xuy3X629tnsdjOTvDKOd+0XcZf5S+UdlU10hSbEVccXddlyOgtJotYzr Te7VEIfM0F1Exw2eoAKGwWZVTBvf3WiAn9N8T+nstD3aNnTxtg+nwzzSQ06Uzv0mk0A2h52kjcomoZ E9DYsrqX26/6CN8q5dP6c6/8llO3udXA2XdqeWfrFY9vjak5itMqA/s7COh7yTi0F84SsExmqEwgqm S7Gqq/3w0xwq8pLNZcBpQN2F6ROSRLkhRTtdbfi2Fnfd4ELN3vCaXkkQfma3BUSHAphKslWCwWE5D5 PmeIMD+X6aBsL1dVUjMXWcBdOD2Leouk97tshgupu0FPg=
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

A bit more going on than usual in the EFI subsystem. The main driver for this
has been the introduction of the LoonArch architecture last cycle, which
inspired some cleanup and refactoring of the EFI code. Another driver for EFI
changes this cycle and in the future is confidential compute.

The LoongArch architecture does not use either struct bootparams or DT natively
[yet], and so passing information between the EFI stub and the core kernel
using either of those is undesirable. And in general, overloading DT has been a
source of issues on arm64, so using DT for this on new architectures is a to
avoid for the time being (even if we might converge on something DT based for
non-x86 architectures in the future). For this reason, in addition to the patch
that enables EFI boot for LoongArch, there are a number of refactoring patches
applied on top of which separate the DT bits from the generic EFI stub bits.
These changes are on a separate topich branch that has been shared with the
LoongArch maintainers, who will include it in their pull request as well. This
is not ideal, but the best way to manage the conflicts without stalling
LoongArch for another cycle.

Another development inspired by LoongArch is the newly added support for EFI
based decompressors. Instead of adding yet another arch-specific incarnation of
this pattern for LoongArch, we are introducing a EFI app based on the existing
EFI libstub infrastructure that encapulates the decompression code we use on
other architectures, but in a way that is fully generic. This has been
developed and tested in collaboration with distro and systemd folks, who are
eager to start using this for systemd-boot and also for arm64 secure boot on
Fedora. Note that the EFI zimage files this introduces can also be decompressed
by non-EFI bootloaders if needed, as the image header describes the location of
the payload inside the image, and the type of compression that was used. (Note
that Fedora's arm64 GRUB is buggy [0] so you'll need a recent version or switch
to systemd-boot in order to use this.)

Finally, we are adding TPM measurement of the kernel command line provided by
EFI. There is an oversight in the TCG spec which results in a blind spot for
command line arguments passed to loaded images, which means that either the
loader or the stub needs to take the measurement. Given the combinatorial
explosion I am anticipating when it comes to firmware/bootloader stacks and
firmware based attestation protocols (SEV-SNP, TDX, DICE, DRTM), it is good to
set a baseline now when it comes to EFI measured boot, which is that the kernel
measures the initrd and command line. Intermediate loaders can measure
additional assets if needed, but with the baseline in place, we can deploy
measured boot in a meaningful way even if you boot into Linux straight from the
EFI firmware.

Please pull the changes below.

-- 
Ard.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.1

for you to fetch changes up to d3549a938b73f203ef522562ae9f2d38aa43d234:

  efi/arm64: libstub: avoid SetVirtualAddressMap() when possible (2022-09-27 13:26:16 +0200)

Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>

[0] https://github.com/rhboot/grub2/commit/7710c05ea38995f558a84a27ae0cb89968383420

----------------------------------------------------------------
EFI updates for v6.1

- implement EFI boot support for LoongArch
- implement generic EFI compressed boot support for arm64, RISC-V and
  LoongArch, none of which implement a decompressor today
- measure the kernel command line into the TPM if measured boot is in
  effect
- refactor the EFI stub code in order to isolate DT dependencies for
  architectures other than x86
- avoid calling SetVirtualAddressMap() on arm64 if the configured size
  of the VA space guarantees that doing so is unnecessary
- move some ARM specific code out of the generic EFI source files
- unmap kernel code from the x86 mixed mode 1:1 page tables

----------------------------------------------------------------
Ard Biesheuvel (23):
      efi/x86-mixed: move unmitigated RET into .rodata
      Merge tag 'efi-loongarch-for-v6.1' into efi/next
      efi/libstub: add some missing EFI prototypes
      efi/libstub: use EFI provided memcpy/memset routines
      efi/libstub: move efi_system_table global var into separate object
      efi/libstub: implement generic EFI zboot
      riscv: efi: enable generic EFI compressed boot
      loongarch: efi: enable generic EFI compressed boot
      arm64: efi: enable generic EFI compressed boot
      efi: libstub: fix type confusion for load_options_size
      efi: libstub: drop pointless get_memory_map() call
      efi: libstub: avoid efi_get_memory_map() for allocating the virt map
      efi: libstub: simplify efi_get_memory_map() and struct efi_boot_memmap
      efi: libstub: remove pointless goto kludge
      efi: libstub: unify initrd loading between architectures
      efi: libstub: remove DT dependency from generic stub
      efi: libstub: install boot-time memory map as config table
      efi/loongarch: libstub: remove dependency on flattened DT
      Merge tag 'efi-loongarch-for-v6.1-2' into HEAD
      efi/arm: libstub: move ARM specific code out of generic routines
      efi: libstub: fix up the last remaining open coded boot service call
      efi: zboot: create MemoryMapped() device path for the parent if needed
      efi/arm64: libstub: avoid SetVirtualAddressMap() when possible

Huacai Chen (1):
      efi/loongarch: Add efistub booting support

Ilias Apalodimas (2):
      efi/libstub: refactor the initrd measuring functions
      efi/libstub: measure EFI LoadOptions

 Documentation/arm/uefi.rst                     |   4 -
 arch/arm/include/asm/efi.h                     |   3 +-
 arch/arm/kernel/efi.c                          |  79 +++++++
 arch/arm/kernel/setup.c                        |   2 +-
 arch/arm64/Makefile                            |   9 +-
 arch/arm64/boot/.gitignore                     |   1 +
 arch/arm64/boot/Makefile                       |   6 +
 arch/arm64/kernel/image-vars.h                 |  13 --
 arch/loongarch/Kconfig                         |  12 +-
 arch/loongarch/Makefile                        |  18 +-
 arch/loongarch/boot/.gitignore                 |   1 +
 arch/loongarch/boot/Makefile                   |  14 +-
 arch/loongarch/include/asm/bootinfo.h          |   2 +-
 arch/loongarch/include/asm/efi.h               |  11 +-
 arch/loongarch/kernel/efi-header.S             |  99 ++++++++
 arch/loongarch/kernel/efi.c                    |  33 ++-
 arch/loongarch/kernel/env.c                    |  13 +-
 arch/loongarch/kernel/head.S                   |  22 ++
 arch/loongarch/kernel/image-vars.h             |  27 +++
 arch/loongarch/kernel/setup.c                  |  15 +-
 arch/loongarch/kernel/vmlinux.lds.S            |   1 +
 arch/riscv/Makefile                            |   6 +-
 arch/riscv/boot/.gitignore                     |   1 +
 arch/riscv/boot/Makefile                       |   6 +
 arch/riscv/kernel/image-vars.h                 |   9 -
 arch/x86/platform/efi/efi_64.c                 |  18 +-
 arch/x86/platform/efi/efi_thunk_64.S           |  13 +-
 drivers/firmware/efi/Kconfig                   |  45 +++-
 drivers/firmware/efi/efi-init.c                |  61 +----
 drivers/firmware/efi/efi.c                     |  15 ++
 drivers/firmware/efi/libstub/Makefile          |  32 ++-
 drivers/firmware/efi/libstub/Makefile.zboot    |  70 ++++++
 drivers/firmware/efi/libstub/arm64-stub.c      |  27 ++-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 290 ++++++++++++++----------
 drivers/firmware/efi/libstub/efi-stub.c        | 118 ++++------
 drivers/firmware/efi/libstub/efistub.h         |  69 +++---
 drivers/firmware/efi/libstub/fdt.c             | 175 +++++++-------
 drivers/firmware/efi/libstub/file.c            |  23 +-
 drivers/firmware/efi/libstub/intrinsics.c      |  30 +++
 drivers/firmware/efi/libstub/loongarch-stub.c  | 102 +++++++++
 drivers/firmware/efi/libstub/mem.c             |  93 ++++----
 drivers/firmware/efi/libstub/randomalloc.c     |  25 +-
 drivers/firmware/efi/libstub/relocate.c        |  21 +-
 drivers/firmware/efi/libstub/systable.c        |   8 +
 drivers/firmware/efi/libstub/x86-stub.c        |  33 +--
 drivers/firmware/efi/libstub/zboot-header.S    | 143 ++++++++++++
 drivers/firmware/efi/libstub/zboot.c           | 302 +++++++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.lds         |  44 ++++
 include/linux/efi.h                            |  35 +++
 include/linux/pe.h                             |   2 +
 50 files changed, 1638 insertions(+), 563 deletions(-)
 create mode 100644 arch/loongarch/kernel/efi-header.S
 create mode 100644 arch/loongarch/kernel/image-vars.h
 create mode 100644 drivers/firmware/efi/libstub/Makefile.zboot
 create mode 100644 drivers/firmware/efi/libstub/intrinsics.c
 create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.c
 create mode 100644 drivers/firmware/efi/libstub/systable.c
 create mode 100644 drivers/firmware/efi/libstub/zboot-header.S
 create mode 100644 drivers/firmware/efi/libstub/zboot.c
 create mode 100644 drivers/firmware/efi/libstub/zboot.lds
