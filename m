Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FED7255A0
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 09:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbjFGH1I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 03:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbjFGH0f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 03:26:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EA2199A;
        Wed,  7 Jun 2023 00:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9647563550;
        Wed,  7 Jun 2023 07:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E06FC4339B;
        Wed,  7 Jun 2023 07:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686122666;
        bh=4Bh3UcI6mBb60v5tgLvoAeGffUld7BrhFCXiRmmP3sE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rzOazdygcvRuY93cXLsS8hgWuvB8GQgaTic9tG6nGelF4i5JdK64FZwgf+gJCb6i2
         8XSlimfFCarpG3ArfY028b4gxt+pWdpuCLoXPsoQnSZ08GRG8f0ec2tYwq5FIGGetV
         l7tBa6SyfWteIEtLzC9gFJvuAyE2/VtTJL7Y0B3xmw5G2NgFKiKFMHZL/o1wNcVf2w
         ADIS/mZuSOf4m0+CynpMHNNjt3+/9ZmK2LCKQlrNCtqr1s6YokuK15SUJVIWUSFcOS
         kB7uE2qrG3V57Yo7ILhK7ut4G650PmOXPuE5QIrT+J1zB1WMwDQD+kqGjn90po6pb7
         AjmubYQrfrgwQ==
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
Subject: [PATCH v5 07/20] x86/decompressor: Call trampoline as a normal function
Date:   Wed,  7 Jun 2023 09:23:29 +0200
Message-Id: <20230607072342.4054036-8-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607072342.4054036-1-ardb@kernel.org>
References: <20230607072342.4054036-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2554; i=ardb@kernel.org; h=from:subject; bh=4Bh3UcI6mBb60v5tgLvoAeGffUld7BrhFCXiRmmP3sE=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXBIOfyXcGvbvdk7s59zjTFLSjIQEnfS8e2IGX29+utW 1ncSkI6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETy+hn+xxVWFTTnnGldY9+m eUmtLzCG0anjqcuUBPPQ3c5LL3j4MPz3qrt0paj+qkaBsewU1mWqRUe32/abr9sTFn39wCNjvRW sAA==
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
 arch/x86/boot/compressed/head_64.S | 25 +++++++++-----------
 arch/x86/boot/compressed/pgtable.h |  2 +-
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 2d1b0ee94929f7ec..af45ddd8297a4a07 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -446,18 +446,9 @@ SYM_CODE_START(startup_64)
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
 
-	/*
-	 * Load the address of trampoline_return() into RDI.
-	 * It will be used by the trampoline to return to the main code.
-	 */
-	leaq	trampoline_return(%rip), %rdi
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
 
@@ -540,16 +531,22 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
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
-	/* Set up data and stack segments */
+	popq	%rdi
+	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
+	pushq	$__KERNEL32_CS
+	leaq	0f(%rip), %rax
+	pushq	%rax
+	lretq
+
+	.code32
+0:	/* Set up data and stack segments */
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
 	movl	%eax, %ss
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

