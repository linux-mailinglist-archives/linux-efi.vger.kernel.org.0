Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49E46D6717
	for <lists+linux-efi@lfdr.de>; Tue,  4 Apr 2023 17:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjDDPUU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Apr 2023 11:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbjDDPUT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Apr 2023 11:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B1D46B6
        for <linux-efi@vger.kernel.org>; Tue,  4 Apr 2023 08:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EC61635AD
        for <linux-efi@vger.kernel.org>; Tue,  4 Apr 2023 15:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C9CC433A1;
        Tue,  4 Apr 2023 15:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680621616;
        bh=KEpiu1LcP6rVmgIdzG1zgBZc7tX1RDFS8L/IT9RtaMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xxmr4l6OYLunrzZ3S37PnCmrHd+VuWn+1PmbhumzsoAXfTINYhdvyQYZl38XqIaNR
         dLKN7ha+Am/gKipxF9hmUO6iOZKHF3Zuc0jp6h5W396k0gK6OQePb7QBsimdm23qWZ
         22GgPz7x3dOGZr+XVT9Cb/7OMJCyOD4WDMujP2p3tRJR8AvtKraMU/yO4g6RxqAk8n
         X/lF07aMzF/DSvlAXltpTnE2XDo1Qcs+/r3AOjGcNPIlJhn8ehmvC75FNBfhUzGTC4
         svOeYExdWeqUXQe9ALuZ6PLZ3iBcIBFe6LcKKHPygBtDoMZUvfsqufdmgGiKRoZWTc
         SMdln7MOJVE4g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, broonie@Kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 5/6] efi/zboot: Set forward edge CFI compat header flag if supported
Date:   Tue,  4 Apr 2023 17:19:58 +0200
Message-Id: <20230404151959.2774612-6-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404151959.2774612-1-ardb@kernel.org>
References: <20230404151959.2774612-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4652; i=ardb@kernel.org; h=from:subject; bh=KEpiu1LcP6rVmgIdzG1zgBZc7tX1RDFS8L/IT9RtaMU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUXHQfbdzPInZjNOvn/CscysNcNpq0zQ05O7pvAZ82bdv z5ty8r1HaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiL88x/DPcK6T/qWd5Pct6 CZvz39Y0rworXTqnPub25jfcEtVbt0QyMiz5l7g6K1Op78Zz1edK36ZWz3Hfc+Sj05mylb0PPNc Im3AAAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
index c65aee0884103c6f..ae645fda90bca574 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -42,5 +42,6 @@ $(obj)/Image.zst: $(obj)/Image FORCE
 EFI_ZBOOT_PAYLOAD	:= Image
 EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
 EFI_ZBOOT_MACH_TYPE	:= ARM64
+EFI_ZBOOT_FORWARD_CFI	:= $(CONFIG_ARM64_BTI_KERNEL)
 
 include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
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

