Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D41A6938
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 17:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgDMPzf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 11:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731168AbgDMPzf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Apr 2020 11:55:35 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DE12073E;
        Mon, 13 Apr 2020 15:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586793334;
        bh=u/xP6CoK1MUmVKKpWlYTdz2lShxhmNKAh4XSY+FwLjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmVGSp6K0VdVrP8HgOexa5iwmmQ7IZXGt680OIuFlIlps3CN2EErfqgDuArDyLSQ0
         /rk+ZqvnWOJPZnSX68Dw5Qci19oft/3skEE3O+fPakg4/23QR2K1I7nz51gIXzpXE6
         tVSs+YfGNgOtENgwLEZkMypZX33UI4gYotTbOS70=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, nivedita@alum.mit.edu,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 2/8] efi/libstub/random: increase random alloc granularity
Date:   Mon, 13 Apr 2020 17:55:15 +0200
Message-Id: <20200413155521.24698-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413155521.24698-1-ardb@kernel.org>
References: <20200413155521.24698-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The implementation of efi_random_alloc() arbitrarily truncates the
provided random seed to 16 bits, which limits the granularity of the
randomly chosen allocation offset in memory. This is currently only
an issue if the size of physical memory exceeds 128 GB, but going
forward, we will reduce the allocation alignment to 64 KB, and this
means we need to increase the granularity to ensure that the random
memory allocations are distributed evenly.

We will need to switch to 64-bit arithmetic for the multiplication,
but this does not result in 64-bit integer intrinsic calls on ARM or
on i386.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/randomalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 6200dfa650f5..a408df474d83 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -87,7 +87,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 	}
 
 	/* find a random number between 0 and total_slots */
-	target_slot = (total_slots * (u16)random_seed) >> 16;
+	target_slot = (total_slots * (u64)(random_seed & U32_MAX)) >> 32;
 
 	/*
 	 * target_slot is now a value in the range [0, total_slots), and so
-- 
2.17.1

