Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEAB20A955
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 01:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgFYXpZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jun 2020 19:45:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4086 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgFYXpY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Jun 2020 19:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593128724; x=1624664724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Actmweta7JvIwPn5FyNaOGyF4xBrvFSmD2/FxpPF7ts=;
  b=VMc8+WE9VNDVVYSRkXje08MZLWr/w/9GTTAHFXzHuT9vcwu1Xt9vlDGF
   wF7rzZ29BLunQgqEnmvCK2jwaF0j/NBt9cVFmk8YXOcVIbf0FTwyH/aSW
   oELe0MNCvW32TcdeePznEbH1lJP2ABjx2sRTeD3LvpSToyc7VEQbnRziX
   ktS2huqmvQ9rIIMaFgeCBEm2180+ooZxAa1q//eKZ2y82U8cInh3AxafV
   2URijwP60vKgNCx9MQ0UN2xEuVCdgA5dTZhKNtJSL2LRuT1M2VKiQzA0r
   4lSQCciSYaHa4l6LqMUPjSzXcCip371oEDwHHXDLwSFZthEWmEXmGLRrO
   Q==;
IronPort-SDR: JbMCBM2U24szDJY6013z8ROl0fTEbKJiNCxKiqgKDqG/cO1a63rO0NL6QjmXRj5CMVdql7uAum
 8dUvL4p4k1DSZC8RgBEwku/K+bwuIyqq3YTz/dQfNNeBq21ylV3cVsfpXXOmHm2Qtn8VvV/hXs
 7n90ccnJzrLlbvVeizbNdE8TtH4rQOo1yj0CWHg8bbD/UCMDS+ClS3cMOLVQzuyAKXpkmEpf8R
 km7ldO0tdM+3cq6opEV5d3cCrp6lHdOY9lx/n7EtZvQOu7fkeNV6uEKzlXQF5qciggAGvahbBI
 Owc=
X-IronPort-AV: E=Sophos;i="5.75,280,1589212800"; 
   d="scan'208";a="140953448"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 07:45:23 +0800
IronPort-SDR: 6txmzN/XMSSOni5X/OXHHl9EeR0964XCfR29t5BcTia6jWNTq0zHMKtj3AnuClUKjdVUCwMfmI
 gRYbiHrXcbcf1JUE30qtBq/gF8Kp/s6QU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 16:34:23 -0700
IronPort-SDR: FXpnazvcnQ8cmE9w2UPNHENcSiBq+pwdMl3n1nIRzHJWRPIAQ/SqZrnrr12Upi1JF6ROlOt85K
 Cly+SYaDK0nw==
WDCIronportException: Internal
Received: from 2349pbt5e4f.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.78])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2020 16:45:23 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 00/11] Add UEFI support for RISC-V 
Date:   Thu, 25 Jun 2020 16:45:05 -0700
Message-Id: <20200625234516.31406-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series adds UEFI support for RISC-V.

Linux kernel: 5.8-rc2
U-Boot: master
OpenSBI: master

Patch 1-6 are preparatory patches that fixes some of the geric efi and riscv issues.

Patch 7-9 adds the efi stub support for RISC-V which was reviewed few months back.
http://lists.infradead.org/pipermail/linux-riscv/2020-April/009586.html

Patch 10 just renames arm-init code so that it can be used across different
architectures. Patch 11 adds the runtime services for RISC-V.

The patches can also be found in following git repo.
https://github.com/atishp04/linux/tree/uefi_riscv_5.9_v1

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

Changes from previous version:
1. Added full ioremap support. 
2. Added efi runtime services support. 
3. Fixes mm issues

Anup Patel (1):
RISC-V: Move DT mapping outof fixmap

Atish Patra (10):
efi: Fix gcc error around __umoddi3 for 32 bit builds
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
drivers/firmware/efi/libstub/alignedmem.c     |   2 +-
drivers/firmware/efi/libstub/efi-stub.c       |  11 +-
drivers/firmware/efi/libstub/riscv-stub.c     | 110 ++++++++++++++
drivers/firmware/efi/riscv-runtime.c          | 141 ++++++++++++++++++
include/linux/pe.h                            |   3 +
31 files changed, 796 insertions(+), 66 deletions(-)
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

