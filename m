Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99E9124EB0
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2019 18:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfLRRDC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Dec 2019 12:03:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfLRRDC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Dec 2019 12:03:02 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B3C72176D;
        Wed, 18 Dec 2019 17:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576688580;
        bh=fuF0iJkEdI2GqIzTqnNC2sAapdeKhCnf+CVK+EvAL/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sRdw52gLaR/mKQDFXsfHu9CLsZX4pxubVLYcaye/aZXpGbo2xs/Onik2JjGdKCit3
         QLd1YTQbRjqkyRBRYBUhrsYYOx3o9+Kox0f3bRiIOahAJE8adt8BqYSWzAC6XVlcJx
         dH0eKl6XQaVDQ8uOOpasia39KmfGojb68JU1GL/4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of efi_config struct
Date:   Wed, 18 Dec 2019 19:01:31 +0200
Message-Id: <20191218170139.9468-14-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218170139.9468-1-ardb@kernel.org>
References: <20191218170139.9468-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The various pointers we stash in the efi_config struct which we
retrieve using __efi_early() are simply copies of the ones in
the EFI system table, which we have started accessing directly
in the previous patch. So drop all the __efi_early() related
plumbing, except for the access to a boolean which tells us
whether the firmware is 64-bit or not.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c   | 36 ++++++++------------
 arch/x86/boot/compressed/head_32.S |  2 +-
 arch/x86/boot/compressed/head_64.S |  4 +--
 arch/x86/include/asm/efi.h         | 23 +++++--------
 4 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 2bcab1ef5a56..53e67334c4c3 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -20,11 +20,17 @@
 
 static efi_system_table_t *sys_table;
 
-static struct efi_config *efi_early;
+struct efi_config {
+	u64 image_handle;
+	u64 table;
+	bool is64;
+} __packed;
 
-__pure const struct efi_config *__efi_early(void)
+static bool is64;
+
+__pure bool __efi_early_is64(void)
 {
-	return efi_early;
+	return is64;
 }
 
 __pure efi_system_table_t *efi_system_table(void)
@@ -32,13 +38,6 @@ __pure efi_system_table_t *efi_system_table(void)
 	return sys_table;
 }
 
-static void setup_boot_services(struct efi_config *c)
-{
-	c->runtime_services	= efi_table_attr(efi_system_table, runtime, sys_table);
-	c->boot_services	= efi_table_attr(efi_system_table, boottime, sys_table);
-	c->text_output		= efi_table_attr(efi_system_table, con_out, sys_table);
-}
-
 static efi_status_t
 preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 {
@@ -382,16 +381,14 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	unsigned long ramdisk_addr;
 	unsigned long ramdisk_size;
 
-	efi_early = c;
-	sys_table = (efi_system_table_t *)(unsigned long)efi_early->table;
-	handle = (void *)(unsigned long)efi_early->image_handle;
+	sys_table = (efi_system_table_t *)(unsigned long)c->table;
+	handle = (void *)(unsigned long)c->image_handle;
+	is64 = c->is64;
 
 	/* Check if we were booted by the EFI firmware */
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		return NULL;
 
-	setup_boot_services(efi_early);
-
 	status = efi_call_early(handle_protocol, handle,
 				&proto, (void *)&image);
 	if (status != EFI_SUCCESS) {
@@ -738,10 +735,9 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 	efi_system_table_t *_table;
 	unsigned long cmdline_paddr;
 
-	efi_early = c;
-
-	_table = (efi_system_table_t *)(unsigned long)efi_early->table;
-	handle = (void *)(unsigned long)efi_early->image_handle;
+	_table = (efi_system_table_t *)(unsigned long)c->table;
+	handle = (void *)(unsigned long)c->image_handle;
+	is64 = c->is64;
 
 	sys_table = _table;
 
@@ -749,8 +745,6 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		goto fail;
 
-	setup_boot_services(efi_early);
-
 	/*
 	 * make_boot_params() may have been called before efi_main(), in which
 	 * case this is the second time we parse the cmdline. This is ok,
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 7da4dfc53df6..c026ab881405 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -261,7 +261,7 @@ SYM_FUNC_END(.Lrelocated)
 #ifdef CONFIG_EFI_STUB
 	.data
 efi32_config:
-	.fill 7,4,0
+	.fill 4,4,0
 	.byte 0
 #endif
 
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 6dc6a7ebb9e1..72065735abc1 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -672,13 +672,13 @@ SYM_DATA_LOCAL(efi_config, .quad 0)
 
 #ifdef CONFIG_EFI_MIXED
 SYM_DATA_START(efi32_config)
-	.fill	5,8,0
+	.fill	2,8,0
 	.byte	0
 SYM_DATA_END(efi32_config)
 #endif
 
 SYM_DATA_START(efi64_config)
-	.fill	5,8,0
+	.fill	2,8,0
 	.byte	1
 SYM_DATA_END(efi64_config)
 #endif /* CONFIG_EFI_STUB */
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index e0789ec5c9f6..8137d4f5c104 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -200,16 +200,7 @@ static inline efi_status_t efi_thunk_set_virtual_address_map(
 
 /* arch specific definitions used by the stub code */
 
-struct efi_config {
-	u64 image_handle;
-	u64 table;
-	efi_runtime_services_t *runtime_services;
-	efi_boot_services_t *boot_services;
-	efi_simple_text_output_protocol_t *text_output;
-	bool is64;
-} __packed;
-
-__pure const struct efi_config *__efi_early(void);
+__pure bool __efi_early_is64(void);
 
 static inline bool efi_is_64bit(void)
 {
@@ -219,7 +210,7 @@ static inline bool efi_is_64bit(void)
 	if (!IS_ENABLED(CONFIG_EFI_MIXED))
 		return true;
 
-	return __efi_early()->is64;
+	return __efi_early_is64();
 }
 
 static inline bool efi_is_native(void)
@@ -252,14 +243,16 @@ static inline bool efi_is_native(void)
 
 #define efi_call_early(f, ...)						\
 	(efi_is_native()						\
-		? __efi_early()->boot_services->f(__VA_ARGS__)		\
-		: efi64_thunk(__efi_early()->boot_services->mixed_mode.f,\
+		? efi_system_table()->boottime->f(__VA_ARGS__)		\
+		: efi64_thunk(efi_table_attr(efi_boot_services,		\
+			boottime, efi_system_table())->mixed_mode.f,	\
 			__VA_ARGS__))
 
 #define efi_call_runtime(f, ...)					\
 	(efi_is_native()						\
-		? __efi_early()->runtime_services->f(__VA_ARGS__)	\
-		: efi64_thunk(__efi_early()->runtime_services->mixed_mode.f,\
+		? efi_system_table()->runtime->f(__VA_ARGS__)		\
+		: efi64_thunk(efi_table_attr(efi_runtime_services,	\
+			runtime, efi_system_table())->mixed_mode.f,	\
 			__VA_ARGS__))
 
 extern bool efi_reboot_required(void);
-- 
2.17.1

