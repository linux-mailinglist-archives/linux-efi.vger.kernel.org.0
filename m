Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7FD5C005F
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiIUOyw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIUOyn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:54:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381422AFC;
        Wed, 21 Sep 2022 07:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C69F3630CF;
        Wed, 21 Sep 2022 14:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63092C433B5;
        Wed, 21 Sep 2022 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772080;
        bh=hjePMKZyCOenQTSHV4pGP5IYB9bZ4b3la+cxQPIBsrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eOGQpxsG98m6Fox2F5dU2wuSzf0M6XmV8Ilp83LqMUqc9w2xhZMr5nojVmeWH47ea
         XJzRdKCfW+MYXDzQPjPIXnXz8aNprXJhaW2VvzC6dPNmQ/wTfpoj4C7guudElhgfUA
         I0JCUIHPtLF3OAneuP4KxLdhLAAZ9JC6jaETXIWj9XMXwJ8+zgg78q8Ui5arFrh22x
         t7bnu7XmktKlhaVFY2l/FdX6VoT7VpR1a9gp/f6H7LkeuJ3XUHhjU3q5CTFqcBNCZX
         u4VaOu1nepHFRLEknOOgPgotPMESUvtQly/bAXdeSaXlRj1b+eW29c9zM1Dv3KBZr1
         t/HX77vUxcVhA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 05/16] x86/compressed: efi-mixed: move efi32_entry out of head_64.S
Date:   Wed, 21 Sep 2022 16:54:11 +0200
Message-Id: <20220921145422.437618-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3927; i=ardb@kernel.org; h=from:subject; bh=hjePMKZyCOenQTSHV4pGP5IYB9bZ4b3la+cxQPIBsrY=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWLVXF3ze3IV/DZKGamQFIJQTrLYmFVZTd1mPTv UeKZFKyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYysliwAKCRDDTyI5ktmPJKjNC/ 9QxC+Hyf23IsALZspJ4N4tYNyyXNS/9AJ9F84+vyLnuSO4wk7quDdWvjKBH4rfsgTnQhci8jd5PY/L oXK7dVE4Hy60kRq0PzMjR84XkIuXFb3BKIr7o7a3CZcQXBI1PCfgpX57sfdgCMovbqDgM6X28FrOSt LZ1ZZOp719f3ZE5XfxG8xDH3XGeYz2WKSPODWihkCkp3jr5elPIhNapebM60x6zZEqKD6TmDxvsJ0g BOY5L4xvT4xKTV5+pFbylST3+QAMoXWruIrrYC2pAUmVZ7Co821SupIANUX8yh090aRZ9qTa4LCxv8 dlD6AUjg9ysEgBrVWAx2sGa6mwUs7uuDfFeJACB7vFlBrWRC0+fyPj1/ITX5/Q9obt5wg+BPq/e+bg s4zR68NBvQkdscFT3uu++fAzB5Sn46EWKo8q1p56R4QEs0jEligSU+hrD8+HwajnaSIJN7XsD8WTTO KXQTTOo3eieCtdRK5kbbUQTHjyX/Fk+mILFBfPZMxy1X4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move the efi32_entry() routine out of head_64.S and into efi-mixed.S,
which reduces clutter in the complicated startup routines. It also
permits linkage of some symbols used by code to be made local.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 44 +++++++++++++++-----
 arch/x86/boot/compressed/head_64.S   | 32 --------------
 2 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 77e77c3ea393..5007a44cd966 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -105,7 +105,7 @@ SYM_FUNC_START(__efi64_thunk)
 	/*
 	 * Switch to IDT and GDT with 32-bit segments. This is the firmware GDT
 	 * and IDT that was installed when the kernel started executing. The
-	 * pointers were saved at the EFI stub entry point in head_64.S.
+	 * pointers were saved by the efi32_entry() routine below.
 	 *
 	 * Pass the saved DS selector to the 32-bit code, and use far return to
 	 * restore the saved CS selector.
@@ -217,22 +217,46 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	lret
 SYM_FUNC_END(efi_enter32)
 
+SYM_FUNC_START(efi32_entry)
+	call	1f
+1:	pop	%ebx
+
+	/* Save firmware GDTR and code/data selectors */
+	sgdtl	(efi32_boot_gdt - 1b)(%ebx)
+	movw	%cs, (efi32_boot_cs - 1b)(%ebx)
+	movw	%ds, (efi32_boot_ds - 1b)(%ebx)
+
+	/* Store firmware IDT descriptor */
+	sidtl	(efi32_boot_idt - 1b)(%ebx)
+
+	/* Store boot arguments */
+	leal	(efi32_boot_args - 1b)(%ebx), %ebx
+	movl	%ecx, 0(%ebx)
+	movl	%edx, 4(%ebx)
+	movl	%esi, 8(%ebx)
+	movb	$0x0, 12(%ebx)          // efi_is64
+
+	/* Disable paging */
+	movl	%cr0, %eax
+	btrl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
+	jmp	startup_32
+SYM_FUNC_END(efi32_entry)
+
 	.data
 	.balign	8
-SYM_DATA_START(efi32_boot_gdt)
+SYM_DATA_START_LOCAL(efi32_boot_gdt)
 	.word	0
 	.quad	0
 SYM_DATA_END(efi32_boot_gdt)
 
-SYM_DATA_START(efi32_boot_idt)
+SYM_DATA_START_LOCAL(efi32_boot_idt)
 	.word	0
 	.quad	0
 SYM_DATA_END(efi32_boot_idt)
 
-SYM_DATA_START(efi32_boot_cs)
-	.word	0
-SYM_DATA_END(efi32_boot_cs)
-
-SYM_DATA_START(efi32_boot_ds)
-	.word	0
-SYM_DATA_END(efi32_boot_ds)
+SYM_DATA_LOCAL(efi32_boot_cs, .word 0)
+SYM_DATA_LOCAL(efi32_boot_ds, .word 0)
+SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
+SYM_DATA(efi_is64, .byte 1)
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 9ae6ddccd3ef..be95d5685717 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -289,35 +289,6 @@ SYM_FUNC_START(efi32_stub_entry)
 	popl	%esi
 	jmp	efi32_entry
 SYM_FUNC_END(efi32_stub_entry)
-
-	.text
-SYM_FUNC_START_LOCAL(efi32_entry)
-	call	1f
-1:	pop	%ebx
-
-	/* Save firmware GDTR and code/data selectors */
-	sgdtl	(efi32_boot_gdt - 1b)(%ebx)
-	movw	%cs, (efi32_boot_cs - 1b)(%ebx)
-	movw	%ds, (efi32_boot_ds - 1b)(%ebx)
-
-	/* Store firmware IDT descriptor */
-	sidtl	(efi32_boot_idt - 1b)(%ebx)
-
-	/* Store boot arguments */
-	leal	(efi32_boot_args - 1b)(%ebx), %ebx
-	movl	%ecx, 0(%ebx)
-	movl	%edx, 4(%ebx)
-	movl	%esi, 8(%ebx)
-	movb	$0x0, 12(%ebx)          // efi_is64
-
-	/* Disable paging */
-	movl	%cr0, %eax
-	btrl	$X86_CR0_PG_BIT, %eax
-	movl	%eax, %cr0
-
-	jmp	startup_32
-SYM_FUNC_END(efi32_entry)
-	__HEAD
 #endif
 
 	.code64
@@ -750,9 +721,6 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
 SYM_DATA(image_offset, .long 0)
 #endif
 #ifdef CONFIG_EFI_MIXED
-SYM_DATA(efi32_boot_args, .long 0, 0, 0)
-SYM_DATA(efi_is64, .byte 1)
-
 #define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
 #define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
 #define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
-- 
2.35.1

