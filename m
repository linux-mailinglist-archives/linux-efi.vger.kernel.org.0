Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB76133F30
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2020 11:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgAHKXR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jan 2020 05:23:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbgAHKXR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 8 Jan 2020 05:23:17 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F051A2087F;
        Wed,  8 Jan 2020 10:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578478995;
        bh=SJcLl6cjxZhhRnMjejtRk4KrAt/ZXaxT86HsnUYW1BI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RqZ07UbklJWG7p7ycPf5YxMlEvh2t04TTLRUmUIhah0gL50uJQD2oEjBGkmtrHf8y
         fxJ++ofghfu7QTH2Y//8iHFieTYKjJlLFzecT0XJ4xTdLMCMv+6819Amra3QlkAdKM
         BlQtc22Hp2nlT3lMbEkmKV3aznwWZlGvwn7ci+6g=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [RFC PATCH 3/3] x86/boot/compressed: get rid of GOT fixup code
Date:   Wed,  8 Jan 2020 11:23:04 +0100
Message-Id: <20200108102304.25800-4-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108102304.25800-1-ardb@kernel.org>
References: <20200108102304.25800-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In a previous patch, we have eliminated GOT entries from the decompressor
binary and added an assertion that the .got section is empty. This means
that the GOT fixup routines that exist in both the 32-bit and 64-bit
startup routines have become dead code, and can be removed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_32.S     | 22 ++------
 arch/x86/boot/compressed/head_64.S     | 57 --------------------
 arch/x86/boot/compressed/vmlinux.lds.S |  2 -
 3 files changed, 3 insertions(+), 78 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index e43ac17cb9fb..b4dc883672a6 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -49,16 +49,13 @@
  * Position Independent Executable (PIE) so that linker won't optimize
  * R_386_GOT32X relocation to its fixed symbol address.  Older
  * linkers generate R_386_32 relocations against locally defined symbols,
- * _bss, _ebss, _got and _egot, in PIE.  It isn't wrong, just less
- * optimal than R_386_RELATIVE.  But the x86 kernel fails to properly handle
+ * _bss, _ebss, in PIE.  It isn't wrong, just suboptimal compared
+ * to R_386_RELATIVE.  But the x86 kernel fails to properly handle
  * R_386_32 relocations when relocating the kernel.  To generate
- * R_386_RELATIVE relocations, we mark _bss, _ebss, _got and _egot as
- * hidden:
+ * R_386_RELATIVE relocations, we mark _bss and _ebss as hidden:
  */
 	.hidden _bss
 	.hidden _ebss
-	.hidden _got
-	.hidden _egot
 
 	__HEAD
 SYM_FUNC_START(startup_32)
@@ -170,19 +167,6 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	shrl	$2, %ecx
 	rep	stosl
 
-/*
- * Adjust our own GOT
- */
-	leal	_got(%ebx), %edx
-	leal	_egot(%ebx), %ecx
-1:
-	cmpl	%ecx, %edx
-	jae	2f
-	addl	%ebx, (%edx)
-	addl	$4, %edx
-	jmp	1b
-2:
-
 /*
  * Do the extraction, and jump to the new kernel..
  */
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1f1f6c8139b3..28bfabcbef79 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -40,8 +40,6 @@
  */
 	.hidden _bss
 	.hidden _ebss
-	.hidden _got
-	.hidden _egot
 
 	__HEAD
 	.code32
@@ -309,25 +307,6 @@ SYM_CODE_START(startup_64)
 	/* Set up the stack */
 	leaq	boot_stack_end(%rbx), %rsp
 
-	/*
-	 * paging_prepare() and cleanup_trampoline() below can have GOT
-	 * references. Adjust the table with address we are running at.
-	 *
-	 * Zero RAX for adjust_got: the GOT was not adjusted before;
-	 * there's no adjustment to undo.
-	 */
-	xorq	%rax, %rax
-
-	/*
-	 * Calculate the address the binary is loaded at and use it as
-	 * a GOT adjustment.
-	 */
-	call	1f
-1:	popq	%rdi
-	subq	$1b, %rdi
-
-	call	.Ladjust_got
-
 	/*
 	 * At this point we are in long mode with 4-level paging enabled,
 	 * but we might want to enable 5-level paging or vice versa.
@@ -412,21 +391,6 @@ trampoline_return:
 	pushq	$0
 	popfq
 
-	/*
-	 * Previously we've adjusted the GOT with address the binary was
-	 * loaded at. Now we need to re-adjust for relocation address.
-	 *
-	 * Calculate the address the binary is loaded at, so that we can
-	 * undo the previous GOT adjustment.
-	 */
-	call	1f
-1:	popq	%rax
-	subq	$1b, %rax
-
-	/* The new adjustment is the relocation address */
-	movq	%rbx, %rdi
-	call	.Ladjust_got
-
 /*
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
@@ -494,27 +458,6 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	jmp	*%rax
 SYM_FUNC_END(.Lrelocated)
 
-/*
- * Adjust the global offset table
- *
- * RAX is the previous adjustment of the table to undo (use 0 if it's the
- * first time we touch GOT).
- * RDI is the new adjustment to apply.
- */
-.Ladjust_got:
-	/* Walk through the GOT adding the address to the entries */
-	leaq	_got(%rip), %rdx
-	leaq	_egot(%rip), %rcx
-1:
-	cmpq	%rcx, %rdx
-	jae	2f
-	subq	%rax, (%rdx)	/* Undo previous adjustment */
-	addq	%rdi, (%rdx)	/* Apply the new adjustment */
-	addq	$8, %rdx
-	jmp	1b
-2:
-	ret
-
 	.code32
 /*
  * This is the 32-bit trampoline that will be copied over to low memory.
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 955496ff2fcd..3fc308f94ce3 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -43,9 +43,7 @@ SECTIONS
 		_erodata = . ;
 	}
 	.got : {
-		_got = .;
 		KEEP(*(.got))
-		_egot = .;
 	}
 	.got.plt : {
 		KEEP(*(.got.plt))
-- 
2.20.1

