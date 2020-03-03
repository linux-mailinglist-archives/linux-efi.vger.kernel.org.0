Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B00178548
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 23:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgCCWMJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 17:12:09 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38366 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgCCWMJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Mar 2020 17:12:09 -0500
Received: by mail-qt1-f195.google.com with SMTP id e20so4162957qto.5;
        Tue, 03 Mar 2020 14:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4fjWsKKt+H6bRW7wk8V36+gnsdIQPUzRbjc5HA3/Pg8=;
        b=oriyw87SsWCn5a4kfmtMnlaoZqor0Y4MZcUVum22Knz3Kyel/2Kkxr6Oefj/0TcrVi
         Rd3auL26b8OGlCtWERX5I4KqSjIXabSUVafFmxz15hLjH3/s6YC/M5i5I0sAlNeJPYf4
         Z/diT049Lus/a+W0nX9JDmhLkezMul94mYxoNiGkginXPfCLDv9xu25W7Vr3M46Lap0P
         JJTkC9byc69MQA3J79FcIvo9vDnfIK/arSTnl4jO+kL8OsKAyu+v0x19TGXZmxKNjSgt
         nHsrGOpZUw0FqgR88CelzXLsfT8GwJwAvlhcw50aEPV9ECyocckdDB0HHkpgPnk4xA6d
         d47g==
X-Gm-Message-State: ANhLgQ22xdR0AS+4Vc7j9s/okBK5gtD67T2BBFLfmd/9ZRBO5GZ0yyGe
        gbHxpavZzNGhOuiAq/TuuDs=
X-Google-Smtp-Source: ADFU+vslCZjDyNq899otKjUFwCvL1s8S76eer/1XK1vxAcl6zgtd3vZliWfyNcoX6c3BFPFpst4E+g==
X-Received: by 2002:ac8:5452:: with SMTP id d18mr6705777qtq.43.1583273528016;
        Tue, 03 Mar 2020 14:12:08 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i91sm13267378qtd.70.2020.03.03.14.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:12:07 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] efi/x86: Decompress at start of PE image load address
Date:   Tue,  3 Mar 2020 17:12:02 -0500
Message-Id: <20200303221205.4048668-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303221205.4048668-1-nivedita@alum.mit.edu>
References: <20200301230537.2247550-1-nivedita@alum.mit.edu>
 <20200303221205.4048668-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When booted via PE loader, define image_offset to hold the offset of
startup_32 from the start of the PE image, and use it as the start of
the decompression buffer.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_32.S      | 17 ++++++++++
 arch/x86/boot/compressed/head_64.S      | 42 +++++++++++++++++++++++--
 drivers/firmware/efi/libstub/x86-stub.c | 17 ++++++++--
 3 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 894182500606..98b224f5a025 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -100,6 +100,19 @@ SYM_FUNC_START(startup_32)
 
 #ifdef CONFIG_RELOCATABLE
 	movl	%edx, %ebx
+
+#ifdef CONFIG_EFI_STUB
+/*
+ * If we were loaded via the EFI LoadImage service, startup_32 will be at an
+ * offset to the start of the space allocated for the image. efi_pe_entry will
+ * setup image_offset to tell us where the image actually starts, so that we
+ * can use the full available buffer.
+ *	image_offset = startup_32 - image_base
+ * Otherwise image_offset will be zero and have no effect on the calculations.
+ */
+	subl    image_offset(%edx), %ebx
+#endif
+
 	movl	BP_kernel_alignment(%esi), %eax
 	decl	%eax
 	addl    %eax, %ebx
@@ -226,6 +239,10 @@ SYM_DATA_START_LOCAL(gdt)
 	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
+#ifdef CONFIG_EFI_STUB
+SYM_DATA(image_offset, .long 0)
+#endif
+
 /*
  * Stack and heap for uncompression
  */
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 5d8338a693ce..ae79b50840ad 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -99,6 +99,19 @@ SYM_FUNC_START(startup_32)
 
 #ifdef CONFIG_RELOCATABLE
 	movl	%ebp, %ebx
+
+#ifdef CONFIG_EFI_STUB
+/*
+ * If we were loaded via the EFI LoadImage service, startup_32 will be at an
+ * offset to the start of the space allocated for the image. efi_pe_entry will
+ * setup image_offset to tell us where the image actually starts, so that we
+ * can use the full available buffer.
+ *	image_offset = startup_32 - image_base
+ * Otherwise image_offset will be zero and have no effect on the calculations.
+ */
+	subl    image_offset(%ebp), %ebx
+#endif
+
 	movl	BP_kernel_alignment(%esi), %eax
 	decl	%eax
 	addl	%eax, %ebx
@@ -111,9 +124,8 @@ SYM_FUNC_START(startup_32)
 1:
 
 	/* Target address to relocate to for decompression */
-	movl	BP_init_size(%esi), %eax
-	subl	$_end, %eax
-	addl	%eax, %ebx
+	addl	BP_init_size(%esi), %ebx
+	subl	$_end, %ebx
 
 /*
  * Prepare for entering 64 bit mode
@@ -299,6 +311,20 @@ SYM_CODE_START(startup_64)
 	/* Start with the delta to where the kernel will run at. */
 #ifdef CONFIG_RELOCATABLE
 	leaq	startup_32(%rip) /* - $startup_32 */, %rbp
+
+#ifdef CONFIG_EFI_STUB
+/*
+ * If we were loaded via the EFI LoadImage service, startup_32 will be at an
+ * offset to the start of the space allocated for the image. efi_pe_entry will
+ * setup image_offset to tell us where the image actually starts, so that we
+ * can use the full available buffer.
+ *	image_offset = startup_32 - image_base
+ * Otherwise image_offset will be zero and have no effect on the calculations.
+ */
+	movl    image_offset(%rip), %eax
+	subq	%rax, %rbp
+#endif
+
 	movl	BP_kernel_alignment(%rsi), %eax
 	decl	%eax
 	addq	%rax, %rbp
@@ -647,6 +673,10 @@ SYM_DATA_START_LOCAL(gdt)
 	.quad   0x0000000000000000	/* TS continued */
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
+#ifdef CONFIG_EFI_STUB
+SYM_DATA(image_offset, .long 0)
+#endif
+
 #ifdef CONFIG_EFI_MIXED
 SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
 SYM_DATA(efi_is64, .byte 1)
@@ -712,6 +742,12 @@ SYM_FUNC_START(efi32_pe_entry)
 	movl	-4(%ebp), %esi			// loaded_image
 	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
 	movl	%ebx, %ebp			// startup_32 for efi32_pe_stub_entry
+	/*
+	 * We need to set the image_offset variable here since startup_32 will
+	 * use it before we get to the 64-bit efi_pe_entry in C code.
+	 */
+	subl	%esi, %ebx
+	movl	%ebx, image_offset(%ebp)	// save image_offset
 	jmp	efi32_pe_stub_entry
 
 2:	popl	%edi				// restore callee-save registers
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 7f3e97c2aad3..e71b8421e088 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -19,6 +19,7 @@
 
 static efi_system_table_t *sys_table;
 extern const bool efi_is64;
+extern u32 image_offset;
 
 __pure efi_system_table_t *efi_system_table(void)
 {
@@ -364,6 +365,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	struct boot_params *boot_params;
 	struct setup_header *hdr;
 	efi_loaded_image_t *image;
+	void *image_base;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
 	int options_size = 0;
 	efi_status_t status;
@@ -384,7 +386,10 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		efi_exit(handle, status);
 	}
 
-	hdr = &((struct boot_params *)efi_table_attr(image, image_base))->hdr;
+	image_base = efi_table_attr(image, image_base);
+	image_offset = (void *)startup_32 - image_base;
+
+	hdr = &((struct boot_params *)image_base)->hdr;
 	above4g = hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G;
 
 	status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params,
@@ -399,7 +404,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr = &boot_params->hdr;
 
 	/* Copy the second sector to boot_params */
-	memcpy(&hdr->jump, efi_table_attr(image, image_base) + 512, 512);
+	memcpy(&hdr->jump, image_base + 512, 512);
 
 	/*
 	 * Fill out some of the header fields ourselves because the
@@ -726,7 +731,7 @@ unsigned long efi_main(efi_handle_t handle,
 	 * If the kernel isn't already loaded at the preferred load
 	 * address, relocate it.
 	 */
-	if (bzimage_addr != hdr->pref_address) {
+	if (bzimage_addr - image_offset != hdr->pref_address) {
 		status = efi_relocate_kernel(&bzimage_addr,
 					     hdr->init_size, hdr->init_size,
 					     hdr->pref_address,
@@ -736,6 +741,12 @@ unsigned long efi_main(efi_handle_t handle,
 			efi_printk("efi_relocate_kernel() failed!\n");
 			goto fail;
 		}
+		/*
+		 * Now that we've copied the kernel elsewhere, we no longer
+		 * have a setup block before startup_32, so reset image_offset
+		 * to zero in case it was set earlier.
+		 */
+		image_offset = 0;
 	}
 
 	/*
-- 
2.24.1

