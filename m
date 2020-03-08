Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E7A17D270
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCHIJq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgCHIJq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:09:46 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45DE42146E;
        Sun,  8 Mar 2020 08:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583654985;
        bh=O0pfjgt8W4HZX12SXd+ODFIBPHBlX/yJxr6ENHQMr5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmDhZbTCJfYZY6c17Ag7oriGNsW0XK9PUr3xVN5x9hcy4G8Uwwk4OJIhXz2uEDG0B
         MIvjxYnXL+3lnGRqoWhs7f/IEb/V95TiwCGev9WSiKgT5sLC39v7Qf+FhWxGCFv8YD
         ZBYqfztREf30wZbHvarjYBUvlKcFMAdImyOjHs+A=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 11/28] efi/x86: Make efi32_pe_entry more readable
Date:   Sun,  8 Mar 2020 09:08:42 +0100
Message-Id: <20200308080859.21568-12-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Setup a proper frame pointer in efi32_pe_entry so that it's easier to
calculate offsets for arguments.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200301230436.2246909-4-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 57 +++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 25fa763f4e83..b74a012a6fea 100644
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
2.17.1

