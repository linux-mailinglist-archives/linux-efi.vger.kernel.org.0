Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3036E665A
	for <lists+linux-efi@lfdr.de>; Tue, 18 Apr 2023 15:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjDRNuO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Apr 2023 09:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDRNuO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Apr 2023 09:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE19B468D
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 06:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84B3E628B6
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 13:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D45C433A4;
        Tue, 18 Apr 2023 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681825811;
        bh=Zod0gLV50Ql+WmIuLOmGh7UoZX0DfCWPHhuwknk4N1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P20uT7A+ztYQyvHg4o1M1pDh3u/tUuynMs6Q6l4AGiQPhnzc+EG8JtVthzRh5OGkN
         deqnHu0rm8JIs17oUv/Q7PblEhLX7VWSUmO8Vw5wHw2hayYdAT+rC3+EAwk/SNkX8B
         VznrjSVtUNfMKo+wtG36K/MLsownNc5bAtTPMHB/KBzpVdTTlDTwJvdZJZeeMEvotk
         EKTV5CURRiMJ1/LIoOx6rBQflw636DZz39DWl34lF01tSpGei4dyrlnt8JVTZWFaoP
         bOVnV0oZKSVATnEfzam5IIgEIxARwSsXcSKLkyU8HOgCPn0UKuDIGMapaSFoYCDnyh
         2alBMdniBRucA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        broonie@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 4/6] efi/zboot: Add BSS padding before compression
Date:   Tue, 18 Apr 2023 15:49:50 +0200
Message-Id: <20230418134952.1170141-5-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418134952.1170141-1-ardb@kernel.org>
References: <20230418134952.1170141-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5838; i=ardb@kernel.org; h=from:subject; bh=Zod0gLV50Ql+WmIuLOmGh7UoZX0DfCWPHhuwknk4N1E=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcVu/l/GG6+Ni7mC3zC2xIS+4C09KHZaP+zZwq7H6cu/z 7ybULilo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExk0iSGfxb/rdVrNG84e/kk 3nvpf96RPT8h+PJeC3W3N7FbW7wPX2b47/9X5daDtzuqkn761aTEV0eu+75u9dKH9Rq/3vAc0G3 05gEA
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

We don't really care about the size of the decompressed image - what
matters is how much space needs to be allocated for the image to
execute, and this includes space for BSS that is not part of the
loadable image and so it is not accounted for in the decompressed size.

So let's add some zero padding to the end of the image: this compresses
well, and it ensures that BSS is accounted for, and as a bonus, it will
be zeroed before launching the image.

Since all architectures that implement support for EFI zboot carry this
value in the header in the same location, we can just grab it from the
binary that is being compressed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile.zboot | 36 +++++++++++++++-----
 drivers/firmware/efi/libstub/zboot-header.S |  2 +-
 drivers/firmware/efi/libstub/zboot.c        |  6 ++--
 3 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index ccdd6a130d98618e..2d78770236049b21 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -3,6 +3,14 @@
 # to be include'd by arch/$(ARCH)/boot/Makefile after setting
 # EFI_ZBOOT_PAYLOAD, EFI_ZBOOT_BFD_TARGET and EFI_ZBOOT_MACH_TYPE
 
+quiet_cmd_copy_and_pad = PAD     $@
+      cmd_copy_and_pad = cp $< $@ && \
+			 truncate -s $(shell hexdump -s16 -n4 -e '"%u"' $<) $@
+
+# Pad the file to the size of the uncompressed image in memory, including BSS
+$(obj)/vmlinux.bin: $(obj)/$(EFI_ZBOOT_PAYLOAD) FORCE
+	$(call if_changed,copy_and_pad)
+
 comp-type-$(CONFIG_KERNEL_GZIP)		:= gzip
 comp-type-$(CONFIG_KERNEL_LZ4)		:= lz4
 comp-type-$(CONFIG_KERNEL_LZMA)		:= lzma
@@ -10,16 +18,25 @@ comp-type-$(CONFIG_KERNEL_LZO)		:= lzo
 comp-type-$(CONFIG_KERNEL_XZ)		:= xzkern
 comp-type-$(CONFIG_KERNEL_ZSTD)		:= zstd22
 
-# Copy the SizeOfHeaders, SizeOfCode and SizeOfImage fields from the payload to
-# the end of the compressed image. Note that this presupposes a PE header
-# offset of 64 bytes, which is what arm64, RISC-V and LoongArch use.
-quiet_cmd_compwithsize = $(quiet_cmd_$(comp-type-y))
-      cmd_compwithsize = $(cmd_$(comp-type-y)) && ( \
+# in GZIP, the appended le32 carrying the uncompressed size is part of the
+# format, but in other cases, we just append it at the end for convenience,
+# causing the original tools to complain when checking image integrity.
+# So disregard it when calculating the payload size in the zimage header.
+zboot-method-y                         := $(comp-type-y)_with_size
+zboot-size-len-y                       := 12
+
+zboot-method-$(CONFIG_KERNEL_GZIP)     := gzip
+zboot-size-len-$(CONFIG_KERNEL_GZIP)   := 8
+
+# Copy the SizeOfHeaders and SizeOfCode fields from the payload to the end of
+# the compressed image. Note that this presupposes a PE header offset of 64
+# bytes, which is what arm64, RISC-V and LoongArch use.
+quiet_cmd_compwithsize = $(quiet_cmd_$(zboot-method-y))
+      cmd_compwithsize = $(cmd_$(zboot-method-y)) && ( \
 			   dd status=none if=$< bs=4 count=1 skip=37 ; \
-			   dd status=none if=$< bs=4 count=1 skip=23 ; \
-			   dd status=none if=$< bs=4 count=1 skip=36 ) >> $@
+			   dd status=none if=$< bs=4 count=1 skip=23 ) >> $@
 
-$(obj)/vmlinuz: $(obj)/$(EFI_ZBOOT_PAYLOAD) FORCE
+$(obj)/vmlinuz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,compwithsize)
 
 OBJCOPYFLAGS_vmlinuz.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) \
@@ -29,6 +46,7 @@ $(obj)/vmlinuz.o: $(obj)/vmlinuz FORCE
 
 AFLAGS_zboot-header.o += -DMACHINE_TYPE=IMAGE_FILE_MACHINE_$(EFI_ZBOOT_MACH_TYPE) \
 			 -DZBOOT_EFI_PATH="\"$(realpath $(obj)/vmlinuz.efi.elf)\"" \
+			 -DZBOOT_SIZE_LEN=$(zboot-size-len-y) \
 			 -DCOMP_TYPE="\"$(comp-type-y)\""
 
 $(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/libstub/zboot-header.S FORCE
@@ -44,4 +62,4 @@ OBJCOPYFLAGS_vmlinuz.efi := -O binary
 $(obj)/vmlinuz.efi: $(obj)/vmlinuz.efi.elf FORCE
 	$(call if_changed,objcopy)
 
-targets += zboot-header.o vmlinuz vmlinuz.o vmlinuz.efi.elf vmlinuz.efi
+targets += zboot-header.o vmlinux.bin vmlinuz vmlinuz.o vmlinuz.efi.elf vmlinuz.efi
diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
index 445cb646eaaaf1c6..053aba073594936b 100644
--- a/drivers/firmware/efi/libstub/zboot-header.S
+++ b/drivers/firmware/efi/libstub/zboot-header.S
@@ -17,7 +17,7 @@ __efistub_efi_zboot_header:
 	.long		MZ_MAGIC
 	.ascii		"zimg"					// image type
 	.long		__efistub__gzdata_start - .Ldoshdr	// payload offset
-	.long		__efistub__gzdata_size - 12		// payload size
+	.long		__efistub__gzdata_size - ZBOOT_SIZE_LEN	// payload size
 	.long		0, 0					// reserved
 	.asciz		COMP_TYPE				// compression type
 	.org		.Ldoshdr + 0x38
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index 6105e5e2eda4612b..63ece480090032c1 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -91,12 +91,12 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 	efi_info("Decompressing Linux Kernel...\n");
 
 	// SizeOfImage from the compressee's PE/COFF header
-	alloc_size = round_up(get_unaligned_le32(_gzdata_end - 4),
+	alloc_size = round_up(get_unaligned_le32(_gzdata_end - 12),
 			      EFI_ALLOC_ALIGN);
 
 	// SizeOfHeaders and SizeOfCode from the compressee's PE/COFF header
-	code_size = get_unaligned_le32(_gzdata_end - 8) +
-		    get_unaligned_le32(_gzdata_end - 12);
+	code_size = get_unaligned_le32(_gzdata_end - 4) +
+		    get_unaligned_le32(_gzdata_end - 8);
 
 	 // If the architecture has a preferred address for the image,
 	 // try that first.
-- 
2.39.2

