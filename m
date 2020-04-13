Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766EE1A6E3D
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 23:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389051AbgDMV3c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 17:29:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20794 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389015AbgDMV3b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Apr 2020 17:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586813371; x=1618349371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pcOCtB5fv/YmPFx2fo9gEb+wBJbwEegEJHy3Q6vyD6w=;
  b=mjTI2RTeqUQWgXnBeuer1Ro52QKZPtFypnCCF2WBLF7Pc2nZ096fx3Vl
   NSej2ai8Ir2ZjROftzBvNoa8dFhrqJxH/CFmiafmAIhGAK/cPnTK4ep9D
   YjubsUB2Z4p8HVqvmUcSmdsWYN0fYlAEYZWsWGReJfbyP5cMcFgihOkxT
   9JQkE3Bt79xd82pqk+h5/SgQAwVQVADO6EB/FK8iWNtswOLiJYC7nKJXW
   U2BrgFkevSbaWP+s0POkjgltnU1PdI8+hzUK2+rB9h5wjZjkqyM0KsVS6
   EYd2DqUIYJX6rhR4Kq3ny+xLTniIBPOTmHnGM2XNglHNur+jO1qTqSceM
   g==;
IronPort-SDR: K8a0xnrKyFaeMBRaNTtg0wCaqtAqn5yDJ1ldnN4dT80AdEidhAx+qabwcah3rZhWr8RAgn0VQY
 GKnw1TjkY2WxBmYzE/uW0SUXAPcKx4VT842B9CHE94+x36DLmUxZ+HUz10EMr6Jkwk0DBJHZyE
 3SYaPu8O41qNEkC3HXGY7HhBMQnW5cI7c6fq63xGeUqSUs8hc93xLmr5PwNHDQehUo0bGMUVgl
 8ALQ7mPWUsTGBBKosI7nmPNZhfdXjT368SbfiD+6XTYFg9PiOSqgTg8wOs3OaMk2JRa2qs/U+K
 a5o=
X-IronPort-AV: E=Sophos;i="5.72,380,1580745600"; 
   d="scan'208";a="139583352"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2020 05:29:30 +0800
IronPort-SDR: eDb2ylkE/WQKo5Z2Mh/KY2O1ZoxN2MemZcUJoy4cMxuSp6XRorSWvmIk4YjeraLEEpcWkn8qIb
 15e0B7nQsq2D+7erve8WcRsWtE2CnWG0Yc1qsd4i700+I8uau+bRw3AXD+YOzW+/My8TfHq7M/
 5csb62CN8ZgwRSRz04bnAQfNsGEqrVO1WO49gB1x0KCzi2dCc+Bcisu6aA5Ko/+tF27X1fk9gH
 zxtuPh2dAyXpfUUiJilPwA7UxQuNUqSAM0aOnoazjls2P1tG77D6er3sqDDas8uKYlaEl8FVFu
 0shc2TD+jhRzD0DsPp0QfD8A
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 14:20:34 -0700
IronPort-SDR: r8UFEQO5M4pHviXz4+biD+GAWKWN6A1nxhe91z8v+Dtoc6TV5nlLfDai33OTJWF23MoqCPRTqN
 sml7yCm+YbC3KL9qJGHkS1x+KSwJJF5yMPRYcohpOaWSHRn5Z1KJpnJ15b5OzXTmnxT2FmpCtz
 2uTJ+WlEAzSE9eIF09bszfOxvtxA5GSDdNK8u/N4CAhG93tPMNGtjZpKJrGldf9s+QoloFc+lr
 2Z2XZHYk6WI8XZJyxyw1VVC4Py/0ANJUKzL50KeslFIQHMiu/JC7cHE+x79o9iRDZ9KLhNXrse
 0Oo=
WDCIronportException: Internal
Received: from 9dg4l72.ad.shared (HELO jedi-01.hgst.com) ([10.86.55.26])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Apr 2020 14:29:30 -0700
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
Subject: [v2 PATCH 1/5] efi: Move arm-stub to a common file
Date:   Mon, 13 Apr 2020 14:29:03 -0700
Message-Id: <20200413212907.29244-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200413212907.29244-1-atish.patra@wdc.com>
References: <20200413212907.29244-1-atish.patra@wdc.com>
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
index 66a04f6f4775..165987aa5bcd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1954,7 +1954,7 @@ config EFI
 	select UCS2_STRING
 	select EFI_PARAMS_FROM_FDT
 	select EFI_STUB
-	select EFI_ARMSTUB
+	select EFI_GENERIC_STUB
 	select EFI_RUNTIME_WRAPPERS
 	---help---
 	  This option provides support for runtime services provided
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 40fb05d96c60..32d818c5ccda 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1785,7 +1785,7 @@ config EFI
 	select EFI_PARAMS_FROM_FDT
 	select EFI_RUNTIME_WRAPPERS
 	select EFI_STUB
-	select EFI_ARMSTUB
+	select EFI_GENERIC_STUB
 	default y
 	help
 	  This option provides support for runtime services provided
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 613828d3f106..2a2b2b96a1dc 100644
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
index 094eabdecfe6..d590504541f6 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -23,7 +23,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
 
-cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
+cflags-$(CONFIG_EFI_GENERIC_STUB)	+= -I$(srctree)/scripts/dtc/libfdt
 
 KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
@@ -45,13 +45,13 @@ lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
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
@@ -73,8 +73,8 @@ CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
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

