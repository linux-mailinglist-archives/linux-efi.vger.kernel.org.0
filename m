Return-Path: <linux-efi+bounces-3801-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03FBAC9183
	for <lists+linux-efi@lfdr.de>; Fri, 30 May 2025 16:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F08C3A31D4
	for <lists+linux-efi@lfdr.de>; Fri, 30 May 2025 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4DF20AF98;
	Fri, 30 May 2025 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INgpYX0m"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616E15746E;
	Fri, 30 May 2025 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748615347; cv=none; b=krJ7Yu/b79ANK2WJKs0K2gU+wsqDJkBkRvbQZd3dgcVdT6M4dAy35Dhyw9cEfVhw+tAjbMbvFGtjg4PueBl6gFNuNmR4xwadB/FWcpcOHTdCMsk3FLVV907Nb0M4E8FMnDpdp50Gczr4E5dO0nIS1XXv0TAgp3eYa9cZBKryHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748615347; c=relaxed/simple;
	bh=yHUgtt6QjNoZ2/oQT+YPFW2ct/TvQH3PYUbwT81dasY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jn6RKiVUA4LYZUw7qZXLZfKJHU4mvOCYIZjk+v65xIejb4te4k3yb7s4bNxFwzOTN5TCXvV3g9LvSaFgbyKBUGfpEFhhN22lF/Tnt54tjIVMS8PWx+s36ONx/5DrtnanYzDCyTb60V0CO1jkMmZHr2nZR1jbx7mY8NODhznYlWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INgpYX0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002CAC4CEEB;
	Fri, 30 May 2025 14:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748615346;
	bh=yHUgtt6QjNoZ2/oQT+YPFW2ct/TvQH3PYUbwT81dasY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=INgpYX0m4B9tzDtY1ZK0N8eGxmJS419QNPGpYOVMvpYZ1d17byT2AyuIuRQxzBbGw
	 FjZwxrqlHtRaggrorj5CLsFqgOdjNx/SsZ1Uk93f2rfCaz/ndolW7rLAVqXeOH+34L
	 1rPT8xMz9W+pyNdan8u8rwl+TF+R+vULt5hPV5n5KjsAkNQbcpKPK4gO2GlZzTLsbV
	 XgqnlIFimA0lhdhW50ptDACFEPeABcUteatZTMC39qqfaJUQ9k3TtA7RK9ofAgf279
	 s9gcAIBu786igM7ris+qQohNPhb3T97lXvEBFzO/AX2vssm7+8/yTlJd5lRd8nVn36
	 YFxaDLUzSCIow==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-551efd86048so2556291e87.3;
        Fri, 30 May 2025 07:29:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURHRrXvHpODd4q9OjqACCY7NUpTGB4qvnLfkeF1dcdp10QAHRoP/4lhcMQOg5NtJoqdV0U+UGyh50YXUeX@vger.kernel.org, AJvYcCXkq/SgHpJWjfoC6h5z+3AWzR+29OxdncVgM8qFB2fRHIUdab5FD7pSB/kqCsSE5CPj1odvqLCT6Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNEsPEGXsMbFluVmpFGCB9VdUPPqwdcJDCq+XvNAX0Mni8XEJj
	r8UZS20CRelXeNgTUktvfHgW7nbr+gDFno7Jen7fFn2vq9s9G6R7K+qOu95s1dZ3pwCculfZWZT
	d6E6lac0FkjvIHtnG52ntfFmtv44DiTk=
X-Google-Smtp-Source: AGHT+IFnRhV3+HTUiNUqrYjZd3G12lOC37LBzo9prk1PXkbvPDPRiegfaa21qZlLGuMaRZOAqcjahfeiLOGIMUt8854=
X-Received: by 2002:a05:6512:23a2:b0:553:3621:310a with SMTP id
 2adb3069b0e04-5533d16dbaamr768389e87.21.1748615344329; Fri, 30 May 2025
 07:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com> <20250512190834.332684-35-ardb+git@google.com>
 <20250530111645.GAaDmTneZG7KOX0ApR@fat_crate.local>
In-Reply-To: <20250530111645.GAaDmTneZG7KOX0ApR@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 30 May 2025 16:28:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEzbBTYr2vF3g_z49muSTHwRY1QUm2iOFsaLNYuijqHDg@mail.gmail.com>
X-Gm-Features: AX0GCFsHN16GrjCPQcshtyMpUhezV1a_8qejPONH3p7G-taT6t1sSUGWFP1MvPA
Message-ID: <CAMj1kXEzbBTYr2vF3g_z49muSTHwRY1QUm2iOFsaLNYuijqHDg@mail.gmail.com>
Subject: Re: [RFT PATCH v3 12/21] x86/sev: Unify SEV-SNP hypervisor feature check
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 May 2025 at 13:17, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, May 12, 2025 at 09:08:47PM +0200, Ard Biesheuvel wrote:
> > diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> > index 70ad9a0aa023..560985ef8df6 100644
> > --- a/arch/x86/boot/startup/sev-shared.c
> > +++ b/arch/x86/boot/startup/sev-shared.c
> > @@ -66,16 +66,10 @@ sev_es_terminate(unsigned int set, unsigned int reason)
> >               asm volatile("hlt\n" : : : "memory");
> >  }
> >
> > -/*
> > - * The hypervisor features are available from GHCB version 2 onward.
> > - */
> > -u64 get_hv_features(void)
> > +static u64 __head get_hv_features(void)
> >  {
> >       u64 val;
> >
> > -     if (ghcb_version < 2)
> > -             return 0;
>
> Why?
>

It is explained below ...
> > -
> >       sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
> >       VMGEXIT();
> >
> > @@ -86,6 +80,31 @@ u64 get_hv_features(void)
> >       return GHCB_MSR_HV_FT_RESP_VAL(val);
> >  }
> >
> > +u64 __head snp_check_hv_features(void)
> > +{
> > +     /*
> > +      * SNP is supported in v2 of the GHCB spec which mandates support for HV
> > +      * features.
> > +      */

... get_hv_features() is only when SEV-SNP has already been detected.

> > +     if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
> > +             u64 hv_features;
> > +
> > +             hv_features = get_hv_features();
> > +             if (!(hv_features & GHCB_HV_FT_SNP))
> > +                     sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> > +
> > +             /*
> > +              * Running at VMPL0 is required unless an SVSM is present and
> > +              * the hypervisor supports the required SVSM GHCB events.
> > +              */
> > +             if (snp_vmpl > 0 && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))
> > +                     sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
> > +
> > +             return hv_features;
> > +     }
> > +     return 0;
> > +}
> > +
> >  int svsm_perform_msr_protocol(struct svsm_call *call)
> >  {
> >       u8 pending = 0;
> > diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
> > index 753cd2094080..0ae04e333f51 100644
> > --- a/arch/x86/boot/startup/sme.c
> > +++ b/arch/x86/boot/startup/sme.c
> > @@ -533,6 +533,8 @@ void __head sme_enable(struct boot_params *bp)
> >       if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
> >               snp_abort();
> >
> > +     sev_hv_features = snp_check_hv_features();
>
> Is this writing the sev_hv_features declared in
>
> arch/x86/boot/startup/sev-startup.c
>
> ?
>
> arch/x86/boot/startup/sev-startup.c:45:u64 sev_hv_features __ro_after_init;
> arch/x86/boot/startup/sme.c:536:        sev_hv_features = snp_check_hv_features();
> arch/x86/coco/sev/core.c:980:   if (!(sev_hv_features & GHCB_HV_FT_SNP_AP_CREATION))
> arch/x86/include/asm/sev-internal.h:5:extern u64 sev_hv_features;
> arch/x86/include/asm/sev.h:428:extern u64 sev_hv_features;
>
> I'm confused.
>
> If sev_hv_features is startup code, why isn't it accessed this way...?
>
> /me goes and looks forward in the set...
>
> oh my, that is coming.
>
> > +
> >       /* Check if memory encryption is enabled */
> >       if (feature_mask == AMD_SME_BIT) {
> >               if (!(bp->hdr.xloadflags & XLF_MEM_ENCRYPTION))
> > diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> > index fa7fdd11a45b..fc4f6f188d42 100644
> > --- a/arch/x86/coco/sev/core.c
> > +++ b/arch/x86/coco/sev/core.c
> > @@ -1264,17 +1264,6 @@ void __init sev_es_init_vc_handling(void)
> >       if (!sev_es_check_cpu_features())
> >               panic("SEV-ES CPU Features missing");
> >
> > -     /*
> > -      * SNP is supported in v2 of the GHCB spec which mandates support for HV
> > -      * features.
> > -      */
> > -     if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> > -             sev_hv_features = get_hv_features();
> > -
> > -             if (!(sev_hv_features & GHCB_HV_FT_SNP))
> > -                     sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> > -     }
>
> I guess we would've terminated earlier anyway so that's probably ok...
>
> > -
> >       /* Initialize per-cpu GHCB pages */
> >       for_each_possible_cpu(cpu) {
> >               alloc_runtime_data(cpu);
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

