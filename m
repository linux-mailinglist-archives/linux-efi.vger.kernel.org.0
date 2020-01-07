Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77BE13282F
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 14:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgAGNzF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 08:55:05 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40566 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGNzE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 08:55:04 -0500
Received: by mail-qt1-f194.google.com with SMTP id e6so45339957qtq.7
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 05:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ilyu7B8QNbYu4Z+xlLUaXz7mlV12SYkVD0ib7qJ5gco=;
        b=MidNBYFJSWfMOAM3L+QCRJkLJqQDDem3u0m6ld9CS2Ttz0hALdZHZTt+2dT9ipztry
         ZGPb8F3QCggCCjui2zPHttMgr/n/eX5n3ukrxjk0puhH4ZvG0eZEBr4o8IRSgik+trNe
         Rnoan17tzXkmeqkJI9U0gvb8bI50Zgow3E8G3YKPa9tpwtf4oDHrSblxvPnDzRbF/NlC
         HSMLnJT0TpOd7KQOmiImeKlbE65XE52gmAswA7JbSrvSbPJS6xfSFjF6bq3qqUuYkXht
         9vyXImnNMD+xeibzP4hlMYduSEkJYonF8gAUFOktizr20DbH8UlurCBK0iV9OO7l06u9
         wAWg==
X-Gm-Message-State: APjAAAU6izUBtD4eNc/1Tfp0xsg0hf6uC6+ytmU9i9nOseA2ZRmii29/
        0Q5pZ629PMunadt9q33I3Aq9VREn
X-Google-Smtp-Source: APXvYqxFn0Zn9wQ4V+XFaCWSu/1IkUoV4pX9K6PgNUWOFVpViHlFEpt8kOhNZ3mt3LEb/zCZhhHHhg==
X-Received: by 2002:aed:2050:: with SMTP id 74mr61460440qta.217.1578405303713;
        Tue, 07 Jan 2020 05:55:03 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v24sm25080627qtq.14.2020.01.07.05.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:55:03 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 3/3] x86/boot: Perform GOT relocation before calling EFI stub
Date:   Tue,  7 Jan 2020 08:55:00 -0500
Message-Id: <20200107135500.644618-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107135500.644618-1-nivedita@alum.mit.edu>
References: <20200107135500.644618-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

While the EFI stub code does not generally require a GOT, it is very
easy to write code that would require a GOT with an old toolchain, but
that modern toolchains optimize to eliminate the GOT references. This
can lead to unexpected crashes if the kernel is built with an older
toolchain.

To avoid potential issues, move the efi_pe_entry back to assembler, and
relocate the GOT if present before calling any C code.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/eboot.c   |  4 ++--
 arch/x86/boot/compressed/head_32.S | 23 ++++++++++++++++++++++-
 arch/x86/boot/compressed/head_64.S | 18 ++++++++++++++++++
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index ab3a40283db7..b62f957274aa 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -356,8 +356,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
  * need to create one ourselves (usually the bootloader would create
  * one for us).
  */
-efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
-				   efi_system_table_t *sys_table_arg)
+efi_status_t efi_entry(efi_handle_t handle,
+		       efi_system_table_t *sys_table_arg)
 {
 	struct boot_params *boot_params;
 	struct apm_bios_info *bi;
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 973ac0b51af5..171947ae5b8c 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -145,9 +145,29 @@ SYM_FUNC_START(startup_32)
 SYM_FUNC_END(startup_32)
 
 #ifdef CONFIG_EFI_STUB
+
+SYM_FUNC_START(efi_pe_entry)
+	/* Adjust the GOT */
+	/* Don't clobber EBX as we may return to firmware in case of error */
+	pushl	%ebx
+	call	1f
+1:	popl	%ebx
+	subl	$1b, %ebx
+	call	.Ladjust_got
+	popl	%ebx
+	/* Transfer control to C entry */
+	jmp	efi_entry
+SYM_FUNC_END(efi_pe_entry)
+
 SYM_FUNC_START(efi32_stub_entry)
 SYM_FUNC_START_ALIAS(efi_stub_entry)
-	add	$0x4, %esp
+	/* We cannot return from here */
+	addl	$0x4, %esp
+	/* Adjust the GOT */
+	call	1f
+1:	popl	%ebx
+	subl	$1b, %ebx
+	call	.Ladjust_got
 	call	efi_main
 	movl	%eax, %esi
 	movl	BP_code32_start(%esi), %eax
@@ -155,6 +175,7 @@ SYM_FUNC_START_ALIAS(efi_stub_entry)
 	jmp	*%eax
 SYM_FUNC_END(efi32_stub_entry)
 SYM_FUNC_END_ALIAS(efi_stub_entry)
+
 #endif
 
 	.text
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1464d8d0ec66..5a295d41a7a8 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -421,9 +421,26 @@ trampoline_return:
 SYM_CODE_END(startup_64)
 
 #ifdef CONFIG_EFI_STUB
+
+SYM_FUNC_START(efi_pe_entry)
+	/* Convert arguments to SysV ABI */
+	movq	%rcx, %rdi
+	movq	%rdx, %rsi
+	/* Adjust the GOT */
+	call	.Ladjust_got
+	/* Transfer control to C entry */
+	jmp	efi_entry
+SYM_FUNC_END(efi_pe_entry)
+
 	.org 0x390
 SYM_FUNC_START(efi64_stub_entry)
 SYM_FUNC_START_ALIAS(efi_stub_entry)
+	/* We cannot return from here */
+	addq	$8, %rsp
+	/* Adjust the GOT */
+	pushq	%rdx
+	call	.Ladjust_got
+	popq	%rdx
 	and	$~0xf, %rsp			/* realign the stack */
 	call	efi_main
 	movq	%rax,%rsi
@@ -432,6 +449,7 @@ SYM_FUNC_START_ALIAS(efi_stub_entry)
 	jmp	*%rax
 SYM_FUNC_END(efi64_stub_entry)
 SYM_FUNC_END_ALIAS(efi_stub_entry)
+
 #endif
 
 	.text
-- 
2.24.1

