Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BABC3172B14
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 23:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgB0W0v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 17:26:51 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16827 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbgB0W0u (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Feb 2020 17:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582842411; x=1614378411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8+bQmOk3su3vFKh2m+lkIXpoSPkei2/BxO2wUo2lbAs=;
  b=NY6la+GFMpCS7ssz9Rq99X+eg8pOwjRBvP7DAE5dqdjO82cQZVQhcpeE
   pK58UIWe77eS9qG46FCPW392DppdzwrFeZTxAxKhXCH5CpgvL6+biCCf8
   aa4TJ+5i6xkBUHY8BjyXoxumXpMwKMNgIwejtZEhyqOf15WB/8SS4vvi2
   rCnWgVmdsT7kwZW//0rh8kfxAgAqIM67Z3qMdYBdraESty8GocyaMrxgB
   d4uttQ2fxkHXkXEFJZvEnOuVRvtRxmEkzDGLPgSrqLj02hyVo4diTOp8h
   XxAWxsNdG4qeqGk2KeCb9mLQRnmzJho2m+qT+ZHMt5ps+L60kHrkiZiWG
   g==;
IronPort-SDR: zPFhSzIFoGwfQAl2fpX0Zr4r2PvkMjye8Zr4HwiM7uIeKoKtEkWBMyfygT4jMLmy5Y6e7vai+f
 heg4YBJxAe/O1h+ba6w+c8Id2Ifn95x0NTmREWnBs09lF1YgmhmD84xywGaCwehJpznv0Jm9zX
 QtrwwEjqO9GENARuntF1W/ntNb2Xg084H8ZNjThMG3YU/VJ2EBuZMeQ+RJlkb6s5WxQT2RiujZ
 8ZP2nqJYYtl7kXACwcI0FBV0IjcehjA8dk4FivKoSaRi+oARPctx6NxKFcC9nykir/ha7o/nug
 EBw=
X-IronPort-AV: E=Sophos;i="5.70,493,1574092800"; 
   d="scan'208";a="131459836"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2020 06:26:50 +0800
IronPort-SDR: aPX2WRmuNIcUAUMVbxKDYdH3OpcTIy5Wx4/SqurWEFlsFAujMZe6qRSWl5cyEVYJ5HQlLjOls7
 kXTIpQGLVJifslte6fLlXONFUNMq9DSFfY81R7HQxQqj8izCjGYvSSQvNJPSGaXExPQfRFzMVI
 0B6ZKT9i+cCwA6vJaRF2BCRVIdAxKcaUmYhr6nhNLZJoZLadDkhKf7Mg8nhJB38YIS1MjAPQf6
 mSTyY8CuvzaGweGWIIH83LTLzOiNW0OZkV/JKbkKKI6k0AkM2qmk1YMLFXwkQyTjS5NeUmRItj
 VAhfRP9Z15ycUFNYhIU8BXP6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 14:19:12 -0800
IronPort-SDR: doNdtjDyQyTl5eHyB8x3had8Qj7buf7Q0oxV6xcruIObUlvaR3SwBNMXHHv35+bayB4a+jhNLs
 N5S5SEE1DogcN0LD6KxHe7gBN+8i0ZwIOU5CG4dDQN6k65Vja7f10nvah4Nk9sPUJ5YHrP9ghF
 fxQGvMEbuEAE9Uv6pwXxYBJyqn0g09Uv3x8uE/2xV2kPrXD0bHt1eNYazxluniZONh8DaRNLAt
 RZDc0vGNHAjphjPfo66mj6MFLQHy6XiHsRPCWXpdUNSQQNipkQJ6082q5MK4KjDtQn087G0uHP
 gzA=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Feb 2020 14:26:49 -0800
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
Subject: [v1 PATCH 1/5] efi: Move arm-stub to a common file
Date:   Thu, 27 Feb 2020 14:26:40 -0800
Message-Id: <20200227222644.9468-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200227222644.9468-1-atish.patra@wdc.com>
References: <20200227222644.9468-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Most of the arm-stub code is written in an architecture independent manner.
As a result, RISC-V can reuse most of the arm-stub code.

Rename the arm-stub.c to efi-stub.c so that ARM, ARM64 and RISC-V can use it.
This patch doesn't introduce any functional changes.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/arm/Kconfig                                     |  2 +-
 arch/arm64/Kconfig                                   |  2 +-
 drivers/firmware/efi/Kconfig                         |  4 ++--
 drivers/firmware/efi/libstub/Makefile                | 12 ++++++------
 .../firmware/efi/libstub/{arm-stub.c => efi-stub.c}  |  0
 5 files changed, 10 insertions(+), 10 deletions(-)
 rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 97864aabc2a6..cccb9df48055 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1955,7 +1955,7 @@ config EFI
 	select UCS2_STRING
 	select EFI_PARAMS_FROM_FDT
 	select EFI_STUB
-	select EFI_ARMSTUB
+	select EFI_GENERIC_STUB
 	select EFI_RUNTIME_WRAPPERS
 	---help---
 	  This option provides support for runtime services provided
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0b30e884e088..edf955832e55 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1720,7 +1720,7 @@ config EFI
 	select EFI_PARAMS_FROM_FDT
 	select EFI_RUNTIME_WRAPPERS
 	select EFI_STUB
-	select EFI_ARMSTUB
+	select EFI_GENERIC_STUB
 	default y
 	help
 	  This option provides support for runtime services provided
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index ecc83e2f032c..708fe86cc66d 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -106,12 +106,12 @@ config EFI_PARAMS_FROM_FDT
 config EFI_RUNTIME_WRAPPERS
 	bool
 
-config EFI_ARMSTUB
+config EFI_GENERIC_STUB
 	bool
 
 config EFI_ARMSTUB_DTB_LOADER
 	bool "Enable the DTB loader"
-	depends on EFI_ARMSTUB
+	depends on EFI_GENERIC_STUB
 	default y
 	help
 	  Select this config option to add support for the dtb= command
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 4d6246c6f651..f1d7de1e0d87 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -22,7 +22,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
 
-cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
+cflags-$(CONFIG_EFI_GENERIC_STUB)	+= -I$(srctree)/scripts/dtc/libfdt
 
 KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
@@ -44,13 +44,13 @@ lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
-arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
+efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
 
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o string.o \
-				   $(patsubst %.c,lib-%.o,$(arm-deps-y))
+lib-$(CONFIG_EFI_GENERIC_STUB)		+= efi-stub.o fdt.o string.o \
+				   $(patsubst %.c,lib-%.o,$(efi-deps-y))
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
@@ -72,8 +72,8 @@ CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 # a verification pass to see if any absolute relocations exist in any of the
 # object files.
 #
-extra-$(CONFIG_EFI_ARMSTUB)	:= $(lib-y)
-lib-$(CONFIG_EFI_ARMSTUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
+extra-$(CONFIG_EFI_GENERIC_STUB)	:= $(lib-y)
+lib-$(CONFIG_EFI_GENERIC_STUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
 
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
similarity index 100%
rename from drivers/firmware/efi/libstub/arm-stub.c
rename to drivers/firmware/efi/libstub/efi-stub.c
-- 
2.24.0

