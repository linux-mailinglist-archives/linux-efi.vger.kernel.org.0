Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A249E1B765D
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgDXNHM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbgDXNHL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:07:11 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 072AC20767;
        Fri, 24 Apr 2020 13:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733630;
        bh=z4vWpbhlY82t1OAv6bqpRSYDjm9YCuAYbM37/Xdua0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mmgp7U3AkhWiLEhCs2HVZS0UxQI607L2q5Kbr6ahEpOs0jUaqS+aljcC4Uhl8uMA2
         cz+sdn4sjeO0bECHcw2pCC+UTeh+SB56GoiIbHn7uGzisM7pOeAhS3hDCHVzNsVpxB
         stbYG+A5AUQGlVfDBKpVKsnWD4ldw7Y5mBOBQxKU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 27/33] efi/x86: Remove __efistub_global and add relocation check
Date:   Fri, 24 Apr 2020 15:05:25 +0200
Message-Id: <20200424130531.30518-28-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Instead of using __efistub_global to force variables into the .data
section, leave them in the .bss but pull the EFI stub's .bss section
into .data in the linker script for the compressed kernel.

Add relocation checking for x86 as well to catch non-PC-relative
relocations that require runtime processing, since the EFI stub does not
do any runtime relocation processing.

This will catch, for example, data relocations created by static
initializers of pointers.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200416151227.3360778-3-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/vmlinux.lds.S |  1 +
 drivers/firmware/efi/libstub/Makefile  | 32 +++++++++++++++++---------
 drivers/firmware/efi/libstub/efistub.h |  4 ----
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 508cfa6828c5..0dc5c2b9614b 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -52,6 +52,7 @@ SECTIONS
 		_data = . ;
 		*(.data)
 		*(.data.*)
+		*(.bss.efistub)
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index aa3ab9a4105e..8d246b51bd49 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -60,6 +60,25 @@ lib-$(CONFIG_X86)		+= x86-stub.o
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
+#
+# For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
+# .bss section, so the .bss section of the EFI stub needs to be included in the
+# .data section of the compressed kernel to ensure initialization. Rename the
+# .bss section here so it's easy to pick out in the linker script.
+#
+STUBCOPY_FLAGS-$(CONFIG_X86)	+= --rename-section .bss=.bss.efistub,load,alloc
+STUBCOPY_RELOC-$(CONFIG_X86_32)	:= R_386_32
+STUBCOPY_RELOC-$(CONFIG_X86_64)	:= R_X86_64_64
+
+#
+# ARM discards the .data section because it disallows r/w data in the
+# decompressor. So move our .data to .data.efistub and .bss to .bss.efistub,
+# which are preserved explicitly by the decompressor linker script.
+#
+STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub	\
+				   --rename-section .bss=.bss.efistub,load,alloc
+STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
+
 #
 # arm64 puts the stub in the kernel proper, which will unnecessarily retain all
 # code indefinitely unless it is annotated as __init/__initdata/__initconst etc.
@@ -74,8 +93,8 @@ CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 # a verification pass to see if any absolute relocations exist in any of the
 # object files.
 #
-extra-$(CONFIG_EFI_GENERIC_STUB) := $(lib-y)
-lib-$(CONFIG_EFI_GENERIC_STUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
+extra-y				:= $(lib-y)
+lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
 
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
@@ -98,12 +117,3 @@ quiet_cmd_stubcopy = STUBCPY $@
 		/bin/false;						\
 	fi;								\
 	$(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
-
-#
-# ARM discards the .data section because it disallows r/w data in the
-# decompressor. So move our .data to .data.efistub and .bss to .bss.efistub,
-# which are preserved explicitly by the decompressor linker script.
-#
-STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub	\
-				   --rename-section .bss=.bss.efistub,load,alloc
-STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 96e25b17c88e..5244eacc5d4b 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -25,11 +25,7 @@
 #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
 #endif
 
-#if defined(CONFIG_X86)
-#define __efistub_global	__section(.data)
-#else
 #define __efistub_global
-#endif
 
 extern bool __pure nochunk(void);
 extern bool __pure nokaslr(void);
-- 
2.17.1

