Return-Path: <linux-efi+bounces-1207-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC042905495
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 16:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD52B289326
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 14:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E3517F506;
	Wed, 12 Jun 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1pCr3jqP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C1180A9D
	for <linux-efi@vger.kernel.org>; Wed, 12 Jun 2024 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200606; cv=none; b=kfAE1uAkDCBO/mD4DW6UKOT52Btpo+myvt7DybMaPdEg6r+GSrlY7ArrhRMJ9yY1CxiT6T9vdSlnyVmbOv2tQM4MRC1JZnWutmZGW1A4YP5mgX+OCw7+HTMmWLTsSrtetqyMvM94mXkyzhQQUMJy4g7nrJD12yGxOPDHZOJox0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200606; c=relaxed/simple;
	bh=B9snKeq9ZRYgjq/H6UcbA2Jvzo4lG/FH93/9EA3J98Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KnK4JH0ts3UmntM4Et6UPLbrxYjiVAPNCA+zyROJiNnCmtFcslWba7JOjggc/Gb3jKHdwuLI2x6i1aCEpc86+K1vV/RpCPAN/0FqPbynzbbIWdo1hpX7dFyClVTHV90Ihf5cuqxEKtiI/QkM6fCdxDle0/7boICEEpl4P6B/IDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1pCr3jqP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4212a3ddb6bso19176355e9.2
        for <linux-efi@vger.kernel.org>; Wed, 12 Jun 2024 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718200603; x=1718805403; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EmGrnZgO3t8ZPnbrwHQ5qRX6BTJ4KO1P/NylSxAXYBg=;
        b=1pCr3jqPNAb7WhJmT/mQjBZVPOVQIPmIE1l26Ht4yjcJf34L3aWi4CBJBVHD4YTTO6
         yAtTcGWUJ03qrjW+Njwc7az4bGK4sqUMUOVB01d+yOIcHYnyz2vtgaYvuIPhVugRQmaY
         wDUV26/R6Q2zMABPy1Oirm68t+113xqzo2JyQwzJCSN/p5W4yi4ic+z966GJ/vVzBD+l
         Hx/Bwwq0Z+6D/VoVAUzZ93yMk3uDin7l/coCAV6OFYo7h2uPbUYz6FBraKxrXQSeNlnz
         pOflqjzoZ2sEIEKgEmXEXPxoIjloBEmd7aQ6nO6umOXa+Ijv9o1ViKS+DHrcG1rP3SXl
         YAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200603; x=1718805403;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmGrnZgO3t8ZPnbrwHQ5qRX6BTJ4KO1P/NylSxAXYBg=;
        b=Krhwyq/uMc8j/WdRlBashqKNVO8CmJK9F6cVJ1Kt9V7RJ3aXk1O2NodKxmXeY6uF+Y
         07rvkDC2kDWEwqnfFWpQ6A4nwZ46X4AUGhaACawaFp5bRxWj/Yj4TVU7HC5NUE4klWLk
         tDhioXQfdc3UxLIHq/jGJ3ZRTGQ/nGp0gGiwt/r7dayXNiV29kqZQ8Q9wVVSiesEV1T3
         kuUfdGCkcXGJAjZDCV5hZv/uDmrmAAOM3woVSBTH0IX2aHTxgHx+f41iS9BZ/dF1+u3D
         CEI8Ac9PPilN57XPXurIFUJPyHq2gtoRWNpjluZ464wLkK3le2wgkZNUsgRQOqIhEe5v
         GVTA==
X-Gm-Message-State: AOJu0Yz8IUwJqAdrfZjuaBD4TQw3/0c84aYNwU8dTZdc+bSKhbvl6uRf
	GQVMeW7L/QDsQg72RwltkeGm1CfPlSiMQN3bZiAyGaBHM1Bo2vWqbJNs5oRnTa4+vGBfOPgzRRm
	QlELW3fiARa9B0Z2mB/312Ctrk6i4t5mr5mtRvKFntUPVNYCEy78dtNOc37EmvEJ9P+QV7gdEto
	rtU9nSG+GHObCZBb6o4wwj5YBiOg==
X-Google-Smtp-Source: AGHT+IFsOJdefJuFx3+Pp8lvsrui/AUtgWCOEXQHIXTVg2yNTTD6iKVMIgE75EiXY5YO2gtti/sv7rZm
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3b87:b0:421:29c8:4ecb with SMTP id
 5b1f17b1804b1-422865ac153mr277195e9.4.1718200602509; Wed, 12 Jun 2024
 06:56:42 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:56:39 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4484; i=ardb@kernel.org;
 h=from:subject; bh=9nbCSSgNmzby1JSlEnWpnSGEjOMACQhq5RITLtxrX/A=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS1zpfgLpcp2b3bD2JvSNT9/TLN9PW3eYoGMywWa1x3On
 JO4tWdCRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiI+BqGv6JcvToXPPc5M52Z
 aWb5obptXsDCEvHAI7lTt+f271a5s5uR4eDp+GmSeQXpt/48lu+sVtrIXCPAupKvQKGradmXiEc P+AE=
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240612135638.298882-2-ardb+git@google.com>
Subject: [PATCH v3] x86/efi: Free EFI memory map only when installing a new one.
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
v3:
- don't move __efi_memmap_free() into what turned out not to be its only
  caller
- drop another CPP #define related to the dummy definition

v2:
- free old memory map only after installing the new one succeeded
- move __efi_memmap_free() into its only caller
- drop obsolete dummy declaration from generic code

 arch/x86/include/asm/efi.h     |  1 -
 arch/x86/platform/efi/memmap.c | 12 +++++++++++-
 drivers/firmware/efi/memmap.c  |  9 ---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 1dc600fa3ba5..481096177500 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -401,7 +401,6 @@ extern int __init efi_memmap_alloc(unsigned int num_entries,
 				   struct efi_memory_map_data *data);
 extern void __efi_memmap_free(u64 phys, unsigned long size,
 			      unsigned long flags);
-#define __efi_memmap_free __efi_memmap_free
 
 extern int __init efi_memmap_install(struct efi_memory_map_data *data);
 extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 4ef20b49eb5e..6ed1935504b9 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -92,12 +92,22 @@ int __init efi_memmap_alloc(unsigned int num_entries,
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
+	__efi_memmap_free(phys, size, flags);
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


