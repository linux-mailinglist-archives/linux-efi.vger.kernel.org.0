Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE76D6714
	for <lists+linux-efi@lfdr.de>; Tue,  4 Apr 2023 17:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbjDDPUO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Apr 2023 11:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjDDPUM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Apr 2023 11:20:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5B344B2
        for <linux-efi@vger.kernel.org>; Tue,  4 Apr 2023 08:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E17F634FC
        for <linux-efi@vger.kernel.org>; Tue,  4 Apr 2023 15:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236C5C433A0;
        Tue,  4 Apr 2023 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680621610;
        bh=Ga8kRwA4cYPGJueBNhAKY9K+0CddQq8XhgGyaJTDtY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpVEE7lAJt9ndt27k37zxCybUY+1K6Hrpo+utt6qw/EDihTFzRkh901NOOBZ0cBu6
         U6kkHyK+zG4ggTAnedmm7BNARQ0tlXywKwi4I5cgLNohLF9seuMcGXN7Pu9MyKO+Tn
         lDRSaTJCclkMDC1pYVlfDp3jZ3J1Vg7vUzx9aTWPiSY0ByLIllVd/ZCGSWrFYQfJCR
         fH7/+RY9L/dYT4T01cDj3e9aLvf844scK9W1igRwJ5Dok+8O6+lM8OAAvgUabMk3y5
         1gA0C7n1lMIZ0/nUNUmfnsFpLLk+/YN2DB+FpqWjh7Cy5Wx80lr/Bob0mof83fmQE8
         +G0aDVyQEKHJw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, broonie@Kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/6] arm64: efi: Enable BTI codegen and add PE/COFF annotation
Date:   Tue,  4 Apr 2023 17:19:55 +0200
Message-Id: <20230404151959.2774612-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404151959.2774612-1-ardb@kernel.org>
References: <20230404151959.2774612-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4840; i=ardb@kernel.org; h=from:subject; bh=Ga8kRwA4cYPGJueBNhAKY9K+0CddQq8XhgGyaJTDtY4=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUXHQfLYasdkze6AN91rV+VkfDv11nazUfPUr3MuZSWpZ FVO5/3RUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZy+xvDf8f4G9H7Zh2S+i5d tXHezKkPDl6ZO+OCaZjchQc3ruvcfa/J8N+Hd5Hl8olH+oR9bTxXWl2fu/Leww0OAdzCJstcg+v +CbABAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI heavily relies on so-called protocols, which are essentially
tables populated with pointers to executable code, and these are invoked
indirectly using BR or BLR instructions.

This makes the EFI execution context vulnerable to attacks on forward
edge control flow, and so it would help if we could enable hardware
enforcement (BTI) on CPUs that implement it.

So let's no longer disable BTI codegen for the EFI stub, and set the
newly introduced PE/COFF header flag when the kernel is built with BTI
landing pads.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi-header.S        | 71 ++++++++++++--------
 drivers/firmware/efi/libstub/Makefile |  3 +-
 2 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
index d731b4655df8eb27..11d7f7de202d0ed2 100644
--- a/arch/arm64/kernel/efi-header.S
+++ b/arch/arm64/kernel/efi-header.S
@@ -81,9 +81,47 @@
 	.quad	0					// CertificationTable
 	.quad	0					// BaseRelocationTable
 
-#ifdef CONFIG_DEBUG_EFI
+#if defined(CONFIG_DEBUG_EFI) || defined(CONFIG_ARM64_BTI_KERNEL)
 	.long	.Lefi_debug_table - .L_head		// DebugTable
 	.long	.Lefi_debug_table_size
+
+	/*
+	 * The debug table is referenced via its Relative Virtual Address (RVA),
+	 * which is only defined for those parts of the image that are covered
+	 * by a section declaration. Since this header is not covered by any
+	 * section, the debug table must be emitted elsewhere. So stick it in
+	 * the .init.rodata section instead.
+	 *
+	 * Note that the payloads themselves are permitted to have zero RVAs,
+	 * which means we can simply put those right after the section headers.
+	 */
+	__INITRODATA
+
+	.align	2
+.Lefi_debug_table:
+#ifdef CONFIG_DEBUG_EFI
+	// EFI_IMAGE_DEBUG_DIRECTORY_ENTRY
+	.long	0					// Characteristics
+	.long	0					// TimeDateStamp
+	.short	0					// MajorVersion
+	.short	0					// MinorVersion
+	.long	IMAGE_DEBUG_TYPE_CODEVIEW		// Type
+	.long	.Lefi_debug_entry_size			// SizeOfData
+	.long	0					// RVA
+	.long	.Lefi_debug_entry - .L_head		// FileOffset
+#endif
+#ifdef CONFIG_ARM64_BTI_KERNEL
+	.long	0					// Characteristics
+	.long	0					// TimeDateStamp
+	.short	0					// MajorVersion
+	.short	0					// MinorVersion
+	.long	IMAGE_DEBUG_TYPE_EX_DLLCHARACTERISTICS	// Type
+	.long	4					// SizeOfData
+	.long	0					// RVA
+	.long	.Lefi_dll_characteristics_ex - .L_head	// FileOffset
+#endif
+	.set	.Lefi_debug_table_size, . - .Lefi_debug_table
+	.previous
 #endif
 
 	// Section table
@@ -119,33 +157,6 @@
 	.set	.Lsection_count, (. - .Lsection_table) / 40
 
 #ifdef CONFIG_DEBUG_EFI
-	/*
-	 * The debug table is referenced via its Relative Virtual Address (RVA),
-	 * which is only defined for those parts of the image that are covered
-	 * by a section declaration. Since this header is not covered by any
-	 * section, the debug table must be emitted elsewhere. So stick it in
-	 * the .init.rodata section instead.
-	 *
-	 * Note that the EFI debug entry itself may legally have a zero RVA,
-	 * which means we can simply put it right after the section headers.
-	 */
-	__INITRODATA
-
-	.align	2
-.Lefi_debug_table:
-	// EFI_IMAGE_DEBUG_DIRECTORY_ENTRY
-	.long	0					// Characteristics
-	.long	0					// TimeDateStamp
-	.short	0					// MajorVersion
-	.short	0					// MinorVersion
-	.long	IMAGE_DEBUG_TYPE_CODEVIEW		// Type
-	.long	.Lefi_debug_entry_size			// SizeOfData
-	.long	0					// RVA
-	.long	.Lefi_debug_entry - .L_head		// FileOffset
-
-	.set	.Lefi_debug_table_size, . - .Lefi_debug_table
-	.previous
-
 .Lefi_debug_entry:
 	// EFI_IMAGE_DEBUG_CODEVIEW_NB10_ENTRY
 	.ascii	"NB10"					// Signature
@@ -157,6 +168,10 @@
 
 	.set	.Lefi_debug_entry_size, . - .Lefi_debug_entry
 #endif
+#ifdef CONFIG_ARM64_BTI_KERNEL
+.Lefi_dll_characteristics_ex:
+	.long	IMAGE_DLLCHARACTERISTICS_EX_FORWARD_CFI_COMPAT
+#endif
 
 	.balign	SEGMENT_ALIGN
 .Lefi_header_end:
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 80d85a5169fb2c72..3abb2b357482a416 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -23,8 +23,7 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
 cflags-$(CONFIG_ARM64)		+= -fpie $(DISABLE_STACKLEAK_PLUGIN) \
-				   -fno-unwind-tables -fno-asynchronous-unwind-tables \
-				   $(call cc-option,-mbranch-protection=none)
+				   -fno-unwind-tables -fno-asynchronous-unwind-tables
 cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
 				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
 				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
-- 
2.39.2

