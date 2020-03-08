Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2543017D27B
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgCHIKF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCHIKE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:10:04 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3622A2166E;
        Sun,  8 Mar 2020 08:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583655003;
        bh=Y3FNhUUljVYLAsepqBIFw9PWxLAxG9XYE6JMQ70hfbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=soY/RX4AC3duuz16mKip/TDD/y4xcxJZSZNjV8KVNcGuOqxOkSNvmK2GVOWBCXQ8J
         Wa/VUK7enb8UJGx3UzN4oZS+WQcWfGWrwfW3BqNgZI9Xd/TEc+tGdWboy63XDmschM
         vd1I9ya3ncd0vyY55l9/f/ElWHXp1Bl+OmHs72Yg=
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
Subject: [PATCH 16/28] efi/x86: Decompress at start of PE image load address
Date:   Sun,  8 Mar 2020 09:08:47 +0100
Message-Id: <20200308080859.21568-17-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

When booted via PE loader, define image_offset to hold the offset of
startup_32 from the start of the PE image, and use it as the start of
the decompression buffer.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200303221205.4048668-3-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_32.S      | 17 ++++++++++
 arch/x86/boot/compressed/head_64.S      | 42 +++++++++++++++++++++++--
 drivers/firmware/efi/libstub/x86-stub.c | 17 ++++++++--
 3 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 2a8965aec234..f7b52ccaa4ee 100644
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
@@ -227,6 +240,10 @@ SYM_DATA_START_LOCAL(gdt)
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
index 1199c4ef0c83..4d4b4763a770 100644
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
index 69a942f0640b..96bc4a8733c8 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -19,6 +19,7 @@
 
 static efi_system_table_t *sys_table;
 extern const bool efi_is64;
+extern u32 image_offset;
 
 __pure efi_system_table_t *efi_system_table(void)
 {
@@ -365,6 +366,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	struct boot_params *boot_params;
 	struct setup_header *hdr;
 	efi_loaded_image_t *image;
+	void *image_base;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
 	int options_size = 0;
 	efi_status_t status;
@@ -385,7 +387,10 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		efi_exit(handle, status);
 	}
 
-	hdr = &((struct boot_params *)efi_table_attr(image, image_base))->hdr;
+	image_base = efi_table_attr(image, image_base);
+	image_offset = (void *)startup_32 - image_base;
+
+	hdr = &((struct boot_params *)image_base)->hdr;
 	above4g = hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G;
 
 	status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params,
@@ -400,7 +405,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr = &boot_params->hdr;
 
 	/* Copy the second sector to boot_params */
-	memcpy(&hdr->jump, efi_table_attr(image, image_base) + 512, 512);
+	memcpy(&hdr->jump, image_base + 512, 512);
 
 	/*
 	 * Fill out some of the header fields ourselves because the
@@ -727,7 +732,7 @@ unsigned long efi_main(efi_handle_t handle,
 	 * If the kernel isn't already loaded at the preferred load
 	 * address, relocate it.
 	 */
-	if (bzimage_addr != hdr->pref_address) {
+	if (bzimage_addr - image_offset != hdr->pref_address) {
 		status = efi_relocate_kernel(&bzimage_addr,
 					     hdr->init_size, hdr->init_size,
 					     hdr->pref_address,
@@ -737,6 +742,12 @@ unsigned long efi_main(efi_handle_t handle,
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
2.17.1

