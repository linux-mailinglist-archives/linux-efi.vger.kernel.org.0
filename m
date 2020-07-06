Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABF5215D28
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jul 2020 19:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgGFR1O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jul 2020 13:27:14 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41526 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgGFR0g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jul 2020 13:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594056421; x=1625592421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZPLqLkRmreTTViDZafKeWTDt0ftxitDjgDKfBWiyQY4=;
  b=DtbyC8OhDAu02Mbeupbror+DSECYI03Y6q6zP5BrjVIQ2mYp27rOzhrC
   t7T1EsDqFHgO2zuYRJIxCHJi52Pm2aUpGEoRUfC/7h+WXxVLjJhzHcop6
   BAaFwgryDr56pVRWeJOKpg3twwbqs55Af0evQYmJYWVQVqI79emAT43iR
   pw6rAlO1IuE325hw+YaDbuUtGonAGGP8l7qN770KK+LxqNqbAMhQAkz7W
   y8Scvy+i05xkqPnkcO+UfTUFgsvEkDYdUFVjsdkeL/u37j1XJ1S8//wLq
   H0jlpXX/Mv7DRaAIxeGXEfPiaRf4mP5EK9XIot3y8ERYXXyd48EIAkWP3
   Q==;
IronPort-SDR: zuzS76c8cbWqSrIkGzeTNTEIM2hVT38Jfr0PwG+hE4g5WpItxscdrvMtYaI6lha52gF24gxw7v
 XPdF1HrN1q/4IQkmig/ySyBJHLeU32mI7BqyfdOvnSmjarLLO4152Iw6rGs375SeZIkv98tC7W
 9AcfZEH+dclhHvaSKqdhefsQsaoDjOAPLD+r9CPFfV4mcLo5MAqGI1HhTpH5VruaiYMks/NycQ
 yLl+9ND07BscULYDeQ1znFe93Sh5NJdLH2hXNHf1YE6Qb1ZJYjFqE50cG+lBA94vwA8Pi6ZLWR
 S+A=
X-IronPort-AV: E=Sophos;i="5.75,320,1589212800"; 
   d="scan'208";a="244770170"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 01:26:50 +0800
IronPort-SDR: earXIZJp3BczxZ3B2w9wcUfKuYF7FKw72BvGxwLGpaXh15AdfTlMBiQiofHb2aecwYxzlRUc3x
 +b+X6/m5rkLVaI9EhmkyWrENV0ZxJDbd0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 10:14:37 -0700
IronPort-SDR: V8HiVNZoUcDsr9kkXV5f0VaUWHVCf3R8abrkby7eWCdFWxsmdW292u67WeRT3k8PV66FGKa2H2
 pfjT6DtMXfaA==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.57.161])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2020 10:26:29 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH v2 00/11] Add UEFI support for RISC-V 
Date:   Mon,  6 Jul 2020 10:25:58 -0700
Message-Id: <20200706172609.25965-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series adds UEFI support for RISC-V.

Linux kernel: 5.8-rc4
U-Boot: master
OpenSBI: master

Patch 1-6 are preparatory patches that fixes some of the geric efi and riscv issues.

Patch 7-9 adds the efi stub support for RISC-V which was reviewed few months back.
https://www.spinics.net/lists/linux-efi/msg19144.html

Patch 10 just renames arm-init code so that it can be used across different
architectures. Patch 11 adds the runtime services for RISC-V.

The patches can also be found in following git repo.
https://github.com/atishp04/linux/tree/uefi_riscv_5.9_v2

The patches have been verified on Qemu using bootefi command in U-Boot for both
RV32 and RV64.

For RV32, maximum allocated memory should be 1G as RISC-V kernel can not map
beyond 1G of physical memory for RV32.

EDK2 can boot quite far into Linux with current series. Currently, we are seeing
some traps from drivers (spi/network). At first glance, they don't seem to be
caused by efi. I thought it is better to get some early feedback on the series
while EDK2 issue is being debugged.

That's why uefi runtime services are not actually well tested in RISC-V.
Any suggestions to test the efi run time services are appreciated. 

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

Atish Patra (10):
efi/libstub: Move the function prototypes to header file
RISC-V: Setup exception vector early
RISC-V: Add early ioremap support
RISC-V: Set maximum number of mapped pages correctly
riscv: Parse all memory blocks to remove unusable memory
include: pe.h: Add RISC-V related PE definition
RISC-V: Add PE/COFF header for EFI stub
RISC-V: Add EFI stub support.
efi: Rename arm-init to efi-init common for all arch
RISC-V: Add EFI runtime services

arch/riscv/Kconfig                            |  25 ++++
arch/riscv/Makefile                           |   1 +
arch/riscv/configs/defconfig                  |   1 +
arch/riscv/include/asm/Kbuild                 |   1 +
arch/riscv/include/asm/efi.h                  |  56 +++++++
arch/riscv/include/asm/fixmap.h               |  16 +-
arch/riscv/include/asm/io.h                   |   1 +
arch/riscv/include/asm/mmu.h                  |   2 +
arch/riscv/include/asm/pgalloc.h              |  12 ++
arch/riscv/include/asm/pgtable.h              |   4 +
arch/riscv/include/asm/sections.h             |  13 ++
arch/riscv/kernel/Makefile                    |   5 +
arch/riscv/kernel/efi-header.S                | 104 +++++++++++++
arch/riscv/kernel/efi.c                       | 106 +++++++++++++
arch/riscv/kernel/head.S                      |  27 +++-
arch/riscv/kernel/head.h                      |   2 -
arch/riscv/kernel/image-vars.h                |  51 +++++++
arch/riscv/kernel/setup.c                     |  16 +-
arch/riscv/kernel/smpboot.c                   |   1 -
arch/riscv/kernel/traps.c                     |   8 +-
arch/riscv/kernel/vmlinux.lds.S               |  22 ++-
arch/riscv/mm/init.c                          | 104 ++++++++-----
drivers/firmware/efi/Kconfig                  |   3 +-
drivers/firmware/efi/Makefile                 |   4 +-
.../firmware/efi/{arm-init.c => efi-init.c}   |   0
drivers/firmware/efi/libstub/Makefile         |  10 ++
drivers/firmware/efi/libstub/efi-stub.c       |  28 ++--
drivers/firmware/efi/libstub/efistub.h        |  16 ++
drivers/firmware/efi/libstub/riscv-stub.c     | 110 ++++++++++++++
drivers/firmware/efi/riscv-runtime.c          | 141 ++++++++++++++++++
include/linux/pe.h                            |   3 +
31 files changed, 811 insertions(+), 82 deletions(-)
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

