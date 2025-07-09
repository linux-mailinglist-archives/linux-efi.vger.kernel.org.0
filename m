Return-Path: <linux-efi+bounces-4206-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39483AFE203
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B43C544B4E
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA50239597;
	Wed,  9 Jul 2025 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VSXcm6Zn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6B235BE2
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048667; cv=none; b=UbaPBXzPV4Wn1lYktiSn2/wEO0FJSsu/s3n+WKqcjxCL8ibwIKV23wKGKDSOevuuXRxLyNGqEM6nUAvF1xLJoOdyHpqKLSqkfSVlsG3ksFNbtJbQfxsoeJeKW5Y1P19F/D33gBogEk4wQVuFhV8aZkVT/+J23Ok1yske6E/PYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048667; c=relaxed/simple;
	bh=rvFUy8VNOP6qgmwC35GsrRDFzZ/g6tUzKy8jPeagLO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cvk2vGXTH2GmY3V49rTxWZC76YSBitvGClkEoZi8IG6qu4cni3UupJPd9FJ+BslzBFdKdkJp0L30iuZ7h3x9oIZjsbXvv87Omsh6oqB4sDoI7RAYBNGNtIH4PEFOKIearIOfdKKvX3g6oan/c6uJYBiDLd6Tw0Ph/ZpxL2WpnoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VSXcm6Zn; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a6d90929d6so2247639f8f.2
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048664; x=1752653464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UelTNJ1ZGFMhoYHsZLPl0KqF4/9p9ZCeI5r05QnvFT0=;
        b=VSXcm6ZnJlJQh4uIONtSqXp67muCCGYDvK3JSD/TMGMuIEywa4LtBp7NON/mzK6tiK
         z0tcp9ENFC16dxci9pL8fX+kZKVrIbyiKxuDjivQ/2GhuhBre7pugaHPKQJVynD51itS
         U1FY34WxImuJBi4HaP6dMDiCuLRBq+XUVWK5pBKs3z7QomLQbL3jNG40B/JjYZnFpD6A
         WyRfpdE82ZeBPyI6tGJo2MBDlZV35RIxfcTpIc+knxc5N3Ms6bOC+8TqsBZ+lg6XsYsW
         ifRjPAssGZFHlsEV42WkjNQgM93PyTP+LbZ+NwKteRNbOvQ4kKVhR04KD2uFSFnnNp7+
         I1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048664; x=1752653464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UelTNJ1ZGFMhoYHsZLPl0KqF4/9p9ZCeI5r05QnvFT0=;
        b=r8vXnqOe2s3tP+7skK+ycvbaiHpZJgb53jQUOswOeZ17csnzCVdcTm/XBYlKw/WAvr
         QIKAvuLS9/LnBH21CwM8P5WNMEZntHkuPDAgT8G3w0YmAho7t7/EV5IRB8NFREEQfmpn
         F479m2EcxHUzMDqKYdKjqUsPqAuxbWWbVL3rAw7rrY1U9YfE8dufAgjzRlDkfGOtSNuz
         02ZwEsTKoBtPAnggiKBpEIL82DiF8xJ43RfGbVthWnofa/earqEhDlUmTKlln7xdRGSA
         qkT5sBSbuIT9vdnMqGsaFcIEtretdMQbOmBjvHY8w4US5+IUkjyrP5xzXXWr/wctUTuF
         QLLQ==
X-Gm-Message-State: AOJu0YwT2VK40ObYC3rnp9KUvaauzeOev8jFwkZ762TrxadjZoPQ5VgJ
	BnFIOlHVfqr9BM9EFQAxyjLkk1hO3M24jveYmzfdK5oj9p8G+XPW7b540dLdqqT1Lwr6EwcqLg=
	=
X-Google-Smtp-Source: AGHT+IH1UcgHnwr/ONpvBzCpnESyqEOF32nxkKebiHM9ga71jVmhRDG10vIprcYBoFwAwgG+s3kFaUaN
X-Received: from wmbem16.prod.google.com ([2002:a05:600c:8210:b0:450:db34:f21f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:26c4:b0:3a6:d579:ec21
 with SMTP id ffacd0b85a97d-3b5e450b3c4mr967624f8f.12.1752048663820; Wed, 09
 Jul 2025 01:11:03 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:42 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7747; i=ardb@kernel.org;
 h=from:subject; bh=KsJKhc9ZBuFADNQxaFbcPRiKpDH4TotE/4MjeTwLh8g=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNPeWKwV6lfkvmd82XXLWMFWV77bhL8cOj0ifAll7/2z
 DKf6KzUUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaySpiR4YRwyYL623xhLPGu
 315bRGXE7lFysGl9nisv9/ejZtHcSoY//KyGIZMLUuUcts38U8b1L2MKzwTW3rOSBrqnXumvVON iBQA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-27-ardb+git@google.com>
Subject: [PATCH v4 01/24] x86/sev: Separate MSR and GHCB based snp_cpuid() via
 a callback
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
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
---
 arch/x86/boot/startup/sev-shared.c | 64 ++++----------------
 arch/x86/coco/sev/vc-shared.c      | 49 ++++++++++++++-
 arch/x86/include/asm/sev.h         |  3 +-
 3 files changed, 63 insertions(+), 53 deletions(-)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 7a706db87b93..992abfa50508 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -319,7 +319,7 @@ static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
 	return 0;
 }
 
-static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
+static int __sev_cpuid_msr_prot(struct cpuid_leaf *leaf)
 {
 	int ret;
 
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
@@ -484,21 +447,20 @@ snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 	return false;
 }
 
-static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+static void snp_cpuid_msr_prot(void *ctx, struct cpuid_leaf *leaf)
 {
-	if (sev_cpuid_hv(ghcb, ctxt, leaf))
+	if (__sev_cpuid_msr_prot(leaf))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
-static int __head
-snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
-		      struct cpuid_leaf *leaf)
+static int __head snp_cpuid_postprocess(void (*cpuid)(void *ctx, struct cpuid_leaf *),
+					void *ctx, struct cpuid_leaf *leaf)
 {
 	struct cpuid_leaf leaf_hv = *leaf;
 
 	switch (leaf->fn) {
 	case 0x1:
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+		cpuid(ctx, &leaf_hv);
 
 		/* initial APIC ID */
 		leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
@@ -517,7 +479,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 		break;
 	case 0xB:
 		leaf_hv.subfn = 0;
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+		cpuid(ctx, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->edx = leaf_hv.edx;
@@ -565,7 +527,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 		}
 		break;
 	case 0x8000001E:
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+		cpuid(ctx, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->eax = leaf_hv.eax;
@@ -586,8 +548,8 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-int __head
-snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+int __head snp_cpuid(void (*cpuid)(void *ctx, struct cpuid_leaf *), void *ctx,
+		     struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -621,7 +583,7 @@ snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 			return 0;
 	}
 
-	return snp_cpuid_postprocess(ghcb, ctxt, leaf);
+	return snp_cpuid_postprocess(cpuid, ctx, leaf);
 }
 
 /*
@@ -648,14 +610,14 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	leaf.fn = fn;
 	leaf.subfn = subfn;
 
-	ret = snp_cpuid(NULL, NULL, &leaf);
+	ret = snp_cpuid(snp_cpuid_msr_prot, NULL, &leaf);
 	if (!ret)
 		goto cpuid_done;
 
 	if (ret != -EOPNOTSUPP)
 		goto fail;
 
-	if (__sev_cpuid_hv_msr(&leaf))
+	if (__sev_cpuid_msr_prot(&leaf))
 		goto fail;
 
 cpuid_done:
diff --git a/arch/x86/coco/sev/vc-shared.c b/arch/x86/coco/sev/vc-shared.c
index 2c0ab0fdc060..776cb90be530 100644
--- a/arch/x86/coco/sev/vc-shared.c
+++ b/arch/x86/coco/sev/vc-shared.c
@@ -409,15 +409,62 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
+static int __sev_cpuid_ghcb_prot(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
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
+static void snp_cpuid_ghcb_prot(void *p, struct cpuid_leaf *leaf)
+{
+	struct cpuid_ctx *ctx = p;
+
+	if (__sev_cpuid_ghcb_prot(ctx->ghcb, ctx->ctxt, leaf))
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
+	ret = snp_cpuid(snp_cpuid_ghcb_prot, &ctx, &leaf);
 	if (!ret) {
 		regs->ax = leaf.eax;
 		regs->bx = leaf.ebx;
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 89075ff19afa..2cabf617de3c 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -552,7 +552,8 @@ struct cpuid_leaf {
 	u32 edx;
 };
 
-int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf);
+int snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
+	      void *ctx, struct cpuid_leaf *leaf);
 
 void __noreturn sev_es_terminate(unsigned int set, unsigned int reason);
 enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
-- 
2.50.0.727.gbf7dc18ff4-goog


