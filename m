Return-Path: <linux-efi+bounces-1430-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF7992ED7E
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 19:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED341C20E98
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5401016D4FC;
	Thu, 11 Jul 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpaL++/f"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF8157469;
	Thu, 11 Jul 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717875; cv=none; b=oyedrRpl9JQTu0GGc+thK7EZxJqylvcD6JXpbFMd+jP9HTKT81v03DFTxuBUWeTi9ROdeNjftBaIoV86lcUZvKqZVxqFDWd1R3kx475e1zpXytwweuWdb04CwFfYvKnV2UVWE+n8u5kMuL8oJ5bxRQ24Jb8K1Ud1AIpWy9JTItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717875; c=relaxed/simple;
	bh=RXXoWLs0cwMxdM/Qi4v8p1p2NcO5f77RYkQqcvzTQug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okCmBnvaLkQ+01V18IMtB2/prBLgg+A5YCK10eiZdr547IVhu5lGOTfX6UX1ITMRI1Nmks/0QB3mKsnOuq+BDzKHV7+FVyJkc8AuAA3dBJ1bDNVOrQRu3nWoWW7W2zijaw1jhApRAx/KEG295x/ufJlrcj3K/xc7Z1bQiiaOJWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpaL++/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06BAC32786;
	Thu, 11 Jul 2024 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720717874;
	bh=RXXoWLs0cwMxdM/Qi4v8p1p2NcO5f77RYkQqcvzTQug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TpaL++/fkd/rV/wjVLLb+raq5EjkslntvsC3m1OHCzO39guyKO54WGWo1QD5mN4W8
	 Dk8jJyKUzWyvARG4OFG8W135wCDnwER6YGpyE80cFhiNqw+fyxmPiElrGRriDIHVER
	 HGMf4nwFoYwBvbbzy1JvNkTCUB7gyuuSPuuXJ8f0kmVk0qScrAEnYKxYB4r4XhNQuF
	 8Rnq5NOYu0mvI8+qzvJmofS8MTimzpw3vJZz/RhU+A/Nsmf0yEdE0hfQoJFESX2+yQ
	 VE4tIVzIvI0jnxBKxtRQjqpWzvxt/NZ25y7+Jx1g0spaChk2NVJnAfwljqPwPM2GmJ
	 bfjuLc+Z+XQ3w==
From: Kees Cook <kees@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Baskov Evgeniy <baskov@ispras.ru>,
	linux-efi@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Radek Podgorny <radek@podgorny.cz>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] efi: Rename efi_early_memdesc_ptr() to efi_memdesc_ptr()
Date: Thu, 11 Jul 2024 10:11:12 -0700
Message-Id: <20240711171114.121313-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711170727.it.194-kees@kernel.org>
References: <20240711170727.it.194-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3571; i=kees@kernel.org; h=from:subject; bh=RXXoWLs0cwMxdM/Qi4v8p1p2NcO5f77RYkQqcvzTQug=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmkBIxM12T+ItZE6IFIzzlKUhAM0dN5KvycQr6w tLQEcT7kTCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpASMQAKCRCJcvTf3G3A Jh9OD/0UM+UTvKLR4vPibX/Exo0SOL8C9pleDjW859SF3zHF5g/1OsfMoSW0efHNxJbek+HxeLs DQAbpXWxwW/M6CsNHfdkythtMnjP6BMM/UyM6dFw59aXDz944fdUe8C1LRU3sGJ7ER8kJpZzjvi aBkbXnFmn7/R2SmxI4Qj9ENcCsbt9LE5m4RcwlU0dDI2Q8VUEV02qAIiJOKfh5ND2fruX8ZllDb 03nu2PoqqqoL2ePB4t6GLI1a6SXTSEe3ohZJEBIIahyyeYrkQColsllLAJ3WNW9p8rSPOcx9MpU YVX+yMDnghJ+ycc/x0yaY62PrHjy9W98gSys6oS8MWuXpLkvTTRpVfojp2mwDsr96pHude10T2Z bExe74xo2vz5BQcUIswEubUvWvGeZHH3G+c8SJT41XoYsaB2JvdYoSLL+BDjnpnTejKOLYSYG/s ydc5A1Z2ychI0S77PEZSqV3gjGd9SBqdFEQNmqxXEH1cjw+HIBG+cccMtusIvok5PL0sGqhjWHa OSffq/9tVkl+V9uCXIRQP0kOAXOUbUVAaT4a6YoX5jO3YGwoXXH760JsvBK6lP4nAH41GLxmOdx yMMhrJlRqNQj1p+9Chojue4+B2ZGZG8tLhckXlVwhmnHGSIiIIhiO9W5mamxnUH0VDxxlqCb3Q5 SKr9h+8Qh7bC1mw==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The "early" part of the helper's name isn't accurate[1]. Drop it in
preparation for adding a new (not early) usage.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/lkml/CAMj1kXEyDjH0uu3Z4eBesV3PEnKGi5ArXXMp7R-hn8HdRytiPg@mail.gmail.com [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: Baskov Evgeniy <baskov@ispras.ru>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/libstub/relocate.c          | 2 +-
 drivers/firmware/efi/libstub/unaccepted_memory.c | 2 +-
 drivers/firmware/efi/libstub/x86-stub.c          | 2 +-
 include/linux/efi.h                              | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
index bf6fbd5d22a1..d694bcfa1074 100644
--- a/drivers/firmware/efi/libstub/relocate.c
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -48,7 +48,7 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 		unsigned long m = (unsigned long)map->map;
 		u64 start, end;
 
-		desc = efi_early_memdesc_ptr(m, map->desc_size, i);
+		desc = efi_memdesc_ptr(m, map->desc_size, i);
 
 		if (desc->type != EFI_CONVENTIONAL_MEMORY)
 			continue;
diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
index 9a655f30ba47..c295ea3a6efc 100644
--- a/drivers/firmware/efi/libstub/unaccepted_memory.c
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -29,7 +29,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
 		efi_memory_desc_t *d;
 		unsigned long m = (unsigned long)map->map;
 
-		d = efi_early_memdesc_ptr(m, map->desc_size, i);
+		d = efi_memdesc_ptr(m, map->desc_size, i);
 		if (d->type != EFI_UNACCEPTED_MEMORY)
 			continue;
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 1983fd3bf392..8d94484f3a20 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -555,7 +555,7 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 		m |= (u64)efi->efi_memmap_hi << 32;
 #endif
 
-		d = efi_early_memdesc_ptr(m, efi->efi_memdesc_size, i);
+		d = efi_memdesc_ptr(m, efi->efi_memdesc_size, i);
 		switch (d->type) {
 		case EFI_RESERVED_TYPE:
 		case EFI_RUNTIME_SERVICES_CODE:
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 418e555459da..fbdfcc9a81e6 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -783,7 +783,7 @@ extern int efi_memattr_apply_permissions(struct mm_struct *mm,
 					 efi_memattr_perm_setter fn);
 
 /*
- * efi_early_memdesc_ptr - get the n-th EFI memmap descriptor
+ * efi_memdesc_ptr - get the n-th EFI memmap descriptor
  * @map: the start of efi memmap
  * @desc_size: the size of space for each EFI memmap descriptor
  * @n: the index of efi memmap descriptor
@@ -801,7 +801,7 @@ extern int efi_memattr_apply_permissions(struct mm_struct *mm,
  * during bootup since for_each_efi_memory_desc_xxx() is available after the
  * kernel initializes the EFI subsystem to set up struct efi_memory_map.
  */
-#define efi_early_memdesc_ptr(map, desc_size, n)			\
+#define efi_memdesc_ptr(map, desc_size, n)			\
 	(efi_memory_desc_t *)((void *)(map) + ((n) * (desc_size)))
 
 /* Iterate through an efi_memory_map */
-- 
2.34.1


