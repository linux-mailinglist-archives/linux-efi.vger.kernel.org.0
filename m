Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362E511F342
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 18:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfLNR57 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 12:57:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfLNR56 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 14 Dec 2019 12:57:58 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B84214D8;
        Sat, 14 Dec 2019 17:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576346276;
        bh=hG8LK0ZdOxOzcwZvBZ398uDTmQhGwn0mcj3PF44L3QI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CdTtD3ra+M4ZcSQF7JxWaQPbhbEGJ+vqJ+ibwrw6ChDtCsnJ321R7vP4+fsbXQVKL
         G7bpEKqfwG7Lf+LTonSVNAb9WHYl0y7Z8RND3IIjD/OVystlS8GUyO8T0LOOEbAQiL
         BNYvj9ZkqmsUYsvcFR8MhKUaibMkOKDAxe20Xsgk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 06/10] efi/libstub/x86: use mixed mode helpers to populate efi_config
Date:   Sat, 14 Dec 2019 18:57:31 +0100
Message-Id: <20191214175735.22518-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214175735.22518-1-ardb@kernel.org>
References: <20191214175735.22518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The efi_config struct returned by __efi_early() contains a couple
of pointers that are obtained from the EFI system table, which
could be 32-bit on a 64-bit system. For this reason, there are
two versions of the setup_boot_services() routine, one for 32-bit
and one for 64-bit.

We have helpers now that hide all this nastiness, so let's use
those instead.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c   | 27 +++++---------------
 arch/x86/boot/compressed/head_32.S |  6 ++---
 arch/x86/include/asm/efi.h         |  6 ++---
 arch/x86/platform/efi/efi.c        |  4 +--
 include/linux/efi.h                |  6 ++---
 5 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 34962f2f3337..6d833f93a878 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -27,19 +27,12 @@ __pure const struct efi_config *__efi_early(void)
 	return efi_early;
 }
 
-#define BOOT_SERVICES(bits)						\
-static void setup_boot_services##bits(struct efi_config *c)		\
-{									\
-	efi_system_table_##bits##_t *table;				\
-									\
-	table = (typeof(table))sys_table;				\
-									\
-	c->runtime_services	= table->runtime;			\
-	c->boot_services	= table->boottime;			\
-	c->text_output		= table->con_out;			\
+static void setup_boot_services(struct efi_config *c)
+{
+	c->runtime_services	= efi_table_attr(efi_system_table, runtime, sys_table);
+	c->boot_services	= efi_table_attr(efi_system_table, boottime, sys_table);
+	c->text_output		= efi_table_attr(efi_system_table, con_out, sys_table);
 }
-BOOT_SERVICES(32);
-BOOT_SERVICES(64);
 
 void efi_char16_printk(efi_system_table_t *table, efi_char16_t *str)
 {
@@ -399,10 +392,7 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		return NULL;
 
-	if (efi_is_64bit())
-		setup_boot_services64(efi_early);
-	else
-		setup_boot_services32(efi_early);
+	setup_boot_services(efi_early);
 
 	status = efi_call_early(handle_protocol, handle,
 				&proto, (void *)&image);
@@ -761,10 +751,7 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		goto fail;
 
-	if (efi_is_64bit())
-		setup_boot_services64(efi_early);
-	else
-		setup_boot_services32(efi_early);
+	setup_boot_services(efi_early);
 
 	/*
 	 * make_boot_params() may have been called before efi_main(), in which
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index f2dfd6d083ef..40468ab49b9b 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -163,7 +163,7 @@ SYM_FUNC_START(efi_pe_entry)
 
 	/* Relocate efi_config->call() */
 	leal	efi32_config(%esi), %eax
-	add	%esi, 40(%eax)
+	add	%esi, 28(%eax)
 	pushl	%eax
 
 	call	make_boot_params
@@ -190,7 +190,7 @@ SYM_FUNC_START(efi32_stub_entry)
 
 	/* Relocate efi_config->call() */
 	leal	efi32_config(%esi), %eax
-	add	%esi, 40(%eax)
+	add	%esi, 28(%eax)
 	pushl	%eax
 2:
 	call	efi_main
@@ -265,7 +265,7 @@ SYM_FUNC_END(.Lrelocated)
 #ifdef CONFIG_EFI_STUB
 	.data
 efi32_config:
-	.fill 5,8,0
+	.fill 7,4,0
 	.long efi_call_phys
 	.long 0
 	.byte 0
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 37364c43296e..2244232108a0 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -202,9 +202,9 @@ static inline efi_status_t efi_thunk_set_virtual_address_map(
 struct efi_config {
 	u64 image_handle;
 	u64 table;
-	u64 runtime_services;
-	u64 boot_services;
-	u64 text_output;
+	efi_runtime_services_t *runtime_services;
+	efi_boot_services_t *boot_services;
+	efi_simple_text_output_protocol_t *text_output;
 	efi_status_t (*call)(unsigned long, ...);
 	bool is64;
 } __packed;
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 1493e964c267..27700268ed4a 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -388,7 +388,7 @@ static int __init efi_systab_init(void *phys)
 		tmp |= systab64->con_in;
 		efi_systab.con_out_handle = systab64->con_out_handle;
 		tmp |= systab64->con_out_handle;
-		efi_systab.con_out = systab64->con_out;
+		efi_systab.con_out = (void *)(unsigned long)systab64->con_out;
 		tmp |= systab64->con_out;
 		efi_systab.stderr_handle = systab64->stderr_handle;
 		tmp |= systab64->stderr_handle;
@@ -430,7 +430,7 @@ static int __init efi_systab_init(void *phys)
 		efi_systab.con_in_handle = systab32->con_in_handle;
 		efi_systab.con_in = systab32->con_in;
 		efi_systab.con_out_handle = systab32->con_out_handle;
-		efi_systab.con_out = systab32->con_out;
+		efi_systab.con_out = (void *)(unsigned long)systab32->con_out;
 		efi_systab.stderr_handle = systab32->stderr_handle;
 		efi_systab.stderr = systab32->stderr;
 		efi_systab.runtime = (void *)(unsigned long)systab32->runtime;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7d7ea32a9990..e17c16d8d523 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -810,7 +810,7 @@ typedef struct {
 	unsigned long con_in_handle;
 	unsigned long con_in;
 	unsigned long con_out_handle;
-	unsigned long con_out;
+	struct efi_simple_text_output_protocol *con_out;
 	unsigned long stderr_handle;
 	unsigned long stderr;
 	efi_runtime_services_t *runtime;
@@ -1445,11 +1445,11 @@ typedef struct {
 	u64 test_string;
 } efi_simple_text_output_protocol_64_t;
 
-struct efi_simple_text_output_protocol {
+typedef struct efi_simple_text_output_protocol {
 	void *reset;
 	efi_status_t (*output_string)(void *, void *);
 	void *test_string;
-};
+} efi_simple_text_output_protocol_t;
 
 #define PIXEL_RGB_RESERVED_8BIT_PER_COLOR		0
 #define PIXEL_BGR_RESERVED_8BIT_PER_COLOR		1
-- 
2.17.1

