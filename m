Return-Path: <linux-efi+bounces-3712-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FA6AB8485
	for <lists+linux-efi@lfdr.de>; Thu, 15 May 2025 13:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204B61B61B4F
	for <lists+linux-efi@lfdr.de>; Thu, 15 May 2025 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E08297B86;
	Thu, 15 May 2025 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PG5DiDVw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67141DE4EC;
	Thu, 15 May 2025 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307424; cv=none; b=k+ZzFGNPiTZr1pHWpTskY9DalvhoLT10L9nYl+JELKQJLQIezpanxo54HqiTeuwoEcu+hfIfgM3AVYzNjMg4Zr71Zw0/yXX3mBEPThglUNvVbTJg/jUD6c+dG6edhh7N1UddWDrpE1Fy81pXoyncptwyHG9V9m1p8wvZk5KmxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307424; c=relaxed/simple;
	bh=dOSpEwILtvqK7dsEfINsAvMIVPK19AOSi7QavgluMlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jwd9lrz4CBnNpJ498U8V2M8vjO/3vMIS2698R0/TcxujecPc9PJOstkYPTtdsXo7Jww7dsG6aM9oWzcj/xnziqQDcEMv00wiNDzZwOG95yT5iNDrBgSkZZO1CaLu/o2xAb5q5On+ZfYS9FB9fkXDDAXEANK8adFP25EF715aTvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PG5DiDVw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D91FB40E0222;
	Thu, 15 May 2025 11:10:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CdIDGR7wdB9i; Thu, 15 May 2025 11:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747307415; bh=mcjbdkqU6NFpAJs04IaNgq1bhla1EfQq1yGFnWFMhmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PG5DiDVwgkmfO2WU4EtR/dwynzVX4zy0bNVb/XZelLlHYNQct7YfQEsxfCoxoyAzZ
	 G7M9FYyd/sGpIdjPrCF+COuDQ1dWP6p+5QoEkA4tRQhIDmT1sZ9BQl8/Ki02oRDIKX
	 mD1rZ+Z8+FuwcOEk31K7/SJASBZZat5ZR2ON1NGq5ZiLR5+FD2nHv5QzCPS2N8dC1R
	 yW8wXI1c+EtavjJaoezQc6/Dm3fjk/1CZID4Vd4P9U4B2ypLvAeUC0xBe1obT0/9b5
	 5Y90tsklSe/2AkgnLtokwsjyiFVe2VJQaNGmmyV4Sx4lwSlwX2Jf0q5DtYgkHNozhl
	 n+1n3lGOQBCfXcbjsOrq9xHcNvk/W7dkTGJ/YaoL9MvNNx0vkt0dwpdh6WE+PH7/9U
	 prUfQQeST5P+/kF4hO1QD3aEnRPSK1La07LzcXP5tKcHhHC2McHrD3eTShCNB/+aWe
	 ZGiX0qHEoGRuLBWkJ4zoya69eT91RVE+yvP00Ci83MgKcmZCD+MH26c5FXLW3t4llr
	 rveci8Ju7GXnhonX/dW+d3mEARjkFCS37RL3tlWXb9YJd2M9d4l6SxDsiBc4LpD00G
	 S7fh+NQKeQQhQb/gxdHMXfGQltSj82COF6ElQLdCEh9sbo98VUMBKb+xkGxqmrCWYs
	 OkfWCwgfhyImQL2pcuWc/mUU=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 23A3240E01ED;
	Thu, 15 May 2025 11:10:06 +0000 (UTC)
Date: Thu, 15 May 2025 13:10:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v3 01/21] x86/sev: Separate MSR and GHCB based
 snp_cpuid() via a callback
Message-ID: <20250515111000.GBaCXLiEi0_bG1qVzx@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512190834.332684-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512190834.332684-24-ardb+git@google.com>

On Mon, May 12, 2025 at 09:08:36PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> There are two distinct callers of snp_cpuid(): one where the MSR
> protocol is always used, and one where the GHCB page based interface is
> always used.

Yeah, let's stick to the nomenclature, pls: you have a GHCB protocol and a MSR
protocol. We call both protocols. :)

> The snp_cpuid() logic does not care about the distinction, which only
> matters at a lower level. But the fact that it supports both interfaces
> means that the GHCB page based logic is pulled into the early startup
> code where PA to VA conversions are problematic, given that it runs from
> the 1:1 mapping of memory.
> 
> So keep snp_cpuid() itself in the startup code, but factor out the
> hypervisor calls via a callback, so that the GHCB page handling can be
> moved out.
> 
> Code refactoring only - no functional change intended.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/startup/sev-shared.c | 58 ++++----------------
>  arch/x86/coco/sev/vc-shared.c      | 49 ++++++++++++++++-
>  arch/x86/include/asm/sev.h         |  3 +-
>  3 files changed, 61 insertions(+), 49 deletions(-)

...

> @@ -484,21 +447,21 @@ snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
>  	return false;
>  }
>  
> -static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
> +static void snp_cpuid_hv_no_ghcb(void *ctx, struct cpuid_leaf *leaf)

Uff, those suffixes make my head hurt. So this is the MSR prot CPUID. Let's
call it this way:

	snp_cpuid_msr_prot()

and the other one 

	snp_cpuid_ghcb_prot()

All clear this way.

>  {
> -	if (sev_cpuid_hv(ghcb, ctxt, leaf))
> +	if (__sev_cpuid_hv_msr(leaf))

__sev_cpuid_msr_prot

>  		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
>  }
>  
>  static int __heada

Let's zap that ugly linebreak.

> -snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
> -		      struct cpuid_leaf *leaf)
> +snp_cpuid_postprocess(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),

Let's call that just "cpuid" now that it can be different things and it is
a pointer.

> +		      void *ctx, struct cpuid_leaf *leaf)
>  {
>  	struct cpuid_leaf leaf_hv = *leaf;
>  
>  	switch (leaf->fn) {
>  	case 0x1:
> -		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
> +		cpuid_hv(ctx, &leaf_hv);
>  
>  		/* initial APIC ID */
>  		leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
> @@ -517,7 +480,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>  		break;
>  	case 0xB:
>  		leaf_hv.subfn = 0;
> -		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
> +		cpuid_hv(ctx, &leaf_hv);
>  
>  		/* extended APIC ID */
>  		leaf->edx = leaf_hv.edx;
> @@ -565,7 +528,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>  		}
>  		break;
>  	case 0x8000001E:
> -		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
> +		cpuid_hv(ctx, &leaf_hv);
>  
>  		/* extended APIC ID */
>  		leaf->eax = leaf_hv.eax;
> @@ -587,7 +550,8 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>   * should be treated as fatal by caller.
>   */
>  int __head

And that ugly linebreak too pls.

...

Here's a diff ontop with my changes. I think it looks a lot saner now and one
can really differentiate which is which.

Could more cleanup be done? Ofc. But that for later patches.

Thx.

---

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 408e064a80d9..992abfa50508 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -319,7 +319,7 @@ static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
 	return 0;
 }
 
-static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
+static int __sev_cpuid_msr_prot(struct cpuid_leaf *leaf)
 {
 	int ret;
 
@@ -447,21 +447,20 @@ snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 	return false;
 }
 
-static void snp_cpuid_hv_no_ghcb(void *ctx, struct cpuid_leaf *leaf)
+static void snp_cpuid_msr_prot(void *ctx, struct cpuid_leaf *leaf)
 {
-	if (__sev_cpuid_hv_msr(leaf))
+	if (__sev_cpuid_msr_prot(leaf))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
-static int __head
-snp_cpuid_postprocess(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
-		      void *ctx, struct cpuid_leaf *leaf)
+static int __head snp_cpuid_postprocess(void (*cpuid)(void *ctx, struct cpuid_leaf *),
+					void *ctx, struct cpuid_leaf *leaf)
 {
 	struct cpuid_leaf leaf_hv = *leaf;
 
 	switch (leaf->fn) {
 	case 0x1:
-		cpuid_hv(ctx, &leaf_hv);
+		cpuid(ctx, &leaf_hv);
 
 		/* initial APIC ID */
 		leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
@@ -480,7 +479,7 @@ snp_cpuid_postprocess(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
 		break;
 	case 0xB:
 		leaf_hv.subfn = 0;
-		cpuid_hv(ctx, &leaf_hv);
+		cpuid(ctx, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->edx = leaf_hv.edx;
@@ -528,7 +527,7 @@ snp_cpuid_postprocess(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
 		}
 		break;
 	case 0x8000001E:
-		cpuid_hv(ctx, &leaf_hv);
+		cpuid(ctx, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->eax = leaf_hv.eax;
@@ -549,9 +548,8 @@ snp_cpuid_postprocess(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-int __head
-snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
-	  void *ctx, struct cpuid_leaf *leaf)
+int __head snp_cpuid(void (*cpuid)(void *ctx, struct cpuid_leaf *), void *ctx,
+		     struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -585,7 +583,7 @@ snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
 			return 0;
 	}
 
-	return snp_cpuid_postprocess(cpuid_hv, ctx, leaf);
+	return snp_cpuid_postprocess(cpuid, ctx, leaf);
 }
 
 /*
@@ -612,14 +610,14 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	leaf.fn = fn;
 	leaf.subfn = subfn;
 
-	ret = snp_cpuid(snp_cpuid_hv_no_ghcb, NULL, &leaf);
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
index b4688f69102e..776cb90be530 100644
--- a/arch/x86/coco/sev/vc-shared.c
+++ b/arch/x86/coco/sev/vc-shared.c
@@ -409,7 +409,7 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
-static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+static int __sev_cpuid_ghcb_prot(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
 	u32 cr4 = native_read_cr4();
 	int ret;
@@ -447,11 +447,11 @@ struct cpuid_ctx {
 	struct es_em_ctxt *ctxt;
 };
 
-static void snp_cpuid_hv_ghcb(void *p, struct cpuid_leaf *leaf)
+static void snp_cpuid_ghcb_prot(void *p, struct cpuid_leaf *leaf)
 {
 	struct cpuid_ctx *ctx = p;
 
-	if (__sev_cpuid_hv_ghcb(ctx->ghcb, ctx->ctxt, leaf))
+	if (__sev_cpuid_ghcb_prot(ctx->ghcb, ctx->ctxt, leaf))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
@@ -464,7 +464,7 @@ static int vc_handle_cpuid_snp(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 
 	leaf.fn = regs->ax;
 	leaf.subfn = regs->cx;
-	ret = snp_cpuid(snp_cpuid_hv_ghcb, &ctx, &leaf);
+	ret = snp_cpuid(snp_cpuid_ghcb_prot, &ctx, &leaf);
 	if (!ret) {
 		regs->ax = leaf.eax;
 		regs->bx = leaf.ebx;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

