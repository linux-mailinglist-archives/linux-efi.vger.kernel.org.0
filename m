Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C817652E7E7
	for <lists+linux-efi@lfdr.de>; Fri, 20 May 2022 10:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347387AbiETIkS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 May 2022 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347322AbiETIkI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 May 2022 04:40:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2114912B031
        for <linux-efi@vger.kernel.org>; Fri, 20 May 2022 01:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B37C8B82A5D
        for <linux-efi@vger.kernel.org>; Fri, 20 May 2022 08:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBE3C385A9;
        Fri, 20 May 2022 08:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653036000;
        bh=xql1yDf7SzyJ288n+CEGHQfFYKs8r2MJiay6fXWdbYw=;
        h=From:To:Cc:Subject:Date:From;
        b=pstgU+KxiJNZ4CPUljwOf18RzqqrG1dSLBBUYxS9UMbWc/YN9tHNHjmk4SX0hE7Ge
         2avHwzkwrJt8OxXoAasHjGYAAVj0JJvq74msDOjcToGe8agsid31LgG2s34SlM/xjU
         O6dMNaJ4zK5AA5F20Odpw7EjcRxYlggxGBEBlTtL29PAlxJDSk0+7+iGpFDZ/oJE25
         1hWVKXnhdmLPiCHuHdm6pV2hmdwGJbghk2XSiuI6XkDU5GzP7Hy+Kvofbfy0CkGPIg
         biq6VatNvKbnU+xkoZPOdb1Ep1ZePinY/vMHtAQZee8Exuk8BOFggc5TeRBGWcmdty
         23X08eJavgqqg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     torvalds@linux-foundation.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI updates for v5.19
Date:   Fri, 20 May 2022 10:39:46 +0200
Message-Id: <20220520083946.549534-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4075; h=from:subject; bh=xql1yDf7SzyJ288n+CEGHQfFYKs8r2MJiay6fXWdbYw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBih1PRs8+HWAqfzAz8AF4udVz/T3auwxUeR2Jf1zUt nUKyIZyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYodT0QAKCRDDTyI5ktmPJO5IDA C3qhvWPUxpIvJc5AAHMpibjgEQ+/5qWomFylW7yte0Nn0ekRqRxiyRkCYQaxV3sc7W25hFSrZzstEF w/ZbgJWT4I41l+qKwslULx2GW9QTTu3us7N53PcRbgzHrCyWK1ByO3QH0GjMDHCF3xMryehFJYfbVW ZEiuy9kJqOv8Fa0wRcmKCytKRT4Z3RVKNqe4IOoNvwVqXpjXntCWNU0IeajGh1H55Xw33Dz5GSuEun 0XSuW9i2erBvD8ljM3f43LczyJQGWva1rRiqebETZgodtNDuusFjYej6Al6i+CS7uUEnfliQeU2FeJ 9rq7ENkAD8ScXmospo9aa7Co5El1s5YmrUHDPqZrIJnwmaDItrFQMhkx2QooMe6kKgdXEqtzN1omMD 7Ml7asFkgSiZ1u1BCipCksFb94991MxuJJFhjUPvLYMfMlKUd/USlJaSqEu22UQjbx53DMR3JnFzql JZxeD2B1MutLWeC09OdN+AofPrb0HlQvtCBORn7JOaNLs=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Linus,

Please pull the changes below. Note the conflict in drivers/virt/Kconfig and
Makefile: this is due to CoCo changes arriving via different trees, and the
resolution is obvious.

Thanks,
Ard.


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.19

for you to fetch changes up to 3f68e69520d3d52d66a6ad872a75b7d8f2ea7665:

  riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL (2022-05-19 10:22:17 +0200)

----------------------------------------------------------------
EFI updates for v5.19

- Allow runtime services to be re-enabled at boot on RT kernels.
- Provide access to secrets injected into the boot image by CoCo
  hypervisors (COnfidential COmputing)
- Use DXE services on x86 to make the boot image executable after
  relocation, if needed.
- Prefer mirrored memory for randomized allocations.
- Only randomize the placement of the kernel image on arm64 if the
  loader has not already done so.
- Add support for obtaining the boot hartid from EFI on RISC-V.

----------------------------------------------------------------
Ard Biesheuvel (3):
      efi: libstub: pass image handle to handle_kernel_image()
      efi/arm64: libstub: run image in place if randomized by the loader
      efi: stub: prefer mirrored memory for randomized allocations

Baskov Evgeniy (2):
      efi: libstub: declare DXE services table
      efi: libstub: ensure allocated memory to be executable

Dov Murik (4):
      efi: Save location of EFI confidential computing area
      virt: Add efi_secret module to expose confidential computing secrets
      efi: Register efi_secret platform device if EFI secret area is declared
      docs: security: Add secrets/coco documentation

Jan Kiszka (1):
      efi: Add missing prototype for efi_capsule_setup_info

Javier Martinez Canillas (1):
      efi: Allow to enable EFI runtime services by default on RT

Peter Jones (1):
      efi: x86: Set the NX-compatibility flag in the PE header

Sunil V L (1):
      riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL

 Documentation/ABI/testing/securityfs-secrets-coco |  51 ++++
 Documentation/security/index.rst                  |   1 +
 Documentation/security/secrets/coco.rst           | 103 +++++++
 Documentation/security/secrets/index.rst          |   9 +
 arch/x86/boot/header.S                            |   4 +
 arch/x86/include/asm/efi.h                        |   5 +
 arch/x86/platform/efi/efi.c                       |   3 +
 drivers/firmware/efi/Kconfig                      |  43 +++
 drivers/firmware/efi/efi.c                        |  13 +-
 drivers/firmware/efi/libstub/arm32-stub.c         |   3 +-
 drivers/firmware/efi/libstub/arm64-stub.c         |  15 +-
 drivers/firmware/efi/libstub/efi-stub.c           |   2 +-
 drivers/firmware/efi/libstub/efistub.h            |  84 +++++-
 drivers/firmware/efi/libstub/randomalloc.c        |  11 +
 drivers/firmware/efi/libstub/riscv-stub.c         |  32 +-
 drivers/firmware/efi/libstub/x86-stub.c           | 119 +++++++-
 drivers/virt/Kconfig                              |   3 +
 drivers/virt/Makefile                             |   1 +
 drivers/virt/coco/efi_secret/Kconfig              |  16 +
 drivers/virt/coco/efi_secret/Makefile             |   2 +
 drivers/virt/coco/efi_secret/efi_secret.c         | 349 ++++++++++++++++++++++
 include/linux/efi.h                               |  27 ++
 22 files changed, 876 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/ABI/testing/securityfs-secrets-coco
 create mode 100644 Documentation/security/secrets/coco.rst
 create mode 100644 Documentation/security/secrets/index.rst
 create mode 100644 drivers/virt/coco/efi_secret/Kconfig
 create mode 100644 drivers/virt/coco/efi_secret/Makefile
 create mode 100644 drivers/virt/coco/efi_secret/efi_secret.c
