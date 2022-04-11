Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED00F4FB885
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbiDKJyb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344900AbiDKJwR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0E040E79
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6656611DF
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BC0C385AF;
        Mon, 11 Apr 2022 09:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670592;
        bh=nY5MgIoq4fA9USqK31dnu7E3Bd7d2UqYghLsLSuHjOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5tlWgFXnRecHK9IysL2hLGfp66fZjtr3JhUYjQkqGQAKEVPTy0jcJnza67eAKEN7
         jmFLUtyz2CEA0NN+qP1rj0FYZvFBbe6MPAFpTJe1pDzFf0GXehw/aUyEKH3Weo8aEv
         Ag0aB5iKYSJKcpPTUBijw9L1ECPXDCOnLWhOYYLR39ww8RC5ScoATsWKZeIuxpZMEt
         1Awg4o1M1HqIpoDoPAouphp/Ef2l87GVyvwEs3gs6dUIw/MpZvAZ1R0IpryFq1vy9j
         CwLdrO+qyAdRf3f5VKhkM5vczbZ3Cj/FTKBmoSizKTsSKQwYDx638AnamDkBtdlTWi
         3OlfcwuoWFycw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 29/30] efi/arm64: libstub: run image in place if randomized by the loader
Date:   Mon, 11 Apr 2022 11:48:23 +0200
Message-Id: <20220411094824.4176877-30-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2987; h=from:subject; bh=nY5MgIoq4fA9USqK31dnu7E3Bd7d2UqYghLsLSuHjOs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/llzSWWWLuFC4/Pg5EMCFfx8VQCtcysoeuYuZ+r VfZf23yJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5ZQAKCRDDTyI5ktmPJBWTC/ 9gJy6GiRy8IrgDMdqxEgGLv0O/5AYyxtBfyTH4jNdznL7YmRWRRb78h+Of7Jx9vaDMGa1hGgLYLBka NTYTVMSvpd5oyt15T0wdchMUBdn5492PQA6Pv4yT6qZB5KiqEZaBoWTsttFbDBKcr9YUfneMuTsY25 hD2EVQ4mi0ZKdJReP69LYy5jYjkQXItHMhS7wCTOjUun47NRebqBus3rAKfQ4RnmQ0lwWERf2RY+4A ACYHM8leENh5hhlh62OaNHLYdXvP9GVBuoZlyXPEaeybUqyBcX+tCodudAV6ID21bGmICXHGOTDn1/ ssi8jWbw1kqtpr5r08iUciggaUXh4a6XIJnxPUKjqES8i9SikzAB6S++9qw8QkjL+1Qn76In12zGIr rtnCssk6QdtyByBvgDAFQ1Yc6qU8s47WkN5Z47sZz4tdx1r/KDln7019CcJJMU4wttsds0Fs4VLI+M LPbG0csnzg7k0onYzsSj1lRf8IpsbUTUPSYVsuFNiD5iY=
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

