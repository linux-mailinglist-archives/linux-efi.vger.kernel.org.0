Return-Path: <linux-efi+bounces-4228-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1056AFE22D
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D66A560D43
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79157283FF1;
	Wed,  9 Jul 2025 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J9fUBOFi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C9283FC8
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048714; cv=none; b=SLr2CFJ+T82BrnO7qG00+hyihV4kSPE7PpI3iLqIuu3I1GA9c5N+Sl+GclOnxHE8+pZY3XeoQ4NNH3K5/CzVirWPltA6SjID+rM8zDLZeqFYSyBaFC2RV/zbahD2qaqPBUOFZviBAqig1UdBBpYNaCjXvJZpBmhiTdNpywDGa18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048714; c=relaxed/simple;
	bh=WGwIkv2HoHKkBaOjhcVk3mbrAUVX1oehUhPVE8wILEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PS2BToL51DGhpvFcK+XESxlYyhlDTC9wgnatnCZRATcYmfNoUwtXzpjinR/ojeNRgpU39qfVpSsM04Pcm9kGhfK7+Pgfa7adIjdXOU55O5dCe9B3Nfxj3eXM4YY8YGBftrjCP695mwDka72Y5oHiHyPITdNYLn6Moo6MR8ZepRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J9fUBOFi; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4538a2f4212so27860295e9.2
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048710; x=1752653510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QtY6TW2swfcp0EdgG0Ej8ocrIPU2TlSXZ3AIyIGaUEQ=;
        b=J9fUBOFiL0GRrf15Z5A8dHoHD56tPXBj6o+dHZ8lc3EYaxWBVf4DG0vXmHkdcCATDw
         DJZQe3AO9vxNb9+Im8irFKKjqHn7OAlIQj5kNrnO/jtsWuDH7/Y7ZbfDIqvIblP+SDuO
         t6WnHAsGaFk/sAEDf4jhzbtjmU/LWf/DpxR7DJy8zrpQNJdgcOYRyt1n2tDReQy+Jrbm
         KoNUE74/Jhm+UJWBAquujTPbu9T3pjvP5XB7jXXlQe0gIu45U2PXUzmXDtBmjzvMCRzp
         hXb7sE0710kW6v3eRoQGvfeInhMVPlGe/pKajJXTRiiyVOOA24X/DYK+bnkxTQRhSwHD
         UVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048710; x=1752653510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtY6TW2swfcp0EdgG0Ej8ocrIPU2TlSXZ3AIyIGaUEQ=;
        b=O67ittYtCnelJa8cBghfuxpwA9oKTq8whgYtFn1GGW/DehKmUHsj3VFVxT26H2h3uu
         +1//vr84dXAZyNT/hui6A8gdQDJHhOMiK0pDKviD8CVLSKAT5WatZacF3leB8klFWpVb
         uNRX7F65p2NRjh7t2p82Sx1A0clnPlszeDngO8RL3oxfanLpkzvmIjR2LCQelja6TuLA
         6bGVh1Wuzwrr6NjxeODBOXiBaw0u0adGEw+YRnshjFm9k2KFnkw12D+WLo/ZICinGQzg
         9ysadLndWVK3aCArOEs+Z1cSHwlLVzqQt60zyWrbT0TxzvifQGleLZMOUZhnysTv9jdT
         Vj7A==
X-Gm-Message-State: AOJu0Yw21MQcsHcOuDZ2moto/GVClwXP+ipvuxSNq5FqdTilbEztkRS3
	/h79u9wmrW+j51E7DgvIgG6i2KRQnLnZM3CUpvdC+Iomf1rxvdAtEosoNKeIvSZDKnw58dL7tg=
	=
X-Google-Smtp-Source: AGHT+IEo0Zs1aRfb0XdlhBfcu5zos1s6HgqDKfUdbpmWc4cSBsae2Ic5q1IiSHApumdXV137tFiczZd9
X-Received: from wmti11.prod.google.com ([2002:a05:600c:8b8b:b0:450:cfda:ece7])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:64ce:0:b0:3a5:8600:7cff
 with SMTP id ffacd0b85a97d-3b5e44e409bmr1163856f8f.1.1752048710261; Wed, 09
 Jul 2025 01:11:50 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:09:04 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=17091; i=ardb@kernel.org;
 h=from:subject; bh=ekxrTB4CqLIayaSSG8sjj/rSFBXz5ufFFA/oHyVBUNY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNP+f+lNZE/HNYcsfL48Thkf+m3qGiN9+7t+3SmWN7cJ
 crR5fS4o5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzEZQrDP7MDMfyFH39E2Xlv
 nhKRuUN8crm4w5oX8aylclcvBTyauJPhv5t3/Pxn9tt9w7N4TZMcwzNmtnvm6HMkSC36r/Pret1 XHgA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-49-ardb+git@google.com>
Subject: [PATCH v4 23/24] x86/boot: Move startup code out of __head section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move startup code out of the __head section, now that this no longer has
a special significance. Move everything into .text or .init.text as
appropriate, so that startup code is not kept around unnecessarily.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      |  3 --
 arch/x86/boot/startup/gdt_idt.c     |  4 +--
 arch/x86/boot/startup/map_kernel.c  |  4 +--
 arch/x86/boot/startup/sev-shared.c  | 38 ++++++++++----------
 arch/x86/boot/startup/sev-startup.c | 14 ++++----
 arch/x86/boot/startup/sme.c         | 26 +++++++-------
 arch/x86/include/asm/init.h         |  6 ----
 arch/x86/kernel/head_32.S           |  2 +-
 arch/x86/kernel/head_64.S           |  2 +-
 arch/x86/platform/pvh/head.S        |  2 +-
 10 files changed, 46 insertions(+), 55 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 5e0fa165e10b..6521530fb701 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -32,9 +32,6 @@ struct ghcb *boot_ghcb;
 #undef __init
 #define __init
 
-#undef __head
-#define __head
-
 #define __BOOT_COMPRESSED
 
 u8 snp_vmpl;
diff --git a/arch/x86/boot/startup/gdt_idt.c b/arch/x86/boot/startup/gdt_idt.c
index a3112a69b06a..d16102abdaec 100644
--- a/arch/x86/boot/startup/gdt_idt.c
+++ b/arch/x86/boot/startup/gdt_idt.c
@@ -24,7 +24,7 @@
 static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
 
 /* This may run while still in the direct mapping */
-void __head startup_64_load_idt(void *vc_handler)
+void startup_64_load_idt(void *vc_handler)
 {
 	struct desc_ptr desc = {
 		.address = (unsigned long)rip_rel_ptr(bringup_idt_table),
@@ -46,7 +46,7 @@ void __head startup_64_load_idt(void *vc_handler)
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
-void __head startup_64_setup_gdt_idt(void)
+void __init startup_64_setup_gdt_idt(void)
 {
 	struct gdt_page *gp = rip_rel_ptr((void *)(__force unsigned long)&gdt_page);
 	void *handler = NULL;
diff --git a/arch/x86/boot/startup/map_kernel.c b/arch/x86/boot/startup/map_kernel.c
index 332dbe6688c4..83ba98d61572 100644
--- a/arch/x86/boot/startup/map_kernel.c
+++ b/arch/x86/boot/startup/map_kernel.c
@@ -30,7 +30,7 @@ static inline bool check_la57_support(void)
 	return true;
 }
 
-static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
+static unsigned long __init sme_postprocess_startup(struct boot_params *bp,
 						    pmdval_t *pmd,
 						    unsigned long p2v_offset)
 {
@@ -84,7 +84,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
  * the 1:1 mapping of memory. Kernel virtual addresses can be determined by
  * subtracting p2v_offset from the RIP-relative address.
  */
-unsigned long __head __startup_64(unsigned long p2v_offset,
+unsigned long __init __startup_64(unsigned long p2v_offset,
 				  struct boot_params *bp)
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] = rip_rel_ptr(early_dynamic_pgts);
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 223eafa56d9d..ce11bab57d4f 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -29,7 +29,7 @@ static u32 cpuid_std_range_max __ro_after_init;
 static u32 cpuid_hyp_range_max __ro_after_init;
 static u32 cpuid_ext_range_max __ro_after_init;
 
-void __head __noreturn
+void __noreturn
 sev_es_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
@@ -45,7 +45,7 @@ sev_es_terminate(unsigned int set, unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
-static u64 __head get_hv_features(void)
+static u64 __init get_hv_features(void)
 {
 	u64 val;
 
@@ -62,7 +62,7 @@ static u64 __head get_hv_features(void)
 	return GHCB_MSR_HV_FT_RESP_VAL(val);
 }
 
-u64 __head snp_check_hv_features(void)
+u64 __init snp_check_hv_features(void)
 {
 	/*
 	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
@@ -240,7 +240,7 @@ const struct snp_cpuid_table *snp_cpuid_get_table(void)
  *
  * Return: XSAVE area size on success, 0 otherwise.
  */
-static u32 __head snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
+static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 	u64 xfeatures_found = 0;
@@ -276,7 +276,7 @@ static u32 __head snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 	return xsave_size;
 }
 
-static bool __head
+static bool
 snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
@@ -318,8 +318,8 @@ static void snp_cpuid_msr_prot(void *ctx, struct cpuid_leaf *leaf)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
-static int __head snp_cpuid_postprocess(void (*cpuid)(void *ctx, struct cpuid_leaf *),
-					void *ctx, struct cpuid_leaf *leaf)
+static int snp_cpuid_postprocess(void (*cpuid)(void *ctx, struct cpuid_leaf *),
+				 void *ctx, struct cpuid_leaf *leaf)
 {
 	struct cpuid_leaf leaf_hv = *leaf;
 
@@ -413,8 +413,8 @@ static int __head snp_cpuid_postprocess(void (*cpuid)(void *ctx, struct cpuid_le
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-int __head snp_cpuid(void (*cpuid)(void *ctx, struct cpuid_leaf *), void *ctx,
-		     struct cpuid_leaf *leaf)
+int snp_cpuid(void (*cpuid)(void *ctx, struct cpuid_leaf *), void *ctx,
+	      struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -456,7 +456,7 @@ int __head snp_cpuid(void (*cpuid)(void *ctx, struct cpuid_leaf *), void *ctx,
  * page yet, so it only supports the MSR based communication with the
  * hypervisor and only the CPUID exit-code.
  */
-void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
+void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
@@ -532,7 +532,7 @@ struct cc_setup_data {
  * Search for a Confidential Computing blob passed in as a setup_data entry
  * via the Linux Boot Protocol.
  */
-static __head
+static __init
 struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
 {
 	struct cc_setup_data *sd = NULL;
@@ -560,7 +560,7 @@ struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
  * mapping needs to be updated in sync with all the changes to virtual memory
  * layout and related mapping facilities throughout the boot process.
  */
-static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 {
 	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
 	int i;
@@ -588,8 +588,8 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 	}
 }
 
-static void __head svsm_pval_4k_page(unsigned long paddr, bool validate,
-				     struct svsm_ca *caa, u64 caa_pa)
+static void svsm_pval_4k_page(unsigned long paddr, bool validate,
+			      struct svsm_ca *caa, u64 caa_pa)
 {
 	struct svsm_pvalidate_call *pc;
 	struct svsm_call call = {};
@@ -628,8 +628,8 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate,
 	native_local_irq_restore(flags);
 }
 
-static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
-				     bool validate, struct svsm_ca *caa, u64 caa_pa)
+static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
+			      bool validate, struct svsm_ca *caa, u64 caa_pa)
 {
 	int ret;
 
@@ -642,8 +642,8 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 	}
 }
 
-static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
-				       enum psc_op op, struct svsm_ca *caa, u64 caa_pa)
+static void __page_state_change(unsigned long vaddr, unsigned long paddr,
+				enum psc_op op, struct svsm_ca *caa, u64 caa_pa)
 {
 	u64 val;
 
@@ -675,7 +675,7 @@ static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
  * services needed when not running in VMPL0.
  */
-static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
+static bool __init svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
 				 void *page)
 {
 	struct snp_secrets_page *secrets_page;
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 0fd80e63b639..f2fb5674283d 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -44,7 +44,7 @@
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
-void __head
+void __init
 early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		      unsigned long npages, enum psc_op op,
 		      struct svsm_ca *caa, u64 caa_pa)
@@ -64,7 +64,7 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 	}
 }
 
-void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 					 unsigned long npages)
 {
 	/*
@@ -84,7 +84,7 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 			      rip_rel_ptr(&boot_svsm_ca_page), boot_svsm_caa_pa);
 }
 
-void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned long npages)
 {
 	/*
@@ -114,7 +114,7 @@ void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
  *
  * Scan for the blob in that order.
  */
-static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+static struct cc_blob_sev_info *__init find_cc_blob(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -140,7 +140,7 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
-static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
+static void __init svsm_setup(struct cc_blob_sev_info *cc_info)
 {
 	struct snp_secrets_page *secrets = (void *)cc_info->secrets_phys;
 	struct svsm_call call = {};
@@ -183,7 +183,7 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	boot_svsm_caa_pa = pa;
 }
 
-bool __head snp_init(struct boot_params *bp)
+bool __init snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -212,7 +212,7 @@ bool __head snp_init(struct boot_params *bp)
 	return true;
 }
 
-void __head __noreturn snp_abort(void)
+void __init __noreturn snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 56dde8c53139..c3eff6d5102c 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -91,7 +91,7 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
-static void __head sme_clear_pgd(struct sme_populate_pgd_data *ppd)
+static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
 	pgd_t *pgd_p;
@@ -106,7 +106,7 @@ static void __head sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 	memset(pgd_p, 0, pgd_size);
 }
 
-static pud_t __head *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
+static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -143,7 +143,7 @@ static pud_t __head *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 	return pud;
 }
 
-static void __head sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
+static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -159,7 +159,7 @@ static void __head sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
-static void __head sme_populate_pgd(struct sme_populate_pgd_data *ppd)
+static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -185,7 +185,7 @@ static void __head sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
-static void __head __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
+static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd_large(ppd);
@@ -195,7 +195,7 @@ static void __head __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __head __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
+static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd(ppd);
@@ -205,7 +205,7 @@ static void __head __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __head __sme_map_range(struct sme_populate_pgd_data *ppd,
+static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
 				   pmdval_t pmd_flags, pteval_t pte_flags)
 {
 	unsigned long vaddr_end;
@@ -229,22 +229,22 @@ static void __head __sme_map_range(struct sme_populate_pgd_data *ppd,
 	__sme_map_range_pte(ppd);
 }
 
-static void __head sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
+static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
 }
 
-static void __head sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
+static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
 }
 
-static void __head sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
+static void __init sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC_WP, PTE_FLAGS_DEC_WP);
 }
 
-static unsigned long __head sme_pgtable_calc(unsigned long len)
+static unsigned long __init sme_pgtable_calc(unsigned long len)
 {
 	unsigned long entries = 0, tables = 0;
 
@@ -281,7 +281,7 @@ static unsigned long __head sme_pgtable_calc(unsigned long len)
 	return entries + tables;
 }
 
-void __head sme_encrypt_kernel(struct boot_params *bp)
+void __init sme_encrypt_kernel(struct boot_params *bp)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
@@ -485,7 +485,7 @@ void __head sme_encrypt_kernel(struct boot_params *bp)
 	native_write_cr3(__native_read_cr3());
 }
 
-void __head sme_enable(struct boot_params *bp)
+void __init sme_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 8b1b1abcef15..01ccdd168df0 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -2,12 +2,6 @@
 #ifndef _ASM_X86_INIT_H
 #define _ASM_X86_INIT_H
 
-#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
-#define __head	__section(".head.text") __no_sanitize_undefined __no_stack_protector
-#else
-#define __head	__section(".head.text") __no_sanitize_undefined
-#endif
-
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
 	void (*free_pgt_page)(void *, void *); /* free buf for page table */
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 76743dfad6ab..437effb1ef03 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -61,7 +61,7 @@ RESERVE_BRK(pagetables, INIT_MAP_SIZE)
  * any particular GDT layout, because we load our own as soon as we
  * can.
  */
-__HEAD
+	__INIT
 SYM_CODE_START(startup_32)
 	movl pa(initial_stack),%ecx
 	
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d219963ecb60..21816b48537c 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -33,7 +33,7 @@
  * because we need identity-mapped pages.
  */
 
-	__HEAD
+	__INIT
 	.code64
 SYM_CODE_START_NOALIGN(startup_64)
 	UNWIND_HINT_END_OF_STACK
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 1d78e5631bb8..344030c1a81d 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -24,7 +24,7 @@
 #include <asm/nospec-branch.h>
 #include <xen/interface/elfnote.h>
 
-	__HEAD
+	__INIT
 
 /*
  * Entry point for PVH guests.
-- 
2.50.0.727.gbf7dc18ff4-goog


