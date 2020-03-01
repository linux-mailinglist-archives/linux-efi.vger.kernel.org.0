Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0F1750C1
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 00:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCAXEl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 18:04:41 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32933 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCAXEk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 18:04:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id x8so4111680qts.0;
        Sun, 01 Mar 2020 15:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUjIIsPXPmqVI6pKRaapg6FxwXRBN7yq/9Q9SfoYuSg=;
        b=r88TRoy2X2zJDT73nWbIeEZ7OeQuVD/UIyt/6rAar357qAivbB9n3qjqQz5jHP2QWV
         8PL6TOq7P+lN9v/bObsA0SQ4ibVzcSCcd/hfIf1fSwWvVmANnxQcSuOGIGX058DCEe9J
         f5ucb408+zJEDBFUJ6lh6mNStfEvAJ8dvQBHtOV/ZUpZ2p7ck8PKhtFrRpVfg/GthtSu
         /GmKeuVlzx04wUt5X+ogIC0iyc+NIuz7r5koU+Y0DHPNGIMiCtC/PM7gGisGFK8L2ECc
         u/QbsGoSBQO2SRLcEHdczvikQbpZS193uPG+4wUboe1NULpcLfzbd2UJPYp+DHt26h3O
         kNyA==
X-Gm-Message-State: ANhLgQ3RlVKMoBEl8dohSPn60uezo5+uvdslys6b7X2oKlw39HK7EnxD
        XJ395ls1bmMNMHpi/jTPhck=
X-Google-Smtp-Source: ADFU+vsYAIdS2YWQfdA/f/nvEC++maOnxktB9K4vPdLL6bZVhnK6dPUBWrJoOG04FjioiuNNSi+ZCQ==
X-Received: by 2002:ac8:6d10:: with SMTP id o16mr3479482qtt.308.1583103879876;
        Sun, 01 Mar 2020 15:04:39 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n138sm9065082qkn.33.2020.03.01.15.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:04:39 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] efi/x86: Make efi32_pe_entry more readable
Date:   Sun,  1 Mar 2020 18:04:34 -0500
Message-Id: <20200301230436.2246909-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301230436.2246909-1-nivedita@alum.mit.edu>
References: <20200301230436.2246909-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Setup a proper frame pointer in efi32_pe_entry so that it's easier to
calculate offsets for arguments.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_64.S | 57 +++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 920daf62dac2..fabbd4c2e9f2 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -658,42 +658,65 @@ SYM_DATA(efi_is64, .byte 1)
 	.text
 	.code32
 SYM_FUNC_START(efi32_pe_entry)
+/*
+ * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
+ *			       efi_system_table_32_t *sys_table)
+ */
+
 	pushl	%ebp
+	movl	%esp, %ebp
+	pushl	%eax				// dummy push to allocate loaded_image
 
-	pushl	%ebx
+	pushl	%ebx				// save callee-save registers
 	pushl	%edi
+
 	call	verify_cpu			// check for long mode support
-	popl	%edi
-	popl	%ebx
 	testl	%eax, %eax
 	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
-	jnz	3f
+	jnz	2f
 
 	call	1f
-1:	pop	%ebp
-	subl	$1b, %ebp
+1:	pop	%ebx
+	subl	$1b, %ebx
 
 	/* Get the loaded image protocol pointer from the image handle */
-	subl	$12, %esp			// space for the loaded image pointer
-	pushl	%esp				// pass its address
-	leal	loaded_image_proto(%ebp), %eax
+	leal	-4(%ebp), %eax
+	pushl	%eax				// &loaded_image
+	leal	loaded_image_proto(%ebx), %eax
 	pushl	%eax				// pass the GUID address
-	pushl	28(%esp)			// pass the image handle
+	pushl	8(%ebp)				// pass the image handle
 
-	movl	36(%esp), %eax			// sys_table
+	/*
+	 * Note the alignment of the stack frame.
+	 *   sys_table
+	 *   handle             <-- 16-byte aligned on entry by ABI
+	 *   return address
+	 *   frame pointer
+	 *   loaded_image       <-- local variable
+	 *   saved %ebx		<-- 16-byte aligned here
+	 *   saved %edi
+	 *   &loaded_image
+	 *   &loaded_image_proto
+	 *   handle             <-- 16-byte aligned for call to handle_protocol
+	 */
+
+	movl	12(%ebp), %eax			// sys_table
 	movl	ST32_boottime(%eax), %eax	// sys_table->boottime
 	call	*BS32_handle_protocol(%eax)	// sys_table->boottime->handle_protocol
-	cmp	$0, %eax
+	addl	$12, %esp			// restore argument space
+	testl	%eax, %eax
 	jnz	2f
 
-	movl	32(%esp), %ecx			// image_handle
-	movl	36(%esp), %edx			// sys_table
-	movl	12(%esp), %esi			// loaded_image
+	movl	8(%ebp), %ecx			// image_handle
+	movl	12(%ebp), %edx			// sys_table
+	movl	-4(%ebp), %esi			// loaded_image
 	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
+	movl	%ebx, %ebp			// startup_32 for efi32_pe_stub_entry
 	jmp	efi32_pe_stub_entry
 
-2:	addl	$24, %esp
-3:	popl	%ebp
+2:	popl	%edi				// restore callee-save registers
+	popl	%ebx
+	leave
 	ret
 SYM_FUNC_END(efi32_pe_entry)
 
-- 
2.24.1

