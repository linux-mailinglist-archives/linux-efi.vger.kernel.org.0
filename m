Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BFC5C006C
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiIUOzJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiIUOyt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:54:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0746621274;
        Wed, 21 Sep 2022 07:54:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 13904CE1D9A;
        Wed, 21 Sep 2022 14:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D8FC43470;
        Wed, 21 Sep 2022 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772082;
        bh=NK01Ptc0Knri4fwSSxLTZJDwNsU8cyDPzfvm17IQIMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NKIvydovmE+HTQL6rh7YDVbwepaQGLFvsTTPsIbyXoq6tIujsKAQskYJm69/+2P+i
         rwUCrqZ8Hi+SLxbnyLKAEjde+CxPvTu/i/cswT2L+9UXb9KYO2VmnZi/qGL+1R7xQz
         jSa9K/tV0YscEdSHfQtdqbzPfXDVGnolGY29hHCSXADeFrlQWF5hJvaE6m7dIHq1z/
         BiLEbHNYuxsX2fsmWUSUwDBIn/v67wMFuzvGSWqKv8E7V7Q5HR48w7PrFzyMz06RJi
         9qvb/YgOR4aT/DPcmP2Pw1CniwsV7PTWUR+ifJ667ZsSeCj/MMNTX+D5SvbINWWpq0
         de7kenMpa2v8w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 06/16] x86/compressed: efi-mixed: move efi32_pe_entry() out of head_64.S
Date:   Wed, 21 Sep 2022 16:54:12 +0200
Message-Id: <20220921145422.437618-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6576; i=ardb@kernel.org; h=from:subject; bh=NK01Ptc0Knri4fwSSxLTZJDwNsU8cyDPzfvm17IQIMA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWNuDyGXEdoWMwh7dkHdqw1aCMN9m22aDQW5bnh 1cHq00SJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYysljQAKCRDDTyI5ktmPJKA2C/ 4rPM9OTTMPG29oXbepy6QAATfyQS8V2f8xbll8wz94P7OKOjrOZqlO89XMqpTslRIktV3A5i8ev4tA /Vpn70D4OQTUqlNJijM/VQvVSShS7qbgBnUaEbeWQtrvmXtO2ENOFwZFXWgVcVW9H/BmUJpVUncWRx Q5gpMzE2KxHqkc8QtcyGcJ0njpJ63Vkz9dF/mKFJT/Ar91ybY3VZB1dA3njq4dVAd/iB+QWij5zv2/ P7ltrzEo2dKFXu32lE0viunoGIATlK8oHdZ7yLUUe+r5yprMv7PdFhKoOWUocStVJS+PcDczFewxy3 XP/pnK4LbhCDrj/5RaNEX/h3OMqTrUa0dV90AgP+QyKLzc/DXu2f0PWMG7By9dkH0pVZw+BHiJtU9v INviqX7LRLLIC0G8rVFotr9NUWV1YuHPjSO9eYlSUtzEMgPlDc+dQT/2MnIXYFtjIItFr/9sw8LRSU nNIQIIS6cVYSWVH0JbVxc13y840Db9KH3RCYzh5nEnWv0=
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
 arch/x86/boot/compressed/efi_mixed.S | 81 ++++++++++++++++++
 arch/x86/boot/compressed/head_64.S   | 86 +-------------------
 2 files changed, 82 insertions(+), 85 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 5007a44cd966..838514f7685a 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -244,6 +244,87 @@ SYM_FUNC_START(efi32_entry)
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
+	jmp	efi32_entry
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
index be95d5685717..8da2396a35a8 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -673,6 +673,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
 	jmp     1b
 SYM_FUNC_END(.Lno_longmode)
 
+	.globl	verify_cpu
 #include "../../kernel/verify_cpu.S"
 
 	.data
@@ -720,91 +721,6 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
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
-	jmp	efi32_entry
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

