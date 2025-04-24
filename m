Return-Path: <linux-efi+bounces-3446-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1C4A9A3EE
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 09:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454661B6236B
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 07:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF3C2046BA;
	Thu, 24 Apr 2025 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwzAr54S"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BDD204680;
	Thu, 24 Apr 2025 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479370; cv=none; b=W4LLFa/1J014BOv59ou7qBjSlkFq9rgxy1xNNDUHP2x4QEXZ8rAL9ytOWWw3QdesIDH3ImMmqm+ymJ6TrFvS/WCNZT30W3GchIO3xOby5Sxk4rCK27Q8WO3HaWKTle3MUBgbjS8PX5I93gTO33PLoOwGPJhIWjCdud40KCn5oB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479370; c=relaxed/simple;
	bh=OPTobuaqLm9m+8ywpsnq/+K9zTYPUVY8MzQ3jL9U66A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzVLYlr0zN+DncLdj5PnVM4gcBiVZ5qw0MI5qcGscwPyeW4bpbHi69V7idi1ZFbLeNeOReAxU4hsw5ij76WSeQNJaGJSccbltFBweBabfxWqapNBbIHQCe2LcFflBt9Wsegc5TuewHQldEgn1wAA7IDN46PTFryxDDhduyKPE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwzAr54S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82B4C4CEEE;
	Thu, 24 Apr 2025 07:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745479369;
	bh=OPTobuaqLm9m+8ywpsnq/+K9zTYPUVY8MzQ3jL9U66A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KwzAr54Sz6yHxN6A2bYhtyTnAnFAzheib0pwuUP+q8nN+mlZT6NgYkaUnyifuZQTU
	 6tjgt2EpO0yFZr7wfGGA3WDW1z3unyPfsgZceeU/xMAGZOTJpA15IGeGFTREe1fsdq
	 EcyNVAK21yQY7sJLU9Dc7LVDkU5m9T1Wg6B2AwV3DeUSODPOANUmLfHeN73aTw7hvC
	 GCgERaAxF+lX6LJXorTXOKvgbpu+/6WacVa2e4kHQW73jl24IJz5xkBrU/GV/f3jG4
	 NH/2vf1yMTatMiDcBHKwYGZngVCj2yvF3mSg5OKv0ZakZjPIWwGjwFOQepxd5X9SDH
	 OdLIgafpJDh2Q==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54d6f933152so828515e87.1;
        Thu, 24 Apr 2025 00:22:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWC5+dQtYT0OJb3+Kcvlk2bVlxpn/0Sm00uooJxW2tqy9ao7v380XOKlkEBYeoCQAiAEevN/MJQnSvZO87t@vger.kernel.org, AJvYcCX4Pbp5RgNtu5iLgo9AYLXk7JtZs0BBUCBlje+ZkylKj+hqLuikpl7Zp0F4xkORyYt/s46FGAeMGb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7R5DowEA2v+SB5B28uZGlJE5zWysr9tme3Z0nyRxvV4z1uhFw
	D7BWUu8aMzQFBEX7sFYDBUynrVhKsZ00fFGBdriP/SUJHqIJOXogP+UM3wQ7aMx0ZH+a2sntmdP
	EEQWdoGED9TE0KMvx/gw8LCD2FDc=
X-Google-Smtp-Source: AGHT+IFpG7BWA2Kl4PlwTgVD9XK4iB/bYChVb4dDvfVKSuglev37r0yrmLT+/aFio8TXZtaGpb4xkVgNZPdvjJCeZZ8=
X-Received: by 2002:a05:6512:3b82:b0:549:8cbb:5441 with SMTP id
 2adb3069b0e04-54e7c41ee2emr498565e87.15.1745479368301; Thu, 24 Apr 2025
 00:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422100728.208479-7-ardb+git@google.com> <d00c9119-5e8b-2615-8e4b-2d25732ff71a@amd.com>
 <CAGnOC3b2XBFw+xdMhTtpfDYG480BG-KwfkPMWOiOP+13XeHFfg@mail.gmail.com>
In-Reply-To: <CAGnOC3b2XBFw+xdMhTtpfDYG480BG-KwfkPMWOiOP+13XeHFfg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 24 Apr 2025 09:22:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFCqLnWDw7hJVL9FShF9V=YZ_Ucf6jSSeq0E=BeuENdkQ@mail.gmail.com>
X-Gm-Features: ATxdqUH330U3kB7vp5aCRlzFskEPcmfdDqLAZ3bcCcFe7TK1O0Cz7BOL-n7PSWk
Message-ID: <CAMj1kXFCqLnWDw7hJVL9FShF9V=YZ_Ucf6jSSeq0E=BeuENdkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] efi: Don't initalize SEV-SNP from the EFI stub
To: Ard Biesheuvel <ardb@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	mingo@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Apr 2025 at 18:40, Ard Biesheuvel <ardb@google.com> wrote:
>
> On Tue, Apr 22, 2025 at 5:51=E2=80=AFPM Tom Lendacky <thomas.lendacky@amd=
.com> wrote:
> >
> > On 4/22/25 05:07, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> >
> > Hi Ard,
> >
> > I'll try to get to reviewing and testing this series very soon.
>
> Thanks.
>
> > But one
> > thing I can see is that we never set the snp_vmpl level anymore in the
> > EFI stub and so PVALIDATE will fail when running under an SVSM.
> >
> > But I don't think this series is completely at fault. This goes back to
> > fixing memory acceptance before sev_enable() was called and I missed th=
e
> > SVSM situation. So I don't think we can completely remove all SNP
> > initialization and might have to do svsm_setup_ca() which has a pre-req
> > on setup_cpuid_table()...  sigh.
> >

Why is that, though? The EFI stub never replaces the #VC and #PF
handlers, and so cpuid instructions will be handled as before, right?
And the SVSM setup code will run again when the core kernel boots and
this time, it will need to update the cpuid tables to record the SVSM
presence.

