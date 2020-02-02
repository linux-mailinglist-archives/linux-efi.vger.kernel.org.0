Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2B014FE7A
	for <lists+linux-efi@lfdr.de>; Sun,  2 Feb 2020 18:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgBBRN7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Feb 2020 12:13:59 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45103 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgBBRN7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Feb 2020 12:13:59 -0500
Received: by mail-qv1-f65.google.com with SMTP id l14so5717132qvu.12;
        Sun, 02 Feb 2020 09:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ME1IxdYKKLBhZ+Y2cSJFbcQtrcC06qeifJt6hX07sZQ=;
        b=bmZgLgERWeKUj3jGMON1ytJmjIjr/hXsHPcUdwSEpGlyvsQlAbb4eIXEpEp1yiXguV
         SlPTsDrcQBdbCCty/T0FWClZANkzAyw9CNFdoyL1FyLfKqLp32LCYUAjstF093qZD2QX
         vlw+HjNS65XaoGGeSeaEPZjD91qNxThSWeVY1G2waQV3tFAVIA1Kxae8fvT49ElzeK6a
         rgJEwL+1rOqdjqqTvgNArmV4BNb1YZLSwqEWITEO3LPhb3UblM+e04nux68pXzTKyU0R
         HljtK0/vubcArdAE7ZjxrQpvVZkWbHTjIBN9pu/3FH30/CKVMLYOV7mwo6rL4WzXyKUy
         lL0g==
X-Gm-Message-State: APjAAAX0yjPbeFTsMEVKzt5XIc709JtLwfUYAhWxc5JRM2VAbh9OmdNI
        ScT974VflQ61TBZOSKYGfBw=
X-Google-Smtp-Source: APXvYqzDBzoWDnZwduI92Wi7CTuir8fKe5n3pammSkkNTqIDsJAw24gQM+5QYWTk7fZ+5g8q/el8SA==
X-Received: by 2002:a0c:e1ce:: with SMTP id v14mr19270533qvl.39.1580663636167;
        Sun, 02 Feb 2020 09:13:56 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 3sm8150081qte.59.2020.02.02.09.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 09:13:55 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] efi/x86: Don't depend on firmware GDT layout
Date:   Sun,  2 Feb 2020 12:13:48 -0500
Message-Id: <20200202171353.3736319-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200202171353.3736319-1-nivedita@alum.mit.edu>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
 <20200202171353.3736319-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

At handover entry in efi32_stub_entry, the firmware's GDT is still
installed. We save the GDTR for later use in __efi64_thunk but we are
assuming that descriptor 2 (__KERNEL_CS) is a valid 32-bit code segment
descriptor and that descriptor 3 (__KERNEL_DS/__BOOT_DS) is a valid data
segment descriptor.

This happens to be true for OVMF (it actually uses descriptor 1 for data
segments, but descriptor 3 is also setup as data), but we shouldn't
depend on this being the case.

Fix this by saving the code and data selectors in addition to the GDTR
in efi32_stub_entry, and restoring them in __efi64_thunk before calling
the firmware. The UEFI specification guarantees that selectors will be
flat, so using the DS selector for all the segment registers should be
enough.

We also need to install our own GDT before initializing segment
registers in startup_32, so move the GDT load up to the beginning of the
function.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/efi_thunk_64.S | 29 +++++++++++++++++++-----
 arch/x86/boot/compressed/head_64.S      | 30 +++++++++++++++----------
 2 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index 8fb7f6799c52..2b2049259619 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -54,11 +54,16 @@ SYM_FUNC_START(__efi64_thunk)
 	 * Switch to gdt with 32-bit segments. This is the firmware GDT
 	 * that was installed when the kernel started executing. This
 	 * pointer was saved at the EFI stub entry point in head_64.S.
+	 *
+	 * Pass the saved DS selector to the 32-bit code, and use far return to
+	 * restore the saved CS selector.
 	 */
 	leaq	efi32_boot_gdt(%rip), %rax
 	lgdt	(%rax)
 
-	pushq	$__KERNEL_CS
+	movzwl	efi32_boot_ds(%rip), %edx
+	movzwq	efi32_boot_cs(%rip), %rax
+	pushq	%rax
 	leaq	efi_enter32(%rip), %rax
 	pushq	%rax
 	lretq
@@ -73,6 +78,10 @@ SYM_FUNC_START(__efi64_thunk)
 	movl	%ebx, %es
 	pop	%rbx
 	movl	%ebx, %ds
+	/* Clear out 32-bit selector from FS and GS */
+	xorl	%ebx, %ebx
+	movl	%ebx, %fs
+	movl	%ebx, %gs
 
 	/*
 	 * Convert 32-bit status code into 64-bit.
@@ -92,10 +101,12 @@ SYM_FUNC_END(__efi64_thunk)
  * The stack should represent the 32-bit calling convention.
  */
 SYM_FUNC_START_LOCAL(efi_enter32)
-	movl	$__KERNEL_DS, %eax
-	movl	%eax, %ds
-	movl	%eax, %es
-	movl	%eax, %ss
+	/* Load firmware selector into data and stack segment registers */
+	movl	%edx, %ds
+	movl	%edx, %es
+	movl	%edx, %fs
+	movl	%edx, %gs
+	movl	%edx, %ss
 
 	/* Reload pgtables */
 	movl	%cr3, %eax
@@ -157,6 +168,14 @@ SYM_DATA_START(efi32_boot_gdt)
 	.quad	0
 SYM_DATA_END(efi32_boot_gdt)
 
+SYM_DATA_START(efi32_boot_cs)
+	.word	0
+SYM_DATA_END(efi32_boot_cs)
+
+SYM_DATA_START(efi32_boot_ds)
+	.word	0
+SYM_DATA_END(efi32_boot_ds)
+
 SYM_DATA_START(efi_gdt64)
 	.word	efi_gdt64_end - efi_gdt64
 	.long	0			/* Filled out by user */
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index bd44d89540d3..c56b30bd9c7b 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -54,10 +54,6 @@ SYM_FUNC_START(startup_32)
 	 */
 	cld
 	cli
-	movl	$(__BOOT_DS), %eax
-	movl	%eax, %ds
-	movl	%eax, %es
-	movl	%eax, %ss
 
 /*
  * Calculate the delta between where we were compiled to run
@@ -72,10 +68,20 @@ SYM_FUNC_START(startup_32)
 1:	popl	%ebp
 	subl	$1b, %ebp
 
+	/* Load new GDT with the 64bit segments using 32bit descriptor */
+	addl	%ebp, gdt+2(%ebp)
+	lgdt	gdt(%ebp)
+
+	/* Load segment registers with our descriptors */
+	movl	$__BOOT_DS, %eax
+	movl	%eax, %ds
+	movl	%eax, %es
+	movl	%eax, %fs
+	movl	%eax, %gs
+	movl	%eax, %ss
+
 /* setup a stack and make sure cpu supports long mode. */
-	movl	$boot_stack_end, %eax
-	addl	%ebp, %eax
-	movl	%eax, %esp
+	leal	boot_stack_end(%ebp), %esp
 
 	call	verify_cpu
 	testl	%eax, %eax
@@ -112,10 +118,6 @@ SYM_FUNC_START(startup_32)
  * Prepare for entering 64 bit mode
  */
 
-	/* Load new GDT with the 64bit segments using 32bit descriptor */
-	addl	%ebp, gdt+2(%ebp)
-	lgdt	gdt(%ebp)
-
 	/* Enable PAE mode */
 	movl	%cr4, %eax
 	orl	$X86_CR4_PAE, %eax
@@ -232,9 +234,13 @@ SYM_FUNC_START(efi32_stub_entry)
 
 	movl	%ecx, efi32_boot_args(%ebp)
 	movl	%edx, efi32_boot_args+4(%ebp)
-	sgdtl	efi32_boot_gdt(%ebp)
 	movb	$0, efi_is64(%ebp)
 
+	/* Save firmware GDTR and code/data selectors */
+	sgdtl	efi32_boot_gdt(%ebp)
+	movw	%cs, efi32_boot_cs(%ebp)
+	movw	%ds, efi32_boot_ds(%ebp)
+
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
-- 
2.24.1

