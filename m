Return-Path: <linux-efi+bounces-3998-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBEAAE9825
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 10:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F7A1C2260C
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840025BEF6;
	Thu, 26 Jun 2025 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHAtd2Ro"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F711FF7B4;
	Thu, 26 Jun 2025 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925952; cv=none; b=Lwt0PvPapl7CX+9uIEgb14b5uy7A8xasDICXbj2VppTGzuR+/YqNt7IyubvR1vV3uayIiJlzWc+bBnLOL6gp/a4V+bJXD+RNi5H8y2Y/ojiQ/f08VyN9IY3ZQA6/VTyxKeMEne96at1y3i0/Kx1C7DRaMxsYpwYHUaI2jFt5te0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925952; c=relaxed/simple;
	bh=agZj/wzaMpG6bvF18cvXlY4v555Y3BqcKQTQxhyrWhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWPEF/xpO2ws4gJrn6nC9YL33DzDWe1GjJ/5tAI6St/2LSLHRSck9z7nROgFX0cNQAgYSqSP2qjBpyt5i3XJ81q9fnH0VrlQk0QkMMg/JAqIB7ClRqiQZL1h/Dc1ZmIY9Wuar3AqYwo86G29/ooCLOHkPC1xdKTLSlqe3ihKkoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHAtd2Ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32322C4CEEB;
	Thu, 26 Jun 2025 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925951;
	bh=agZj/wzaMpG6bvF18cvXlY4v555Y3BqcKQTQxhyrWhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHAtd2RowB8YUj61KdTZX0EkkfQeqM1sQjQiU4ebRUsQTxFnsAtvwmSnDVNOKt3Lj
	 dZv41Y0aTFp+blxCjjjciIAfJTKsQP8atdMyF50ceEgJymd9Pt2Vwv3h/ZsWHqdv77
	 9oHdmNyvr+g3lRPE+tAJ+Uiei6mQ1ZTGltFj5nC18Di9/5zaGQLzlOUqKhW355+jSZ
	 3cudfWUHngbills5+n/2rOKx4Dfh9tdjvS820U27v+Mye/XZsNh/sKyFkcb0PHbjaX
	 C7Zx2maWxH0nhD12jbl/oyoiKbJSQQ2zldEOPcyG1A/meONM7Uczvd6NuXowBPzuup
	 9c/+RORnADZXw==
Date: Thu, 26 Jun 2025 10:19:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] x86/sev: Let sev_es_efi_map_ghcbs() map the caa
 pages too
Message-ID: <aF0CemSo0go8-Bru@gmail.com>
References: <20250626074236.307848-1-kraxel@redhat.com>
 <20250626074236.307848-3-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626074236.307848-3-kraxel@redhat.com>


* Gerd Hoffmann <kraxel@redhat.com> wrote:

> OVMF EFI firmware needs access to the CAA page to do SVSM protocol calls. For
> example, when the SVSM implements an EFI variable store, such calls will be
> necessary.
> 
> So add that to sev_es_efi_map_ghcbs() and also rename the function to reflect
> the additional job it is doing now.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  arch/x86/include/asm/sev.h     |  4 ++--
>  arch/x86/coco/sev/core.c       | 20 ++++++++++++++++++--
>  arch/x86/platform/efi/efi_64.c |  4 ++--
>  3 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 58e028d42e41..6e0ef192f23b 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -445,7 +445,7 @@ static __always_inline void sev_es_nmi_complete(void)
>  	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
>  		__sev_es_nmi_complete();
>  }
> -extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
> +extern int __init sev_es_efi_map_ghcbs_caas(pgd_t *pgd);
>  extern void sev_enable(struct boot_params *bp);
>  
>  /*
> @@ -556,7 +556,7 @@ static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>  static inline void sev_es_ist_exit(void) { }
>  static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
>  static inline void sev_es_nmi_complete(void) { }
> -static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
> +static inline int sev_es_efi_map_ghcbs_caas(pgd_t *pgd) { return 0; }
>  static inline void sev_enable(struct boot_params *bp) { }
>  static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
>  static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index b6db4e0b936b..b52318d806b6 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1045,11 +1045,13 @@ int __init sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
>   * This is needed by the OVMF UEFI firmware which will use whatever it finds in
>   * the GHCB MSR as its GHCB to talk to the hypervisor. So make sure the per-cpu
>   * runtime GHCBs used by the kernel are also mapped in the EFI page-table.
> + *
> + * When running under SVSM the CCA page is needed too, so map it as well.
>   */
> -int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
> +int __init sev_es_efi_map_ghcbs_caas(pgd_t *pgd)
>  {
>  	struct sev_es_runtime_data *data;
> -	unsigned long address, pflags;
> +	unsigned long address, pflags, pflags_enc;
>  	int cpu;
>  	u64 pfn;
>  
> @@ -1057,6 +1059,7 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
>  		return 0;
>  
>  	pflags = _PAGE_NX | _PAGE_RW;
> +	pflags_enc = cc_mkenc(pflags);
>  
>  	for_each_possible_cpu(cpu) {
>  		data = per_cpu(runtime_data, cpu);
> @@ -1068,6 +1071,19 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
>  			return 1;
>  	}
>  
> +	if (!snp_vmpl)
> +		return 0;
> +
> +	for_each_possible_cpu(cpu) {


So while it's only run-once __init code, still there's no good reason 
to have *two* all-CPUs loops in the same function.

> +		address = per_cpu(svsm_caa_pa, cpu);
> +		if (!address)
> +			return 1;

Yeah, so could we please use sensible & standard error return values 
such as -EINVAL? This is a pre-existing problem in this function, so it 
should be done in a separate, preparatory patch. (And yeah, the error 
codes of efi_setup_page_tables() are kinda lame too, but there's no 
reason to repeat that mistake in the SEV code.)

> +
> +		pfn = address >> PAGE_SHIFT;
> +		if (kernel_map_pages_in_pgd(pgd, pfn, address, 1, pflags_enc))
> +			return 1;


Ditto - for consistency this should just pass through the error code 
that kernel_map_pages_in_pgd() gives.

No objections to the added functionality/fix aspect.

Thanks,

	Ingo

