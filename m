Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D931B4B96
	for <lists+linux-efi@lfdr.de>; Wed, 22 Apr 2020 19:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgDVRYg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Apr 2020 13:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbgDVRYf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 22 Apr 2020 13:24:35 -0400
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73B2120776;
        Wed, 22 Apr 2020 17:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587576275;
        bh=2Af0d9nbT5I1O4V4xc2Dg3F6cePg+ZwzJ43ReJokLcs=;
        h=From:To:Cc:Subject:Date:From;
        b=1LkadNPxSocPKyLj1tMqlJmeuKBzyXNIUq53b4G0mj7j1VV9z9JgZlX8EOQNCfvcx
         lxDObewwcIgdmCzOHyJKFcoyP8ocZXPSBepbvga8ZrSj24lCl2Clvae2pMYAgvI7Cn
         /lxibqDF1iQo3Nl5eCyZKdimvmshN3gdgHd0EO+4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 0/7] Add UEFI support for RISC-V
Date:   Wed, 22 Apr 2020 19:24:07 +0200
Message-Id: <20200422172414.6662-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is a rework of Atish's series [0] to add EFI stub loader support
to the RISC-V port. The purpose is to split the code in a way that makes
it amenable to being merged via different trees during the same cycle.
While at it, I added a patch to disable initrd= loading for new ports,
given that it is deprecated and replaced with a method based on a 
special UEFI device path.

My changes are logged in the individual patches.

I propose to take the first four patches via the EFI tree, and expose
them via a stable tag so that the RISC-V maintainers can merge it before
applying the remaining patches. That will ensure that both trees remain
in a buildable state, with working EFI stub support on the riscv branch.

Cc: Atish Patra <atish.patra@wdc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org

Ard Biesheuvel (1):
  efi/libstub: Make initrd file loader configurable

Atish Patra (6):
  efi/libstub: Move arm-stub to a common file
  efi/libstub/riscv: add arch specific efi.h header file
  include: pe.h: Add RISC-V related PE definition
  RISC-V: Define fixmap bindings for generic early ioremap support
  RISC-V: Add PE/COFF header for EFI stub
  RISC-V: Add EFI stub support.

 arch/arm/Kconfig                              |   2 +-
 arch/arm64/Kconfig                            |   2 +-
 arch/riscv/Kconfig                            |  21 ++++
 arch/riscv/Makefile                           |   1 +
 arch/riscv/configs/defconfig                  |   1 +
 arch/riscv/include/asm/Kbuild                 |   1 +
 arch/riscv/include/asm/efi.h                  |  41 +++++++
 arch/riscv/include/asm/fixmap.h               |  18 +++
 arch/riscv/include/asm/io.h                   |   1 +
 arch/riscv/include/asm/sections.h             |  13 +++
 arch/riscv/kernel/Makefile                    |   4 +
 arch/riscv/kernel/efi-header.S                | 100 ++++++++++++++++
 arch/riscv/kernel/head.S                      |  16 +++
 arch/riscv/kernel/image-vars.h                |  53 +++++++++
 arch/riscv/kernel/vmlinux.lds.S               |  22 +++-
 drivers/firmware/efi/Kconfig                  |  15 ++-
 drivers/firmware/efi/libstub/Makefile         |  22 +++-
 .../efi/libstub/{arm-stub.c => efi-stub.c}    |   0
 drivers/firmware/efi/libstub/file.c           |   3 +
 drivers/firmware/efi/libstub/riscv-stub.c     | 109 ++++++++++++++++++
 include/linux/pe.h                            |   3 +
 21 files changed, 436 insertions(+), 12 deletions(-)
 create mode 100644 arch/riscv/include/asm/efi.h
 create mode 100644 arch/riscv/include/asm/sections.h
 create mode 100644 arch/riscv/kernel/efi-header.S
 create mode 100644 arch/riscv/kernel/image-vars.h
 rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (100%)
 create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c

-- 
2.17.1

