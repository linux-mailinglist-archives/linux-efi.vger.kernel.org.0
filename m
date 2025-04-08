Return-Path: <linux-efi+bounces-3224-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0032AA7F8D0
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 11:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC033BBA8F
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7560266B59;
	Tue,  8 Apr 2025 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FK4Q2N5L"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FCD266583
	for <linux-efi@vger.kernel.org>; Tue,  8 Apr 2025 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102408; cv=none; b=dRLnyn0aeJTrYGAQprxKGxtjLhZ2gOcZpBUa0jDYEF9UyemlSy+4HBME4DysVETYoTNnYfQRiqilHwZZ87I38Halc6CFqAc0ksT/XQcJup6w0slHgy6aU1fG62mIuZgznPqarnmejpgHgiTi6yaqxZcKNw9EKZikNOxlDA1TZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102408; c=relaxed/simple;
	bh=afAM/r8LLBJ3ce6878gWia6R3fO9omu9O2KzXRnZMwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IjNWvvqLWliwug78Xd2IZN5cX5IWiruQH8lktAX7VUMoWW+cCPMwO3vmdpN0wOHU9NZNbYRUHx6FybUgJFKc/sgD9UoKteKOwTohEIA0XIVx/HNd8aQ2YDkbPVZWkQsW+1MQIW53NyuNVYjf0Wv7DGLj3y05MgDTVtuk3VqqNlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FK4Q2N5L; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so29618955e9.2
        for <linux-efi@vger.kernel.org>; Tue, 08 Apr 2025 01:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744102403; x=1744707203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cD0R3YWzzmvI7uAGndwbKruAiXCyd47nNPAPxqQeLtI=;
        b=FK4Q2N5LhN1V6oAEVATYpNjqy90DE25brdl7RakvzM+Si/QXk8bbtv4V3x4jSrCdin
         dSVzIKbGXpALZYyDYz1aNx4pLrXK5uOaAMr3Zrtan1REHqqbD0bFQ2NGm3tT5C0UCIYP
         Mp2v5jKWbp3u0r6j/E53sleiEGfa2cqfxUYaeC9dbKjKmXWf23ZgBv8B4MCsAXs9HZSt
         G4tcu23Wei+9kZV7SM7NCBpCbWafhZYqrv3DADZeQ+3rsE3iVOGJRh/RFnJo9Ibrqpsi
         Cl6nVbNyLUEexHUZVlEBfiHwdHHV4RxR/51y3yApqudRhNghlh8KRz5Nk/j329qj0oOM
         ODJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102403; x=1744707203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cD0R3YWzzmvI7uAGndwbKruAiXCyd47nNPAPxqQeLtI=;
        b=tVmq+YZ8iV+LIGoEMOXIgkZd2saemkF1XBKgw7DWlrMETclgLlXXjccfbYzFixNgjC
         rHdsy6s94sm9qS8KPQSjo3fC7VLFRaxcvLu/PhTkuUim+VelQzgyjPiFxWdV1+MU1Prv
         ZCpZwjCRxkwa0k06bcmzkqNasNcjw1Wouj7z8+ch86N0gZ6XRXLSKmgSrsWnedqhA0Ks
         da2KC5BkOLGf5fFruKLOhyf7gsV6akwI49SASzotf5ncdEy7l//wovn/7P/o7KI2D4Za
         /djYyRhyO3rcsV4tUHEfhY4rRFaC3CSef6jgqJCUX6RqllZYg/XAxvRZPLc6C2wVcF53
         P9pQ==
X-Gm-Message-State: AOJu0YygXtCyBKEwmOxrN0dSpeOQYLxuotF7A+4H+Kfle7BvN8IaMB1A
	bMsoR3/YVf0QQgEL2Oz0V3xaVgjZ+ygswRVB6rbXosFeoVQjtXfeVPPDsBMtT8CYsxLLKH04Cf7
	vbx5CrboAxbAzG7X6glN/HYkmThO9sANUnrriAYIBSbokZqQNavhu9ENHXazvGsxQNNnRimS8og
	F5JNzwGbBKnjXv36kQlyYuTBNR7w==
X-Google-Smtp-Source: AGHT+IH3hgzl7XMIA+2byfCqeuv9ky4s6Y91FTFpPpgmkni5CTzO8UF27NgEzCp4MuWw4yVPNr1+RNNF
X-Received: from wmsp32.prod.google.com ([2002:a05:600c:1da0:b0:43c:f6b3:fa10])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b1b:b0:43c:ec4c:25b1
 with SMTP id 5b1f17b1804b1-43ee076d701mr88955555e9.23.1744102403597; Tue, 08
 Apr 2025 01:53:23 -0700 (PDT)
Date: Tue,  8 Apr 2025 10:52:59 +0200
In-Reply-To: <20250408085254.836788-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250408085254.836788-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=16737; i=ardb@kernel.org;
 h=from:subject; bh=tGbwhpUC8P3TmNYLN+90vBme6ochJTirJO/Rz83PktE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3L47ccBU+KfxlvjjBIF910c0q95aNrTz1NFOfsF931W
 d/R5UtmRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhI+gGGf2oTg2Wfr/jEuWxf
 5d6l/955nm3QELYvNnrH9mq7pPJZxcMM/wwFF/38n2aw86gTU+mkbw95Nkence1e0nszf9+a3bI KoVwA
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250408085254.836788-13-ardb+git@google.com>
Subject: [PATCH v3 4/7] x86/boot: Move early kernel mapping code into startup/
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The startup code that constructs the kernel virtual mapping runs from
the 1:1 mapping of memory itself, and therefore, cannot use absolute
symbol references. Before making changes in subsequent patches, move
this code into a separate source file under arch/x86/boot/startup/ where
all such code will be kept from now on.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile     |   2 +-
 arch/x86/boot/startup/map_kernel.c | 224 ++++++++++++++++++++
 arch/x86/kernel/head64.c           | 211 +-----------------
 3 files changed, 226 insertions(+), 211 deletions(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 1beb5de30735..10319aee666b 100644
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
index 000000000000..5f1b7e0ba26e
--- /dev/null
+++ b/arch/x86/boot/startup/map_kernel.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/pgtable.h>
+
+#include <asm/init.h>
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
+	RIP_REL_REF(__pgtable_l5_enabled)	= 1;
+	RIP_REL_REF(pgdir_shift)		= 48;
+	RIP_REL_REF(ptrs_per_p4d)		= 512;
+	RIP_REL_REF(page_offset_base)		= __PAGE_OFFSET_BASE_L5;
+	RIP_REL_REF(vmalloc_base)		= __VMALLOC_BASE_L5;
+	RIP_REL_REF(vmemmap_base)		= __VMEMMAP_BASE_L5;
+
+	return true;
+}
+
+static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
+						    pmdval_t *pmd,
+						    unsigned long p2v_offset)
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
+		paddr = (unsigned long)rip_rel_ptr(__start_bss_decrypted);
+		paddr_end = (unsigned long)rip_rel_ptr(__end_bss_decrypted);
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
+/* Code in __startup_64() can be relocated during execution, but the compiler
+ * doesn't have to generate PC-relative relocations when accessing globals from
+ * that function. Clang actually does not generate them, which leads to
+ * boot-time crashes. To work around this problem, every global pointer must
+ * be accessed using RIP_REL_REF(). Kernel virtual addresses can be determined
+ * by subtracting p2v_offset from the RIP-relative address.
+ */
+unsigned long __head __startup_64(unsigned long p2v_offset,
+				  struct boot_params *bp)
+{
+	pmd_t (*early_pgts)[PTRS_PER_PMD] = rip_rel_ptr(early_dynamic_pgts);
+	unsigned long physaddr = (unsigned long)rip_rel_ptr(_text);
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
+	load_delta = __START_KERNEL_map + p2v_offset;
+	RIP_REL_REF(phys_base) = load_delta;
+
+	/* Is the address not 2M aligned? */
+	if (load_delta & ~PMD_MASK)
+		for (;;);
+
+	va_text = physaddr - p2v_offset;
+	va_end  = (unsigned long)rip_rel_ptr(_end) - p2v_offset;
+
+	/* Include the SME encryption mask in the fixup value */
+	load_delta += sme_get_me_mask();
+
+	/* Fixup the physical addresses in the page table */
+
+	pgd = rip_rel_ptr(early_top_pgt);
+	pgd[pgd_index(__START_KERNEL_map)] += load_delta;
+
+	if (IS_ENABLED(CONFIG_X86_5LEVEL) && la57) {
+		p4d = (p4dval_t *)rip_rel_ptr(level4_kernel_pgt);
+		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
+
+		pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d | _PAGE_TABLE;
+	}
+
+	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 2].pud += load_delta;
+	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 1].pud += load_delta;
+
+	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
+		RIP_REL_REF(level2_fixmap_pgt)[i].pmd += load_delta;
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
+	RIP_REL_REF(next_early_pgt) = 2;
+
+	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
+
+	if (la57) {
+		p4d = &early_pgts[RIP_REL_REF(next_early_pgt)++]->pmd;
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
+	pmd_entry &= RIP_REL_REF(__supported_pte_mask);
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
+	pmd = rip_rel_ptr(level2_kernel_pgt);
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
index 9b2ffec4bbad..6b68a206fa7f 100644
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
-		paddr = (unsigned long)rip_rel_ptr(__start_bss_decrypted);
-		paddr_end = (unsigned long)rip_rel_ptr(__end_bss_decrypted);
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
-	pmd_t (*early_pgts)[PTRS_PER_PMD] = rip_rel_ptr(early_dynamic_pgts);
-	unsigned long physaddr = (unsigned long)rip_rel_ptr(_text);
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
-	va_end  = (unsigned long)rip_rel_ptr(_end) - p2v_offset;
-
-	/* Include the SME encryption mask in the fixup value */
-	load_delta += sme_get_me_mask();
-
-	/* Fixup the physical addresses in the page table */
-
-	pgd = rip_rel_ptr(early_top_pgt);
-	pgd[pgd_index(__START_KERNEL_map)] += load_delta;
-
-	if (IS_ENABLED(CONFIG_X86_5LEVEL) && la57) {
-		p4d = (p4dval_t *)rip_rel_ptr(level4_kernel_pgt);
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
-	pmd = rip_rel_ptr(level2_kernel_pgt);
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


