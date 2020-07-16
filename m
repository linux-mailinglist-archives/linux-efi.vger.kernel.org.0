Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F69222F33
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jul 2020 01:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgGPXlO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Jul 2020 19:41:14 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7103 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgGPXlO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Jul 2020 19:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594942873; x=1626478873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kUG/HMv0nJnrst7Sns7/AKTyFHl/1SzBX+Bwh+vDZlA=;
  b=DXKhZvSzvdjqPO4+0A0rP0JIMG6ednvd3evyD2Rtm0BMQN+8FS5MXGin
   8RsHg5lQ+Fm8eJKffegxu902JUd0IrJvgk5DWXp6itR4n4dxxQn85Kits
   AlddwWgWUMcuWnlihW/MpAFrFwMPAEx0hPTv866zyBv1kk5i+1hAcow0n
   FNpcK4BEUnLB7MuWac1QBGM3TF+9abWDxxpDfTnJVPdOFSNuJSXjLQh2m
   tjVb/rM+sST8WDcwp+Y007Rlo08v6vqdjSSMUOblDTDLyD12iNqZBbpfg
   5aas2w8Nsc1frh6zLrXMSL5w0vqIq0/EnYtGWFn1AvIqCUxPEgGRJ6cDL
   w==;
IronPort-SDR: BLhPbpJhfWM0mZ2AZCcrovvwpscdA0fJAKvWT/ZtjSdVkLEF/JgT16fbV2WpnnuV9myM5+JKS2
 ygLucAWc0G1LZGWwTJkn7uPfi/qvPFsxGj+AodjehVEah2QXDOk1xB9S/FM607JrdMC3+IlR5R
 /hZ+hBp09C3tMWut3A2jgtC4KQCmMfynHoGSiMvoiC28O/qDa1QXp0ZMtROy5Fn9ZK+WfUnxc7
 LVSMbKMc8pZ45vowO8EMpWvJN7BhIuJ/sAUYxRRNa049L8CRgoQoNUQIXB4H/lhUhnSQNHVoSv
 mmk=
X-IronPort-AV: E=Sophos;i="5.75,360,1589212800"; 
   d="scan'208";a="251923186"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 07:41:12 +0800
IronPort-SDR: Liner50EOfzMCfDauaVqS+LtS1USImzG17ygi0nCB7H+zerUnOw3tm6oUtnUU/lsdHbF/2lGyD
 li60ZYIjb5tWi5yPE2P4g6SYJhdZEq46o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 16:29:36 -0700
IronPort-SDR: 2hT8GNbz2MtsskMAQMxU6lttS0NTqNVxNsn5ZJD2clmQGd0fWs1xQw22jaruo3+STJ4pgyDaD0
 otrAU2Kc14/Q==
WDCIronportException: Internal
Received: from phd004806.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.54])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2020 16:41:12 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFT PATCH v3 0/9] Add UEFI support for RISC-V
Date:   Thu, 16 Jul 2020 16:40:55 -0700
Message-Id: <20200716234104.29049-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series adds UEFI support for RISC-V.

Linux kernel: 5.8-rc5 + "mm & exception handing fixes" series
U-Boot: master
OpenSBI: master

This series depends on earlier mm fixes series

http://lists.infradead.org/pipermail/linux-riscv/2020-July/001208.html

Patch 1-3 are generic riscv feature addition required for UEFI support.
Patch 4-7 adds the efi stub support for RISC-V which was reviewed few months back.
https://www.spinics.net/lists/linux-efi/msg19144.html
Patch 8 just renames arm-init code so that it can be used across different
architectures. Patch 11 adds the runtime services for RISC-V.

The working set of patches can also be found in following git repo.
https://github.com/atishp04/linux/tree/uefi_riscv_5.9_v3

The patches have been verified on Qemu using bootefi command in U-Boot for both
RV32 and RV64.

For RV32, maximum allocated memory should be 1G as RISC-V kernel can not map
beyond 1G of physical memory for RV32.

EDK2 can boot quite far into Linux with current series. Currently, we are seeing
some traps from drivers (spi/network). At first glance, they don't seem to be
caused by efi. I thought it is better to get some early feedback on the series
while EDK2 issue is being debugged.

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
service. That's why all tests have been skipped but I manually verified the value
returned from U-Boot not kernel :).

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
arch/riscv/include/asm/pgtable.h              |   4 +
arch/riscv/include/asm/sections.h             |  13 ++
arch/riscv/kernel/Makefile                    |   5 +
arch/riscv/kernel/efi-header.S                | 104 +++++++++++++
arch/riscv/kernel/efi.c                       | 105 +++++++++++++
arch/riscv/kernel/head.S                      |  17 ++-
arch/riscv/kernel/head.h                      |   2 -
arch/riscv/kernel/image-vars.h                |  51 +++++++
arch/riscv/kernel/setup.c                     |  16 +-
arch/riscv/kernel/vmlinux.lds.S               |  22 ++-
arch/riscv/mm/init.c                          | 100 ++++++++----
arch/riscv/mm/ptdump.c                        |  48 +++++-
drivers/firmware/efi/Kconfig                  |   3 +-
drivers/firmware/efi/Makefile                 |   4 +-
.../firmware/efi/{arm-init.c => efi-init.c}   |   0
drivers/firmware/efi/libstub/Makefile         |  10 ++
drivers/firmware/efi/libstub/efi-stub.c       |  11 +-
drivers/firmware/efi/libstub/riscv-stub.c     | 110 ++++++++++++++
drivers/firmware/efi/riscv-runtime.c          | 143 ++++++++++++++++++
include/linux/pe.h                            |   3 +
28 files changed, 823 insertions(+), 51 deletions(-)
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

