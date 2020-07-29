Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580CA232827
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jul 2020 01:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgG2Xgy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Jul 2020 19:36:54 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22290 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgG2Xgx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Jul 2020 19:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596065812; x=1627601812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vaQcXC9di+Mc2s5KFNyp48HQd4ruw9ElPp3ceNLFrRM=;
  b=SwH09PYsrvR/wU+kCitloWYsn8qjbgKWU19ELhvbfu8zMuTxFNC7MyWM
   6K8H5ZO9QtM9msTRFPoMDAnSPwdMdtNEkDw00H7G6HeCYgBD3eVgarslL
   NhvF+YWIHnf6LcqdMYgErGb33kn0LeswuEOqzZAwesByBVf7nphk3a4xw
   tbavIXXYTNx1fiZJmdrJGa+w9lMauCZCd4HQ/eAcfh3VlqInoWReZshh1
   i0C3Tws9J6PKbs1C837fqb9bJuBNpishmhL8ZowqdRLpC4vjtJ8D/iCBw
   UTrXmBWHiXFB9NAVX/sGQcKBB4AQCrQhT61xfQ3VQ9I2Ipt06s9WnwewW
   g==;
IronPort-SDR: RA2wGNs+3wMdncVD5prlKtbgNNl4mnHvjWR8SZ82Q5POG/mLvXMcygWrsSNhVvNHxlr29g6WAG
 mTW96UHloXaezCs4r6F99P8wB5qo1Cu4AaxIY6MQxtOULvwEqyX/YwTUl+GdjdIgr39H/nwR3t
 m7HLD0YikvknI25WtI2Jqs8uVjgbF66rOPBN7O9LdpHEYqlTqmXyEQbhl08dSm9IWrkjJzc4TE
 G0t/qpCnWdh18CiLSLlELUOH2xskrTixTfWjmUFF1XctF6W5cVkz974hOFQJM/4eu410Qr7OvF
 W+Q=
X-IronPort-AV: E=Sophos;i="5.75,412,1589212800"; 
   d="scan'208";a="144951782"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2020 07:36:52 +0800
IronPort-SDR: mXSfk/sUruE2z0+OO8PWoyGLLGAVwwwpdBiE/5BnZfXUFAxKoxMbXNMA7gCUaGn6ehd95IRbvE
 kcjjUUTBkPqYBSqGrGX6azmai15Ax3J8o=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 16:24:59 -0700
IronPort-SDR: cAK8YKv/xIcCDLCbQUt9z+oLhL3d8kz5nSiNkpu01AvlXXn7xtw5AUB4sT7uOC4yMr40YkMZMx
 TXsgvfR+HvPg==
WDCIronportException: Internal
Received: from jpf009043.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.210])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jul 2020 16:36:52 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yash Shah <yash.shah@sifive.com>, Zong Li <zong.li@sifive.com>
Subject: [RFT PATCH v4 0/9] Add UEFI support for RISC-V
Date:   Wed, 29 Jul 2020 16:36:26 -0700
Message-Id: <20200729233635.14406-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series adds UEFI support for RISC-V.

Linux kernel: 5.8-rc7 + 1 exception vector setup patch (queued for for-next) 
U-Boot: v2020.07 
OpenSBI: master

This series depends on early setup of exeception vector patch
http://lists.infradead.org/pipermail/linux-riscv/2020-July/001207.html

Patch 1-3 are generic riscv feature addition required for UEFI support.
Patch 4-7 adds the efi stub support for RISC-V which was reviewed few months back.
https://www.spinics.net/lists/linux-efi/msg19144.html
Patch 8 just renames arm-init code so that it can be used across different
architectures. Patch 11 adds the runtime services for RISC-V.

The working set of patches can also be found in following git repo.
https://github.com/atishp04/linux/tree/uefi_riscv_5.9_v4

The patches have been verified on Qemu/HiFive unleashed using bootefi command in
U-Boot for both RV32 and RV64.

For RV32, maximum allocated memory should be 1G as RISC-V kernel can not map
beyond 1G of physical memory for RV32.

Runtime services have been verified with fwts. Here is the snippet of the result.

***********************************************************************
This test run on 16/07/20 at 17:54:53 on host Linux fedora-riscv
5.8.0-rc5-00015-g5e61441080fd-dirty #938 SMP Thu Jul 16 14:50:11 PDT 2020
riscv64.

Command: "fwts uefirtvariable".
Running tests: uefirtvariable.

uefirtvariable: UEFI Runtime service variable interface tests.
Test 1 of 9: Test UEFI RT service get variable interface.
SKIPPED: Test 1, Skipping test, SetVariable runtime service is not supported on
this platform.

Test 2 of 9: Test UEFI RT service get next variable name interface.
The runtime service GetNextVariableName interface function test.
SKIPPED: Test 2, Skipping test, SetVariable runtime service is not supported on
this platform.

...

Test 4 of 9: Test UEFI RT service query variable info interface.
SKIPPED: Test 4, Not support the QueryVariableInfo UEFI runtime interface:
cannot test.

ADVICE: Firmware also needs to check if the revision of system table is correct
or not. Linux kernel returns EFI_UNSUPPORTED as well, if the FirmwareRevision of
system table is less than EFI_2_00_SYSTEM_TABLE_REVISION.

...
***********************************************************************

Currently, U-Boot EFI implementation returns EFI_UNSUPPORTED for set_variable
service. That's why all tests have been skipped but I manually verified that the
value is returned from U-Boot not kernel :).

EDK2 can boot quite far into Linux with the current series. However, it crashes
before userspace because of a possible memory corruption by EDK2.

Changes from v3->v4:
1. Used pgd mapping to avoid copying DT to bss.

Changes from v2->v3:
1. Fixed few bugs in run time services page table mapping.
2. Dropped patch 1 as it is already taken into efi-tree.
3. Sent few generic mmu fixes as a separate series to ease the merge conflicts.

Changes from v1->v2:
1. Removed patch 1 as it is already taken into efi-tree.
2. Fixed compilation issues with patch 9.
3. Moved few function prototype declaration to header file to keep kbuild happy.

Changes from previous version:
1. Added full ioremap support.
2. Added efi runtime services support.
3. Fixes mm issues

Anup Patel (1):
RISC-V: Move DT mapping outof fixmap

Atish Patra (8):
RISC-V: Add early ioremap support
RISC-V: Implement late mapping page table allocation functions
include: pe.h: Add RISC-V related PE definition
RISC-V: Add PE/COFF header for EFI stub
RISC-V: Add EFI stub support.
efi: Rename arm-init to efi-init common for all arch
RISC-V: Add EFI runtime services
RISC-V: Add page table dump support for uefi

arch/riscv/Kconfig                            |  25 +++
arch/riscv/Makefile                           |   1 +
arch/riscv/configs/defconfig                  |   1 +
arch/riscv/include/asm/Kbuild                 |   1 +
arch/riscv/include/asm/efi.h                  |  56 +++++++
arch/riscv/include/asm/fixmap.h               |  16 +-
arch/riscv/include/asm/io.h                   |   1 +
arch/riscv/include/asm/mmu.h                  |   2 +
arch/riscv/include/asm/pgtable.h              |   5 +
arch/riscv/include/asm/sections.h             |  13 ++
arch/riscv/kernel/Makefile                    |   5 +
arch/riscv/kernel/efi-header.S                | 104 +++++++++++++
arch/riscv/kernel/efi.c                       | 105 +++++++++++++
arch/riscv/kernel/head.S                      |  17 ++-
arch/riscv/kernel/head.h                      |   2 -
arch/riscv/kernel/image-vars.h                |  51 +++++++
arch/riscv/kernel/setup.c                     |  17 ++-
arch/riscv/kernel/vmlinux.lds.S               |  22 ++-
arch/riscv/mm/init.c                          |  90 ++++++++---
arch/riscv/mm/ptdump.c                        |  48 +++++-
drivers/firmware/efi/Kconfig                  |   3 +-
drivers/firmware/efi/Makefile                 |   4 +-
.../firmware/efi/{arm-init.c => efi-init.c}   |   0
drivers/firmware/efi/libstub/Makefile         |  10 ++
drivers/firmware/efi/libstub/efi-stub.c       |  11 +-
drivers/firmware/efi/libstub/riscv-stub.c     | 110 ++++++++++++++
drivers/firmware/efi/riscv-runtime.c          | 143 ++++++++++++++++++
include/linux/pe.h                            |   3 +
28 files changed, 825 insertions(+), 41 deletions(-)
create mode 100644 arch/riscv/include/asm/efi.h
create mode 100644 arch/riscv/include/asm/sections.h
create mode 100644 arch/riscv/kernel/efi-header.S
create mode 100644 arch/riscv/kernel/efi.c
create mode 100644 arch/riscv/kernel/image-vars.h
rename drivers/firmware/efi/{arm-init.c => efi-init.c} (100%)
create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
create mode 100644 drivers/firmware/efi/riscv-runtime.c

--
2.24.0

