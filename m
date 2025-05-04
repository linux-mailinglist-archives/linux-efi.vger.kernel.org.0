Return-Path: <linux-efi+bounces-3563-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A2FAA85B4
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E599A3BC132
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025D61DEFE4;
	Sun,  4 May 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRFPdL91"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A711D6DB4
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352412; cv=none; b=THSXmxASJEx7FhShzKuu8K2oPAGocm74cuj8zOyl2EwUBApGbVd/JZk3dclXrr6Avo72OpFx61nyV0qqWnn7w65sKi4zK3qQWBPWpMk0reG0Vyjdfct8DNlzB1SfyYrH6M63SDk803aOsswB32jFskYFvYRb78fWHwV0uo5kTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352412; c=relaxed/simple;
	bh=5ULEMcpNxvFS8qCRTlhFI13Km44zrVehn0FrJFS36Hs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AMLbEbDTIABAkLj4SqZ8AljpVf63t6C92P+nn/4VqpZFLoXtaDEq1OuvLUrwjJO5Uf/+sWNRa6h0Jl1K4TN+YnONbgaaBERMP2XSzzSmycO0TgoyPxbT2P89qyc+nRl30HqltAZEigWNZb8Voa0H9O2sFwrx7MJ74dOJtwdB4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRFPdL91; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43efa869b0aso22371285e9.3
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352409; x=1746957209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e/d0BPzGs3MdNKHAWj2sgSYd18qYPnubQKVmpcEvDb4=;
        b=YRFPdL91nC86pov+Yobrkfo6TuhJkGCwVCUZEdXBlLElFf9MpA61axYu5icLujoAic
         CfEnM/P1TuqbZGwzW9l0mGmFXdSFmVV2uQ59a19zH3JFPD+1sJWZyhyexN19nBDrqsSP
         7E18Sf9abJwClrZ578sPRHkyIdseY18MTcXOEIQuR6XvXDwqgT9HXhiFUAgay/3BWjEH
         qOB3LIXdLRh+gf7RWPFNoBc4I0il/zp+xct31MvFCAFPlsZWPEoHq6bY0PlYypiSjLXe
         uVlAWuL1ikqH3AnmZ8ZAAoHPedFdcyldnccxprnmPdIqHKc4+9WG3xrKnUX+q/z1LXca
         HSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352409; x=1746957209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/d0BPzGs3MdNKHAWj2sgSYd18qYPnubQKVmpcEvDb4=;
        b=tTb7T6caDyF/tf1y3Kvcg59EZ73pZFmed8du9QTiLEz/DnsrgryJ5K6ysJhobSMqhd
         WYGOlCvmq6OfMUcG9aeGAgXFvSgKYCCFMlLXFv1aKrh/Y/ziKWvZRlL5SqKWl3CUeody
         lAunARX1U/VO2gINlkNF03+mhLPOeyEJP44VgNrmGKmYzZnBjhaZH2DiK2EPCo6SnCAn
         D07/yW+qIC+eNcuyjVM7epxvEsMGPKvshJnUumx0tD+LuXn4wPuSuQF9qEkSfHu0pUhZ
         68i0N5WsjMGWyWLU50uI9qSfsTbG1DvLLNKiuROl32APYPnMhStszKWzRlT2FtSjJTbq
         AwHA==
X-Gm-Message-State: AOJu0YxhD5EKQQLlLLYjp2KgQi7VV6KXYWI3DlSwU4NYlS7PUth3+a5l
	iQ8ytc1+dwnioJEgIcrkAWORyPycsgLC/QymskkkNeQGe/DyRsOu0sexiv90KnbJUoHa4Q==
X-Google-Smtp-Source: AGHT+IHIinamTewPRChs9JThiYfWnsnrrjk8ws/eEYLogc6R+jucO0qeiQ8XF/VTmlh3M6rTNXmq/YUh
X-Received: from wmbes9.prod.google.com ([2002:a05:600c:8109:b0:43b:d523:6ad8])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3508:b0:43d:fa59:bced
 with SMTP id 5b1f17b1804b1-441c493401bmr18743425e9.32.1746352409312; Sun, 04
 May 2025 02:53:29 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:42 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6173; i=ardb@kernel.org;
 h=from:subject; bh=/+cX53OtqhrxbtCxNs51oh/f3aA1xTFZJXd9z8j8Auw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4h2b7eGfSkcmx3j/ne8wMfvZx1qhF8/ZNwQ6a77P0
 xO0sP/WUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZSJM7w31f67yZmU3ZZ5cy9
 TL1K5191vYrV2V0vmpf4497f8I/l9xkZbu+dJHyDK2Jl6QzFnfsTY37a37x8/JJb+XJWDebV3w+ b8AIA
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-37-ardb+git@google.com>
Subject: [RFT PATCH v2 12/23] x86/sev: Unify SEV-SNP hypervisor feature check
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
index 18ba81c0b0ed..79550736ad2a 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -414,24 +414,7 @@ void sev_enable(struct boot_params *bp)
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
index b1f4b9b15045..b72c2b9c40c3 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -78,16 +78,10 @@ sev_es_terminate(unsigned int set, unsigned int reason)
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
 
@@ -98,6 +92,31 @@ u64 get_hv_features(void)
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
 bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index ade5ad5060e9..7fc6a689cefe 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -524,6 +524,8 @@ void __head sme_enable(struct boot_params *bp)
 	if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
 		snp_abort();
 
+	sev_hv_features = snp_check_hv_features();
+
 	/* Check if memory encryption is enabled */
 	if (feature_mask == AMD_SME_BIT) {
 		if (!(bp->hdr.xloadflags & XLF_MEM_ENCRYPTION))
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 36edf670ff19..106c231d8ded 100644
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
index 4335711274e3..3aa59ad288ce 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -84,6 +84,6 @@ static __always_inline void sev_es_wr_ghcb_msr(u64 val)
 
 bool sev_es_negotiate_protocol(void);
 bool sev_es_check_cpu_features(void);
-u64 get_hv_features(void);
+void check_hv_features(void);
 
 const struct snp_cpuid_table *snp_cpuid_get_table(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ca7168cc2118..ca914f7384c6 100644
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
2.49.0.906.g1f30a19c02-goog


