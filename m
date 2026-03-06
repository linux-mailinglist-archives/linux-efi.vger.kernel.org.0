Return-Path: <linux-efi+bounces-6262-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFI5HTT6qmmcZAEAu9opvQ
	(envelope-from <linux-efi+bounces-6262-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:00:52 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6CA22473B
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A30D530AB64A
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA05C3F0749;
	Fri,  6 Mar 2026 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXc1BGKG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6553EF0BB
	for <linux-efi@vger.kernel.org>; Fri,  6 Mar 2026 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812650; cv=none; b=NuCe8tL+H+n81XvcWxaMr/jor0CXMf1AOcIZkNufmNiPdVyCPsxhoTPyQb7m0QcrwspFYtoIYbZnBMwyU/1ZwZg2vSUIucEz3QaVLVhU7kwhffysajFY57q373i7o+uLyU4r6UyGt1e36NEzPEv54bzP5UcSC62yxjKmEkT1ew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812650; c=relaxed/simple;
	bh=5zd9SfMdyJBxjHTVPHqLum9qpDstlixyq0HqoJ8o+18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uRmYLuz2MBF0xd2atUQhqY93ihNEhNi1uHDb4HbIaRmionmDVJTgJd2RiRxYdVpE3n3vr7AIhbCtUcIG1P1X37OgR7SRbemCoGZEj6Gy3ylCKgDzzftl+rW3hot1W5rMJx5pR+hk/3S5/rOu64Xo4/BHuwMKGLj5fhbLJ8rkV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hXc1BGKG; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4830e7c6131so97821095e9.2
        for <linux-efi@vger.kernel.org>; Fri, 06 Mar 2026 07:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772812647; x=1773417447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmprDLEjUjr/uUOMNaPL1M9LRCd51D3rl5+x6D9Z3Tc=;
        b=hXc1BGKGk3kg30wOKdG6sGnzeP6AxG6uFxinPrNC15DNbRcu7QBTclzsiM9za00Zxm
         YFZzwI9vZK/A7SzFIyDG7ipB/tqNGt5+/ayfTH+TVPpl9u1YiDyqNfXzbyixpfwbkngw
         9jl8mvnLy/faVfXNZFf5wl/CU93TzjC+fV0lAJW/ZTRvvaTgKMqPKZAelFo5SWImIf4h
         3Ao/2wpo3LzRp3jLP76hANEoIiWlDi1Sg5tHPBeaxrVyDnQzwUzuz8/oaOkuseqn+11V
         TYkqUCcir0tFqfT+qJnK33J3jFXCwlncHKe6gc/BOXSau6dbIbvD55nNWRLugx64xnKf
         fqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812647; x=1773417447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmprDLEjUjr/uUOMNaPL1M9LRCd51D3rl5+x6D9Z3Tc=;
        b=cbqp+mpG8NY9YPb1Q+sNzTjWk9ygQSQ581LitahohRr9dk3F6d+cpk+Wys38jtjkZq
         QpzwcLi+3pcEtNykAkHHLpk8qnNQE+0NXgQhiIwIkTBYUSZzUqvby+ZGR/C0y+dwpPco
         bd271HZ3ajWuMY8qFUuH8GoW2RVQO3d/bLsIu0Z8wlsTxuB0ITXLhSrUeSXh7nlv84su
         mNDcg4tmA8keZQk4P9uSE5N+mU+oxc4NQ9j2MoFLbeNIVBooUkzMCwNm+mDBI1yo8tyU
         Wj51c1nX7eCWKRq11BpoekHwZdFcNG87fzrZ66Gtys7k/yEEh8RsgBcbRYF6Rce7XHxD
         W4nA==
X-Gm-Message-State: AOJu0YzjlaRoettbnYpPp6crbeVFgHUiV7Dcem7K7H5pzpEQpC9zwRvq
	ATWT+NTjrKcH1FTIrvMiutu0BMQrKxUWMRtvC/ZHemnYxREvHPPxGNuBe7Xj4Zt2y/7oAhPHNQ=
	=
X-Received: from wmjy24.prod.google.com ([2002:a7b:cd98:0:b0:485:2ab7:1775])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a0d:b0:485:1878:7b8c
 with SMTP id 5b1f17b1804b1-4852695b6fcmr41463395e9.18.1772812647341; Fri, 06
 Mar 2026 07:57:27 -0800 (PST)
Date: Fri,  6 Mar 2026 16:57:13 +0100
In-Reply-To: <20260306155703.815272-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306155703.815272-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6680; i=ardb@kernel.org;
 h=from:subject; bh=hw+BPkyMQz0wZCk+FdNvJtlzl9MRgrvosyieBfbdoWE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXPVz5AK78klujLeSpYr56mwCLXJ25x16v/zJv7DZZ9vJ
 Qbmz/d2lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlwVzEy9M5Ouli1S+Zvi19s
 yIccya9X5r745Px09bad9z0v8Hg5zWP4K6LQvOKg4knf4z9Lb5yOW6NelXjz6RyHc2EsZ7b1vQu vZQAA
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306155703.815272-21-ardb+git@google.com>
Subject: [RFC PATCH 8/9] x86/efi: Defer compaction of the EFI memory map
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EE6CA22473B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6262-lists,linux-efi=lfdr.de,git];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@google.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.932];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

Currently, the EFI memory map is compacted early at boot, to leave only
the entries that are significant to the current kernel or potentially a
kexec'ed kernel that comes after, and to suppress all boot services code
and data entries that have no correspondence with anything that either
the firmware or the kernel treats as reserved for firmware use.

Given that actually freeing those regions to the page allocator is not
possible yet at this point, those suppressed entries are converted into
yet another type of temporary memory reservation map, and freed during
an arch_initcall(), which is the earliest convenient time to actually
perform this operation.

Given that compacting the memory map does not need to occur that early
to begin with, move it to the arch_initcall(). This removes the need for
the special memory reservation map, as the entries still exist at this
point, and can be consulted directly to decide whether they need to be
preserved in their entirety or only partially.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/quirks.c | 130 +++++++-------------
 1 file changed, 46 insertions(+), 84 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 5bf97376c1a0..d7a64b404bea 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -350,37 +350,10 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
 		pr_err("Failed to unmap VA mapping for 0x%llx\n", va);
 }
 
-struct efi_freeable_range {
-	u64 start;
-	u64 end;
-};
-
-static struct efi_freeable_range *ranges_to_free;
-
 void __init efi_unmap_boot_services(void)
 {
-	struct efi_memory_map_data data = {
-		.phys_map	= efi.memmap.phys_map,
-		.desc_version	= efi.memmap.desc_version,
-		.desc_size	= efi.memmap.desc_size,
-	};
 	efi_memory_desc_t *md;
-	void *new_md;
-	int idx = 0;
-	size_t sz;
 
-	/* Keep all regions for /sys/kernel/debug/efi */
-	if (efi_enabled(EFI_DBG))
-		return;
-
-	sz = sizeof(*ranges_to_free) * efi.memmap.nr_map + 1;
-	ranges_to_free = kzalloc(sz, GFP_KERNEL);
-	if (!ranges_to_free) {
-		pr_err("Failed to allocate storage for freeable EFI regions\n");
-		return;
-	}
-
-	new_md = efi.memmap.map;
 	for_each_efi_memory_desc(md) {
 		unsigned long long start = md->phys_addr;
 		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
@@ -394,15 +367,10 @@ void __init efi_unmap_boot_services(void)
 		/*
 		 * Before calling set_virtual_address_map(), EFI boot services
 		 * code/data regions were mapped as a quirk for buggy firmware.
-		 * Unmap them from efi_pgd before freeing them up.
+		 * Unmap them from efi_pgd, they will be freed later.
 		 */
 		efi_unmap_pages(md);
 
-		/* Do not free, someone else owns it: */
-		if (md->attribute & EFI_MEMORY_RUNTIME) {
-			continue;
-		}
-
 		/*
 		 * Nasty quirk: if all sub-1MB memory is used for boot
 		 * services, we can get here without having allocated the
@@ -416,49 +384,14 @@ void __init efi_unmap_boot_services(void)
 		 * this happened, but Linux should still try to boot rather
 		 * panicking early.)
 		 */
-		rm_size = real_mode_size_needed();
+		rm_size = PAGE_ALIGN(real_mode_size_needed());
 		if (rm_size && (start + rm_size) < (1<<20) && size >= rm_size) {
 			set_real_mode_mem(start);
-			start += rm_size;
-			size -= rm_size;
-		}
-
-		/*
-		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT parts of the memory
-		 * map are still not initialized and we can't reliably free
-		 * memory here.
-		 * Queue the ranges to free at a later point.
-		 */
-		ranges_to_free[idx].start = start;
-		ranges_to_free[idx].end = start + size;
-		idx++;
-	}
 
-	/*
-	 * Build a new EFI memmap that excludes any boot services
-	 * regions that are not tagged EFI_MEMORY_RUNTIME, since those
-	 * regions have now been freed.
-	 */
-	new_md = efi.memmap.map;
-	for_each_efi_memory_desc(md) {
-		if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
-		    (md->type == EFI_BOOT_SERVICES_CODE ||
-		     md->type == EFI_BOOT_SERVICES_DATA) &&
-		    !e820__mapped_any(md->phys_addr,
-				      md->phys_addr + md->num_pages * EFI_PAGE_SIZE,
-				      E820_TYPE_RESERVED)) {
-			continue;
+			/* Remove the allocated space from the descriptor */
+			md->phys_addr += rm_size;
+			md->num_pages -= rm_size / EFI_PAGE_SIZE;
 		}
-
-		memcpy(new_md, md, efi.memmap.desc_size);
-		new_md += efi.memmap.desc_size;
-	}
-
-	data.size = new_md - efi.memmap.map;
-
-	if (efi_memmap_install(&data) != 0) {
-		pr_err("Could not install new EFI memmap\n");
-		return;
 	}
 }
 
@@ -498,24 +431,53 @@ efi_free_unreserved_subregions(u64 range_start, u64 range_end)
 
 static int __init efi_free_boot_services(void)
 {
-	struct efi_freeable_range *range = ranges_to_free;
+	struct efi_memory_map_data data = {
+		.phys_map	= efi.memmap.phys_map,
+		.desc_version	= efi.memmap.desc_version,
+		.desc_size	= efi.memmap.desc_size,
+	};
 	unsigned long freed = 0;
+	efi_memory_desc_t *md;
+	void *new_md;
 
-	if (!ranges_to_free)
+	/* Keep all regions for /sys/kernel/debug/efi */
+	if (efi_enabled(EFI_DBG))
 		return 0;
 
-	while (range->start) {
-		/*
-		 * Don't free memory under 1M for two reasons:
-		 * - BIOS might clobber it
-		 * - Crash kernel needs it to be reserved
-		 */
-		u64 start = max(range->start, SZ_1M);
+	new_md = efi.memmap.map;
+	for_each_efi_memory_desc(md) {
+		u64 md_start = max(md->phys_addr, SZ_1M);
+		u64 md_end = md->phys_addr + md->num_pages * EFI_PAGE_SIZE;
+		bool preserve_entry = true;
+
+		if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
+		    (md->type == EFI_BOOT_SERVICES_CODE ||
+		     md->type == EFI_BOOT_SERVICES_DATA)) {
+			u64 f = efi_free_unreserved_subregions(md_start, md_end);
+
+			/*
+			 * Omit the memory map entry of this region only if it
+			 * has been freed entirely. This ensures that boot data
+			 * regions for things like ESRT and BGRT tables carry
+			 * over correctly during kexec.
+			 */
+			if (f == md_end - md_start)
+				preserve_entry = false;
+
+			freed += f;
+		}
 
-		freed += efi_free_unreserved_subregions(start, range->end);
-		range++;
+		if (preserve_entry) {
+			if (new_md != md)
+				memcpy(new_md, md, efi.memmap.desc_size);
+			new_md += efi.memmap.desc_size;
+		}
 	}
-	kfree(ranges_to_free);
+
+	data.size = new_md - efi.memmap.map;
+
+	if (efi_memmap_install(&data) != 0)
+		pr_err("Could not install new EFI memmap\n");
 
 	if (freed)
 		pr_info("Freeing EFI boot services memory: %ldK\n", freed / SZ_1K);
-- 
2.53.0.473.g4a7958ca14-goog


