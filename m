Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35B6766874
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jul 2023 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjG1JN2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jul 2023 05:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbjG1JMq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jul 2023 05:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D343C05;
        Fri, 28 Jul 2023 02:11:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B893262080;
        Fri, 28 Jul 2023 09:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C51CC433CB;
        Fri, 28 Jul 2023 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535489;
        bh=zb9LZmjOYI3iltlzgu+uUQDWaVktAFuGGB7huSFwGZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6bbCBm68qvSzh+haKFgFJMrxjigtMQ4Z5UCpcBy+Jzm8Xqgok3h1YEeXryqqcjE3
         rEbBN+VIF9ZmfPN6q5Eq7qJenrSfN+S7KapeFktSj6quCoJDKhpjMvNraJkxeO1Aqk
         5SnKHRZbYgLLfCyX+isLtWkYHpA7okVbzB/V1THNGD41TKqQ+V/dIAxzhf7ABBeDgd
         Na4zXxMqAqSW01Wn4lwH3OBk4B83TsQY+4p4m4lHEPXpEdXXfnpkewh9OlK8qCJBPM
         6jdfb+yIofT0JvAteb4afC4iSUQFZ+phAENJROX++idQsbsb2bSmjc5WcQe8jC4EZQ
         xSuodLiIi+oKg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v7 11/22] x86/decompressor: Avoid the need for a stack in the 32-bit trampoline
Date:   Fri, 28 Jul 2023 11:09:05 +0200
Message-Id: <20230728090916.1538550-12-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728090916.1538550-1-ardb@kernel.org>
References: <20230728090916.1538550-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6725; i=ardb@kernel.org; h=from:subject; bh=zb9LZmjOYI3iltlzgu+uUQDWaVktAFuGGB7huSFwGZQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVw6zqX0PvhP9O4tzrV/f39/n/Khl0msfeKj2f6sJ63k POyjbTqKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABO5bcXwP4MzxiFEp/fwg6Mc B4r2t6xl1JdLtXHwsLwu6D4lnHvXGob/ftuPWFhMr3rsaMnVZuumIGynyBycXCJR8W6ywlazT1a sAA==
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

The 32-bit trampoline no longer uses the stack for anything except
performing a far return back to long mode. Currently, this stack is
placed in the same page that carries the trampoline code, which means
this page must be mapped writable and executable, and the stack is
therefore executable as well.

Replace the far return with a far jump, so that the return address can
be pre-calculated and patched into the code before it is called. This
removes the need for a stack entirely, and in a later patch, this will
be taken advantage of by removing writable permissions from (and adding
executable permissions to) this code page explicitly when booting via
the EFI stub.

Not touching the stack pointer also makes it more straight-forward to
call the trampoline code as an ordinary 64-bit function from C code.

Note that we need to preserve the value of RSP across the switch into
compatibility mode: the stack pointer may get truncated to 32 bits.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 64 ++++++++++----------
 arch/x86/boot/compressed/pgtable.h    |  4 +-
 arch/x86/boot/compressed/pgtable_64.c | 12 +++-
 3 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 491d985be75fd5b0..1b0c61d1b389fd37 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -449,9 +449,6 @@ SYM_CODE_START(startup_64)
 	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
 	call	*%rax
 
-	/* Restore the stack, the 32-bit trampoline uses its own stack */
-	leaq	rva(boot_stack_end)(%rbx), %rsp
-
 	/*
 	 * cleanup_trampoline() would restore trampoline memory.
 	 *
@@ -537,32 +534,37 @@ SYM_FUNC_END(.Lrelocated)
  * EDI contains the base address of the trampoline memory.
  * Non-zero ESI means trampoline needs to enable 5-level paging.
  */
+	.section ".rodata", "a", @progbits
 SYM_CODE_START(trampoline_32bit_src)
-	/* Grab return address */
-	movq	(%rsp), %rax
-
-	/* Set up 32-bit addressable stack */
-	leaq	TRAMPOLINE_32BIT_STACK_END(%rdi), %rsp
-
-	/* Preserve return address and other live 64-bit registers */
-	pushq	%rax
+	/* Preserve live 64-bit registers */
 	pushq	%r15
 	pushq	%rbp
 	pushq	%rbx
 
+	/* Preserve top half of RSP in a legacy mode GPR to avoid truncation */
+	movq	%rsp, %rbx
+	shrq	$32, %rbx
+
 	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
 	pushq	$__KERNEL32_CS
 	leaq	0f(%rip), %rax
 	pushq	%rax
 	lretq
 
+	/*
+	 * The 32-bit code below will do a far jump back to long mode and end
+	 * up here after reconfiguring the number of paging levels.
+	 */
+.Lret:	shlq	$32, %rbx		// Reconstruct stack pointer
+	orq	%rbx, %rsp
+
+	popq	%rbx
+	popq	%rbp
+	popq	%r15
+	retq
+
 	.code32
 0:
-	/* Set up data and stack segments */
-	movl	$__KERNEL_DS, %eax
-	movl	%eax, %ds
-	movl	%eax, %ss
-
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -617,29 +619,25 @@ SYM_CODE_START(trampoline_32bit_src)
 1:
 	movl	%eax, %cr4
 
-	/* Calculate address of paging_enabled() once we are executing in the trampoline */
-	leal	.Lpaging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%edi), %eax
-
-	/* Prepare the stack for far return to Long Mode */
-	pushl	$__KERNEL_CS
-	pushl	%eax
-
 	/* Enable paging again. */
 	movl	%cr0, %eax
 	btsl	$X86_CR0_PG_BIT, %eax
 	movl	%eax, %cr0
 
-	lret
+	/*
+	 * Return to the 64-bit calling code using LJMP rather than LRET, to
+	 * avoid the need for a 32-bit addressable stack. The destination
+	 * address will be adjusted after the template code is copied into a
+	 * 32-bit addressable buffer.
+	 */
+.Ljmp:	ljmpl	$__KERNEL_CS, $(.Lret - trampoline_32bit_src)
 SYM_CODE_END(trampoline_32bit_src)
 
-	.code64
-SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
-	/* Return from the trampoline */
-	popq	%rbx
-	popq	%rbp
-	popq	%r15
-	retq
-SYM_FUNC_END(.Lpaging_enabled)
+/*
+ * This symbol is placed right after trampoline_32bit_src() so its address can
+ * be used to infer the size of the trampoline code.
+ */
+SYM_DATA(trampoline_ljmp_imm_offset, .word  .Ljmp + 1 - trampoline_32bit_src)
 
 	/*
          * The trampoline code has a size limit.
@@ -648,7 +646,7 @@ SYM_FUNC_END(.Lpaging_enabled)
 	 */
 	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
 
-	.code32
+	.text
 SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index 4e8cef135226bcbb..c6b0903aded05a07 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -8,13 +8,13 @@
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
 #define TRAMPOLINE_32BIT_CODE_SIZE	0xA0
 
-#define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
-
 #ifndef __ASSEMBLER__
 
 extern unsigned long *trampoline_32bit;
 
 extern void trampoline_32bit_src(void *trampoline, bool enable_5lvl);
 
+extern const u16 trampoline_ljmp_imm_offset;
+
 #endif /* __ASSEMBLER__ */
 #endif /* BOOT_COMPRESSED_PAGETABLE_H */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 2ac12ff4111bf8c0..d66639c961b8eeda 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -109,6 +109,7 @@ static unsigned long find_trampoline_placement(void)
 struct paging_config paging_prepare(void *rmode)
 {
 	struct paging_config paging_config = {};
+	void *tramp_code;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
 	boot_params = rmode;
@@ -143,9 +144,18 @@ struct paging_config paging_prepare(void *rmode)
 	memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
 
 	/* Copy trampoline code in place */
-	memcpy(trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
+	tramp_code = memcpy(trampoline_32bit +
+			TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
 			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
 
+	/*
+	 * Avoid the need for a stack in the 32-bit trampoline code, by using
+	 * LJMP rather than LRET to return back to long mode. LJMP takes an
+	 * immediate absolute address, which needs to be adjusted based on the
+	 * placement of the trampoline.
+	 */
+	*(u32 *)(tramp_code + trampoline_ljmp_imm_offset) += (unsigned long)tramp_code;
+
 	/*
 	 * The code below prepares page table in trampoline memory.
 	 *
-- 
2.39.2

