Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF676A693A
	for <lists+linux-efi@lfdr.de>; Wed,  1 Mar 2023 09:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCAIz6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Mar 2023 03:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCAIz5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Mar 2023 03:55:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87948392AC;
        Wed,  1 Mar 2023 00:55:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5F1261254;
        Wed,  1 Mar 2023 08:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B58C433EF;
        Wed,  1 Mar 2023 08:55:52 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] efi/loongarch: Reintroduce efi_relocate_kernel() to relocate kernel
Date:   Wed,  1 Mar 2023 16:55:45 +0800
Message-Id: <20230301085545.2373646-1-chenhuacai@loongson.cn>
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

Since Linux-6.3, LoongArch supports PIE kernel now, so let's reintroduce
efi_relocate_kernel() to relocate the core kernel.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/firmware/efi/libstub/loongarch-stub.c | 24 ++++++-------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
index eee7ed43cdfb..72c71ae201f0 100644
--- a/drivers/firmware/efi/libstub/loongarch-stub.c
+++ b/drivers/firmware/efi/libstub/loongarch-stub.c
@@ -21,26 +21,16 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 efi_loaded_image_t *image,
 				 efi_handle_t image_handle)
 {
-	int nr_pages = round_up(kernel_asize, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
-	efi_physical_addr_t kernel_addr = EFI_KIMG_PREFERRED_ADDRESS;
 	efi_status_t status;
+	unsigned long kernel_addr = 0;
 
-	/*
-	 * Allocate space for the kernel image at the preferred offset. This is
-	 * the only location in memory from where we can execute the image, so
-	 * no point in falling back to another allocation.
-	 */
-	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
-			     EFI_LOADER_DATA, nr_pages, &kernel_addr);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	*image_addr = EFI_KIMG_PREFERRED_ADDRESS;
-	*image_size = kernel_asize;
+	kernel_addr = (unsigned long)&kernel_offset - kernel_offset;
+
+	status = efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel_asize,
+		     EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align(), 0x0);
 
-	memcpy((void *)EFI_KIMG_PREFERRED_ADDRESS,
-	       (void *)&kernel_offset - kernel_offset,
-	       kernel_fsize);
+	*image_addr = kernel_addr;
+	*image_size = kernel_asize;
 
 	return status;
 }
-- 
2.39.1

