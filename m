Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4481C1A6937
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbgDMPze (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 11:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730923AbgDMPzc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Apr 2020 11:55:32 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B76C20739;
        Mon, 13 Apr 2020 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586793331;
        bh=BUDRicBn8f0ZY8ppIfG0csRmOCIXJIw2tlzx7xNVDnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fw+jw5m5kVq0nwtcd5wSaX+y+J63IlU5bU5zu0fCjN72+FoqAi62rLYWY6i2erMJ/
         gzbO5OSTQhM8UNd/4dvKXB8P6L1HFYMJApMuIOu0AGPgznh/zGy8nrLPWkpgMnO44S
         3dZmdxXw4dpTgnaUIdaUJMshUNGnuHYA7LTMRyps=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, nivedita@alum.mit.edu,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 1/8] efi/libstub/random: align allocate size to EFI_ALLOC_ALIGN
Date:   Mon, 13 Apr 2020 17:55:14 +0200
Message-Id: <20200413155521.24698-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413155521.24698-1-ardb@kernel.org>
References: <20200413155521.24698-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI stub uses a per-architecture #define for the minimum base
and size alignment of page allocations, which is set to 4 KB for
all architecures except arm64, which uses 64 KB, to ensure that
allocations can always be (un)mapped efficiently, regardless of
the page size used by the kernel proper, which could be a kexec'ee

The API wrappers around page based allocations assume that this
alignment is always taken into account, and so efi_free() will
also round up its size argument to EFI_ALLOC_ALIGN.

Currently, efi_random_alloc() does not honour this alignment for
the allocated size, and so freeing such an allocation may result
in unrelated memory to be freed, potentially leading to issues
after boot. So let's round up size in efi_random_alloc() as well.

Fixes: 2ddbfc81eac84a29 ("efi: stub: add implementation of efi_random_alloc()")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/randomalloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 4578f59e160c..6200dfa650f5 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -74,6 +74,8 @@ efi_status_t efi_random_alloc(unsigned long size,
 	if (align < EFI_ALLOC_ALIGN)
 		align = EFI_ALLOC_ALIGN;
 
+	size = round_up(size, EFI_ALLOC_ALIGN);
+
 	/* count the suitable slots in each memory map entry */
 	for (map_offset = 0; map_offset < map_size; map_offset += desc_size) {
 		efi_memory_desc_t *md = (void *)memory_map + map_offset;
@@ -109,7 +111,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 		}
 
 		target = round_up(md->phys_addr, align) + target_slot * align;
-		pages = round_up(size, EFI_PAGE_SIZE) / EFI_PAGE_SIZE;
+		pages = size / EFI_PAGE_SIZE;
 
 		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
 				     EFI_LOADER_DATA, pages, &target);
-- 
2.17.1

