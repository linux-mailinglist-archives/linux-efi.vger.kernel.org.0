Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CE51E4B86
	for <lists+linux-efi@lfdr.de>; Wed, 27 May 2020 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbgE0RJe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 May 2020 13:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731179AbgE0RJd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 27 May 2020 13:09:33 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB1020873;
        Wed, 27 May 2020 17:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590599372;
        bh=wCetC++Us0xX1f6RC7S6xMvFaA6lr71j5qXv/R2GFEE=;
        h=Date:From:To:Cc:Subject:From;
        b=zLuucDwT+5SPkCFh4nrEOUYnJtLP3LHGwsXthvT1fHzBKOVyJJWRuUvG7aJeB0gKF
         bX2nxlkpXARsQkhAuBWVIqNlkHrKpFILGrJvqaovJMiepJYVTIa6rwizDlMby9gXva
         jrkwIPva6pl9pFMgmeQphrBYMIfD4O8oy8pYdysU=
Date:   Wed, 27 May 2020 12:14:25 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] efi: Replace zero-length array and use struct_size() helper
Message-ID: <20200527171425.GA4053@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

Lastly, make use of the sizeof_field() helper instead of an open-coded
version.

This issue was found with the help of Coccinelle and audited _manually_.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/firmware/efi/efi.c | 3 ++-
 include/linux/efi.h        | 7 ++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7f1657b6c30df..edc5d36caf54e 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -622,7 +622,8 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 			rsv = (void *)(p + prsv % PAGE_SIZE);
 
 			/* reserve the entry itself */
-			memblock_reserve(prsv, EFI_MEMRESERVE_SIZE(rsv->size));
+			memblock_reserve(prsv,
+					 struct_size(rsv, entry, rsv->size));
 
 			for (i = 0; i < atomic_read(&rsv->count); i++) {
 				memblock_reserve(rsv->entry[i].base,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index c45ac969ea4eb..328cc52a5fd45 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1234,14 +1234,11 @@ struct linux_efi_memreserve {
 	struct {
 		phys_addr_t	base;
 		phys_addr_t	size;
-	} entry[0];
+	} entry[];
 };
 
-#define EFI_MEMRESERVE_SIZE(count) (sizeof(struct linux_efi_memreserve) + \
-	(count) * sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
-
 #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
-	/ sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
+	/ sizeof_field(struct linux_efi_memreserve, entry[0]))
 
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
 
-- 
2.26.2

