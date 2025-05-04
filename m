Return-Path: <linux-efi+bounces-3557-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40166AA85A7
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1581732E8
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BDD1AA7A6;
	Sun,  4 May 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZZXwJrJH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815261B3952
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352402; cv=none; b=TeV7IzRVpHItRG0KDFLBn5Cqi8KC0GXvJPq7BGrGOVxL5hSXGTbeM91ceB+3ErKZKGYDZ1DUvhii9VhQsju+X8wfNCs9oNbOppPrxysGmVX2cFOz5j0FQnrNnC8gROk9eA9hOewsLAEUEdiZ5+ovbxXb0QsBJPHgCmwvBnI8Fcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352402; c=relaxed/simple;
	bh=0XHRubWlvxhGoOPlMmYL4p0PTmPlw/mD7RVIaahL8sY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QfHqhE7mvpSJZYA5AFPoNr8vt5Qg6pr445RLH6Rxvt7/DCk71YEWMJxrnJ6WoYdFRCnnZ+Q2MF3lQsuNVCJxfaKqB63ncTvem1LScyqx9ySufXS6dKOuzrDiLpTzdWfqVPHCs1yOgumQwB4QJRlr5wsZ+jaAn+x78DMmugPfOhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZZXwJrJH; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d01024089so22445285e9.1
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352399; x=1746957199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3kJ+KMNddTv+kjQ55dJFzUMVOm9H3ODRuwtb5qBjuuQ=;
        b=ZZXwJrJHjW3E2BMvr0YFJXDRQRVLjUc8AtKZq3Nxzu5MZo0XetbwZzEfkiRXt7y761
         ESrXijpt/DeLW9/9GQCltJh2da+PqTrWvBouLjX4A9Z1MLC74D32q37gtEyqMczyFPci
         5lIR6m9/dJpLdhDmifbZKMEg32JlEvhPiZTdrds6Q+Jm0ZflcZiwEmYGNibXhSfsYhWb
         FUrKOArV6QDilsOznCNHJx9aYIrqVo8FW7iIRKWsp5Qnog4w+NlAgSF98UCdC8Y7JSK2
         zHsaAX67op6rUjDF//csrWB4MZd5N9dBkVr5VVSl4HcEvwN1uTKu1HB67pP7nKjUeh4E
         ixRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352399; x=1746957199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kJ+KMNddTv+kjQ55dJFzUMVOm9H3ODRuwtb5qBjuuQ=;
        b=jvAx1Z5COEpBHZhSsoXEtPGrqEbQ2reI178k3iHP4q0sVmoIdS1IRa7A8sCPdCcUHS
         zk0vhEfZA6MBjmP50wXVJxygYw65XWEtZuAUDmlgNZYaOehZ1Rvca7V7OiuevAt8XWQy
         FgCgxN52J8t0nz1Gjr+T8xoHDsJEM8UdeFGBtgtCvbwGTnBsV6MspxXtT4Bu7CkL5mSj
         Jaglk/LnMUS1Ew22By9LJkyTUqe9KRjbt/MLFkaxefx9IxSd4FNPOYwfSPJLWN80kQvO
         6iwJQdxMXyaPd+91B1yWqlfjUmZ2qCwsZ9XP7gfN152eKLLCV+mpZSYa5kvJOch5A4+5
         ik6w==
X-Gm-Message-State: AOJu0Yy+Qw4Z7Ixo3DRWwhDVtk1HkPYtvVnjI2JVa2gA+/XdswhYVyrW
	u2UV8shMItzBo7eQVlnup3AUSZnNidi+Gw+1PQl8t2opgwPlHKM0rUlYu/sUPWcDWtKQug==
X-Google-Smtp-Source: AGHT+IEzXD80Qu7nqtQLSpTQz6noqKOtcFrzINt/dHyOuOPEcLbKdNREk9XewiF1CRE8vF7zu9fi4Br1
X-Received: from wmsp15.prod.google.com ([2002:a05:600c:1d8f:b0:43d:56fa:9b95])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c07:b0:43c:fe9f:ab90
 with SMTP id 5b1f17b1804b1-441c4937630mr25859795e9.28.1746352398955; Sun, 04
 May 2025 02:53:18 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:37 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7268; i=ardb@kernel.org;
 h=from:subject; bh=Zd4Hy2l6+2Xwx0i5ZHR0ISwcKyYHYyYNXAs7wzR0PHY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4sWDGrsSH3W+mysdvJcufZzdVGtYGau+JCJz+o71s
 WdKZDk6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETuf2X4Z8Kk/9rS2ZJ1akj7
 yai+JlNP/Wfmy2Pr3orkbImtLEmxZWT4duht98lvxR/uJR+7nPOht3TrrX1Vfx+82irEm+VX+02 TEQA=
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-32-ardb+git@google.com>
Subject: [RFT PATCH v2 07/23] x86/sev: Separate MSR and GHCB based snp_cpuid()
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
2.49.0.906.g1f30a19c02-goog


