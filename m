Return-Path: <linux-efi+bounces-3756-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 665ECABD709
	for <lists+linux-efi@lfdr.de>; Tue, 20 May 2025 13:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65F58A7A19
	for <lists+linux-efi@lfdr.de>; Tue, 20 May 2025 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEDA27A47C;
	Tue, 20 May 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f9ie6QQL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA81DE2A8;
	Tue, 20 May 2025 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741153; cv=none; b=LD0GvAGuCKATf+drAFIbLfIzgzvk9H0hd0AzS9MHYJvddpLFx54Z2eRDCvTXoGaBgP52jBDSS5cLhxk58xSvTBJ0CT846LwPuaWYeCNBjBXPmoT/qZPh+tEPPPHjSLa6Nq2ldcG6hSUX+BO3IQbJFBjuDt5IOwOWOzMpMYZkFgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741153; c=relaxed/simple;
	bh=oYh8G4JIVxhFwKyKSysp9R5AdOvLFZhl6hLYBOyr3G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9d88+uBm1GSvUBAl+GgRdahpJzzBybzxbCR+FdFF/SoamgKfN6dOZa9KRi9mBUMUsZug8h1F50KBexmNnQpZHUQnE5xH510koLcGF5/qxLhLda2ZJWTYgy6r7gPa6WcIbUKghK9p5aYMYJQZQAQv7kSTa7O6KZy7YxyXgSBFbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f9ie6QQL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 61ED140E016A;
	Tue, 20 May 2025 11:39:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6UkYHkhvtnbd; Tue, 20 May 2025 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747741144; bh=dokcQ2YdP6ZzHV0g9+3ZFOSsJK6WqTO7QD8DX7AVhpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9ie6QQLACdJlOTTl1fC0oiaMlDvDQgTHOhdLJk9MFbc2hdPadKHFCcn2KFHGfgI1
	 ne0+YvNyzVJgplkUy6CgL3dI57KzLDjvLCGPO/Ly3zRLqcrvBVtxsImS09q8Vm+7CC
	 PL2rAkHStFXi1OZ/tmXUmRIGYlmA5cD10UIRG/4Gau/nYTW0mXNFrmEz2YE2wu2One
	 ZiKT5rZVxjofzzzu3laPgvHw0yrn7P28E3yUOfntMq/WeRChGy23B/8uzZtXeuBMSN
	 ORfsPtOHrx15OWj69xz/aP8zudIGC261BET4tUPzf+67iniPQ2awq11VQzzaykfr/W
	 ERThxzfsLtUTu9Hk85nvRNo1pn2StcNx4n+IlC9lkHyctN3vT8HZd/YKCb7A9tXdgf
	 nm4L6p3srlfoYQptGTrYpDdnQU9Z3wfO2rjv+GfMiAJQlv7RTsYTMV8xsEHXtN9t79
	 zKJ32G7J7qyXpBltRwHYC5s2otcCJtrNP0LzHMvgs/AWt6rcyObuGo2oX7Yf5vb4R4
	 9qSPjKo8aJQem1ZL84LydcZGoOLr2vYHgNV6vdOoM7YJD0MgKkPOFsERMV3RqyIJEf
	 jhwHZyumT9MHkXWlPBbfTegElBFzqnHjWqtPl+oubta2DWBl2IcFr1DLjUCYNWqhK8
	 cMzN1MaXunrY8SGHpyWgaGb8=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C78440E0238;
	Tue, 20 May 2025 11:38:55 +0000 (UTC)
Date: Tue, 20 May 2025 13:38:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v3 05/21] x86/sev: Move GHCB page based HV
 communication out of startup code
Message-ID: <20250520113849.GKaCxpyVy-7N6bih-r@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512190834.332684-28-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512190834.332684-28-ardb+git@google.com>

On Mon, May 12, 2025 at 09:08:40PM +0200, Ard Biesheuvel wrote:
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index f50a606be4f1..07081bb85331 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -485,6 +485,7 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
>  struct snp_guest_request_ioctl;
>  
>  void setup_ghcb(void);
> +void snp_register_ghcb_early(unsigned long paddr);
>  void early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
>  				  unsigned long npages);
>  void early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
> @@ -521,8 +522,6 @@ static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
>  	__builtin_memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
>  }
>  
> -void vc_forward_exception(struct es_em_ctxt *ctxt);
> -
>  /* I/O parameters for CPUID-related helpers */
>  struct cpuid_leaf {
>  	u32 fn;
> @@ -533,15 +532,71 @@ struct cpuid_leaf {
>  	u32 edx;
>  };
>  
> +int svsm_perform_msr_protocol(struct svsm_call *call);
>  int snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
>  	      void *ctx, struct cpuid_leaf *leaf);
>  
> +/*
> + * Issue a VMGEXIT to call the SVSM:
> + *   - Load the SVSM register state (RAX, RCX, RDX, R8 and R9)
> + *   - Set the CA call pending field to 1
> + *   - Issue VMGEXIT
> + *   - Save the SVSM return register state (RAX, RCX, RDX, R8 and R9)
> + *   - Perform atomic exchange of the CA call pending field
> + *
> + *   - See the "Secure VM Service Module for SEV-SNP Guests" specification for
> + *     details on the calling convention.
> + *     - The calling convention loosely follows the Microsoft X64 calling
> + *       convention by putting arguments in RCX, RDX, R8 and R9.
> + *     - RAX specifies the SVSM protocol/callid as input and the return code
> + *       as output.
> + */
> +static __always_inline void svsm_issue_call(struct svsm_call *call, u8 *pending)

Why in a header?

At least in sev-internal.h or so.

I'd prefer for this to be in a .c file, though.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

