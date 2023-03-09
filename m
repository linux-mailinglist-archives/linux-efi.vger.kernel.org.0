Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26936B1B0D
	for <lists+linux-efi@lfdr.de>; Thu,  9 Mar 2023 07:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCIGA2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Mar 2023 01:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCIGA2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Mar 2023 01:00:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A68BC362C;
        Wed,  8 Mar 2023 22:00:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6326B81DEC;
        Thu,  9 Mar 2023 06:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D824C433D2;
        Thu,  9 Mar 2023 06:00:20 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] efi/libstub: Call setup_graphics() before handle_kernel_image()
Date:   Thu,  9 Mar 2023 14:00:12 +0800
Message-Id: <20230309060012.4189412-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypoint
into separate file") moves setup_graphics() into efi_stub_common() which
is after handle_kernel_image(). This causes efifb no longer work because
handle_kernel_image() may move the core kernel to its preferred address,
which means the screen_info filled by the efistub will not be the same
as the one accessed by the core kernel. So let us call setup_graphics()
before handle_kernel_image() which restores the old behavior.

The side effect is zboot will not call setup_graphics(), but I think
zboot doesn't need it either.

Fixes: 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypoint into separate file")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/firmware/efi/libstub/efi-stub-entry.c | 29 +++++++++++++++++++
 drivers/firmware/efi/libstub/efi-stub.c       | 27 -----------------
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
index 5245c4f031c0..f971fd25a4eb 100644
--- a/drivers/firmware/efi/libstub/efi-stub-entry.c
+++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
@@ -5,6 +5,30 @@
 
 #include "efistub.h"
 
+struct screen_info *setup_graphics(void)
+{
+	unsigned long size;
+	efi_status_t status;
+	efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
+	void **gop_handle = NULL;
+	struct screen_info *si = NULL;
+
+	size = 0;
+	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
+			     &gop_proto, NULL, &size, gop_handle);
+	if (status == EFI_BUFFER_TOO_SMALL) {
+		si = alloc_screen_info();
+		if (!si)
+			return NULL;
+		status = efi_setup_gop(si, &gop_proto, size);
+		if (status != EFI_SUCCESS) {
+			free_screen_info(si);
+			return NULL;
+		}
+	}
+	return si;
+}
+
 /*
  * EFI entry point for the generic EFI stub used by ARM, arm64, RISC-V and
  * LoongArch. This is the entrypoint that is described in the PE/COFF header
@@ -22,6 +46,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_guid_t loaded_image_proto = LOADED_IMAGE_PROTOCOL_GUID;
 	unsigned long reserve_addr = 0;
 	unsigned long reserve_size = 0;
+	struct screen_info *si;
 
 	WRITE_ONCE(efi_system_table, systab);
 
@@ -47,6 +72,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	efi_info("Booting Linux Kernel...\n");
 
+	si = setup_graphics();
+
 	status = handle_kernel_image(&image_addr, &image_size,
 				     &reserve_addr,
 				     &reserve_size,
@@ -58,6 +85,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	status = efi_stub_common(handle, image, image_addr, cmdline_ptr);
 
+	free_screen_info(si);
+
 	efi_free(image_size, image_addr);
 	efi_free(reserve_size, reserve_addr);
 
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 2955c1ac6a36..bc67af721412 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -56,30 +56,6 @@ void __weak free_screen_info(struct screen_info *si)
 {
 }
 
-static struct screen_info *setup_graphics(void)
-{
-	efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
-	efi_status_t status;
-	unsigned long size;
-	void **gop_handle = NULL;
-	struct screen_info *si = NULL;
-
-	size = 0;
-	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
-			     &gop_proto, NULL, &size, gop_handle);
-	if (status == EFI_BUFFER_TOO_SMALL) {
-		si = alloc_screen_info();
-		if (!si)
-			return NULL;
-		status = efi_setup_gop(si, &gop_proto, size);
-		if (status != EFI_SUCCESS) {
-			free_screen_info(si);
-			return NULL;
-		}
-	}
-	return si;
-}
-
 static void install_memreserve_table(void)
 {
 	struct linux_efi_memreserve *rsv;
@@ -163,14 +139,12 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 			     unsigned long image_addr,
 			     char *cmdline_ptr)
 {
-	struct screen_info *si;
 	efi_status_t status;
 
 	status = check_platform_features();
 	if (status != EFI_SUCCESS)
 		return status;
 
-	si = setup_graphics();
 
 	efi_retrieve_tpm2_eventlog();
 
@@ -190,7 +164,6 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 
 	status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
 
-	free_screen_info(si);
 	return status;
 }
 
-- 
2.39.1

