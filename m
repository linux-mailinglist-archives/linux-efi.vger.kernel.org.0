Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB9063410C
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiKVQLo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiKVQLT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:11:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F2973421;
        Tue, 22 Nov 2022 08:11:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C70C0B81C10;
        Tue, 22 Nov 2022 16:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4559C433D7;
        Tue, 22 Nov 2022 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133459;
        bh=ReDXv/q3k9hMwnrrtZAWhC5ghMLwcJr6hIjqxuAEllw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVxTisLDPi7J+oQOfFOl1fJpuNdgrmJW8coJidIe/CYMFZZcTQbWQ/wT4GY+a+eLo
         yOdMlFjLDpziqPyztfgWOqy7U4CSTZBgvD6w6TIRvDaZAePZLyDW5MKIUNVnfiJ9kG
         x9YZnLWgL+4E6ILgsoeHep4Sdi5kbdOzwq83D36GVm7pwpLvOtFNnECFu7ryXv2Qq6
         Lg8myt7Mx0yFuqy09b6a/n1Xi6OdYfaAgIu3fp5/nkyMwIQpMr4m69Tj/PiB3+Is3q
         P2PtJ/gsrd8Y+3F1hX9PzhHOzv16koy/uF4QbImqVhtlZa9unIqTs0cRTDqWoaBHjk
         JzwblZLWQWkuw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 12/17] x86/compressed: move startup32_load_idt() out of head_64.S
Date:   Tue, 22 Nov 2022 17:10:12 +0100
Message-Id: <20221122161017.2426828-13-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4967; i=ardb@kernel.org; h=from:subject; bh=ReDXv/q3k9hMwnrrtZAWhC5ghMLwcJr6hIjqxuAEllw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRgzwGVx/T1BBAR2+PJz9BwCwj6JuS5em6yTyOg pxvocYGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0YAAKCRDDTyI5ktmPJNw4C/ 9lFituVzfi6BkQa27qIpp8Newy0/YneL6tT8/bLqyrVdIM3vdLP5KcIJ7ctN0zS6DXQyf0JVCj2zKm pVSnVCjviTU7PouBCLtGlRRSFPoftPlFpiSVGFTmm6H/H0u8sCNSIO38hUSJCr5X7JUSJSMpwaif5K c0xrpoQk9oX8PaHxpqOZt57lAtt178he8jE3U9iDwA7tWtbZ85Wtr4EFGwykVEqB6ZxJOsZNTsScos +M3yU97f1ph+lm32dHQSw2IDaNQ44R8EiV2Dc+WX70Y5h/eXYNu4M4xG4yYASV0eM8MGRRWC1b4pAs zPOsEhylMW8ZJO3lkCVHg7Sos8Zvw3BHIe2gx2Y7KwozUzhTBF5iqq/WGtvSG/8uCJDm7ecGyvuzuD AIdaDaM5FsVLqvxtD4fEANHtp1YcC+34uW54Ohp3eywjof2GRB9q9BOizvHfwiR/amqiaA1Z122k8m fbQgDOfU4WIG2ee9D0FRNf6qq1HQ0bMd5oNAPfQIVmKGQ=
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

Now that startup32_load_idt() has been refactored into an ordinary
callable function, move it into mem-encrypt.S where it belongs.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S     | 72 --------------------
 arch/x86/boot/compressed/mem_encrypt.S | 72 +++++++++++++++++++-
 2 files changed, 71 insertions(+), 73 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 2d42852d5b828209..97b2167f128cbefe 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -715,78 +715,6 @@ SYM_DATA_START(boot_idt)
 	.endr
 SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-SYM_DATA_START(boot32_idt_desc)
-	.word   boot32_idt_end - boot32_idt - 1
-	.long   0
-SYM_DATA_END(boot32_idt_desc)
-	.balign 8
-SYM_DATA_START(boot32_idt)
-	.rept 32
-	.quad 0
-	.endr
-SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
-
-	.text
-	.code32
-/*
- * Write an IDT entry into boot32_idt
- *
- * Parameters:
- *
- * %eax:	Handler address
- * %edx:	Vector number
- * %ecx:	IDT address
- */
-SYM_FUNC_START_LOCAL(startup32_set_idt_entry)
-	/* IDT entry address to %ecx */
-	leal	(%ecx, %edx, 8), %ecx
-
-	/* Build IDT entry, lower 4 bytes */
-	movl    %eax, %edx
-	andl    $0x0000ffff, %edx		# Target code segment offset [15:0]
-	orl	$(__KERNEL32_CS << 16), %edx	# Target code segment selector
-
-	/* Store lower 4 bytes to IDT */
-	movl    %edx, (%ecx)
-
-	/* Build IDT entry, upper 4 bytes */
-	movl    %eax, %edx
-	andl    $0xffff0000, %edx	# Target code segment offset [31:16]
-	orl     $0x00008e00, %edx	# Present, Type 32-bit Interrupt Gate
-
-	/* Store upper 4 bytes to IDT */
-	movl    %edx, 4(%ecx)
-
-	RET
-SYM_FUNC_END(startup32_set_idt_entry)
-
-SYM_FUNC_START(startup32_load_idt)
-	push	%ebp
-	push	%ebx
-
-	call	1f
-1:	pop	%ebp
-
-	leal    (boot32_idt - 1b)(%ebp), %ebx
-
-	/* #VC handler */
-	leal    (startup32_vc_handler - 1b)(%ebp), %eax
-	movl    $X86_TRAP_VC, %edx
-	movl	%ebx, %ecx
-	call    startup32_set_idt_entry
-
-	/* Load IDT */
-	leal	(boot32_idt_desc - 1b)(%ebp), %ecx
-	movl	%ebx, 2(%ecx)
-	lidt    (%ecx)
-
-	pop	%ebx
-	pop	%ebp
-	RET
-SYM_FUNC_END(startup32_load_idt)
-#endif
-
 /*
  * Check for the correct C-bit position when the startup_32 boot-path is used.
  *
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index a73e4d783cae20b6..6747e5e4c696637c 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -12,6 +12,8 @@
 #include <asm/processor-flags.h>
 #include <asm/msr.h>
 #include <asm/asm-offsets.h>
+#include <asm/segment.h>
+#include <asm/trapnr.h>
 
 	.text
 	.code32
@@ -98,7 +100,7 @@ SYM_CODE_START_LOCAL(sev_es_req_cpuid)
 	jmp	1b
 SYM_CODE_END(sev_es_req_cpuid)
 
-SYM_CODE_START(startup32_vc_handler)
+SYM_CODE_START_LOCAL(startup32_vc_handler)
 	pushl	%eax
 	pushl	%ebx
 	pushl	%ecx
@@ -184,6 +186,63 @@ SYM_CODE_START(startup32_vc_handler)
 	jmp .Lfail
 SYM_CODE_END(startup32_vc_handler)
 
+/*
+ * Write an IDT entry into boot32_idt
+ *
+ * Parameters:
+ *
+ * %eax:	Handler address
+ * %edx:	Vector number
+ * %ecx:	IDT address
+ */
+SYM_FUNC_START_LOCAL(startup32_set_idt_entry)
+	/* IDT entry address to %ecx */
+	leal	(%ecx, %edx, 8), %ecx
+
+	/* Build IDT entry, lower 4 bytes */
+	movl    %eax, %edx
+	andl    $0x0000ffff, %edx		# Target code segment offset [15:0]
+	orl	$(__KERNEL32_CS << 16), %edx	# Target code segment selector
+
+	/* Store lower 4 bytes to IDT */
+	movl    %edx, (%ecx)
+
+	/* Build IDT entry, upper 4 bytes */
+	movl    %eax, %edx
+	andl    $0xffff0000, %edx	# Target code segment offset [31:16]
+	orl     $0x00008e00, %edx	# Present, Type 32-bit Interrupt Gate
+
+	/* Store upper 4 bytes to IDT */
+	movl    %edx, 4(%ecx)
+
+	RET
+SYM_FUNC_END(startup32_set_idt_entry)
+
+SYM_FUNC_START(startup32_load_idt)
+	push	%ebp
+	push	%ebx
+
+	call	1f
+1:	pop	%ebp
+
+	leal    (boot32_idt - 1b)(%ebp), %ebx
+
+	/* #VC handler */
+	leal    (startup32_vc_handler - 1b)(%ebp), %eax
+	movl    $X86_TRAP_VC, %edx
+	movl	%ebx, %ecx
+	call    startup32_set_idt_entry
+
+	/* Load IDT */
+	leal	(boot32_idt_desc - 1b)(%ebp), %ecx
+	movl	%ebx, 2(%ecx)
+	lidt    (%ecx)
+
+	pop	%ebx
+	pop	%ebp
+	RET
+SYM_FUNC_END(startup32_load_idt)
+
 	.code64
 
 #include "../../kernel/sev_verify_cbit.S"
@@ -195,4 +254,15 @@ SYM_CODE_END(startup32_vc_handler)
 SYM_DATA(sme_me_mask,		.quad 0)
 SYM_DATA(sev_status,		.quad 0)
 SYM_DATA(sev_check_data,	.quad 0)
+
+SYM_DATA_START_LOCAL(boot32_idt)
+	.rept	32
+	.quad	0
+	.endr
+SYM_DATA_END(boot32_idt)
+
+SYM_DATA_START_LOCAL(boot32_idt_desc)
+	.word	. - boot32_idt - 1
+	.long	0
+SYM_DATA_END(boot32_idt_desc)
 #endif
-- 
2.35.1

