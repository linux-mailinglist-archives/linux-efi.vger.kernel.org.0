Return-Path: <linux-efi+bounces-3407-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4699A9656D
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 12:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874993AB4BA
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA678214A7B;
	Tue, 22 Apr 2025 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3MG2RAxN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614E20D4F6
	for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316475; cv=none; b=I961QVbN8+D3DNcHphXu/1ZqBywmQxBCRRZ9S+TVS+j6tsrIwRiN8AJML5IiEXcfsh1789T78MfCNC/HJmnfPtOuHaETjUnIVWj0dldTDHFHF3Rf1hBViTC5zj/AFhEmzX1Q/I1dGM+EVtcqcba6v1a3WAxyiHVyTjD14CBF61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316475; c=relaxed/simple;
	bh=GIUFYEPyGYfKGc0PPY6tQJ80hwh0wA75Wwtw3lhqhfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W4NgeIPRl+vs4VPbby/xmtHsf6nU2W6FJQWqPb36sDqYdeg3fOOFfR4TH/XYc6eHE3/3byBBluP+d6Oqn8sQUx4O2BUnjykQBOnV+vTBlMk+wbghAdCp1aog3XFWtk39HJntTlep+ctK1mExHT0oCqjb70fWVWhhz0nKgxkPkek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3MG2RAxN; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so21432145e9.3
        for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 03:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745316472; x=1745921272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+uDSj/a78y5CTkwwVW780j1vFa4nB3BKuRODNgKIvqk=;
        b=3MG2RAxNjBRvbg/ZtsYZSYS5P8Znu2n+nxMSwOswOmSr32UfJBF6hLMqxLrO0I+kfB
         FuPiHwyZ0uasHEfdHFHVRIPyAtpvzfvudlDIvnn2v43Uxa1FZ/zStDsvUPSbM60JDwQO
         KFQod6k7xYpkmceR7z3g5ZPShrKsceXYIqbZCd7EDVeY71J5bjy14v0pfYS+NSk/6S8V
         KusrDc6UlpRAEGrzvAAasWREhLyx6X3/vjD926SCorwG1BaWIihLzZkU0MytKqiroQcG
         upAcUkGCWOBmdsJWp9fZtwCCEOpDz8OY8E95D5zFUT0xToAwMo0/0arvZ4m3C2k5vlk7
         2fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316472; x=1745921272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+uDSj/a78y5CTkwwVW780j1vFa4nB3BKuRODNgKIvqk=;
        b=wAGMwB3xjV2HHgBL4mfVl491EjiBvyE9nFsOOe5rYEU2z7GvC96Zk0phfKwbVSiX4z
         v4oV2V6yJhsf7dd9izF9ZZIa/JxNzZAWtG7S3jRzcf59UEa9LkJkr4xIY9E9ManDXX0q
         bSSr4FCaSSt/L6Ux1bQvQ6ocwROoxDwzBeH8Tuho4dwNyEtIwIzjpaTKlASDY7iscttL
         lP+HyRmf7JUcadkptxbrr0+e/9n4+ndFuhyaSxz0dbxE3YeZzlqM6ZmbWc78e5g3CU+8
         Hipgab7PCZtvRV/GYWezLgPoILwe3kS3mpCU0ypomPE8Ym8/5KPEXB3MDcEdxmsB76PS
         mZSg==
X-Gm-Message-State: AOJu0YwXFAiemQvWeQdVHsQmvusj4JPIYsWKXrZ9yYQ+0zH8X3cdiK19
	LS4By4NfblM6Xa8QeeHTTkwJhMKQM95g3rUa8aDsLmFJttIs0umeve3wpfAem338uOzYuY0aLm9
	GQv2ynFvGNlqPAy2IJquXnerMWVd85FtL6kQxDN/dG7fmgbpPE/4C9tti2OfCib6JaGEj2xwDNv
	LhwMq5yILRT48pK8WNEEZBDvhltQ==
X-Google-Smtp-Source: AGHT+IEDLcQMXNDfKrQxKgqe3y/SZCaJQ1YZJAIHNR3ks91xPuvaiSGeRwSEzICRkIxvXxbYZhmA4HK1
X-Received: from wmbhg23.prod.google.com ([2002:a05:600c:5397:b0:43d:44cf:11f8])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b0d:b0:43d:7413:cb3e
 with SMTP id 5b1f17b1804b1-4406ab7f548mr111476305e9.1.1745316471962; Tue, 22
 Apr 2025 03:07:51 -0700 (PDT)
Date: Tue, 22 Apr 2025 12:07:33 +0200
In-Reply-To: <20250422100728.208479-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422100728.208479-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6465; i=ardb@kernel.org;
 h=from:subject; bh=O9MPAbgsJxC5SW2cxjXxQ67LptvnOIX9WzkitS/fhSo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYM9K3PuAv2TxVtm3GUtOP2QpW3dPR1BiQcV53Pvm3zvj
 jqiGyfQUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZSo8jwPyx2+ZXjd47kKE9h
 OG9TbbR4gq6Ng6QM+5EKk88zhEKENzAyrN2pluW7huuV1xt9mZolp7c+du5nspTO/Ve8c1dMiqU AOwA=
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250422100728.208479-11-ardb+git@google.com>
Subject: [PATCH v3 4/5] x86/sev: Unify SEV-SNP hypervisor feature check
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The decompressor and the core kernel both check the hypervisor feature
mask exposed by the hypervisor, but test it in slightly different ways.

This disparity seems unintentional, and simply a result of the fact that
the decompressor and the core kernel evolve differently over time when
it comes to setting up the SEV-SNP execution context.

So move the HV feature check into a helper function and call that
instead. For the core kernel, move the check to an earlier boot stage,
right after the point where it is established that the guest is
executing in SEV-SNP mode.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      | 19 +----------
 arch/x86/boot/startup/sev-shared.c  | 33 +++++++++++++++-----
 arch/x86/boot/startup/sme.c         |  2 ++
 arch/x86/coco/sev/core.c            | 11 -------
 arch/x86/include/asm/sev-internal.h |  3 +-
 arch/x86/include/asm/sev.h          |  2 ++
 6 files changed, 32 insertions(+), 38 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 91a2836b20a1..5477f8bf9c96 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -576,24 +576,7 @@ void sev_enable(struct boot_params *bp)
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
 	}
 
-	/*
-	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
-	 * features.
-	 */
-	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
-		u64 hv_features;
-
-		hv_features = get_hv_features();
-		if (!(hv_features & GHCB_HV_FT_SNP))
-			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
-
-		/*
-		 * Running at VMPL0 is required unless an SVSM is present and
-		 * the hypervisor supports the required SVSM GHCB events.
-		 */
-		if (snp_vmpl > 0 && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))
-			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
-	}
+	snp_check_hv_features();
 
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 173f3d1f777a..7151cdd37557 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -94,16 +94,10 @@ sev_es_terminate(unsigned int set, unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
-/*
- * The hypervisor features are available from GHCB version 2 onward.
- */
-u64 get_hv_features(void)
+static u64 __head get_hv_features(void)
 {
 	u64 val;
 
-	if (ghcb_version < 2)
-		return 0;
-
 	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
 	VMGEXIT();
 
@@ -114,6 +108,31 @@ u64 get_hv_features(void)
 	return GHCB_MSR_HV_FT_RESP_VAL(val);
 }
 
+u64 __head snp_check_hv_features(void)
+{
+	/*
+	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
+	 * features.
+	 */
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
+		u64 hv_features;
+
+		hv_features = get_hv_features();
+		if (!(hv_features & GHCB_HV_FT_SNP))
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+		/*
+		 * Running at VMPL0 is required unless an SVSM is present and
+		 * the hypervisor supports the required SVSM GHCB events.
+		 */
+		if (snp_vmpl > 0 && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
+
+		return hv_features;
+	}
+	return 0;
+}
+
 void snp_register_ghcb_early(unsigned long paddr)
 {
 	unsigned long pfn = paddr >> PAGE_SHIFT;
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 5738b31c8e60..11caa343790d 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -533,6 +533,8 @@ void __head sme_enable(struct boot_params *bp)
 	if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
 		snp_abort();
 
+	sev_hv_features = snp_check_hv_features();
+
 	/* Check if memory encryption is enabled */
 	if (feature_mask == AMD_SME_BIT) {
 		if (!(bp->hdr.xloadflags & XLF_MEM_ENCRYPTION))
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 617988a5f3d7..20c37bff6259 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1170,17 +1170,6 @@ void __init sev_es_init_vc_handling(void)
 	if (!sev_es_check_cpu_features())
 		panic("SEV-ES CPU Features missing");
 
-	/*
-	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
-	 * features.
-	 */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
-		sev_hv_features = get_hv_features();
-
-		if (!(sev_hv_features & GHCB_HV_FT_SNP))
-			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
-	}
-
 	/* Initialize per-cpu GHCB pages */
 	for_each_possible_cpu(cpu) {
 		alloc_runtime_data(cpu);
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index e54847a69107..3d3fbcae7ba7 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -4,7 +4,6 @@
 
 extern struct ghcb boot_ghcb_page;
 extern struct ghcb *boot_ghcb;
-extern u64 sev_hv_features;
 
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
@@ -107,6 +106,6 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 void snp_register_ghcb_early(unsigned long paddr);
 bool sev_es_negotiate_protocol(void);
 bool sev_es_check_cpu_features(void);
-u64 get_hv_features(void);
+void check_hv_features(void);
 
 const struct snp_cpuid_table *snp_cpuid_get_table(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index a8661dfc9a9a..8637a65973ef 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -418,6 +418,7 @@ struct svsm_call {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u8 snp_vmpl;
+extern u64 sev_hv_features;
 
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
@@ -494,6 +495,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __noreturn snp_abort(void);
+u64 snp_check_hv_features(void);
 void snp_dmi_setup(void);
 int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
-- 
2.49.0.805.g082f7c87e0-goog


