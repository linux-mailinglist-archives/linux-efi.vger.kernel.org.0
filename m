Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0089C157F5D
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBJQDK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbgBJQDK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:10 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDEE4214DB;
        Mon, 10 Feb 2020 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350590;
        bh=K54a8DUyV7Yot/t1lCOUPHD1tfsFk5jYnwJWzz2w5kM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uX2+OI+5hv0zOVhyMeLl2UEztIoOTTMN8FqoWPomuwrVapzGNtwGfMuhVfQX3jHqn
         zOOy+Dq7RRInnD+adrycBWMODeJ278QikEu+IIsqJgOONmEG3DGrvpp6F3ZP4xp8iH
         zswR1J+lAtlyT/CET8QnSK3uoBivmSmdtO+2Jqao=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 07/19] efi/libstub/x86: Incorporate eboot.c into libstub
Date:   Mon, 10 Feb 2020 17:02:36 +0100
Message-Id: <20200210160248.4889-8-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Most of the EFI stub source files of all architectures reside under
drivers/firmware/efi/libstub, where they share a Makefile with special
CFLAGS and an include file with declarations that are only relevant
for stub code.

Currently, we carry a lot of stub specific stuff in linux/efi.h only
because eboot.c in arch/x86 needs them as well. So let's move eboot.c
into libstub/, and move the contents of eboot.h that we still care
about into efistub.h

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile                                           |  5 +---
 arch/x86/boot/compressed/eboot.h                                            | 31 --------------------
 drivers/firmware/efi/libstub/Makefile                                       |  1 +
 drivers/firmware/efi/libstub/efistub.h                                      | 16 ++++++++++
 arch/x86/boot/compressed/eboot.c => drivers/firmware/efi/libstub/x86-stub.c |  5 +---
 5 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 26050ae0b27e..e51879bdc51c 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -87,10 +87,7 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
-$(obj)/eboot.o: KBUILD_CFLAGS += -fshort-wchar -mno-red-zone
-
-vmlinux-objs-$(CONFIG_EFI_STUB) += $(obj)/eboot.o \
-	$(objtree)/drivers/firmware/efi/libstub/lib.a
+vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 
 # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
diff --git a/arch/x86/boot/compressed/eboot.h b/arch/x86/boot/compressed/eboot.h
deleted file mode 100644
index 99f35343d443..000000000000
--- a/arch/x86/boot/compressed/eboot.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef BOOT_COMPRESSED_EBOOT_H
-#define BOOT_COMPRESSED_EBOOT_H
-
-#define SEG_TYPE_DATA		(0 << 3)
-#define SEG_TYPE_READ_WRITE	(1 << 1)
-#define SEG_TYPE_CODE		(1 << 3)
-#define SEG_TYPE_EXEC_READ	(1 << 1)
-#define SEG_TYPE_TSS		((1 << 3) | (1 << 0))
-#define SEG_OP_SIZE_32BIT	(1 << 0)
-#define SEG_GRANULARITY_4KB	(1 << 0)
-
-#define DESC_TYPE_CODE_DATA	(1 << 0)
-
-typedef union efi_uga_draw_protocol efi_uga_draw_protocol_t;
-
-union efi_uga_draw_protocol {
-	struct {
-		efi_status_t (__efiapi *get_mode)(efi_uga_draw_protocol_t *,
-						  u32*, u32*, u32*, u32*);
-		void *set_mode;
-		void *blt;
-	};
-	struct {
-		u32 get_mode;
-		u32 set_mode;
-		u32 blt;
-	} mixed_mode;
-};
-
-#endif /* BOOT_COMPRESSED_EBOOT_H */
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 45d6eb657437..8e15634fa929 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -52,6 +52,7 @@ lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o string.o \
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
+lib-$(CONFIG_X86)		+= x86-stub.o
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index c244b165005e..55de118e8267 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -90,4 +90,20 @@ void *get_efi_config_table(efi_guid_t guid);
 	efi_rt_call(set_variable, (efi_char16_t *)(name),	\
 		    (efi_guid_t *)(vendor), __VA_ARGS__)
 
+typedef union efi_uga_draw_protocol efi_uga_draw_protocol_t;
+
+union efi_uga_draw_protocol {
+	struct {
+		efi_status_t (__efiapi *get_mode)(efi_uga_draw_protocol_t *,
+						  u32*, u32*, u32*, u32*);
+		void *set_mode;
+		void *blt;
+	};
+	struct {
+		u32 get_mode;
+		u32 set_mode;
+		u32 blt;
+	} mixed_mode;
+};
+
 #endif
diff --git a/arch/x86/boot/compressed/eboot.c b/drivers/firmware/efi/libstub/x86-stub.c
similarity index 99%
rename from arch/x86/boot/compressed/eboot.c
rename to drivers/firmware/efi/libstub/x86-stub.c
index 55637135b50c..7e7c50883cce 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -6,8 +6,6 @@
  *
  * ----------------------------------------------------------------------- */
 
-#pragma GCC visibility push(hidden)
-
 #include <linux/efi.h>
 #include <linux/pci.h>
 
@@ -17,8 +15,7 @@
 #include <asm/desc.h>
 #include <asm/boot.h>
 
-#include "../string.h"
-#include "eboot.h"
+#include "efistub.h"
 
 static efi_system_table_t *sys_table;
 extern const bool efi_is64;
-- 
2.17.1

