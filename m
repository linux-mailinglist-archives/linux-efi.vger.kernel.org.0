Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF2915C0D6
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 16:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBMO77 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 09:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbgBMO77 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Feb 2020 09:59:59 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A2724649;
        Thu, 13 Feb 2020 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581605998;
        bh=DOTtRdFIB/hKfBqsFmk6QEVi/+0venotMXHhie8bOHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1CK2t9slELuYxzfifGliWa30UPhanY+znLU/D2XckDAK1e1oyfSDsgf4Mf0p/lUd6
         80wr7d4KiG8o3Pd6637iUOAXZKTKmuUTRUjNTZaXQ+pOWqR5HMo+bq0UZKNZXrm/pK
         NpjjgA4B3yTRgKuskKiUUujDoE5rJCBctr2dlCCA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, daniel.kiper@oracle.com, hdegoede@redhat.com,
        nivedita@alum.mit.edu, mbrown@fensystems.co.uk, mingo@kernel.org
Subject: [RFC PATCH 3/3] efi/x86: implement mixed mode boot without the handover protocol
Date:   Thu, 13 Feb 2020 15:59:28 +0100
Message-Id: <20200213145928.7047-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213145928.7047-1-ardb@kernel.org>
References: <20200213145928.7047-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add support for booting 64-bit x86 kernels from 32-bit firmware running
on 64-bit capable CPUs without requiring the bootloader to implement
the EFI handover protocol, allocate the setup block etc etc, all of
which can be done by the stub using code we have already implemented.

Instead, create an ordinary EFI application entrypoint but implemented
in 32-bit code, so that it can be invoked by 32-bit firmware, and stash
the address of this 32-bit entrypoint in the .compat section where the
bootloader can find it.

Note that we use the setup block embedded in the binary to go through
startup_32(), but it gets reallocated and copied in efi_pe_entry(),
using the same code that runs when the x86 kernel is booted in EFI
mode from native firmware. This requires the loaded image protocol to
be installed on the kernel image's EFI handle, and point to the kernel
image itself and not to its loader. This, in turn, requires the
bootloader to use the LoadImage() boot services to load the 64-bit
image from 32-bit firmware, which is in fact supported by firmware
based on EDK2. (Only StartImage() will fail, and instead, the newly
added entrypoint needs to be invoked)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 61 +++++++++++++++++++-
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a4f5561c1c0e..7baaf9c97f5a 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -207,8 +207,8 @@ SYM_FUNC_START(startup_32)
 	cmp	$0, %edi
 	jz	1f
 	leal	efi64_stub_entry(%ebp), %eax
-	movl	%esi, %edx
 	movl	efi32_boot_args+4(%ebp), %esi
+	movl	efi32_boot_args+8(%ebp), %edx	// saved bootparams pointer
 1:
 #endif
 	pushl	%eax
@@ -233,6 +233,8 @@ SYM_FUNC_START(efi32_stub_entry)
 1:	pop	%ebp
 	subl	$1b, %ebp
 
+	movl	%esi, efi32_boot_args+8(%ebp)
+2:
 	movl	%ecx, efi32_boot_args(%ebp)
 	movl	%edx, efi32_boot_args+4(%ebp)
 	movb	$0, efi_is64(%ebp)
@@ -249,6 +251,49 @@ SYM_FUNC_START(efi32_stub_entry)
 
 	jmp	startup_32
 SYM_FUNC_END(efi32_stub_entry)
+
+#define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
+#define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
+#define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
+
+	.subsection 1
+	.code32
+SYM_FUNC_START(efi32_pe_entry)
+	pushl	%ebp
+
+	call	3f
+3:	pop	%ebp
+	subl	$3b, %ebp
+
+	/* Get the loaded image protocol pointer from the image handle */
+	subl	$12, %esp			// space for the loaded image pointer
+	pushl	%esp				// pass its address
+	leal	5f(%ebp), %eax
+	pushl	%eax				// pass the GUID address
+	pushl	28(%esp)			// pass the image handle
+
+	movl	36(%esp), %eax			// sys_table
+	movl	ST32_boottime(%eax), %eax	// sys_table->boottime
+	call	*BS32_handle_protocol(%eax)	// sys_table->boottime->handle_protocol
+	cmp	$0, %eax
+	jnz	4f
+
+	movl	32(%esp), %ecx			// image_handle
+	movl	36(%esp), %edx			// sys_table
+	movl	12(%esp), %esi			// loaded_image
+	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
+	jmp	2b
+
+4:	addl	$24, %esp
+	popl	%ebp
+	ret
+SYM_FUNC_END(efi32_pe_entry)
+
+	/* EFI loaded image protocol GUID */
+5:	.long	0x5B1B31A1
+	.word	0x9562, 0x11d2
+	.byte	0x8E, 0x3F, 0x00, 0xA0, 0xC9, 0x69, 0x72, 0x3B
+	.previous
 #endif
 
 	.code64
@@ -465,11 +510,23 @@ SYM_CODE_END(startup_64)
 SYM_FUNC_START(efi64_stub_entry)
 SYM_FUNC_START_ALIAS(efi_stub_entry)
 	and	$~0xf, %rsp			/* realign the stack */
+#ifdef CONFIG_EFI_MIXED
+	cmpl	$0, %edx
+	jz	0f
+#endif
 	call	efi_main
 	movq	%rax,%rsi
 	movl	BP_code32_start(%esi), %eax
 	leaq	startup_64(%rax), %rax
 	jmp	*%rax
+
+#ifdef CONFIG_EFI_MIXED
+0:	movl	%edi, %ecx		// MS calling convention
+	movl	%esi, %edx
+	call	efi_pe_entry
+1:	hlt
+	jmp	1b
+#endif
 SYM_FUNC_END(efi64_stub_entry)
 SYM_FUNC_END_ALIAS(efi_stub_entry)
 #endif
@@ -641,7 +698,7 @@ SYM_DATA_START_LOCAL(gdt)
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
 #ifdef CONFIG_EFI_MIXED
-SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0)
+SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
 SYM_DATA(efi_is64, .byte 1)
 #endif
 
-- 
2.17.1

