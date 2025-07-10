Return-Path: <linux-efi+bounces-4267-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F986AFF802
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 06:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFBA3B23F6
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 04:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA24A236A73;
	Thu, 10 Jul 2025 04:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xz1vHyUC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD32F3E;
	Thu, 10 Jul 2025 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121507; cv=none; b=NBrfL5uhiH6sFC+orWOHWpr2XBAjrJqit99UzdzynKnSwEsIjm9fVCp0/5MhuI2//A/zuJHeb6ynhDsitMud3rYIAjhrBzv3W/iMYoitl50eGGz2AYxJQvdy9Hhd+MDOPFKQuVIGIOmqVVqf0vPjNM8I/PZuw2X+mYOeNNyrCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121507; c=relaxed/simple;
	bh=CntOVjlW9v8B8fEoo8i3Fqm6VVhNMT9fs2ducdiMuQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0IZyiTHoahTNpcBt83WqIAQi9VNaR/pm3DTH5lvqGm5u6k3xLUDaXpy+HdVbmwIZoFNvCZpWwx5IL6Y11YWQNfnq1iBjFl4H3qxSB0l3oAt4yOnlrhYl83zEkr3SBzPVxFmxvQuEGsV1AXqD1BnNt39l1NK0EjRhMDa1QIySmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xz1vHyUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27730C4CEF7;
	Thu, 10 Jul 2025 04:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752121506;
	bh=CntOVjlW9v8B8fEoo8i3Fqm6VVhNMT9fs2ducdiMuQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xz1vHyUCNn/0SieOIUwLB7a8WapNZHbCxYd1gW2vAmBMd813mrKWQ00EzP0O5IW1K
	 e8fkW+DyvSDR0Pg/Wy4mBsiVWC0hkEfvNWq5Y+s9FdXXjYcUcxC42a5DaBwG+XvZpT
	 b0l59l7RgGM1Lno5uUr4Z7KyL5uY69qQbdfbxKM6JwGeFnuyZHznp0DKWN3Lc11xvc
	 AKdGra1B9VDfvqwjgUXbzT4/Vrj9ooSu/6FxSy7RgMF/a0PUXFBki/UA4t1g6Dn1n+
	 e0HRF1NkFhTCYo+lQBMGuGtyNjgj1mrWa5l+LGAfIvqzekAcUz4d1b+kHhrMCMQbk9
	 anC56B/iKkUdA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-558fa0b2c99so397110e87.2;
        Wed, 09 Jul 2025 21:25:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPqeUkRKg6sfE6RJ4ZpLFRvDzQL1xaVwWZbvflUJqAd6rF4B80PFRQRCgTGdL4zKo3s/UW1zvUgDY=@vger.kernel.org, AJvYcCWb9T0f1XZoDSGzzOg/pAr3ZBqtjMUAJYin63zUCcfV9+SpxafCrzW+cK/Px+pPfSxUpzsiKU+yZC/R5hsm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/U7L3TA7E4KEtfPGghU9q2uyQcL9LWXN+6Rd5W7vjyz/FeN8V
	slzXCy/0q3VKuPk2mzbinIXJUcAD86bL9spKHvnFMKX16eZwyb9WQCqmgAQP7odBXAneUI+yFWB
	nXaRXfs0C9UtUrrZA4ndbUtLGV190Olw=
X-Google-Smtp-Source: AGHT+IHaJ1Y8zDXj4f4aU04sif+sn4n2t330nTUZc6tahQWhLLD+koqBT35wpIYphk84FoW0m8F4Yes3QGXjuVJmADY=
X-Received: by 2002:a05:6512:ac4:b0:553:acbf:e003 with SMTP id
 2adb3069b0e04-558fa897064mr1738892e87.13.1752121504496; Wed, 09 Jul 2025
 21:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
 <20250709080840.2233208-38-ardb+git@google.com> <85qzyovfov.fsf@amd.com>
In-Reply-To: <85qzyovfov.fsf@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 10 Jul 2025 14:24:53 +1000
X-Gmail-Original-Message-ID: <CAMj1kXF73myE9sKos5j9ErZi14ExDQBDZvp8PEhG3K4PELQrSw@mail.gmail.com>
X-Gm-Features: Ac12FXwo4qDeU6iuCorBS-OhUFdACYFeQAj9Tpwb2Q_te5kVIXLs6RmU7-aBFik
Message-ID: <CAMj1kXF73myE9sKos5j9ErZi14ExDQBDZvp8PEhG3K4PELQrSw@mail.gmail.com>
Subject: Re: [PATCH v4 12/24] x86/sev: Unify SEV-SNP hypervisor feature check
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Jul 2025 at 14:21, Nikunj A Dadhania <nikunj@amd.com> wrote:
>
> Ard Biesheuvel <ardb+git@google.com> writes:
>
> > From: Ard Biesheuvel <ardb@kernel.org>
>
> ...
>
> > So move the HV feature check into a helper function and call that
> > instead. For the core kernel, move the check to an earlier boot stage,
> > right after the point where it is established that the guest is
> > executing in SEV-SNP mode.
>
> This change is causing the SNP guest to fail ...
>
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
>
> >  arch/x86/boot/startup/sme.c         |  2 ++
> >  arch/x86/coco/sev/core.c            | 11 -------
>
> > diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
> > index 70ea1748c0a7..529090e20d2a 100644
> > --- a/arch/x86/boot/startup/sme.c
> > +++ b/arch/x86/boot/startup/sme.c
> > @@ -533,6 +533,8 @@ void __head sme_enable(struct boot_params *bp)
> >       if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
> >               snp_abort();
> >
> > +     sev_hv_features = snp_check _hv_features();
> > +
>
> ...
> snp_check_hv_features()
>  -> get_hv_features() fails as ghcb_version is not yet initalized
>
> ghcb_version is initialized as part of sev_es_negotiate_protocol(),
> atleast this function needs to be called before get_hv_features() is
> called.
>

Thanks for the diagnosis.

I added back the ghcb_version check, even though it is redundant,
given that SNP support implies ghcb version >= 2

Would the below change be sufficient too?

--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -49,9 +49,6 @@ static u64 __init get_hv_features(void)
 {
        u64 val;

-       if (ghcb_version < 2)
-               return 0;
-
        sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
        VMGEXIT();

