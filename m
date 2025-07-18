Return-Path: <linux-efi+bounces-4416-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B74E6B0A003
	for <lists+linux-efi@lfdr.de>; Fri, 18 Jul 2025 11:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BD91889ACB
	for <lists+linux-efi@lfdr.de>; Fri, 18 Jul 2025 09:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B542343BE;
	Fri, 18 Jul 2025 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFFkhi1G"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095B71EEA55;
	Fri, 18 Jul 2025 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831973; cv=none; b=lCcoQXFTqW8RucZ7PrDj6LAc5MNLkvbndlYdw6vCWd5M0Ea7zuIYYBe9T07SkeP4l0Bp+ZaHCFOflLR/RgK/lhxYsAM7LLrYLOKqSGhLSLgFKE9YrD/4bUQ4v0v1WCHx0gRyIfjLEobT52gXR5Ee72EeMO8hgKK7UlvqkYc4z88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831973; c=relaxed/simple;
	bh=c3p//fUsKlqfogdnHdyGXSn34gD82Yvqx6k3I1w6ZAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsCe2bBVYnPq+VpFngZYdCF0rcPDdlk63HC+rZsod5EjpgELmBX35/yQvPL56lVHbF/t1WTbmEArIqYNdOSF7v7/YYx4YSOWcs3FFOGk4+UpoSr9crEQmT2y4MYnP+Ppg4Cao90YqtAyy+FrUvuCmj5HK7U32s6Szpi8IcQI4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFFkhi1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7822BC4CEEB;
	Fri, 18 Jul 2025 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752831972;
	bh=c3p//fUsKlqfogdnHdyGXSn34gD82Yvqx6k3I1w6ZAY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oFFkhi1GaDDDE1msb7Qiw6R5J0HWJoXjyypfYq2z6nQ4tnhlGLttHVg0gthXX4+63
	 PumYY6xck/hwhP6/FxtMbHxtYgE0CGyx4J2emr17+MOHhEOoFwRaVD2wenLcbF7t4v
	 PGHPwV/9vbuYx67yGDe3JUzmM/kQRccdnmBb72m6oEtUHVyK1Q69qESYIG9TIosvhq
	 isb1c0Dbco3hqdcp1Z39i7vKdmpFBRK4kU5z48EuPhYayAxRmvuJ3b7ejfLC6/H/de
	 u89bfdwcZ/uFv39Qy0Or56UcCDilOEpylfF2sJXYaNImy6ia/+K954Qi4BUztIDs/s
	 N9Cor5IdK0/AA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32f2947ab0cso16359181fa.2;
        Fri, 18 Jul 2025 02:46:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrfVLC6hckxalCRHuOqfJEi1LCDPlSpfWfP58cyqnoobkl0f4p4cL9RhKyxavQ7nVrfQyafu71K7c=@vger.kernel.org, AJvYcCXLes5BS2aEn6JLN7x2JUhoKPI9RlmdexMY3j+Y+d0u3gr1X3vSlDOxBqdlIyL7yiy6FQhWxfoOWwK5+w6U@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ1Y767/1ToZ8kY/JXQMCWIg9IFZniFpbESiZHz3LvfW3Gtjen
	k8RLVMYsz9/nSfcSpDVfX73zm/51n98X4lR3jUbmkM8Gb7ejkIGgXSNerC0nxvAQBdMsNPmqOgv
	bFiVmD1l9kZTt9/QF4tOQpRqRKazRgEA=
X-Google-Smtp-Source: AGHT+IHgwq+m+zfNPnTHIn6j3OU4UA7xPPWZYmjO40RVMI2F9lkEM70rP9oYjRzOBp1erLyVMniw3WIOxcZucTGDRdo=
X-Received: by 2002:a05:651c:3047:b0:32a:8aac:e450 with SMTP id
 38308e7fff4ca-3308f628ce0mr27119311fa.33.1752831970870; Fri, 18 Jul 2025
 02:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
 <20250716031814.2096113-26-ardb+git@google.com> <d750dec4-f68f-0f3d-69cd-53749044ecba@amd.com>
In-Reply-To: <d750dec4-f68f-0f3d-69cd-53749044ecba@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 18 Jul 2025 19:45:56 +1000
X-Gmail-Original-Message-ID: <CAMj1kXEeinL-2yZTVqDAz3iStpOTVrbb98Xk2p=P6V+TZ9wH9g@mail.gmail.com>
X-Gm-Features: Ac12FXysw3iFS7G_7776pUJX2vNVb7jN-fe-nDGnPGRC5P6t63Vi-8Fmq69SvdY
Message-ID: <CAMj1kXEeinL-2yZTVqDAz3iStpOTVrbb98Xk2p=P6V+TZ9wH9g@mail.gmail.com>
Subject: Re: [PATCH v5 02/22] x86/sev: Use MSR protocol for remapping SVSM
 calling area
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Jul 2025 at 03:03, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 7/15/25 22:18, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > As the preceding code comment already indicates, remapping the SVSM
> > calling area occurs long before the GHCB page is configured, and so
> > calling svsm_perform_call_protocol() is guaranteed to result in a call
> > to svsm_perform_msr_protocol().
> >
> > So just call the latter directly. This allows most of the GHCB based API
> > infrastructure to be moved out of the startup code in a subsequent
> > patch.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > ---
> >  arch/x86/boot/startup/sev-shared.c  | 11 +++++++++++
> >  arch/x86/boot/startup/sev-startup.c |  5 ++---
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> > index c401d0391537..60ab09b3149d 100644
> > --- a/arch/x86/boot/startup/sev-shared.c
> > +++ b/arch/x86/boot/startup/sev-shared.c
> > @@ -723,6 +723,17 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
> >       }
> >  }
> >
> > +static int __head svsm_call_msr_protocol(struct svsm_call *call)
> > +{
> > +     int ret;
> > +
> > +     do {
> > +             ret = svsm_perform_msr_protocol(call);
> > +     } while (ret == -EAGAIN);
> > +
> > +     return ret;
> > +}
> > +
> >  static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
> >  {
> >       struct svsm_pvalidate_call *pc;
> > diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
> > index 0b7e3b950183..c30e0eed0131 100644
> > --- a/arch/x86/boot/startup/sev-startup.c
> > +++ b/arch/x86/boot/startup/sev-startup.c
> > @@ -295,7 +295,6 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
> >  static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
> >  {
> >       struct svsm_call call = {};
> > -     int ret;
> >       u64 pa;
> >
> >       /*
> > @@ -325,8 +324,8 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
> >       call.caa = svsm_get_caa();
> >       call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
> >       call.rcx = pa;
> > -     ret = svsm_perform_call_protocol(&call);
> > -     if (ret)
> > +
> > +     if (svsm_perform_msr_protocol(&call))
>
> This should be svsm_call_msr_protocol().
>

OK will fix

