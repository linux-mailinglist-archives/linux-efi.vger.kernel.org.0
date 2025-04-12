Return-Path: <linux-efi+bounces-3305-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA352A86DBC
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 16:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0785443D1B
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3FE1EF0AC;
	Sat, 12 Apr 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ap0qhEk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JExnEhX2"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599AB1EDA22;
	Sat, 12 Apr 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744468427; cv=none; b=RT6iIqK7SGANpwXruAkEysy1yWjwR3Uh/Vf4qA4gbPLsmdiyEk2EKZbWSBo4h7SnLtzHfFX/q7KeCtXx1ONlRh9U9SCyd5zw4f38QVrz3xQ4MMm8Q1xiB84xU5gSosrofihs62N4+r3CxjNQhORrxQ8IaX/9/gP0u5HmFdfkq/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744468427; c=relaxed/simple;
	bh=WlgZJ0vX7LqWvBDaDKxcBSkriCXQGOWYEDSUxh4HSQk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KRkJm2RrNc/XoM0DeMEBsp7QYG0OhqPV0IiV1aJFCB1kmJBU0eE4WtPGdq0rhBw/mvsPoKEW+1DDhe+AzputeH6XmxVjXhO7tfQ4cCaBE3NrTMQG+3nL2WDfAeX6N+bwJxzNOTskyASNlNatIfENkN4zu4nL3lmrEEfPfovcbAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ap0qhEk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JExnEhX2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 14:33:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744468418;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xTiFDspZOPxWDJmtpIoMRpjjtSswyTbsylDF6QhlZc=;
	b=2ap0qhEkY353C9V0sSjTCkJfhoQVsF3GvyMOhoFphPiwwa+pJfyS1vdFTOhm+oBaosEuEW
	YqMweTWNtLq+rjRm2jxeLJcuLuiDIEksdg9EQXZBdVuejp6GL7imiuSzWR6V/WdNzdpDwf
	Ob6+L2UcqE5dUtNSLvLyqEOUJhFw4D4sASrsOAIGBeA/NPROCUuAfNTqh8eB9WMdHhRRZV
	qIhnchlGhdn+E7mstJWb8yHPHuqA/s6V/8/FfFyzInu9kOT6n/lxYqyx8AvDmTDgtbRBMm
	LyqSP34VJC8qIixpj3Z4IAW0E3RonXHNRASw3W5ahAonhrgdhcwntkwzbBXbWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744468418;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xTiFDspZOPxWDJmtpIoMRpjjtSswyTbsylDF6QhlZc=;
	b=JExnEhX2C/TZve0xONPEkA5K06hfZqBU1tdNDJI03AfJUqGnoGqk7ELnSWCNE1LwrWXom8
	33XwfAw5M2bdYGBA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot: Move early kernel mapping code into startup/
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250410134117.3713574-16-ardb+git@google.com>
References: <20250410134117.3713574-16-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174446841726.31282.8524035661562839300.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     dbe0ad775cbbd614583409d96abbc8ea7edb5eb4
Gitweb:        https://git.kernel.org/tip/dbe0ad775cbbd614583409d96abbc8ea7edb5eb4
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 10 Apr 2025 15:41:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 11:13:05 +02:00

x86/boot: Move early kernel mapping code into startup/

The startup code that constructs the kernel virtual mapping runs from
the 1:1 mapping of memory itself, and therefore, cannot use absolute
symbol references. Before making changes in subsequent patches, move
this code into a separate source file under arch/x86/boot/startup/ where
all such code will be kept from now on.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250410134117.3713574-16-ardb+git@google.com
---
 arch/x86/boot/startup/Makefile     |   2 +-
 arch/x86/boot/startup/map_kernel.c | 224 ++++++++++++++++++++++++++++-
 arch/x86/kernel/head64.c           | 211 +--------------------------
 3 files changed, 226 insertions(+), 211 deletions(-)
 create mode 100644 arch/x86/boot/startup/map_kernel.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 1beb5de..10319ae 100644
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
index 0000000..5f1b7e0
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
index 9b2ffec..6b68a20 100644
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

