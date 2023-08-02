Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38D376D2DB
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 17:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbjHBPuf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 11:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjHBPuC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 11:50:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B84198B;
        Wed,  2 Aug 2023 08:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D6C361A10;
        Wed,  2 Aug 2023 15:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9ABC433C9;
        Wed,  2 Aug 2023 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690991375;
        bh=o3w6/K1bZDjt5Qe6bPiZnYXVVaPATRaZ4q8AqRzBKd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZRcU1y0eqPy0VTwEbezskEtnPaZ5lDQ3ApN33vgb/tFK3UhI15q8TMDL2atKh6VjR
         f/w90Jg3PXZBe6qKmvcxNjysN60pM3PNj+md9a+OGBLbzO51bWqL0pOepR/J9z84a5
         QbRu2sExpq5tzxOgXr88lGpQs+bka0/bWMDUSM1cd03psOcLAexAFVjWfckooRZtom
         IE9EcvRGac3jtaZoTax50FMur7YWf+hfPV5eYp07AY6r/BzictkZ4AkMzIJs6h6u9N
         xc4D5svNdcm65oTEITO6lCOm8ZBUQbdAMqLGFQ8Cjyp638yLTJ4K0+8pNDwm1Ap/t/
         afeJy16NVvZ5g==
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
Subject: [PATCH v8 10/23] x86/decompressor: Use standard calling convention for trampoline
Date:   Wed,  2 Aug 2023 17:48:18 +0200
Message-Id: <20230802154831.2147855-11-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802154831.2147855-1-ardb@kernel.org>
References: <20230802154831.2147855-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3491; i=ardb@kernel.org; h=from:subject; bh=o3w6/K1bZDjt5Qe6bPiZnYXVVaPATRaZ4q8AqRzBKd0=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVU1T7uTIv9888t6Jo26/4qedWZqxv6lIV2/lv9M8pv0 b6uRO8JHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAir70Y/sppel5+nykg8OPt W/vLsl0/t38+fve1nvqhVj6ZjMUv7l5kZOj0kBf6rm3AsjzQ9o7/It6bcfdfnl23SEC24mjKez3 /fl4A
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

Update the trampoline code so its arguments are passed via RDI and RSI,
which matches the ordinary SysV calling convention for x86_64. This will
allow this code to be called directly from C.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 27 ++++++++++----------
 arch/x86/boot/compressed/pgtable.h |  2 +-
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 91b5eee306148f9a..c47504208105d7d3 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -444,9 +444,9 @@ SYM_CODE_START(startup_64)
 	movq	%r15, %rdi
 	call	paging_prepare
 
-	/* Save the trampoline address in RCX */
-	movq	%rax, %rcx
-
+	/* Pass the trampoline address and boolean flag as args #1 and #2 */
+	movq	%rax, %rdi
+	movq	%rdx, %rsi
 	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
 	call	*%rax
 
@@ -531,11 +531,14 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 SYM_FUNC_END(.Lrelocated)
 
 /*
- * This is the 32-bit trampoline that will be copied over to low memory.
+ * This is the 32-bit trampoline that will be copied over to low memory. It
+ * will be called using the ordinary 64-bit calling convention from code
+ * running in 64-bit mode.
  *
  * Return address is at the top of the stack (might be above 4G).
- * ECX contains the base address of the trampoline memory.
- * Non zero RDX means trampoline needs to enable 5-level paging.
+ * The first argument (EDI) contains the 32-bit addressable base of the
+ * trampoline memory. A non-zero second argument (ESI) means that the
+ * trampoline needs to enable 5-level paging.
  */
 SYM_CODE_START(trampoline_32bit_src)
 	/*
@@ -582,7 +585,7 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	%eax, %cr0
 
 	/* Check what paging mode we want to be in after the trampoline */
-	testl	%edx, %edx
+	testl	%esi, %esi
 	jz	1f
 
 	/* We want 5-level paging: don't touch CR3 if it already points to 5-level page tables */
@@ -597,21 +600,17 @@ SYM_CODE_START(trampoline_32bit_src)
 	jz	3f
 2:
 	/* Point CR3 to the trampoline's new top level page table */
-	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%ecx), %eax
+	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%edi), %eax
 	movl	%eax, %cr3
 3:
 	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
-	pushl	%ecx
-	pushl	%edx
 	movl	$MSR_EFER, %ecx
 	rdmsr
 	btsl	$_EFER_LME, %eax
 	/* Avoid writing EFER if no change was made (for TDX guest) */
 	jc	1f
 	wrmsr
-1:	popl	%edx
-	popl	%ecx
-
+1:
 #ifdef CONFIG_X86_MCE
 	/*
 	 * Preserve CR4.MCE if the kernel will enable #MC support.
@@ -628,7 +627,7 @@ SYM_CODE_START(trampoline_32bit_src)
 
 	/* Enable PAE and LA57 (if required) paging modes */
 	orl	$X86_CR4_PAE, %eax
-	testl	%edx, %edx
+	testl	%esi, %esi
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
 1:
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index 91dbb99203fbce2d..4e8cef135226bcbb 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -14,7 +14,7 @@
 
 extern unsigned long *trampoline_32bit;
 
-extern void trampoline_32bit_src(void *return_ptr);
+extern void trampoline_32bit_src(void *trampoline, bool enable_5lvl);
 
 #endif /* __ASSEMBLER__ */
 #endif /* BOOT_COMPRESSED_PAGETABLE_H */
-- 
2.39.2

