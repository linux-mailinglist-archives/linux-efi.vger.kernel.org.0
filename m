Return-Path: <linux-efi+bounces-6258-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH+NElf7qmnlZAEAu9opvQ
	(envelope-from <linux-efi+bounces-6258-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:05:43 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA1922489B
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEBFD3130AAF
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619913EDAAE;
	Fri,  6 Mar 2026 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRbIXEoy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCB33ECBE2
	for <linux-efi@vger.kernel.org>; Fri,  6 Mar 2026 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812646; cv=none; b=DW5yR5r+YJGNhuPkoIyIRlzxmHeon8DLNMLvvPtXOj+IYTH3HHk9A+1qZ2R5mlmTCbzyfw2zT65jCQw+j70ZlMpQ4ZM5psSEwZIv/PtlMUb/+pmIRSjfuMm3o00ix/nGqoHVNKHQJxR09zhVgzbjHUp+BZw3Klo41iVB5TR+mTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812646; c=relaxed/simple;
	bh=vTYAQNY3Wjeqjeo20q+YJOZUG2bhyt1rtftQ4oTgN3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TTXrms6tPraUHece5o3HEF4E8Zi2Kxe29o88OqFiOkwRpckIEzYgC0RIOnDidFSi4ooX7+JeAL5gnayA45k2Ru+YMcOExIdTyy9whu62X0NW8SVLoLAzbrGOeeNpbe9RZBQVmLofFT9n+sP0bd6WSqP+tKYSjCpB/nMIlQrAG8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gRbIXEoy; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48378c4a79fso82100695e9.0
        for <linux-efi@vger.kernel.org>; Fri, 06 Mar 2026 07:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772812643; x=1773417443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NjiQWvjHyJpWfWYstxbrMEc+P5m9/w7Dl080OfHlOyk=;
        b=gRbIXEoy84Bt1G0Zz0/DFp4oHtmlb60j11I4nM1NiVYrkZLkoVg/piS8yhazyVFoxW
         dUMu2BY1O7aZJ/V+SEtwNuw6J3VpzueDVJpGgdEp9X/cFPcr8gsXNbgzbZtVaP2Pu3xN
         yLWV6BFN+W9UY8bg+MXfSdck6wAafdo25ujcGjF6PilmfuYTMlETMPgX8S2W2gT3TyYl
         7au1xd4VWbjkjG9dFbw0Lg39R1kB5prPAt++zt1uDy8QrtG7lSHrQP5MTJoTJgqFdy//
         dLkWXnjhe8G8O5QjkYZ8eZScfAvH0nQtMdx3gyOg1aqVSrd5x5IVCEGz09O85zN0H9+1
         BWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812643; x=1773417443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NjiQWvjHyJpWfWYstxbrMEc+P5m9/w7Dl080OfHlOyk=;
        b=hW/+saipY0AvhTRuAkdJbdzpZREy2jRBxuVboHd45J9PciBZD/3CPvI6o+yCiyGDks
         ZuaBNh0TT4a058h0XUoK4k/JPOGD24ebylHw2DBN2DExqAIXV0yqpFVg7fA2o/l0hxRg
         +jko0kDdfCrpFIaZaN8WhIS0VDAB6jkDgxJMSCy5xcsje/WEz8cIF0SbV0JrvpUlKUIP
         Oqy9PkctVFjzwSGm9r9JbzIlakXpbnEloejpuUHPOcfw3LF0eR7xL7GM//riBFsIxiSv
         73hd89jI+YcXjEnaE/YJyl+eS80+Hc9xuNv+JDjgl5rLqNDh0yBclWic1bJPXI3H9Rb+
         aCtw==
X-Gm-Message-State: AOJu0YwdQpWsD9mRXeCdtvRjnggV7YsYkHBD0CTm2rGek+jccl0jKiUl
	7w2SPVyNTRhCqDt7UzeOqyC/w37/SE3eUap6BoOY4a7EyjX7QFedmNj/HDQGF5plZaVpeNdHoA=
	=
X-Received: from wmbjw13.prod.google.com ([2002:a05:600c:574d:b0:483:a1ee:5eca])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:46d1:b0:483:6de6:37ad
 with SMTP id 5b1f17b1804b1-48526979684mr44974755e9.34.1772812643044; Fri, 06
 Mar 2026 07:57:23 -0800 (PST)
Date: Fri,  6 Mar 2026 16:57:09 +0100
In-Reply-To: <20260306155703.815272-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306155703.815272-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7836; i=ardb@kernel.org;
 h=from:subject; bh=lQHAoieqpClT33fFpHsqU6z28LZv8gyQTPoLL65HPCg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXPVzyCnjv6fdztblIPX2TjtdfhyR3Huc70LN66HFBsox
 zadkf7bUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACby7wDD/0LZinPdbTf1/4jk
 OO8J/dW59ET71u8LGTaf3eOQZm3usZ+R4aL0lS87rnIebVb7vNpTaHal2dWJQnsO7tdQVtH6UzQ niQcA
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306155703.815272-17-ardb+git@google.com>
Subject: [PATCH 4/4] x86/efi: Omit kernel reservations of boot services memory
 from memmap
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DBA1922489B
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
	TAGGED_FROM(0.00)[bounces-6258-lists,linux-efi=lfdr.de,git];
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
	NEURAL_HAM(-0.00)[-0.933];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

Now that efi_mem_reserve() has been updated to rely on RSRV_KERN
memblock reservations, it is no longer needed to mark memblock reserved
regions as EFI_MEMORY_RUNTIME. This means that it is no longer needed to
split existing entries in the EFI memory map, removing the need to
re-allocate/copy/remap the entire EFI memory map on every call to
efi_mem_reserve().

So drop this functionality - it is no longer needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h     |   4 -
 arch/x86/platform/efi/memmap.c | 138 --------------------
 arch/x86/platform/efi/quirks.c |  54 --------
 3 files changed, 196 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 51b4cdbea061..b01dd639bf62 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -396,10 +396,6 @@ extern int __init efi_memmap_alloc(unsigned int num_entries,
 				   struct efi_memory_map_data *data);
 
 extern int __init efi_memmap_install(struct efi_memory_map_data *data);
-extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
-					 struct range *range);
-extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
-				     void *buf, struct efi_mem_range *mem);
 
 extern enum efi_secureboot_mode __x86_ima_efi_boot_mode(void);
 
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 023697c88910..8ef45014c7e7 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -110,141 +110,3 @@ int __init efi_memmap_install(struct efi_memory_map_data *data)
 	__efi_memmap_free(phys, size, flags);
 	return 0;
 }
-
-/**
- * efi_memmap_split_count - Count number of additional EFI memmap entries
- * @md: EFI memory descriptor to split
- * @range: Address range (start, end) to split around
- *
- * Returns the number of additional EFI memmap entries required to
- * accommodate @range.
- */
-int __init efi_memmap_split_count(efi_memory_desc_t *md, struct range *range)
-{
-	u64 m_start, m_end;
-	u64 start, end;
-	int count = 0;
-
-	start = md->phys_addr;
-	end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
-
-	/* modifying range */
-	m_start = range->start;
-	m_end = range->end;
-
-	if (m_start <= start) {
-		/* split into 2 parts */
-		if (start < m_end && m_end < end)
-			count++;
-	}
-
-	if (start < m_start && m_start < end) {
-		/* split into 3 parts */
-		if (m_end < end)
-			count += 2;
-		/* split into 2 parts */
-		if (end <= m_end)
-			count++;
-	}
-
-	return count;
-}
-
-/**
- * efi_memmap_insert - Insert a memory region in an EFI memmap
- * @old_memmap: The existing EFI memory map structure
- * @buf: Address of buffer to store new map
- * @mem: Memory map entry to insert
- *
- * It is suggested that you call efi_memmap_split_count() first
- * to see how large @buf needs to be.
- */
-void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
-			      struct efi_mem_range *mem)
-{
-	u64 m_start, m_end, m_attr;
-	efi_memory_desc_t *md;
-	u64 start, end;
-	void *old, *new;
-
-	/* modifying range */
-	m_start = mem->range.start;
-	m_end = mem->range.end;
-	m_attr = mem->attribute;
-
-	/*
-	 * The EFI memory map deals with regions in EFI_PAGE_SIZE
-	 * units. Ensure that the region described by 'mem' is aligned
-	 * correctly.
-	 */
-	if (!IS_ALIGNED(m_start, EFI_PAGE_SIZE) ||
-	    !IS_ALIGNED(m_end + 1, EFI_PAGE_SIZE)) {
-		WARN_ON(1);
-		return;
-	}
-
-	for (old = old_memmap->map, new = buf;
-	     old < old_memmap->map_end;
-	     old += old_memmap->desc_size, new += old_memmap->desc_size) {
-
-		/* copy original EFI memory descriptor */
-		memcpy(new, old, old_memmap->desc_size);
-		md = new;
-		start = md->phys_addr;
-		end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
-
-		if (m_start <= start && end <= m_end)
-			md->attribute |= m_attr;
-
-		if (m_start <= start &&
-		    (start < m_end && m_end < end)) {
-			/* first part */
-			md->attribute |= m_attr;
-			md->num_pages = (m_end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-			/* latter part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_end + 1;
-			md->num_pages = (end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-		}
-
-		if ((start < m_start && m_start < end) && m_end < end) {
-			/* first part */
-			md->num_pages = (m_start - md->phys_addr) >>
-				EFI_PAGE_SHIFT;
-			/* middle part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->attribute |= m_attr;
-			md->phys_addr = m_start;
-			md->num_pages = (m_end - m_start + 1) >>
-				EFI_PAGE_SHIFT;
-			/* last part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_end + 1;
-			md->num_pages = (end - m_end) >>
-				EFI_PAGE_SHIFT;
-		}
-
-		if ((start < m_start && m_start < end) &&
-		    (end <= m_end)) {
-			/* first part */
-			md->num_pages = (m_start - md->phys_addr) >>
-				EFI_PAGE_SHIFT;
-			/* latter part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_start;
-			md->num_pages = (end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-			md->attribute |= m_attr;
-		}
-	}
-}
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index af766694f7ee..8d2bfbd3a0ce 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -239,63 +239,9 @@ EXPORT_SYMBOL_GPL(efi_query_variable_store);
  * buggy implementations we reserve boot services region during EFI
  * init and make sure it stays executable. Then, after
  * SetVirtualAddressMap(), it is discarded.
- *
- * However, some boot services regions contain data that is required
- * by drivers, so we need to track which memory ranges can never be
- * freed. This is done by tagging those regions with the
- * EFI_MEMORY_RUNTIME attribute.
- *
- * Any driver that wants to mark a region as reserved must use
- * efi_mem_reserve() which will insert a new EFI memory descriptor
- * into efi.memmap (splitting existing regions if necessary) and tag
- * it with EFI_MEMORY_RUNTIME.
  */
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 {
-	struct efi_memory_map_data data = { 0 };
-	struct efi_mem_range mr;
-	efi_memory_desc_t md;
-	int num_entries;
-	void *new;
-
-	if (efi_mem_desc_lookup(addr, &md) ||
-	    md.type != EFI_BOOT_SERVICES_DATA) {
-		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
-		return;
-	}
-
-	if (addr + size > md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT)) {
-		pr_err("Region spans EFI memory descriptors, %pa\n", &addr);
-		return;
-	}
-
-	size += addr % EFI_PAGE_SIZE;
-	size = round_up(size, EFI_PAGE_SIZE);
-	addr = round_down(addr, EFI_PAGE_SIZE);
-
-	mr.range.start = addr;
-	mr.range.end = addr + size - 1;
-	mr.attribute = md.attribute | EFI_MEMORY_RUNTIME;
-
-	num_entries = efi_memmap_split_count(&md, &mr.range);
-	num_entries += efi.memmap.nr_map;
-
-	if (efi_memmap_alloc(num_entries, &data) != 0) {
-		pr_err("Could not allocate boot services memmap\n");
-		return;
-	}
-
-	new = early_memremap_prot(data.phys_map, data.size,
-				  pgprot_val(pgprot_encrypted(FIXMAP_PAGE_NORMAL)));
-	if (!new) {
-		pr_err("Failed to map new boot services memmap\n");
-		return;
-	}
-
-	efi_memmap_insert(&efi.memmap, new, &mr);
-	early_memunmap(new, data.size);
-
-	efi_memmap_install(&data);
 	e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
 	e820__update_table(e820_table);
 }
-- 
2.53.0.473.g4a7958ca14-goog


