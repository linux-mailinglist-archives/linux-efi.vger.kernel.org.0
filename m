Return-Path: <linux-efi+bounces-3306-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F01EA86DC8
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 16:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96958A66C4
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433ED1EF38E;
	Sat, 12 Apr 2025 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="onZi5FIO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rrXOos4h"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A93198E77;
	Sat, 12 Apr 2025 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744468428; cv=none; b=lOBWfcWGbhTn3Yf1p9syRoqYIuyJZZXwDGSY2d7/1rMEjQQ50P0Q7d4pVYqUDBKzFPtuJFPqwdjicSyO+SlH5pF1Ht5Foy4Lvja1kTYWMW42SayAk54PG4bxhspJEiUNW8TKr0/ItK3dCmmrKbxw67muH1TRLS27lJWjNEfeQhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744468428; c=relaxed/simple;
	bh=XCpIcqnyEWDpPhURVq2aaXna553pBPno93KDwIgIAzo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MQzFx9bJ2R1i7prr3hvqbyuuzw7iK1HG0+Ngad0ex7Am5Tgb3wxqXh8V3rG3DdYJI72detaOSxYjK4uyGyvVMChoN+wDgJG+Z97DyZlLYzEROdKtQRstPD1XYmpx976rCXypYSGCPHROLAEAJu277VnxZ9zyO4EackWV1SbJuNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=onZi5FIO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rrXOos4h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 14:33:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744468416;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3XQf8dUaT4uuiEzZkZ01volT4TfyCEmXmYQeNwCPi8=;
	b=onZi5FIOkVEm3f2eopzQP/3lD6koC4NE3Ew2ltQsQS5yWQrA5P3KBju14arDUEhP/MI4kg
	8xXqNn3KvmTwV0LJgScHagxjlQQ8eCq+8Y/Sr6rya1Ts0YcGDdd/aUCng25fXwnDIAvj/O
	6nM7CVN9Ayo4gv1aoe6h0UnOz6tOKcUFwur/UHT/1gl9D0dqcIyUE+bguoNDW8BlK17g2R
	iIoIw5YkA5TlIcgt4TynHNdXr5t26MySyGo2ixfIN/WG2zHFzn7rxg13/iWQ8ZRZppoICs
	ALwEXJMO4hNzj4Ux++FqmEjwIJsESPmLToWZtP7tSN8+rrYZxp+NM/7fuver2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744468416;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3XQf8dUaT4uuiEzZkZ01volT4TfyCEmXmYQeNwCPi8=;
	b=rrXOos4heMSJqCptlzVE53RSRT+4gnTJjasU5NsxcAnFKlRDB55zUYvXodVUi5+UTnnnob
	s6xNJOV4uZZrscAA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Move early SME init code into startup/
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250410134117.3713574-18-ardb+git@google.com>
References: <20250410134117.3713574-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174446841554.31282.7082585342786313160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     7ae089ee75f3c77b94ff23204b41ea06da9f0193
Gitweb:        https://git.kernel.org/tip/7ae089ee75f3c77b94ff23204b41ea06da9f0193
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 10 Apr 2025 15:41:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 11:13:05 +02:00

x86/boot: Move early SME init code into startup/

Move the SME initialization code, which runs from the 1:1 mapping of
memory as it operates on the kernel virtual mapping, into the new
sub-directory arch/x86/boot/startup/ where all startup code will reside
that needs to tolerate executing from the 1:1 mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250410134117.3713574-18-ardb+git@google.com
---
 arch/x86/boot/startup/Makefile     |   1 +-
 arch/x86/boot/startup/sme.c        | 567 ++++++++++++++++++++++++++++-
 arch/x86/mm/Makefile               |   6 +-
 arch/x86/mm/mem_encrypt_identity.c | 569 +----------------------------
 4 files changed, 568 insertions(+), 575 deletions(-)
 create mode 100644 arch/x86/boot/startup/sme.c
 delete mode 100644 arch/x86/mm/mem_encrypt_identity.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 10319ae..ccdfc42 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -16,6 +16,7 @@ UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
 
 obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
+obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
new file mode 100644
index 0000000..23d10cd
--- /dev/null
+++ b/arch/x86/boot/startup/sme.c
@@ -0,0 +1,567 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Memory Encryption Support
+ *
+ * Copyright (C) 2016 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+/*
+ * Since we're dealing with identity mappings, physical and virtual
+ * addresses are the same, so override these defines which are ultimately
+ * used by the headers in misc.h.
+ */
+#define __pa(x)  ((unsigned long)(x))
+#define __va(x)  ((void *)((unsigned long)(x)))
+
+/*
+ * Special hack: we have to be careful, because no indirections are
+ * allowed here, and paravirt_ops is a kind of one. As it will only run in
+ * baremetal anyway, we just keep it from happening. (This list needs to
+ * be extended when new paravirt and debugging variants are added.)
+ */
+#undef CONFIG_PARAVIRT
+#undef CONFIG_PARAVIRT_XXL
+#undef CONFIG_PARAVIRT_SPINLOCKS
+
+/*
+ * This code runs before CPU feature bits are set. By default, the
+ * pgtable_l5_enabled() function uses bit X86_FEATURE_LA57 to determine if
+ * 5-level paging is active, so that won't work here. USE_EARLY_PGTABLE_L5
+ * is provided to handle this situation and, instead, use a variable that
+ * has been set by the early boot code.
+ */
+#define USE_EARLY_PGTABLE_L5
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
+
+#include <asm/init.h>
+#include <asm/setup.h>
+#include <asm/sections.h>
+#include <asm/coco.h>
+#include <asm/sev.h>
+
+#define PGD_FLAGS		_KERNPG_TABLE_NOENC
+#define P4D_FLAGS		_KERNPG_TABLE_NOENC
+#define PUD_FLAGS		_KERNPG_TABLE_NOENC
+#define PMD_FLAGS		_KERNPG_TABLE_NOENC
+
+#define PMD_FLAGS_LARGE		(__PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL)
+
+#define PMD_FLAGS_DEC		PMD_FLAGS_LARGE
+#define PMD_FLAGS_DEC_WP	((PMD_FLAGS_DEC & ~_PAGE_LARGE_CACHE_MASK) | \
+				 (_PAGE_PAT_LARGE | _PAGE_PWT))
+
+#define PMD_FLAGS_ENC		(PMD_FLAGS_LARGE | _PAGE_ENC)
+
+#define PTE_FLAGS		(__PAGE_KERNEL_EXEC & ~_PAGE_GLOBAL)
+
+#define PTE_FLAGS_DEC		PTE_FLAGS
+#define PTE_FLAGS_DEC_WP	((PTE_FLAGS_DEC & ~_PAGE_CACHE_MASK) | \
+				 (_PAGE_PAT | _PAGE_PWT))
+
+#define PTE_FLAGS_ENC		(PTE_FLAGS | _PAGE_ENC)
+
+struct sme_populate_pgd_data {
+	void    *pgtable_area;
+	pgd_t   *pgd;
+
+	pmdval_t pmd_flags;
+	pteval_t pte_flags;
+	unsigned long paddr;
+
+	unsigned long vaddr;
+	unsigned long vaddr_end;
+};
+
+/*
+ * This work area lives in the .init.scratch section, which lives outside of
+ * the kernel proper. It is sized to hold the intermediate copy buffer and
+ * more than enough pagetable pages.
+ *
+ * By using this section, the kernel can be encrypted in place and it
+ * avoids any possibility of boot parameters or initramfs images being
+ * placed such that the in-place encryption logic overwrites them.  This
+ * section is 2MB aligned to allow for simple pagetable setup using only
+ * PMD entries (see vmlinux.lds.S).
+ */
+static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
+
+static void __head sme_clear_pgd(struct sme_populate_pgd_data *ppd)
+{
+	unsigned long pgd_start, pgd_end, pgd_size;
+	pgd_t *pgd_p;
+
+	pgd_start = ppd->vaddr & PGDIR_MASK;
+	pgd_end = ppd->vaddr_end & PGDIR_MASK;
+
+	pgd_size = (((pgd_end - pgd_start) / PGDIR_SIZE) + 1) * sizeof(pgd_t);
+
+	pgd_p = ppd->pgd + pgd_index(ppd->vaddr);
+
+	memset(pgd_p, 0, pgd_size);
+}
+
+static pud_t __head *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd = ppd->pgd + pgd_index(ppd->vaddr);
+	if (pgd_none(*pgd)) {
+		p4d = ppd->pgtable_area;
+		memset(p4d, 0, sizeof(*p4d) * PTRS_PER_P4D);
+		ppd->pgtable_area += sizeof(*p4d) * PTRS_PER_P4D;
+		set_pgd(pgd, __pgd(PGD_FLAGS | __pa(p4d)));
+	}
+
+	p4d = p4d_offset(pgd, ppd->vaddr);
+	if (p4d_none(*p4d)) {
+		pud = ppd->pgtable_area;
+		memset(pud, 0, sizeof(*pud) * PTRS_PER_PUD);
+		ppd->pgtable_area += sizeof(*pud) * PTRS_PER_PUD;
+		set_p4d(p4d, __p4d(P4D_FLAGS | __pa(pud)));
+	}
+
+	pud = pud_offset(p4d, ppd->vaddr);
+	if (pud_none(*pud)) {
+		pmd = ppd->pgtable_area;
+		memset(pmd, 0, sizeof(*pmd) * PTRS_PER_PMD);
+		ppd->pgtable_area += sizeof(*pmd) * PTRS_PER_PMD;
+		set_pud(pud, __pud(PUD_FLAGS | __pa(pmd)));
+	}
+
+	if (pud_leaf(*pud))
+		return NULL;
+
+	return pud;
+}
+
+static void __head sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
+{
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pud = sme_prepare_pgd(ppd);
+	if (!pud)
+		return;
+
+	pmd = pmd_offset(pud, ppd->vaddr);
+	if (pmd_leaf(*pmd))
+		return;
+
+	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
+}
+
+static void __head sme_populate_pgd(struct sme_populate_pgd_data *ppd)
+{
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pud = sme_prepare_pgd(ppd);
+	if (!pud)
+		return;
+
+	pmd = pmd_offset(pud, ppd->vaddr);
+	if (pmd_none(*pmd)) {
+		pte = ppd->pgtable_area;
+		memset(pte, 0, sizeof(*pte) * PTRS_PER_PTE);
+		ppd->pgtable_area += sizeof(*pte) * PTRS_PER_PTE;
+		set_pmd(pmd, __pmd(PMD_FLAGS | __pa(pte)));
+	}
+
+	if (pmd_leaf(*pmd))
+		return;
+
+	pte = pte_offset_kernel(pmd, ppd->vaddr);
+	if (pte_none(*pte))
+		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
+}
+
+static void __head __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
+{
+	while (ppd->vaddr < ppd->vaddr_end) {
+		sme_populate_pgd_large(ppd);
+
+		ppd->vaddr += PMD_SIZE;
+		ppd->paddr += PMD_SIZE;
+	}
+}
+
+static void __head __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
+{
+	while (ppd->vaddr < ppd->vaddr_end) {
+		sme_populate_pgd(ppd);
+
+		ppd->vaddr += PAGE_SIZE;
+		ppd->paddr += PAGE_SIZE;
+	}
+}
+
+static void __head __sme_map_range(struct sme_populate_pgd_data *ppd,
+				   pmdval_t pmd_flags, pteval_t pte_flags)
+{
+	unsigned long vaddr_end;
+
+	ppd->pmd_flags = pmd_flags;
+	ppd->pte_flags = pte_flags;
+
+	/* Save original end value since we modify the struct value */
+	vaddr_end = ppd->vaddr_end;
+
+	/* If start is not 2MB aligned, create PTE entries */
+	ppd->vaddr_end = ALIGN(ppd->vaddr, PMD_SIZE);
+	__sme_map_range_pte(ppd);
+
+	/* Create PMD entries */
+	ppd->vaddr_end = vaddr_end & PMD_MASK;
+	__sme_map_range_pmd(ppd);
+
+	/* If end is not 2MB aligned, create PTE entries */
+	ppd->vaddr_end = vaddr_end;
+	__sme_map_range_pte(ppd);
+}
+
+static void __head sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
+{
+	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
+}
+
+static void __head sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
+{
+	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
+}
+
+static void __head sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
+{
+	__sme_map_range(ppd, PMD_FLAGS_DEC_WP, PTE_FLAGS_DEC_WP);
+}
+
+static unsigned long __head sme_pgtable_calc(unsigned long len)
+{
+	unsigned long entries = 0, tables = 0;
+
+	/*
+	 * Perform a relatively simplistic calculation of the pagetable
+	 * entries that are needed. Those mappings will be covered mostly
+	 * by 2MB PMD entries so we can conservatively calculate the required
+	 * number of P4D, PUD and PMD structures needed to perform the
+	 * mappings.  For mappings that are not 2MB aligned, PTE mappings
+	 * would be needed for the start and end portion of the address range
+	 * that fall outside of the 2MB alignment.  This results in, at most,
+	 * two extra pages to hold PTE entries for each range that is mapped.
+	 * Incrementing the count for each covers the case where the addresses
+	 * cross entries.
+	 */
+
+	/* PGDIR_SIZE is equal to P4D_SIZE on 4-level machine. */
+	if (PTRS_PER_P4D > 1)
+		entries += (DIV_ROUND_UP(len, PGDIR_SIZE) + 1) * sizeof(p4d_t) * PTRS_PER_P4D;
+	entries += (DIV_ROUND_UP(len, P4D_SIZE) + 1) * sizeof(pud_t) * PTRS_PER_PUD;
+	entries += (DIV_ROUND_UP(len, PUD_SIZE) + 1) * sizeof(pmd_t) * PTRS_PER_PMD;
+	entries += 2 * sizeof(pte_t) * PTRS_PER_PTE;
+
+	/*
+	 * Now calculate the added pagetable structures needed to populate
+	 * the new pagetables.
+	 */
+
+	if (PTRS_PER_P4D > 1)
+		tables += DIV_ROUND_UP(entries, PGDIR_SIZE) * sizeof(p4d_t) * PTRS_PER_P4D;
+	tables += DIV_ROUND_UP(entries, P4D_SIZE) * sizeof(pud_t) * PTRS_PER_PUD;
+	tables += DIV_ROUND_UP(entries, PUD_SIZE) * sizeof(pmd_t) * PTRS_PER_PMD;
+
+	return entries + tables;
+}
+
+void __head sme_encrypt_kernel(struct boot_params *bp)
+{
+	unsigned long workarea_start, workarea_end, workarea_len;
+	unsigned long execute_start, execute_end, execute_len;
+	unsigned long kernel_start, kernel_end, kernel_len;
+	unsigned long initrd_start, initrd_end, initrd_len;
+	struct sme_populate_pgd_data ppd;
+	unsigned long pgtable_area_len;
+	unsigned long decrypted_base;
+
+	/*
+	 * This is early code, use an open coded check for SME instead of
+	 * using cc_platform_has(). This eliminates worries about removing
+	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
+	 * function.
+	 */
+	if (!sme_get_me_mask() ||
+	    RIP_REL_REF(sev_status) & MSR_AMD64_SEV_ENABLED)
+		return;
+
+	/*
+	 * Prepare for encrypting the kernel and initrd by building new
+	 * pagetables with the necessary attributes needed to encrypt the
+	 * kernel in place.
+	 *
+	 *   One range of virtual addresses will map the memory occupied
+	 *   by the kernel and initrd as encrypted.
+	 *
+	 *   Another range of virtual addresses will map the memory occupied
+	 *   by the kernel and initrd as decrypted and write-protected.
+	 *
+	 *     The use of write-protect attribute will prevent any of the
+	 *     memory from being cached.
+	 */
+
+	kernel_start = (unsigned long)rip_rel_ptr(_text);
+	kernel_end = ALIGN((unsigned long)rip_rel_ptr(_end), PMD_SIZE);
+	kernel_len = kernel_end - kernel_start;
+
+	initrd_start = 0;
+	initrd_end = 0;
+	initrd_len = 0;
+#ifdef CONFIG_BLK_DEV_INITRD
+	initrd_len = (unsigned long)bp->hdr.ramdisk_size |
+		     ((unsigned long)bp->ext_ramdisk_size << 32);
+	if (initrd_len) {
+		initrd_start = (unsigned long)bp->hdr.ramdisk_image |
+			       ((unsigned long)bp->ext_ramdisk_image << 32);
+		initrd_end = PAGE_ALIGN(initrd_start + initrd_len);
+		initrd_len = initrd_end - initrd_start;
+	}
+#endif
+
+	/*
+	 * Calculate required number of workarea bytes needed:
+	 *   executable encryption area size:
+	 *     stack page (PAGE_SIZE)
+	 *     encryption routine page (PAGE_SIZE)
+	 *     intermediate copy buffer (PMD_SIZE)
+	 *   pagetable structures for the encryption of the kernel
+	 *   pagetable structures for workarea (in case not currently mapped)
+	 */
+	execute_start = workarea_start = (unsigned long)rip_rel_ptr(sme_workarea);
+	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
+	execute_len = execute_end - execute_start;
+
+	/*
+	 * One PGD for both encrypted and decrypted mappings and a set of
+	 * PUDs and PMDs for each of the encrypted and decrypted mappings.
+	 */
+	pgtable_area_len = sizeof(pgd_t) * PTRS_PER_PGD;
+	pgtable_area_len += sme_pgtable_calc(execute_end - kernel_start) * 2;
+	if (initrd_len)
+		pgtable_area_len += sme_pgtable_calc(initrd_len) * 2;
+
+	/* PUDs and PMDs needed in the current pagetables for the workarea */
+	pgtable_area_len += sme_pgtable_calc(execute_len + pgtable_area_len);
+
+	/*
+	 * The total workarea includes the executable encryption area and
+	 * the pagetable area. The start of the workarea is already 2MB
+	 * aligned, align the end of the workarea on a 2MB boundary so that
+	 * we don't try to create/allocate PTE entries from the workarea
+	 * before it is mapped.
+	 */
+	workarea_len = execute_len + pgtable_area_len;
+	workarea_end = ALIGN(workarea_start + workarea_len, PMD_SIZE);
+
+	/*
+	 * Set the address to the start of where newly created pagetable
+	 * structures (PGDs, PUDs and PMDs) will be allocated. New pagetable
+	 * structures are created when the workarea is added to the current
+	 * pagetables and when the new encrypted and decrypted kernel
+	 * mappings are populated.
+	 */
+	ppd.pgtable_area = (void *)execute_end;
+
+	/*
+	 * Make sure the current pagetable structure has entries for
+	 * addressing the workarea.
+	 */
+	ppd.pgd = (pgd_t *)native_read_cr3_pa();
+	ppd.paddr = workarea_start;
+	ppd.vaddr = workarea_start;
+	ppd.vaddr_end = workarea_end;
+	sme_map_range_decrypted(&ppd);
+
+	/* Flush the TLB - no globals so cr3 is enough */
+	native_write_cr3(__native_read_cr3());
+
+	/*
+	 * A new pagetable structure is being built to allow for the kernel
+	 * and initrd to be encrypted. It starts with an empty PGD that will
+	 * then be populated with new PUDs and PMDs as the encrypted and
+	 * decrypted kernel mappings are created.
+	 */
+	ppd.pgd = ppd.pgtable_area;
+	memset(ppd.pgd, 0, sizeof(pgd_t) * PTRS_PER_PGD);
+	ppd.pgtable_area += sizeof(pgd_t) * PTRS_PER_PGD;
+
+	/*
+	 * A different PGD index/entry must be used to get different
+	 * pagetable entries for the decrypted mapping. Choose the next
+	 * PGD index and convert it to a virtual address to be used as
+	 * the base of the mapping.
+	 */
+	decrypted_base = (pgd_index(workarea_end) + 1) & (PTRS_PER_PGD - 1);
+	if (initrd_len) {
+		unsigned long check_base;
+
+		check_base = (pgd_index(initrd_end) + 1) & (PTRS_PER_PGD - 1);
+		decrypted_base = max(decrypted_base, check_base);
+	}
+	decrypted_base <<= PGDIR_SHIFT;
+
+	/* Add encrypted kernel (identity) mappings */
+	ppd.paddr = kernel_start;
+	ppd.vaddr = kernel_start;
+	ppd.vaddr_end = kernel_end;
+	sme_map_range_encrypted(&ppd);
+
+	/* Add decrypted, write-protected kernel (non-identity) mappings */
+	ppd.paddr = kernel_start;
+	ppd.vaddr = kernel_start + decrypted_base;
+	ppd.vaddr_end = kernel_end + decrypted_base;
+	sme_map_range_decrypted_wp(&ppd);
+
+	if (initrd_len) {
+		/* Add encrypted initrd (identity) mappings */
+		ppd.paddr = initrd_start;
+		ppd.vaddr = initrd_start;
+		ppd.vaddr_end = initrd_end;
+		sme_map_range_encrypted(&ppd);
+		/*
+		 * Add decrypted, write-protected initrd (non-identity) mappings
+		 */
+		ppd.paddr = initrd_start;
+		ppd.vaddr = initrd_start + decrypted_base;
+		ppd.vaddr_end = initrd_end + decrypted_base;
+		sme_map_range_decrypted_wp(&ppd);
+	}
+
+	/* Add decrypted workarea mappings to both kernel mappings */
+	ppd.paddr = workarea_start;
+	ppd.vaddr = workarea_start;
+	ppd.vaddr_end = workarea_end;
+	sme_map_range_decrypted(&ppd);
+
+	ppd.paddr = workarea_start;
+	ppd.vaddr = workarea_start + decrypted_base;
+	ppd.vaddr_end = workarea_end + decrypted_base;
+	sme_map_range_decrypted(&ppd);
+
+	/* Perform the encryption */
+	sme_encrypt_execute(kernel_start, kernel_start + decrypted_base,
+			    kernel_len, workarea_start, (unsigned long)ppd.pgd);
+
+	if (initrd_len)
+		sme_encrypt_execute(initrd_start, initrd_start + decrypted_base,
+				    initrd_len, workarea_start,
+				    (unsigned long)ppd.pgd);
+
+	/*
+	 * At this point we are running encrypted.  Remove the mappings for
+	 * the decrypted areas - all that is needed for this is to remove
+	 * the PGD entry/entries.
+	 */
+	ppd.vaddr = kernel_start + decrypted_base;
+	ppd.vaddr_end = kernel_end + decrypted_base;
+	sme_clear_pgd(&ppd);
+
+	if (initrd_len) {
+		ppd.vaddr = initrd_start + decrypted_base;
+		ppd.vaddr_end = initrd_end + decrypted_base;
+		sme_clear_pgd(&ppd);
+	}
+
+	ppd.vaddr = workarea_start + decrypted_base;
+	ppd.vaddr_end = workarea_end + decrypted_base;
+	sme_clear_pgd(&ppd);
+
+	/* Flush the TLB - no globals so cr3 is enough */
+	native_write_cr3(__native_read_cr3());
+}
+
+void __head sme_enable(struct boot_params *bp)
+{
+	unsigned int eax, ebx, ecx, edx;
+	unsigned long feature_mask;
+	unsigned long me_mask;
+	bool snp_en;
+	u64 msr;
+
+	snp_en = snp_init(bp);
+
+	/* Check for the SME/SEV support leaf */
+	eax = 0x80000000;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	if (eax < 0x8000001f)
+		return;
+
+#define AMD_SME_BIT	BIT(0)
+#define AMD_SEV_BIT	BIT(1)
+
+	/*
+	 * Check for the SME/SEV feature:
+	 *   CPUID Fn8000_001F[EAX]
+	 *   - Bit 0 - Secure Memory Encryption support
+	 *   - Bit 1 - Secure Encrypted Virtualization support
+	 *   CPUID Fn8000_001F[EBX]
+	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
+	 */
+	eax = 0x8000001f;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	/* Check whether SEV or SME is supported */
+	if (!(eax & (AMD_SEV_BIT | AMD_SME_BIT)))
+		return;
+
+	me_mask = 1UL << (ebx & 0x3f);
+
+	/* Check the SEV MSR whether SEV or SME is enabled */
+	RIP_REL_REF(sev_status) = msr = __rdmsr(MSR_AMD64_SEV);
+	feature_mask = (msr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
+
+	/*
+	 * Any discrepancies between the presence of a CC blob and SNP
+	 * enablement abort the guest.
+	 */
+	if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
+		snp_abort();
+
+	/* Check if memory encryption is enabled */
+	if (feature_mask == AMD_SME_BIT) {
+		if (!(bp->hdr.xloadflags & XLF_MEM_ENCRYPTION))
+			return;
+
+		/*
+		 * No SME if Hypervisor bit is set. This check is here to
+		 * prevent a guest from trying to enable SME. For running as a
+		 * KVM guest the MSR_AMD64_SYSCFG will be sufficient, but there
+		 * might be other hypervisors which emulate that MSR as non-zero
+		 * or even pass it through to the guest.
+		 * A malicious hypervisor can still trick a guest into this
+		 * path, but there is no way to protect against that.
+		 */
+		eax = 1;
+		ecx = 0;
+		native_cpuid(&eax, &ebx, &ecx, &edx);
+		if (ecx & BIT(31))
+			return;
+
+		/* For SME, check the SYSCFG MSR */
+		msr = __rdmsr(MSR_AMD64_SYSCFG);
+		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
+			return;
+	}
+
+	RIP_REL_REF(sme_me_mask) = me_mask;
+	RIP_REL_REF(physical_mask) &= ~me_mask;
+	RIP_REL_REF(cc_vendor) = CC_VENDOR_AMD;
+	cc_set_mask(me_mask);
+}
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 32035d5..3faa60f 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -3,12 +3,10 @@
 KCOV_INSTRUMENT_tlb.o			:= n
 KCOV_INSTRUMENT_mem_encrypt.o		:= n
 KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
-KCOV_INSTRUMENT_mem_encrypt_identity.o	:= n
 KCOV_INSTRUMENT_pgprot.o		:= n
 
 KASAN_SANITIZE_mem_encrypt.o		:= n
 KASAN_SANITIZE_mem_encrypt_amd.o	:= n
-KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 KASAN_SANITIZE_pgprot.o		:= n
 
 # Disable KCSAN entirely, because otherwise we get warnings that some functions
@@ -16,12 +14,10 @@ KASAN_SANITIZE_pgprot.o		:= n
 KCSAN_SANITIZE := n
 # Avoid recursion by not calling KMSAN hooks for CEA code.
 KMSAN_SANITIZE_cpu_entry_area.o := n
-KMSAN_SANITIZE_mem_encrypt_identity.o := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_amd.o		= -pg
-CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
 CFLAGS_REMOVE_pgprot.o			= -pg
 endif
 
@@ -32,7 +28,6 @@ obj-y				+= pat/
 
 # Make sure __phys_addr has no stackprotector
 CFLAGS_physaddr.o		:= -fno-stack-protector
-CFLAGS_mem_encrypt_identity.o	:= -fno-stack-protector
 
 CFLAGS_fault.o := -I $(src)/../include/asm/trace
 
@@ -63,5 +58,4 @@ obj-$(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)	+= pti.o
 obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
 
-obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
deleted file mode 100644
index e7fb377..0000000
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ /dev/null
@@ -1,569 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * AMD Memory Encryption Support
- *
- * Copyright (C) 2016 Advanced Micro Devices, Inc.
- *
- * Author: Tom Lendacky <thomas.lendacky@amd.com>
- */
-
-/*
- * Since we're dealing with identity mappings, physical and virtual
- * addresses are the same, so override these defines which are ultimately
- * used by the headers in misc.h.
- */
-#define __pa(x)  ((unsigned long)(x))
-#define __va(x)  ((void *)((unsigned long)(x)))
-
-/*
- * Special hack: we have to be careful, because no indirections are
- * allowed here, and paravirt_ops is a kind of one. As it will only run in
- * baremetal anyway, we just keep it from happening. (This list needs to
- * be extended when new paravirt and debugging variants are added.)
- */
-#undef CONFIG_PARAVIRT
-#undef CONFIG_PARAVIRT_XXL
-#undef CONFIG_PARAVIRT_SPINLOCKS
-
-/*
- * This code runs before CPU feature bits are set. By default, the
- * pgtable_l5_enabled() function uses bit X86_FEATURE_LA57 to determine if
- * 5-level paging is active, so that won't work here. USE_EARLY_PGTABLE_L5
- * is provided to handle this situation and, instead, use a variable that
- * has been set by the early boot code.
- */
-#define USE_EARLY_PGTABLE_L5
-
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/mem_encrypt.h>
-#include <linux/cc_platform.h>
-
-#include <asm/init.h>
-#include <asm/setup.h>
-#include <asm/sections.h>
-#include <asm/coco.h>
-#include <asm/sev.h>
-
-#include "mm_internal.h"
-
-#define PGD_FLAGS		_KERNPG_TABLE_NOENC
-#define P4D_FLAGS		_KERNPG_TABLE_NOENC
-#define PUD_FLAGS		_KERNPG_TABLE_NOENC
-#define PMD_FLAGS		_KERNPG_TABLE_NOENC
-
-#define PMD_FLAGS_LARGE		(__PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL)
-
-#define PMD_FLAGS_DEC		PMD_FLAGS_LARGE
-#define PMD_FLAGS_DEC_WP	((PMD_FLAGS_DEC & ~_PAGE_LARGE_CACHE_MASK) | \
-				 (_PAGE_PAT_LARGE | _PAGE_PWT))
-
-#define PMD_FLAGS_ENC		(PMD_FLAGS_LARGE | _PAGE_ENC)
-
-#define PTE_FLAGS		(__PAGE_KERNEL_EXEC & ~_PAGE_GLOBAL)
-
-#define PTE_FLAGS_DEC		PTE_FLAGS
-#define PTE_FLAGS_DEC_WP	((PTE_FLAGS_DEC & ~_PAGE_CACHE_MASK) | \
-				 (_PAGE_PAT | _PAGE_PWT))
-
-#define PTE_FLAGS_ENC		(PTE_FLAGS | _PAGE_ENC)
-
-struct sme_populate_pgd_data {
-	void    *pgtable_area;
-	pgd_t   *pgd;
-
-	pmdval_t pmd_flags;
-	pteval_t pte_flags;
-	unsigned long paddr;
-
-	unsigned long vaddr;
-	unsigned long vaddr_end;
-};
-
-/*
- * This work area lives in the .init.scratch section, which lives outside of
- * the kernel proper. It is sized to hold the intermediate copy buffer and
- * more than enough pagetable pages.
- *
- * By using this section, the kernel can be encrypted in place and it
- * avoids any possibility of boot parameters or initramfs images being
- * placed such that the in-place encryption logic overwrites them.  This
- * section is 2MB aligned to allow for simple pagetable setup using only
- * PMD entries (see vmlinux.lds.S).
- */
-static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
-
-static void __head sme_clear_pgd(struct sme_populate_pgd_data *ppd)
-{
-	unsigned long pgd_start, pgd_end, pgd_size;
-	pgd_t *pgd_p;
-
-	pgd_start = ppd->vaddr & PGDIR_MASK;
-	pgd_end = ppd->vaddr_end & PGDIR_MASK;
-
-	pgd_size = (((pgd_end - pgd_start) / PGDIR_SIZE) + 1) * sizeof(pgd_t);
-
-	pgd_p = ppd->pgd + pgd_index(ppd->vaddr);
-
-	memset(pgd_p, 0, pgd_size);
-}
-
-static pud_t __head *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-
-	pgd = ppd->pgd + pgd_index(ppd->vaddr);
-	if (pgd_none(*pgd)) {
-		p4d = ppd->pgtable_area;
-		memset(p4d, 0, sizeof(*p4d) * PTRS_PER_P4D);
-		ppd->pgtable_area += sizeof(*p4d) * PTRS_PER_P4D;
-		set_pgd(pgd, __pgd(PGD_FLAGS | __pa(p4d)));
-	}
-
-	p4d = p4d_offset(pgd, ppd->vaddr);
-	if (p4d_none(*p4d)) {
-		pud = ppd->pgtable_area;
-		memset(pud, 0, sizeof(*pud) * PTRS_PER_PUD);
-		ppd->pgtable_area += sizeof(*pud) * PTRS_PER_PUD;
-		set_p4d(p4d, __p4d(P4D_FLAGS | __pa(pud)));
-	}
-
-	pud = pud_offset(p4d, ppd->vaddr);
-	if (pud_none(*pud)) {
-		pmd = ppd->pgtable_area;
-		memset(pmd, 0, sizeof(*pmd) * PTRS_PER_PMD);
-		ppd->pgtable_area += sizeof(*pmd) * PTRS_PER_PMD;
-		set_pud(pud, __pud(PUD_FLAGS | __pa(pmd)));
-	}
-
-	if (pud_leaf(*pud))
-		return NULL;
-
-	return pud;
-}
-
-static void __head sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
-{
-	pud_t *pud;
-	pmd_t *pmd;
-
-	pud = sme_prepare_pgd(ppd);
-	if (!pud)
-		return;
-
-	pmd = pmd_offset(pud, ppd->vaddr);
-	if (pmd_leaf(*pmd))
-		return;
-
-	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
-}
-
-static void __head sme_populate_pgd(struct sme_populate_pgd_data *ppd)
-{
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	pud = sme_prepare_pgd(ppd);
-	if (!pud)
-		return;
-
-	pmd = pmd_offset(pud, ppd->vaddr);
-	if (pmd_none(*pmd)) {
-		pte = ppd->pgtable_area;
-		memset(pte, 0, sizeof(*pte) * PTRS_PER_PTE);
-		ppd->pgtable_area += sizeof(*pte) * PTRS_PER_PTE;
-		set_pmd(pmd, __pmd(PMD_FLAGS | __pa(pte)));
-	}
-
-	if (pmd_leaf(*pmd))
-		return;
-
-	pte = pte_offset_kernel(pmd, ppd->vaddr);
-	if (pte_none(*pte))
-		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
-}
-
-static void __head __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
-{
-	while (ppd->vaddr < ppd->vaddr_end) {
-		sme_populate_pgd_large(ppd);
-
-		ppd->vaddr += PMD_SIZE;
-		ppd->paddr += PMD_SIZE;
-	}
-}
-
-static void __head __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
-{
-	while (ppd->vaddr < ppd->vaddr_end) {
-		sme_populate_pgd(ppd);
-
-		ppd->vaddr += PAGE_SIZE;
-		ppd->paddr += PAGE_SIZE;
-	}
-}
-
-static void __head __sme_map_range(struct sme_populate_pgd_data *ppd,
-				   pmdval_t pmd_flags, pteval_t pte_flags)
-{
-	unsigned long vaddr_end;
-
-	ppd->pmd_flags = pmd_flags;
-	ppd->pte_flags = pte_flags;
-
-	/* Save original end value since we modify the struct value */
-	vaddr_end = ppd->vaddr_end;
-
-	/* If start is not 2MB aligned, create PTE entries */
-	ppd->vaddr_end = ALIGN(ppd->vaddr, PMD_SIZE);
-	__sme_map_range_pte(ppd);
-
-	/* Create PMD entries */
-	ppd->vaddr_end = vaddr_end & PMD_MASK;
-	__sme_map_range_pmd(ppd);
-
-	/* If end is not 2MB aligned, create PTE entries */
-	ppd->vaddr_end = vaddr_end;
-	__sme_map_range_pte(ppd);
-}
-
-static void __head sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
-{
-	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
-}
-
-static void __head sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
-{
-	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
-}
-
-static void __head sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
-{
-	__sme_map_range(ppd, PMD_FLAGS_DEC_WP, PTE_FLAGS_DEC_WP);
-}
-
-static unsigned long __head sme_pgtable_calc(unsigned long len)
-{
-	unsigned long entries = 0, tables = 0;
-
-	/*
-	 * Perform a relatively simplistic calculation of the pagetable
-	 * entries that are needed. Those mappings will be covered mostly
-	 * by 2MB PMD entries so we can conservatively calculate the required
-	 * number of P4D, PUD and PMD structures needed to perform the
-	 * mappings.  For mappings that are not 2MB aligned, PTE mappings
-	 * would be needed for the start and end portion of the address range
-	 * that fall outside of the 2MB alignment.  This results in, at most,
-	 * two extra pages to hold PTE entries for each range that is mapped.
-	 * Incrementing the count for each covers the case where the addresses
-	 * cross entries.
-	 */
-
-	/* PGDIR_SIZE is equal to P4D_SIZE on 4-level machine. */
-	if (PTRS_PER_P4D > 1)
-		entries += (DIV_ROUND_UP(len, PGDIR_SIZE) + 1) * sizeof(p4d_t) * PTRS_PER_P4D;
-	entries += (DIV_ROUND_UP(len, P4D_SIZE) + 1) * sizeof(pud_t) * PTRS_PER_PUD;
-	entries += (DIV_ROUND_UP(len, PUD_SIZE) + 1) * sizeof(pmd_t) * PTRS_PER_PMD;
-	entries += 2 * sizeof(pte_t) * PTRS_PER_PTE;
-
-	/*
-	 * Now calculate the added pagetable structures needed to populate
-	 * the new pagetables.
-	 */
-
-	if (PTRS_PER_P4D > 1)
-		tables += DIV_ROUND_UP(entries, PGDIR_SIZE) * sizeof(p4d_t) * PTRS_PER_P4D;
-	tables += DIV_ROUND_UP(entries, P4D_SIZE) * sizeof(pud_t) * PTRS_PER_PUD;
-	tables += DIV_ROUND_UP(entries, PUD_SIZE) * sizeof(pmd_t) * PTRS_PER_PMD;
-
-	return entries + tables;
-}
-
-void __head sme_encrypt_kernel(struct boot_params *bp)
-{
-	unsigned long workarea_start, workarea_end, workarea_len;
-	unsigned long execute_start, execute_end, execute_len;
-	unsigned long kernel_start, kernel_end, kernel_len;
-	unsigned long initrd_start, initrd_end, initrd_len;
-	struct sme_populate_pgd_data ppd;
-	unsigned long pgtable_area_len;
-	unsigned long decrypted_base;
-
-	/*
-	 * This is early code, use an open coded check for SME instead of
-	 * using cc_platform_has(). This eliminates worries about removing
-	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
-	 * function.
-	 */
-	if (!sme_get_me_mask() ||
-	    RIP_REL_REF(sev_status) & MSR_AMD64_SEV_ENABLED)
-		return;
-
-	/*
-	 * Prepare for encrypting the kernel and initrd by building new
-	 * pagetables with the necessary attributes needed to encrypt the
-	 * kernel in place.
-	 *
-	 *   One range of virtual addresses will map the memory occupied
-	 *   by the kernel and initrd as encrypted.
-	 *
-	 *   Another range of virtual addresses will map the memory occupied
-	 *   by the kernel and initrd as decrypted and write-protected.
-	 *
-	 *     The use of write-protect attribute will prevent any of the
-	 *     memory from being cached.
-	 */
-
-	kernel_start = (unsigned long)rip_rel_ptr(_text);
-	kernel_end = ALIGN((unsigned long)rip_rel_ptr(_end), PMD_SIZE);
-	kernel_len = kernel_end - kernel_start;
-
-	initrd_start = 0;
-	initrd_end = 0;
-	initrd_len = 0;
-#ifdef CONFIG_BLK_DEV_INITRD
-	initrd_len = (unsigned long)bp->hdr.ramdisk_size |
-		     ((unsigned long)bp->ext_ramdisk_size << 32);
-	if (initrd_len) {
-		initrd_start = (unsigned long)bp->hdr.ramdisk_image |
-			       ((unsigned long)bp->ext_ramdisk_image << 32);
-		initrd_end = PAGE_ALIGN(initrd_start + initrd_len);
-		initrd_len = initrd_end - initrd_start;
-	}
-#endif
-
-	/*
-	 * Calculate required number of workarea bytes needed:
-	 *   executable encryption area size:
-	 *     stack page (PAGE_SIZE)
-	 *     encryption routine page (PAGE_SIZE)
-	 *     intermediate copy buffer (PMD_SIZE)
-	 *   pagetable structures for the encryption of the kernel
-	 *   pagetable structures for workarea (in case not currently mapped)
-	 */
-	execute_start = workarea_start = (unsigned long)rip_rel_ptr(sme_workarea);
-	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
-	execute_len = execute_end - execute_start;
-
-	/*
-	 * One PGD for both encrypted and decrypted mappings and a set of
-	 * PUDs and PMDs for each of the encrypted and decrypted mappings.
-	 */
-	pgtable_area_len = sizeof(pgd_t) * PTRS_PER_PGD;
-	pgtable_area_len += sme_pgtable_calc(execute_end - kernel_start) * 2;
-	if (initrd_len)
-		pgtable_area_len += sme_pgtable_calc(initrd_len) * 2;
-
-	/* PUDs and PMDs needed in the current pagetables for the workarea */
-	pgtable_area_len += sme_pgtable_calc(execute_len + pgtable_area_len);
-
-	/*
-	 * The total workarea includes the executable encryption area and
-	 * the pagetable area. The start of the workarea is already 2MB
-	 * aligned, align the end of the workarea on a 2MB boundary so that
-	 * we don't try to create/allocate PTE entries from the workarea
-	 * before it is mapped.
-	 */
-	workarea_len = execute_len + pgtable_area_len;
-	workarea_end = ALIGN(workarea_start + workarea_len, PMD_SIZE);
-
-	/*
-	 * Set the address to the start of where newly created pagetable
-	 * structures (PGDs, PUDs and PMDs) will be allocated. New pagetable
-	 * structures are created when the workarea is added to the current
-	 * pagetables and when the new encrypted and decrypted kernel
-	 * mappings are populated.
-	 */
-	ppd.pgtable_area = (void *)execute_end;
-
-	/*
-	 * Make sure the current pagetable structure has entries for
-	 * addressing the workarea.
-	 */
-	ppd.pgd = (pgd_t *)native_read_cr3_pa();
-	ppd.paddr = workarea_start;
-	ppd.vaddr = workarea_start;
-	ppd.vaddr_end = workarea_end;
-	sme_map_range_decrypted(&ppd);
-
-	/* Flush the TLB - no globals so cr3 is enough */
-	native_write_cr3(__native_read_cr3());
-
-	/*
-	 * A new pagetable structure is being built to allow for the kernel
-	 * and initrd to be encrypted. It starts with an empty PGD that will
-	 * then be populated with new PUDs and PMDs as the encrypted and
-	 * decrypted kernel mappings are created.
-	 */
-	ppd.pgd = ppd.pgtable_area;
-	memset(ppd.pgd, 0, sizeof(pgd_t) * PTRS_PER_PGD);
-	ppd.pgtable_area += sizeof(pgd_t) * PTRS_PER_PGD;
-
-	/*
-	 * A different PGD index/entry must be used to get different
-	 * pagetable entries for the decrypted mapping. Choose the next
-	 * PGD index and convert it to a virtual address to be used as
-	 * the base of the mapping.
-	 */
-	decrypted_base = (pgd_index(workarea_end) + 1) & (PTRS_PER_PGD - 1);
-	if (initrd_len) {
-		unsigned long check_base;
-
-		check_base = (pgd_index(initrd_end) + 1) & (PTRS_PER_PGD - 1);
-		decrypted_base = max(decrypted_base, check_base);
-	}
-	decrypted_base <<= PGDIR_SHIFT;
-
-	/* Add encrypted kernel (identity) mappings */
-	ppd.paddr = kernel_start;
-	ppd.vaddr = kernel_start;
-	ppd.vaddr_end = kernel_end;
-	sme_map_range_encrypted(&ppd);
-
-	/* Add decrypted, write-protected kernel (non-identity) mappings */
-	ppd.paddr = kernel_start;
-	ppd.vaddr = kernel_start + decrypted_base;
-	ppd.vaddr_end = kernel_end + decrypted_base;
-	sme_map_range_decrypted_wp(&ppd);
-
-	if (initrd_len) {
-		/* Add encrypted initrd (identity) mappings */
-		ppd.paddr = initrd_start;
-		ppd.vaddr = initrd_start;
-		ppd.vaddr_end = initrd_end;
-		sme_map_range_encrypted(&ppd);
-		/*
-		 * Add decrypted, write-protected initrd (non-identity) mappings
-		 */
-		ppd.paddr = initrd_start;
-		ppd.vaddr = initrd_start + decrypted_base;
-		ppd.vaddr_end = initrd_end + decrypted_base;
-		sme_map_range_decrypted_wp(&ppd);
-	}
-
-	/* Add decrypted workarea mappings to both kernel mappings */
-	ppd.paddr = workarea_start;
-	ppd.vaddr = workarea_start;
-	ppd.vaddr_end = workarea_end;
-	sme_map_range_decrypted(&ppd);
-
-	ppd.paddr = workarea_start;
-	ppd.vaddr = workarea_start + decrypted_base;
-	ppd.vaddr_end = workarea_end + decrypted_base;
-	sme_map_range_decrypted(&ppd);
-
-	/* Perform the encryption */
-	sme_encrypt_execute(kernel_start, kernel_start + decrypted_base,
-			    kernel_len, workarea_start, (unsigned long)ppd.pgd);
-
-	if (initrd_len)
-		sme_encrypt_execute(initrd_start, initrd_start + decrypted_base,
-				    initrd_len, workarea_start,
-				    (unsigned long)ppd.pgd);
-
-	/*
-	 * At this point we are running encrypted.  Remove the mappings for
-	 * the decrypted areas - all that is needed for this is to remove
-	 * the PGD entry/entries.
-	 */
-	ppd.vaddr = kernel_start + decrypted_base;
-	ppd.vaddr_end = kernel_end + decrypted_base;
-	sme_clear_pgd(&ppd);
-
-	if (initrd_len) {
-		ppd.vaddr = initrd_start + decrypted_base;
-		ppd.vaddr_end = initrd_end + decrypted_base;
-		sme_clear_pgd(&ppd);
-	}
-
-	ppd.vaddr = workarea_start + decrypted_base;
-	ppd.vaddr_end = workarea_end + decrypted_base;
-	sme_clear_pgd(&ppd);
-
-	/* Flush the TLB - no globals so cr3 is enough */
-	native_write_cr3(__native_read_cr3());
-}
-
-void __head sme_enable(struct boot_params *bp)
-{
-	unsigned int eax, ebx, ecx, edx;
-	unsigned long feature_mask;
-	unsigned long me_mask;
-	bool snp_en;
-	u64 msr;
-
-	snp_en = snp_init(bp);
-
-	/* Check for the SME/SEV support leaf */
-	eax = 0x80000000;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	if (eax < 0x8000001f)
-		return;
-
-#define AMD_SME_BIT	BIT(0)
-#define AMD_SEV_BIT	BIT(1)
-
-	/*
-	 * Check for the SME/SEV feature:
-	 *   CPUID Fn8000_001F[EAX]
-	 *   - Bit 0 - Secure Memory Encryption support
-	 *   - Bit 1 - Secure Encrypted Virtualization support
-	 *   CPUID Fn8000_001F[EBX]
-	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
-	 */
-	eax = 0x8000001f;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	/* Check whether SEV or SME is supported */
-	if (!(eax & (AMD_SEV_BIT | AMD_SME_BIT)))
-		return;
-
-	me_mask = 1UL << (ebx & 0x3f);
-
-	/* Check the SEV MSR whether SEV or SME is enabled */
-	RIP_REL_REF(sev_status) = msr = __rdmsr(MSR_AMD64_SEV);
-	feature_mask = (msr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
-
-	/*
-	 * Any discrepancies between the presence of a CC blob and SNP
-	 * enablement abort the guest.
-	 */
-	if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
-		snp_abort();
-
-	/* Check if memory encryption is enabled */
-	if (feature_mask == AMD_SME_BIT) {
-		if (!(bp->hdr.xloadflags & XLF_MEM_ENCRYPTION))
-			return;
-
-		/*
-		 * No SME if Hypervisor bit is set. This check is here to
-		 * prevent a guest from trying to enable SME. For running as a
-		 * KVM guest the MSR_AMD64_SYSCFG will be sufficient, but there
-		 * might be other hypervisors which emulate that MSR as non-zero
-		 * or even pass it through to the guest.
-		 * A malicious hypervisor can still trick a guest into this
-		 * path, but there is no way to protect against that.
-		 */
-		eax = 1;
-		ecx = 0;
-		native_cpuid(&eax, &ebx, &ecx, &edx);
-		if (ecx & BIT(31))
-			return;
-
-		/* For SME, check the SYSCFG MSR */
-		msr = __rdmsr(MSR_AMD64_SYSCFG);
-		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
-			return;
-	}
-
-	RIP_REL_REF(sme_me_mask) = me_mask;
-	RIP_REL_REF(physical_mask) &= ~me_mask;
-	RIP_REL_REF(cc_vendor) = CC_VENDOR_AMD;
-	cc_set_mask(me_mask);
-}

