Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38314EC8AB
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348366AbiC3Pod (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348368AbiC3Poc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FED534B91
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C39F7CE1D4F
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1E1C340EC;
        Wed, 30 Mar 2022 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654964;
        bh=nY5MgIoq4fA9USqK31dnu7E3Bd7d2UqYghLsLSuHjOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVNx9yDboKjpdbBoDAyyWEf14Ym8nauJXpH4+srvJIyJ/Mp1vZhuwIaq4dW3IRd6a
         8uQpOkSKq8JniYsgFcJF6iymtSsg8EhyfXXc21V1xqSMyJaOZ3Poj93oZH0pJRmunC
         pqn7uZSp7iWm8T52TAdEfb/sdBsJPeY3MKnM+xpgN9YMHFU+QCv4ALwl/8tnQ7fDI8
         moa8pglsHOk0BMYAZNU0vzlDG4fkAWlg0/SIRa19v0CQDZ+RiLBkITJFfxotTn+UCs
         gv1yK4i2IDJIJk6RbQHsjOgxi2in0z6omFbDGaCKm+fDbh7WP2oExngy1PmWVji2ng
         wJp1m9HTzT0mw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 17/18] efi/arm64: libstub: run image in place if randomized by the loader
Date:   Wed, 30 Mar 2022 17:42:04 +0200
Message-Id: <20220330154205.2483167-18-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2987; h=from:subject; bh=nY5MgIoq4fA9USqK31dnu7E3Bd7d2UqYghLsLSuHjOs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHpKzSWWWLuFC4/Pg5EMCFfx8VQCtcysoeuYuZ+r VfZf23yJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6SgAKCRDDTyI5ktmPJCm3C/ 0eCxz2zED1vCT8/NEwbBohrpW33i7Rjl/8u+X/NyoIGreLpx7UOIPFX4xGtd56C+LvDxMO5vHUp6L/ ZH8cOhk39bRdBD4Mcv4chuBVyGwui1rGLlpytJbGaLaCYaBc2G5TtuVtckJ370UX8auuzCuTvMV7i6 4S9RIl8aqtfgDaC8NGE4d08ujYa2Yr0sbugmx/SuYQ38yD73gSGaz8MiOUIlCI0LePgXuj+W1C6DnO JTO+8TbQooGrXwbDsb1MMC+c4XUYoZEaDkz9YwzHaU1kD7l8NRjlfiF7LsYvDcDpXkTXw8GWKnWaCS i1n4pmGSr+6KE5gkUUyPxE+8BKS83gSinh0LBgv46SckZF3uDqphRVRZykQWUghoeHIvPxzpRE/+7v EhftGRFxp4K0XtPIzCy8srG+2cTp+hx/oujlAYce/o3EBrGa9dMgJVoAzZoEElHDtwSSfYBWnRFObG CFiE/x00VLme2RLdkUSVKm3b/pkDj3drJdHhmjmPk3wM0=
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

If the loader has already placed the EFI kernel image randomly in
physical memory, and indicates having done so by installing the 'fixed
placement' protocol onto the image handle, don't bother randomizing the
placement again in the EFI stub.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 12 +++++++++---
 include/linux/efi.h                       | 11 +++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 00c91a3807ea..577173ee1f83 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -101,7 +101,15 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	u64 min_kimg_align = efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
-		if (!efi_nokaslr) {
+		efi_guid_t li_fixed_proto = LINUX_EFI_LOADED_IMAGE_FIXED_GUID;
+		void *p;
+
+		if (efi_nokaslr) {
+			efi_info("KASLR disabled on kernel command line\n");
+		} else if (efi_bs_call(handle_protocol, image_handle,
+				       &li_fixed_proto, &p) == EFI_SUCCESS) {
+			efi_info("Image placement fixed by loader\n");
+		} else {
 			status = efi_get_random_bytes(sizeof(phys_seed),
 						      (u8 *)&phys_seed);
 			if (status == EFI_NOT_FOUND) {
@@ -112,8 +120,6 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 					status);
 				efi_nokaslr = true;
 			}
-		} else {
-			efi_info("KASLR disabled on kernel command line\n");
 		}
 	}
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ccd4d3f91c98..d7567006e151 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -406,6 +406,17 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_INITRD_MEDIA_GUID		EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
 #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
 
+/*
+ * This GUID may be installed onto the kernel image's handle as a NULL protocol
+ * to signal to the stub that the placement of the image should be respected,
+ * and moving the image in physical memory is undesirable. To ensure
+ * compatibility with 64k pages kernels with virtually mapped stacks, and to
+ * avoid defeating physical randomization, this protocol should only be
+ * installed if the image was placed at a randomized 128k aligned address in
+ * memory.
+ */
+#define LINUX_EFI_LOADED_IMAGE_FIXED_GUID	EFI_GUID(0xf5a37b6d, 0x3344, 0x42a5,  0xb6, 0xbb, 0x97, 0x86, 0x48, 0xc1, 0x89, 0x0a)
+
 /* OEM GUIDs */
 #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
 #define AMD_SEV_MEM_ENCRYPT_GUID		EFI_GUID(0x0cf29b71, 0x9e51, 0x433a,  0xa3, 0xb7, 0x81, 0xf3, 0xab, 0x16, 0xb8, 0x75)
-- 
2.30.2

