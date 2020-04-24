Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BF21B764C
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgDXNGQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgDXNGP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:15 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D2820776;
        Fri, 24 Apr 2020 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733574;
        bh=FVACX4cYkQcGD25LFBzvPspC7jbn1/ZcMW9bBxk2MiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqRIo1yE592CsQcriQLSNWBQ29z0RDAoI1p/c4Q2FZWoMM+XeES186xqSpIpy0M0V
         A6mYhBy5+NfJtsOTJeam3Prdu6X7bJhN7SkcWauLqemlvAfz/Z2RDacriM+0B0oV9p
         0A9Kls6sfO0kFnDimfZ540hkUla+5FBEz2iLJs+I=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 01/33] efi/libstub: Move arm-stub to a common file
Date:   Fri, 24 Apr 2020 15:04:59 +0200
Message-Id: <20200424130531.30518-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

Most of the arm-stub code is written in an architecture independent manner.
As a result, RISC-V can reuse most of the arm-stub code.

Rename the arm-stub.c to efi-stub.c so that ARM, ARM64 and RISC-V can use it.
This patch doesn't introduce any functional changes.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Link: https://lore.kernel.org/r/20200415195422.19866-2-atish.patra@wdc.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
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
index 094eabdecfe6..75cb2c3a1519 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -23,7 +23,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
 
-cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
+cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
 
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
+lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o fdt.o string.o \
+				   $(patsubst %.c,lib-%.o,$(efi-deps-y))
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
@@ -73,8 +73,8 @@ CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 # a verification pass to see if any absolute relocations exist in any of the
 # object files.
 #
-extra-$(CONFIG_EFI_ARMSTUB)	:= $(lib-y)
-lib-$(CONFIG_EFI_ARMSTUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
+extra-$(CONFIG_EFI_GENERIC_STUB) := $(lib-y)
+lib-$(CONFIG_EFI_GENERIC_STUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
 
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
similarity index 100%
rename from drivers/firmware/efi/libstub/arm-stub.c
rename to drivers/firmware/efi/libstub/efi-stub.c
-- 
2.17.1

