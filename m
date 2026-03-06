Return-Path: <linux-efi+bounces-6260-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICTRCBf6qmmcZAEAu9opvQ
	(envelope-from <linux-efi+bounces-6260-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:00:23 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B06A322470D
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D26FB3066822
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D8A3EF0DA;
	Fri,  6 Mar 2026 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DP6UKx7M"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C83EDAB5
	for <linux-efi@vger.kernel.org>; Fri,  6 Mar 2026 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812649; cv=none; b=nZN2wRFIF4F4Baj7QYdeghbPv9KWgvkxrkNPw5Rl5pWZfUcpvUwETC9oipqKQSLG/0N2C1tlo5ajPi2lFhctMXcTzxx+vvEAjhkvlCqODNtPhV3snnttMGaFj6BMaUqQ2YoVup9laOI0r41Yw5FaMeIZgw7j/tPz5Pc0j/E4KBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812649; c=relaxed/simple;
	bh=uLd9V1oCpPRWtIo1XizCv09BniqJ8HX1YepTkcjMXh4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e/gqYA/ckPcoeEbMIIjC5jmZQ6JZ7vMkrgA5K+ppRFnIaelIhrGYIVnijs7s/+S9fZ7SQv0jfFYoEsJT9KK1+vOCQEaK0IRDBDR7ArYL4yKjQFBhzavOkQ0Uwxxe5rJDOeGUP7heexW6W9DbUFceS6G7RcuaN7D1b12IxeNuNhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DP6UKx7M; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-439ae28f5fcso4452754f8f.2
        for <linux-efi@vger.kernel.org>; Fri, 06 Mar 2026 07:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772812646; x=1773417446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VJwwrxymdAZuyNsFopMLfzW51d6bGAIMUJLL86H4+U=;
        b=DP6UKx7MwA//RudFySkPKdjiyGguCG48uZvZfLhT+P6onvmPv1h2qjvfmLYLbScN+y
         NzqvG+OrYG0A2lKUOL8leyWD9eu3Sqd+ID1uskG/P+A5csNL3OJceiUw6QcKPLUOap+b
         pyPEJrAT9wREu2ZsrkCGaDkJZGOrNLeHgZMbsV/6r4uyjGuKdgoUf01Vnt/MzpPN6DD/
         iNbm8rmK5UETckPsE7EB2GnF23/1VKBBUZQY+ezPmwqrwve2xuI9wgYeZQA5nAbxwCvx
         A2Worhk23YfAc7MZczhs9eSbZUIRs9FkQJ/UdTclh6bElHnIS1G40nKzZmmMLhnOfEho
         lW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812646; x=1773417446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VJwwrxymdAZuyNsFopMLfzW51d6bGAIMUJLL86H4+U=;
        b=Ib+TaHgHHZ9fBZxx9/lHzVPykwpWmWiQfNztZvJGftsnbyAMjovJGi7nQ3YF0boGEy
         y5qGP5ABBA3tGqJBkGg7eqsYr+e4B0ua+kteSealsPZGD7kAf1Hi/SA1y+gqD1bfykh6
         EY6svW0X/V5hX7nDivEg158asMzHD/J8HnDhxKm5pssqoFqV1wTPcSEgi9pRHfE21Q3H
         SnNZUsNS6KY84+ajxql1WQQGayEB8DJiExTn7vEJ0ZBkqSX1pZEK9xXZ7RTbkcz/qQ2C
         TmXClHO8Y6uaRJEihEIvJC9ZYHzVpjNW/DOiSk8TBev6Mj/jWDfipokPSF0BI5mRRvJM
         3vdA==
X-Gm-Message-State: AOJu0Yx3c5MfG3EA5ZeiMHZXHxuyl4nVmHEIz129c/EizQjwHpTXPDpn
	dQSExg+gS81jaEye8xmqXPURLmuAFIn8v1tIIZ0nCo9/E7qw7TSwFkwfR7ytvEFFVCBobFb9HA=
	=
X-Received: from wrbcm14.prod.google.com ([2002:a5d:5f4e:0:b0:439:b8a5:41be])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:420b:b0:439:a958:434b
 with SMTP id ffacd0b85a97d-439da31dbf6mr4340230f8f.2.1772812645563; Fri, 06
 Mar 2026 07:57:25 -0800 (PST)
Date: Fri,  6 Mar 2026 16:57:11 +0100
In-Reply-To: <20260306155703.815272-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306155703.815272-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=8782; i=ardb@kernel.org;
 h=from:subject; bh=jGYP0/YOGkv3IJMXLQNb+76CSu4ibyPhkWVRrJnk7UU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXPVz+BDxzlYs5S/eFz1rVL1W9D7QVpxYfvfxUzOQqbf7
 yyZNF2qo5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExkfSwjw9HXytFe0jkcxXMV
 vC6xdxa9v66VtndDbYONM5vJ3PLXuYwMb+fqZp08vKjeyKj5YFzMVMZDS3nu3V1axyr85ZNLk/l WfgA=
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306155703.815272-19-ardb+git@google.com>
Subject: [RFC PATCH 6/9] x86/efi: Do not rely on EFI_MEMORY_RUNTIME bit and
 avoid entry splitting
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B06A322470D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6260-lists,linux-efi=lfdr.de,git];
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
	NEURAL_HAM(-0.00)[-0.933];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

Now that efi_mem_reserve() has been updated to rely on RSRV_KERN
memblock reservations, it is no longer needed to mark memblock reserved
regions as EFI_MEMORY_RUNTIME. This means that it is no longer needed to
split existing entries in the EFI memory map, removing the need to
re-allocate/copy/remap the entire EFI memory map on every call to
efi_mem_reserve().

So drop this functionality - it is no longer needed.

Note that, for the time being, this requires the E820 map to be
consulted when deciding whether or not an entry with the
EFI_MEMORY_RUNTIME cleared needs to be preserved in the runtime map or
not. However, this will be superseded and removed by a subsequent patch,
which combines the map compaction with the actual freeing, in which case
the freeing logic can answer this question directly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h     |   4 -
 arch/x86/platform/efi/memmap.c | 138 --------------------
 arch/x86/platform/efi/quirks.c |  60 +--------
 3 files changed, 5 insertions(+), 197 deletions(-)

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
index e72e8b23598e..8a4a0c6b64bc 100644
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
@@ -509,8 +455,12 @@ void __init efi_unmap_boot_services(void)
 	for_each_efi_memory_desc(md) {
 		if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
 		    (md->type == EFI_BOOT_SERVICES_CODE ||
-		     md->type == EFI_BOOT_SERVICES_DATA))
+		     md->type == EFI_BOOT_SERVICES_DATA) &&
+		    !e820__mapped_any(md->phys_addr,
+				      md->phys_addr + md->num_pages * EFI_PAGE_SIZE,
+				      E820_TYPE_RESERVED)) {
 			continue;
+		}
 
 		memcpy(new_md, md, efi.memmap.desc_size);
 		new_md += efi.memmap.desc_size;
-- 
2.53.0.473.g4a7958ca14-goog


