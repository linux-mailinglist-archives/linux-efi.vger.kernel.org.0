Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67D91EC8F2
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jun 2020 07:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgFCFus (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Jun 2020 01:50:48 -0400
Received: from condef-05.nifty.com ([202.248.20.70]:45932 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgFCFus (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Jun 2020 01:50:48 -0400
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2020 01:50:47 EDT
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-05.nifty.com with ESMTP id 0535Y1N5005795
        for <linux-efi@vger.kernel.org>; Wed, 3 Jun 2020 14:34:17 +0900
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 0535XFsW027699;
        Wed, 3 Jun 2020 14:33:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 0535XFsW027699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1591162396;
        bh=S2qfYJl3VVPFJgaHLte7Yupybv6BYwId2vGPrugcKrQ=;
        h=From:To:Cc:Subject:Date:From;
        b=KFtphBTePXst6vLqPvuK1CfhDSFYJXLl4lAEN0Mj2Q43jXBw/1aEgdlQj8imyBzd2
         7OvaxoOGDIGpPo4+iVt7uSk9HzDt8mfOC9raDIn9nYTDiFQGnC49YtZ9vYFn13BhbS
         CSW6i52tokICX16L+d7hBZH6H9a4ptUzVI29ax5NspZuhuuCsWOtFR2Idq+oMly2Kt
         2qkP1QohWQAWh9+4hX/Se6s4elEet6KU3BvusbemSO2dGse+xf9tpfMhMbtM1GBFJc
         GZbTtpiXDkA3kz+stcKzwweokDo00NoXZv0pyEgxY69HuSxKreymadDKM/FeuD+fjV
         lI4Unna+N38XQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi/libstub: refactor Makefile to not use lib-y syntax
Date:   Wed,  3 Jun 2020 14:33:13 +0900
Message-Id: <20200603053313.3863761-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Documentation/kbuild/makefiles.rst says:

  Use of lib-y is normally restricted to `lib/` and `arch/*/lib`.

I want to disallow lib-y outside of them.

Add a custom rule to build lib.a, which is linked to the decompressor
for ARCH=x86, ARCH=arm.

For ARCH=arm64, use obj-y to link objects to vmlinux in the ordinary
way.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/Makefile                   |  1 -
 drivers/firmware/efi/Makefile         |  2 +-
 drivers/firmware/efi/libstub/Makefile | 51 +++++++++++++++------------
 3 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 650e1185c190..ab79b20efc8d 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -145,7 +145,6 @@ export	TEXT_OFFSET
 
 core-y		+= arch/arm64/
 libs-y		:= arch/arm64/lib/ $(libs-y)
-core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 # Default target when executing plain make
 boot		:= arch/arm64/boot
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 7a216984552b..317a05cd388b 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_EFI_VARS_PSTORE)		+= efi-pstore.o
 obj-$(CONFIG_UEFI_CPER)			+= cper.o
 obj-$(CONFIG_EFI_RUNTIME_MAP)		+= runtime-map.o
 obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)	+= runtime-wrappers.o
-subdir-$(CONFIG_EFI_STUB)		+= libstub
+obj-$(CONFIG_EFI_STUB)			+= libstub/
 obj-$(CONFIG_EFI_FAKE_MEMMAP)		+= fake_map.o
 obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)	+= efibc.o
 obj-$(CONFIG_EFI_TEST)			+= test/
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index cce4a7436052..e4e9b17fa3b2 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -44,7 +44,7 @@ OBJECT_FILES_NON_STANDARD	:= y
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT			:= n
 
-lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
+stub-obj-y			:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
 				   alignedmem.o relocate.o vsprintf.o
@@ -55,15 +55,19 @@ efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o fdt.o string.o \
+stub-obj-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o fdt.o string.o \
 				   $(patsubst %.c,lib-%.o,$(efi-deps-y))
 
-lib-$(CONFIG_ARM)		+= arm32-stub.o
-lib-$(CONFIG_ARM64)		+= arm64-stub.o
-lib-$(CONFIG_X86)		+= x86-stub.o
+stub-obj-$(CONFIG_ARM)		+= arm32-stub.o
+stub-obj-$(CONFIG_ARM64)	+= arm64-stub.o
+stub-obj-$(CONFIG_X86)		+= x86-stub.o
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
+targets				+= $(stub-obj-y)
+stub-obj-y			:= $(patsubst %.o,%.stub.o, $(stub-obj-y))
+targets				+= $(stub-obj-y)
+
 #
 # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
 # .bss section, so the .bss section of the EFI stub needs to be included in the
@@ -83,23 +87,6 @@ STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub	\
 				   --rename-section .bss=.bss.efistub,load,alloc
 STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
 
-#
-# arm64 puts the stub in the kernel proper, which will unnecessarily retain all
-# code indefinitely unless it is annotated as __init/__initdata/__initconst etc.
-# So let's apply the __init annotations at the section level, by prefixing
-# the section names directly. This will ensure that even all the inline string
-# literals are covered.
-# The fact that the stub and the kernel proper are essentially the same binary
-# also means that we need to be extra careful to make sure that the stub does
-# not rely on any absolute symbol references, considering that the virtual
-# kernel mapping that the linker uses is not active yet when the stub is
-# executing. So build all C dependencies of the EFI stub into libstub, and do
-# a verification pass to see if any absolute relocations exist in any of the
-# object files.
-#
-extra-y				:= $(lib-y)
-lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
-
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
 STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
@@ -121,3 +108,23 @@ quiet_cmd_stubcopy = STUBCPY $@
 		/bin/false;						\
 	fi;								\
 	$(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
+
+# arm64 puts the stub in the kernel proper, which will unnecessarily retain all
+# code indefinitely unless it is annotated as __init/__initdata/__initconst etc.
+# So let's apply the __init annotations at the section level, by prefixing
+# the section names directly. This will ensure that even all the inline string
+# literals are covered.
+# The fact that the stub and the kernel proper are essentially the same binary
+# also means that we need to be extra careful to make sure that the stub does
+# not rely on any absolute symbol references, considering that the virtual
+# kernel mapping that the linker uses is not active yet when the stub is
+# executing. So build all C dependencies of the EFI stub into libstub, and do
+# a verification pass to see if any absolute relocations exist in any of the
+# object files.
+#
+obj-$(CONFIG_ARM64)		+= $(stub-obj-y)
+extra-$(CONFIG_ARM)		+= lib.a
+extra-$(CONFIG_X86)		+= lib.a
+
+$(obj)/lib.a: $(addprefix $(obj)/, $(stub-obj-y)) FORCE
+	$(call if_changed,ar)
-- 
2.25.1

