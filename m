Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0CB6D6716
	for <lists+linux-efi@lfdr.de>; Tue,  4 Apr 2023 17:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjDDPUT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Apr 2023 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjDDPUS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Apr 2023 11:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D12A4205
        for <linux-efi@vger.kernel.org>; Tue,  4 Apr 2023 08:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CC93635CB
        for <linux-efi@vger.kernel.org>; Tue,  4 Apr 2023 15:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C1CC433EF;
        Tue,  4 Apr 2023 15:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680621614;
        bh=Zod0gLV50Ql+WmIuLOmGh7UoZX0DfCWPHhuwknk4N1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SnXiglBacTaqBx4Kx+/0h00V7M+hT91ZfknYmjh2WMm9afuri6GCekKeGSnaTvM5o
         55k8PDszt7f1igsa2wjSMxfDGQcK7D7j72yCx8Ro9CKJcF3/IK3DaLTv8HL3A5ZQTt
         jEzKrfpATFoALA5t3iQXH/vMrZaw4wN45PAtkEOn3L5gr4j4x1wOOa1ZlDXQwgSSy+
         u1aS8WXrFTl8vG7fPpN7CFwrn0l71W/DcWJAG0kcpHHw6j39UGodquTdQvLe5HICOq
         umjWxBALq2nCXIn8anewTRG0XHSi6KLja7vMuqpSiPzF9Lbwl3QwHCo516/vzS0Sxh
         k+1PxA9/bjBuQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, broonie@Kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 4/6] efi/zboot: Add BSS padding before compression
Date:   Tue,  4 Apr 2023 17:19:57 +0200
Message-Id: <20230404151959.2774612-5-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404151959.2774612-1-ardb@kernel.org>
References: <20230404151959.2774612-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5838; i=ardb@kernel.org; h=from:subject; bh=Zod0gLV50Ql+WmIuLOmGh7UoZX0DfCWPHhuwknk4N1E=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUXHQZrxxmvjYq7gN4wtMaEveEsPip3WD3u2sOtx+vLvM +8mFG7pKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZZcTI8LgkSlBywpY+S0c5 o1kvLV3XHrfcNuXyhke8EmzrQ48LhDMyPForPY1n+cX/e/nsEv9rF1pdWGxvdvPJycq+bWEL/5k c4AUA
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

