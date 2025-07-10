Return-Path: <linux-efi+bounces-4271-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 434CFAFFB0B
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 09:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C2F1C431D6
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 07:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB95289344;
	Thu, 10 Jul 2025 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs0vwaX+"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC623E34D;
	Thu, 10 Jul 2025 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133008; cv=none; b=h9osqbRUnYl46Y6HRLqSKAsEjNzx7c8BxI5xb2+9P62JuKCaOMbSIPMu+YKNc6E491N3tUPGwJtERyGXZvadbElbgdespEL0ziy3zIh6nWU1OlNI0NhG+eIEwJqRTfJW4kegEOk3cC6qBSvBhRhmP6yxp1Um3BkmGY09fJ++E5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133008; c=relaxed/simple;
	bh=RF1x5/owSgmOCJxvymPU0CBUm8h4dhDswHjybXlbWDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HA7+KIsejh67n0ntXdoW2oq11HOBMwCEvbuS/rafmXITWiKG9FbvIkC39WqqCDV1+TsP1kbKEIwqvDnQ/mKJtlJViD+lamuYGcIb6HFrspVJK3hKvdrMA1fitcwrnS/VDbV8Xsu15+tekcz+RSGPkrNBlO8wyBHGjLCLwOmf0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs0vwaX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084F0C4CEE3;
	Thu, 10 Jul 2025 07:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752133008;
	bh=RF1x5/owSgmOCJxvymPU0CBUm8h4dhDswHjybXlbWDA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bs0vwaX+BCBCyPXraB14F7mBIiDBh4mhGBPhp59qOHj9EdPJMbgyTsogipHgtMO1k
	 W3XUiXIjiAdOvlWg0dWhu8n22jF6Sw9GQaAywCSwPzCRIrIdJqRee0fM5frpTQ1jUu
	 pgDKI4GPDTVpkbSCDb0TKhElrBqAYheu32vdO82N/PhNIpoFsy3//v7D7/JRuT7WJ2
	 E8C5XACCtY17hdKOf1xF9pGzIaHBOrOd3cTKrNKsq8fe7sqGFq36ClaQQi0ie4Kuh+
	 j5m/xTPoUplMnT/HZ43yKdrXlhoWevGKUy/jjipo8PAgb5HB/Ke9vx5Px85zm4dtVD
	 BN2x1T8L5i54A==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54d98aa5981so891146e87.0;
        Thu, 10 Jul 2025 00:36:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhHaZLpCrxlbVbi5cb3IxBaLEf9MSh08qEhf3/sdfcG5Y8ZBFXff/NJMwVPi7pIBOSYdN1FBCSEu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoD61jw0ki3IW3oPsm0HxfRyEbzA7Lc770Jv85NN+ghFSQb7Mp
	eUv5s0b75UL+tB9nNoygJA5+uUjynL2zMkUkT2Kgj7m+kcy4VEb9QjliOJMVji/YBD9tK4ehqWY
	bHWqfSnvjkV/5RdjPdblpozhzruvTbcw=
X-Google-Smtp-Source: AGHT+IFLHwy2Bade+36c8nH9tNsAsCkF1R5BLwLqjIUip2XsheHUIQoV5nrl9b+gl/URo/SZsR6MilnqWKnMpZI3fK8=
X-Received: by 2002:a05:6512:3b96:b0:553:cdd7:368b with SMTP id
 2adb3069b0e04-55935b34e0dmr597330e87.43.1752133006444; Thu, 10 Jul 2025
 00:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
 <20250709080840.2233208-38-ardb+git@google.com> <85qzyovfov.fsf@amd.com>
 <CAMj1kXF73myE9sKos5j9ErZi14ExDQBDZvp8PEhG3K4PELQrSw@mail.gmail.com> <85o6tsv8m2.fsf@amd.com>
In-Reply-To: <85o6tsv8m2.fsf@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 10 Jul 2025 17:36:33 +1000
X-Gmail-Original-Message-ID: <CAMj1kXHZhFQ0DQWGDXtX4+-RWUFgyfL1qJh4hCONdi29NeBzhQ@mail.gmail.com>
X-Gm-Features: Ac12FXzf2WEwzpKobjG_NxajN4OUqTnYX4Std_aOl_mIrO7S0mFHoDU-B9CUQXI
Message-ID: <CAMj1kXHZhFQ0DQWGDXtX4+-RWUFgyfL1qJh4hCONdi29NeBzhQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/24] x86/sev: Unify SEV-SNP hypervisor feature check
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, 
	X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

(please keep the CCs)

On Thu, 10 Jul 2025 at 16:54, Nikunj A Dadhania <nikunj@amd.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > On Thu, 10 Jul 2025 at 14:21, Nikunj A Dadhania <nikunj@amd.com> wrote:
> >>
> >> Ard Biesheuvel <ardb+git@google.com> writes:
> >>
> >> > From: Ard Biesheuvel <ardb@kernel.org>
> >>
> >> ...
> >>
> >> > So move the HV feature check into a helper function and call that
> >> > instead. For the core kernel, move the check to an earlier boot stage,
> >> > right after the point where it is established that the guest is
> >> > executing in SEV-SNP mode.
> >>
> >> This change is causing the SNP guest to fail ...
> >>
> >> >
> >> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >> > ---
> >>
> >> >  arch/x86/boot/startup/sme.c         |  2 ++
> >> >  arch/x86/coco/sev/core.c            | 11 -------
> >>
> >> > diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
> >> > index 70ea1748c0a7..529090e20d2a 100644
> >> > --- a/arch/x86/boot/startup/sme.c
> >> > +++ b/arch/x86/boot/startup/sme.c
> >> > @@ -533,6 +533,8 @@ void __head sme_enable(struct boot_params *bp)
> >> >       if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
> >> >               snp_abort();
> >> >
> >> > +     sev_hv_features = snp_check _hv_features();
> >> > +
> >>
> >> ...
> >> snp_check_hv_features()
> >>  -> get_hv_features() fails as ghcb_version is not yet initalized
> >>
> >> ghcb_version is initialized as part of sev_es_negotiate_protocol(),
> >> atleast this function needs to be called before get_hv_features() is
> >> called.
> >>
> >
> > Thanks for the diagnosis.
> >
> > I added back the ghcb_version check,
>
> Not sure if I understand, this check is there since:
>
> cbd3d4f7c4e5 x86/sev: Check SEV-SNP features support
>
> > even though it is redundant,
> > given that SNP support implies ghcb version >= 2
> >
> > Would the below change be sufficient too?
>
> KVM_SEV_INIT2 allows the user space to provide ghcb_version, setting
> ghcb_version=1 in QEMU;
>
> with my changes: SNP guest does not boot, as the ghcb_version < 2
> with the below change: SNP guest boots, which is not correct
>
> This needs to be fixed in KVM as well to not allow creating SNP guest if
> ghcb_version < 2.
>

OK, thanks for clariyfing this - it means that checking the GHCB
version remains necessary, even though it is only done for SNP guests,
where GHCB version >=2 is mandated.

I'll take this into account in the next revision.

