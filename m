Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88C01A6E49
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 23:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389042AbgDMV3b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 17:29:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20794 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388994AbgDMV3a (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Apr 2020 17:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586813370; x=1618349370;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VGLGVChtgkugJ2Zf+S/wgEqmmZg5+pWj+SDm9AjhtcA=;
  b=SpCaj77XNEzRm+5VZXpMJbGmJpMwA10C1bZBbpraCjFcMPMBVyx1H+03
   9c4QfsaHE0t2kYwkgW00SDSnKlgdrw1RC1aT5VKHjmQvWr7iJLEWNS+HC
   jkWyP48t5t6RultefLBvYTGv2taoe8E54DTtv3yO+tUtjc5IRwqmGnmvf
   QvXTr1602odO7gu0o0fPfOZIqECIABGaq/dNFru0V92nm2mD8l3B4Weqn
   6hvTDSQg9bhWSkCyLHGfoHL7nC6vP3we4Qkf1Leq7UPzr3OgBnN2gV7vy
   oNeYFtAaijUAcuNswVUDHRv5KOlukNg9Sct2Yfxjl99T77jJ0/jyBMpFZ
   Q==;
IronPort-SDR: L99hkqN4LH3oQcz2WVtJj3K7Nu8spioaRmwD3uQfOEj2sZ8ZEprpM6neTxpFfwDNCREXXw6jjU
 dJQOOBU5wAa4Orz/V8uZ988YqWMnadX+IPjNrhmveuanraBu1TqclgGj9amKKfsKpbCRBdWelB
 8Dokly0RJcosjjD1xfYi5tc/SCFSrBa6yoSffCP78WMvPib6f28UNBtSOa7ye/wwgnzLJD+e/e
 GhLyndmlFsBS+WLUniQ4VWHRr0885LCHAaivez9p2k84FMTkta+velAHrF/OKe2XRz+I9gzIyK
 vzo=
X-IronPort-AV: E=Sophos;i="5.72,380,1580745600"; 
   d="scan'208";a="139583348"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2020 05:29:29 +0800
IronPort-SDR: PVi9g5xGh0STGPeWQpw87pLhjP+yCoCDAVlhaPW8wBts8uELJQ1nZIT45PscpKuTsB07wnXiOO
 byQ5n1EVXPvwtAff9q1n9F9ZlKzKALtXvYN9WKMZHkNRIMS6d+UYcDPSfz6PMNdd0/KL4FNTaW
 gb6X24VCe4I09r93iFu8Kvl4vVAAox3CrhO+/enCV1oj73bGM9fq5ktHyuDd+eVrbT8y56eeom
 5HyQkqJQ+Gtr32+AGaLsPHe3b84Vs2LCwucHhw5oh/17ew+3IPWXPink/Tgu+GmQB6MJS3/SPP
 9VoTGPaSFghgtyfAf0Xp2bjJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 14:20:33 -0700
IronPort-SDR: WT5XDCFN81cADlBdOKDjic6ONVXHu3nS0Q+aL5T9UZa8LcDQ4YTXdhXRPIAv5q7nBEeBBLSrPh
 pEcJJEK7lUvjOI5ZmkXx/2g0RkbihNkPpV6qbaOpzJmxVDraTlUlUQ6OuRSCSabH9V2nskYlLZ
 Yfr5pie0rwXElQ33RRu85DkExbBxfpVL8JuCFvS/9bSBqqYIGlnD5vf1RzzkIxGotZuztB1Vsh
 ty8HgLZKEX3u9zuXuzq13KH6YOE0aWf65iPB8xpFeNnAiXZiNxTgy8jxECq68SL3nO1W5sszxQ
 mIM=
WDCIronportException: Internal
Received: from 9dg4l72.ad.shared (HELO jedi-01.hgst.com) ([10.86.55.26])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Apr 2020 14:29:29 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
Subject: [v2 PATCH 0/5] Add UEFI support for RISC-V 
Date:   Mon, 13 Apr 2020 14:29:02 -0700
Message-Id: <20200413212907.29244-1-atish.patra@wdc.com>
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

https://github.com/atishp04/linux/tree/wip_uefi_riscv_v2

The patches have been verified on Qemu using bootefi command in U-Boot.

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
arch/riscv/Kconfig                            |  21 +++
arch/riscv/Makefile                           |   1 +
arch/riscv/configs/defconfig                  |   1 +
arch/riscv/include/asm/Kbuild                 |   1 +
arch/riscv/include/asm/efi.h                  |  45 ++++++
arch/riscv/include/asm/fixmap.h               |  18 +++
arch/riscv/include/asm/io.h                   |   1 +
arch/riscv/include/asm/sections.h             |  13 ++
arch/riscv/kernel/Makefile                    |   4 +
arch/riscv/kernel/efi-header.S                |  99 +++++++++++++
arch/riscv/kernel/head.S                      |  16 +++
arch/riscv/kernel/image-vars.h                |  53 +++++++
arch/riscv/kernel/vmlinux.lds.S               |  22 ++-
drivers/firmware/efi/Kconfig                  |   4 +-
drivers/firmware/efi/libstub/Makefile         |  20 ++-
.../efi/libstub/{arm-stub.c => efi-stub.c}    |   0
drivers/firmware/efi/libstub/riscv-stub.c     | 131 ++++++++++++++++++
include/linux/pe.h                            |   3 +
20 files changed, 445 insertions(+), 12 deletions(-)
create mode 100644 arch/riscv/include/asm/efi.h
create mode 100644 arch/riscv/include/asm/sections.h
create mode 100644 arch/riscv/kernel/efi-header.S
create mode 100644 arch/riscv/kernel/image-vars.h
rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (100%)
create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c

--
2.24.0

