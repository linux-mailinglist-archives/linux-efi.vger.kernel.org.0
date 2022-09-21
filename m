Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57325C0077
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiIUOz4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiIUOzL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:55:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E836879;
        Wed, 21 Sep 2022 07:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71A7DB83032;
        Wed, 21 Sep 2022 14:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DE7C433D6;
        Wed, 21 Sep 2022 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772096;
        bh=nlSUhbGA0ylsVYAt77oav3fesjwMW7rDea8nZZxp6aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quVsnzRLyj9UipR5MACVwJzqUP03IWwXX5bo0ZlYa+ordoXKGVnhA06Pad2Yz07+6
         mUk8Guu6/36opXySWRZ9eaKEtn1JUvoMHQV2rxhXOVfPqV8RJePcf//5ONP4HI2kso
         uI/pyPkfzktG3CDd4GtkjEf5hnI5Z6AxrIsYU+AUp+MkwqVeWK9430U+2ppI75o6mt
         GC3VOaOydX/tb87Srcn3H/w+2/v2c3Aoi0jH8qxj9vQICQ0AAcAorBhMyvdF5y9Vg3
         iM5i/RWaqybmRjbe7CHyYB526FYdKCJqTfXHb6JANFMNgAGJvOo8Qkz6BoI0Is1NV1
         61+k7PaYuuQAQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 12/16] x86/compressed: move startup32_load_idt() out of head_64.S
Date:   Wed, 21 Sep 2022 16:54:18 +0200
Message-Id: <20220921145422.437618-13-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4991; i=ardb@kernel.org; h=from:subject; bh=nlSUhbGA0ylsVYAt77oav3fesjwMW7rDea8nZZxp6aA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWXnT+thXk9WFAYzVZ5ocJoz5PcVuJHGitoDGwK HFoMHGCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYysllwAKCRDDTyI5ktmPJIl/DA Cp2FqDmbmvyiQDd9MYzjBjQZ+P2LJxT2a6EOoIg1IB6VDrHhN9nF6nQm/8flEZIfPYTucjSPhMd1ll ieYowd0QfXV6HC1CUF9d4SY+wUaPLj9ZxgGpAeIrFfFWGouzrp0zKSwjCKBpQDymm4P1zySNrSdmYh Sck3Vyeu3Myo8rOkVQ4CiSMzm6Tx2GUAqyuRK2zoyxU0Ybq9nq2uXA9ynAyoBXBr3Ov+hy6u2N6NIZ r0TU7BQWAODxeHZGt3tInOIQ9n7Z4vhcpI6oUWnNeTuLmgGBO/z0bZnbeG1t50o4DitvO3j91Z6KtG miB2iXdMBz9oYWEh1DfW0w/xm3UepnDsFzQ96hfdaJ8eKk/k1zI41FlAMcDWnwy1pag94/6QdJpcn4 R+3w+r2MBwk3hrG55xbPHkS/OO7fL3m90oPuhAODw+n07+3BYGBpI12NS0OLzJNJyCnz6ZSwcfSn/7 RgpHPLpsgoim4Bv8y7H2NZZzJUE0k5cnp2zbgEbZFoxuk=
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
 arch/x86/boot/compressed/head_64.S     | 74 --------------------
 arch/x86/boot/compressed/mem_encrypt.S | 72 ++++++++++++++++++-
 2 files changed, 71 insertions(+), 75 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index b4b2b76ed1af..abb5a650a816 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -707,80 +707,6 @@ SYM_DATA_START(boot_idt)
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
-#ifdef CONFIG_AMD_MEM_ENCRYPT
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
index a73e4d783cae..6747e5e4c696 100644
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

