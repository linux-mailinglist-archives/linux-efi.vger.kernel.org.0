Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB1A772AB3
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjHGQ2R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjHGQ2N (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8901736;
        Mon,  7 Aug 2023 09:28:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BC0B61EDB;
        Mon,  7 Aug 2023 16:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF688C433C8;
        Mon,  7 Aug 2023 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425684;
        bh=fjkcob2xgGNWbmxPyT046ld3aiHiccqW2NKMWmAIfyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbgtznVf5hLnv4xU/jIAzBl9FngvtmOwirNEq0bxgqxGTBRCToYtrOrOk6a5XIq29
         Q0dA3G/FA+jeQVLIOIW72A2aQC/EPaOOOzN9QPYx5QxiJ3pU1e4kApVuotd5gyJQwJ
         C0baUFC0A/RhYz6lRYfuB2knEwHTCSfI+Vpi+6NuwrUqLX5jRKbpv/g+L0/w6dP0qy
         JcxHA7v9x8TldW2hdQAPZtag/f3a1ycdhmMxMhFKRLcORdCiuCofzwfMrW4cPBazWg
         +IStoJxzeNB8QfbrqJUg0GhPW5KtCw1MWyrWFstwxZVeauSkJHTr9NwZ/EJy6mWdBW
         lcIMkyTy+aF/Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v9 11/23] x86/decompressor: Avoid the need for a stack in the 32-bit trampoline
Date:   Mon,  7 Aug 2023 18:27:08 +0200
Message-Id: <20230807162720.545787-12-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807162720.545787-1-ardb@kernel.org>
References: <20230807162720.545787-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6456; i=ardb@kernel.org; h=from:subject; bh=fjkcob2xgGNWbmxPyT046ld3aiHiccqW2NKMWmAIfyY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWidISWBMvsdQsKI64+qZI/VZNQaGj31Kbr+ewbxe9PV ben/W7rKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABP5XMLwm3Uz274ZKrYvln+8 mS5RkP65ubaFf9fzhorqz1nyuocKEhkZOjVWy927uePjZg4nzTtev24xPzo7+XZ7zHtNVSVLw/U NPAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The 32-bit trampoline no longer uses the stack for anything except
performing a far return back to long mode, and preserving the caller's
stack pointer value. Currently, the trampoline stack is placed in the
same page that carries the trampoline code, which means this page must
be mapped writable and executable, and the stack is therefore executable
as well.

Replace the far return with a far jump, so that the return address can
be pre-calculated and patched into the code before it is called. This
removes the need for a 32-bit addressable stack entirely, and in a later
patch, this will be taken advantage of by removing writable permissions
from (and adding executable permissions to) the trampoline code page
when booting via the EFI stub.

Note that the value of RSP still needs to be preserved explicitly across
the switch into 32-bit mode, as the register may get truncated to 32
bits.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 45 ++++++++++++--------
 arch/x86/boot/compressed/pgtable.h    |  4 +-
 arch/x86/boot/compressed/pgtable_64.c | 12 +++++-
 3 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index c47504208105d7d3..37fd7b7d683d696c 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -540,6 +540,7 @@ SYM_FUNC_END(.Lrelocated)
  * trampoline memory. A non-zero second argument (ESI) means that the
  * trampoline needs to enable 5-level paging.
  */
+	.section ".rodata", "a", @progbits
 SYM_CODE_START(trampoline_32bit_src)
 	/*
 	 * Preserve live 64-bit registers on the stack: this is necessary
@@ -550,13 +551,9 @@ SYM_CODE_START(trampoline_32bit_src)
 	pushq	%rbp
 	pushq	%rbx
 
-	/* Set up 32-bit addressable stack and push the old RSP value */
-	leaq	(TRAMPOLINE_32BIT_STACK_END - 8)(%rcx), %rbx
-	movq	%rsp, (%rbx)
-	movq	%rbx, %rsp
-
-	/* Take the address of the trampoline exit code */
-	leaq	.Lret(%rip), %rbx
+	/* Preserve top half of RSP in a legacy mode GPR to avoid truncation */
+	movq	%rsp, %rbx
+	shrq	$32, %rbx
 
 	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
 	pushq	$__KERNEL32_CS
@@ -564,9 +561,17 @@ SYM_CODE_START(trampoline_32bit_src)
 	pushq	%rax
 	lretq
 
+	/*
+	 * The 32-bit code below will do a far jump back to long mode and end
+	 * up here after reconfiguring the number of paging levels. First, the
+	 * stack pointer needs to be restored to its full 64-bit value before
+	 * the callee save register contents can be popped from the stack.
+	 */
 .Lret:
+	shlq	$32, %rbx
+	orq	%rbx, %rsp
+
 	/* Restore the preserved 64-bit registers */
-	movq	(%rsp), %rsp
 	popq	%rbx
 	popq	%rbp
 	popq	%r15
@@ -574,11 +579,6 @@ SYM_CODE_START(trampoline_32bit_src)
 
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
@@ -633,18 +633,26 @@ SYM_CODE_START(trampoline_32bit_src)
 1:
 	movl	%eax, %cr4
 
-	/* Prepare the stack for far return to Long Mode */
-	pushl	$__KERNEL_CS
-	pushl	%ebx
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
 
+/*
+ * This symbol is placed right after trampoline_32bit_src() so its address can
+ * be used to infer the size of the trampoline code.
+ */
+SYM_DATA(trampoline_ljmp_imm_offset, .word  .Ljmp + 1 - trampoline_32bit_src)
+
 	/*
          * The trampoline code has a size limit.
          * Make sure we fail to compile if the trampoline code grows
@@ -652,6 +660,7 @@ SYM_CODE_END(trampoline_32bit_src)
 	 */
 	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
 
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
index f8092d3244c9559b..5198a05aefa8d14a 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -109,6 +109,7 @@ static unsigned long find_trampoline_placement(void)
 struct paging_config paging_prepare(void *rmode)
 {
 	struct paging_config paging_config = {};
+	void *tramp_code;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
 	boot_params = rmode;
@@ -148,9 +149,18 @@ struct paging_config paging_prepare(void *rmode)
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

