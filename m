Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756791A693D
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 17:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbgDMPzr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 11:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731168AbgDMPzq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Apr 2020 11:55:46 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A9E620739;
        Mon, 13 Apr 2020 15:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586793346;
        bh=3Fh3BffeAc7NkYh1mfmRJ9kkzBxnlWD78shHS+Df4II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHKqIrFSn/z+3bCN0lXSwkvimyV3XbtswX+4+IU1uRvjArc+Aa8JphL0B5GO3vkQP
         BFIIrrqg3p5kdDU6FayyPB2mlYiXbpO1SWuv/ioUeLg6TdGGAsL6iXmNwIDBD6Q0ir
         1QYWRWNGlPLPTMMIb5dlIdq9M67fER5jy3iOSEzk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, nivedita@alum.mit.edu,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 7/8] efi/libstub/arm64: switch to ordinary page allocator for kernel image
Date:   Mon, 13 Apr 2020 17:55:20 +0200
Message-Id: <20200413155521.24698-8-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413155521.24698-1-ardb@kernel.org>
References: <20200413155521.24698-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

It is no longer necessary to locate the kernel as low as possible in
physical memory, and so we can switch from efi_low_alloc() [which is
a rather nasty concoction on top of GetMemoryMap()] to a new helper
called efi_allocate_pages_aligned(), which simply rounds up the size
to account for the alignment, and frees the misaligned pages again.

So considering that the kernel can live anywhere in the physical
address space, as long as its alignment requirements are met, let's
switch to efi_allocate_pages_aligned() to allocate the pages.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 6fc3bd9a56db..99b67e88a33b 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -98,8 +98,8 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 			return EFI_SUCCESS;
 		}
 
-		status = efi_low_alloc(*reserve_size,
-				       min_kimg_align, reserve_addr);
+		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
+						    ULONG_MAX, min_kimg_align);
 
 		if (status != EFI_SUCCESS) {
 			pr_efi_err("Failed to relocate kernel\n");
-- 
2.17.1

