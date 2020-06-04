Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420041EDB1D
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jun 2020 04:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgFDCVH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Jun 2020 22:21:07 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:37617 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgFDCVH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Jun 2020 22:21:07 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 0542KXGU019289;
        Thu, 4 Jun 2020 11:20:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 0542KXGU019289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1591237234;
        bh=T9r/TRCaX0W970ulkmT2ASlHD4cDKaD1gWaMUEyt/Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wK7zqBC0TshFIPuPAEipGKnbPJPDjBncCmz19ZsnDjbUEkOobX5gmwnUGrPLKGVSP
         nKHHl77DVIhSPWQ+X/1twD+ki+VfknNqK4mvHz1XZNNAZPS6/fWrFQk/Y3QG3qleVF
         oc/48N+P6+PAh9y2Xy3MIjOPY9xwyH/8/dOXKzmNjd1Vp3GtyX+DqQXjRLmqgHAJk8
         mU3jigHEdrkPCiF1lJxTfpDM8NoVJobZ5pnNjJIm6YYA6netzDmSidDNIcS9OLE+Qn
         UFAlWIizXKfSE2oQaZihufME/WSqShdcItC9E5aQLx5wahDJHEF+CD7wYH9I8+1iit
         qysGFSiGxOHYw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] efi/libstub: refactor Makefile to not use lib-y syntax
Date:   Thu,  4 Jun 2020 11:20:31 +0900
Message-Id: <20200604022031.164207-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200604022031.164207-1-masahiroy@kernel.org>
References: <20200604022031.164207-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Documentation/kbuild/makefiles.rst says:

  Use of lib-y is normally restricted to `lib/` and `arch/*/lib`.

This is because lib-y is inteded to be hooked to KBUILD_VMLINUX_LIBS,
which is passed down to scripts/link-vmlinux.sh.

Besides, lib-y is not so interesting because objects from lib-y are
mostly linked in normal usecases. For example, lib-y only saves 364
bytes for x86_64_defconfig. You can see the details in commit
7273ad2b08f8 ("kbuild: link lib-y objects to vmlinux forcibly when
CONFIG_MODULES=y").

I think we should consider to deprecate lib-y syntax at some point
because we should aim for better solution like dead code elimination
or LTO.

Other than lib/ and arch/*/lib, this Makefile is the only user of
lib-y. Replace lib-y with a custom rule.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Add more description

 drivers/firmware/efi/libstub/Makefile | 49 +++++++++++++++------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index cce4a7436052..7d81dc45cadf 100644
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
@@ -121,3 +108,21 @@ quiet_cmd_stubcopy = STUBCPY $@
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
+extra-y += lib.a
+
+$(obj)/lib.a: $(addprefix $(obj)/, $(stub-obj-y)) FORCE
+	$(call if_changed,ar)
-- 
2.25.1

