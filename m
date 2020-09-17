Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905F526E912
	for <lists+linux-efi@lfdr.de>; Fri, 18 Sep 2020 00:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgIQWrj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Sep 2020 18:47:39 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54146 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQWrj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Sep 2020 18:47:39 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 18:47:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600382909; x=1631918909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hutlet2njpyeL/sMjQX6Uq1jHOVaORsRpw7WgDF3Mgk=;
  b=irZOEZgeNPOzJyPtJvp1Q0DFnz/2DjS2gWXeNdql2Jtz7FAyimpJZOng
   5AdgPeQIlsVvVEH+TwZxTkYXDDsv/Yu1Bc+TG/Gs4EL1IgN8OvwFowOr1
   Lp3xM7dln2XxbDlJ9Kg9tBJiRmvFwWyVdGFNtK1j65P5WBIO7g6HybjeO
   unPzBcL41tZd2trm7Mw45JP2hlfwzgEFAw+OGlavCdIeqY8VSPwP5Czqo
   1ZyYDT+TGezKime692Bno0ki8O2k/S5+GzbPLG+gWEwIg8y85rWNb+TyI
   9X4thjTK/vDB8YT1iFNvydFpPjgLgDKeQD7pULTnl5WhvNeLsxHk9Pd98
   w==;
IronPort-SDR: PJq9h6zDIULzvwnr8Ieq1dhl+oDsAlBya9/cgEz92PYkeglTsjuCo2VELxtF+nmQOIl8s6iJco
 4bs/zucSpTmBlZYq3B7ckzUPMMHFC5BxZFi45FRVmGoU5nSEHW2w8R70N05rMqjmGeuj9oFF6l
 85c9vVt82x7qgxu8krnA0lWK+SgJHDnS9c3ZOyX/lzdeYo4NZBXp3DrGtNyNGybKm2hc3dEcbz
 zhT5z0242D2rhtJmA+B9oCD02bVBVvXvaW4uxY5X51ErOxXahTUxu9dPUshERVd8JEKL6l7uNp
 /mw=
X-IronPort-AV: E=Sophos;i="5.77,272,1596470400"; 
   d="scan'208";a="251021071"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2020 06:37:53 +0800
IronPort-SDR: yy+kvdbWUm0J2tt1UTBeZ010Ya/HuCPV+0qQcwqnb4xmgy05D8RhsfDmLoYLRmh6Of/n2lgi4c
 Eft6Weu9n/lA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 15:23:50 -0700
IronPort-SDR: yWykapKjvrHxnljwC0B8/iCDlg/TVg2Bib8NUzBqJPFIDLrbpVBsz6wfyBOhzsCAftH8JyS+G2
 ODFBE7Y0TjIQ==
WDCIronportException: Internal
Received: from use204338.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Sep 2020 15:37:36 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v8 0/7] Add UEFI support for RISC-V
Date:   Thu, 17 Sep 2020 15:37:09 -0700
Message-Id: <20200917223716.2300238-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series adds UEFI support for RISC-V.

Linux kernel: v5.9-rc5 
U-Boot: v2020.07 
OpenSBI: master

Patch 1-3 are generic riscv feature addition required for UEFI support.
Patch 4-5 adds the efi stub support for RISC-V which was reviewed few months back.
Patch 6 adds the runtime services for RISC-V.

The working set of patches can also be found in following git repo.
https://github.com/atishp04/linux/tree/uefi_riscv_5.10_v8

@Palmer: I have dropped the following 2 patches from last series (v7)
as this is already part of the shared efi-tree. I am assuming you are pulling
these two from there. The above github tree contains all the patches in order
as per Ard's suggestion.

87a1eeea8e7a include: pe.h: Add RISC-V related PE definition
76fdd4313434 efi: Rename arm-init to efi-init common for all arch

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

Changes from v7->v8:
1. Rebased on latest efi series[1].
2. Fixed efi-header for 32 bit.
3. Included RISC-V tweaks from Ard[2].
4. Removed the 2 patches(pe.h & arm init) from v7 as it is going through efi tree.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
[2] git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git

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

Atish Patra (6):
RISC-V: Add early ioremap support
RISC-V: Implement late mapping page table allocation functions
RISC-V: Add PE/COFF header for EFI stub
RISC-V: Add EFI stub support.
RISC-V: Add EFI runtime services
RISC-V: Add page table dump support for uefi

arch/riscv/Kconfig                        |  25 +++
arch/riscv/Makefile                       |   1 +
arch/riscv/configs/defconfig              |   1 +
arch/riscv/include/asm/Kbuild             |   1 +
arch/riscv/include/asm/efi.h              |  55 +++++++
arch/riscv/include/asm/fixmap.h           |  16 +-
arch/riscv/include/asm/io.h               |   1 +
arch/riscv/include/asm/mmu.h              |   2 +
arch/riscv/include/asm/pgtable.h          |   5 +
arch/riscv/include/asm/sections.h         |  13 ++
arch/riscv/kernel/Makefile                |   2 +
arch/riscv/kernel/efi-header.S            | 111 +++++++++++++
arch/riscv/kernel/efi.c                   |  96 +++++++++++
arch/riscv/kernel/head.S                  |  17 +-
arch/riscv/kernel/head.h                  |   2 -
arch/riscv/kernel/image-vars.h            |  51 ++++++
arch/riscv/kernel/setup.c                 |  18 +-
arch/riscv/kernel/vmlinux.lds.S           |  23 ++-
arch/riscv/mm/init.c                      | 191 ++++++++++++++++------
arch/riscv/mm/ptdump.c                    |  48 +++++-
drivers/firmware/efi/Kconfig              |   3 +-
drivers/firmware/efi/Makefile             |   2 +
drivers/firmware/efi/libstub/Makefile     |  10 ++
drivers/firmware/efi/libstub/efi-stub.c   |  11 +-
drivers/firmware/efi/libstub/riscv-stub.c | 109 ++++++++++++
drivers/firmware/efi/riscv-runtime.c      | 143 ++++++++++++++++
26 files changed, 891 insertions(+), 66 deletions(-)
create mode 100644 arch/riscv/include/asm/efi.h
create mode 100644 arch/riscv/include/asm/sections.h
create mode 100644 arch/riscv/kernel/efi-header.S
create mode 100644 arch/riscv/kernel/efi.c
create mode 100644 arch/riscv/kernel/image-vars.h
create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
create mode 100644 drivers/firmware/efi/riscv-runtime.c

--
2.25.1

