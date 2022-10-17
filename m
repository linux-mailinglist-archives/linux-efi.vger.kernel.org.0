Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5143601498
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJQRSN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiJQRSM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:18:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71EF72680
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:18:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6393EB816B3
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4385CC433D6;
        Mon, 17 Oct 2022 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027088;
        bh=K8RgJkeP2FjZcFMhtMZG0DPtPyp/e1VBGlYkpTSuiEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YoqyGLsyG5EnmwfMYI/M4klqA9/FiD2/yl8hlr1Nq2+pY6kSfpRVU+8AuayFK2v69
         L3LH7w5k+oRSah9NwIwVXjQK6Pa56kR7Njd5eONAoo8BfG2FrKJJe/bLul5DTvoOXL
         OBHAHGKZnzafh8ZcGOlJIzc8f7jvCGcuWAMRuiwe+FHExWWlDTXJ5J7GuZVNjVkEPV
         uDMJEfLO+wLoGaqDN3R1JB6Nu6lgrEFHOhYhysnuMvIB0cFONCRdWHU4E7W0KRSrwP
         JN7LPUV755O2fhhTA7FkRIKjAyYNHYePSgcSiaNEdhNJ0MQJX9Ei7HxSsDZZBNN5Gw
         P8Q/I0RBWMXSQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 15/21] efi: libstub: Add image code and data size to the zimage metadata
Date:   Mon, 17 Oct 2022 19:16:54 +0200
Message-Id: <20221017171700.3736890-16-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3995; i=ardb@kernel.org; h=from:subject; bh=K8RgJkeP2FjZcFMhtMZG0DPtPyp/e1VBGlYkpTSuiEQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY4Bb/e50QcPop8x6FlB1bRCYamI+h3HrZJncNgg 7yWjH8mJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02OAQAKCRDDTyI5ktmPJK8LDA Ci6AOhwm4a1z6EoFkNfHbBJ63Nd79Q5z7U8/OEfu3kclaue83+aNLTptAAeJNWdCeuswT/rw5VC6R1 xVBf9KIn9AawtRIgVBFXrP+1yMsuK3Kf/KRK4wC94sMLqFUVizfeY+WCFm89bqkDMgktqbBvDa54fA OKlRGHllxISQ2yaWrqZlsMfw44tWRA4ELhb95Cw0OhZX3EFI7U/g8dA0rLZkgb0mbSxBIRJeXWnUvk 6rl0BwZCyNuMLziLiT598JvTTgUyCbWMDPXU6DgYcbSNaQYccL4lguBl0OB7kQGcAwBuBLa4rE4isZ 8TmLkyrMOgr9VWMwP7UYD3Y58fkWGBE4k5CXkA+IQOdw75b7IUxQpwDTXL8ufjd6bY5oap+GMbyNlV TROXH9OQlQLPqgVMC0gj05jPfh00mw2BAw33x8lpgpaWZiZ3x3InVl/o+hXf5+nLgZO3tCbW0puyzs haiLXB1VzHeSjeDPHczt3o7WhjqbO3RgQ1MqG+UbKwNgM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In order to be able to switch from LoadImage() [which treats the
supplied PE/COFF image as file input only, and reconstructs the memory
image based on the section descriptors] to a mode where we allocate the
memory directly, and invoke the image in place, we need to now how much
memory to allocate beyond the end of the image. So copy this information
from the payload's PE/COFF header to the end of the compressed version
of the payload, so that the decompressor app can access it before
performing the decompression itself.

We'll also need to size of the code region once we switch arm64 to
jumping to the kernel proper with MMU and caches enabled, so let's
capture that information as well. Note that SizeOfCode does not account
for the header, so we need SizeOfHeaders as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile.zboot | 26 +++++++++-----------
 drivers/firmware/efi/libstub/zboot-header.S |  2 +-
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 3340b385a05b..c5d11473ef80 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -10,18 +10,17 @@ comp-type-$(CONFIG_KERNEL_LZO)		:= lzo
 comp-type-$(CONFIG_KERNEL_XZ)		:= xzkern
 comp-type-$(CONFIG_KERNEL_ZSTD)		:= zstd22
 
-# in GZIP, the appended le32 carrying the uncompressed size is part of the
-# format, but in other cases, we just append it at the end for convenience,
-# causing the original tools to complain when checking image integrity.
-# So disregard it when calculating the payload size in the zimage header.
-zboot-method-y				:= $(comp-type-y)_with_size
-zboot-size-len-y			:= 4
-
-zboot-method-$(CONFIG_KERNEL_GZIP)	:= gzip
-zboot-size-len-$(CONFIG_KERNEL_GZIP)	:= 0
-
-$(obj)/vmlinuz: $(obj)/$(EFI_ZBOOT_PAYLOAD) FORCE
-	$(call if_changed,$(zboot-method-y))
+# Copy the SizeOfHeaders, SizeOfCode and SizeOfImage fields from the payload to
+# the end of the compressed image. Note that this presupposes a PE header
+# offset of 64 bytes, which is what arm64, RISC-V and LoongArch use.
+quiet_cmd_pesize = PESIZE  $@
+      cmd_pesize = ( dd status=none if=$< bs=1 count=4 skip=148 ; \
+		     dd status=none if=$< bs=1 count=4 skip=92 ; \
+		     dd status=none if=$< bs=1 count=4 skip=144 ) >> $@
+
+$(obj)/vmlinuz: $(obj)/$(EFI_ZBOOT_PAYLOAD)
+	$(call cmd,$(comp-type-y))
+	$(call cmd,pesize)
 
 OBJCOPYFLAGS_vmlinuz.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) \
 			  --rename-section .data=.gzdata,load,alloc,readonly,contents
@@ -30,7 +29,6 @@ $(obj)/vmlinuz.o: $(obj)/vmlinuz FORCE
 
 AFLAGS_zboot-header.o += -DMACHINE_TYPE=IMAGE_FILE_MACHINE_$(EFI_ZBOOT_MACH_TYPE) \
 			 -DZBOOT_EFI_PATH="\"$(realpath $(obj)/vmlinuz.efi.elf)\"" \
-			 -DZBOOT_SIZE_LEN=$(zboot-size-len-y) \
 			 -DCOMP_TYPE="\"$(comp-type-y)\""
 
 $(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/libstub/zboot-header.S FORCE
@@ -46,4 +44,4 @@ OBJCOPYFLAGS_vmlinuz.efi := -O binary
 $(obj)/vmlinuz.efi: $(obj)/vmlinuz.efi.elf FORCE
 	$(call if_changed,objcopy)
 
-targets += zboot-header.o vmlinuz vmlinuz.o vmlinuz.efi.elf vmlinuz.efi
+targets += zboot-header.o vmlinuz.o vmlinuz.efi.elf vmlinuz.efi
diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
index 9e6fe061ab07..bc2d7750d7f1 100644
--- a/drivers/firmware/efi/libstub/zboot-header.S
+++ b/drivers/firmware/efi/libstub/zboot-header.S
@@ -17,7 +17,7 @@ __efistub_efi_zboot_header:
 	.long		MZ_MAGIC
 	.ascii		"zimg"					// image type
 	.long		__efistub__gzdata_start - .Ldoshdr	// payload offset
-	.long		__efistub__gzdata_size - ZBOOT_SIZE_LEN	// payload size
+	.long		__efistub__gzdata_size - 12		// payload size
 	.long		0, 0					// reserved
 	.asciz		COMP_TYPE				// compression type
 	.org		.Ldoshdr + 0x3c
-- 
2.35.1

