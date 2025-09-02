Return-Path: <linux-efi+bounces-4668-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA16B3FFD9
	for <lists+linux-efi@lfdr.de>; Tue,  2 Sep 2025 14:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13F5543AA9
	for <lists+linux-efi@lfdr.de>; Tue,  2 Sep 2025 12:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806FB2F5496;
	Tue,  2 Sep 2025 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iekwy2bZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3002F3C12;
	Tue,  2 Sep 2025 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814829; cv=none; b=vFJQl4xzEHrXM4zW41L9kUs2k88+9SpuA5Hrf6/vLBuDL8TgBaPW2PDEWlBz4ZlAfq8En5xx5rVeL/fh2/8nVQIe7+Rp3ouGCRfJ7/obvF2lgooF76c9so0ia1dhkJ7gxHFqKrP+S38/8Gz1/BuVJ6skXtNnpQjZbIsvOfDAQG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814829; c=relaxed/simple;
	bh=D6qJALJ72rYjadWcVJQkmqDt0zTWZuBg/EKiaR4fjeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiyfoJiK9BnL8TUER8MXYjq8g2rhP/dthf//ne+jOUS2umcR706wZBw5B9/AelsIJSYPwGwHELNd/xOC0x1ifFDn7aH/e4k2F49zykM6+bMO2AW8S5lQmew6z7KfIs1PZPMMU70LOdOODzpCknYWjcCJSs2Zoqjr5YxDfW0lJ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iekwy2bZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A0B9B40E01CD;
	Tue,  2 Sep 2025 12:07:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mY44Bz8hlKKw; Tue,  2 Sep 2025 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756814820; bh=+Ci97lgH9Q/96lnHUBZnJ6/A0GQqo2s3yBOxDRZTOo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iekwy2bZwnUEREzT2Xzzu2NqfR/TsBKrPMXOPem2yMAF3v49QJHLG16df67wXlO65
	 9xQTOaW/143RUAEmewLveQP/1B4JiYWVgdTr9ebYed7yDyFeWKoDtUTkw2DLzL7lOU
	 dfo/1bpRtL2b3UzBVDb9xIw6IKcf5D8cWPwE7CpqqsVj+ITvve+yYWsKxcZ8bgwh4J
	 i/iW9W799jWMDhvmVq17HQn44N4NbIh3tILTF8Cr6IPdGX6b/IeA3PBgBgbSAPdb1v
	 JuGizQ1hbNrrh+yGtzfXgD2Fc3UsbpN/R7knlb/HYT3x+edLpSDqfQTg4Y8EpqHlx/
	 qq9UkmzP9McY1I1VODET5cVNVwWX1YouoWtu1oh5FYz/+XpVknD7qp7mRCjBl/kuZJ
	 mjk/RASP8a4L4LBGKo55yhIIUT8OL63EQdbOuqXpHaAcA+DVV23RgQb36UXbgNiFe8
	 taGDukwjYvn5uBDpA34bxE/+dHEaqa+KxCT449m9vHixmsY2iT3I4PH28FDPgrKXv1
	 tMe+tvDNVwh/zc9PYG7+ah/cKheu4VTZDV5q3wOy4oEDfmKwjKnZtjFnjv6f9YsDja
	 XdfVfaZf5ebXeJd3LxAY3CjWSLA+hdmqU2nlwwIOxBIk4KXztAbUs8G6QaP+jThYGz
	 W61G+gjBo5qqgSLT6rtT1SwI=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9FE6440E015D;
	Tue,  2 Sep 2025 12:06:49 +0000 (UTC)
Date: Tue, 2 Sep 2025 14:06:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v7 12/22] x86/sev: Provide PIC aliases for SEV related
 data objects
Message-ID: <20250902120648.GFaLbd2LyZYkQ4l8WV@fat_crate.local>
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-36-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828102202.1849035-36-ardb+git@google.com>

On Thu, Aug 28, 2025 at 12:22:15PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Provide PIC aliases for data objects that are shared between the SEV
> startup code and the SEV code that executes later. This is needed so
> that the confined startup code is permitted to access them.
> 
> This requires some of these variables to be moved into a source file
> that is not part of the startup code, as the PIC alias is already
> implied, and exporting variables in the opposite direction is not
> supported.
> 
> Move ghcb_version as well, but don't provide a PIC alias as it is not
> actually needed.

I see

SYM_PIC_ALIAS(ghcb_version);

below.

Stale commit message?

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/sev.c      |  3 ++
>  arch/x86/boot/startup/sev-shared.c  | 19 -----------
>  arch/x86/boot/startup/sev-startup.c |  9 ------
>  arch/x86/coco/sev/core.c            | 34 ++++++++++++++++++++
>  4 files changed, 37 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index d650a314143b..6822eb4b9152 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -38,6 +38,9 @@ struct ghcb *boot_ghcb;
>  #define __BOOT_COMPRESSED
>  
>  u8 snp_vmpl;
> +u16 ghcb_version;
> +
> +u64 boot_svsm_caa_pa;
>  
>  /* Include code for early handlers */
>  #include "../../boot/startup/sev-shared.c"
> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> index b86027d9a968..180f54570022 100644
> --- a/arch/x86/boot/startup/sev-shared.c
> +++ b/arch/x86/boot/startup/sev-shared.c
> @@ -19,25 +19,6 @@
>  #define WARN(condition, format...) (!!(condition))
>  #endif
>  
> -/*
> - * SVSM related information:
> - *   During boot, the page tables are set up as identity mapped and later
> - *   changed to use kernel virtual addresses. Maintain separate virtual and
> - *   physical addresses for the CAA to allow SVSM functions to be used during
> - *   early boot, both with identity mapped virtual addresses and proper kernel
> - *   virtual addresses.
> - */
> -u64 boot_svsm_caa_pa __ro_after_init;
> -
> -/*
> - * Since feature negotiation related variables are set early in the boot
> - * process they must reside in the .data section so as not to be zeroed
> - * out when the .bss section is later cleared.
> - *
> - * GHCB protocol version negotiated with the hypervisor.
> - */
> -u16 ghcb_version __ro_after_init;
> -
>  /* Copy of the SNP firmware's CPUID page. */
>  static struct snp_cpuid_table cpuid_table_copy __ro_after_init;
>  
> diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
> index b0fc63f8dee1..138b26f14ff1 100644
> --- a/arch/x86/boot/startup/sev-startup.c
> +++ b/arch/x86/boot/startup/sev-startup.c
> @@ -41,15 +41,6 @@
>  #include <asm/cpuid/api.h>
>  #include <asm/cmdline.h>
>  
> -/* Bitmap of SEV features supported by the hypervisor */
> -u64 sev_hv_features __ro_after_init;
> -
> -/* Secrets page physical address from the CC blob */
> -u64 sev_secrets_pa __ro_after_init;
> -
> -/* For early boot SVSM communication */
> -struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
> -
>  /*
>   * Nothing shall interrupt this code path while holding the per-CPU
>   * GHCB. The backup GHCB is only for NMIs interrupting this path.
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 9782ebe30675..b9133c825f90 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -46,6 +46,29 @@
>  #include <asm/cmdline.h>
>  #include <asm/msr.h>
>  
> +/* Bitmap of SEV features supported by the hypervisor */
> +u64 sev_hv_features __ro_after_init;
> +SYM_PIC_ALIAS(sev_hv_features);
> +
> +/* Secrets page physical address from the CC blob */
> +u64 sev_secrets_pa __ro_after_init;
> +SYM_PIC_ALIAS(sev_secrets_pa);
> +
> +/* For early boot SVSM communication */
> +struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
> +SYM_PIC_ALIAS(boot_svsm_ca_page);
> +
> +/*
> + * SVSM related information:
> + *   During boot, the page tables are set up as identity mapped and later
> + *   changed to use kernel virtual addresses. Maintain separate virtual and
> + *   physical addresses for the CAA to allow SVSM functions to be used during
> + *   early boot, both with identity mapped virtual addresses and proper kernel
> + *   virtual addresses.
> + */
> +u64 boot_svsm_caa_pa __ro_after_init;
> +SYM_PIC_ALIAS(boot_svsm_caa_pa);
> +
>  DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
>  DEFINE_PER_CPU(u64, svsm_caa_pa);
>  
> @@ -119,6 +142,17 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
>   */
>  u8 snp_vmpl __ro_after_init;
>  EXPORT_SYMBOL_GPL(snp_vmpl);
> +SYM_PIC_ALIAS(snp_vmpl);
> +
> +/*
> + * Since feature negotiation related variables are set early in the boot
> + * process they must reside in the .data section so as not to be zeroed
> + * out when the .bss section is later cleared.
> + *
> + * GHCB protocol version negotiated with the hypervisor.
> + */
> +u16 ghcb_version __ro_after_init;
> +SYM_PIC_ALIAS(ghcb_version);
>  
>  /* For early boot hypervisor communication in SEV-ES enabled guests */
>  static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
> -- 
> 2.51.0.268.g9569e192d0-goog
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

