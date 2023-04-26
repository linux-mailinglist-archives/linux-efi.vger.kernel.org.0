Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEED6EF606
	for <lists+linux-efi@lfdr.de>; Wed, 26 Apr 2023 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbjDZOLT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Apr 2023 10:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZOLS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Apr 2023 10:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B33659E
        for <linux-efi@vger.kernel.org>; Wed, 26 Apr 2023 07:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33A6A60FFA
        for <linux-efi@vger.kernel.org>; Wed, 26 Apr 2023 14:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB23C433EF;
        Wed, 26 Apr 2023 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682518276;
        bh=ZezF8Fjx5HkcVFGu9nLyFtSxmdWwnirdqBUV4olYt+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WT7NpJBZQUyqzceb63abnrCwINbSkr95//3jCbTyFs+bW3XZchtlaL25AgWdldh/x
         ttHderUXEK0AbrWkRMvYW/QsMbCWSzTqI2ROMuXwUi8VvkcPaw0+EYBxC2EYgHwI52
         6MNCq1UkVUFr1iHNI0NnBGrlgntpj0NsFEUw9/SAnx+7BskklpPwK21DE0lIhcFx9x
         3GHZTIg2C5qMP5dLWkFqoax1PIz4YucHw0EPQCvpeDv/bohpYNsJDKGzzUJCkPLP0/
         KDN4Cy1e7/YVZcwMPcFtt9iztPtopfu+8QG5myCzU30OU1Ia84A3a0GMxRSBjOdo7p
         VYdeUhyV9vQ8A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/2] efi/zboot: arm64: Inject kernel code size symbol into the zboot payload
Date:   Wed, 26 Apr 2023 16:11:02 +0200
Message-Id: <20230426141103.2464423-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230426141103.2464423-1-ardb@kernel.org>
References: <20230426141103.2464423-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3115; i=ardb@kernel.org; h=from:subject; bh=ZezF8Fjx5HkcVFGu9nLyFtSxmdWwnirdqBUV4olYt+A=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcXT4KuXTamdpNsFnsw7ZZ4me+5GMT7qvHx+/nmrq9Z38 zMC7HZ2lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlYPGb4K7lAhjtu2W8vnqP5 t/vTTt9a+efU84Cc2BMu08OXSOY+5WZk+GxZ7Ji9MHChr2HvlN93UnyN3u+/ElNlyjdJ566e/+P /XAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI zboot code is not built as part of the kernel proper, like the
ordinary EFI stub, but still needs access to symbols that are defined
only internally in the kernel, and are left unexposed deliberately to
avoid creating ABI inadvertently that we're stuck with later.

So capture the kernel code size of the kernel image, and inject it as an
ELF symbol into the object that contains the compressed payload, where
it will be accessible to zboot code that needs it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/boot/Makefile                    | 3 +++
 arch/arm64/kernel/image-vars.h              | 4 ++++
 drivers/firmware/efi/libstub/Makefile.zboot | 2 +-
 drivers/firmware/efi/libstub/zboot.lds      | 7 +++++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index ae645fda90bca574..1761f5972443fc50 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -44,4 +44,7 @@ EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
 EFI_ZBOOT_MACH_TYPE	:= ARM64
 EFI_ZBOOT_FORWARD_CFI	:= $(CONFIG_ARM64_BTI_KERNEL)
 
+EFI_ZBOOT_OBJCOPY_FLAGS	= --add-symbol zboot_code_size=0x$(shell \
+				$(NM) vmlinux|grep _kernel_codesize|cut -d' ' -f1)
+
 include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 8309197c0ebd4a8e..35f3c79595137354 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -108,4 +108,8 @@ KVM_NVHE_ALIAS(kvm_protected_mode_initialized);
 
 #endif /* CONFIG_KVM */
 
+#ifdef CONFIG_EFI_ZBOOT
+_kernel_codesize = ABSOLUTE(__inittext_end - _text);
+#endif
+
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 0a9dcc2b13736519..1b101d9076fd49e5 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -40,7 +40,7 @@ quiet_cmd_compwithsize = $(quiet_cmd_$(zboot-method-y))
 $(obj)/vmlinuz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,compwithsize)
 
-OBJCOPYFLAGS_vmlinuz.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) \
+OBJCOPYFLAGS_vmlinuz.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) $(EFI_ZBOOT_OBJCOPY_FLAGS) \
 			  --rename-section .data=.gzdata,load,alloc,readonly,contents
 $(obj)/vmlinuz.o: $(obj)/vmlinuz FORCE
 	$(call if_changed,objcopy)
diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
index 93d33f68333b2b68..ac8c0ef851581f5d 100644
--- a/drivers/firmware/efi/libstub/zboot.lds
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -2,6 +2,8 @@
 
 ENTRY(__efistub_efi_zboot_header);
 
+PROVIDE(zboot_code_size = ABSOLUTE(0));
+
 SECTIONS
 {
 	.head : ALIGN(4096) {
@@ -17,6 +19,11 @@ SECTIONS
 		*(.gzdata)
 		__efistub__gzdata_end = .;
 		*(.rodata* .init.rodata* .srodata*)
+
+		. = ALIGN(4);
+		__efistub_code_size = .;
+		LONG(zboot_code_size);
+
 		_etext = ALIGN(4096);
 		. = _etext;
 	}
-- 
2.39.2

