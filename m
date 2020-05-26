Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E043B1E27D9
	for <lists+linux-efi@lfdr.de>; Tue, 26 May 2020 19:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgEZRCb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 May 2020 13:02:31 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41623 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgEZRCb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 May 2020 13:02:31 -0400
Received: by mail-qv1-f65.google.com with SMTP id v15so9779605qvr.8
        for <linux-efi@vger.kernel.org>; Tue, 26 May 2020 10:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3El7Fz4ClRus4+cUUmqW8DOXLgq5TpiLJZkHFGOBiZI=;
        b=QcZ5mYQaV3cjeVaoZSCNg9XKtkTx8Y4bv083wcN4hjoYcsjAc7B1iyM0/D/skXyNOl
         LkDbhBJiEghUFOy15E3AR/IWj1enW64mEmgad98iG979/hnIImDRIYoFH7YjMCBkazCQ
         eMLbWUxWyqkj29YeN6aUhIWEUWcN6P/9zUhH9BxIEcWa25OYEbUNsgLkFlNBEKwH96VG
         dSasz1C0yFsymMEhMUBRFFqUxE27+zPAQo18Od5upImf/nkNxUt71M4FBIOSkcQdJVAw
         hktw3rH4XvCZ2C7tZZ3jfJ+j5yKMCp/o39uOMWc115XRnolEOuvC9Hd0Tz4ocLFtgGVE
         zkoQ==
X-Gm-Message-State: AOAM531LfN1R5WrvuS6Uq85tUJEhnp0GYpHm2dgathne9pNBn8X49CDi
        k3scFChiY6k6GjyBikhi88qdZW32
X-Google-Smtp-Source: ABdhPJzyG5Ni/9tqIEh3ZXxB8qZ6p1hbMgIx1uu3VCaQTPA+ddzTVqXRye6RBTbnK8YV0zKDsWrE0A==
X-Received: by 2002:a0c:d610:: with SMTP id c16mr4148267qvj.43.1590512550064;
        Tue, 26 May 2020 10:02:30 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l184sm125392qkf.84.2020.05.26.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 10:02:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 1/1] efi/x86: Use firmware stack for mixed-mode EFI stub
Date:   Tue, 26 May 2020 13:02:26 -0400
Message-Id: <20200526170226.2371024-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526170226.2371024-1-nivedita@alum.mit.edu>
References: <20200526170226.2371024-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The UEFI specification requires a 128KiB stack during boot services. On
a native mode boot, the EFI stub executes on the firmware stack.
However, on a mixed-mode boot, startup_32 switches to the kernel's boot
stack, which is only 16KiB, and the EFI stub is executed with this
stack.

To avoid any potential problems with running out of stack space, save
and restore the UEFI stack pointer in the mixed-mode entry, so that the
EFI stub can use the firmware stack in this case as well.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_64.S | 46 ++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 4b7ad1dfbea6..923e5c381804 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -237,21 +237,7 @@ SYM_FUNC_START(startup_32)
 	 * used to perform that far jump.
 	 */
 	pushl	$__KERNEL_CS
-	leal	rva(startup_64)(%ebp), %eax
-#ifdef CONFIG_EFI_MIXED
-	movl	rva(efi32_boot_args)(%ebp), %edi
-	cmp	$0, %edi
-	jz	1f
-	leal	rva(efi64_stub_entry)(%ebp), %eax
-	movl	rva(efi32_boot_args+4)(%ebp), %esi
-	movl	rva(efi32_boot_args+8)(%ebp), %edx	// saved bootparams pointer
-	cmpl	$0, %edx
-	jnz	1f
-	leal	rva(efi_pe_entry)(%ebp), %eax
-	movl	%edi, %ecx			// MS calling convention
-	movl	%esi, %edx
-1:
-#endif
+	leal	rva(.L64bit)(%ebp), %eax
 	pushl	%eax
 
 	/* Enter paged protected Mode, activating Long Mode */
@@ -260,6 +246,31 @@ SYM_FUNC_START(startup_32)
 
 	/* Jump from 32bit compatibility mode into 64bit mode. */
 	lret
+
+	.code64
+SYM_INNER_LABEL(.L64bit, SYM_L_LOCAL)
+#ifndef CONFIG_EFI_MIXED
+	jmp	startup_64
+#else
+	movl	efi32_boot_args(%rip), %edi
+	testl	%edi, %edi
+	jz	startup_64
+
+	/* Restore firmware stack pointer */
+	movl	efi32_boot_sp(%rip), %esp
+	/* and align it to 8 mod 16 */
+	andl	$~0xf, %esp
+	subl	$8, %esp
+
+	movl	efi32_boot_args+4(%rip), %esi
+	movl	efi32_boot_args+8(%rip), %edx	// saved bootparams pointer
+	testl	%edx, %edx
+	jnz	efi64_stub_entry
+	movl	%edi, %ecx			// MS calling convention
+	movl	%esi, %edx
+	jmp	efi_pe_entry
+#endif
+	.code32
 SYM_FUNC_END(startup_32)
 
 #ifdef CONFIG_EFI_MIXED
@@ -285,6 +296,9 @@ SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
 	movw	%cs, rva(efi32_boot_cs)(%ebp)
 	movw	%ds, rva(efi32_boot_ds)(%ebp)
 
+	/* Save firmware stack pointer */
+	movl	%esp, rva(efi32_boot_sp)(%ebp)
+
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -648,6 +662,7 @@ SYM_DATA(image_offset, .long 0)
 
 #ifdef CONFIG_EFI_MIXED
 SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
+SYM_DATA_LOCAL(efi32_boot_sp, .long 0)
 SYM_DATA(efi_is64, .byte 1)
 
 #define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
@@ -710,6 +725,7 @@ SYM_FUNC_START(efi32_pe_entry)
 	movl	12(%ebp), %edx			// sys_table
 	movl	-4(%ebp), %esi			// loaded_image
 	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
+	leave					// clear stack frame
 	movl	%ebx, %ebp			// startup_32 for efi32_pe_stub_entry
 	/*
 	 * We need to set the image_offset variable here since startup_32() will
-- 
2.26.2

