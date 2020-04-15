Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538BE1AB221
	for <lists+linux-efi@lfdr.de>; Wed, 15 Apr 2020 21:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406363AbgDOTyo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Apr 2020 15:54:44 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:22134 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406078AbgDOTyl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Apr 2020 15:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586980480; x=1618516480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hhsd5JtwPM12DYmkDLyIy4E1RXRHsLoMVadetZOBWkA=;
  b=PMuRmvfYHNO+RITsw6TNQsObAwRNSoFctkwCitYukUtSRiwzkvobMJv8
   J369MkZXlMuVGr2mTq6rxqJTPgwHjjfw18mW2CVyetTc8Q9zDWVqo3qPk
   cidIYu3Fztozb1fJ1a8GBQR2v+PHPv4zJJFTVFsZF87l+xi+CVs34fhGI
   fIWBg4dXEQAFydi/auRU7U54r5+ewlbWc14X1GYrMqAAs6CrlJRx9Ov6y
   92GsQowoe7Vz5Wh3uWmX8cjzdw+xu0LZaYQu+KK9RyTUl7EuVTOVIOvVo
   kCPNgkl75YUc5TnJRYOn1Mch5g9MNgJ9g5TZbTK+JWuIyPBHT9S5eAQ18
   w==;
IronPort-SDR: HskfMLuEx+gW50VLbJ+A5FzSC8/DAh+CCZNzhTgr5Fqos7Y6H4SeAqp6JazVt2kASw9ZT9pYf/
 5a80S2vnjBkThuHpoGezCEaY50LzrtvPWV/2f8+Q0oDfI35540wfOQcYKTZf+18ruvLlvv33/T
 zcwSpFhV5kBTKbyuIC+zBQqbORrOa8VEhMqkb2BIHOiNIeldhYlky4pmqOmWRLUVFyoZAk3kI3
 ZwSblBkfyBQOwOmxqeVbPKC6axRzIENe6cOgap+gQB7NdCLPokxkz4iSRI3BkmgE500zrUxW5z
 maM=
X-IronPort-AV: E=Sophos;i="5.72,388,1580745600"; 
   d="scan'208";a="244077013"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2020 03:54:40 +0800
IronPort-SDR: +8G22lKOTSnisZhBia4e6azOMqzIMditu1TTMSrqnkU+/vRV+D9j0O/iYJZZE6KmRCZEdjKB39
 ceTGljag/zDFgNQC9gP3W76t95Z3UyRnExxm/ge32n644K2hjgG5rIZNzWcMm+Y4n1b1ORoJLn
 0uC8arGR6sPPd4MMqXWax1UHIi2W1Xi3iCOgrQDgBak+zgpUHzcypXj/4ROr5bD1+eb6F6j6+T
 Fkt2Z1urYEyVdkOgVgwnO2x50TF/a6FJaiSxZKPOZTjKwOmmieXgvnuBVgPzhq4eYLi8hGnxgF
 GaHCnrG+QDCQAjyeGwIIcNE7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 12:45:08 -0700
IronPort-SDR: 4zlsxO4RkiT45OqVEJZYxpJPZzqj8CHvYmVLBNY/LOdQ/H1G/eqCmGl6vWjLtcH/tZit8rvf9J
 3aFsTlvTIsX7uIXQdsIdo/fQ9/h1tfKL0xL/VLUA3vNjnRRrMxDZaBvmtRYEhOr+bcfj6+MCCz
 vsLlTP/3jLqHirySbTVKexPEbPGYOsyPp/IxkyeNtxS4lYDy8Q2cZ04nxyld0tycqO98l7YVMa
 13g6swKV44qzSYs9xfv8RAswec9tgjPOMdSiHURxJubnXqxlvi0eVTjp9IaQ/mYo3U4DBwhFV/
 Dt8=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.55.244])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2020 12:54:40 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
Subject: [v3 PATCH 0/5] Add UEFI support for RISC-V 
Date:   Wed, 15 Apr 2020 12:54:17 -0700
Message-Id: <20200415195422.19866-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series adds UEFI support for RISC-V. Currently, only boot time
services have been added. Runtime services will be added in a separate
series. This series depends on some core EFI patches
present in current in efi-next and following other patches.

U-Boot: Adds the boot hartid under chosen node.
https://lists.denx.de/pipermail/u-boot/2020-April/405726.html

Linux kernel: 5.7-rc1

OpenSBI: master

Patch 1 just moves arm-stub code to a generic code so that it can be used
across different architecture.

Patch 3 adds fixmap bindings so that CONFIG_EFI can be compiled and we do not
have create separate config to enable boot time services. 
As runtime services are not enabled at this time, full generic early ioremap
support is also not added in this series.

Patch 4 and 5 adds the PE/COFF header and EFI stub code support for RISC-V
respectively.

The patches can also be found in following git repo.

https://github.com/atishp04/linux/tree/wip_uefi_riscv_v3

The patches have been verified on Qemu using bootefi command in U-Boot.

Changes from v2->v3:
1. Rebased on top of latest efi patches.
2. Improved handle_kernel_image().

Changes from v1->v2:
1. Rebased on 5.7-rc1.
2. Fixed minor typos and removed redundant macros/comments.

Changes from previous version:
1. Renamed to the generic efi stub macro.
2. Address all redundant comments.
3. Supported EFI kernel image with normal booti command.
4. Removed runtime service related macro defines.

Atish Patra (5):
efi: Move arm-stub to a common file
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
arch/riscv/include/asm/efi.h                  |  44 +++++++
arch/riscv/include/asm/fixmap.h               |  18 +++
arch/riscv/include/asm/io.h                   |   1 +
arch/riscv/include/asm/sections.h             |  13 ++
arch/riscv/kernel/Makefile                    |   4 +
arch/riscv/kernel/efi-header.S                |  99 ++++++++++++++++
arch/riscv/kernel/head.S                      |  16 +++
arch/riscv/kernel/image-vars.h                |  53 +++++++++
arch/riscv/kernel/vmlinux.lds.S               |  20 +++-
drivers/firmware/efi/Kconfig                  |   4 +-
drivers/firmware/efi/libstub/Makefile         |  19 ++-
.../efi/libstub/{arm-stub.c => efi-stub.c}    |   0
drivers/firmware/efi/libstub/riscv-stub.c     | 111 ++++++++++++++++++
include/linux/pe.h                            |   3 +
20 files changed, 421 insertions(+), 12 deletions(-)
create mode 100644 arch/riscv/include/asm/efi.h
create mode 100644 arch/riscv/include/asm/sections.h
create mode 100644 arch/riscv/kernel/efi-header.S
create mode 100644 arch/riscv/kernel/image-vars.h
rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (100%)
create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c

--
2.24.0

