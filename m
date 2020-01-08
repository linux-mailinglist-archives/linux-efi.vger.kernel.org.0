Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCC85133C68
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2020 08:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgAHHpL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jan 2020 02:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgAHHpL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 8 Jan 2020 02:45:11 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B8B2082E;
        Wed,  8 Jan 2020 07:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578469510;
        bh=r4Qpq80aUu09MFgOTnRq7ceRcS2KRxaePcGw1mSoenA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDnlGtMA6aZV481XAsSlrUbXbESlJLp1lN/fO7MnVDFbsmhPYdxva1W/k6KDKqYXr
         1OfSxDVm3fJ6QHn7h/AUVrf4mH656Wr5f7hVMlroNaGAiCHsvqPMecO0DOnq8uD6ZV
         89ChvUKUFBYFA26j92CoDfwxZQSRgp9ySIuSO3xk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     luto@kernel.org, x86@kernel.org, nivedita@alum.mit.edu,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/2] efi/libstub/x86: use const attribute for efi_is_64bit()
Date:   Wed,  8 Jan 2020 08:45:01 +0100
Message-Id: <20200108074502.10960-2-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108074502.10960-1-ardb@kernel.org>
References: <20200108074502.10960-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Reshuffle the x86 stub code a bit so that we can tag the efi_is_64bit()
function with the 'const' attribute, which permits the compiler to
optimize away any redundant calls. Since we have two different entry
points for 32 and 64 bit firmware in the startup code, this also
simplifies the C code since we'll enter it with the efi_is64 variable
already set.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c   | 14 ++++++--------
 arch/x86/boot/compressed/head_64.S |  7 +++----
 arch/x86/include/asm/efi.h         |  2 +-
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 4afd29eb5b34..ab3a40283db7 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -21,16 +21,18 @@
 #include "eboot.h"
 
 static efi_system_table_t *sys_table;
-static bool efi_is64 = IS_ENABLED(CONFIG_X86_64);
+extern const bool efi_is64;
 
 __pure efi_system_table_t *efi_system_table(void)
 {
 	return sys_table;
 }
 
-__pure bool efi_is_64bit(void)
+__attribute_const__ bool efi_is_64bit(void)
 {
-	return efi_is64;
+	if (IS_ENABLED(CONFIG_EFI_MIXED))
+		return efi_is64;
+	return IS_ENABLED(CONFIG_X64_64);
 }
 
 static efi_status_t
@@ -710,8 +712,7 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
  */
 struct boot_params *efi_main(efi_handle_t handle,
 			     efi_system_table_t *sys_table_arg,
-			     struct boot_params *boot_params,
-			     bool is64)
+			     struct boot_params *boot_params)
 {
 	struct desc_ptr *gdt = NULL;
 	struct setup_header *hdr = &boot_params->hdr;
@@ -721,9 +722,6 @@ struct boot_params *efi_main(efi_handle_t handle,
 
 	sys_table = sys_table_arg;
 
-	if (IS_ENABLED(CONFIG_EFI_MIXED))
-		efi_is64 = is64;
-
 	/* Check if we were booted by the EFI firmware */
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		goto fail;
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 44a6bb6964b5..1f1f6c8139b3 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -211,10 +211,9 @@ SYM_FUNC_START(startup_32)
 	movl	efi32_boot_args(%ebp), %edi
 	cmp	$0, %edi
 	jz	1f
-	leal	handover_entry(%ebp), %eax
+	leal	efi64_stub_entry(%ebp), %eax
 	movl	%esi, %edx
 	movl	efi32_boot_args+4(%ebp), %esi
-	movl	$0x0, %ecx
 1:
 #endif
 	pushl	%eax
@@ -242,6 +241,7 @@ SYM_FUNC_START(efi32_stub_entry)
 	movl	%ecx, efi32_boot_args(%ebp)
 	movl	%edx, efi32_boot_args+4(%ebp)
 	sgdtl	efi32_boot_gdt(%ebp)
+	movb	$0, efi_is64(%ebp)
 
 	/* Disable paging */
 	movl	%cr0, %eax
@@ -452,8 +452,6 @@ SYM_CODE_END(startup_64)
 	.org 0x390
 SYM_FUNC_START(efi64_stub_entry)
 SYM_FUNC_START_ALIAS(efi_stub_entry)
-	movq	$1, %rcx
-SYM_INNER_LABEL(handover_entry, SYM_L_LOCAL)
 	and	$~0xf, %rsp			/* realign the stack */
 	call	efi_main
 	movq	%rax,%rsi
@@ -632,6 +630,7 @@ SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
 #ifdef CONFIG_EFI_MIXED
 SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0)
+SYM_DATA(efi_is64, .byte 1)
 #endif
 
 /*
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 9ce697a621cc..86169a24b0d8 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -223,7 +223,7 @@ efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
 
 /* arch specific definitions used by the stub code */
 
-__pure bool efi_is_64bit(void);
+__attribute_const__ bool efi_is_64bit(void);
 
 static inline bool efi_is_native(void)
 {
-- 
2.20.1

