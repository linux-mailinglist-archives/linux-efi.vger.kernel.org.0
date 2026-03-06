Return-Path: <linux-efi+bounces-6261-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNMyOA/7qmmcZAEAu9opvQ
	(envelope-from <linux-efi+bounces-6261-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:04:31 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A03224860
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A7AF319E6D4
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441253EFD28;
	Fri,  6 Mar 2026 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQW5IGVQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D593EF0A6
	for <linux-efi@vger.kernel.org>; Fri,  6 Mar 2026 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812650; cv=none; b=tqrpVlwICkkWEc9TBJS2Z7Ph012EiIjxXeSq53Bxnv22SmwjHbr0CVy0mIhbjc8HB/ZTuUpQsdE4QpufLeL034a944tFhDiLhFl9JScInBocV3BNLp0sfob/YTOBFbZ5Im5YL+eIwu05VM+VVEkUQVt7ZLP3aRiO0kA79RfVQSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812650; c=relaxed/simple;
	bh=AcDvV7hr6f9ZvnKPw0LOtcj7T7Cb7fyegl+5ztfQwus=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PrIFvxLSHNByOC0biJ/e8W9jDRU3MA9DBQ1+0JrCbIzqLR8ZOIby47bOGEaPTW9/o6tHH28UZA4y0ikHVv+ptGKTa5E9Qz0qw4UM0Q4kR0tjM4AJrZCQAzx74UZAj37dvypRen2R8fxsc17WkFJ+Sko/K1JvumYxS485cvAYNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQW5IGVQ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837246211bso121720625e9.0
        for <linux-efi@vger.kernel.org>; Fri, 06 Mar 2026 07:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772812646; x=1773417446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUL+2jwG2aYHm6Demo1pooALvVPYq2HBm66gmXpaBJo=;
        b=FQW5IGVQf2ZFh4X01lzvzWfVEzp+LdaXq+cYhSncdw1YWLHQWl97i4rgozfuIh4YYv
         Z3vKsRY/7Ky2/Ex0YE1QNkaSKY3KjPa2QSvvtq80G8+wNtcCtfohmBRaqddhnz5hrZsW
         ADN5bUXPhUJyJxLPTfyEHTI5seFQ9Hnkps115oWbo1dMLRQPWkPL1faiYf6MoakAv9kN
         0wGia21ON+HcbvwNF4ekYD8rHdPiukgNZcSEn2dqnSjJYfuay7i04bNx3VxqAR3v1JFT
         c2n8LNoHQxlv5cJ8BhTCjz5EPXdQdA5PNCCWPYBe8yw2lcTZVw4jZyrzCsY+bJHQvyd4
         GLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812646; x=1773417446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUL+2jwG2aYHm6Demo1pooALvVPYq2HBm66gmXpaBJo=;
        b=ZZN2UPvxNdG7d/u7GuXvl32Rqkm10kbl6/2zd48aYvhexOwQSP7U6hu4jDntkPShvB
         bTU+X9QBvCVlFNxMpF/7Klfg0yQEgLBezSd/0bUPzkh4XkmdDaK5GpsNKIcwTxQlJvC2
         Wv2EQX6SZe9YoK+e8EquDKv/TErSoqNfO1tnGb5Gso9uVhpRN52uMwYZTkKQvPqQSEnP
         cwokw90MqVhL8Rv5ebNLffW8tH4UtbOhKzo8VF6exzzT6xtUKz+4lHfsR0A/W9pgh6VM
         PilVua1w7ayle0olzdIIwUz61y+Gb5czuu6VcccOtRP5ZOJF0WOiM/GJzXFSixw9SykL
         /28Q==
X-Gm-Message-State: AOJu0YwbeOiAfk+fPPFW/tr5XHyc6kGrvW34IELU9SJA3rTciRDvkZH4
	Zf0V6VrZDWZupE9DBe9B8cpOQr9H1w78TahBaNjzZaIVSDpZTRH6Y6QKpQ8++LHnaLunyhyqiQ=
	=
X-Received: from wmqn19.prod.google.com ([2002:a05:600c:4f93:b0:483:a1ee:5eb8])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6386:b0:483:afbb:a064
 with SMTP id 5b1f17b1804b1-48526918f7fmr47374065e9.1.1772812646554; Fri, 06
 Mar 2026 07:57:26 -0800 (PST)
Date: Fri,  6 Mar 2026 16:57:12 +0100
In-Reply-To: <20260306155703.815272-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306155703.815272-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7331; i=ardb@kernel.org;
 h=from:subject; bh=QVcwFSJX1AHsu94pZJ2sqfnsDGPzuZFlAdmjpouGCM8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXPVz5DtH4KtmL+Fv049n8IrOol/LaPi4kWK13kXHbqUu
 u5l2JGUjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCR1lCG//Xrp1YwPzPlEF+w
 bhPjwt3X3+6/IOQ0J+FTZFep6et3Tj8ZGT4c0r0veCXzoYicc2ntltM/z8jm9gUk5fK+SbOtMVx YywAA
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306155703.815272-20-ardb+git@google.com>
Subject: [RFC PATCH 7/9] x86/efi: Reuse memory map instead of reallocating it
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 74A03224860
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6261-lists,linux-efi=lfdr.de,git];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@google.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.931];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

The EFI memory map consists of 10s to 100s of entries of around 40 bytes
each. The initial version is allocated and populated by the EFI stub,
but later on, after freeing the boot services data regions and pruning
the associated entries, a new memory map is allocated with room for only
the remaining entries, which are typically much fewer in number.

Given that the original allocation is never freed, this does not
actually save any memory, and it is much simpler to just move the
entries that need to be preserved to the beginning of the map, and to
truncate it. That way, a lot of the complicated memory map allocation
and freeing code can simply be dropped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h     |  3 -
 arch/x86/platform/efi/memmap.c | 83 +-------------------
 arch/x86/platform/efi/quirks.c | 30 +++----
 include/linux/efi.h            |  2 -
 4 files changed, 10 insertions(+), 108 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index b01dd639bf62..ec352a8f6e7a 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -392,9 +392,6 @@ static inline void efi_reserve_boot_services(void)
 }
 #endif /* CONFIG_EFI */
 
-extern int __init efi_memmap_alloc(unsigned int num_entries,
-				   struct efi_memory_map_data *data);
-
 extern int __init efi_memmap_install(struct efi_memory_map_data *data);
 
 extern enum efi_secureboot_mode __x86_ima_efi_boot_mode(void);
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 8ef45014c7e7..951a90235abb 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -8,78 +8,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/efi.h>
-#include <linux/io.h>
-#include <asm/early_ioremap.h>
 #include <asm/efi.h>
-#include <linux/memblock.h>
-#include <linux/slab.h>
-
-static phys_addr_t __init __efi_memmap_alloc_early(unsigned long size)
-{
-	return memblock_phys_alloc(size, SMP_CACHE_BYTES);
-}
-
-static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
-{
-	unsigned int order = get_order(size);
-	struct page *p = alloc_pages(GFP_KERNEL, order);
-
-	if (!p)
-		return 0;
-
-	return PFN_PHYS(page_to_pfn(p));
-}
-
-static
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
-		__free_pages(p, order);
-	}
-}
-
-/**
- * efi_memmap_alloc - Allocate memory for the EFI memory map
- * @num_entries: Number of entries in the allocated map.
- * @data: efi memmap installation parameters
- *
- * Depending on whether mm_init() has already been invoked or not,
- * either memblock or "normal" page allocation is used.
- *
- * Returns zero on success, a negative error code on failure.
- */
-int __init efi_memmap_alloc(unsigned int num_entries,
-		struct efi_memory_map_data *data)
-{
-	/* Expect allocation parameters are zero initialized */
-	WARN_ON(data->phys_map || data->size);
-
-	data->size = num_entries * efi.memmap.desc_size;
-	data->desc_version = efi.memmap.desc_version;
-	data->desc_size = efi.memmap.desc_size;
-	data->flags &= ~(EFI_MEMMAP_SLAB | EFI_MEMMAP_MEMBLOCK);
-	data->flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
-
-	if (slab_is_available()) {
-		data->flags |= EFI_MEMMAP_SLAB;
-		data->phys_map = __efi_memmap_alloc_late(data->size);
-	} else {
-		data->flags |= EFI_MEMMAP_MEMBLOCK;
-		data->phys_map = __efi_memmap_alloc_early(data->size);
-	}
-
-	if (!data->phys_map)
-		return -ENOMEM;
-	return 0;
-}
 
 /**
  * efi_memmap_install - Install a new EFI memory map in efi.memmap
@@ -93,20 +22,10 @@ int __init efi_memmap_alloc(unsigned int num_entries,
  */
 int __init efi_memmap_install(struct efi_memory_map_data *data)
 {
-	unsigned long size = efi.memmap.desc_size * efi.memmap.nr_map;
-	unsigned long flags = efi.memmap.flags;
-	u64 phys = efi.memmap.phys_map;
-	int ret;
-
 	efi_memmap_unmap();
 
 	if (efi_enabled(EFI_PARAVIRT))
 		return 0;
 
-	ret = __efi_memmap_init(data);
-	if (ret)
-		return ret;
-
-	__efi_memmap_free(phys, size, flags);
-	return 0;
+	return __efi_memmap_init(data);
 }
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 8a4a0c6b64bc..5bf97376c1a0 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -359,12 +359,15 @@ static struct efi_freeable_range *ranges_to_free;
 
 void __init efi_unmap_boot_services(void)
 {
-	struct efi_memory_map_data data = { 0 };
+	struct efi_memory_map_data data = {
+		.phys_map	= efi.memmap.phys_map,
+		.desc_version	= efi.memmap.desc_version,
+		.desc_size	= efi.memmap.desc_size,
+	};
 	efi_memory_desc_t *md;
-	int num_entries = 0;
+	void *new_md;
 	int idx = 0;
 	size_t sz;
-	void *new, *new_md;
 
 	/* Keep all regions for /sys/kernel/debug/efi */
 	if (efi_enabled(EFI_DBG))
@@ -377,6 +380,7 @@ void __init efi_unmap_boot_services(void)
 		return;
 	}
 
+	new_md = efi.memmap.map;
 	for_each_efi_memory_desc(md) {
 		unsigned long long start = md->phys_addr;
 		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
@@ -384,7 +388,6 @@ void __init efi_unmap_boot_services(void)
 
 		if (md->type != EFI_BOOT_SERVICES_CODE &&
 		    md->type != EFI_BOOT_SERVICES_DATA) {
-			num_entries++;
 			continue;
 		}
 
@@ -397,7 +400,6 @@ void __init efi_unmap_boot_services(void)
 
 		/* Do not free, someone else owns it: */
 		if (md->attribute & EFI_MEMORY_RUNTIME) {
-			num_entries++;
 			continue;
 		}
 
@@ -432,26 +434,12 @@ void __init efi_unmap_boot_services(void)
 		idx++;
 	}
 
-	if (!num_entries)
-		return;
-
-	if (efi_memmap_alloc(num_entries, &data) != 0) {
-		pr_err("Failed to allocate new EFI memmap\n");
-		return;
-	}
-
-	new = memremap(data.phys_map, data.size, MEMREMAP_WB);
-	if (!new) {
-		pr_err("Failed to map new EFI memmap\n");
-		return;
-	}
-
 	/*
 	 * Build a new EFI memmap that excludes any boot services
 	 * regions that are not tagged EFI_MEMORY_RUNTIME, since those
 	 * regions have now been freed.
 	 */
-	new_md = new;
+	new_md = efi.memmap.map;
 	for_each_efi_memory_desc(md) {
 		if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
 		    (md->type == EFI_BOOT_SERVICES_CODE ||
@@ -466,7 +454,7 @@ void __init efi_unmap_boot_services(void)
 		new_md += efi.memmap.desc_size;
 	}
 
-	memunmap(new);
+	data.size = new_md - efi.memmap.map;
 
 	if (efi_memmap_install(&data) != 0) {
 		pr_err("Could not install new EFI memmap\n");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 664898d09ff5..dbf5971dd1c5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -572,8 +572,6 @@ struct efi_memory_map {
 	unsigned long desc_version;
 	unsigned long desc_size;
 #define EFI_MEMMAP_LATE (1UL << 0)
-#define EFI_MEMMAP_MEMBLOCK (1UL << 1)
-#define EFI_MEMMAP_SLAB (1UL << 2)
 	unsigned long flags;
 };
 
-- 
2.53.0.473.g4a7958ca14-goog


