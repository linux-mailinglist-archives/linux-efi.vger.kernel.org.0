Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC363725598
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 09:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbjFGH0p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 03:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239218AbjFGH0J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 03:26:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AC92733;
        Wed,  7 Jun 2023 00:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2418C633D6;
        Wed,  7 Jun 2023 07:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6175C433A1;
        Wed,  7 Jun 2023 07:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686122674;
        bh=gxLsEkoDGg4mIvvhxqLtxwNQiYAezxQxa0+9h4F2jjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7HWBXaJpWPhzKi3lc1wVD2Z2EMcOliBv5MFGMJ1SyEh8z85J1xHLu4d7/vkZhw2a
         +cGmaFx3D3obhq/m9tl4U6Mmb3tBjCkEHmRf99fT8s2L14/vUpSFp2Nb3gB2GNIW0v
         uGvap7ISzB0uWWzfIR0aiUYR1ANFA573hXyqcp+iL8SHWQrkf5pvV1QBs7HxJ2PxXl
         YRwb1Tbtvz5QvHa4v+KuBxvYWjWwIhWRwUpKeA+22m84nn0pgrjPTBAWKhiwppgR1G
         lRqDY9QNhI4n6Z5zbRoF8UG2zA88nLaMC5QQnDMZENKs9UjI+ZDZIDA+QdWFtY7uqc
         zkADpbx14Y/AQ==
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
Subject: [PATCH v5 09/20] x86/decompressor: Avoid the need for a stack in the 32-bit trampoline
Date:   Wed,  7 Jun 2023 09:23:31 +0200
Message-Id: <20230607072342.4054036-10-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607072342.4054036-1-ardb@kernel.org>
References: <20230607072342.4054036-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6253; i=ardb@kernel.org; h=from:subject; bh=gxLsEkoDGg4mIvvhxqLtxwNQiYAezxQxa0+9h4F2jjU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXBIP9m3YK9Qs/ke1M2r0g+f+7EluZr2zY33ZJ6reAWI CzsHHmqo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEyERYPhnzKXcvrqqbxaba5L i4TKnJb3L/DbMYn5paNX7OLnR861zWNkaJsi/X6lLsP5c96GqrU+n2pvvfDQeMd5aqfxWomuW4c uMAEA
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

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 48 +++++++++-----------
 arch/x86/boot/compressed/pgtable.h    |  6 +--
 arch/x86/boot/compressed/pgtable_64.c | 12 ++++-
 3 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a387cd80964e1a1e..cdefafd456c70335 100644
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
@@ -608,26 +603,25 @@ SYM_CODE_START(trampoline_32bit_src)
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
+/*
+ * This symbol is placed right after trampoline_32bit_src() so its address can
+ * be used to infer the size of the trampoline code.
+ */
+SYM_DATA(trampoline_ljmp_imm_offset, .word  .Ljmp + 1 - trampoline_32bit_src)
 
 	/*
          * The trampoline code has a size limit.
@@ -636,7 +630,7 @@ SYM_FUNC_END(.Lpaging_enabled)
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

