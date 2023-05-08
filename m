Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719D06FA086
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 09:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjEHHFo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 03:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjEHHFJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 03:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5D71F48C;
        Mon,  8 May 2023 00:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71A7761F8C;
        Mon,  8 May 2023 07:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6DEC433A1;
        Mon,  8 May 2023 07:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529470;
        bh=4yAB7qU2wBVgLTvHIHU6cIIZ4zGzroQGyA3YqSYrfmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmwammIdU7YC9lbQBSs3qyH0YJ63WWeoJAf7K+TgDHLan4Oe3DmD1oHuptUzWWc5U
         FwiCLsGsQqDkxOLtj33NzVFdUeyaFd+qtelkUENTiIXr8z7RWb8mYtqxOj2RwYseek
         4HjUzLyZj1fTQ087NzlKaipHBUwuCBXCEWT3MWL8IxNRfU/TWpYNkofDjhlLzr2kG0
         YW4w+Air4OSGcX+Ell3abGYv3h/EhUOgBXY1Jbh8Q7NEQUxgzRtYQLmQsPo7V7BO/A
         WFRKo16YjIZ7y9rbVMZeuuOagb1rm0iMPc4Lewvfl9YO/rTPXa6tpqvCxn315Eo3ON
         269KlaI2Z8e0A==
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
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 12/20] x86: decompressor: Move global symbol references to C code
Date:   Mon,  8 May 2023 09:03:22 +0200
Message-Id: <20230508070330.582131-13-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508070330.582131-1-ardb@kernel.org>
References: <20230508070330.582131-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4975; i=ardb@kernel.org; h=from:subject; bh=4yAB7qU2wBVgLTvHIHU6cIIZ4zGzroQGyA3YqSYrfmM=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3o4Fr6aHe4veZr3r/3Jto5qFwOb9/z3TLx9xia3a3 PO967BVRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIlbsMf/iSG169XyMmGr3e Mv5yZ9tM/Yqscz93XHF/acJe0jvtfx0jw4cyze1xZQ4qYqrv1v7vfaE/a2bw6s0it5n97O8/dep /yQcA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We no longer have to be cautious when referring to global variables in
the position independent decompressor code, now that we use PIE codegen
and assert in the linker script that no GOT entries exist (which would
require adjustment for the actual runtime load address of the
decompressor binary).

This means we can simply refer to global variables directly, instead of
passing them into C routines from asm code. Let's do so for the code
that will be called directly from the EFI stub after a subsequent patch,
and avoid the need to pass these quantities directly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_32.S |  8 --------
 arch/x86/boot/compressed/head_64.S |  8 +-------
 arch/x86/boot/compressed/misc.c    | 16 +++++++++-------
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 53cbee1e2a93efce..8ee8749007595fcc 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -179,13 +179,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
  */
 	/* push arguments for extract_kernel: */
 
-	pushl	output_len@GOTOFF(%ebx)	/* decompressed length, end of relocs */
 	pushl	%ebp			/* output address */
-	pushl	input_len@GOTOFF(%ebx)	/* input_len */
-	leal	input_data@GOTOFF(%ebx), %eax
-	pushl	%eax			/* input_data */
-	leal	boot_heap@GOTOFF(%ebx), %eax
-	pushl	%eax			/* heap area */
 	pushl	%esi			/* real mode pointer */
 	call	extract_kernel		/* returns kernel entry point in %eax */
 	addl	$24, %esp
@@ -213,8 +207,6 @@ SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
  */
 	.bss
 	.balign 4
-boot_heap:
-	.fill BOOT_HEAP_SIZE, 1, 0
 boot_stack:
 	.fill BOOT_STACK_SIZE, 1, 0
 boot_stack_end:
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 21af9cfd0dd0afb7..bcf678aed81468e3 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -519,11 +519,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
  * Do the extraction, and jump to the new kernel..
  */
 	movq	%r15, %rdi		/* pass struct boot_params pointer */
-	leaq	boot_heap(%rip), %rsi	/* malloc area for uncompression */
-	leaq	input_data(%rip), %rdx  /* input_data */
-	movl	input_len(%rip), %ecx	/* input_len */
-	movq	%rbp, %r8		/* output target address */
-	movl	output_len(%rip), %r9d	/* decompressed length, end of relocs */
+	movq	%rbp, %rsi		/* output target address */
 	call	extract_kernel		/* returns kernel entry point in %rax */
 
 /*
@@ -651,8 +647,6 @@ SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
  */
 	.bss
 	.balign 4
-SYM_DATA_LOCAL(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
-
 SYM_DATA_START_LOCAL(boot_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
 	.balign 16
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 014ff222bf4b35c2..1cd40cb9fb4e5027 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -330,6 +330,11 @@ static size_t parse_elf(void *output)
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
+static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
+
+extern unsigned char input_data[];
+extern unsigned int input_len, output_len;
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -347,14 +352,11 @@ static size_t parse_elf(void *output)
  *             |-------uncompressed kernel image---------|
  *
  */
-asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
-				  unsigned char *input_data,
-				  unsigned long input_len,
-				  unsigned char *output,
-				  unsigned long output_len)
+asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 {
 	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
+	memptr heap = (memptr)boot_heap;
 	unsigned long needed_size;
 	size_t entry_offset;
 
@@ -412,7 +414,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	 * entries. This ensures the full mapped area is usable RAM
 	 * and doesn't include any reserved areas.
 	 */
-	needed_size = max(output_len, kernel_total_size);
+	needed_size = max((unsigned long)output_len, kernel_total_size);
 #ifdef CONFIG_X86_64
 	needed_size = ALIGN(needed_size, MIN_KERNEL_ALIGN);
 #endif
@@ -443,7 +445,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 #ifdef CONFIG_X86_64
 	if (heap > 0x3fffffffffffUL)
 		error("Destination address too large");
-	if (virt_addr + max(output_len, kernel_total_size) > KERNEL_IMAGE_SIZE)
+	if (virt_addr + needed_size > KERNEL_IMAGE_SIZE)
 		error("Destination virtual address is beyond the kernel mapping area");
 #else
 	if (heap > ((-__PAGE_OFFSET-(128<<20)-1) & 0x7fffffff))
-- 
2.39.2

