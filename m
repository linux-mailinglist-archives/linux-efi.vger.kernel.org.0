Return-Path: <linux-efi+bounces-3578-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA362AA86A9
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 16:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F9E18969BB
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD2F1C6FE9;
	Sun,  4 May 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PtG6yLmf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5PKcjnS"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE62B189BB5;
	Sun,  4 May 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746368419; cv=none; b=fZWhIGXqWySq2L3iOY0vjyElXbfDRDTW69cNnBs/+JJd2qd/3Gs5//T4Q8HCRDTB3hpKuROzwYLAT3NwEszSMQR8jklXbxe638S7iZ2iLmN688U7uN1rtzBU4ID8EHmFIQLjy2syQ9V3qgYwqVZdpFKAk5mlorBlV2d9hVh9b/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746368419; c=relaxed/simple;
	bh=8ow8MbyU147hMMcx4Fo/Z3ZUamPCUUSwOVMcW3oz6aU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cV/bPKyzzX9Bg9fs5NxMke3v7XoYpcf7s7Gf+6vOjaRQPd4H2GWn/io5xFIruBTs4bjp25u9T+CrCFZiHvLezoK0awkUOl7xTQurbpHNALTiIyYnDwAHCO5v/dFJ0kNmfEuQXZdxyepYKXRodFzj6bkevWZZrxSAceKwAu3jTwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PtG6yLmf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C5PKcjnS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 May 2025 14:20:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746368415;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztc98rjQsPe95ZjizxjxPuYoZ8HTRfvS5qkih66iMjw=;
	b=PtG6yLmfWh2KhQXuarx3Mk9p18Phc6ww4JCg2I8LlbO5fQbfWD+8kDXt9uNsNfZ1xl/10v
	uaWEULt5gKHoWrTW3L1xaryoUD7T1LujI4W8yItLAB2nhfufobjvhFJ9JAxGQ7ZNoT3k7l
	4pSi9bqMmg2ANYbn79gVgm9q20FNq3ScRQ7tTB2f/iKeKV22XNnB4fY34sVrO2Tz2FUBye
	eMwAi0GeGYSpsnYrPE6dLIaBKrrBxukBVvouht1W5u8PVV5x6AyWQI5ydm+RMO9pH3e5WA
	SMN0cSgjCjKcghDgwAAF0xX1N2qAbD3p+TWDKZYC4wlZDCVCsiO+Bzyna/ORFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746368415;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztc98rjQsPe95ZjizxjxPuYoZ8HTRfvS5qkih66iMjw=;
	b=C5PKcjnSVUcF+gqRkM9tU/kaJXUjwvHqu5r/B8SMQpFfB1pwvx9k4OnL/LTaneBu1zpKzB
	XKB7KYB1wrcBe6Cw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Add a bunch of PIC aliases
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>, Len Brown <len.brown@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250504095230.2932860-39-ardb+git@google.com>
References: <20250504095230.2932860-39-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174636841473.22196.14666018940808044981.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     419cbaf6a56a6e4b7e6d2278302c197f55dec830
Gitweb:        https://git.kernel.org/tip/419cbaf6a56a6e4b7e6d2278302c197f55dec830
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sun, 04 May 2025 11:52:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 15:59:43 +02:00

x86/boot: Add a bunch of PIC aliases

Add aliases for all the data objects that the startup code references -
this is needed so that this code can be moved into its own confined area
where it can only access symbols that have a __pi_ prefix.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250504095230.2932860-39-ardb+git@google.com
---
 arch/x86/coco/core.c            | 2 ++
 arch/x86/kernel/cpu/common.c    | 1 +
 arch/x86/kernel/head64.c        | 4 ++++
 arch/x86/kernel/head_64.S       | 8 ++++++++
 arch/x86/kernel/setup.c         | 1 +
 arch/x86/kernel/vmlinux.lds.S   | 4 ++++
 arch/x86/lib/memcpy_64.S        | 1 +
 arch/x86/lib/memset_64.S        | 1 +
 arch/x86/lib/retpoline.S        | 2 ++
 arch/x86/mm/mem_encrypt_amd.c   | 2 ++
 arch/x86/mm/pgtable.c           | 1 +
 tools/objtool/arch/x86/decode.c | 6 ++++--
 12 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 9a0ddda..d4610af 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -18,7 +18,9 @@
 #include <asm/processor.h>
 
 enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
+SYM_PIC_ALIAS(cc_vendor);
 u64 cc_mask __ro_after_init;
+SYM_PIC_ALIAS(cc_mask);
 
 static struct cc_attr_flags {
 	__u64 host_sev_snp	: 1,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 12126ad..f0f8548 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -242,6 +242,7 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
 #endif
 } };
 EXPORT_PER_CPU_SYMBOL_GPL(gdt_page);
+SYM_PIC_ALIAS(gdt_page);
 
 #ifdef CONFIG_X86_64
 static int __init x86_nopcid_setup(char *s)
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 29226f3..510fb41 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -48,6 +48,7 @@
  */
 extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
 unsigned int __initdata next_early_pgt;
+SYM_PIC_ALIAS(next_early_pgt);
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 #ifdef CONFIG_X86_5LEVEL
@@ -61,10 +62,13 @@ EXPORT_SYMBOL(ptrs_per_p4d);
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
+SYM_PIC_ALIAS(page_offset_base);
 unsigned long vmalloc_base __ro_after_init = __VMALLOC_BASE_L4;
 EXPORT_SYMBOL(vmalloc_base);
+SYM_PIC_ALIAS(vmalloc_base);
 unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
 EXPORT_SYMBOL(vmemmap_base);
+SYM_PIC_ALIAS(vmemmap_base);
 #endif
 
 /* Wipe all early page tables except for the kernel symbol map */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index fefe2a2..0694208 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -573,6 +573,7 @@ SYM_CODE_START_NOALIGN(vc_no_ghcb)
 	/* Pure iret required here - don't use INTERRUPT_RETURN */
 	iretq
 SYM_CODE_END(vc_no_ghcb)
+SYM_PIC_ALIAS(vc_no_ghcb);
 #endif
 
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
@@ -604,10 +605,12 @@ SYM_DATA_START_PTI_ALIGNED(early_top_pgt)
 	.quad	level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 	.fill	PTI_USER_PGD_FILL,8,0
 SYM_DATA_END(early_top_pgt)
+SYM_PIC_ALIAS(early_top_pgt)
 
 SYM_DATA_START_PAGE_ALIGNED(early_dynamic_pgts)
 	.fill	512*EARLY_DYNAMIC_PAGE_TABLES,8,0
 SYM_DATA_END(early_dynamic_pgts)
+SYM_PIC_ALIAS(early_dynamic_pgts);
 
 SYM_DATA(early_recursion_flag, .long 0)
 
@@ -651,6 +654,7 @@ SYM_DATA_START_PAGE_ALIGNED(level4_kernel_pgt)
 	.fill	511,8,0
 	.quad	level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 SYM_DATA_END(level4_kernel_pgt)
+SYM_PIC_ALIAS(level4_kernel_pgt)
 #endif
 
 SYM_DATA_START_PAGE_ALIGNED(level3_kernel_pgt)
@@ -659,6 +663,7 @@ SYM_DATA_START_PAGE_ALIGNED(level3_kernel_pgt)
 	.quad	level2_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.quad	level2_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 SYM_DATA_END(level3_kernel_pgt)
+SYM_PIC_ALIAS(level3_kernel_pgt)
 
 SYM_DATA_START_PAGE_ALIGNED(level2_kernel_pgt)
 	/*
@@ -676,6 +681,7 @@ SYM_DATA_START_PAGE_ALIGNED(level2_kernel_pgt)
 	 */
 	PMDS(0, __PAGE_KERNEL_LARGE_EXEC, KERNEL_IMAGE_SIZE/PMD_SIZE)
 SYM_DATA_END(level2_kernel_pgt)
+SYM_PIC_ALIAS(level2_kernel_pgt)
 
 SYM_DATA_START_PAGE_ALIGNED(level2_fixmap_pgt)
 	.fill	(512 - 4 - FIXMAP_PMD_NUM),8,0
@@ -688,6 +694,7 @@ SYM_DATA_START_PAGE_ALIGNED(level2_fixmap_pgt)
 	/* 6 MB reserved space + a 2MB hole */
 	.fill	4,8,0
 SYM_DATA_END(level2_fixmap_pgt)
+SYM_PIC_ALIAS(level2_fixmap_pgt)
 
 SYM_DATA_START_PAGE_ALIGNED(level1_fixmap_pgt)
 	.rept (FIXMAP_PMD_NUM)
@@ -703,6 +710,7 @@ SYM_DATA(smpboot_control,		.long 0)
 	.align 16
 /* This must match the first entry in level2_kernel_pgt */
 SYM_DATA(phys_base, .quad 0x0)
+SYM_PIC_ALIAS(phys_base);
 EXPORT_SYMBOL(phys_base)
 
 #include "../xen/xen-head.S"
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 9d2a13b..e0cf159 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -134,6 +134,7 @@ struct ist_info ist_info;
 
 struct cpuinfo_x86 boot_cpu_data __read_mostly;
 EXPORT_SYMBOL(boot_cpu_data);
+SYM_PIC_ALIAS(boot_cpu_data);
 
 #if !defined(CONFIG_X86_PAE) || defined(CONFIG_X86_64)
 __visible unsigned long mmu_cr4_features __ro_after_init;
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index ccdc45e..9340c74 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -79,11 +79,13 @@ const_cpu_current_top_of_stack = cpu_current_top_of_stack;
 #define BSS_DECRYPTED						\
 	. = ALIGN(PMD_SIZE);					\
 	__start_bss_decrypted = .;				\
+	__pi___start_bss_decrypted = .;				\
 	*(.bss..decrypted);					\
 	. = ALIGN(PAGE_SIZE);					\
 	__start_bss_decrypted_unused = .;			\
 	. = ALIGN(PMD_SIZE);					\
 	__end_bss_decrypted = .;				\
+	__pi___end_bss_decrypted = .;				\
 
 #else
 
@@ -128,6 +130,7 @@ SECTIONS
 	/* Text and read-only data */
 	.text :  AT(ADDR(.text) - LOAD_OFFSET) {
 		_text = .;
+		__pi__text = .;
 		_stext = .;
 		ALIGN_ENTRY_TEXT_BEGIN
 		*(.text..__x86.rethunk_untrain)
@@ -391,6 +394,7 @@ SECTIONS
 
 	. = ALIGN(PAGE_SIZE);		/* keep VO_INIT_SIZE page aligned */
 	_end = .;
+	__pi__end = .;
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/*
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 0ae2e17..12a23fa 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -41,6 +41,7 @@ SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
 SYM_FUNC_ALIAS_MEMFUNC(memcpy, __memcpy)
+SYM_PIC_ALIAS(memcpy)
 EXPORT_SYMBOL(memcpy)
 
 SYM_FUNC_START_LOCAL(memcpy_orig)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index d66b710..fb5a03c 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -42,6 +42,7 @@ SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(__memset)
 
 SYM_FUNC_ALIAS_MEMFUNC(memset, __memset)
+SYM_PIC_ALIAS(memset)
 EXPORT_SYMBOL(memset)
 
 SYM_FUNC_START_LOCAL(memset_orig)
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index a26c43a..9f31166 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -40,6 +40,7 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 	ALTERNATIVE_2 __stringify(RETPOLINE \reg), \
 		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg; int3), X86_FEATURE_RETPOLINE_LFENCE, \
 		      __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), ALT_NOT(X86_FEATURE_RETPOLINE)
+SYM_PIC_ALIAS(__x86_indirect_thunk_\reg)
 
 .endm
 
@@ -394,6 +395,7 @@ SYM_CODE_START(__x86_return_thunk)
 #endif
 	int3
 SYM_CODE_END(__x86_return_thunk)
+SYM_PIC_ALIAS(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
 
 #endif /* CONFIG_MITIGATION_RETHUNK */
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 7490ff6..faf3a13 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -40,7 +40,9 @@
  * section is later cleared.
  */
 u64 sme_me_mask __section(".data") = 0;
+SYM_PIC_ALIAS(sme_me_mask);
 u64 sev_status __section(".data") = 0;
+SYM_PIC_ALIAS(sev_status);
 u64 sev_check_data __section(".data") = 0;
 EXPORT_SYMBOL(sme_me_mask);
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f7ae44d..e62af72 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -10,6 +10,7 @@
 #ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
 phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
 EXPORT_SYMBOL(physical_mask);
+SYM_PIC_ALIAS(physical_mask);
 #endif
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 3ce7b54..331b9a7 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -842,12 +842,14 @@ int arch_decode_hint_reg(u8 sp_reg, int *base)
 
 bool arch_is_retpoline(struct symbol *sym)
 {
-	return !strncmp(sym->name, "__x86_indirect_", 15);
+	return !strncmp(sym->name, "__x86_indirect_", 15) ||
+	       !strncmp(sym->name, "__pi___x86_indirect_", 20);
 }
 
 bool arch_is_rethunk(struct symbol *sym)
 {
-	return !strcmp(sym->name, "__x86_return_thunk");
+	return !strcmp(sym->name, "__x86_return_thunk") ||
+	       !strcmp(sym->name, "__pi___x86_return_thunk");
 }
 
 bool arch_is_embedded_insn(struct symbol *sym)

