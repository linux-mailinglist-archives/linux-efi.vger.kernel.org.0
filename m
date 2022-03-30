Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE014EC8A1
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348364AbiC3Pob (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348366AbiC3Poa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD3633EAA
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CB50B81D6E
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1273C34114;
        Wed, 30 Mar 2022 15:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654962;
        bh=1CikZ2pxQ07LdCOKvbfGEUejKhtp/ShmFjaqIdNlSrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t7qqqBkDqWwgnhKrpIhK1f7Mlu9bU/Bs01mF9513Q3GzaQ5500NmSbt44FeqbNoD4
         AMyyk0MLNc8020bWm4tOpRJcjhedZ+rNwDn2+WYSiKlHljjjUgWQHu9Fpvy9fZH07J
         Btcu8RV/0c7OYhpOkr8R1hXnLne1Ch23rzkxXG0o5dwa2ooDCbaVooLgi8UoHeMYvw
         XTetGnooHi/ZnH8eRXx/sFiK/Rzb2kBIMtX2x5+11v08TwygVAukHkwHXMFzsmT7Ft
         YLpEk5tIxFTC59Ub9SKWat509BnnR3Q1XIgNLuEzo5ulDb8B1mGGsjLyQUaeHEvYqx
         tvAKi5KcP8O9w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 16/18] efi: libstub: pass image handle to handle_kernel_image()
Date:   Wed, 30 Mar 2022 17:42:03 +0200
Message-Id: <20220330154205.2483167-17-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3709; h=from:subject; bh=1CikZ2pxQ07LdCOKvbfGEUejKhtp/ShmFjaqIdNlSrM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHpJZUSNQ0i79wjfMTAXX35/YMEC9rq9fAqQAUIR lU19mgKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6SQAKCRDDTyI5ktmPJBrzC/ 9NQzeLdD6VWj4JurFsTuMeHrzidzBJPJePxmiVRuswOgN338vQD6DXeBURklOftjkahHz8qvlT9GBs vZTQR+a7f9HzBagn5pJWexbstuN48i6tEbCkTQZQlihXGaixA4l18gAQGktg/QRVU44Gu0x4FlPTqV ToH30Q1wz+HGU4GHeZEBEDiiAr5gwshvngdvpKRX43Gj48SfIldYHNN+C+boVILiHA7oV0j6dhX8OC ZLisY/mTySnoUes3giKiQSRm8VX2c1H6DtpCl+6/l4TgwM7fnI9T8EMkQvOKJx9O9k6X5msz4uDpMz yoZn+/Sk8aGaMW+MebCg7+RiS+1bfMgmZhId7SMwIsXuonBXJ9RPaj8sDVZUoA1pg6O0Y+UktPx0Pc G4Q50G9ZS7xJxD1olq92LSW6UpCCuKA3C3JFk8CIdVYSY9KVSvT2ofRCbJ3To4hln9c5SQIt1r79YE XBjdxFKVUtiHbTYbQOV0LkK27KUgh073ApDrnDVZglVbQ=
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

In a future patch, arm64's implementation of handle_kernel_image() will
omit randomizing the placement of the kernel if the load address was
chosen randomly by the loader. In order to do this, it needs to locate a
protocol on the image handle, so pass it to handle_kernel_image().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm32-stub.c | 3 ++-
 drivers/firmware/efi/libstub/arm64-stub.c | 3 ++-
 drivers/firmware/efi/libstub/efi-stub.c   | 2 +-
 drivers/firmware/efi/libstub/efistub.h    | 3 ++-
 drivers/firmware/efi/libstub/riscv-stub.c | 3 ++-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index 4b5b2403b3a0..0131e3aaa605 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -117,7 +117,8 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
 				 unsigned long *reserve_size,
-				 efi_loaded_image_t *image)
+				 efi_loaded_image_t *image,
+				 efi_handle_t image_handle)
 {
 	const int slack = TEXT_OFFSET - 5 * PAGE_SIZE;
 	int alloc_size = MAX_UNCOMP_KERNEL_SIZE + EFI_PHYS_ALIGN;
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 9cc556013d08..00c91a3807ea 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -83,7 +83,8 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
 				 unsigned long *reserve_size,
-				 efi_loaded_image_t *image)
+				 efi_loaded_image_t *image,
+				 efi_handle_t image_handle)
 {
 	efi_status_t status;
 	unsigned long kernel_size, kernel_memsize = 0;
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index da93864d7abc..f515394cce6e 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -198,7 +198,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	status = handle_kernel_image(&image_addr, &image_size,
 				     &reserve_addr,
 				     &reserve_size,
-				     image);
+				     image, handle);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to relocate kernel\n");
 		goto fail_free_screeninfo;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index edb77b0621ea..c4f4f078087d 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -865,7 +865,8 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
 				 unsigned long *reserve_size,
-				 efi_loaded_image_t *image);
+				 efi_loaded_image_t *image,
+				 efi_handle_t image_handle);
 
 asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
 					    unsigned long fdt_addr,
diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
index 9c460843442f..eec043873354 100644
--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -80,7 +80,8 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
 				 unsigned long *reserve_size,
-				 efi_loaded_image_t *image)
+				 efi_loaded_image_t *image,
+				 efi_handle_t image_handle)
 {
 	unsigned long kernel_size = 0;
 	unsigned long preferred_addr;
-- 
2.30.2

