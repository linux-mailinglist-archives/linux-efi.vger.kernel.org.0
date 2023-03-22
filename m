Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4256C4D1F
	for <lists+linux-efi@lfdr.de>; Wed, 22 Mar 2023 15:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCVOKx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Mar 2023 10:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjCVOKw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Mar 2023 10:10:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09485FA6C
        for <linux-efi@vger.kernel.org>; Wed, 22 Mar 2023 07:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0398B61F40
        for <linux-efi@vger.kernel.org>; Wed, 22 Mar 2023 14:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3944C433D2;
        Wed, 22 Mar 2023 14:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679494247;
        bh=UCoMh4hSwyIK8JgF8/rWDzBDYL17Hkon+pbKcPK/av0=;
        h=From:To:Cc:Subject:Date:From;
        b=Je1OzQCFa3dNy6+rMvAdKavR4adUUHQN0VMolmUU3FQiSuzgPAhi0L5nMthp3PIfO
         EfLD+gKWY4eh44h17fV13ecWnMl+uQ7wlnsyJfgdZOU1L+WApkTDgTNXSmICLpt+Og
         RhnzaSb4rvzGWaqSF3fJJIrp9qNe7XU7kxSmSvL1fdUX7kFugT7IwOYs6OnQBZwjNy
         b8M+4i0dRGPQipvK94aalKymbaCh7sVFKGM7X454YzWXfNtUtlQr99JsLQwygy8KpM
         07ZRFF5pd6C+U2T4krBOpDfYBw6j1CX8xeEGNS/gpNrTcrFMrj6GlnK7UMgTjTiBQn
         YKrN3/oRQVW5A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v2] efi: libstub: Use relocated version of kernel's struct screen_info
Date:   Wed, 22 Mar 2023 15:10:37 +0100
Message-Id: <20230322141037.3684946-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6658; i=ardb@kernel.org; h=from:subject; bh=UCoMh4hSwyIK8JgF8/rWDzBDYL17Hkon+pbKcPK/av0=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUWaJyZbRfW7j7nV5nOPdUPma2ebzCrQs0/YOrPGeZKKe 8Xmm2c6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQc9jMyzGlz+n7GI/77nHeG b5hPCM+4E9WR+lFbp+T/7EhWjZqnnxj+p6QGP7Zh/Kq27NXE9EXewtxnD3vY8/IGGosUhUR4H3d hAAA=
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

In some cases, we expose the kernel's struct screen_info to the EFI stub
directly, so it gets populated before even entering the kernel.  This
means the early console is available as soon as the early param parsing
happens, which is nice. It also means we need two different ways to pass
this information, as this trick only works if the EFI stub is baked into
the core kernel image, which is not always the case.

Huacai reports that the preparatory refactoring that was needed to
implement this alternative method for zboot resulted in a non-functional
efifb earlycon for other cases as well, due to the reordering of the
kernel image relocation with the population of the screen_info struct,
and the latter now takes place after copying the image to its new
location, which means we copy the old, uninitialized state.

So let's ensure that the same-image version of alloc_screen_info()
produces the correct screen_info pointer, by taking the displacement of
the loaded image into account.

Cc: loongarch@lists.linux.dev
Cc: Xuefeng Li <lixuefeng@loongson.cn>
Cc: Xuerui Wang <kernel@xen0n.name>
Cc: loongson-kernel@lists.loongnix.cn
Reported-by: Huacai Chen <chenhuacai@loongson.cn>
Link: https://lore.kernel.org/linux-efi/20230310021749.921041-1-chenhuacai@loongson.cn/
Fixes: 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypoint into separate file")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2:
- ensure image->image_base is accurate (Redhat has shipped broken GRUB
  versions that put bogus values in there)
- ensure that the config table screen_info version is only used when
  needed

 drivers/firmware/efi/libstub/arm64-stub.c     |  4 +++-
 drivers/firmware/efi/libstub/efi-stub-entry.c | 15 +++++++++++++++
 drivers/firmware/efi/libstub/efi-stub.c       |  9 ---------
 drivers/firmware/efi/libstub/efistub.h        |  1 +
 drivers/firmware/efi/libstub/screen_info.c    |  9 +--------
 drivers/firmware/efi/libstub/zboot.c          |  9 +++++++++
 6 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index b996553cdb4c3587..770b8ecb73984c61 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -85,8 +85,10 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		}
 	}
 
-	if (image->image_base != _text)
+	if (image->image_base != _text) {
 		efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
+		image->image_base = _text;
+	}
 
 	if (!IS_ALIGNED((u64)_text, SEGMENT_ALIGN))
 		efi_err("FIRMWARE BUG: kernel image not aligned on %dk boundary\n",
diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
index 5245c4f031c0a70a..d66e400cd4ccfa19 100644
--- a/drivers/firmware/efi/libstub/efi-stub-entry.c
+++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
@@ -5,6 +5,19 @@
 
 #include "efistub.h"
 
+static unsigned long screen_info_offset;
+
+struct screen_info *alloc_screen_info(void)
+{
+	if (IS_ENABLED(CONFIG_ARM))
+		return __alloc_screen_info();
+	return (void *)&screen_info + screen_info_offset;
+}
+
+void __weak free_screen_info(struct screen_info *si)
+{
+}
+
 /*
  * EFI entry point for the generic EFI stub used by ARM, arm64, RISC-V and
  * LoongArch. This is the entrypoint that is described in the PE/COFF header
@@ -56,6 +69,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		return status;
 	}
 
+	screen_info_offset = image_addr - (unsigned long)image->image_base;
+
 	status = efi_stub_common(handle, image, image_addr, cmdline_ptr);
 
 	efi_free(image_size, image_addr);
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 2955c1ac6a36ee00..c4b9eccad0f103dc 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -47,15 +47,6 @@
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
 static bool flat_va_mapping = (EFI_RT_VIRTUAL_OFFSET != 0);
 
-struct screen_info * __weak alloc_screen_info(void)
-{
-	return &screen_info;
-}
-
-void __weak free_screen_info(struct screen_info *si)
-{
-}
-
 static struct screen_info *setup_graphics(void)
 {
 	efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index bd9c38a93bbce09c..148013bcb5f89fdd 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1062,6 +1062,7 @@ efi_enable_reset_attack_mitigation(void) { }
 void efi_retrieve_tpm2_eventlog(void);
 
 struct screen_info *alloc_screen_info(void);
+struct screen_info *__alloc_screen_info(void);
 void free_screen_info(struct screen_info *si);
 
 void efi_cache_sync_image(unsigned long image_base,
diff --git a/drivers/firmware/efi/libstub/screen_info.c b/drivers/firmware/efi/libstub/screen_info.c
index 8e76a8b384ba142d..4be1c4d1f922becd 100644
--- a/drivers/firmware/efi/libstub/screen_info.c
+++ b/drivers/firmware/efi/libstub/screen_info.c
@@ -15,18 +15,11 @@
  * early, but it only works if the EFI stub is part of the core kernel image
  * itself. The zboot decompressor can only use the configuration table
  * approach.
- *
- * In order to support both methods from the same build of the EFI stub
- * library, provide this dummy global definition of struct screen_info. If it
- * is required to satisfy a link dependency, it means we need to override the
- * __weak alloc and free methods with the ones below, and those will be pulled
- * in as well.
  */
-struct screen_info screen_info;
 
 static efi_guid_t screen_info_guid = LINUX_EFI_SCREEN_INFO_TABLE_GUID;
 
-struct screen_info *alloc_screen_info(void)
+struct screen_info *__alloc_screen_info(void)
 {
 	struct screen_info *si;
 	efi_status_t status;
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index ba234e062a1a29da..10a161e6d5555fe1 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -57,6 +57,15 @@ void __weak efi_cache_sync_image(unsigned long image_base,
 	// executable code loaded into memory to be safe for execution.
 }
 
+struct screen_info *alloc_screen_info(void)
+{
+	return __alloc_screen_info();
+}
+
+void __weak free_screen_info(struct screen_info *si)
+{
+}
+
 asmlinkage efi_status_t __efiapi
 efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 {
-- 
2.39.2

