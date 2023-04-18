Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CE86E6659
	for <lists+linux-efi@lfdr.de>; Tue, 18 Apr 2023 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjDRNuO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Apr 2023 09:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjDRNuM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Apr 2023 09:50:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFF19031
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 06:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99C0462828
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 13:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D7DC433A0;
        Tue, 18 Apr 2023 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681825810;
        bh=itkz19a6AQffFf+lI3+0O4zeHpmhbSPDYT1Qi9LQ+Uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNzToNHcnx5kSIlCsDHfu54FmEEnLhiYCsUfjDBzG7wTJAfoQjEkJYnskmy2mC+45
         qYiS+uAVieJXOXZieIG0GUmzejsS7OsuCVE8CR2C+9VwcoaZkmrn4AQuuWqRMUY5gm
         BCwiejlkIHkyzVfikjQ3+fqUYM4ruEILCNTLX7kOGjStsQFtsXegB5/IG1xbjLYhXP
         1HSqDG7kV4mc5k8OrpOhyDgd64UveULYyqdrOFy2cnq/LE6tOO1px3KBoFy2WUpSLR
         Coz4SU2xdQmBjs6rp6WmxDtG80w8ETmH6F1NJWiUOeNqNJWQtDsn1xJJvGaKRagk4b
         BybqoKMl/2ymg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        broonie@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 3/6] efi/zboot: arm64: Poke kernel code size into the zboot payload image header
Date:   Tue, 18 Apr 2023 15:49:49 +0200
Message-Id: <20230418134952.1170141-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418134952.1170141-1-ardb@kernel.org>
References: <20230418134952.1170141-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662; i=ardb@kernel.org; h=from:subject; bh=itkz19a6AQffFf+lI3+0O4zeHpmhbSPDYT1Qi9LQ+Uc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcVu/p/KqvcB5RqrlPuCz+atn79g9bTJ0+dPqvc8vSCHV WT6jJhrHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiNQKMDDtPcv0QM98ww2fR GutbX46Y/pt9amr6+3/8TnoSxtt2cxczMpx7Hj0v9EC+hfm/M5U92v7+5nK/ou9VW6/I5phxc/m KQ7wA
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

The EFI zboot code is not built as part of the kernel proper, like the
ordinary EFI stub, but still needs access to symbols that are defined
only internally in the kernel, and are left unexposed deliberately to
avoid creating ABI inadvertently that we're stuck with later.

So instead of passing the ordinary Image file to the zboot make rules,
create an alternate version Image.zboot that has the code size copied
into the header into a field that has meaning in the bare metal boot
ABI, but is actually not used anymore, and is always set to 0x0.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/boot/Makefile       | 23 +++++++++++++++++++-
 arch/arm64/kernel/image-vars.h |  4 ++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index c65aee0884103c6f..5d73229604b11061 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -39,8 +39,29 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
 $(obj)/Image.zst: $(obj)/Image FORCE
 	$(call if_changed,zstd)
 
-EFI_ZBOOT_PAYLOAD	:= Image
+EFI_ZBOOT_PAYLOAD	:= Image.zboot
 EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
 EFI_ZBOOT_MACH_TYPE	:= ARM64
 
+#
+# The EFI zboot logic needs to know the size of the executable region in the
+# image, so let's poke that into the text_offset field of the image header of
+# the zboot payload, as that field is no longer used and can thus be repurposed
+# for other, purely internal uses.
+#
+quiet_cmd_copy_and_poke = $(quiet_cmd_objcopy)
+      cmd_copy_and_poke = $(cmd_objcopy) && /bin/echo -ne "$(POKE_DATA)" | dd bs=1 \
+				status=none conv=notrunc seek=$(POKE_OFFSET) of=$@
+
+# grab the code size and convert it into something we can echo
+$(obj)/$(EFI_ZBOOT_PAYLOAD): POKE_DATA = $(shell $(NM) $<|grep _kernel_codesize|\
+				sed -E 's/0+(..)(..)(..)(..) .+/\\x\4\\x\3\\x\2\\x\1/')
+$(obj)/$(EFI_ZBOOT_PAYLOAD): POKE_OFFSET := 8
+$(obj)/$(EFI_ZBOOT_PAYLOAD): vmlinux FORCE
+	$(call if_changed,copy_and_poke)
+
+OBJCOPYFLAGS_$(EFI_ZBOOT_PAYLOAD) := $(OBJCOPYFLAGS_Image)
+
+targets += $(EFI_ZBOOT_PAYLOAD)
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
-- 
2.39.2

