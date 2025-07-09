Return-Path: <linux-efi+bounces-4217-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D193FAFE21B
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FB33BC2F6
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF7D27817A;
	Wed,  9 Jul 2025 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w/hRQjTN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C57274B49
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048689; cv=none; b=E/LDs1YdYxkEr26vOAzQKZ2WkyCNk0au4pDOdctx+Dz9rgS2nBIrR4hpGgvhm+VbRVIl4bwlP9WiXZbn1axL5Jtec6sjlBcl0+IA4guUYkURlrSkqPPiLrkYiW7BLN5RgQK9jYFm7o3EBKayawnNlYHfkhjdr6f9FCkQdKEzeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048689; c=relaxed/simple;
	bh=MIn0obE2Tdl0yDybRtiPWZ2ex9nM1vepzOAqEYPobN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oLFaURwDfJfjiOEwSG0UeRP7qjcp7+GDNlRyTZRMrtyzzJhEnpLrgexlmEv64q1kWqYL/mVbWdszArjQ1XYWL0UA7LSMX9B9JplpbIKUpE4nWd1lPBP2x+aVBmcj+UirhT8aBMhCl3ntEqEYmNrFUNMELWGdqT4o99u+inml6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w/hRQjTN; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso3598068f8f.0
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048686; x=1752653486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=82AjK2Mr78LnVWeN6ZzoHpTnv0/ttUqkcA2ueyW5d70=;
        b=w/hRQjTNNGPwi1Ea8kXSqWNEeFi5tlUBmA7cLpf3CTxU2MvKAg/37TrXD9rd0aj+oh
         6L3wBDPWUdTai60+vsyDvpAzd5lUd5m5XczCFMfDaQTW2a3JIETLMnRAf3PkHI1HwmvP
         zoUzn1opjSEPyoWnsPHBvqPioZr4oIQ2ki3sQDgdz8PvSyMp3RuCnbm5eVfgXCm0HvLD
         l+HCyemwnEJDjUqlqpbYBi/wcx+V7x955UthdUPJKVoqUzV5/PiRnLG+MnmlYHUftQG1
         RoSsQ0L3ZcfBtWL5NTuk7/EmNigx/i2nQSKBLHmDpEQJRCpvWR1PuRzxwbI42ZZTUhv0
         V4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048686; x=1752653486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82AjK2Mr78LnVWeN6ZzoHpTnv0/ttUqkcA2ueyW5d70=;
        b=EZsS8tZcB5xaW9eZ+0yTaNLIMB9heIUnTzG0/q8ETRqu8aGKBw36z9m/J8iTm1DoVv
         FzARFKxN01rJkqcBVpGnLv73r+0I2CCsgWLOm668YxBN6eU6gRRGj4J8vBqDbIlr7Ls5
         mN4q+uvJXCSzHdPGsvA7Pg8FPXEa3ZHCe65wKRZuaXC0yWLvv+HG5l1v6tgnvqHWmtMI
         skwA9ggX3Ezdp51Tk89dUzrX77D0cb86cCza8FThOr3um4cnFB11c/xZtxGhKM5lrm10
         SFCrw7cLCI4zfbz/hzo9FU8sX4c/fohp3tETc2qYDxEB1PQzi1sRLFh5Wk5mmATUnUdk
         PB6w==
X-Gm-Message-State: AOJu0Yyk4wIguzhaWDk4SlpFk1hy7NkAmPPV5wMG+qd8yMdwEjV2h3r/
	6d1YLMt+9IPYRORLQJAv2PNtU/cQvtr9kXTgN4rzbIniQkzQilTeixISI+tXvS4chqAvzwQyww=
	=
X-Google-Smtp-Source: AGHT+IH4sOcxdqnSwJ1caH7J7j0f/jFWQf/gNmdL+Xr2ICC6qvy/5dCj/UsmVMdkF6+eHQfBXKXYOh7/
X-Received: from wmos4.prod.google.com ([2002:a05:600c:45c4:b0:440:60ac:3f40])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2008:b0:3a4:fcc3:4a14
 with SMTP id ffacd0b85a97d-3b5e453803amr1054391f8f.34.1752048686562; Wed, 09
 Jul 2025 01:11:26 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:53 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6080; i=ardb@kernel.org;
 h=from:subject; bh=9jJdcVhQ0yW0f61+vt5kfMq0QB/TwojdgAvB3ZGZ6Bk=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGhuI8ihzOqdwrWUUecyM3c0cwzMxOxTATRVaIMW2Zl1toHoc
 4h1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmhuI8gACgkQMG4JVi59LVx/BgEAp0EI
 /JO/QIt1G4SCWKKYhVPTWSkaXqeUaekVkVDK6C8BAIoDNrEjRdQys2VWVM4RnO+9wxqHJu9uTFN 8g1b5Ub8B
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-38-ardb+git@google.com>
Subject: [PATCH v4 12/24] x86/sev: Unify SEV-SNP hypervisor feature check
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
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
 arch/x86/boot/compressed/sev.c      | 19 +------------
 arch/x86/boot/startup/sev-shared.c  | 30 +++++++++++++++++---
 arch/x86/boot/startup/sme.c         |  2 ++
 arch/x86/coco/sev/core.c            | 11 -------
 arch/x86/include/asm/sev-internal.h |  2 +-
 arch/x86/include/asm/sev.h          |  2 ++
 6 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 5fd51f51e55c..4bd7b45562ed 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -397,24 +397,7 @@ void sev_enable(struct boot_params *bp)
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
index 1f2c4feeafce..a1d27a418421 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -66,10 +66,7 @@ sev_es_terminate(unsigned int set, unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
-/*
- * The hypervisor features are available from GHCB version 2 onward.
- */
-u64 get_hv_features(void)
+static u64 __head get_hv_features(void)
 {
 	u64 val;
 
@@ -86,6 +83,31 @@ u64 get_hv_features(void)
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
 int svsm_process_result_codes(struct svsm_call *call)
 {
 	switch (call->rax_out) {
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 70ea1748c0a7..529090e20d2a 100644
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
index 4fe0928bc0ad..f73dea313f55 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1344,17 +1344,6 @@ void __init sev_es_init_vc_handling(void)
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
index bdfe008120f3..f0bfa46f3407 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -81,6 +81,6 @@ static __always_inline void sev_es_wr_ghcb_msr(u64 val)
 	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
 }
 
-u64 get_hv_features(void);
+void check_hv_features(void);
 
 const struct snp_cpuid_table *snp_cpuid_get_table(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index f3acbfcdca9a..f20860187fe9 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -438,6 +438,7 @@ struct svsm_call {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u8 snp_vmpl;
+extern u64 sev_hv_features;
 
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
@@ -513,6 +514,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __noreturn snp_abort(void);
+u64 snp_check_hv_features(void);
 void snp_dmi_setup(void);
 int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
-- 
2.50.0.727.gbf7dc18ff4-goog


