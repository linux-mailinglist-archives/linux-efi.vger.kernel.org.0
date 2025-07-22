Return-Path: <linux-efi+bounces-4437-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C234B0D318
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1484916727E
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0862C3263;
	Tue, 22 Jul 2025 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y0wUPKPV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F02C158F
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169394; cv=none; b=iGXJcu9DBywfPBNyR4Gwm977G8Z7f/GKhM7h0blcdV9YxWL+MdEMChxQG1ol7/MMkYMOryrAii6uBsbB7zAHDUT0m5AJCeZjLP6MxDwAoZJ+cekU8B3fQToryvxe6gSRMGOovi0bTq9ImylVOUcY5FwN8TLWJNR9Gvq0W5pMpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169394; c=relaxed/simple;
	bh=pNlYdSPWJSc2Sjd1Rg21bRbL7xz44gMJD1OntgWPAFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G+pGqYgNGMWbB/cSV3p0FMFPae7Y9TgvnTgzZLY8EI1LLeyODdyU+NQYNzl6oy4dbwYn4P9QCIZdqXcO84OzrDopRaQVp53ox/cHSdmr2WSAnLcu9cziLHW/3BCbc8KPztJ5Eaz+lFYM2uCZFyyMSXUVkkHE41AaYT46+kdoUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y0wUPKPV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so31770605e9.0
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169390; x=1753774190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MU+D/CPMPjJsRbMsZGElOxQGyy4+8B4ya3pOCdnZVkw=;
        b=y0wUPKPVjjfb0uHb5j+3aSYkEVFnzyP60Elzilq7rcD99FlOt2QaYWHmyT3HuwMsgo
         M1oX1HCSM9J62Wd+Zq3cxUGXADtsi/lKyerxNDKqRQgZdKAO69jZNHOvnLGsVpho+Qak
         0oJMf5S87OXWnxo535UdPFddUyJ1iMcYfKXw3tQoVNQ6Fi5dW0rrxxRIxI+1U7FBcXBw
         HX3t1Gt7RX97+he+xqCkUJ/BD66LYRkfH7iJoJGLA2jBKSTTlfMA2+ynfjIh5vzs0X9W
         wjDj+F7K9jQjoVXOjdLhBe0vGjtFikwJpnFBEO0ShIvEjoar5IdenLaujIzC3ilPdsv6
         kzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169390; x=1753774190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MU+D/CPMPjJsRbMsZGElOxQGyy4+8B4ya3pOCdnZVkw=;
        b=dfV58boJx6d6MWTGLoq2Jq240/y0PO4qljNmwDsuT0vuxMm9QEcETPV4+HVkbfJEdW
         /RVOhSem2AapfPBluNhPM+tu187ziB6Q0bGD7uThpW8r2UDmB0W4VHDH0lRG/v5+CYPR
         8iSZc9SblvnDRKoMKwYMhCeFei2MmoHQRkdoxcPrArvA3LM7E0vgMt9hcIvRvxONXMbJ
         KLNixh/RcZ3VBb9sJmOQMDPs0KifWYR2rC9cuEohY10UD+sMeIBjYiSZLPbVsuldDWin
         UAKMlIDaNYeQeSPPiytpZVgLAPKeRV3KvIaaDNA6oYWRNz+f76dvdnYtUXSZwWNZUeZd
         JJiw==
X-Gm-Message-State: AOJu0Yz6AvhLQsI4TiU/KMWdm48p/7G3LyUFGHrXbvzpDLm+m9/1kOPp
	3OLmCRDa5ZorTkmiDZEQt7wo4GAHa7rHfg+YCCtpvB9olNFsEjcgAl5IAuJx9DkI8DZmatTfvg=
	=
X-Google-Smtp-Source: AGHT+IGOnO1RjG2/8oG3w56s9VfKH34J95TpqenGdctnfrw8bldh+tHmzXbH7YzHpE2LScTfkRPrIikt
X-Received: from wmbeq12.prod.google.com ([2002:a05:600c:848c:b0:456:c7c:3165])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e8e:b0:456:1b8b:b8ab
 with SMTP id 5b1f17b1804b1-4563b8fca24mr154363935e9.30.1753169390664; Tue, 22
 Jul 2025 00:29:50 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:10 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7420; i=ardb@kernel.org;
 h=from:subject; bh=d/TVkAXlOWDHbewpJxXD5/3KvG5R7cnCMDZ8fMf9M4g=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPeNkTzdt/pR1P0EpfzvWOa9nORrS4H38JYxxrxY8LFq
 hETj//tKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABN5d5KRYVGznudLHlsvUZOH
 ymu95bvtHbaL7JAI6ef6/OlAvq/jPYa/Ugv5Gla867rEFz6jKGkHc42S9I9qaQ22oycvrbnPr8D DBQA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-25-ardb+git@google.com>
Subject: [PATCH v6 01/22] x86/sev: Separate MSR and GHCB based snp_cpuid() via
 a callback
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

There are two distinct callers of snp_cpuid(): one where the MSR
protocol is always used, and one where the GHCB page based interface is
always used.

The snp_cpuid() logic does not care about the distinction, which only
matters at a lower level. But the fact that it supports both interfaces
means that the GHCB page based logic is pulled into the early startup
code where PA to VA conversions are problematic, given that it runs from
the 1:1 mapping of memory.

So keep snp_cpuid() itself in the startup code, but factor out the
hypervisor calls via a callback, so that the GHCB page handling can be
moved out.

Code refactoring only - no functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/startup/sev-shared.c | 59 ++++----------------
 arch/x86/coco/sev/vc-shared.c      | 49 +++++++++++++++-
 arch/x86/include/asm/sev.h         |  3 +-
 3 files changed, 61 insertions(+), 50 deletions(-)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 7a706db87b93..a1e211e0000c 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -342,44 +342,7 @@ static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
 	return ret;
 }
 
-static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
-{
-	u32 cr4 = native_read_cr4();
-	int ret;
-
-	ghcb_set_rax(ghcb, leaf->fn);
-	ghcb_set_rcx(ghcb, leaf->subfn);
-
-	if (cr4 & X86_CR4_OSXSAVE)
-		/* Safe to read xcr0 */
-		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
-	else
-		/* xgetbv will cause #UD - use reset value for xcr0 */
-		ghcb_set_xcr0(ghcb, 1);
-
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
-	if (ret != ES_OK)
-		return ret;
-
-	if (!(ghcb_rax_is_valid(ghcb) &&
-	      ghcb_rbx_is_valid(ghcb) &&
-	      ghcb_rcx_is_valid(ghcb) &&
-	      ghcb_rdx_is_valid(ghcb)))
-		return ES_VMM_ERROR;
 
-	leaf->eax = ghcb->save.rax;
-	leaf->ebx = ghcb->save.rbx;
-	leaf->ecx = ghcb->save.rcx;
-	leaf->edx = ghcb->save.rdx;
-
-	return ES_OK;
-}
-
-static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
-{
-	return ghcb ? __sev_cpuid_hv_ghcb(ghcb, ctxt, leaf)
-		    : __sev_cpuid_hv_msr(leaf);
-}
 
 /*
  * This may be called early while still running on the initial identity
@@ -484,21 +447,21 @@ snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 	return false;
 }
 
-static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+static void snp_cpuid_hv_msr(void *ctx, struct cpuid_leaf *leaf)
 {
-	if (sev_cpuid_hv(ghcb, ctxt, leaf))
+	if (__sev_cpuid_hv_msr(leaf))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
 static int __head
-snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
-		      struct cpuid_leaf *leaf)
+snp_cpuid_postprocess(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *leaf),
+		      void *ctx, struct cpuid_leaf *leaf)
 {
 	struct cpuid_leaf leaf_hv = *leaf;
 
 	switch (leaf->fn) {
 	case 0x1:
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+		cpuid_fn(ctx, &leaf_hv);
 
 		/* initial APIC ID */
 		leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
@@ -517,7 +480,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 		break;
 	case 0xB:
 		leaf_hv.subfn = 0;
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+		cpuid_fn(ctx, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->edx = leaf_hv.edx;
@@ -565,7 +528,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 		}
 		break;
 	case 0x8000001E:
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+		cpuid_fn(ctx, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->eax = leaf_hv.eax;
@@ -586,8 +549,8 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-int __head
-snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+int __head snp_cpuid(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *leaf),
+		     void *ctx, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -621,7 +584,7 @@ snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 			return 0;
 	}
 
-	return snp_cpuid_postprocess(ghcb, ctxt, leaf);
+	return snp_cpuid_postprocess(cpuid_fn, ctx, leaf);
 }
 
 /*
@@ -648,7 +611,7 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	leaf.fn = fn;
 	leaf.subfn = subfn;
 
-	ret = snp_cpuid(NULL, NULL, &leaf);
+	ret = snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
 	if (!ret)
 		goto cpuid_done;
 
diff --git a/arch/x86/coco/sev/vc-shared.c b/arch/x86/coco/sev/vc-shared.c
index 2c0ab0fdc060..b4688f69102e 100644
--- a/arch/x86/coco/sev/vc-shared.c
+++ b/arch/x86/coco/sev/vc-shared.c
@@ -409,15 +409,62 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
+static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+{
+	u32 cr4 = native_read_cr4();
+	int ret;
+
+	ghcb_set_rax(ghcb, leaf->fn);
+	ghcb_set_rcx(ghcb, leaf->subfn);
+
+	if (cr4 & X86_CR4_OSXSAVE)
+		/* Safe to read xcr0 */
+		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
+	else
+		/* xgetbv will cause #UD - use reset value for xcr0 */
+		ghcb_set_xcr0(ghcb, 1);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) &&
+	      ghcb_rbx_is_valid(ghcb) &&
+	      ghcb_rcx_is_valid(ghcb) &&
+	      ghcb_rdx_is_valid(ghcb)))
+		return ES_VMM_ERROR;
+
+	leaf->eax = ghcb->save.rax;
+	leaf->ebx = ghcb->save.rbx;
+	leaf->ecx = ghcb->save.rcx;
+	leaf->edx = ghcb->save.rdx;
+
+	return ES_OK;
+}
+
+struct cpuid_ctx {
+	struct ghcb *ghcb;
+	struct es_em_ctxt *ctxt;
+};
+
+static void snp_cpuid_hv_ghcb(void *p, struct cpuid_leaf *leaf)
+{
+	struct cpuid_ctx *ctx = p;
+
+	if (__sev_cpuid_hv_ghcb(ctx->ghcb, ctx->ctxt, leaf))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
+}
+
 static int vc_handle_cpuid_snp(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
+	struct cpuid_ctx ctx = { ghcb, ctxt };
 	struct pt_regs *regs = ctxt->regs;
 	struct cpuid_leaf leaf;
 	int ret;
 
 	leaf.fn = regs->ax;
 	leaf.subfn = regs->cx;
-	ret = snp_cpuid(ghcb, ctxt, &leaf);
+	ret = snp_cpuid(snp_cpuid_hv_ghcb, &ctx, &leaf);
 	if (!ret) {
 		regs->ax = leaf.eax;
 		regs->bx = leaf.ebx;
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 89075ff19afa..9086b1ff1fdc 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -552,7 +552,8 @@ struct cpuid_leaf {
 	u32 edx;
 };
 
-int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf);
+int snp_cpuid(void (*cpuid_fn)(void *ctx, struct cpuid_leaf *leaf),
+	      void *ctx, struct cpuid_leaf *leaf);
 
 void __noreturn sev_es_terminate(unsigned int set, unsigned int reason);
 enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
-- 
2.50.0.727.gbf7dc18ff4-goog


