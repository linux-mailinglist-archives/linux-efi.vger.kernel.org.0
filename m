Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00436340FE
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiKVQLK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiKVQLD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:11:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C539742D2;
        Tue, 22 Nov 2022 08:10:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B864461740;
        Tue, 22 Nov 2022 16:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677BDC433D6;
        Tue, 22 Nov 2022 16:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133446;
        bh=Hw2/NHAhXb/vWGw1F6zOY2IxnO/vI56SXymPfFRSUKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wmbz6c7s/QjSXFggLzZ4w1sGHWgtUImVrkPWB/n2JEspTcOqnBTUwL30pVtjkLd5g
         nqHnme2/N5IEx2ipvrQ5bbhiROhegasy5KvUwug5TOUZMkPW0nTIJuvUy9PF+LUx7I
         UwOhS6ku/Tqjabtz9k6EXybxeipy7w6TfmBaabakeWHdJ9wYRPRYdixE2MjS9KMuHd
         I8xtBRUffBZEjhGU2UNAIEP1l0xeV2U1FZcqr4Hi7T6ewyzEttEpWV8QRmMeZWuis0
         li6xSlhd+5Zxepd1qYM3+u2Vwmd+8+gsrpopPhJJTiFtXJkXTXf6Fz6yFa2FMoN52P
         3v3ywoO2gcQ1A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 06/17] x86/compressed: efi-mixed: move efi32_pe_entry() out of head_64.S
Date:   Tue, 22 Nov 2022 17:10:06 +0100
Message-Id: <20221122161017.2426828-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6730; i=ardb@kernel.org; h=from:subject; bh=Hw2/NHAhXb/vWGw1F6zOY2IxnO/vI56SXymPfFRSUKQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRXpdaBO49FmkrTW40LuSlfKSo3t3bQsuE4oOGM nwvgMuyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0VwAKCRDDTyI5ktmPJFa9C/ 4nGoOyFT2p0SubaaT/MMeYHxRqD9638ZAXP9/Ijfb8Im8HOUrwAKxyJeOHiVOZql+xkiqUjjrV+mLC xeP15VWd00MxkDtYspoGEBhbuSASdKxCE+77M1wSYTDjX5Mu2EpdA2+vYiezj8KM0bo3qur8rJDJf/ pGL5qw0jThhSzQa9DM0xu2EAs+O91gqa12w4tc1bhZTjZ7mCWfvGpHVgPHZwNd/UYhGixgYQzpNeHm YBlCBUlh5CfcWV9xgbZoQCh6AJ5F/zfwIfCygyFtW/4drymqkh9S7YBxQawa18wtXzu+KjDDA7AXWu 0c96UNWj+Iut5mgXZAI/YP/X5pYBrAA4Q02TkBABOfPrVxlHhWM6lir9QxmNFXrJqyUGht8I8SHdT7 riJgksOdV4hjcBMCpHk169KbWPPnZoxO5K1J3LFtvzlyN85yPTh/vQb0ESZ3J9eP2zZV0lWlbbE/KG E13CuE6uNqrkoiyp+PvubD4DpqH4+rd3IdWvc9Hx/ccoc=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move the implementation of efi32_pe_entry() into efi-mixed.S, which is a
more suitable location that only gets built if EFI mixed mode is
actually enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 82 ++++++++++++++++++
 arch/x86/boot/compressed/head_64.S   | 87 +-------------------
 2 files changed, 83 insertions(+), 86 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 3487484ac1fd5c6c..8844d8ed4b1c7561 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -257,6 +257,88 @@ SYM_FUNC_START(efi32_entry)
 	jmp	startup_32
 SYM_FUNC_END(efi32_entry)
 
+#define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
+#define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
+#define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
+
+/*
+ * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
+ *			       efi_system_table_32_t *sys_table)
+ */
+SYM_FUNC_START(efi32_pe_entry)
+	pushl	%ebp
+	movl	%esp, %ebp
+	pushl	%eax				// dummy push to allocate loaded_image
+
+	pushl	%ebx				// save callee-save registers
+	pushl	%edi
+
+	call	verify_cpu			// check for long mode support
+	testl	%eax, %eax
+	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
+	jnz	2f
+
+	call	1f
+1:	pop	%ebx
+
+	/* Get the loaded image protocol pointer from the image handle */
+	leal	-4(%ebp), %eax
+	pushl	%eax				// &loaded_image
+	leal	(loaded_image_proto - 1b)(%ebx), %eax
+	pushl	%eax				// pass the GUID address
+	pushl	8(%ebp)				// pass the image handle
+
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
+	movl	ST32_boottime(%eax), %eax	// sys_table->boottime
+	call	*BS32_handle_protocol(%eax)	// sys_table->boottime->handle_protocol
+	addl	$12, %esp			// restore argument space
+	testl	%eax, %eax
+	jnz	2f
+
+	movl	8(%ebp), %ecx			// image_handle
+	movl	12(%ebp), %edx			// sys_table
+	movl	-4(%ebp), %esi			// loaded_image
+	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
+	leal	(startup_32 - 1b)(%ebx), %ebp	// runtime address of startup_32
+	/*
+	 * We need to set the image_offset variable here since startup_32() will
+	 * use it before we get to the 64-bit efi_pe_entry() in C code.
+	 */
+	subl	%esi, %ebp			// calculate image_offset
+	movl	%ebp, (image_offset - 1b)(%ebx)	// save image_offset
+	xorl	%esi, %esi
+	jmp	efi32_entry			// pass %ecx, %edx, %esi
+						// no other registers remain live
+
+2:	popl	%edi				// restore callee-save registers
+	popl	%ebx
+	leave
+	RET
+SYM_FUNC_END(efi32_pe_entry)
+
+	.section ".rodata"
+	/* EFI loaded image protocol GUID */
+	.balign 4
+SYM_DATA_START_LOCAL(loaded_image_proto)
+	.long	0x5b1b31a1
+	.word	0x9562, 0x11d2
+	.byte	0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b
+SYM_DATA_END(loaded_image_proto)
+
 	.data
 	.balign	8
 SYM_DATA_START_LOCAL(efi32_boot_gdt)
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 8fa92ce5610e5329..987f0a3c284fad43 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -681,6 +681,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
 	jmp     1b
 SYM_FUNC_END(.Lno_longmode)
 
+	.globl	verify_cpu
 #include "../../kernel/verify_cpu.S"
 
 	.data
@@ -728,92 +729,6 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
 #ifdef CONFIG_EFI_STUB
 SYM_DATA(image_offset, .long 0)
 #endif
-#ifdef CONFIG_EFI_MIXED
-#define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
-#define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
-#define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
-
-	.text
-	.code32
-SYM_FUNC_START(efi32_pe_entry)
-/*
- * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
- *			       efi_system_table_32_t *sys_table)
- */
-
-	pushl	%ebp
-	movl	%esp, %ebp
-	pushl	%eax				// dummy push to allocate loaded_image
-
-	pushl	%ebx				// save callee-save registers
-	pushl	%edi
-
-	call	verify_cpu			// check for long mode support
-	testl	%eax, %eax
-	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
-	jnz	2f
-
-	call	1f
-1:	pop	%ebx
-
-	/* Get the loaded image protocol pointer from the image handle */
-	leal	-4(%ebp), %eax
-	pushl	%eax				// &loaded_image
-	leal	(loaded_image_proto - 1b)(%ebx), %eax
-	pushl	%eax				// pass the GUID address
-	pushl	8(%ebp)				// pass the image handle
-
-	/*
-	 * Note the alignment of the stack frame.
-	 *   sys_table
-	 *   handle             <-- 16-byte aligned on entry by ABI
-	 *   return address
-	 *   frame pointer
-	 *   loaded_image       <-- local variable
-	 *   saved %ebx		<-- 16-byte aligned here
-	 *   saved %edi
-	 *   &loaded_image
-	 *   &loaded_image_proto
-	 *   handle             <-- 16-byte aligned for call to handle_protocol
-	 */
-
-	movl	12(%ebp), %eax			// sys_table
-	movl	ST32_boottime(%eax), %eax	// sys_table->boottime
-	call	*BS32_handle_protocol(%eax)	// sys_table->boottime->handle_protocol
-	addl	$12, %esp			// restore argument space
-	testl	%eax, %eax
-	jnz	2f
-
-	movl	8(%ebp), %ecx			// image_handle
-	movl	12(%ebp), %edx			// sys_table
-	movl	-4(%ebp), %esi			// loaded_image
-	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
-	leal	(startup_32 - 1b)(%ebx), %ebp	// runtime address of startup_32
-	/*
-	 * We need to set the image_offset variable here since startup_32() will
-	 * use it before we get to the 64-bit efi_pe_entry() in C code.
-	 */
-	subl	%esi, %ebp			// calculate image_offset
-	movl	%ebp, (image_offset - 1b)(%ebx)	// save image_offset
-	xorl	%esi, %esi
-	jmp	efi32_entry			// pass %ecx, %edx, %esi
-						// no other registers remain live
-
-2:	popl	%edi				// restore callee-save registers
-	popl	%ebx
-	leave
-	RET
-SYM_FUNC_END(efi32_pe_entry)
-
-	.section ".rodata"
-	/* EFI loaded image protocol GUID */
-	.balign 4
-SYM_DATA_START_LOCAL(loaded_image_proto)
-	.long	0x5b1b31a1
-	.word	0x9562, 0x11d2
-	.byte	0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b
-SYM_DATA_END(loaded_image_proto)
-#endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	__HEAD
-- 
2.35.1

