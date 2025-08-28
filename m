Return-Path: <linux-efi+bounces-4625-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A90B4B3998B
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B4836833E
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3192130AD0F;
	Thu, 28 Aug 2025 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mrbyGs+V"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5A30ACFA
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376559; cv=none; b=SnhrsQkorv5ceRgIBffiaYC8aYJcRetP3cUj/hvfLNLs5oL8DRWIFQlOHxVpUeSGiZsUcZmPcy66bX5F/7HaUyMJIDDaFUzBOSTI0iPaYtktAV2eT2mGL/+rcJty45Z75+fmhs0SWiaYUsxsGJlyKikjXceztxUjkcjOT4SqEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376559; c=relaxed/simple;
	bh=QWMAOJGY7wAY00/6/1Jn9/MS9Qg7ZHHCIEvWvhpd8Po=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h+gR2f8T3emg0+7/egBgPxOtAyubnlJO07Ch8i1R9qtdyqkyAcw7m0jm4083a/pcqOHrgQdb4syz9kCF8MKLb+CgMfYxIWYRyWxhx+ITOTxOUs/glAsEy2s9EFZfSuSxMYBj7KowyrGYpjRrsMejq/4QZKkv7jRtjkhjim+YMR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mrbyGs+V; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0514a5so2691755e9.1
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376556; x=1756981356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3TnBpY9TST7dQigmkmElwBFo/yBElL6XMFdV+VIXJk=;
        b=mrbyGs+VJ9rjAjXeGEZaNelmEcgGho7Lwqu8h1W7SeZChED7c8gbgGXZC0B6QTwfhZ
         Rg3m24Txp+LTKE5sa+bQL/nipDz+kaJlCFHxksSAqH7996qHFQdmKLe3KAv6ezKFtJWL
         ANp1t0t4SrR9kOBel2k8Fm53h6FMT4sTEBmLfHydgD/8p6QEk3CBtEqOEmkfuOuB4NS/
         mxfFY8C5qQbMryoluho5Xvc7PHQu22t3cyLijevBL8tK2wjMxFUYEILtOqKp6W+SbXgb
         m+nBNKQV2rw2aTEWvU3laYNdfKsOHlyeuAaoR9clzs6W8LHHd4g6JkM42T9sq5xZ19rO
         w36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376556; x=1756981356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3TnBpY9TST7dQigmkmElwBFo/yBElL6XMFdV+VIXJk=;
        b=aZuB3oXfo3eJGMyuc6yfO9o+StuYi2hYeOw5N2VvVINl2rcARPKpS10CKxpOR3oahD
         AP1HXC9E7YamCjRBnZa/+mwRWtD+6UcA5UvewXIoQcM1p9tSiDAP4VQenxppZViX621x
         1ZIwD2aeIvwcqLq/9dgOgZAADCGw8owf5epQSO7c0EX2+0XII4tkEXT/PlA0ExmE1oVj
         6WU8SOGZdjux20nAMv33m7VEhbYwt8iBlPW+sRznFu0pkPcX4wbckSHXPgi2kirFbSe/
         MYbK8FhF1VFSktjC9ii3IWahjAbcnRaPsCFjZKeYqDEMEm/XpiWoT8rcW4THP2Bzw6JG
         8t5Q==
X-Gm-Message-State: AOJu0YxxQ1MzqisGLw3mpE9mCOna2RzPDMJinkuHq53/QNmcP8RxgQkg
	JFmXaBQ/0oyhx2B4t9wduI1Q9uCzVi6v1DfHvgzP4BUzapT5ht5A4Ff66zkaMY1p80dVEyVyIw=
	=
X-Google-Smtp-Source: AGHT+IGmn4fylxlHvTGvZojtYGz2aGF8b7MYomRZcytxjfvT4OhW4VzPuMKEvb0vhLIkgGrBXtYySlAn
X-Received: from wmbfp21.prod.google.com ([2002:a05:600c:6995:b0:45b:79d1:abcb])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e8a:b0:459:ddad:a3a3
 with SMTP id 5b1f17b1804b1-45b517ddbd5mr208544765e9.25.1756376555802; Thu, 28
 Aug 2025 03:22:35 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:04 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7420; i=ardb@kernel.org;
 h=from:subject; bh=qu1Hf52YhO2sdv5NSOQ+rtKpRbKQeGB9Ds++Nh+Esg0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7pm1Cdduh5w3uL33UOergL3f5t2fe0Zhi1R34gzPV
 T9DH/IydpSyMIhxMciKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJ8LMz/C8VL5TYs/SNftaW
 q68mTHf3nxhwqHNS292kP1Grp7QtOFvE8N+16mSJnavd77ZXOjc1Ny7Imcf7TmO79ibGwr87/7N abOIDAA==
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-25-ardb+git@google.com>
Subject: [PATCH v7 01/22] x86/sev: Separate MSR and GHCB based snp_cpuid() via
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
index a34cd19796f9..ed88dfe7605e 100644
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
index 02236962fdb1..e4622e470ceb 100644
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
2.51.0.268.g9569e192d0-goog


