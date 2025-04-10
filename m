Return-Path: <linux-efi+bounces-3270-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70647A84549
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 15:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C209A3AA0
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC73C28C5B1;
	Thu, 10 Apr 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WsGxr9Q5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B938D28C5AB
	for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292524; cv=none; b=qu3e7Iq+LkeTLT+YCo56U7HRVmPV/oApJWwOVv/VCqB3AuUeTNdpgrYGnGBAA7miNPbozJIOvxsV9xaPjgoHsmhlz41EaFfRNGgNec5GpeHj+8gejolmcFiUA/yG9FUrwPMW3908/QfbwiZ4Yr9dztI4G6u20hHqafI+rHIDnYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292524; c=relaxed/simple;
	bh=qRnbrYushYruhm4qh3eglZ9GhyvymI5PLgTPXFxDYaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gPcSqAcWIIoLRcNajuuqydJS0vH4ti3l5fjh3In9Lw5/7R55IwzSb++TpXKqp7P1WD/Ea2E7HP1HDiIwNNexSIFH0+6LIfX9FM8ODWruNV+zFOUmlw7Vd1sob2kWWdTiiZKjYkNgxkwsNMfzLtTXSaYqf1V6oHzDKIOqBiHJbvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WsGxr9Q5; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-39135d31ca4so484356f8f.1
        for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 06:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744292521; x=1744897321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sm9qg46trCRfuH5OPEG2I+8thbipFQuVhxq71kAuSK8=;
        b=WsGxr9Q55hM6iaYh7aDCSJvmUStTZ264BuUOfKhOx9NoFU4VSviriTLSLe8ef7iAgb
         WB/vvhn3kp08sKNgA0OKLWjrGydOs2588CnZtlKzFM7uPZMMK7e+eMMLoQeSDsgak34X
         2AUg6b5n6qRZtBXtGxM56lhUM7mJ1B6jn+03zP0VRBzBHG2KgHJdLcvv7CXwbgu5MDMb
         Jf55tV0+4PzmucEgPiLsNzU3mJegHjpPg+T5ssk0vCNXnP6d+rH5A/607eZBALamRUSp
         u0kGnm8vyeqCt15FPEtbH1ZgjsOHTY0glGpGK/oqHwlkr5TJTQB8jM+MyVbmpani4xQ1
         IgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292521; x=1744897321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sm9qg46trCRfuH5OPEG2I+8thbipFQuVhxq71kAuSK8=;
        b=A1aSo0sKudpRbyynvnZOuR8m2JUVfC6k6qXMebT+zWPW6Rnn0Ppe9f1CUhCWZjaT6U
         LnkxiH0SM7c0ywzOoEPzI3unxcPruygJQcPTSuxVbHSMF89XEfzWB1BFsg+tkYSrEwmi
         k463OZmdi6V7Xu1mdap6z3WYUTlzOwQoafH44jAGCatgrxFdlG4y059LYUtcchQ/zu34
         lyJ/2Ld/o3g9Lhtq/+yQlYfqefclWeOO/H1EYw+dNTVGctiU1xcHPYJ2CM/2CE3lEGyA
         igjfpnpY02umpYkSPQGlMRNOrrY/v6Onh8auYqAYqDF5OuBBHwGoXXYlAZ7388YIvfoI
         EkaA==
X-Gm-Message-State: AOJu0YwCS21p/MLso7k31+Q0O4nowx5XtFDvJBS9DYODAyEsBlVBwlWx
	LF4lNHY9OcELvm/yH4ZmWHKDoStxbueVfm6FOtk7hlFb6hxGIwi/ppT2LiQX9NXl2mIEA7Vu5MS
	pmzfkZYZ1msRXoxJ50gbiYPZ+uNu00Mw7hiFjWbBy+Xr8wllq1IOD/rs8Sy0mdNsyeQYWCGlUoR
	KDTGUWc6iAHhIel0jsDpoEO8r7fQ==
X-Google-Smtp-Source: AGHT+IF4ZCUofvG98+/W0HdYPKmbxRqu7FA683gwVCBxJo6VzdLSZzPQd41IKBaeCpJh++s/0G8p8qN1
X-Received: from wmbh20.prod.google.com ([2002:a05:600c:a114:b0:43d:8f:dd29])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:64c9:0:b0:39c:2673:4f10
 with SMTP id ffacd0b85a97d-39d8f4c9222mr2471771f8f.23.1744292521043; Thu, 10
 Apr 2025 06:42:01 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:41:28 +0200
In-Reply-To: <20250410134117.3713574-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410134117.3713574-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6881; i=ardb@kernel.org;
 h=from:subject; bh=me4CAa7ZM5wAa0+f+0nLWScVpocU5E9ofun8VFTWI5A=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf37qb5DnQs2LjJv07t168XhDdvcFNpKzecavrl0vfXvr
 FCPbZPedpSwMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJRHMx/Nhz7VvlN+GYx8bs
 FRP0mv0nRik3dNwTmHKi2+LSqg86lxgZ9rAKeOjbbVrSl/Lv26tPOXqvr+Z0L+WJuzjDKHtd/ms lfgA=
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410134117.3713574-23-ardb+git@google.com>
Subject: [PATCH v4 10/11] x86/boot: Drop RIP_REL_REF() uses from early SEV code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that the early SEV code is built with -fPIC, RIP_REL_REF() has no
effect and can be dropped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/sev-shared.c  | 26 +++++++++-----------
 arch/x86/boot/startup/sev-startup.c | 16 ++++++------
 arch/x86/include/asm/sev-internal.h | 18 +++-----------
 3 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 815542295f16..173f3d1f777a 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -299,7 +299,7 @@ static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
 	 * Fill in protocol and format specifiers. This can be called very early
 	 * in the boot, so use rip-relative references as needed.
 	 */
-	ghcb->protocol_version = RIP_REL_REF(ghcb_version);
+	ghcb->protocol_version = ghcb_version;
 	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
 
 	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
@@ -656,9 +656,9 @@ snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 		leaf->eax = leaf->ebx = leaf->ecx = leaf->edx = 0;
 
 		/* Skip post-processing for out-of-range zero leafs. */
-		if (!(leaf->fn <= RIP_REL_REF(cpuid_std_range_max) ||
-		      (leaf->fn >= 0x40000000 && leaf->fn <= RIP_REL_REF(cpuid_hyp_range_max)) ||
-		      (leaf->fn >= 0x80000000 && leaf->fn <= RIP_REL_REF(cpuid_ext_range_max))))
+		if (!(leaf->fn <= cpuid_std_range_max ||
+		      (leaf->fn >= 0x40000000 && leaf->fn <= cpuid_hyp_range_max) ||
+		      (leaf->fn >= 0x80000000 && leaf->fn <= cpuid_ext_range_max)))
 			return 0;
 	}
 
@@ -1179,11 +1179,11 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
 
 		if (fn->eax_in == 0x0)
-			RIP_REL_REF(cpuid_std_range_max) = fn->eax;
+			cpuid_std_range_max = fn->eax;
 		else if (fn->eax_in == 0x40000000)
-			RIP_REL_REF(cpuid_hyp_range_max) = fn->eax;
+			cpuid_hyp_range_max = fn->eax;
 		else if (fn->eax_in == 0x80000000)
-			RIP_REL_REF(cpuid_ext_range_max) = fn->eax;
+			cpuid_ext_range_max = fn->eax;
 	}
 }
 
@@ -1229,11 +1229,7 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 {
 	int ret;
 
-	/*
-	 * This can be called very early during boot, so use rIP-relative
-	 * references as needed.
-	 */
-	if (RIP_REL_REF(snp_vmpl)) {
+	if (snp_vmpl) {
 		svsm_pval_4k_page(paddr, validate);
 	} else {
 		ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
@@ -1377,7 +1373,7 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	if (!secrets_page->svsm_guest_vmpl)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_VMPL0);
 
-	RIP_REL_REF(snp_vmpl) = secrets_page->svsm_guest_vmpl;
+	snp_vmpl = secrets_page->svsm_guest_vmpl;
 
 	caa = secrets_page->svsm_caa;
 
@@ -1392,8 +1388,8 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	 * The CA is identity mapped when this routine is called, both by the
 	 * decompressor code and the early kernel code.
 	 */
-	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)caa;
-	RIP_REL_REF(boot_svsm_caa_pa) = caa;
+	boot_svsm_caa = (struct svsm_ca *)caa;
+	boot_svsm_caa_pa = caa;
 
 	/* Advertise the SVSM presence via CPUID. */
 	cpuid_table = (struct snp_cpuid_table *)snp_cpuid_get_table();
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 10b636009d1c..e376a340b629 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -467,10 +467,10 @@ int svsm_perform_call_protocol(struct svsm_call *call)
 	 * ghcbs_initialized is set, then it is late in the boot and no need
 	 * to worry about rip-relative references in called functions.
 	 */
-	if (RIP_REL_REF(sev_cfg).ghcbs_initialized)
+	if (sev_cfg.ghcbs_initialized)
 		ghcb = __sev_get_ghcb(&state);
-	else if (RIP_REL_REF(boot_ghcb))
-		ghcb = RIP_REL_REF(boot_ghcb);
+	else if (boot_ghcb)
+		ghcb = boot_ghcb;
 	else
 		ghcb = NULL;
 
@@ -479,7 +479,7 @@ int svsm_perform_call_protocol(struct svsm_call *call)
 			   : svsm_perform_msr_protocol(call);
 	} while (ret == -EAGAIN);
 
-	if (RIP_REL_REF(sev_cfg).ghcbs_initialized)
+	if (sev_cfg.ghcbs_initialized)
 		__sev_put_ghcb(&state);
 
 	native_local_irq_restore(flags);
@@ -542,7 +542,7 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	 * This eliminates worries about jump tables or checking boot_cpu_data
 	 * in the cc_platform_has() function.
 	 */
-	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
+	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
 	 /*
@@ -561,7 +561,7 @@ void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	 * This eliminates worries about jump tables or checking boot_cpu_data
 	 * in the cc_platform_has() function.
 	 */
-	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
+	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
@@ -1356,8 +1356,8 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	if (ret)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
 
-	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)pa;
-	RIP_REL_REF(boot_svsm_caa_pa) = pa;
+	boot_svsm_caa = (struct svsm_ca *)pa;
+	boot_svsm_caa_pa = pa;
 }
 
 bool __head snp_init(struct boot_params *bp)
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index 73cb774c3639..e54847a69107 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -68,28 +68,18 @@ extern u64 boot_svsm_caa_pa;
 
 static __always_inline struct svsm_ca *svsm_get_caa(void)
 {
-	/*
-	 * Use rIP-relative references when called early in the boot. If
-	 * ->use_cas is set, then it is late in the boot and no need
-	 * to worry about rIP-relative references.
-	 */
-	if (RIP_REL_REF(sev_cfg).use_cas)
+	if (sev_cfg.use_cas)
 		return this_cpu_read(svsm_caa);
 	else
-		return RIP_REL_REF(boot_svsm_caa);
+		return boot_svsm_caa;
 }
 
 static __always_inline u64 svsm_get_caa_pa(void)
 {
-	/*
-	 * Use rIP-relative references when called early in the boot. If
-	 * ->use_cas is set, then it is late in the boot and no need
-	 * to worry about rIP-relative references.
-	 */
-	if (RIP_REL_REF(sev_cfg).use_cas)
+	if (sev_cfg.use_cas)
 		return this_cpu_read(svsm_caa_pa);
 	else
-		return RIP_REL_REF(boot_svsm_caa_pa);
+		return boot_svsm_caa_pa;
 }
 
 int svsm_perform_call_protocol(struct svsm_call *call);
-- 
2.49.0.504.g3bcea36a83-goog


