Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE844FB86E
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbiDKJyE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344903AbiDKJwR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF883F8A5
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40D77B811CB
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4DCC385A3;
        Mon, 11 Apr 2022 09:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670589;
        bh=1CikZ2pxQ07LdCOKvbfGEUejKhtp/ShmFjaqIdNlSrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=askvxoerYFZVWC3aTFAuLQ8ozaFSpZLh3vN+hJg/ga9uduRUPmHaz0V8EQHS8XUQs
         HsPlZ/uClJrxldIleFdaYLTO2bRkCwqHuU1Npz2xu83HTHaDH8PMZpqCm2g3m2CcKG
         z3SOHA+ffWqY7ogEIBqTu2gn0pa7svdT+QSsF0be5oZuOesHUonM9CF2godsjprGaH
         xvApoTmo4YM/kF3GcwqI7jjdjTSfAHVy1WEDlzwluHFHLZamAj9Z5RToVjZBKN8mwi
         fzWd6zc2pfZWGvH1OB1HU0QkNDiSp5IalyPa2YnZKR1YYGRqA0PyK++nirev3SLQ1j
         tWOLUmQbLabMg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 28/30] efi: libstub: pass image handle to handle_kernel_image()
Date:   Mon, 11 Apr 2022 11:48:22 +0200
Message-Id: <20220411094824.4176877-29-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3709; h=from:subject; bh=1CikZ2pxQ07LdCOKvbfGEUejKhtp/ShmFjaqIdNlSrM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/ljZUSNQ0i79wjfMTAXX35/YMEC9rq9fAqQAUIR lU19mgKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5YwAKCRDDTyI5ktmPJIeDDA C4vlBkQeiUY0osUjwpoTqwmpaOdhVYUhcgz6ZEUUMF31/QgaOJRhjn69q4yzo9DNCDk9Zs/VyDV+Ws DJfMGC74IBHh1qSzJk8BmcLmpUQJSG6qSIol9727lvkhPgsb3ySym2N2C7exI0ZJfFOsNLhBRqQW19 5/DsiIrxrqk+cr8L90aoPRNkAF1fmylEbU2a/rAQy6iwOTTNpnmVUDnje3zmhe+BuN5MXrBUzd3/X+ AmCTUOyK9HrWLS27vYGz8HFBtZCA5dp4DX90iBJXWRL5OEm64KCkorJjc1DcQkGk3DD4kFZ/t9356I izppl16pPOVjUxKZBBHipSYaYljN2hJoMDNwRzM3gi/hTKuWzDk3qxwD6qUEkHP6o39ViClnBJEwjY crnu4NK45W+qj6HTcptrmP5ss/YvCPm9CxpyKgBiC8hjCMN5H29RNs/vHatJSwkQlbi1l/fIX09TGi S3XvVyzGveaF0V6AOWNs8UQ1tr5ZaebtuArBMfOc0lwQw=
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

