Return-Path: <linux-efi+bounces-1205-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E227390529C
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 14:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8E21C21245
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 12:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B037C171093;
	Wed, 12 Jun 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYbsOqaE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172BD171070
	for <linux-efi@vger.kernel.org>; Wed, 12 Jun 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195837; cv=none; b=cwzZeyp5EQ/3a7KTsFclDWkuV419a65/U4vO9VLx5F3Q1tpyJ4447wwg0tCDBw85u30dy0X+CLFzrrZKxzeNHwMNjHnG3sBuvOETti45CBDppamR9Eow/85ouIq/d55NGyarEhLN9AYQPWUT8ptvv2/e1Ad2fMksmE2bSPta8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195837; c=relaxed/simple;
	bh=GgEF8zEHf8pEI7O6wjwwr6gKrdf9x38J0uU+CMmF6f0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mVnaKQU5AEKpEhACLAJShMDuHlzWcMzr2xFSZoopiAsuFG4NqBW3wgd7rGDClgO3Lzrhk3LMAc+2qPz5MI2iLSfKBH3kkN3yQkqz1IaARXwzd+ThiqSkk28HGZPQ4q+AsiTlYw/gF0PDBQ9zWWa2Hwxk2sipznvqlgQjlJs5DDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYbsOqaE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62fb36d7f5fso13944287b3.1
        for <linux-efi@vger.kernel.org>; Wed, 12 Jun 2024 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718195835; x=1718800635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nEd1lRimO6iA7hWFaxTwTmIDTFIM9zKyp5vC+IWBdtc=;
        b=vYbsOqaEzZlBasd/GvXK1rWYSpXjl/Ze24acIjmejBwwMToa5KbSXC+F25tGiC3xCN
         lBhgKUK0cnDpBlHoAdP+kzECzKdL0z3Axx1PXl+BSP46P/Ryu93gattb4hJ72pBub2/y
         8tcNWqTyg/NKvE1+spzSBGdK16pDGukQRvLXSgHUuYOT4vqa0HOa0THCs2FWKC4M/L5S
         hbezP8xovmZd5qKqsdOWrULQa7FV/0UZKn9uVgNn1pZ9O3D7QKmlgk+iwbYHcyDbbhr4
         t8byJICMTFSXHN0Js8Ud9W4umvNwzX9QtiOHxm7j25ucKsRQm3RZAFHuf7pSVTZUzIdV
         I/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718195835; x=1718800635;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEd1lRimO6iA7hWFaxTwTmIDTFIM9zKyp5vC+IWBdtc=;
        b=sEqaGU7KBSxa4my6j+FLCJhCcYV8ZO0EXQW9SKIMKlWWoUVxAjFYbd/3JaGHRIMIwT
         AlRtkPEWJFt4h5OEmg7tpwDYRCi6ETCtWJAXk0tmGa4MBHCxaM458k8jD0UjvIcXbhqx
         6WkggvBeZb0c4MJBVEYe4BVNvPx3zHQdnwHa0YHBaqbl2ZacLaLFLclZOnW9UZqctHOY
         381O7SoY1oKstUDXtASAtD5rD2eixOP4DyRRI+OF3KXzht+kMafgDWRuajmkIIYVPOVu
         00Ltstc4wi4QZUPbQUO7uCbHZW9DvxR8i6p9gUjpFxoixOPsTNU6QHgirx9MSR6NJ80h
         TiOQ==
X-Gm-Message-State: AOJu0YxcmN5q3gUSXRfU4TTPn6PZA/WAijFS9mnSLivJDNrMXVU+y6Ue
	6mdnXq9YdBcWa2ySvBbXyqNFMvm7/7i18HOhgLe8eYJUH8xNOkk5JtNjl76x9ag+J7qAt2acJDb
	4v0ZS3ZO6JoQGX8XFT+rcA9lIJpu32lZDfujhN+f+riCd3cHJsvr3wO/eGMhMLBAb6NVt8O4QOy
	U7ltlvIklhGwigkQb9H63fCi8uSQ==
X-Google-Smtp-Source: AGHT+IEVEd5jIX4Keafg8R4USgdVVqa1WLn/DKKhLC/PSnKi3+qdd7tXQ2p5AsiVVO2UvMXbsp7enEkx
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:6403:b0:62c:c5ea:66ad with SMTP id
 00721157ae682-62fb847c4c0mr4792757b3.4.1718195834992; Wed, 12 Jun 2024
 05:37:14 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:37:11 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4718; i=ardb@kernel.org;
 h=from:subject; bh=OWIOh2L1bo96UhRQWj5TV3Q2gAHpb3WgG7hEvcb06P4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS1zWvnlz4mKa/6oxF6ufHovUy5u/bYZb5cfNenh3/PBa
 6fFOv8THaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiU/Yx/LP7Lx8edP9cVKPX
 zqItt3cf9O9relC06P7vDO3CWfZh1/8wMpzg1AiePOW9ROryoFrrXOtZs6SUIq6lsnafMvQyf/x JgR8A
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240612123710.177557-2-ardb+git@google.com>
Subject: [PATCH v2] x86/efi: Free EFI memory map only when installing a new one.
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Ashish Kalra <Ashish.Kalra@amd.com>, Dave Young <dyoung@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The logic in __efi_memmap_init() is shared between two different
execution flows:
- mapping the EFI memory map early or late into the kernel VA space, so
  that its entries can be accessed;
- cloning the EFI memory map in order to insert new entries that are
  created as a result of creating a memory reservation
  (efi_arch_mem_reserve())

In the former case, the underlying memory containing the kernel's view
of the EFI memory map (which may be heavily modified by the kernel
itself on x86) is not modified at all, and the only thing that changes
is the virtual mapping of this memory, which is different between early
and late boot.

In the latter case, an entirely new allocation is created that carries a
new, updated version of the kernel's view of the EFI memory map. When
installing this new version, the old version will no longer be
referenced, and if the memory was allocated by the kernel, it will leak
unless it gets freed.

The logic that implements this freeing currently lives on the code path
that is shared between these two use cases, but it should only apply to
the latter. So move it to the correct spot.

While at it, move __efi_memmap_free() into its only caller, and drop the
dummy definition for non-x86 architectures, as that is no longer needed.

Cc: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Fixes: f0ef6523475f ("efi: Fix efi_memmap_alloc() leaks")
Link: https://lore.kernel.org/all/36ad5079-4326-45ed-85f6-928ff76483d3@amd.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2:
- free old memory map only after installing the new one succeeded
- move __efi_memmap_free() into its only caller
- drop obsolete dummy declaration from generic code

 arch/x86/platform/efi/memmap.c | 38 +++++++++++---------
 drivers/firmware/efi/memmap.c  |  9 -----
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 4ef20b49eb5e..602386eead49 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -30,21 +30,6 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
 	return PFN_PHYS(page_to_pfn(p));
 }
 
-void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
-{
-	if (flags & EFI_MEMMAP_MEMBLOCK) {
-		if (slab_is_available())
-			memblock_free_late(phys, size);
-		else
-			memblock_phys_free(phys, size);
-	} else if (flags & EFI_MEMMAP_SLAB) {
-		struct page *p = pfn_to_page(PHYS_PFN(phys));
-		unsigned int order = get_order(size);
-
-		free_pages((unsigned long) page_address(p), order);
-	}
-}
-
 /**
  * efi_memmap_alloc - Allocate memory for the EFI memory map
  * @num_entries: Number of entries in the allocated map.
@@ -92,12 +77,33 @@ int __init efi_memmap_alloc(unsigned int num_entries,
  */
 int __init efi_memmap_install(struct efi_memory_map_data *data)
 {
+	unsigned long size = efi.memmap.desc_size * efi.memmap.nr_map;
+	unsigned long flags = efi.memmap.flags;
+	u64 phys = efi.memmap.phys_map;
+	int ret;
+
 	efi_memmap_unmap();
 
 	if (efi_enabled(EFI_PARAVIRT))
 		return 0;
 
-	return __efi_memmap_init(data);
+	ret = __efi_memmap_init(data);
+	if (ret)
+		return ret;
+
+	if (flags & EFI_MEMMAP_MEMBLOCK) {
+		if (slab_is_available())
+			memblock_free_late(phys, size);
+		else
+			memblock_phys_free(phys, size);
+	} else if (flags & EFI_MEMMAP_SLAB) {
+		struct page *p = pfn_to_page(PHYS_PFN(phys));
+		unsigned int order = get_order(size);
+
+		free_pages((unsigned long)page_address(p), order);
+	}
+
+	return 0;
 }
 
 /**
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 3365944f7965..34109fd86c55 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -15,10 +15,6 @@
 #include <asm/early_ioremap.h>
 #include <asm/efi.h>
 
-#ifndef __efi_memmap_free
-#define __efi_memmap_free(phys, size, flags) do { } while (0)
-#endif
-
 /**
  * __efi_memmap_init - Common code for mapping the EFI memory map
  * @data: EFI memory map data
@@ -51,11 +47,6 @@ int __init __efi_memmap_init(struct efi_memory_map_data *data)
 		return -ENOMEM;
 	}
 
-	if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
-		__efi_memmap_free(efi.memmap.phys_map,
-				  efi.memmap.desc_size * efi.memmap.nr_map,
-				  efi.memmap.flags);
-
 	map.phys_map = data->phys_map;
 	map.nr_map = data->size / data->desc_size;
 	map.map_end = map.map + data->size;
-- 
2.45.2.505.gda0bf45e8d-goog


