Return-Path: <linux-efi+bounces-4622-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8295CB39435
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 08:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5BB23A6B79
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 06:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AC921FF21;
	Thu, 28 Aug 2025 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvsWMphp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ADE1E0E08;
	Thu, 28 Aug 2025 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363828; cv=none; b=g3+CbO97oLOklUTY0MLQmdeVPPRc+0ArFa4FlY7Nf2sjikrQkhTnII3Xx8ui7hhBOyWrGDiwdo2Xrskb7LiEq9Z+EutRUoutk959tkuxpvnJyAk5JcM+YBeYbnmWLV0trYj5ZJeLpNAgn9Vm1fyW9UYBx557yrpjRJbYhvv+PRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363828; c=relaxed/simple;
	bh=vd7ioM8/GW48jxGdJa25KQEQm1jXUpsZVuZaq5tK8j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2W1fFUz/OqQx1EIt3AGYVQpjET8Sp+xneHt9a/z/I8AFoTOvd9HgtuBBLi6TqGE4/m2vHApXsCFapFrliNnRWtCGftFx0CqYfUVgwGajf+fXl29wYIT1Kc8PGWC5LrbTKzMx5hEaArNaoksOJw+yFvI2yrrJd9F49UcwiwYxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvsWMphp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AA4C4CEEB;
	Thu, 28 Aug 2025 06:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756363828;
	bh=vd7ioM8/GW48jxGdJa25KQEQm1jXUpsZVuZaq5tK8j8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tvsWMphp5sUXSkG12CLxguPckTSnGaG6xI7rQEf6Fi98b9vtDLMqbpPyuLUw/1fg3
	 DEs1n23DzpJGnhTUnHIjtbCGNkd0wsrJ2YJnvJrzuyd3m1tdyO8qMSU8qfzA9AuGpT
	 X10lInrdakrp6H4MN241CrffXulCx/dVpdpVE2ScyLElqKXAuo6+TnPPOOYBNn2flt
	 ALaGSl0UHJDCxY4H62lRwvfxlNvcBHWEOA9/4oceRloNAofO1MYeMy9+UkdlHkDDJM
	 Ne/OXgxLiLTKguLNHQDqOxgDvkFgrMlwKauGVgSW2SMuyGcTtwNOibUCOpxOdYSKVd
	 +6xVo+Yc/DZFA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f4cf36c00so629982e87.1;
        Wed, 27 Aug 2025 23:50:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTR9KYDwdZkXbRkpDa5vgCTc+O/8/qrwHBXtuBlX11gyIQoQhJUXqNJJnjDx4yWU3ao75zJqxHO+8fo0eN@vger.kernel.org, AJvYcCWFBEqHuPirBuoPk+q5hiDy3ZCJ1XTgXeH4gCYowPhsG9CENw3T+oG2VKM/8ci9G/Rszt3mvnKy8VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRf732QHOcuUz5zeBFhK1nwszHKKQYUylchl8yFHIyw4JAgf5o
	iDi5SJwqhKS2hc3QhFaIq2u2GYJYCgJ99v5hwiHUc0l/PzXwLAEddL4e1Lb9mywVBZAMLCszgFb
	VpEfUkZORk45uHmbPToFBPDdY/1kfzjY=
X-Google-Smtp-Source: AGHT+IGe+s6hVyR6gdEaJkCRYuYgYp0177C3B/pikO5kKxuTc2KdIrm/SUUSLRqe4D4DUSxIUvjz6OqnLn9hNkKad68=
X-Received: by 2002:a05:6512:6090:b0:55f:54fe:3401 with SMTP id
 2adb3069b0e04-55f54fe361amr1632925e87.24.1756363826676; Wed, 27 Aug 2025
 23:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
 <20250722072708.2079165-45-ardb+git@google.com> <20250811174034.GRaJorEmcBfLTDhWml@fat_crate.local>
 <c9bb1b3f-17ce-254f-5d0f-ae3563b03b50@amd.com> <20250811190306.GAaJo-ai4M2aVod6_V@fat_crate.local>
 <38f6fa08-41fb-4717-9763-39ec5fa54075@amd.com>
In-Reply-To: <38f6fa08-41fb-4717-9763-39ec5fa54075@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 28 Aug 2025 08:50:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGY7-ZmQbUnw-KtMq6HG-o9xUNmb7KMHAzdBBbWBmGo=g@mail.gmail.com>
X-Gm-Features: Ac12FXyf1cR7C5PPk0mmrhnkwwaURPgHXYpwTkx5Q3hcxSfvqBkXNDy8Zu0Yqco
Message-ID: <CAMj1kXGY7-ZmQbUnw-KtMq6HG-o9xUNmb7KMHAzdBBbWBmGo=g@mail.gmail.com>
Subject: Re: [PATCH v6 21/22] x86/boot: Move startup code out of __head section
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nikunj A Dadhania <nikunj@amd.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 19:17, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 8/11/25 14:03, Borislav Petkov wrote:
> > On Mon, Aug 11, 2025 at 01:05:42PM -0500, Tom Lendacky wrote:
> >> Yes, that works. Or just get rid of snp_abort() and call
> >> sev_es_terminate() directly. Secure AVIC could even use an
> >> SEV_TERM_SET_LINUX specific code instead of the generic failure code.
> >
> > I *love* deleting code. Here's something to start the debate:
> >
> > ---
> > diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
> > index 7a8128dc076e..19b23e6d2dbe 100644
> > --- a/arch/x86/boot/startup/sev-startup.c
> > +++ b/arch/x86/boot/startup/sev-startup.c
> > @@ -135,7 +135,7 @@ static struct cc_blob_sev_info *__init find_cc_blob(struct boot_params *bp)
> >
> >  found_cc_info:
> >       if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
> > -             snp_abort();
> > +             sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> >
> >       return cc_info;
> >  }
> > @@ -209,8 +209,3 @@ bool __init snp_init(struct boot_params *bp)
> >
> >       return true;
> >  }
> > -
> > -void __init __noreturn snp_abort(void)
> > -{
> > -     sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> > -}
> > diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
> > index 39e7e9d18974..e389b39fa2a9 100644
> > --- a/arch/x86/boot/startup/sme.c
> > +++ b/arch/x86/boot/startup/sme.c
> > @@ -531,7 +531,7 @@ void __init sme_enable(struct boot_params *bp)
> >        * enablement abort the guest.
> >        */
> >       if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
> > -             snp_abort();
> > +             sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> >
> >       /* Check if memory encryption is enabled */
> >       if (feature_mask == AMD_SME_BIT) {
> > diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> > index 0020d77a0800..01a6e4dbe423 100644
> > --- a/arch/x86/include/asm/sev-common.h
> > +++ b/arch/x86/include/asm/sev-common.h
> > @@ -208,6 +208,7 @@ struct snp_psc_desc {
> >  #define GHCB_TERM_SVSM_CAA           9       /* SVSM is present but CAA is not page aligned */
> >  #define GHCB_TERM_SECURE_TSC         10      /* Secure TSC initialization failed */
> >  #define GHCB_TERM_SVSM_CA_REMAP_FAIL 11      /* SVSM is present but CA could not be remapped */
> > +#define GHCB_TERM_SAVIC_FAIL         12      /* Secure AVIC-specific failure */
>
> We can get specific if desired, e.g., GHCB_TERM_SAVIC_NO_X2APIC
>

I'll fold this in for the next revision, and we can take it from there.

