Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0466E665C
	for <lists+linux-efi@lfdr.de>; Tue, 18 Apr 2023 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjDRNuT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Apr 2023 09:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjDRNuS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Apr 2023 09:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D761A10DE
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 06:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5607462898
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 13:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4950DC4339C;
        Tue, 18 Apr 2023 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681825815;
        bh=WKSi12TPj0ccbN/qjUB9rtwsQfvcIxbjSFCwov90qm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wxy/Pwfp8p5jz5RS51hOfgacYKLpcPDrojAkm92N7X39c9avpdxqILspCbjctHYG5
         jSVZSM94thYDke83nHe3XphoZUdzuMkhPxeBiV4q849EfhKmjpnUpva+Tw+3w1hQcJ
         I+FpVyusd3EuebW5oqsnogbzQz875Ctxf0nxLP8m+RmJgsQRT5SFfa3uQ7BXPf2P/E
         TCXz50cirIRVVESUIdmp+nPSGSMLcg1Se8IKlANXvPtDWPjqcGV04XQBWD/CXcjFH+
         TAFaZG55oKK2SdEMTtLYykGvxPGTvdG58x+zmMgHmIr1CLoezONDf9rT3+e7S+9mr7
         RQN7M5x77XujQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        broonie@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 6/6] efi/zboot: arm64: Grab code size from image header
Date:   Tue, 18 Apr 2023 15:49:52 +0200
Message-Id: <20230418134952.1170141-7-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418134952.1170141-1-ardb@kernel.org>
References: <20230418134952.1170141-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6520; i=ardb@kernel.org; h=from:subject; bh=WKSi12TPj0ccbN/qjUB9rtwsQfvcIxbjSFCwov90qm0=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcVuAcO7b2F99mHf+0N+T3yx4tS7fbMuGrU6exzInlR/6 N3u738dOkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBE+qIZ/im0nnwuuYFT8fPz I/9Oefrff5n8SKg67NjEnb+kr9yOf/+RkWHvk58RU1l/azTvfRLezzn54dv/epsnllQKTrzYOsl o9Q82AA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of relying on a dodgy dd hack to copy the image code size from
the uncompressed image's PE header to the end of the compressed image,
let's grab the code size from the text_offset field of the arm64 image
header after decompression, which is where the arm64 specific EFI zboot
make rules will poke the code size when generating zboot specific
version of the binary Image payload.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile.zboot | 14 +++--------
 drivers/firmware/efi/libstub/arm64.c        | 26 +++++++++++++++-----
 drivers/firmware/efi/libstub/efistub.h      |  3 +--
 drivers/firmware/efi/libstub/zboot.c        | 15 +++--------
 4 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 0a9dcc2b13736519..d34d4f0ed33349d5 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -24,21 +24,13 @@ comp-type-$(CONFIG_KERNEL_ZSTD)		:= zstd22
 # causing the original tools to complain when checking image integrity.
 # So disregard it when calculating the payload size in the zimage header.
 zboot-method-y                         := $(comp-type-y)_with_size
-zboot-size-len-y                       := 12
+zboot-size-len-y                       := 4
 
 zboot-method-$(CONFIG_KERNEL_GZIP)     := gzip
-zboot-size-len-$(CONFIG_KERNEL_GZIP)   := 8
-
-# Copy the SizeOfHeaders and SizeOfCode fields from the payload to the end of
-# the compressed image. Note that this presupposes a PE header offset of 64
-# bytes, which is what arm64, RISC-V and LoongArch use.
-quiet_cmd_compwithsize = $(quiet_cmd_$(zboot-method-y))
-      cmd_compwithsize = $(cmd_$(zboot-method-y)) && ( \
-			   dd status=none if=$< bs=4 count=1 skip=37 ; \
-			   dd status=none if=$< bs=4 count=1 skip=23 ) >> $@
+zboot-size-len-$(CONFIG_KERNEL_GZIP)   := 0
 
 $(obj)/vmlinuz: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,compwithsize)
+	$(call if_changed,$(zboot-method-y))
 
 OBJCOPYFLAGS_vmlinuz.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) \
 			  --rename-section .data=.gzdata,load,alloc,readonly,contents
diff --git a/drivers/firmware/efi/libstub/arm64.c b/drivers/firmware/efi/libstub/arm64.c
index 8aad8c49d43f18e0..a75933b3b9f41c38 100644
--- a/drivers/firmware/efi/libstub/arm64.c
+++ b/drivers/firmware/efi/libstub/arm64.c
@@ -9,6 +9,7 @@
 
 #include <linux/efi.h>
 #include <asm/efi.h>
+#include <asm/image.h>
 #include <asm/memory.h>
 #include <asm/sysreg.h>
 
@@ -89,25 +90,38 @@ efi_status_t check_platform_features(void)
 #endif
 
 void efi_cache_sync_image(unsigned long image_base,
-			  unsigned long alloc_size,
-			  unsigned long code_size)
+			  unsigned long alloc_size)
 {
+	struct arm64_image_header *header = (void *)image_base;
+	/*
+	 * In the EFI zboot case, the kernel code size lives in the text_offset
+	 * field of the image header, which is no longer used now that
+	 * TEXT_OFFSET is always 0x0.
+	 */
+	unsigned long code_size = le64_to_cpu(header->text_offset);
 	u32 ctr = read_cpuid_effective_cachetype();
 	u64 lsize = 4 << cpuid_feature_extract_unsigned_field(ctr,
 						CTR_EL0_DminLine_SHIFT);
 
 	/* only perform the cache maintenance if needed for I/D coherency */
 	if (!(ctr & BIT(CTR_EL0_IDC_SHIFT))) {
+		unsigned long base = image_base;
+		unsigned long size = code_size;
+
 		do {
-			asm("dc " DCTYPE ", %0" :: "r"(image_base));
-			image_base += lsize;
-			code_size -= lsize;
-		} while (code_size >= lsize);
+			asm("dc " DCTYPE ", %0" :: "r"(base));
+			base += lsize;
+			size -= lsize;
+		} while (size >= lsize);
 	}
 
 	asm("ic ialluis");
 	dsb(ish);
 	isb();
+
+	header->text_offset = 0x0;
+
+	efi_remap_image(image_base, alloc_size, code_size);
 }
 
 unsigned long __weak primary_entry_offset(void)
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 148013bcb5f89fdd..67d5a20802e0b7c6 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1066,8 +1066,7 @@ struct screen_info *__alloc_screen_info(void);
 void free_screen_info(struct screen_info *si);
 
 void efi_cache_sync_image(unsigned long image_base,
-			  unsigned long alloc_size,
-			  unsigned long code_size);
+			  unsigned long alloc_size);
 
 struct efi_smbios_record {
 	u8	type;
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index 63ece480090032c1..e5d7fa1f1d8fd160 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -50,8 +50,7 @@ static unsigned long alloc_preferred_address(unsigned long alloc_size)
 }
 
 void __weak efi_cache_sync_image(unsigned long image_base,
-				 unsigned long alloc_size,
-				 unsigned long code_size)
+				 unsigned long alloc_size)
 {
 	// Provided by the arch to perform the cache maintenance necessary for
 	// executable code loaded into memory to be safe for execution.
@@ -66,7 +65,7 @@ asmlinkage efi_status_t __efiapi
 efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 {
 	unsigned long compressed_size = _gzdata_end - _gzdata_start;
-	unsigned long image_base, alloc_size, code_size;
+	unsigned long image_base, alloc_size;
 	efi_loaded_image_t *image;
 	efi_status_t status;
 	char *cmdline_ptr;
@@ -91,13 +90,9 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 	efi_info("Decompressing Linux Kernel...\n");
 
 	// SizeOfImage from the compressee's PE/COFF header
-	alloc_size = round_up(get_unaligned_le32(_gzdata_end - 12),
+	alloc_size = round_up(get_unaligned_le32(_gzdata_end - 4),
 			      EFI_ALLOC_ALIGN);
 
-	// SizeOfHeaders and SizeOfCode from the compressee's PE/COFF header
-	code_size = get_unaligned_le32(_gzdata_end - 4) +
-		    get_unaligned_le32(_gzdata_end - 8);
-
 	 // If the architecture has a preferred address for the image,
 	 // try that first.
 	image_base = alloc_preferred_address(alloc_size);
@@ -140,9 +135,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 		goto free_image;
 	}
 
-	efi_cache_sync_image(image_base, alloc_size, code_size);
-
-	efi_remap_image(image_base, alloc_size, code_size);
+	efi_cache_sync_image(image_base, alloc_size);
 
 	status = efi_stub_common(handle, image, image_base, cmdline_ptr);
 
-- 
2.39.2

