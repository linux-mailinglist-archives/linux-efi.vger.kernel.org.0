Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE69F255F90
	for <lists+linux-efi@lfdr.de>; Fri, 28 Aug 2020 19:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgH1RUq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Aug 2020 13:20:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11687 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgH1RUo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Aug 2020 13:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598635243; x=1630171243;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gHenN6fwJGp5BObIYNPC3TZqcQqp7idU10NNnHU1wyQ=;
  b=UBa1hdG6bp43Mw/CnhECggZqvNZgEnKqtCiEk+4IPyvJx0hotC8TDGkS
   TjFcEdWgZN6Un/QYBEAEz9NjbEnF51zaZjNdkF7j70wv6H5y+7Hs5RX7i
   yC7QqjxxniwvOllTD8/KKUU9d7khrS+gd3rsjkHS8uweZheD0HLQvUEiu
   6m/BQziYBJPQnuJQgxNh75QaJHARVlDZVmAKjYWjHzKkTd6+VeQ4Mmk3P
   d3vbUtIPa3gLfNDrWj6dYqwXMhNlY3uj18nBwdgnjMkZ2z+rYV/jwFGcv
   MLg9DSwqd2s/FhViF4UTlPG1+DFhIsXVVLXUII81TasdpWsicU9T29Anj
   Q==;
IronPort-SDR: fH1d980RkWhep6zBYWJwaTYiIkILA6AOK/v199lCmiB5IlE6eRf1FWnuN9h1ZgQMsa5XPQOXhM
 jAdsqitlHt6KhcVWVZKLvHjSM9xkqdYxxrTZtXczIew/T8CO3zpc5y8dd1Chiq0AY9TWQKy/Lu
 br+2W22PPAXCqnj1cycc/OGaPAnDXu5d0pLyo0WShvPE9/1v1nxZt5FaYpyBKtu5eTtZci/a0k
 einluRzs5J5YA9wp8gekC+jwIW6Wqh7xSO+1wOA1eBlUJVUmK/Ul4Aj4/lZYCh/DQHmwYExIKR
 mro=
X-IronPort-AV: E=Sophos;i="5.76,364,1592841600"; 
   d="scan'208";a="146018507"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Aug 2020 01:20:42 +0800
IronPort-SDR: nSEB2uzb2XynYpNU4eU9WA2NqldtnYuDDcw/LcavM3tCBKKfe07dN5XrkQq3Iex+1aI18RVdqx
 pet5PfEzWA1A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 10:08:14 -0700
IronPort-SDR: ldEYICpeaM843o92uGCkExcLgncDIk+5aq2ei6+za4TuMPcSGbsH5252HtlnN6bcwl8Uf7E4Dj
 xbTV4ZcaT/5A==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.137])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Aug 2020 10:20:41 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v7 0/9] Add UEFI support for RISC-V
Date:   Fri, 28 Aug 2020 10:20:27 -0700
Message-Id: <20200828172036.8056-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series adds UEFI support for RISC-V.

Linux kernel: v5.9-rc2 
U-Boot: v2020.07 
OpenSBI: master

Patch 1-3 are generic riscv feature addition required for UEFI support.
Patch 4-7 adds the efi stub support for RISC-V which was reviewed few months back.
https://www.spinics.net/lists/linux-efi/msg19144.html
Patch 8 just renames arm-init code so that it can be used across different
architectures.
Patch 9 adds the runtime services for RISC-V.

The working set of patches can also be found in following git repo.
https://github.com/atishp04/linux/tree/uefi_riscv_5.10_v7

The patches have been verified on following platforms:
1. Qemu (both RV32 & RV64) for the following bootflow
   OpenSBI->U-Boot->Linux
   EDK2->Linux
2. HiFive unleashed using (RV64) for the following bootflow
   OpenSBI->U-Boot->Linux
   EDK2->Linux

Thanks Abner & Daniel for all work done for EDK2.
The EDK2 instructions are available here.
https://github.com/JohnAZoidberg/riscv-edk2-docker/

Note:
1. Currently, EDK2 RISC-V port doesn't support OVMF package. That's why
EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER should be enabled to load initrd via
commandline until OVMF patches are available.

2. For RV32, maximum allocated memory should be 1G as RISC-V kernel can not map
beyond 1G of physical memory for RV32.

3. Runtime services have been verified with fwts on EDK2.

***********************************************************************
[root@fedora-riscv ~]# fwts uefirtvariable
Running 1 tests, results appended to results.log
Test: UEFI Runtime service variable interface tests.                        
  Test UEFI RT service get variable interface.            1 passed             
  Test UEFI RT service get next variable name interface.  4 passed             
  Test UEFI RT service set variable interface.            7 passed, 1 warning  
  Test UEFI RT service query variable info interface.     1 passed             
  Test UEFI RT service variable interface stress test.    2 passed             
  Test UEFI RT service set variable interface stress t..  4 passed             
  Test UEFI RT service query variable info interface s..  1 passed             
  Test UEFI RT service get variable interface, invalid..  5 passed             
  Test UEFI RT variable services supported status.        1 skipped 

Test           |Pass |Fail |Abort|Warn |Skip |Info |
uefirtvariable |   25|     |     |    1|    1|     |
Total:         |   25|    0|    0|    1|    1|    0|

***********************************************************************

Changes from v6->v7:
1. Fixed build error reported on linux-next for patch2.

Changes from v5->v6:
1. Fixed the static declaration for pt_ops.
2. Added Reviewed/Acked-by.

Changes from v4->v5:
1. Late mappings allocations are now done through function pointers.
2. EFI run time services are verified using full linux boot and fwts using EDK2.

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
arch/riscv/include/asm/efi.h                  |  56 +++++
arch/riscv/include/asm/fixmap.h               |  16 +-
arch/riscv/include/asm/io.h                   |   1 +
arch/riscv/include/asm/mmu.h                  |   2 +
arch/riscv/include/asm/pgtable.h              |   5 +
arch/riscv/include/asm/sections.h             |  13 ++
arch/riscv/kernel/Makefile                    |   5 +
arch/riscv/kernel/efi-header.S                | 104 ++++++++++
arch/riscv/kernel/efi.c                       | 105 ++++++++++
arch/riscv/kernel/head.S                      |  17 +-
arch/riscv/kernel/head.h                      |   2 -
arch/riscv/kernel/image-vars.h                |  51 +++++
arch/riscv/kernel/setup.c                     |  18 +-
arch/riscv/kernel/vmlinux.lds.S               |  22 +-
arch/riscv/mm/init.c                          | 191 +++++++++++++-----
arch/riscv/mm/ptdump.c                        |  48 ++++-
drivers/firmware/efi/Kconfig                  |   3 +-
drivers/firmware/efi/Makefile                 |   4 +-
.../firmware/efi/{arm-init.c => efi-init.c}   |   0
drivers/firmware/efi/libstub/Makefile         |  10 +
drivers/firmware/efi/libstub/efi-stub.c       |  11 +-
drivers/firmware/efi/libstub/riscv-stub.c     | 110 ++++++++++
drivers/firmware/efi/riscv-runtime.c          | 143 +++++++++++++
include/linux/pe.h                            |   3 +
28 files changed, 901 insertions(+), 67 deletions(-)
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

