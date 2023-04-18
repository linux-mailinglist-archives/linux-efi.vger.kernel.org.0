Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3B76E665B
	for <lists+linux-efi@lfdr.de>; Tue, 18 Apr 2023 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjDRNuQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Apr 2023 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDRNuQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Apr 2023 09:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38BB5267
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 06:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AACB62898
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 13:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2E3C433EF;
        Tue, 18 Apr 2023 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681825813;
        bh=aBrDCdupW5WFY28jp8yQPFuc9JM8G51UC2UuSAiY7pE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvBA32gXo/7WTYJSyH1RXIyiUteYju8GcKmVDjNilL45jIAyWwR+MU6yPbbSekR+i
         bQKE87itTB9UTeDHvxgWgMDnIzqXeW4pALBBA5Jv8OKsP+FuHiGeFxGycbcmVORepW
         FwcutNWjwyV4TJtgJDAohqfJEhqVn65iNzGle+w2xs98CVap8akVAJg3QPJQnv4ZPL
         c4Xh5IRwPqoh8aH26ZOXARQL/9zsimc7nDwd5Q3wX1j8dTP1cg3ml2HdWekDun75Fp
         7o9/3dI1/4qWGacgmT/kMzMqj1+lQsE9WGeeBmMeXobKjZI5+KfQicSBRgWHV+aOzu
         8vOiVlThwiqXQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        broonie@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 5/6] efi/zboot: Set forward edge CFI compat header flag if supported
Date:   Tue, 18 Apr 2023 15:49:51 +0200
Message-Id: <20230418134952.1170141-6-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418134952.1170141-1-ardb@kernel.org>
References: <20230418134952.1170141-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4676; i=ardb@kernel.org; h=from:subject; bh=aBrDCdupW5WFY28jp8yQPFuc9JM8G51UC2UuSAiY7pE=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcVu/j+xzsOeUy/U7FJME33skPQ51M/1bcn07WJme6b4L mldMnd3RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIkxEjw5H5Pk8/HI1u/T39 AE9Bzfzuwk2SPZ+ufF6Tviv/72fRrbwMf+Wn9ybL/b7GzMe7d02p6LU9kzdP4d8iP6nPRD7vRKD 9bAYA
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

Add some plumbing to the zboot EFI header generation to set the newly
introduced DllCharacteristicsEx flag associated with forward edge CFI
enforcement instructions (BTI on arm64, IBT on x86)

x86 does not currently uses the zboot infrastructure, so let's wire it
up only for arm64.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/boot/Makefile                    |  1 +
 drivers/firmware/efi/libstub/Makefile.zboot |  9 +++-
 drivers/firmware/efi/libstub/zboot-header.S | 49 +++++++++++++-------
 3 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index 5d73229604b11061..affbcb0df9db81e5 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -42,6 +42,7 @@ $(obj)/Image.zst: $(obj)/Image FORCE
 EFI_ZBOOT_PAYLOAD	:= Image.zboot
 EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
 EFI_ZBOOT_MACH_TYPE	:= ARM64
+EFI_ZBOOT_FORWARD_CFI	:= $(CONFIG_ARM64_BTI_KERNEL)
 
 #
 # The EFI zboot logic needs to know the size of the executable region in the
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 2d78770236049b21..0a9dcc2b13736519 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 # to be include'd by arch/$(ARCH)/boot/Makefile after setting
-# EFI_ZBOOT_PAYLOAD, EFI_ZBOOT_BFD_TARGET and EFI_ZBOOT_MACH_TYPE
+# EFI_ZBOOT_PAYLOAD, EFI_ZBOOT_BFD_TARGET, EFI_ZBOOT_MACH_TYPE and
+# EFI_ZBOOT_FORWARD_CFI
 
 quiet_cmd_copy_and_pad = PAD     $@
       cmd_copy_and_pad = cp $< $@ && \
@@ -44,10 +45,14 @@ OBJCOPYFLAGS_vmlinuz.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) \
 $(obj)/vmlinuz.o: $(obj)/vmlinuz FORCE
 	$(call if_changed,objcopy)
 
+aflags-zboot-header-$(EFI_ZBOOT_FORWARD_CFI) := \
+		-DPE_DLL_CHAR_EX=IMAGE_DLLCHARACTERISTICS_EX_FORWARD_CFI_COMPAT
+
 AFLAGS_zboot-header.o += -DMACHINE_TYPE=IMAGE_FILE_MACHINE_$(EFI_ZBOOT_MACH_TYPE) \
 			 -DZBOOT_EFI_PATH="\"$(realpath $(obj)/vmlinuz.efi.elf)\"" \
 			 -DZBOOT_SIZE_LEN=$(zboot-size-len-y) \
-			 -DCOMP_TYPE="\"$(comp-type-y)\""
+			 -DCOMP_TYPE="\"$(comp-type-y)\"" \
+			 $(aflags-zboot-header-y)
 
 $(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/libstub/zboot-header.S FORCE
 	$(call if_changed_rule,as_o_S)
diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
index 053aba073594936b..fb676ded47fa4341 100644
--- a/drivers/firmware/efi/libstub/zboot-header.S
+++ b/drivers/firmware/efi/libstub/zboot-header.S
@@ -78,9 +78,36 @@ __efistub_efi_zboot_header:
 	.quad		0				// ExceptionTable
 	.quad		0				// CertificationTable
 	.quad		0				// BaseRelocationTable
-#ifdef CONFIG_DEBUG_EFI
+#if defined(PE_DLL_CHAR_EX) || defined(CONFIG_DEBUG_EFI)
 	.long		.Lefi_debug_table - .Ldoshdr	// DebugTable
 	.long		.Lefi_debug_table_size
+
+	.section	".rodata", "a"
+	.p2align	2
+.Lefi_debug_table:
+	// EFI_IMAGE_DEBUG_DIRECTORY_ENTRY[]
+#ifdef PE_DLL_CHAR_EX
+	.long		0					// Characteristics
+	.long		0					// TimeDateStamp
+	.short		0					// MajorVersion
+	.short		0					// MinorVersion
+	.long		IMAGE_DEBUG_TYPE_EX_DLLCHARACTERISTICS	// Type
+	.long		4					// SizeOfData
+	.long		0					// RVA
+	.long		.Lefi_dll_characteristics_ex - .Ldoshdr	// FileOffset
+#endif
+#ifdef CONFIG_DEBUG_EFI
+	.long		0					// Characteristics
+	.long		0					// TimeDateStamp
+	.short		0					// MajorVersion
+	.short		0					// MinorVersion
+	.long		IMAGE_DEBUG_TYPE_CODEVIEW		// Type
+	.long		.Lefi_debug_entry_size			// SizeOfData
+	.long		0					// RVA
+	.long		.Lefi_debug_entry - .Ldoshdr		// FileOffset
+#endif
+	.set		.Lefi_debug_table_size, . - .Lefi_debug_table
+	.previous
 #endif
 
 .Lsection_table:
@@ -110,23 +137,11 @@ __efistub_efi_zboot_header:
 
 	.set		.Lsection_count, (. - .Lsection_table) / 40
 
+#ifdef PE_DLL_CHAR_EX
+.Lefi_dll_characteristics_ex:
+	.long		PE_DLL_CHAR_EX
+#endif
 #ifdef CONFIG_DEBUG_EFI
-	.section	".rodata", "a"
-	.align		2
-.Lefi_debug_table:
-	// EFI_IMAGE_DEBUG_DIRECTORY_ENTRY
-	.long		0				// Characteristics
-	.long		0				// TimeDateStamp
-	.short		0				// MajorVersion
-	.short		0				// MinorVersion
-	.long		IMAGE_DEBUG_TYPE_CODEVIEW	// Type
-	.long		.Lefi_debug_entry_size		// SizeOfData
-	.long		0				// RVA
-	.long		.Lefi_debug_entry - .Ldoshdr	// FileOffset
-
-	.set		.Lefi_debug_table_size, . - .Lefi_debug_table
-	.previous
-
 .Lefi_debug_entry:
 	// EFI_IMAGE_DEBUG_CODEVIEW_NB10_ENTRY
 	.ascii		"NB10"				// Signature
-- 
2.39.2

