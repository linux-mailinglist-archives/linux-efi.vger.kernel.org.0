Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7631AB222
	for <lists+linux-efi@lfdr.de>; Wed, 15 Apr 2020 21:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441903AbgDOTyo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Apr 2020 15:54:44 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:22138 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406322AbgDOTym (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Apr 2020 15:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586980481; x=1618516481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Djqlg8Cv1gfYTZdwhPlUmPWsMdIBfQD89t54SYqYujA=;
  b=NQvD5FhSnjenJ7luBTQQW/dyXJp/3w2sxL2zvYUOQrRObIL41IVrAUGL
   YvVqzEXuXh2CMugz17XGoFlssEwju3fQwK/FodkluLJRSVJ1EBauRctYw
   zoke8FkzAoVCvtKeuDA34cL5gHIo57OOJw8Wo6UV8digvNlJsYlesjray
   GDP3SBfoud6Ui6wpbiB5NJYm4ITQnvsEj6SPvKYdNTZCRr0JgreR9ITXD
   g37fSmsw3Z3HNHtnu7ZvRZTCWsAdTLJaYe/bldiUq1AZ+VYbl9+8PNN7B
   mz9lc4YQlic3G64jueUxe666BSyNGU2Z4yI/KXn/PpXkzCvLovFQRFYMA
   w==;
IronPort-SDR: lL32ABlfPZot9oxR0x6sRuRrJDayfBNMx3m1FABY3Tx5ra2DyFpax9RrSdiJLbb3UibBlQ3sPp
 VdiJjXK/ewpp1OYCX/LBzMTw3vB49Q+GbQIBFgGJ8LjVWyhx3/9GdSt79oLGf+ox87zK/1lqf3
 3Uy7ECC4LyaqmlqooxyICcvdy8uURf31PUjPYbK6QNZXWOfiC6RFw4w//0bxm2Hdcj79fUU18z
 efFIEUOc0I5ZjAkPCV637D6/OMvyfH2cRvIK/9BraulIEzK6GqlhKqwA42rEHtDuBExQrIh8eN
 C6Y=
X-IronPort-AV: E=Sophos;i="5.72,388,1580745600"; 
   d="scan'208";a="244077016"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2020 03:54:40 +0800
IronPort-SDR: 7VQRJwHY9jqjUF3M08RAZpGRD1V7QH/3T9WRECSmzot0qO/tEUyOzfl2zCrXgTS5ioVBWnmUiW
 1CFmiuSxX1Lf95derYJMCbQui+WyWsBcewnqZOphzzPf37z9ELxFYyg/fJMrK9I/guyPQe/7NR
 6hJ/68AYRem4s5KD8IAGtrxgpkql8J1zrUa2dpbIveeLWvhpooWCxKkTUFbb1vzQAgAXJZIlY8
 mgB3YRY1py8tqHIAFzttl2e//5EgapHpRrCYw093mNz3lbF9G0/3aAYxUYjTYqxATFknKA+9kR
 4QbQMR+DmtZ+EqIwd4k96SKm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 12:45:08 -0700
IronPort-SDR: nSxPAvAlQJjzhHxPbWNQxGt8iiqTRn/CFCJkP1IW2hN5kyO5x8A0nRolmARO8ejzgeKfne+XP+
 YhJ4lrEiUZ37oaoV0GyXFhQYDJ03SuhpCh0NrV2VvwhAhUgoNRfuHaBpEE/l/USJX50yxiOqJy
 YTTxdcr6U/EaTqWNrfb+QPwLTSOhaX7knnoFdhHsKeiBV4tKN+5T0zEH4dBF0qLaMALMgKuIbZ
 7HNCWtfgqizgzP0T4PThCN2aQ7PrhPH4yMg4hhf5fq9zYKTHHBylCByOHlSkTlfb6aJV+U9QcM
 MVE=
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
Subject: [v3 PATCH 1/5] efi: Move arm-stub to a common file
Date:   Wed, 15 Apr 2020 12:54:18 -0700
Message-Id: <20200415195422.19866-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200415195422.19866-1-atish.patra@wdc.com>
References: <20200415195422.19866-1-atish.patra@wdc.com>
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
index 2dbe4394f818..2b4e09bf987c 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -23,7 +23,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
 
-cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
+cflags-$(CONFIG_EFI_GENERIC_STUB)	+= -I$(srctree)/scripts/dtc/libfdt
 
 KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
@@ -46,13 +46,13 @@ lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   alignedmem.o relocate.o
 
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
@@ -74,8 +74,8 @@ CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
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

