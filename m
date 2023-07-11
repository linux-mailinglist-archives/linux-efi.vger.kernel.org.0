Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E8174EA12
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jul 2023 11:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjGKJQ4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jul 2023 05:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjGKJQH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jul 2023 05:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A33719BC;
        Tue, 11 Jul 2023 02:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1E5F61418;
        Tue, 11 Jul 2023 09:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37718C433CA;
        Tue, 11 Jul 2023 09:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689066946;
        bh=gxLsEkoDGg4mIvvhxqLtxwNQiYAezxQxa0+9h4F2jjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PfqLD4O1XeIuzYrzNeOHcYOHjz4ogHz9efdFISOPC5YLYmGj+HmqBMUATYY96knk5
         meqC1tUcdu1G9L5Zcw2QsfxSaADeT9DNKK31XQIExLcRe91qBCPZALyFRVzECCBQgx
         Jjh6cUDAQyysy/8hDQ/VIQ+j1s7pwJTL3qNrxEhquS51eR7I+3qOc/I2K38qK2m6tA
         DxRpO+/izRWM/vtdsn+ZdDR+QkfywvY7f4HlJ+x068nhOOFE6UqW3MN7I5KDiR5u82
         3GoLKN0I3njFXPJf4Et8N+m8awWq6c/TB7BOAFmxMI9GymT6mEaGxzNZB705ek26+h
         FBI7PA0QkD1eA==
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
Subject: [PATCH v6 10/21] x86/decompressor: Avoid the need for a stack in the 32-bit trampoline
Date:   Tue, 11 Jul 2023 11:14:42 +0200
Message-Id: <20230711091453.2543622-11-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711091453.2543622-1-ardb@kernel.org>
References: <20230711091453.2543622-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6253; i=ardb@kernel.org; h=from:subject; bh=gxLsEkoDGg4mIvvhxqLtxwNQiYAezxQxa0+9h4F2jjU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWWtbMPNugV7hZ7J96ZsXpF8/tyJLc3Xtm1uuiX1WsEtQ FjYOfJURykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiI1S9Ghlu7gz5O8Jgu6x2V EelS8Vumx+zuiezzivZnsw+k+e0M/c3wz46fdYvetb2t/Zf+3XLjZT1dub/nHMPtuOeiM4pPRTk eZgEA
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

