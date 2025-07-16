Return-Path: <linux-efi+bounces-4375-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61280B06C43
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62F8561346
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07EF2900BF;
	Wed, 16 Jul 2025 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3i0ismKV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214F28DEE0
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636174; cv=none; b=tgv3WMQesWx6Cqjn+qHqO8ecFGXYBbHzkJHND8RaSJjAA5TKbOTlZk3/ztTQmiAcnzuk8SSw7VZ9i2Y+2GYTBP90k6XV9vub6thVjzMJyb8do+I3VqQcAFtp95dlsYI2u386b31DLat5Bx7m5wyaQ2DI/dhRDFDXzLBx0jg2hxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636174; c=relaxed/simple;
	bh=pYLH0Fg80GBMsJnnL1ks9z964iWsYBt0LhWbKo46WtM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h6KIvAOB6pO4/Bfg1Trwz6r1aii3a6sc5Baudwg1CJClfRGT2nZIn+iD3psJobYY6L3SgJIXw6ZM08DTDPmX65duFRWf8SEzeSLomJKp5lsLzMllaX9LEPGMpfd8tlYCNVfQ1THPJK+Rf8A4VdYlWZjYBWV3IX2JH9rM9Hk3kWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3i0ismKV; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45626e0d3e1so12221335e9.1
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636171; x=1753240971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NzdZAcrlQKZSEh2UZMP8E9BVzV/2LxhvcbnzZODRoKA=;
        b=3i0ismKVQWJk8++vvkYHA2JAp1vnCAthMa/aW+j1k6EBELz8H2R1Lc/wA9wm9I8RZz
         +LWptW9VC7ATLoEyrsxmX6kzA6H+oJSAi2zGgFqGk320sIDHCTBMpbNEKldVRNLU7et7
         5QDAuhMQssHn00CXspRm0exMhrFM1z1cU3nwhE+l+dswA1HULamVzZbxRNJQEcr118zR
         JNu/77PzxZrhNv6bwKZ9sBl/YqsDmuYAB9d50KG2Q0QdsRezjFzcbro6B2o1EODpGnFO
         idcHwXIsI6L1c4Tac+VYYoW0GBSeLRuRRFXbqVOqmKDV5nIcaIrvfuhRhXCUp8TVHGPj
         A11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636171; x=1753240971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzdZAcrlQKZSEh2UZMP8E9BVzV/2LxhvcbnzZODRoKA=;
        b=m3scD/bvpKeSlWcOpl4EtIwIGJFWl175EXuA6d26/0FMmbFBXSqvFHv2lk7ZScybCf
         WJfAX6F+9J1agiNuyASsKliJQjvCdut3lpj26Na2uy3MzFbaE1OeFYa9myKJbwYs0P4K
         mf6yqTklRirATdO4mFPmsbUGQ7HLsmL6sA9uDLkq0/fANee5E7w0IE26n3O85aXcrz3K
         7e5NnYXYFoej1RyupEUDwWiCR9Jsn5OsRRrENa3Ug5ABZiOcwhyKgo1miUB6gRpML//i
         fexm3G6HgY3noIRjar+eVTmfAea8bxeEDgXj8Iu4y0jiMRbcCzslzldtpE89+ZtiHpEu
         ZkYw==
X-Gm-Message-State: AOJu0Yx9RRdEax6pqq3EDcTT2DpZjv/mKnb9VXGAPyLMVryMfAC88lzv
	I7WnqQ0jt0Wnhxd1THQz0+TSL0K1vdfFTtdLtO+BYPA36JY9rnKMbAvCsF2pSAuZ96rjPVPgUg=
	=
X-Google-Smtp-Source: AGHT+IECAe+OdurbwG69pRXocrNZVLq6RP1bwCna4gQadx+PxWaHvaD9cd9kfuheUrR7UANDmnu4hXB7
X-Received: from wmbea5.prod.google.com ([2002:a05:600c:6745:b0:456:2dbe:bf2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b84:b0:455:fc16:9eb3
 with SMTP id 5b1f17b1804b1-4562e3c27bdmr6297635e9.33.1752636170824; Tue, 15
 Jul 2025 20:22:50 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:36 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=17100; i=ardb@kernel.org;
 h=from:subject; bh=Ekexm5rxuUFJ0TfAkq77J/A+NRy0wf9pIushV+GgWT8=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGh3Gmei7jQbrMDwXgrYRWttCekfF/xfV+ADv0+NvfU3f5ED+
 Yh1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmh3GmcACgkQMG4JVi59LVxZggEAu3ON
 W0pDDZz/rADkNcOvH8nar0BJnYQBHfiO9pquoXQBAL9plG5wIqljgRuCH0u1x/5kXsUPuHWJ7So ElCQnM7wP
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-45-ardb+git@google.com>
Subject: [PATCH v5 21/22] x86/boot: Move startup code out of __head section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
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
index faa6cc2f9990..a7af906145e8 100644
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
index b60d546e74a7..4e36a81d8c18 100644
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
@@ -48,7 +48,7 @@ sev_es_terminate(unsigned int set, unsigned int reason)
 /*
  * The hypervisor features are available from GHCB version 2 onward.
  */
-u64 get_hv_features(void)
+u64 __init get_hv_features(void)
 {
 	u64 val;
 
@@ -218,7 +218,7 @@ const struct snp_cpuid_table *snp_cpuid_get_table(void)
  *
  * Return: XSAVE area size on success, 0 otherwise.
  */
-static u32 __head snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
+static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 	u64 xfeatures_found = 0;
@@ -254,7 +254,7 @@ static u32 __head snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 	return xsave_size;
 }
 
-static bool __head
+static bool
 snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
@@ -296,8 +296,8 @@ static void snp_cpuid_hv_msr(void *ctx, struct cpuid_leaf *leaf)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
-static int __head snp_cpuid_postprocess(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *),
-					void *ctx, struct cpuid_leaf *leaf)
+static int snp_cpuid_postprocess(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *),
+				 void *ctx, struct cpuid_leaf *leaf)
 {
 	struct cpuid_leaf leaf_hv = *leaf;
 
@@ -391,8 +391,8 @@ static int __head snp_cpuid_postprocess(void (*cpuid_fn)(void *ctx, struct cpuid
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-int __head snp_cpuid(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *), void *ctx,
-		     struct cpuid_leaf *leaf)
+int snp_cpuid(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *), void *ctx,
+	      struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -434,7 +434,7 @@ int __head snp_cpuid(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *), void *ctx
  * page yet, so it only supports the MSR based communication with the
  * hypervisor and only the CPUID exit-code.
  */
-void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
+void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
@@ -510,7 +510,7 @@ struct cc_setup_data {
  * Search for a Confidential Computing blob passed in as a setup_data entry
  * via the Linux Boot Protocol.
  */
-static __head
+static __init
 struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
 {
 	struct cc_setup_data *sd = NULL;
@@ -538,7 +538,7 @@ struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
  * mapping needs to be updated in sync with all the changes to virtual memory
  * layout and related mapping facilities throughout the boot process.
  */
-static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 {
 	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
 	int i;
@@ -566,7 +566,7 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 	}
 }
 
-static int __head svsm_call_msr_protocol(struct svsm_call *call)
+static int svsm_call_msr_protocol(struct svsm_call *call)
 {
 	int ret;
 
@@ -577,8 +577,8 @@ static int __head svsm_call_msr_protocol(struct svsm_call *call)
 	return ret;
 }
 
-static void __head svsm_pval_4k_page(unsigned long paddr, bool validate,
-				     struct svsm_ca *caa, u64 caa_pa)
+static void svsm_pval_4k_page(unsigned long paddr, bool validate,
+			      struct svsm_ca *caa, u64 caa_pa)
 {
 	struct svsm_pvalidate_call *pc;
 	struct svsm_call call = {};
@@ -618,8 +618,8 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate,
 	native_local_irq_restore(flags);
 }
 
-static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
-				     bool validate, struct svsm_ca *caa, u64 caa_pa)
+static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
+			      bool validate, struct svsm_ca *caa, u64 caa_pa)
 {
 	int ret;
 
@@ -632,8 +632,8 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 	}
 }
 
-static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
-				       enum psc_op op, struct svsm_ca *caa, u64 caa_pa)
+static void __page_state_change(unsigned long vaddr, unsigned long paddr,
+				enum psc_op op, struct svsm_ca *caa, u64 caa_pa)
 {
 	u64 val, msr;
 
@@ -671,7 +671,7 @@ static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
  * services needed when not running in VMPL0.
  */
-static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
+static bool __init svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
 				 void *page)
 {
 	struct snp_secrets_page *secrets_page;
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index e9238149f2cf..1fdf196f9fad 100644
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
@@ -181,7 +181,7 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	boot_svsm_caa_pa = pa;
 }
 
-bool __head snp_init(struct boot_params *bp)
+bool __init snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -210,7 +210,7 @@ bool __head snp_init(struct boot_params *bp)
 	return true;
 }
 
-void __head __noreturn snp_abort(void)
+void __init __noreturn snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index eb6a758ba660..39e7e9d18974 100644
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


