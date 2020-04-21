Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882841B1CE1
	for <lists+linux-efi@lfdr.de>; Tue, 21 Apr 2020 05:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgDUDel (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Apr 2020 23:34:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10948 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDUDel (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Apr 2020 23:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587440080; x=1618976080;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GjTTpLTWGYCXUfvIMno62LIuH07aVZwFi+V4pOUKReY=;
  b=KlMSVnww91RsPRjUUOOCA5h2LHw8X6zNMP9oo0tyL9r3LLPuUwv8CBDz
   F4hipMV+Yx3vX/7Irt2pm4gZ7fLVjAZ2XJ521oCTqBoEFHWCLp2yoLE3p
   ojFF/drVZX9Md+HARFy0YGgBeG4Kmn8PWhu6T9aWbkP90QiJJjkUU8Zdz
   kl0emXrCFdUhThyD77cLme+U4LEaBLuhcaaMpIUgKuQ4S8F9+IYXPnpb3
   Xizuubqj0YUkrvtq+Vj5hkpDfIkGuxy2eDgPFzsMBQHJG7eWyJ7oxcFuZ
   QnhfgBcy+83lwJlcanhQLMcvufiRFhVVQyfmRp3oJQqVQBZTVLVPFkrxF
   A==;
IronPort-SDR: iTG+wf/3z3H0v3UTmwcvRYsBMNwDqM8mQOKkioChuqlu5/sM8+5IWSDnVVX2u2swdWHpLsA8XY
 fXbPOh4Z4OLOw3S962PU7kKtYFbnx3Y9yxQhmqjCUpeb0ddwiRmBOSHuX2u1U4v7xWeLcvfWqY
 L1ToCPnbe0Eyz0wvCW2HOu0q8sWtVgQ5WgRkzsqDKP6agFm7a4EzDI7DHBGX9yR+KjkbZSxFes
 h75zLgBvMFuGXdn6z75uls3opHKpaTby6DMmpnGX8c3hX2xFTEu5BAVTolm7L/1Dv1RAmxOBiY
 Me8=
X-IronPort-AV: E=Sophos;i="5.72,408,1580745600"; 
   d="scan'208";a="135760535"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2020 11:34:40 +0800
IronPort-SDR: ZSjOJ4JHOOkaZ6kLZy3/724Ju1D0AWE+dbZ0xeOq1vgeBnRQpBbgDqJ3/8oRphVlmPgXttzR38
 t8wZ3cEzyFerAVBbQ+WePFqycg8tmmmX0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 20:25:32 -0700
IronPort-SDR: lO7btBcWjrqFJtn8pnNC/QtT/FXAyKDOK8vNC0ORN4WSfJuUKDUKxwBo4E+EPTJqyazL7MQOIh
 v3q9juxzrKMg==
WDCIronportException: Internal
Received: from hqe220030.ad.shared (HELO jedi-01.hgst.com) ([10.86.56.34])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Apr 2020 20:34:41 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [v4 PATCH 0/3] Add UEFI support for RISC-V 
Date:   Mon, 20 Apr 2020 20:33:33 -0700
Message-Id: <20200421033336.9663-1-atish.patra@wdc.com>
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

https://github.com/atishp04/linux/tree/wip_uefi_riscv_v4

The patches have been verified on Qemu using bootefi command in U-Boot.

Changes from v3->v4:
1. Rebased on top of efi-next.
2. Dropped patch 1 & 2 from this series as it is already queued in efi-next.
Changes from v2->v3:
3. Improved handle_kernel_image() for RISC-V.

Changes from v1->v2:
1. Rebased on 5.7-rc1.
2. Fixed minor typos and removed redundant macros/comments.

Changes from previous version:
1. Renamed to the generic efi stub macro.
2. Address all redundant comments.
3. Supported EFI kernel image with normal booti command.
4. Removed runtime service related macro defines.

Atish Patra (3):
RISC-V: Define fixmap bindings for generic early ioremap support
RISC-V: Add PE/COFF header for EFI stub
RISC-V: Add EFI stub support.

arch/riscv/Kconfig                        |  21 +++++
arch/riscv/Makefile                       |   1 +
arch/riscv/configs/defconfig              |   1 +
arch/riscv/include/asm/Kbuild             |   1 +
arch/riscv/include/asm/efi.h              |  44 +++++++++
arch/riscv/include/asm/fixmap.h           |  18 ++++
arch/riscv/include/asm/io.h               |   1 +
arch/riscv/include/asm/sections.h         |  13 +++
arch/riscv/kernel/Makefile                |   4 +
arch/riscv/kernel/efi-header.S            |  99 ++++++++++++++++++++
arch/riscv/kernel/head.S                  |  16 ++++
arch/riscv/kernel/image-vars.h            |  53 +++++++++++
arch/riscv/kernel/vmlinux.lds.S           |  20 +++-
drivers/firmware/efi/Kconfig              |   2 +-
drivers/firmware/efi/libstub/Makefile     |  10 ++
drivers/firmware/efi/libstub/riscv-stub.c | 106 ++++++++++++++++++++++
16 files changed, 407 insertions(+), 3 deletions(-)
create mode 100644 arch/riscv/include/asm/efi.h
create mode 100644 arch/riscv/include/asm/sections.h
create mode 100644 arch/riscv/kernel/efi-header.S
create mode 100644 arch/riscv/kernel/image-vars.h
create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c

--
2.24.0

