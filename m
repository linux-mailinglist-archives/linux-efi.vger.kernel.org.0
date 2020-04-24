Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651331B7656
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgDXNG4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728142AbgDXNGy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:54 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0BC82084D;
        Fri, 24 Apr 2020 13:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733613;
        bh=BUDRicBn8f0ZY8ppIfG0csRmOCIXJIw2tlzx7xNVDnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKl3xONkNiDUd2ZKrEORtN9Bk3G5TXp4RXuuOYmjrFEYRaILFHZHvVJuArYuOeTTZ
         NCutFaTFElJ7as7jaccxAeg0UYCGUwJBRYceY1zZ9Ui9iWMCwe1ZCAfTv555D/0/iD
         JOa+Ia/M6HJ464ejX0NslrN2dQpPmWmgI57ZH+8g=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 19/33] efi/libstub/random: Align allocate size to EFI_ALLOC_ALIGN
Date:   Fri, 24 Apr 2020 15:05:17 +0200
Message-Id: <20200424130531.30518-20-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
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

