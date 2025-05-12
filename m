Return-Path: <linux-efi+bounces-3656-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF02AB4487
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E4717B0A1
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C06298C08;
	Mon, 12 May 2025 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrdBEEie"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351BB2980BC
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077099; cv=none; b=jsuTDcFWFlTqSw2EFSIuEDKvhR6qjgoGXkLw6JjQKSfAUXSGGwPDYluNoovVfnG+CZi+IpqxKvjA4DPqBn+DQFYLkUVt1YSU3XfAh43CUzCwvbxdX+OuigP4HERvv+CgARtjt2qhrmCq5rDu3TA/knQebDI2SCQ7qGAHc3EB9dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077099; c=relaxed/simple;
	bh=IT9XlH23kMRDjTqP6nbxillnbIsmo5aqXnIcKYyC0J8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jO7KjqmxR7ZN+Bx9zqcQZl+ZNcqtCliJS1PLpv7xKf6+KOCnLgbMXaollIOlY96PBpmlklKmmI1dUQX6rSLChqGgeCmmO4QLep7lZab+D7JUvY6sbIe6fGgEf8+45ZvNbtV/FPR8N4R4lRrwhzBpPjtY7mVhSKpsbiVnnqwGjtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GrdBEEie; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so30305625e9.2
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077094; x=1747681894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tez2B6Dx36hKxJWfXYtYmnT1eeCqtp3xVkagTtM9zXQ=;
        b=GrdBEEienyM11Tf5WfkYHG3VhIHrkmDdCPpFJCBF2nWz7cRJnxDmC2OI4LiN6yokNt
         muPj2a6pGCw+qby0/Kqa9nTKIhta59nuAiMJdPB3tTrpgWEH97HN+f7FwhsIy0LJIiro
         qThaIGuVO+G3Pl4DCv7g8lBXTo4DOpT8tegHx4v9Rz4h5JRGb8EpbgURcv7jnjcJr8cU
         H/IZ/YE+5yZt03PZlT2YNwVfPEZcKPkywtpb6lfwKJLf4PF39UWVVDaPSVd8FmcQCnUn
         /hwD66q4xovwBkmRszvMj05xxnY5agifH3MMggOEXGbYzgYtIqne2LmU+JH1KQT8qiYT
         Bnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077094; x=1747681894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tez2B6Dx36hKxJWfXYtYmnT1eeCqtp3xVkagTtM9zXQ=;
        b=ZVnhZBSCVo7y50zZkcZAADfAwgEC6h7Fpi8RjkN6FZjwXpnOK7de42eBjowOW+2WWX
         l3cPmFhLRqgIYPkq3O/MNt/vDyosqMDRBoMuoajvSjrpHMgrcT16dLxAKHMDNZ2xhVcA
         sYa6DtSWlJQwIa3hfHFX3NzPHzxeiHPiMMYi82ZMF2hUkhmDnKn5jDAYxZRCSrQvI5et
         novxbEdod342y/QlcIkxy18gL5g+4XWh5m/rNY7Qrs/TohQy1Xtb4HeyMpXQwky1LEcP
         D2/bTDFwBiY35/2iKBTkAes1h0KrZ3eg7UtVY5Qe8jEaLR40y2iCM7LgIUKbKFyK4Ffu
         sqPw==
X-Gm-Message-State: AOJu0YxdfSo4bTrWLjPq6O9RyXZiJz7OKaWuW+vsRkyqeM8nhng72aV/
	aqxTkQDtIYer3++PltGsmZ4fG/2ghnGrOyDI2f0ikh25ULTHfcPSgsKO22gdM/Yqm4t9IQ==
X-Google-Smtp-Source: AGHT+IGCI+eHbv4DUOM4UndVn2vwms3Eyzkvt8uC7GVyEEz2YxCexQ6Ik3N8j/O+v2ykKFoys4uS2Q90
X-Received: from wmbbd12.prod.google.com ([2002:a05:600c:1f0c:b0:43b:b74b:9350])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:34d5:b0:441:b19c:96fe
 with SMTP id 5b1f17b1804b1-442d6d3e243mr140125965e9.10.1747077094561; Mon, 12
 May 2025 12:11:34 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:36 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7269; i=ardb@kernel.org;
 h=from:subject; bh=vgBLVpHUAk6O1vi3E1PwJCjzQ1f2dPW7uqfVkWdmNWQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3cy0YUurzGvm2/wPt8WnibH2L5nWwP9ogvl6ZV9et
 55qK5uOUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJGOxQz/VE9Oi0jgWKxp8EjA
 2jJpno3ba+//1cobrDjczFuv3pePZGR4rvA3rK5R5GBBtZL3J2NZbabJiTve7JzMGf2/R7y4YzE vAA==
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-24-ardb+git@google.com>
Subject: [RFT PATCH v3 01/21] x86/sev: Separate MSR and GHCB based snp_cpuid()
 via a callback
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
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
 arch/x86/boot/startup/sev-shared.c | 58 ++++----------------
 arch/x86/coco/sev/vc-shared.c      | 49 ++++++++++++++++-
 arch/x86/include/asm/sev.h         |  3 +-
 3 files changed, 61 insertions(+), 49 deletions(-)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 7a706db87b93..408e064a80d9 100644
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
+static void snp_cpuid_hv_no_ghcb(void *ctx, struct cpuid_leaf *leaf)
 {
-	if (sev_cpuid_hv(ghcb, ctxt, leaf))
+	if (__sev_cpuid_hv_msr(leaf))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
 static int __head
-snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
-		      struct cpuid_leaf *leaf)
+snp_cpuid_postprocess(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
+		      void *ctx, struct cpuid_leaf *leaf)
 {
 	struct cpuid_leaf leaf_hv = *leaf;
 
 	switch (leaf->fn) {
 	case 0x1:
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+		cpuid_hv(ctx, &leaf_hv);
 
 		/* initial APIC ID */
 		leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
@@ -517,7 +480,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 		break;
 	case 0xB:
 		leaf_hv.subfn = 0;
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+		cpuid_hv(ctx, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->edx = leaf_hv.edx;
@@ -565,7 +528,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 		}
 		break;
 	case 0x8000001E:
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+		cpuid_hv(ctx, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->eax = leaf_hv.eax;
@@ -587,7 +550,8 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
  * should be treated as fatal by caller.
  */
 int __head
-snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
+	  void *ctx, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -621,7 +585,7 @@ snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 			return 0;
 	}
 
-	return snp_cpuid_postprocess(ghcb, ctxt, leaf);
+	return snp_cpuid_postprocess(cpuid_hv, ctx, leaf);
 }
 
 /*
@@ -648,7 +612,7 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	leaf.fn = fn;
 	leaf.subfn = subfn;
 
-	ret = snp_cpuid(NULL, NULL, &leaf);
+	ret = snp_cpuid(snp_cpuid_hv_no_ghcb, NULL, &leaf);
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
index 6158893786d6..f50a606be4f1 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -533,7 +533,8 @@ struct cpuid_leaf {
 	u32 edx;
 };
 
-int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf);
+int snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
+	      void *ctx, struct cpuid_leaf *leaf);
 
 void __noreturn sev_es_terminate(unsigned int set, unsigned int reason);
 enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
-- 
2.49.0.1045.g170613ef41-goog


