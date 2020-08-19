Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE6124A94A
	for <lists+linux-efi@lfdr.de>; Thu, 20 Aug 2020 00:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHSWYf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Aug 2020 18:24:35 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15990 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgHSWYc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Aug 2020 18:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597875871; x=1629411871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eWwpsArXfSQictHdS/cKLHfYwlV65jMBjNE1uTO8rAI=;
  b=IIbZbOpohy/1dfGK/Lgc6bBZ/Kl07tCYrAxci2YnViNmv0lFu8YoVRIB
   i1PibOwyl6vb1PqxBHXjvQyXS4CoXxujrG2qdNxtFarnCcRudS8/UaaHe
   Sg4k04uDGLAfSLqX3UGl731kHo37Qv9Oafu5ovGjwWDT3/1992vbQQ6M0
   AueDSRSHZTb/s5dNPd34OjJRKXauoNvSRGxPGe6tLb36yvrwFJLeNoJXC
   o4m6TGGokc1gXqQ2PYW3UibdC0uYAG8CF4a2qkXwCc6Xs4hkv/CmawDhP
   WcODTLJnfP8j2teJY5oy6Eh1eOD3HuwgneBSZYwK3sWJktBmItHD4Togs
   A==;
IronPort-SDR: iG1nNYLWh7ZZdUo4TB2CwaxMfWaEmmnEnCbiTXDdCJhT2BMLJdZxrluZrV5GTSZ07mEiVHxFEd
 FE688iNoRXGmFlHkspeR6QGk83LRdhWPll9UWF9jPe73eApQRUFz2KoDACxRM18L0Tu30X88QR
 snos5j7ldyMb5OMqHLrdsYJPMV2POWm0SH1pRPeHY4NZUswQZw5ofTlFBmi7NpBkMYffpuIozx
 V/q9wu8tqRejnMSRXWn0lmN+knfA8nlgJo4pNlMG6f4lyo+gPzQArSm6Qonb4l/2qiQE/IYope
 0Fc=
X-IronPort-AV: E=Sophos;i="5.76,332,1592841600"; 
   d="scan'208";a="145373585"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2020 06:24:31 +0800
IronPort-SDR: 02+bPEgon9walzySJ8oi0n0/8I0EjVDBDvbDDfy/hB3OgZMu6Fe7kq3fq/Ts9dJs4Su26SX7Ge
 y4VCYJOllmDw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 15:12:12 -0700
IronPort-SDR: 57FbsZD1SuHW+NPD4Zva8bPTxiF4OLrT3VgeXT0oyZuBFmQXJk+3hkhEDpKoOf/8dh0huR1ohL
 6k4PDPiiwPjQ==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Aug 2020 15:24:29 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Price <steven.price@arm.com>,
        Waiman Long <longman@redhat.com>, Zong Li <zong.li@sifive.com>,
        Daniel Schaefer <daniel.schaefer@hpe.com>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>
Subject: [PATCH v6 0/9] Add UEFI support for RISC-V
Date:   Wed, 19 Aug 2020 15:24:16 -0700
Message-Id: <20200819222425.30721-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series adds UEFI support for RISC-V.

Linux kernel: v5.9-rc1 
U-Boot: v2020.07 
OpenSBI: master

Patch 1-3 are generic riscv feature addition required for UEFI support.
Patch 4-7 adds the efi stub support for RISC-V which was reviewed few months back.
https://www.spinics.net/lists/linux-efi/msg19144.html
Patch 8 just renames arm-init code so that it can be used across different
architectures.
Patch 9 adds the runtime services for RISC-V.

The working set of patches can also be found in following git repo.
https://github.com/atishp04/linux/tree/uefi_riscv_5.10_v6

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
arch/riscv/kernel/setup.c                     |  17 +-
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
28 files changed, 900 insertions(+), 67 deletions(-)
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

