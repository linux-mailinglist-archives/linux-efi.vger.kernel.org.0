Return-Path: <linux-efi+bounces-3565-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 428FCAA85B8
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CEB1681C8
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA151E5B66;
	Sun,  4 May 2025 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kzvKqXMF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23401E0DDC
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352417; cv=none; b=KAX9/nqYdJA830S9cj+TFA8dB/cEJL7ON4+bMeM3zEVe2YfxsPuSIiuSMbzmQW82MQRRZf9PCzNpt0Nv0niNt9UzGqoKz/zi8jqjfz6raDgukbye0YSpaa2as+SjfbwTILcZa30+HBL2wXCZ69MJOnEaQm98retpzr0IAnBUPWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352417; c=relaxed/simple;
	bh=sWOuNmVwqKJsh6FN9Hqj8hllxNw9ztxUry+Dj4yIv+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rEMfYxwGV03OdpsPi7qHkRf+LYEgEyHbBwCD1RhSGzy5Xc6z9bti6nU+ea952hLKLQviLGYMs9qqiR64fbdNM0ZAFYHDGtn/hlFzjN8QimxsTdRf39xUUieC6UQQRtFO77a8Fg3547wE10rxkijW0QXeU2+FgJkRAkbSSpYJoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kzvKqXMF; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cec217977so19585045e9.0
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352413; x=1746957213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ko26uMulVFMdtYJyNTvHF5NZmrI36k7LhGtmC9vPdWo=;
        b=kzvKqXMFQPxwy9S6K2i8stNhQ4vQw5jxv7AMC1XD64QyvhJCG6noGojnFYCnIiutHG
         pTJi3FK6B36oUe3a4ccHSTOnT0sscGIxESnPmr0qeJgTb8Lw0K7PAnOkgUVjE2/a4ej4
         YVFI2nw5vJlk+Djjnw84QLUkPkrjAXYN2p9zeIjgVLsq+jt5AcfwxIIr2zrz1qvL4XnC
         TWX4ZHZFpvVJ7PgEJ4LeUMbdzMd9d2afw7c8gcx/+vb2GubjOCeez38S8kRiG6SfcoQR
         TxBeEGkhmOJ57f4Kb2MkcC9wYJfRuz+vi1BmcNm3grZiD8sHB/mvip+NFZzq1fFbtf7G
         a4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352413; x=1746957213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ko26uMulVFMdtYJyNTvHF5NZmrI36k7LhGtmC9vPdWo=;
        b=Q5yuV3/4rzR3RLMx3Ti725Kcolrti3laPOrcbeuKSVhLRRG13zL0cG4r0DXTjVxpd4
         5zZzcrbj/W0Pp/Yd1rGKuXf20d7Ju7OTVComQAfSq4l2Gf5ky2wU7ymT6YwIcexX74tk
         nNJavQWoaMNi+/grJpXOmFnJ8BzvmMezAZMIJ8xCc/VcGxLSnduBqNWHqWoGveJOZYz1
         U7DWq13Izxk6B+D9qOty7p/XS6PqlI2MZU0IPFWZ71GrNYYUzZRyZAcLNkgBZp0MsuGi
         LZ7K3qVCGP5+eziksETPJFxtzA5YPveMdceMDPsovF1gAu/wEAqcAYYhVwqmnQctBTqW
         OT/A==
X-Gm-Message-State: AOJu0YxBIwqEih4yo9i8OxRWWzjwcWA8tLQxhUyxxf15rsntZnDth5Uk
	l2egt0jIfVP5WO2aV1VzaueEKySXdmae7or0B96YSCBJfMida+v55kwmXtqnhgR4kMslXw==
X-Google-Smtp-Source: AGHT+IFB7cle6HoLINzdo46UDztpATOUd0MvYEfIU5z51g0lhq1Ou7fUuVJhLDjEeEURT36sv/GkKAOE
X-Received: from wmsd5.prod.google.com ([2002:a05:600c:3ac5:b0:43d:4055:98e3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:500d:b0:43d:b3:fb1
 with SMTP id 5b1f17b1804b1-441c4938d9emr23167985e9.27.1746352413379; Sun, 04
 May 2025 02:53:33 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:44 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=9580; i=ardb@kernel.org;
 h=from:subject; bh=7+X4vMIGHoU1bGhpqvlC6g8e24q39Or6xjCqsWJDs+Q=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4mPNA8MteXEV3JJlwlK3k6Q8ojnMj0X+DkntNG5Ys
 qTCr7yjlIVBjINBVkyRRWD233c7T0+UqnWeJQszh5UJZAgDF6cATCSnh5GhZa9cR8E6joKz0cqy
 8tckY5t5Zq2RLNX+K/8mZuu7CZ82MvxP3rYoIFJh3QGGLoWjyo5fDpmWJuQx7XzbJWx07bDZQks uAA==
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-39-ardb+git@google.com>
Subject: [RFT PATCH v2 14/23] x86/boot: Add a bunch of PIC aliases
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Add aliases for all the data objects that the startup code references -
this is needed so that this code can be moved into its own confined area
where it can only access symbols that have a __pi_ prefix.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
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
index 9a0ddda3aa69..d4610af68114 100644
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
index eb6a7f6e20c4..7b8753224f3e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -240,6 +240,7 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
 #endif
 } };
 EXPORT_PER_CPU_SYMBOL_GPL(gdt_page);
+SYM_PIC_ALIAS(gdt_page);
 
 #ifdef CONFIG_X86_64
 static int __init x86_nopcid_setup(char *s)
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 3d49abb1bb3a..b7da8b45b6d8 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -45,15 +45,19 @@
  */
 extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
 unsigned int __initdata next_early_pgt;
+SYM_PIC_ALIAS(next_early_pgt);
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
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
index fefe2a25cf02..069420853304 100644
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
index 9d2a13b37833..e0cf1595a0ab 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -134,6 +134,7 @@ struct ist_info ist_info;
 
 struct cpuinfo_x86 boot_cpu_data __read_mostly;
 EXPORT_SYMBOL(boot_cpu_data);
+SYM_PIC_ALIAS(boot_cpu_data);
 
 #if !defined(CONFIG_X86_PAE) || defined(CONFIG_X86_64)
 __visible unsigned long mmu_cr4_features __ro_after_init;
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index ccdc45e5b759..9340c74b680d 100644
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
index 0ae2e1712e2e..12a23fa7c44c 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -41,6 +41,7 @@ SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
 SYM_FUNC_ALIAS_MEMFUNC(memcpy, __memcpy)
+SYM_PIC_ALIAS(memcpy)
 EXPORT_SYMBOL(memcpy)
 
 SYM_FUNC_START_LOCAL(memcpy_orig)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index d66b710d628f..fb5a03cf5ab7 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -42,6 +42,7 @@ SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(__memset)
 
 SYM_FUNC_ALIAS_MEMFUNC(memset, __memset)
+SYM_PIC_ALIAS(memset)
 EXPORT_SYMBOL(memset)
 
 SYM_FUNC_START_LOCAL(memset_orig)
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index a26c43abd47d..9f3116609c8c 100644
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
index 7490ff6d83b1..faf3a13fb6ba 100644
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
index a05fcddfc811..b871f55c5d20 100644
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
index 3ce7b54003c2..331b9a744410 100644
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
-- 
2.49.0.906.g1f30a19c02-goog


