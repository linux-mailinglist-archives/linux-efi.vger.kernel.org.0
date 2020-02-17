Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2579161507
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 15:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgBQOst (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 09:48:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728723AbgBQOst (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Feb 2020 09:48:49 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E92C20801;
        Mon, 17 Feb 2020 14:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581950928;
        bh=vse7ZsMpLvXMzldb4xV2sHdsjuTsAykt14cTEqtb54M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GBJy98IMsvd2bY+d1dqGPmgW0euMxOFBihGbQYbmi6N/AgqQQmRDdiGgxPbnj25BW
         5yiwT6lmYM3QjCCeVsuxywzrZSDf3kXjqMaAnAsGUh6zfmY7zYQ90jaUbrqsVAMy4e
         M8arIHKIASkUreAA7Zc8nOI30Bn3t/YY5qPbqYjY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, daniel.kiper@oracle.com, hdegoede@redhat.com,
        nivedita@alum.mit.edu, mingo@kernel.org
Subject: [PATCH v2 4/5] efi/x86: Implement mixed mode boot without the handover protocol
Date:   Mon, 17 Feb 2020 15:48:21 +0100
Message-Id: <20200217144822.24616-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217144822.24616-1-ardb@kernel.org>
References: <20200217144822.24616-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add support for booting 64-bit x86 kernels from 32-bit firmware running
on 64-bit capable CPUs without requiring the bootloader to implement
the EFI handover protocol or allocate the setup block, etc etc, all of
which can be done by the stub itself, using code that already exists.

Instead, create an ordinary EFI application entrypoint but implemented
in 32-bit code [so that it can be invoked by 32-bit firmware], and stash
the address of this 32-bit entrypoint in the .compat section where the
bootloader can find it.

Note that we use the setup block embedded in the binary to go through
startup_32(), but it gets reallocated and copied in efi_pe_entry(),
using the same code that runs when the x86 kernel is booted in EFI
mode from native firmware. This requires the loaded image protocol to
be installed on the kernel image's EFI handle, and point to the kernel
image itself and not to its loader. This, in turn, requires the
bootloader to use the LoadImage() boot service to load the 64-bit
image from 32-bit firmware, which is in fact supported by firmware
based on EDK2. (Only StartImage() will fail, and instead, the newly
added entrypoint needs to be invoked)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S      | 60 +++++++++++++++++++-
 drivers/firmware/efi/libstub/x86-stub.c | 29 +++++-----
 2 files changed, 74 insertions(+), 15 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a4f5561c1c0e..47a475146107 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -207,8 +207,11 @@ SYM_FUNC_START(startup_32)
 	cmp	$0, %edi
 	jz	1f
 	leal	efi64_stub_entry(%ebp), %eax
-	movl	%esi, %edx
 	movl	efi32_boot_args+4(%ebp), %esi
+	movl	efi32_boot_args+8(%ebp), %edx	// saved bootparams pointer
+	cmpl	$0, %edx
+	jnz	1f
+	leal	efi32_pe_enter64(%ebp), %eax
 1:
 #endif
 	pushl	%eax
@@ -233,6 +236,8 @@ SYM_FUNC_START(efi32_stub_entry)
 1:	pop	%ebp
 	subl	$1b, %ebp
 
+	movl	%esi, efi32_boot_args+8(%ebp)
+SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
 	movl	%ecx, efi32_boot_args(%ebp)
 	movl	%edx, efi32_boot_args+4(%ebp)
 	movb	$0, efi_is64(%ebp)
@@ -641,8 +646,59 @@ SYM_DATA_START_LOCAL(gdt)
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
 #ifdef CONFIG_EFI_MIXED
-SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0)
+SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
 SYM_DATA(efi_is64, .byte 1)
+
+#define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
+#define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
+#define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
+
+	.text
+	.code32
+SYM_FUNC_START(efi32_pe_entry)
+	pushl	%ebp
+
+	call	1f
+1:	pop	%ebp
+	subl	$1b, %ebp
+
+	/* Get the loaded image protocol pointer from the image handle */
+	subl	$12, %esp			// space for the loaded image pointer
+	pushl	%esp				// pass its address
+	leal	4f(%ebp), %eax
+	pushl	%eax				// pass the GUID address
+	pushl	28(%esp)			// pass the image handle
+
+	movl	36(%esp), %eax			// sys_table
+	movl	ST32_boottime(%eax), %eax	// sys_table->boottime
+	call	*BS32_handle_protocol(%eax)	// sys_table->boottime->handle_protocol
+	cmp	$0, %eax
+	jnz	2f
+
+	movl	32(%esp), %ecx			// image_handle
+	movl	36(%esp), %edx			// sys_table
+	movl	12(%esp), %esi			// loaded_image
+	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
+	jmp	efi32_pe_stub_entry
+
+2:	addl	$24, %esp
+	popl	%ebp
+	ret
+SYM_FUNC_END(efi32_pe_entry)
+
+	.code64
+SYM_CODE_START_LOCAL(efi32_pe_enter64)
+	movl	%edi, %ecx		// MS calling convention
+	movl	%esi, %edx
+	call	efi_pe_entry
+	/* not reached */
+SYM_CODE_END(efi32_pe_enter64)
+
+	.section ".rodata"
+	/* EFI loaded image protocol GUID */
+4:	.long	0x5B1B31A1
+	.word	0x9562, 0x11d2
+	.byte	0x8E, 0x3F, 0x00, 0xA0, 0xC9, 0x69, 0x72, 0x3B
 #endif
 
 /*
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cec6baa14d5c..9db98839d7b4 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -424,21 +424,24 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr->ramdisk_image = 0;
 	hdr->ramdisk_size = 0;
 
-	status = efi_parse_options(cmdline_ptr);
-	if (status != EFI_SUCCESS)
-		goto fail2;
-
-	if (!noinitrd()) {
-		status = efi_load_initrd(image, &ramdisk_addr, &ramdisk_size,
-					 hdr->initrd_addr_max,
-					 above4g ? ULONG_MAX
-						 : hdr->initrd_addr_max);
+	if (efi_is_native()) {
+		status = efi_parse_options(cmdline_ptr);
 		if (status != EFI_SUCCESS)
 			goto fail2;
-		hdr->ramdisk_image = ramdisk_addr & 0xffffffff;
-		hdr->ramdisk_size  = ramdisk_size & 0xffffffff;
-		boot_params->ext_ramdisk_image = (u64)ramdisk_addr >> 32;
-		boot_params->ext_ramdisk_size  = (u64)ramdisk_size >> 32;
+
+		if (!noinitrd()) {
+			status = efi_load_initrd(image, &ramdisk_addr,
+						 &ramdisk_size,
+						 hdr->initrd_addr_max,
+						 above4g ? ULONG_MAX
+							 : hdr->initrd_addr_max);
+			if (status != EFI_SUCCESS)
+				goto fail2;
+			hdr->ramdisk_image = ramdisk_addr & 0xffffffff;
+			hdr->ramdisk_size  = ramdisk_size & 0xffffffff;
+			boot_params->ext_ramdisk_image = (u64)ramdisk_addr >> 32;
+			boot_params->ext_ramdisk_size  = (u64)ramdisk_size >> 32;
+		}
 	}
 
 	efi_stub_entry(handle, sys_table, boot_params);
-- 
2.17.1

