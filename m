Return-Path: <linux-efi+bounces-3206-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE2EA7D3DC
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 08:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90725188BF41
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 06:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE4F22539E;
	Mon,  7 Apr 2025 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xne6OdtT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511D224AF3
	for <linux-efi@vger.kernel.org>; Mon,  7 Apr 2025 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744006306; cv=none; b=X+xfiyIfeCa7sB8IPgd8Mn7804nA+yUHc733iosx2eR5oApzve6aNSqfdyyZCcRZM3Q1+4Qrve8/l7L9BN8Snp5KRw3WWPP79qSoXtl4uOY2C/J4S+VzEuTDO+Q/ErDWBNgFXyO7m7k/XjqiLxQPQ0Htna/fO2+Dw5ESRJNESLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744006306; c=relaxed/simple;
	bh=29wEvP3mo2FgQbpZl2dIbWEAUdhjtBmuI+j9Jhz91AM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BppilFInkYEdofsWi6mEsGd5lmPxSkLtUulkrd7VYHQlWTBf8uDyDNT4QvYV1OUFC7L3ylFRZxAk9UetMApMgZSkglHuFwsoeeWIsoKzFAkyKk4OqjI/cwC/yNFmbqT3WXgnZx0N/MXw1bJBwMxlEFxoGDflAPFhwe2fc51zeug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xne6OdtT; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3912e4e2033so1757014f8f.0
        for <linux-efi@vger.kernel.org>; Sun, 06 Apr 2025 23:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744006302; x=1744611102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMxiBFcThX7tgGvKaVxziX0eJsMo+maZ3LTI6Ameq7o=;
        b=xne6OdtTKOwxe8Z43OxJooYgvXvMTJ56cz0wQCE1RsDOUgGR8Aznxn2AbDg9Pwkud1
         MJSQlr/6DwkRW+ClNHsOM+9n5ebpeUYJDcGevz641xz5WRnlURwCq1tpN+o9rR7fYsj5
         C9ZwAT7GPoWTehckoxP5aRe09tT2uD2EUtekDGLvf3HBpFyJQMpbiHgPk55L8xm0s37V
         GnFxX36/khd40A3xHSDI10+RDNL9Z/NlJEfbwPqoTgMyFFL3u9xt3POTu2V5fmfv7pma
         v59wL30jGqaaWpt2QyIrW/PMEgQhfvibX4tUb0MRTUBgL1pzTGe3l7RyDqG6sWeKdY0j
         G4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744006302; x=1744611102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMxiBFcThX7tgGvKaVxziX0eJsMo+maZ3LTI6Ameq7o=;
        b=QgcRgEXOoqUGJa+jnQTgk01m4DSLOAJLtmVceJ/J+vbHCnufVya2n3WzjEYQu2d5DB
         mVDKJ5MadUw2bqXEeyRvqgfH4y8G/BtT+5poJWzElkDuzzVmiDch/N++eKvt2I9NqR8k
         uxhehIfQVvmxaFmrgipyF+jeeJKoBUUGQWp0DwGadWSncLBnGukUlDCCR++ptT7DCpp4
         WovDpq8s6O5PUbqIYkQPzgJYeC8JoJxH0+WhGYaZdVujcLLzYzmqJwJWeXbnQsS+a59c
         lBL5tARkYOiFSfJegxjrbbX7W8yz+vekWH/yREV/VmYppABwvk1Ehd74/CoiRF9wxvCA
         dZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrEbydK3V05FS0jZe3oDIAj4ZOT8uNwauoDs+ysHSbLuiqNTXBeYQHQgwjTI1X3yz8o7xE0ih24zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymH5gPGddyaouhuJfJiLv0vGIiG07F4tqeiQL3avOwVVXBiwZ8
	tFrxpJals5TLmOkpttaVITd6h2jygBOjHfFRfe6HxDykptnYv3HEaT+Vg1yoIpNhR9FLZw==
X-Google-Smtp-Source: AGHT+IHRTs8Q23SbKVrOZW+vwKXToI+ggMkxg+UmNCECbwh8wFZga2Ek6mwzvgSVHQQ/vis+fOpRvZEU
X-Received: from wrbcg11.prod.google.com ([2002:a5d:5ccb:0:b0:39a:bfe3:f904])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:584c:0:b0:390:fb37:1ca
 with SMTP id ffacd0b85a97d-39cba93cf5dmr9460146f8f.53.1744006302441; Sun, 06
 Apr 2025 23:11:42 -0700 (PDT)
Date: Mon,  7 Apr 2025 08:11:34 +0200
In-Reply-To: <20250407061132.69315-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407061132.69315-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=16201; i=ardb@kernel.org;
 h=from:subject; bh=bFcOQFipnneenYlvZh5Ml236kuSq+b0rnH02R3Sld2s=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf1zznSXw4sX1yy+ezVQPl6l9f70Lz0PndZqxUhUbWm7G
 SKR8Xl7RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIyzxGhp8miokTU9iMDj/+
 tIXzxlXJv2HXH2Ybzd4QNNk/g6Mk5TXD/yyzO5NlVCqmcJzYu+BYmPv2G9Wnr+evNauO6pmizZP qxA8A
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407061132.69315-5-ardb+git@google.com>
Subject: [PATCH v2 1/2] x86/boot: Move early kernel mapping code into startup/
From: Ard Biesheuvel <ardb+git@google.com>
To: mingo@kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The startup code that constructs the kernel virtual mapping runs from
the 1:1 mapping of memory itself, and therefore, cannot use absolute
symbol references. Move this code into a separate source file under
arch/x86/boot/startup/ where all such code will be kept from now on.

Since all code here is constructed in a manner that ensures that it
tolerates running from the 1:1 mapping of memory, any uses of the
RIP_REL_REF() macro can be dropped, along with __head annotations for
placing this code in a dedicated startup section.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile     |   2 +-
 arch/x86/boot/startup/map_kernel.c | 215 ++++++++++++++++++++
 arch/x86/kernel/head64.c           | 211 +------------------
 3 files changed, 217 insertions(+), 211 deletions(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 34b324cbd5a4..01423063fec2 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -15,7 +15,7 @@ KMSAN_SANITIZE	:= n
 UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
 
-obj-$(CONFIG_X86_64)		+= gdt_idt.o
+obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
diff --git a/arch/x86/boot/startup/map_kernel.c b/arch/x86/boot/startup/map_kernel.c
new file mode 100644
index 000000000000..1cf57c03c319
--- /dev/null
+++ b/arch/x86/boot/startup/map_kernel.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/pgtable.h>
+
+#include <asm/sections.h>
+#include <asm/setup.h>
+#include <asm/sev.h>
+
+extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
+extern unsigned int next_early_pgt;
+
+static inline bool check_la57_support(void)
+{
+	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
+		return false;
+
+	/*
+	 * 5-level paging is detected and enabled at kernel decompression
+	 * stage. Only check if it has been enabled there.
+	 */
+	if (!(native_read_cr4() & X86_CR4_LA57))
+		return false;
+
+	__pgtable_l5_enabled	= 1;
+	pgdir_shift		= 48;
+	ptrs_per_p4d		= 512;
+	page_offset_base	= __PAGE_OFFSET_BASE_L5;
+	vmalloc_base		= __VMALLOC_BASE_L5;
+	vmemmap_base		= __VMEMMAP_BASE_L5;
+
+	return true;
+}
+
+static unsigned long sme_postprocess_startup(struct boot_params *bp,
+					     pmdval_t *pmd,
+					     unsigned long p2v_offset)
+{
+	unsigned long paddr, paddr_end;
+	int i;
+
+	/* Encrypt the kernel and related (if SME is active) */
+	sme_encrypt_kernel(bp);
+
+	/*
+	 * Clear the memory encryption mask from the .bss..decrypted section.
+	 * The bss section will be memset to zero later in the initialization so
+	 * there is no need to zero it after changing the memory encryption
+	 * attribute.
+	 */
+	if (sme_get_me_mask()) {
+		paddr = (unsigned long)__start_bss_decrypted;
+		paddr_end = (unsigned long)__end_bss_decrypted;
+
+		for (; paddr < paddr_end; paddr += PMD_SIZE) {
+			/*
+			 * On SNP, transition the page to shared in the RMP table so that
+			 * it is consistent with the page table attribute change.
+			 *
+			 * __start_bss_decrypted has a virtual address in the high range
+			 * mapping (kernel .text). PVALIDATE, by way of
+			 * early_snp_set_memory_shared(), requires a valid virtual
+			 * address but the kernel is currently running off of the identity
+			 * mapping so use the PA to get a *currently* valid virtual address.
+			 */
+			early_snp_set_memory_shared(paddr, paddr, PTRS_PER_PMD);
+
+			i = pmd_index(paddr - p2v_offset);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
+	/*
+	 * Return the SME encryption mask (if SME is active) to be used as a
+	 * modifier for the initial pgdir entry programmed into CR3.
+	 */
+	return sme_get_me_mask();
+}
+
+unsigned long __init __startup_64(unsigned long p2v_offset,
+				  struct boot_params *bp)
+{
+	pmd_t (*early_pgts)[PTRS_PER_PMD] = early_dynamic_pgts;
+	unsigned long physaddr = (unsigned long)_text;
+	unsigned long va_text, va_end;
+	unsigned long pgtable_flags;
+	unsigned long load_delta;
+	pgdval_t *pgd;
+	p4dval_t *p4d;
+	pudval_t *pud;
+	pmdval_t *pmd, pmd_entry;
+	bool la57;
+	int i;
+
+	la57 = check_la57_support();
+
+	/* Is the address too large? */
+	if (physaddr >> MAX_PHYSMEM_BITS)
+		for (;;);
+
+	/*
+	 * Compute the delta between the address I am compiled to run at
+	 * and the address I am actually running at.
+	 */
+	phys_base = load_delta = __START_KERNEL_map + p2v_offset;
+
+	/* Is the address not 2M aligned? */
+	if (load_delta & ~PMD_MASK)
+		for (;;);
+
+	va_text = physaddr - p2v_offset;
+	va_end  = (unsigned long)_end - p2v_offset;
+
+	/* Include the SME encryption mask in the fixup value */
+	load_delta += sme_get_me_mask();
+
+	/* Fixup the physical addresses in the page table */
+
+	pgd = &early_top_pgt[0].pgd;
+	pgd[pgd_index(__START_KERNEL_map)] += load_delta;
+
+	if (IS_ENABLED(CONFIG_X86_5LEVEL) && la57) {
+		p4d = (p4dval_t *)level4_kernel_pgt;
+		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
+
+		pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d | _PAGE_TABLE;
+	}
+
+	level3_kernel_pgt[PTRS_PER_PUD - 2].pud += load_delta;
+	level3_kernel_pgt[PTRS_PER_PUD - 1].pud += load_delta;
+
+	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
+		level2_fixmap_pgt[i].pmd += load_delta;
+
+	/*
+	 * Set up the identity mapping for the switchover.  These
+	 * entries should *NOT* have the global bit set!  This also
+	 * creates a bunch of nonsense entries but that is fine --
+	 * it avoids problems around wraparound.
+	 */
+
+	pud = &early_pgts[0]->pmd;
+	pmd = &early_pgts[1]->pmd;
+	next_early_pgt = 2;
+
+	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
+
+	if (la57) {
+		p4d = &early_pgts[next_early_pgt++]->pmd;
+
+		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
+		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
+		pgd[i + 1] = (pgdval_t)p4d + pgtable_flags;
+
+		i = physaddr >> P4D_SHIFT;
+		p4d[(i + 0) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
+		p4d[(i + 1) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
+	} else {
+		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
+		pgd[i + 0] = (pgdval_t)pud + pgtable_flags;
+		pgd[i + 1] = (pgdval_t)pud + pgtable_flags;
+	}
+
+	i = physaddr >> PUD_SHIFT;
+	pud[(i + 0) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
+	pud[(i + 1) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
+
+	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
+	/* Filter out unsupported __PAGE_KERNEL_* bits: */
+	pmd_entry &= __supported_pte_mask;
+	pmd_entry += sme_get_me_mask();
+	pmd_entry +=  physaddr;
+
+	for (i = 0; i < DIV_ROUND_UP(va_end - va_text, PMD_SIZE); i++) {
+		int idx = i + (physaddr >> PMD_SHIFT);
+
+		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
+	}
+
+	/*
+	 * Fixup the kernel text+data virtual addresses. Note that
+	 * we might write invalid pmds, when the kernel is relocated
+	 * cleanup_highmap() fixes this up along with the mappings
+	 * beyond _end.
+	 *
+	 * Only the region occupied by the kernel image has so far
+	 * been checked against the table of usable memory regions
+	 * provided by the firmware, so invalidate pages outside that
+	 * region. A page table entry that maps to a reserved area of
+	 * memory would allow processor speculation into that area,
+	 * and on some hardware (particularly the UV platform) even
+	 * speculative access to some reserved areas is caught as an
+	 * error, causing the BIOS to halt the system.
+	 */
+
+	pmd = &level2_kernel_pgt[0].pmd;
+
+	/* invalidate pages before the kernel image */
+	for (i = 0; i < pmd_index(va_text); i++)
+		pmd[i] &= ~_PAGE_PRESENT;
+
+	/* fixup pages that are part of the kernel image */
+	for (; i <= pmd_index(va_end); i++)
+		if (pmd[i] & _PAGE_PRESENT)
+			pmd[i] += load_delta;
+
+	/* invalidate pages after the kernel image */
+	for (; i < PTRS_PER_PMD; i++)
+		pmd[i] &= ~_PAGE_PRESENT;
+
+	return sme_postprocess_startup(bp, pmd, p2v_offset);
+}
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 5b993b545c7e..6b68a206fa7f 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -47,7 +47,7 @@
  * Manage page tables very early on.
  */
 extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
-static unsigned int __initdata next_early_pgt;
+unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 #ifdef CONFIG_X86_5LEVEL
@@ -67,215 +67,6 @@ unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
 EXPORT_SYMBOL(vmemmap_base);
 #endif
 
-static inline bool check_la57_support(void)
-{
-	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
-		return false;
-
-	/*
-	 * 5-level paging is detected and enabled at kernel decompression
-	 * stage. Only check if it has been enabled there.
-	 */
-	if (!(native_read_cr4() & X86_CR4_LA57))
-		return false;
-
-	RIP_REL_REF(__pgtable_l5_enabled)	= 1;
-	RIP_REL_REF(pgdir_shift)		= 48;
-	RIP_REL_REF(ptrs_per_p4d)		= 512;
-	RIP_REL_REF(page_offset_base)		= __PAGE_OFFSET_BASE_L5;
-	RIP_REL_REF(vmalloc_base)		= __VMALLOC_BASE_L5;
-	RIP_REL_REF(vmemmap_base)		= __VMEMMAP_BASE_L5;
-
-	return true;
-}
-
-static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
-						    pmdval_t *pmd,
-						    unsigned long p2v_offset)
-{
-	unsigned long paddr, paddr_end;
-	int i;
-
-	/* Encrypt the kernel and related (if SME is active) */
-	sme_encrypt_kernel(bp);
-
-	/*
-	 * Clear the memory encryption mask from the .bss..decrypted section.
-	 * The bss section will be memset to zero later in the initialization so
-	 * there is no need to zero it after changing the memory encryption
-	 * attribute.
-	 */
-	if (sme_get_me_mask()) {
-		paddr = (unsigned long)&RIP_REL_REF(__start_bss_decrypted);
-		paddr_end = (unsigned long)&RIP_REL_REF(__end_bss_decrypted);
-
-		for (; paddr < paddr_end; paddr += PMD_SIZE) {
-			/*
-			 * On SNP, transition the page to shared in the RMP table so that
-			 * it is consistent with the page table attribute change.
-			 *
-			 * __start_bss_decrypted has a virtual address in the high range
-			 * mapping (kernel .text). PVALIDATE, by way of
-			 * early_snp_set_memory_shared(), requires a valid virtual
-			 * address but the kernel is currently running off of the identity
-			 * mapping so use the PA to get a *currently* valid virtual address.
-			 */
-			early_snp_set_memory_shared(paddr, paddr, PTRS_PER_PMD);
-
-			i = pmd_index(paddr - p2v_offset);
-			pmd[i] -= sme_get_me_mask();
-		}
-	}
-
-	/*
-	 * Return the SME encryption mask (if SME is active) to be used as a
-	 * modifier for the initial pgdir entry programmed into CR3.
-	 */
-	return sme_get_me_mask();
-}
-
-/* Code in __startup_64() can be relocated during execution, but the compiler
- * doesn't have to generate PC-relative relocations when accessing globals from
- * that function. Clang actually does not generate them, which leads to
- * boot-time crashes. To work around this problem, every global pointer must
- * be accessed using RIP_REL_REF(). Kernel virtual addresses can be determined
- * by subtracting p2v_offset from the RIP-relative address.
- */
-unsigned long __head __startup_64(unsigned long p2v_offset,
-				  struct boot_params *bp)
-{
-	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
-	unsigned long physaddr = (unsigned long)&RIP_REL_REF(_text);
-	unsigned long va_text, va_end;
-	unsigned long pgtable_flags;
-	unsigned long load_delta;
-	pgdval_t *pgd;
-	p4dval_t *p4d;
-	pudval_t *pud;
-	pmdval_t *pmd, pmd_entry;
-	bool la57;
-	int i;
-
-	la57 = check_la57_support();
-
-	/* Is the address too large? */
-	if (physaddr >> MAX_PHYSMEM_BITS)
-		for (;;);
-
-	/*
-	 * Compute the delta between the address I am compiled to run at
-	 * and the address I am actually running at.
-	 */
-	load_delta = __START_KERNEL_map + p2v_offset;
-	RIP_REL_REF(phys_base) = load_delta;
-
-	/* Is the address not 2M aligned? */
-	if (load_delta & ~PMD_MASK)
-		for (;;);
-
-	va_text = physaddr - p2v_offset;
-	va_end  = (unsigned long)&RIP_REL_REF(_end) - p2v_offset;
-
-	/* Include the SME encryption mask in the fixup value */
-	load_delta += sme_get_me_mask();
-
-	/* Fixup the physical addresses in the page table */
-
-	pgd = &RIP_REL_REF(early_top_pgt)->pgd;
-	pgd[pgd_index(__START_KERNEL_map)] += load_delta;
-
-	if (IS_ENABLED(CONFIG_X86_5LEVEL) && la57) {
-		p4d = (p4dval_t *)&RIP_REL_REF(level4_kernel_pgt);
-		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
-
-		pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d | _PAGE_TABLE;
-	}
-
-	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 2].pud += load_delta;
-	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 1].pud += load_delta;
-
-	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
-		RIP_REL_REF(level2_fixmap_pgt)[i].pmd += load_delta;
-
-	/*
-	 * Set up the identity mapping for the switchover.  These
-	 * entries should *NOT* have the global bit set!  This also
-	 * creates a bunch of nonsense entries but that is fine --
-	 * it avoids problems around wraparound.
-	 */
-
-	pud = &early_pgts[0]->pmd;
-	pmd = &early_pgts[1]->pmd;
-	RIP_REL_REF(next_early_pgt) = 2;
-
-	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
-
-	if (la57) {
-		p4d = &early_pgts[RIP_REL_REF(next_early_pgt)++]->pmd;
-
-		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
-		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
-		pgd[i + 1] = (pgdval_t)p4d + pgtable_flags;
-
-		i = physaddr >> P4D_SHIFT;
-		p4d[(i + 0) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
-		p4d[(i + 1) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
-	} else {
-		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
-		pgd[i + 0] = (pgdval_t)pud + pgtable_flags;
-		pgd[i + 1] = (pgdval_t)pud + pgtable_flags;
-	}
-
-	i = physaddr >> PUD_SHIFT;
-	pud[(i + 0) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
-	pud[(i + 1) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
-
-	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
-	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	pmd_entry &= RIP_REL_REF(__supported_pte_mask);
-	pmd_entry += sme_get_me_mask();
-	pmd_entry +=  physaddr;
-
-	for (i = 0; i < DIV_ROUND_UP(va_end - va_text, PMD_SIZE); i++) {
-		int idx = i + (physaddr >> PMD_SHIFT);
-
-		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
-	}
-
-	/*
-	 * Fixup the kernel text+data virtual addresses. Note that
-	 * we might write invalid pmds, when the kernel is relocated
-	 * cleanup_highmap() fixes this up along with the mappings
-	 * beyond _end.
-	 *
-	 * Only the region occupied by the kernel image has so far
-	 * been checked against the table of usable memory regions
-	 * provided by the firmware, so invalidate pages outside that
-	 * region. A page table entry that maps to a reserved area of
-	 * memory would allow processor speculation into that area,
-	 * and on some hardware (particularly the UV platform) even
-	 * speculative access to some reserved areas is caught as an
-	 * error, causing the BIOS to halt the system.
-	 */
-
-	pmd = &RIP_REL_REF(level2_kernel_pgt)->pmd;
-
-	/* invalidate pages before the kernel image */
-	for (i = 0; i < pmd_index(va_text); i++)
-		pmd[i] &= ~_PAGE_PRESENT;
-
-	/* fixup pages that are part of the kernel image */
-	for (; i <= pmd_index(va_end); i++)
-		if (pmd[i] & _PAGE_PRESENT)
-			pmd[i] += load_delta;
-
-	/* invalidate pages after the kernel image */
-	for (; i < PTRS_PER_PMD; i++)
-		pmd[i] &= ~_PAGE_PRESENT;
-
-	return sme_postprocess_startup(bp, pmd, p2v_offset);
-}
-
 /* Wipe all early page tables except for the kernel symbol map */
 static void __init reset_early_page_tables(void)
 {
-- 
2.49.0.504.g3bcea36a83-goog


