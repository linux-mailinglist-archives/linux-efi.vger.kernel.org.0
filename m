Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3B016F4B5
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 02:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgBZBKz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 20:10:55 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:57164 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729795AbgBZBKw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Feb 2020 20:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582679452; x=1614215452;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NZg4u6V8Z0INJBN1XdeJcWgb0fnCl1aP4d5JfmKexCQ=;
  b=a1xt+xLHrNZM6W+fYM0zT+XtRsNugfpkhMBzruu2ovs1csNaMmpafeuh
   3HYVUh03J9hMc45hSFkfXReQxwiWGqRXCc6Acs4ze4xI/suyQ9Osz0qi/
   YENDPBbgAF+hKmksbsfOCkKRQTrLXmTGlj4qPQiGYcCVC+KSCMdcT4p6A
   le30LytQNPU87HjFmxy/MAyiEW9tho8HxG+fgM0DXJm1ceeVhFtI8I3OL
   stB5+roE2Of/xWV/mgXGWmmQ8k8SCWY0zt+zvfM5vrFOaLuK48fIctz7V
   6TLWfs9Nl//ZEkGwU7FI4w1ZB66Axv9zxJ7lTLOZYp8ceVW9OH/xtTy1a
   w==;
IronPort-SDR: RrQfM1iKDxvopeo4nF5JZuCZj+X1yQU96C0HjGz1CMYQbYdWn13lCS0RhUfJLkOrSRqCFrAC8A
 r2aS3GxNX+X5mGLYQbykToiHHdU3Ga3PQjInIG7q0CPHfkiqZbuz68f0GT/8zvloUuIRIMpe90
 YTGEeFqVhaZ74O7Kk1OCwgH3HF6L19Uy1ywEHccZn9GH8DruhWjx4+7dzn548Qh2FT4+r5EA7S
 JP82hF8oOcNi3/FT912IyiHbQ5i09gReCmqUTmFdMt/ga9qG07CM0dphPDXEZuoiTB9zAeNLmf
 69U=
X-IronPort-AV: E=Sophos;i="5.70,486,1574092800"; 
   d="scan'208";a="131266488"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2020 09:10:49 +0800
IronPort-SDR: P3G70WKBbUWD4JIWhmgOMD+uKul7PzfgwISVDWYgXtrbTPAIU93x+Rptyjz/3FxsSaMRqHUv60
 C3uqMkJaKOnlHkAgzV/V8KWCHsFSZQiBqzqdZVHPYXpRQIggsev0ljSUgrS9j8EZaXLWAOd3uC
 1U8bh/YUKe7yOdFCH6kbhs77jfG5cXZiyrTg2VOGFUh0LQfpF9qilbOCI7MbRnW/I34eRUmXi8
 AkjR//XzV4yqNmxHOpvSgGEV0oTODISRCXCSBCzH9lYyzZgCEG7mlKj++897nfcnSGarHVsWEA
 S1hb9wALZrQoMUv3AtmMCkC/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 17:03:14 -0800
IronPort-SDR: 8c1x7BtrsxAIwmO/HJj0NItWFGgQptHN46p2vFlF3Dj4YVryIzkAyezvkjD4w+4OKeVG6wBjbw
 8we5DOedz8TXd8LiJGIOMqoMAe7mVePjj+N0dEuqplmQdnxTCnQDuUwPZGAL5hY9pQlAjl0uDd
 oOcdSrEzpiaCH7M16ZlzSZtC1j42Gtu0xwfQ0SAZDikmr6FZbmtLvE+5tZF1N9Z5rGK/eRbcvF
 InpgYh/KDO9rVWTbAFOFx+cNynVayRZCNSXqP3xW3Diqc6jsDixKYTx85DLJ9ieFlf537hbvIQ
 OMk=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Feb 2020 17:10:46 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mao Han <han_mao@c-sky.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Alexander Graf <agraf@csgraf.de>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "Chang, Abner (HPS SW/FW Technologist)" <abner.chang@hpe.com>,
        daniel.schaefer@hpe.com
Subject: [RFC PATCH 0/5] Add UEFI support for RISC-V 
Date:   Tue, 25 Feb 2020 17:10:32 -0800
Message-Id: <20200226011037.7179-1-atish.patra@wdc.com>
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
https://lists.denx.de/pipermail/u-boot/2020-February/401227.html

Linux kernel: SBI v0.2 and HSM extension support. This series is a mandatory
pre-requisite for UEFI support as only single core can boot EFI stub and
Linux via UEFI. All other cores are brought up using SBI HSM extension.
http://lists.infradead.org/pipermail/linux-riscv/2020-February/008513.html

OpenSBI: master (commit: ge3f69fc1e934)

Patch 1 just moves arm-stub code to a generic code so that it can be used
across different architecture.

Patch 3 adds fixmap bindings so that CONFIG_EFI can be compiled and we do not
have create separate config to enable boot time services. 
As runtime services are not enabled at this time, full generic early ioremap
support is also not added in this series.

Patch 4 and 5 adds the PE/COFF header and EFI stub code support for RISC-V
respectively.

The patches can also be found in following git repo.

https://github.com/atishp04/linux/tree/wip_uefi_riscv

The patches have been verified on Qemu using bootefi command in U-Boot.
Here is a boot log.

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
arch/riscv/include/asm/Kbuild                 |   2 +-
arch/riscv/include/asm/fixmap.h               |  21 ++-
arch/riscv/include/asm/io.h                   |   1 +
arch/riscv/include/asm/sections.h             |  13 ++
arch/riscv/kernel/Makefile                    |   4 +
arch/riscv/kernel/efi-header.S                | 107 ++++++++++++++
arch/riscv/kernel/head.S                      |  15 ++
arch/riscv/kernel/image-vars.h                |  52 +++++++
arch/riscv/kernel/vmlinux.lds.S               |  27 +++-
drivers/firmware/efi/Kconfig                  |   6 +-
drivers/firmware/efi/libstub/Makefile         |  20 ++-
.../efi/libstub/{arm-stub.c => efi-stub.c}    |   7 +-
drivers/firmware/efi/libstub/riscv-stub.c     | 135 ++++++++++++++++++
include/linux/pe.h                            |   3 +
19 files changed, 420 insertions(+), 20 deletions(-)
create mode 100644 arch/riscv/include/asm/sections.h
create mode 100644 arch/riscv/kernel/efi-header.S
create mode 100644 arch/riscv/kernel/image-vars.h
rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (98%)
create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c

--
2.24.0

