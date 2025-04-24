Return-Path: <linux-efi+bounces-3455-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5562DA9B279
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 17:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26914188C550
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7AB27B50D;
	Thu, 24 Apr 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6X94TCR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033501ACEBB;
	Thu, 24 Apr 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508875; cv=none; b=NWx3tj6oGUrvi1wdSN2E7v/+eehnRCbd5yqm65hwddUdaxb58U+AUiodeVHdC/wBGnYqjI6jcQ0b45y/5hBR4LOObdzaIzw8INGkDzYk2WxdKEHRhtp7gmjI1IeMkCzXby1MjE0j9Tw8IlYqdMLp5T9J20YKCQWV+ANpPuqfg2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508875; c=relaxed/simple;
	bh=LZTHQrtct7I0W/ebUGRhLcTlWogxfJUTN7BhmEfy4Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hd041uqtKzoaihiXHEvanMwsWj2O6AAbv1ggtBwJsv2yNbZ8fptyCT0UD45eJu0w1GayqqdhMSXPtovDUmg+8r5ieDxM6sTk+07uCEZwVc0uXzM6gvShgM91kPivm5ZSt3owb3srZB6OE4MvbouzdHbY6wxS+sk+MiNMPUqwFog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6X94TCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE39DC4CEE3;
	Thu, 24 Apr 2025 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745508874;
	bh=LZTHQrtct7I0W/ebUGRhLcTlWogxfJUTN7BhmEfy4Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6X94TCRJcZtfi5tbgYAV51PuZVmZvMGxpnte/WLJIGFkd9qSiA+B8J7C923cIFIw
	 i+tTOjmb0vdTGCvfIF1pNrfQgdeg9EftHilwxM2wc26UhArimvjhBRGeiXRPcWF2AN
	 es+QNEPyZtunCbc+hvbg8qBVvNz80LON2Jbn/vS95DQY1nZLFFl5g0RYOjU5nfjv63
	 EE6Y/tZMKEFlHfxRaVmryRsDfoXlCqkFULQrcYMWSxetKiPiG7+GUwS067evGzrH/N
	 bQxlJKKz1umurrAX/hjJ2W7j0O8eZ3ROgHj5CR1LFZvUTouwGRuhHVCED47l3vCta3
	 fmgkBZL7M7ZJQ==
Date: Thu, 24 Apr 2025 17:34:00 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: [PATCH] x86/sev: Share the sev_secrets_pa value again
Message-ID: <aApZ6JwPQ8Cde3OK@gmail.com>
References: <20250418141253.2601348-8-ardb+git@google.com>
 <20250418141253.2601348-11-ardb+git@google.com>
 <cf878810-81ed-3017-52c6-ce6aa41b5f01@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf878810-81ed-3017-52c6-ce6aa41b5f01@amd.com>


* Tom Lendacky <thomas.lendacky@amd.com> wrote:

> On 4/18/25 09:12, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > Disentangle the SEV core code and the SEV code that is called during
> > early boot. The latter piece will be moved into startup/ in a subsequent
> > patch.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> 
> This patch breaks SNP guests. The SNP guest boots, but no longer has
> access to the VMPCK keys needed to communicate with the ASP, which is
> used, for example, to obtain an attestation report.
> 
> It looks like the secrets_pa is defined as static in both startup.c and
> core.c. It is set by a function in startup.c and so when used in core.c
> its value will be 0.
> 
> The following fixed the issue for me. Let me know if it can be squashed
> in or a full patch is needed. Although, it likely should be named
> sev_secrets_pa since it is no longer static.

Thanks for the fix!

I wrote a changelog for it and also included the suggested rename to 
sev_secrets_pa as it's now a global symbol. I've added your SOB as 
well. Does this patch look good to you?

Thanks,

	Ingo

==========================================>
From: Tom Lendacky <thomas.lendacky@amd.com>
Date: Wed, 23 Apr 2025 10:22:31 -0500
Subject: [PATCH] x86/sev: Share the sev_secrets_pa value again

This commits breaks SNP guests:

  234cf67fc3bd ("x86/sev: Split off startup code from core code")

The SNP guest boots, but no longer has access to the VMPCK keys needed
to communicate with the ASP, which is used, for example, to obtain an
attestation report.

The secrets_pa value is defined as static in both startup.c and
core.c. It is set by a function in startup.c and so when used in
core.c its value will be 0.

Share it again and add the sev_ prefix to put it into the global
SEV symbols namespace.

[ mingo: Renamed to sev_secrets_pa ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Link: https://lore.kernel.org/r/cf878810-81ed-3017-52c6-ce6aa41b5f01@amd.com
---
 arch/x86/boot/startup/sev-startup.c | 4 ++--
 arch/x86/coco/sev/core.c            | 7 ++-----
 arch/x86/include/asm/sev-internal.h | 1 +
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 36a75c5096b0..f901ce9680e6 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -55,7 +55,7 @@ struct ghcb *boot_ghcb __section(".data");
 u64 sev_hv_features __ro_after_init;
 
 /* Secrets page physical address from the CC blob */
-static u64 secrets_pa __ro_after_init;
+u64 sev_secrets_pa __ro_after_init;
 
 /* For early boot SVSM communication */
 struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
@@ -1367,7 +1367,7 @@ bool __head snp_init(struct boot_params *bp)
 		return false;
 
 	if (cc_info->secrets_phys && cc_info->secrets_len == PAGE_SIZE)
-		secrets_pa = cc_info->secrets_phys;
+		sev_secrets_pa = cc_info->secrets_phys;
 	else
 		return false;
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 617988a5f3d7..ac400525de73 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -80,9 +80,6 @@ static const char * const sev_status_feat_names[] = {
 	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMTProt",
 };
 
-/* Secrets page physical address from the CC blob */
-static u64 secrets_pa __ro_after_init;
-
 /*
  * For Secure TSC guests, the BSP fetches TSC_INFO using SNP guest messaging and
  * initializes snp_tsc_scale and snp_tsc_offset. These values are replicated
@@ -109,7 +106,7 @@ static u64 __init get_snp_jump_table_addr(void)
 	void __iomem *mem;
 	u64 addr;
 
-	mem = ioremap_encrypted(secrets_pa, PAGE_SIZE);
+	mem = ioremap_encrypted(sev_secrets_pa, PAGE_SIZE);
 	if (!mem) {
 		pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
 		return 0;
@@ -1599,7 +1596,7 @@ struct snp_msg_desc *snp_msg_alloc(void)
 	if (!mdesc)
 		return ERR_PTR(-ENOMEM);
 
-	mem = ioremap_encrypted(secrets_pa, PAGE_SIZE);
+	mem = ioremap_encrypted(sev_secrets_pa, PAGE_SIZE);
 	if (!mem)
 		goto e_free_mdesc;
 
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index e54847a69107..a78f97208a39 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -5,6 +5,7 @@
 extern struct ghcb boot_ghcb_page;
 extern struct ghcb *boot_ghcb;
 extern u64 sev_hv_features;
+extern u64 sev_secrets_pa;
 
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {

