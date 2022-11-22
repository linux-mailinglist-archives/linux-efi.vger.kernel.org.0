Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB76340FC
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiKVQLJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiKVQLD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:11:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91272742CB;
        Tue, 22 Nov 2022 08:10:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 434A0B81C0D;
        Tue, 22 Nov 2022 16:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F17C433D7;
        Tue, 22 Nov 2022 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133444;
        bh=tZGzPcZmAcGsWu7+zFKgxe2N03AY23KDGmZFylxg1pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KasLeOcVIxriQma5aHt7FjrY54w9HG/jfjpYCQAnvLgcRI+e1Ba5vxJqGqJ0+qMAT
         tSapIi4LRGoSwU1eoFrGhJBoqkqVPqH2ubaNNGPKYm4BQ67oyEGdKeYpVqhkmBVClm
         vsFwlprf212IYPyfM77CFRXkmTgibgquvD7l996RnsWf8z0eupycBBMNWFDdsYteUy
         t7jwMqwJdbhELhmePiiuu5zPquyMLuGoiUOWhucjm2MjVEjQ7rQSsdKiHDDtImHd4d
         oaIZr7hclo/3o5effQ8pODCMLLFNcOJ9JTNGenE5MLkxDwUQVhXFncczZEAbwEKeY4
         7YxA0fHYlowwg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 05/17] x86/compressed: efi-mixed: move efi32_entry out of head_64.S
Date:   Tue, 22 Nov 2022 17:10:05 +0100
Message-Id: <20221122161017.2426828-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4945; i=ardb@kernel.org; h=from:subject; bh=tZGzPcZmAcGsWu7+zFKgxe2N03AY23KDGmZFylxg1pw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRVvLVcT2XQ/GHHG/VENjFiTSdl7lZ35vBnkfbI JTrxCIaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0VQAKCRDDTyI5ktmPJPcCC/ 98FrxNmvlO1mtu+HHPbrIllxlSyVNnVqrA4M+I2uawGhlAMQoGEaFsIo36jghE3ejgPhavycmvjI7e p3zHiALSK8T8ekTwwfGGaK4AcCFcUPjzr25D/ka0lJnMoq7Jtt1qPzft3n7bCo4yGedh5F3rluu8lg u8P8i/S++sq8Mnq3dzF8XHnXogE7V/e1a/P42Q8vKj3sb0DWmKzO3VnirAyTR+1Z+4kB5UEWR5THW+ XAc2uPg8FCLHxonSn7jtECB9mgl8RJdoT/mk77yUC7e9T9kb0TfqyqSjaI029B4hoRHeoQMlVxgPAh PiSXxGzCpPjOWqTFxyTw8Vmiyuh1LLo9A09BJdP3hppk2gHwSCIwkKFg98NupUVZb9hULE9/4fGjDL pDL6pYa+aIvsCbyKtsEnIh/npJNZM31cvLBMpelvgHGsa8GZt+3uzYovwV1tZ2sQXRP62XV6J59E29 32WaILJrHCIsNoeNcAM4XmJRIo84qo9cXxCY2PbUqDyTg=
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
 arch/x86/boot/compressed/efi_mixed.S | 57 ++++++++++++++++----
 arch/x86/boot/compressed/head_64.S   | 45 ----------------
 2 files changed, 47 insertions(+), 55 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 58ab2e1ffd92afbc..3487484ac1fd5c6c 100644
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
@@ -217,22 +217,59 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	lret
 SYM_FUNC_END(efi_enter32)
 
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
index 8192ab1c308567ce..8fa92ce5610e5329 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -297,48 +297,6 @@ SYM_FUNC_START(efi32_stub_entry)
 	popl	%esi
 	jmp	efi32_entry
 SYM_FUNC_END(efi32_stub_entry)
-
-	.text
-/*
- * This is the common EFI stub entry point for mixed mode.
- *
- * Arguments:	%ecx	image handle
- * 		%edx	EFI system table pointer
- *		%esi	struct bootparams pointer (or NULL when not using
- *			the EFI handover protocol)
- *
- * Since this is the point of no return for ordinary execution, no registers
- * are considered live except for the function parameters. [Note that the EFI
- * stub may still exit and return to the firmware using the Exit() EFI boot
- * service.]
- */
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
@@ -771,9 +729,6 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
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

