Return-Path: <linux-efi+bounces-3673-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E993AB44A7
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3D7188D636
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E1929AAFE;
	Mon, 12 May 2025 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ckfmh2Ks"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC55D29A9F5
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077133; cv=none; b=V5PSgZQBBGe20fu7/Dt1mUctQjyF9w5xChkHbJ9h+6JVlI79Xi154AcgALWB1YDs/f5dyjiJBXlkxfjKvaSpG7wUVnSQQtGG1fz2f1M7A4Vzsl7tmSBpafcE6r94vQ6X50Vam6+LeNTIa4APPSyJouRmXhNyNxa/vFKsaPvl4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077133; c=relaxed/simple;
	bh=rU+TwznRcBHCFH7MnBGVSjyi/z5s/y0C2yw1ovXBaDs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dO+LoCgzFeF2Xl2e2geRcb1Q3+7UuGI4q9YC7DlhCjd/97m4sWwt4xU6VWgX0JMHzeg9+26oFTbxSG1dfDvja/7SJmLEJsiXU2bGOtX1a3bhHizOmr4nkYzozb/iQbNNGupWy0nQsdeAlrcnFsyo1JzW4FhizhD+13SwRKJfBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ckfmh2Ks; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so23320995e9.3
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077129; x=1747681929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N552s59xbOEiXCvjnWnzGWY8FKK5cMDeJsBikBFtM2M=;
        b=Ckfmh2KszkR7YaXxmzUrcUebKWyMWGRiPekVOyWTLhrXf/vRvA7XS2NP5LoJkRcz7H
         ROnFmlNTjbMhi25ELD7evsABN/FyNSgND6UOivy8cNH2+IZUbJKuZZK4TKvKj1XNOBot
         lEvHDjabIPGf+85h2k8bgMu0OUHOcYC02iOLUmH/QZhrAn9owgal5S/MrG9mimeyoVg8
         e+jKyivbRVpC59csmxL+IVM36lUTm23+UHoIKYPmeTWGPUR43x3TUePZe9mYhUqYBYQf
         blhcudiePZnywtN7F2Lb0MB9oCCTBlxCXb98wZP9qzI7v96wWZzDc9vrZLRT4+++UkUY
         PucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077129; x=1747681929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N552s59xbOEiXCvjnWnzGWY8FKK5cMDeJsBikBFtM2M=;
        b=IspqF4N+9GTZZL0N8PaUBHU0QJIHrNjbWmNulyiNynU55V/qETrOZ+YyO4/7CBS9re
         LQdEotiNjMroXN61Ryo0tXGFpvtfH61Q0atHVKfX+8dFgir4y2QlWlNyBcyVSZIyTVNL
         OnI6cEDNSHnlBxsxtrPkt6Te114+JHYGtY5MxfgkAleB2iXnfYVPcn7ZcO6E7AJESzrL
         iO2LqlGTOi/VZTJK9Xmsn+kT4icDJQVJ8aweZcYXmEnY//1l9gh/IHjTftWMqKxfyJmD
         EyVazxE9hS5niuNJ1+XPFNBQfvdSm3FrxgMpnkZuCcHH0zWRrOepGKMvdVA2WsZ/0PGs
         +qkQ==
X-Gm-Message-State: AOJu0YyAvsR2OJtqAYAEfWS74d/3MKtvzTbNSGhmc1231lbxzkTkDqVr
	frqOHnLRKSFcyiBMj0i2F5Fu4MFlTTnP+hwyn3CBOvpqmAUkhADnd1S0n9cIZ4m4O40+XQ==
X-Google-Smtp-Source: AGHT+IHEVwDsw+AG/riQpdoS4Z2xMV7NSgAPA0IX/hG2WFjkzlI5Pj0OqVBNaZQXFdbBqsgE1IAV1hoo
X-Received: from wmbdr11.prod.google.com ([2002:a05:600c:608b:b0:441:d228:3918])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:34d3:b0:43d:ac5:11ed
 with SMTP id 5b1f17b1804b1-442d6dc530bmr117931755e9.24.1747077129288; Mon, 12
 May 2025 12:12:09 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:53 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=16708; i=ardb@kernel.org;
 h=from:subject; bh=+O+UrsC91HAI+PXyY59+K+bmlox0wgmI5ck05CzzrkM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJPYyzLi/7Uti6Fu8Zwrd77FseT9I1kFm/PPtzudnz3
 +IaCes6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESmMDD8r/PbErnpomejYc+f
 BuXwxJf+u1I5HObKZh0TVO679G26AsM//Z2fp1+PPFT9uNubZ82TJ/s+uxea75nVuKJGe+lb623 y7AA=
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-41-ardb+git@google.com>
Subject: [RFT PATCH v3 18/21] x86/boot: Move startup code out of __head section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
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
 arch/x86/boot/startup/sev-shared.c  | 34 ++++++++++----------
 arch/x86/boot/startup/sev-startup.c | 14 ++++----
 arch/x86/boot/startup/sme.c         | 26 +++++++--------
 arch/x86/include/asm/init.h         |  6 ----
 arch/x86/kernel/head_32.S           |  2 +-
 arch/x86/kernel/head_64.S           |  2 +-
 arch/x86/platform/pvh/head.S        |  2 +-
 10 files changed, 44 insertions(+), 53 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 750f08d1c7a1..79309944cb19 100644
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
index 099ae2559336..75b3dd62da50 100644
--- a/arch/x86/boot/startup/map_kernel.c
+++ b/arch/x86/boot/startup/map_kernel.c
@@ -36,7 +36,7 @@ static inline bool check_la57_support(void)
 	return true;
 }
 
-static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
+static unsigned long __init sme_postprocess_startup(struct boot_params *bp,
 						    pmdval_t *pmd,
 						    unsigned long p2v_offset)
 {
@@ -90,7 +90,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
  * the 1:1 mapping of memory. Kernel virtual addresses can be determined by
  * subtracting p2v_offset from the RIP-relative address.
  */
-unsigned long __head __startup_64(unsigned long p2v_offset,
+unsigned long __init __startup_64(unsigned long p2v_offset,
 				  struct boot_params *bp)
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] = rip_rel_ptr(early_dynamic_pgts);
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 49440955885a..77b34ab6c7d8 100644
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
 
@@ -59,7 +59,7 @@ static u64 __head get_hv_features(void)
 	return GHCB_MSR_HV_FT_RESP_VAL(val);
 }
 
-u64 __head snp_check_hv_features(void)
+u64 __init snp_check_hv_features(void)
 {
 	/*
 	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
@@ -186,7 +186,7 @@ const struct snp_cpuid_table *snp_cpuid_get_table(void)
  *
  * Return: XSAVE area size on success, 0 otherwise.
  */
-static u32 __head snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
+static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 	u64 xfeatures_found = 0;
@@ -222,7 +222,7 @@ static u32 __head snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 	return xsave_size;
 }
 
-static bool __head
+static bool
 snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
@@ -264,7 +264,7 @@ static void snp_cpuid_hv_no_ghcb(void *ctx, struct cpuid_leaf *leaf)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
-static int __head
+static int
 snp_cpuid_postprocess(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
 		      void *ctx, struct cpuid_leaf *leaf)
 {
@@ -360,7 +360,7 @@ snp_cpuid_postprocess(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-int __head
+int
 snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
 	  void *ctx, struct cpuid_leaf *leaf)
 {
@@ -404,7 +404,7 @@ snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
  * page yet, so it only supports the MSR based communication with the
  * hypervisor and only the CPUID exit-code.
  */
-void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
+void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
@@ -480,7 +480,7 @@ struct cc_setup_data {
  * Search for a Confidential Computing blob passed in as a setup_data entry
  * via the Linux Boot Protocol.
  */
-static __head
+static __init
 struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
 {
 	struct cc_setup_data *sd = NULL;
@@ -508,7 +508,7 @@ struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
  * mapping needs to be updated in sync with all the changes to virtual memory
  * layout and related mapping facilities throughout the boot process.
  */
-static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 {
 	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
 	int i;
@@ -536,8 +536,8 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 	}
 }
 
-static void __head svsm_pval_4k_page(unsigned long paddr, bool validate,
-				     struct svsm_ca *caa, u64 caa_pa)
+static void svsm_pval_4k_page(unsigned long paddr, bool validate,
+			      struct svsm_ca *caa, u64 caa_pa)
 {
 	struct svsm_pvalidate_call *pc;
 	struct svsm_call call = {};
@@ -576,8 +576,8 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate,
 	native_local_irq_restore(flags);
 }
 
-static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
-				     bool validate, struct svsm_ca *caa, u64 caa_pa)
+static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
+			      bool validate, struct svsm_ca *caa, u64 caa_pa)
 {
 	int ret;
 
@@ -590,8 +590,8 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 	}
 }
 
-static void __head __page_state_change(unsigned long paddr, enum psc_op op,
-				       struct svsm_ca *caa, u64 caa_pa)
+static void __page_state_change(unsigned long paddr, enum psc_op op,
+			        struct svsm_ca *caa, u64 caa_pa)
 {
 	u64 val;
 
@@ -623,7 +623,7 @@ static void __head __page_state_change(unsigned long paddr, enum psc_op op,
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
  * services needed when not running in VMPL0.
  */
-static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
+static bool __init svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
 				 void *page)
 {
 	struct snp_secrets_page *secrets_page;
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index b56a585f57ab..21424157819c 100644
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
index ffd0185aaa9d..846f5d7c24e1 100644
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
index 2e42056d2306..5962ff2a189a 100644
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
index 88cbf932f7c2..ac1116f623d3 100644
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
index cfa18ec7d55f..16aa1f018b80 100644
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
2.49.0.1045.g170613ef41-goog


