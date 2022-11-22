Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5383B6340F6
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiKVQKp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbiKVQKi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:10:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9187342F;
        Tue, 22 Nov 2022 08:10:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE05A61790;
        Tue, 22 Nov 2022 16:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85371C433D6;
        Tue, 22 Nov 2022 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133437;
        bh=sEJvhCQxeDCcI3Wh1P1C49BRYqX5Djj4f/natWFpYe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SV9XRYW0O18IJlBXy7lIv08oVHUL/FtEJw7NFQjMF3iG86/d7BS2ekDBpJ+k461Pl
         Z6o9EhvO18shfI/TB2tD4Dif54y1lhgvHYk5Jz9rD1+iLjeeeMbfjFcwuc/FPoDb5V
         hrUPaXGgjgz0gkw0+ru5Ft70d/tfDSZIjr3R7EEpjmaSqoxCtsIPL/YBBVLilc7Wp+
         WFv7bQ4LD6fXuuIew6uuWW8qF/waWXTCVJ59T4M8CuKrmj2Sk+Fu/4qLb1pWtkGgsg
         +0lfBmRdrDwd/88Klps0p0EwyVsn0HR/EkAtgtAeWMAq8pZX/ec/MsAQbKuqSdhzc/
         Nw9HPxP5FBNTw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 02/17] x86/compressed: efi-mixed: move 32-bit entrypoint code into .text section
Date:   Tue, 22 Nov 2022 17:10:02 +0100
Message-Id: <20221122161017.2426828-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725; i=ardb@kernel.org; h=from:subject; bh=sEJvhCQxeDCcI3Wh1P1C49BRYqX5Djj4f/natWFpYe8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRQtQpikiqIcg3GsEynnGIf0E0BXR9vhKHMTNMA ubl/JByJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0UAAKCRDDTyI5ktmPJN81C/ wKlnKRZktDzn6/J/fnPFJYeZqn0QJ5lycWp1uJOecLHgijPegOrMDDmrn8Hp5ZjbUdEY/dImsbyQoT XVAhWCeJux0/0dQRDQ8QisYP2IjPdkMYPtWExtqKNdxmyES89JK4P+HZIhjipRPNCmx/2NMNbNqmlE 5pWqJAU7f0GjzHe8ZCU5C+rplYk5TekvTuYIZihEGsYtEAVkFvhotbHli6ijd12v9/kWqiPL3jOpNc E+KqvOQ6FiFH4VG7E0SpY3kzqdVY//zNtXCR2X5tDbXmYNKLWAYunuHX9/CsUy1rnhPKTwh6Hnv3BU mR4+4otxW7ny2isBdou/WGdplFFx+Yigs8XBfzJo5NNzWdq1RfxIIlPeKmGsfCe+HDrdjxsb0MpnC2 A4pxKHr7KNvXrUtrVkGMfMNSaNJdPacDo4lY2sLYwqqzBua2VAV5CJ8TJvUIvv6ahtE9QPMrGv+MO8 32cS/k7Er70o+lPIMaxl3UTJTvbEd7ZA1Kr+trNWdnkmI=
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

Move the code that stores the arguments passed to the EFI entrypoint
into the .text section, so that it can be moved into a separate
compilation unit in a subsequent patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 48 ++++++++++++++------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 190b803eb78712e0..74aaffd22b7425f4 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -311,24 +311,41 @@ SYM_FUNC_START(efi32_stub_entry)
 	popl	%ecx
 	popl	%edx
 	popl	%esi
+	jmp	efi32_entry
+SYM_FUNC_END(efi32_stub_entry)
 
+	.text
+/*
+ * This is the common EFI stub entry point for mixed mode.
+ *
+ * Arguments:	%ecx	image handle
+ * 		%edx	EFI system table pointer
+ *		%esi	struct bootparams pointer (or NULL when not using
+ *			the EFI handover protocol)
+ *
+ * Since this is the point of no return for ordinary execution, no registers
+ * are considered live except for the function parameters. [Note that the EFI
+ * stub may still exit and return to the firmware using the Exit() EFI boot
+ * service.]
+ */
+SYM_FUNC_START_LOCAL(efi32_entry)
 	call	1f
-1:	pop	%ebp
-	subl	$ rva(1b), %ebp
-
-	movl	%esi, rva(efi32_boot_args+8)(%ebp)
-SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
-	movl	%ecx, rva(efi32_boot_args)(%ebp)
-	movl	%edx, rva(efi32_boot_args+4)(%ebp)
-	movb	$0, rva(efi_is64)(%ebp)
+1:	pop	%ebx
 
 	/* Save firmware GDTR and code/data selectors */
-	sgdtl	rva(efi32_boot_gdt)(%ebp)
-	movw	%cs, rva(efi32_boot_cs)(%ebp)
-	movw	%ds, rva(efi32_boot_ds)(%ebp)
+	sgdtl	(efi32_boot_gdt - 1b)(%ebx)
+	movw	%cs, (efi32_boot_cs - 1b)(%ebx)
+	movw	%ds, (efi32_boot_ds - 1b)(%ebx)
 
 	/* Store firmware IDT descriptor */
-	sidtl	rva(efi32_boot_idt)(%ebp)
+	sidtl	(efi32_boot_idt - 1b)(%ebx)
+
+	/* Store boot arguments */
+	leal	(efi32_boot_args - 1b)(%ebx), %ebx
+	movl	%ecx, 0(%ebx)
+	movl	%edx, 4(%ebx)
+	movl	%esi, 8(%ebx)
+	movb	$0x0, 12(%ebx)          // efi_is64
 
 	/* Disable paging */
 	movl	%cr0, %eax
@@ -336,7 +353,8 @@ SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
 	movl	%eax, %cr0
 
 	jmp	startup_32
-SYM_FUNC_END(efi32_stub_entry)
+SYM_FUNC_END(efi32_entry)
+	__HEAD
 #endif
 
 	.code64
@@ -839,7 +857,9 @@ SYM_FUNC_START(efi32_pe_entry)
 	 */
 	subl	%esi, %ebx
 	movl	%ebx, rva(image_offset)(%ebp)	// save image_offset
-	jmp	efi32_pe_stub_entry
+	xorl	%esi, %esi
+	jmp	efi32_entry			// pass %ecx, %edx, %esi
+						// no other registers remain live
 
 2:	popl	%edi				// restore callee-save registers
 	popl	%ebx
-- 
2.35.1

