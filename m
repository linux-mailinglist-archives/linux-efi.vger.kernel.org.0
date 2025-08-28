Return-Path: <linux-efi+bounces-4650-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2BCB3A5DD
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 18:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 326EB4E4556
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C656E2F0C62;
	Thu, 28 Aug 2025 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2uvxWho"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251C2EDD6B;
	Thu, 28 Aug 2025 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397683; cv=none; b=gCjiTrNqDunYH5Y1O6bs8ti+ymHIiPEB6rfy19YiKaC45ZiXiBMQZoQr0p6nKaqC61TjJReRjTzNC0TfhYL6VPuYZshW2tSPam62gbykb1/6kM0FeI82CMY6KtQMcDzezn3ALdmY1p0BE6ZMTKbDBDZ0WyGAVespbxCMyinanKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397683; c=relaxed/simple;
	bh=0mWAt9V6mXzDVb76YBkp9s6T7YlQCMYmSXf3GXrqJbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gp3yIfwSJecf+WnpYwRHx5i/B1ovPj359HSY4YNDE0ywf4v7ruS5+RUXnCokHXLajg3cyGL96piR8a7YhHm3wSn3262mIeyB8Mp4KsuOtf/07wiXwEAQ/Gq5qRwjya5UvOGrnbPusWNA6XM1wxcmu1qGkJysLPF/Aow6wtAJFM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2uvxWho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22941C4CEEB;
	Thu, 28 Aug 2025 16:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756397683;
	bh=0mWAt9V6mXzDVb76YBkp9s6T7YlQCMYmSXf3GXrqJbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A2uvxWhoM/zuM2lRnzkT8S/A/a14ldw2ziBz4wZraMso8vGj6wggJ9v6vH6DsBH2Y
	 b3fhWWkZjiU3nWfw6OY1czRqq+7PiUSbgBQ2T9Ks9HaOwi5WGBAJZ+zIALeCs9yasb
	 PBp6vqRa1mq+aJcRIy3ro60lGlYlH1/GKJ//RjgSpE5dUso/zu8+hbc8wdQ0jNlxey
	 wF+prCs2tI6dzScMZxTvaFQsEE/ZuLFG3p2o8JowQCfNV527s7le0mCN8gZ0JP0WBa
	 qwCEEYJbOR3PNOeZjy4ln80FeuRv8qjeoEOlk+pDK7z1r6yjB8WSpb+3KsT4R+RfOM
	 /wed8/NKuiumQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-33667661214so9308871fa.2;
        Thu, 28 Aug 2025 09:14:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNb12wjxtgbq6ihEsR1WwNEdTzfgXyKA43G2BRtKunvmh4WQIZDAyhW4zdtwsEbt5x3wnk5PLtmCoTHbWg@vger.kernel.org, AJvYcCXIMxWNG142zid39PAzYZxR3wnK8MQBVLcoizrH6XwGMztouVnbQaTBypEgKgFQUhPqMMch9WxkpPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylArEcvEN5nuf8FMRgkSPgDRnEwsdsacTbjGOjHCbuLBdLesTX
	ju7WB0CHndBuN0D0MS7JVKNHvGPjnp9vmfDYH5O32DTLsd9gZl0ec7yEAJkB7AogUPkFzCSoXxW
	fmG8XmldabugQ0QEA/+mT5/bpGku4mSw=
X-Google-Smtp-Source: AGHT+IG1WYeagqTMnqb5sScxobXQ++ZQzyOW31/FcuuZBydDuBwB6gyyreygguVxecm5t/O9yoNhokOnymRZ2RRmejk=
X-Received: by 2002:a05:651c:544:b0:336:9232:fb91 with SMTP id
 38308e7fff4ca-33692334925mr17627921fa.4.1756397681507; Thu, 28 Aug 2025
 09:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-25-ardb+git@google.com> <20250828153317.GJaLB2vSvuR20WzgQV@fat_crate.local>
In-Reply-To: <20250828153317.GJaLB2vSvuR20WzgQV@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 28 Aug 2025 18:14:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFa5j2AoUWNvOmfBrQxg_hjwwPrCZSKickNwYjZ8RxkVA@mail.gmail.com>
X-Gm-Features: Ac12FXxogj-fTnbMOOotGI37m-7Cxa4h31KLVwgtA58M4JKiXlQMA8t8aRuGwKg
Message-ID: <CAMj1kXFa5j2AoUWNvOmfBrQxg_hjwwPrCZSKickNwYjZ8RxkVA@mail.gmail.com>
Subject: Re: [PATCH v7 01/22] x86/sev: Separate MSR and GHCB based snp_cpuid()
 via a callback
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 17:33, Borislav Petkov <bp@alien8.de> wrote:
>
> + Joerg and Mike to doublecheck me.
>
> On Thu, Aug 28, 2025 at 12:22:04PM +0200, Ard Biesheuvel wrote:
> > @@ -648,7 +611,7 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
> >       leaf.fn = fn;
> >       leaf.subfn = subfn;
> >
> > -     ret = snp_cpuid(NULL, NULL, &leaf);
> > +     ret = snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
> >       if (!ret)
> >               goto cpuid_done;
> >
>
> So this code becomes now:
>
> ---
>         ret = snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
>         if (!ret)
>                 goto cpuid_done;
>
> <--- tries to find the CPUID leaf in the CPUID table
> <--- otherwise uses the MSR protocol to read CPUID from HV and massage it
>
>         if (ret != -EOPNOTSUPP)
>                 goto fail;
>
>         if (__sev_cpuid_hv_msr(&leaf))
>                 goto fail;
>
> <--- and now it tries to do the same - do CPUID over MSR protocol.
>
> This flow made sense before your change because it'll try to use the GHCB
> protocol but you're zapping that now so, IOW, you can zap that second call
> too:
>
>
> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> index ed88dfe7605e..fbfdfe0dce70 100644
> --- a/arch/x86/boot/startup/sev-shared.c
> +++ b/arch/x86/boot/startup/sev-shared.c
> @@ -612,16 +612,9 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>         leaf.subfn = subfn;
>
>         ret = snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
> -       if (!ret)
> -               goto cpuid_done;
> -
> -       if (ret != -EOPNOTSUPP)
> -               goto fail;
> -
> -       if (__sev_cpuid_hv_msr(&leaf))
> +       if (ret && ret != -EOPNOTSUPP)
>                 goto fail;
>
> -cpuid_done:
>         regs->ax = leaf.eax;
>         regs->bx = leaf.ebx;
>         regs->cx = leaf.ecx;
>

This seems plausible but I'm not sure I understand 100% why this
fallback logic was introduced in the first place, so I'll defer to the
experts here.

