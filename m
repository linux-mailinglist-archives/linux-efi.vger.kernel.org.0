Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC095766894
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jul 2023 11:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjG1JOt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jul 2023 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbjG1JMp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jul 2023 05:12:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20BB3590;
        Fri, 28 Jul 2023 02:11:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F30462062;
        Fri, 28 Jul 2023 09:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03377C433CB;
        Fri, 28 Jul 2023 09:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535480;
        bh=Fowt+T1f7j1SkaFRI5qxgj5A61yqdrfzCYAzIxm5GW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQZgrPErweMj88AIwSA9ggneHAOluYdPbt2FEV3fwM/BZFx7fmLOsLNyYXHnt5hFt
         GIZ+kRbuQPHDktMxf4kvhHfeSWcbufsRE66+3hd4nu8Locsw47ZyP8ZdIsrJw5Od5M
         lkB+EBfw7Si5DZ6WQBAgCzu8dCfOFb7+dZUfWZM1SRb6fIdrPEZQvX9Neil0vQuoln
         e+WOp9FbbLuiHqb5IhiEzB1EIE2NIP2wpdT95hdEhcDxK0voNE2xbyt+2vMiXCpUr6
         2ftWMPCVctQR9OP4dAQLZ1EO8TOS/ZqQySzFdcrg7YrRyK9uetmgk56Ora/DiA9heO
         /O31fONVSZJKQ==
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
Subject: [PATCH v7 09/22] x86/decompressor: Call trampoline as a normal function
Date:   Fri, 28 Jul 2023 11:09:03 +0200
Message-Id: <20230728090916.1538550-10-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728090916.1538550-1-ardb@kernel.org>
References: <20230728090916.1538550-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3066; i=ardb@kernel.org; h=from:subject; bh=Fowt+T1f7j1SkaFRI5qxgj5A61yqdrfzCYAzIxm5GW0=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVw6xqWuhpLK93PC16fXdvjdC9siviqHXovfWyZL6/Ib F2xKE+mo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExkSS7DP3OZV0H1bfPVQ/Q8 Hn25zHzm/CV15SeXmmPftk3anWD92JWRYYWGSkW4sbJT8lEr3WfnT7yw12Gp2LWsbV+/neFZ1+g djAA=
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

Move the long return to switch to 32-bit mode into the trampoline code
so it can be called as an ordinary function. This will allow it to be
called directly from C code in a subsequent patch.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 46 ++++++++++----------
 arch/x86/boot/compressed/pgtable.h |  2 +-
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 2ccddec2220ce914..1892679be2b6897a 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -446,29 +446,9 @@ SYM_CODE_START(startup_64)
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
 
-	/* Set up 32-bit addressable stack */
-	leaq	TRAMPOLINE_32BIT_STACK_END(%rcx), %rsp
-
-	/*
-	 * Load the address of trampoline_return() into RDI and push it onto
-	 * the stack so it will survive 32-bit truncation due to the 32-bit
-	 * protected mode switch. It will be used by the trampoline to return
-	 * to the main code.
-	 */
-	leaq	trampoline_return(%rip), %rdi
-	pushq	%rdi
-
-	/* Preserve other live 64-bit registers */
-	pushq	%r15
-	pushq	%rbp
-	pushq	%rbx
-
-	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
-	pushq	$__KERNEL32_CS
 	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
-	pushq	%rax
-	lretq
-trampoline_return:
+	call	*%rax
+
 	/* Restore the stack, the 32-bit trampoline uses its own stack */
 	leaq	rva(boot_stack_end)(%rbx), %rsp
 
@@ -551,15 +531,33 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	jmp	*%rax
 SYM_FUNC_END(.Lrelocated)
 
-	.code32
 /*
  * This is the 32-bit trampoline that will be copied over to low memory.
  *
- * RDI contains the return address (might be above 4G).
  * ECX contains the base address of the trampoline memory.
  * Non zero RDX means trampoline needs to enable 5-level paging.
  */
 SYM_CODE_START(trampoline_32bit_src)
+	/* Grab return address */
+	movq	(%rsp), %rax
+
+	/* Set up 32-bit addressable stack */
+	leaq	TRAMPOLINE_32BIT_STACK_END(%rcx), %rsp
+
+	/* Preserve return address and other live 64-bit registers */
+	pushq	%rax
+	pushq	%r15
+	pushq	%rbp
+	pushq	%rbx
+
+	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
+	pushq	$__KERNEL32_CS
+	leaq	0f(%rip), %rax
+	pushq	%rax
+	lretq
+
+	.code32
+0:
 	/* Set up data and stack segments */
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index cc9b2529a08634b4..91dbb99203fbce2d 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -6,7 +6,7 @@
 #define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
 
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
-#define TRAMPOLINE_32BIT_CODE_SIZE	0x80
+#define TRAMPOLINE_32BIT_CODE_SIZE	0xA0
 
 #define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
 
-- 
2.39.2

