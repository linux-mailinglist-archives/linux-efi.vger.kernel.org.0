Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D87593022
	for <lists+linux-efi@lfdr.de>; Mon, 15 Aug 2022 15:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiHONml (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Aug 2022 09:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiHONmk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Aug 2022 09:42:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467E822289;
        Mon, 15 Aug 2022 06:42:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5C82B80EBC;
        Mon, 15 Aug 2022 13:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0304C433D7;
        Mon, 15 Aug 2022 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570956;
        bh=offx7NkKGZBzdriaIeydphHo5vIpisW1NvkleSw7ccw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ohf9Zs5m8Qt7F1daFud/tIcfEeshb0oIpPFlhiFQ+7nlTkbmdvH2GX2mydBQsPeIk
         qUfQUWzaS0qSbgZPKI3xpj1g1eGzVJfJXs/z/QtiCcNp8eliU/DCCC86zMORJjkJqL
         k5FJm1It+ny+n409YEt6n1u4nypaWlI8jZqhyZ6eRdCgD2d5H9KHFMUnez2iRzFvQd
         wU68pJjcmWQFvo2eohNJcs6eqMEsA40Yzt63kGTy3E5EtN1d8oCL8/yJwMC9SrtLr+
         xSFOXGSjbFZ5kQ9FcxKBNkjyiPkQ7NRCXX8/7l36U3r42+r/0CSH+Fhod2Aw2dXqB3
         1IYUrrYw1bQIw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH 3/6] x86/compressed: move startup32_load_idt() out of startup code
Date:   Mon, 15 Aug 2022 15:42:20 +0200
Message-Id: <20220815134223.740112-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815134223.740112-1-ardb@kernel.org>
References: <20220815134223.740112-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5692; i=ardb@kernel.org; h=from:subject; bh=offx7NkKGZBzdriaIeydphHo5vIpisW1NvkleSw7ccw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi+k03/dhSw+jga7OIa+6N+ECIys8qujkg8w9nFzz/ ppAdM8mJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvpNNwAKCRDDTyI5ktmPJDSxDA Cr+BEyES73damuvsUYyk81mavJ7fiZX92lvWIjd+0a7+1n+LwnUThC13KmzDku/SzV3PnTVklzurgk ivsDVfuXhbAnGJn+g/mmFkoqW2fkaqhmJFZf0/+nWiHoVE/ugAkXpzHoUzsILbsZ2cW44SwQjVeSRl 2BlNg1cQZolALQECBj4XnbBcUO4bwC+IsGFBqmZxOF9EFVgwT8W/RioDhCpfmDBCDdHy0wzWy6YMbC cpA54WyJZmleQLhisHugGMFYWD4Rx5qxpPmWQH7J1XCIwz/PoKnHVm+2ttW0MkJvYdLbVRJPoq4Dyo qyBB6oLZauMBzzbxbklN6BqnWZb6od/g9Nv2rp/e6oLSmwknGnlmiNW1LGQwjz5Vc9M+DXFLW9U0Vj idpMBU9E3QFmc3NC5D5lBNdPX5a5Tjct3TPM8H1SPTuVkWtLafbAbosMYeKDWtrokDzXHdpbGYHr+Q FaKq0BVgjawuVwkNQUcFVMUidx0v3ybLu2yfjawuL6sKc=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move the function startup32_load_idt() into mem_encrypt.S, and turn it
into an ordinary function, instead of relying on hidden register
arguments and non-standard calling conventions.

While at it, simplify the arithmetic involved in populating a IDT entry.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S     | 71 +------------------
 arch/x86/boot/compressed/mem_encrypt.S | 72 ++++++++++++++++++--
 2 files changed, 69 insertions(+), 74 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index c2cdbd8a3375..1ca2ed52f93c 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -118,7 +118,9 @@ SYM_FUNC_START(startup_32)
 1:
 
 	/* Setup Exception handling for SEV-ES */
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 	call	startup32_load_idt
+#endif
 
 	/* Make sure cpu supports long mode. */
 	call	verify_cpu
@@ -701,80 +703,11 @@ SYM_DATA_START(boot_idt)
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
-#endif
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	__HEAD
 	.code32
-/*
- * Write an IDT entry into boot32_idt
- *
- * Parameters:
- *
- * %eax:	Handler address
- * %edx:	Vector number
- *
- * Physical offset is expected in %ebp
- */
-SYM_FUNC_START(startup32_set_idt_entry)
-	push    %ebx
-	push    %ecx
-
-	/* IDT entry address to %ebx */
-	leal    rva(boot32_idt)(%ebp), %ebx
-	shl	$3, %edx
-	addl    %edx, %ebx
-
-	/* Build IDT entry, lower 4 bytes */
-	movl    %eax, %edx
-	andl    $0x0000ffff, %edx	# Target code segment offset [15:0]
-	movl    $__KERNEL32_CS, %ecx	# Target code segment selector
-	shl     $16, %ecx
-	orl     %ecx, %edx
-
-	/* Store lower 4 bytes to IDT */
-	movl    %edx, (%ebx)
-
-	/* Build IDT entry, upper 4 bytes */
-	movl    %eax, %edx
-	andl    $0xffff0000, %edx	# Target code segment offset [31:16]
-	orl     $0x00008e00, %edx	# Present, Type 32-bit Interrupt Gate
-
-	/* Store upper 4 bytes to IDT */
-	movl    %edx, 4(%ebx)
-
-	pop     %ecx
-	pop     %ebx
-	RET
-SYM_FUNC_END(startup32_set_idt_entry)
 #endif
 
-SYM_FUNC_START(startup32_load_idt)
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	/* #VC handler */
-	leal    rva(startup32_vc_handler)(%ebp), %eax
-	movl    $X86_TRAP_VC, %edx
-	call    startup32_set_idt_entry
-
-	/* Load IDT */
-	leal	rva(boot32_idt)(%ebp), %eax
-	movl	%eax, rva(boot32_idt_desc+2)(%ebp)
-	lidt    rva(boot32_idt_desc)(%ebp)
-#endif
-	RET
-SYM_FUNC_END(startup32_load_idt)
-
 /*
  * Check for the correct C-bit position when the startup_32 boot-path is used.
  *
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index a73e4d783cae..889450d073ea 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -11,9 +11,14 @@
 
 #include <asm/processor-flags.h>
 #include <asm/msr.h>
+#include <asm/segment.h>
+#include <asm/trapnr.h>
 #include <asm/asm-offsets.h>
 
 	.text
+	.code64
+#include "../../kernel/sev_verify_cbit.S"
+
 	.code32
 SYM_FUNC_START(get_sev_encryption_bit)
 	xor	%eax, %eax
@@ -61,6 +66,8 @@ SYM_FUNC_START(get_sev_encryption_bit)
 	RET
 SYM_FUNC_END(get_sev_encryption_bit)
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+
 /**
  * sev_es_req_cpuid - Request a CPUID value from the Hypervisor using
  *		      the GHCB MSR protocol
@@ -98,7 +105,7 @@ SYM_CODE_START_LOCAL(sev_es_req_cpuid)
 	jmp	1b
 SYM_CODE_END(sev_es_req_cpuid)
 
-SYM_CODE_START(startup32_vc_handler)
+SYM_CODE_START_LOCAL(startup32_vc_handler)
 	pushl	%eax
 	pushl	%ebx
 	pushl	%ecx
@@ -184,15 +191,70 @@ SYM_CODE_START(startup32_vc_handler)
 	jmp .Lfail
 SYM_CODE_END(startup32_vc_handler)
 
-	.code64
+/*
+ * Write an IDT entry
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
+	/* Build IDT entry */
+	movl    %eax, %edx
+	andl    $0x0000ffff, %edx		# Target code segment offset [15:0]
+	andl    $0xffff0000, %eax		# Target code segment offset [31:16]
+	orl     $(__KERNEL32_CS << 16), %edx	# Target code segment selector
+	orl     $0x00008e00, %eax		# Present, Type 32-bit Interrupt Gate
+
+	/* Store entry to IDT */
+	movl    %edx, (%ecx)
+	movl    %eax, 4(%ecx)
+	RET
+SYM_FUNC_END(startup32_set_idt_entry)
 
-#include "../../kernel/sev_verify_cbit.S"
+SYM_FUNC_START(startup32_load_idt)
+	push	%ebp
+	push	%ebx
 
-	.data
+	call	1f
+1:	pop	%ebp
+	leal    (boot32_idt - 1b)(%ebp), %ebx
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
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
+	.data
 	.balign	8
 SYM_DATA(sme_me_mask,		.quad 0)
 SYM_DATA(sev_status,		.quad 0)
 SYM_DATA(sev_check_data,	.quad 0)
+
+SYM_DATA_START_LOCAL(boot32_idt)
+	.rept 32
+	.quad 0
+	.endr
+SYM_DATA_END(boot32_idt)
+
+SYM_DATA_START_LOCAL(boot32_idt_desc)
+	.word   . - boot32_idt - 1
+	.long   0
+SYM_DATA_END(boot32_idt_desc)
 #endif
-- 
2.35.1

