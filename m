Return-Path: <linux-efi+bounces-3667-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40AAAB449B
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F41164B0E
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CED29A312;
	Mon, 12 May 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GzDMK/Dk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C94299AB6
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077120; cv=none; b=hsgpEv9/SSEAB0Lg4hcIM0r02ee0cKyXP6merBdf4fETE2eQMM3f5nFrRVzm0XymmNHjY1N9xzgKLo8vYy7zieFe2T1s77i1xMskF6QUjYkpqWQSpFNKNXaTMC7wqSIWD7NPrWrf+yuhvjKGeINVzPrx6i4J/WJ1cwolJnhgG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077120; c=relaxed/simple;
	bh=Ae2bTUsPVgTkgeeoTxnjjgufOuYstQjBzDP0Q98XS34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hDxZVCQuYNij/QayI1qJPYu3F/ZqEsu0bxM1qeEDRarb1W0TCLc1zCKnRQ/NpraQTgH4U5BI5tMO8qq45Gftp1PmGx+8q2b7tzTuuiKgxcvFlr5xG2U0I2cKOc7+5SHht8MiyKBqWijc833pnZvU5reL7iN2oI/h9oZe9wwSrMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GzDMK/Dk; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-442d472cf7fso27654105e9.3
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077117; x=1747681917; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2cjVQZuIH0EwsabYOpjvP/rbkK0LuiNi8s+Yy7b5os=;
        b=GzDMK/Dk5oJckkrLT8lfE79KGvcY8A74bD335syAYPAtlExvw2sPf/PercefDn/AzX
         4VGKrnnYcvvejeHHd1DjIZIenLp3s2g+8AmhwHNOewXsw3NVO/3Ncq1WCvKsVSJ/K7qR
         7hc90tbA+upbO0VzloVo7MTu42Mu/2yPo7QDWA3Tzt1tP7aYalcjGqSY9Rk4PdnhhIWx
         3pwGC30skiORB8L5MWnw4cX2K1NZZq9sCafDJf+VD+aE8gcb9UdDyUImD6ufTgnS34jm
         XuG4Ll5t753wYWqpuIFHv2814bvOy4O6fc8kaoAQIN/sXbN4MbryktW7rXxYsgCF8qnM
         xrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077117; x=1747681917;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2cjVQZuIH0EwsabYOpjvP/rbkK0LuiNi8s+Yy7b5os=;
        b=j9mtILeBUId/Fhip0h4iEfXHzTjQKGybXDtncjq/hemZLQ5scdDLrJrt9Da8fEY+PP
         uPpPEOloG0zLfOxbQYMDveC0lHsCSnCP2M0k9seXVRKJdWjSNBB4gQVpe+nSnrVVXi62
         xxJg2yvh20DPEUPpxNinus/C4C6ROj5TLrBq6uJYMAJcx7G6F5Kr5mtDxMYEBNEyeWkD
         7DaPS4i4Exg2xNzDt9wb1G9mxk+4DjSLN692zGsyc/2gDOkyze2JIDnGvGUahNYVFD6l
         oVeVw50XnO9fILsteHC34wKTf2tVGbDlceCtyeWknsV/q1O+vKtl+x0QgAblC2Iga3vh
         IZ4Q==
X-Gm-Message-State: AOJu0Yzg8LZUqYNnpQ3O/FMu0T8f43pUJzD/jOCaMjzrTjXAsWQIE6Wh
	mTOAW7Y6CWI7yxoX88gLlS3I013IlAKPtnijUe9WlPDcZRNHdllprWlqPlDua9msuGH/nA==
X-Google-Smtp-Source: AGHT+IFO2Juxgf0Vy95m5fzCvEWVqisVFwZ/ZeZtIx+d2i9YuGp6LSEDOFfWg83ZlqJL44eeGcS09Pr4
X-Received: from wmbji6.prod.google.com ([2002:a05:600c:a346:b0:43c:fe99:2bc5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f52:b0:43d:40b0:5b
 with SMTP id 5b1f17b1804b1-442d6dda0bfmr89095805e9.25.1747077117045; Mon, 12
 May 2025 12:11:57 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:47 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6173; i=ardb@kernel.org;
 h=from:subject; bh=puw+vd+gW6u69/qXNHG7sPOaV2+GnhFrDkUQFAxL0rY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3Vvdfc/9ortWk10F7u+1U/8YnGQzacdPdalvXx+03
 pftUeLpKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPZ28XwT/nRlncfbLpvz/yx
 fsk7nVTvpMc7GnZbO/4JU6gLK1lRxMzwV0BXf9Num0W9wdofC/VXnGNmuVTAdeHctO17Zzp+22P hwQ0A
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-35-ardb+git@google.com>
Subject: [RFT PATCH v3 12/21] x86/sev: Unify SEV-SNP hypervisor feature check
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
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
 arch/x86/include/asm/sev-internal.h |  2 +-
 arch/x86/include/asm/sev.h          |  2 ++
 6 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 68fc3d179bbe..4b7a99b2f822 100644
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
index 70ad9a0aa023..560985ef8df6 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -66,16 +66,10 @@ sev_es_terminate(unsigned int set, unsigned int reason)
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
 
@@ -86,6 +80,31 @@ u64 get_hv_features(void)
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
 int svsm_perform_msr_protocol(struct svsm_call *call)
 {
 	u8 pending = 0;
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 753cd2094080..0ae04e333f51 100644
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
index fa7fdd11a45b..fc4f6f188d42 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1264,17 +1264,6 @@ void __init sev_es_init_vc_handling(void)
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
index 3690994275dd..7ad8faf5e88b 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -81,6 +81,6 @@ static __always_inline void sev_es_wr_ghcb_msr(u64 val)
 	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
 }
 
-u64 get_hv_features(void);
+void check_hv_features(void);
 
 const struct snp_cpuid_table *snp_cpuid_get_table(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ae2502253bd3..17b03a1f5694 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -418,6 +418,7 @@ struct svsm_call {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u8 snp_vmpl;
+extern u64 sev_hv_features;
 
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
@@ -495,6 +496,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __noreturn snp_abort(void);
+u64 snp_check_hv_features(void);
 void snp_dmi_setup(void);
 int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
-- 
2.49.0.1045.g170613ef41-goog


