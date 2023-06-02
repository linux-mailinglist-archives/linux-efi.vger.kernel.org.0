Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D294E71FF15
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 12:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbjFBKXu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbjFBKWz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 06:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02A71A2;
        Fri,  2 Jun 2023 03:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 479C764E6C;
        Fri,  2 Jun 2023 10:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A38C4339E;
        Fri,  2 Jun 2023 10:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685701366;
        bh=opd5H6IVQawxAyaERFSxkNMBcud1PLTZeWa/VKUckUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMziCQIVqQGPlxVhREtKOQUKNdUzCNaj8norH3m8d9ok64s2AgSIVPGbFwGC8pTNZ
         8fBlaSBOkbDaNKchiVuUcX2LI96YhWaKKvNkP+59H1H+RskBg0f7qqZ7lDrefC7VVF
         mHhH+6of6LC/Nrcoofc3CB7IFfsztqW1VUnc1iBNsQHguqko7vpVJFVad6h/ghnWc4
         bAaNQqvhisciRrf0UBwxtXappXKZJqaHyQLE4D+QYwRlmE2n6084qz0ER8eLxmOYqF
         rPKZNXpQYn0aiIQdNj0JdD1cahzAACVGXITO+7+1/PFvxxGSN4drTlzYx4vJE1mLZB
         kLq95up9Nk59g==
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
Subject: [PATCH v4 09/21] x86/decompressor: Avoid the need for a stack in the 32-bit trampoline
Date:   Fri,  2 Jun 2023 12:13:01 +0200
Message-Id: <20230602101313.3557775-10-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230602101313.3557775-1-ardb@kernel.org>
References: <20230602101313.3557775-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6184; i=ardb@kernel.org; h=from:subject; bh=opd5H6IVQawxAyaERFSxkNMBcud1PLTZeWa/VKUckUQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXywKrD16I62NpYrdcd4c0/OFVmC+uFDfX//6yR3fBXM Kcl3reuo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzEMomRYYHD/GJBbqcbry4d D+vusGev3NSrOXWX8qPTTV8tFp3bpsfwT1tiIa9iwh7tqdET1x2dzqHVVd2+/7bt/QUP4x7NWsP 6gh8A
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 45 ++++++++------------
 arch/x86/boot/compressed/pgtable.h    |  6 +--
 arch/x86/boot/compressed/pgtable_64.c | 12 +++++-
 3 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a387cd80964e1a1e..741b4e8fefc915ea 100644
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
@@ -537,24 +534,22 @@ SYM_FUNC_END(.Lrelocated)
  * EDI contains the base address of the trampoline memory.
  * Non-zero ESI means trampoline needs to enable 5-level paging.
  */
+	.section ".rodata", "a", @progbits
 SYM_CODE_START(trampoline_32bit_src)
-	popq	%r8
 	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
 	pushq	$__KERNEL32_CS
 	leaq	0f(%rip), %rax
 	pushq	%rax
 	lretq
 
+	/*
+	 * The 32-bit code below will do a far jump back to long mode and end
+	 * up here after reconfiguring the number of paging levels.
+	 */
+.Lret:	retq
+
 	.code32
-0:	/* Set up data and stack segments */
-	movl	$__KERNEL_DS, %eax
-	movl	%eax, %ds
-	movl	%eax, %ss
-
-	/* Set up new stack */
-	leal	TRAMPOLINE_32BIT_STACK_END(%edi), %esp
-
-	/* Disable paging */
+0:	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
 	movl	%eax, %cr0
@@ -608,26 +603,22 @@ SYM_CODE_START(trampoline_32bit_src)
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
-	jmp	*%r8
-SYM_FUNC_END(.Lpaging_enabled)
+/* keep this right after trampoline_32bit_src() so we can infer its size */
+SYM_DATA(trampoline_ljmp_imm_offset, .word  .Ljmp + 1 - trampoline_32bit_src)
 
 	/*
          * The trampoline code has a size limit.
@@ -636,7 +627,7 @@ SYM_FUNC_END(.Lpaging_enabled)
 	 */
 	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
 
-	.code32
+	.text
 SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index 4e8cef135226bcbb..131488f50af55d0a 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -6,9 +6,7 @@
 #define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
 
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
-#define TRAMPOLINE_32BIT_CODE_SIZE	0xA0
-
-#define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
+#define TRAMPOLINE_32BIT_CODE_SIZE	0x80
 
 #ifndef __ASSEMBLER__
 
@@ -16,5 +14,7 @@ extern unsigned long *trampoline_32bit;
 
 extern void trampoline_32bit_src(void *trampoline, bool enable_5lvl);
 
+extern const u16 trampoline_ljmp_imm_offset;
+
 #endif /* __ASSEMBLER__ */
 #endif /* BOOT_COMPRESSED_PAGETABLE_H */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 2ac12ff4111bf8c0..09fc18180929fab3 100644
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
+	 * immediate absolute address, so we have to adjust that based on the
+	 * placement of the trampoline.
+	 */
+	*(u32 *)(tramp_code + trampoline_ljmp_imm_offset) += (unsigned long)tramp_code;
+
 	/*
 	 * The code below prepares page table in trampoline memory.
 	 *
-- 
2.39.2

