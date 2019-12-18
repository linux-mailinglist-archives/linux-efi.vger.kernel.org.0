Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D278F124EAE
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2019 18:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLRRCz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Dec 2019 12:02:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfLRRCz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Dec 2019 12:02:55 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3398324676;
        Wed, 18 Dec 2019 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576688574;
        bh=0sCkpjXMCJohONQZbsBxzn8gAqvjnPbL4dqS9auRgHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OG7PnrGlgimMNGuBVEOT2RNHxRYlvNrvW78uvAHoL6WLp+e+nOOk3a29FHttyAKvm
         ExLm6kuiUjZZYABOvDmXE7znKz2ZVVHMt3qqBKA8xb9nLGRZJk1AsFIo+af41A2efn
         G1UcqMLFVa2y68DSr817Onny4vTG/h1HfcAv7pmM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH v2 11/21] efi/libstub: get rid of 'sys_table_arg' macro parameter
Date:   Wed, 18 Dec 2019 19:01:29 +0200
Message-Id: <20191218170139.9468-12-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218170139.9468-1-ardb@kernel.org>
References: <20191218170139.9468-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The efi_call macros on ARM have a dependency on a variable 'sys_table_arg'
existing in the scope of the macro instantiation. Since this variable
always points to the same data structure, let's create a global getter
for it and use that instead.

Note that the use of a global variable with external linkage is avoided,
given the problems we had in the past with early processing of the GOT
tables.

While at it, drop the redundant casts in the efi_table_attr and
efi_call_proto macros.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h              |  8 ++++----
 arch/arm64/include/asm/efi.h            |  8 ++++----
 arch/x86/boot/compressed/eboot.c        |  5 +++++
 drivers/firmware/efi/libstub/arm-stub.c | 11 ++++++++++-
 drivers/firmware/efi/libstub/efistub.h  |  2 ++
 drivers/firmware/efi/libstub/gop.c      |  2 ++
 6 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 9b0c64c28bff..555364b7bd2a 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -50,15 +50,15 @@ void efi_virtmap_unload(void);
 
 /* arch specific definitions used by the stub code */
 
-#define efi_call_early(f, ...)		sys_table_arg->boottime->f(__VA_ARGS__)
-#define efi_call_runtime(f, ...)	sys_table_arg->runtime->f(__VA_ARGS__)
+#define efi_call_early(f, ...)		efi_system_table()->boottime->f(__VA_ARGS__)
+#define efi_call_runtime(f, ...)	efi_system_table()->runtime->f(__VA_ARGS__)
 #define efi_is_native()			(true)
 
 #define efi_table_attr(table, attr, instance)				\
-	((table##_t *)instance)->attr
+	instance->attr
 
 #define efi_call_proto(protocol, f, instance, ...)			\
-	((protocol##_t *)instance)->f(instance, ##__VA_ARGS__)
+	instance->f(instance, ##__VA_ARGS__)
 
 struct screen_info *alloc_screen_info(efi_system_table_t *sys_table_arg);
 void free_screen_info(efi_system_table_t *sys_table, struct screen_info *si);
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 189082c44c28..9aa518d67588 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -93,15 +93,15 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 	return (image_addr & ~(SZ_1G - 1UL)) + (1UL << (VA_BITS_MIN - 1));
 }
 
-#define efi_call_early(f, ...)		sys_table_arg->boottime->f(__VA_ARGS__)
-#define efi_call_runtime(f, ...)	sys_table_arg->runtime->f(__VA_ARGS__)
+#define efi_call_early(f, ...)		efi_system_table()->boottime->f(__VA_ARGS__)
+#define efi_call_runtime(f, ...)	efi_system_table()->runtime->f(__VA_ARGS__)
 #define efi_is_native()			(true)
 
 #define efi_table_attr(table, attr, instance)				\
-	((table##_t *)instance)->attr
+	instance->attr
 
 #define efi_call_proto(protocol, f, instance, ...)			\
-	((protocol##_t *)instance)->f(instance, ##__VA_ARGS__)
+	instance->f(instance, ##__VA_ARGS__)
 
 #define alloc_screen_info(x...)		&screen_info
 
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 4a965212ee64..bed78679e10b 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -27,6 +27,11 @@ __pure const struct efi_config *__efi_early(void)
 	return efi_early;
 }
 
+__pure efi_system_table_t *efi_system_table(void)
+{
+	return sys_table;
+}
+
 static void setup_boot_services(struct efi_config *c)
 {
 	c->runtime_services	= efi_table_attr(efi_system_table, runtime, sys_table);
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 60a301e1c072..47f072ac3f30 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -37,6 +37,13 @@
 
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
 
+static efi_system_table_t *__section(.data) sys_table;
+
+__pure efi_system_table_t *efi_system_table(void)
+{
+	return sys_table;
+}
+
 void efi_char16_printk(efi_system_table_t *sys_table_arg,
 			      efi_char16_t *str)
 {
@@ -110,7 +117,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
  * for both archictectures, with the arch-specific code provided in the
  * handle_kernel_image() function.
  */
-unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
+unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 			       unsigned long *image_addr)
 {
 	efi_loaded_image_t *image;
@@ -131,6 +138,8 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
 	enum efi_secureboot_mode secure_boot;
 	struct screen_info *si;
 
+	sys_table = sys_table_arg;
+
 	/* Check if we were booted by the EFI firmware */
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		goto fail;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 05739ae013c8..e6775c16a97d 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -29,6 +29,8 @@ extern int __pure nokaslr(void);
 extern int __pure is_quiet(void);
 extern int __pure novamap(void);
 
+extern __pure efi_system_table_t  *efi_system_table(void);
+
 #define pr_efi(sys_table, msg)		do {				\
 	if (!is_quiet()) efi_printk(sys_table, "EFI stub: "msg);	\
 } while (0)
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 5f4fbc2ac687..6c49d0a9aa3f 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -10,6 +10,8 @@
 #include <asm/efi.h>
 #include <asm/setup.h>
 
+#include "efistub.h"
+
 static void find_bits(unsigned long mask, u8 *pos, u8 *size)
 {
 	u8 first, len;
-- 
2.17.1

