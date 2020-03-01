Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11CFA1750CF
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 00:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgCAXFl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 18:05:41 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38986 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgCAXFl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 18:05:41 -0500
Received: by mail-qt1-f193.google.com with SMTP id e13so2680925qts.6;
        Sun, 01 Mar 2020 15:05:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NA9cnSTi8NP3eDk/kwlJmmVQTI+IcGtkxpzfYDhF69g=;
        b=m/SI7nrWvLmx9wuWyUk9oNjnhuORYru42asAI5h7WzZbQJnXyU76M6782ii9gBZvUE
         gsMSFparbHSIkPOybf3zsL/NVJVKwkuSTSuDPC3nYep/XY8WDdrlCgxcs06UMHgu+tbS
         lqEp4Z3r3t3erX+0V5VleufgifD9cTjf0brgbfJP2vpG79D0UrloEYOo8GmcRCvFfVxz
         tYGcUSTlAsvGkSN4PJXCG6CUO0fwiWPtnxYp6BUTkjvAYAW95uHqO5iazeAFWO6j5HIU
         DIfJEQZRoDt5yOSRoZtxP+xuI3XGCApIlz8qV6dtPPNGywMtVeUF2PK0Vi9jk7Pa0O9p
         TWVg==
X-Gm-Message-State: APjAAAU2WalWN54UdgBiv8n+YgWCUM1kaS1x9xpmFBsym4C/EYLckhUP
        BOyQXAN/CQOYr2dwODSKFHfvTFtpYWw=
X-Google-Smtp-Source: APXvYqygK9gibuUZQwZbu3WwYlgT4cb5nBOge6lj6Syb6Y9WXyfovtTSA2PJ7bF2746LEHqpO4GRKQ==
X-Received: by 2002:ac8:104:: with SMTP id e4mr13371870qtg.37.1583103939994;
        Sun, 01 Mar 2020 15:05:39 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x131sm8923906qka.1.2020.03.01.15.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:05:39 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] efi/x86: Decompress at start of PE image load address
Date:   Sun,  1 Mar 2020 18:05:34 -0500
Message-Id: <20200301230537.2247550-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301230537.2247550-1-nivedita@alum.mit.edu>
References: <20200301230537.2247550-1-nivedita@alum.mit.edu>
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
 arch/x86/boot/compressed/head_32.S      | 17 +++++++++++
 arch/x86/boot/compressed/head_64.S      | 38 +++++++++++++++++++++++--
 drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++--
 3 files changed, 61 insertions(+), 6 deletions(-)

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
index 5d8338a693ce..1a4ea8738df0 100644
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
@@ -712,6 +742,8 @@ SYM_FUNC_START(efi32_pe_entry)
 	movl	-4(%ebp), %esi			// loaded_image
 	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
 	movl	%ebx, %ebp			// startup_32 for efi32_pe_stub_entry
+	subl	%esi, %ebx
+	movl	%ebx, image_offset(%ebp)	// save image_offset
 	jmp	efi32_pe_stub_entry
 
 2:	popl	%edi				// restore callee-save registers
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 7f3e97c2aad3..0c4a6352cfd3 100644
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
@@ -736,6 +741,7 @@ unsigned long efi_main(efi_handle_t handle,
 			efi_printk("efi_relocate_kernel() failed!\n");
 			goto fail;
 		}
+		image_offset = 0;
 	}
 
 	/*
-- 
2.24.1

