Return-Path: <linux-efi+bounces-5122-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C592C056C3
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 11:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5FB5348C81
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE4C30BB97;
	Fri, 24 Oct 2025 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmfdGp0v"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D630B51B
	for <linux-efi@vger.kernel.org>; Fri, 24 Oct 2025 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299368; cv=none; b=nTeKWDH9rCVmkU9A/FxeoY7q1ta/R+c+d6mll/mrDaaGk8Z5JUn+Y9T4v5cc3ifp7uAdmZRKJRfu3Zr+/Uql3N0u6q/WtYfwpjPVnuI3Fd1TsN7cldSbJuqE9+J41X07cuOwnJAyvMZ5vRKNtBC6CTh3qLjDq8fCDnwWqWc+1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299368; c=relaxed/simple;
	bh=+rEgbmUg/T/QmQbXAyRzjpFQS6FK3emL01RgLGpF4yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXVM6nmEbbvQG4WJFTBQxzREiJ9LW1ARCA+1lFEcZiQCMa3K7DhCrw1g5i67uzXj5B618kYzEk48GD2j8BFNTrmCJDEdAqmb4DZUlTLjinoST9QJuEx+gQ21c7Kxk2xZoOnN/WX9gb/rPauvBzAB/qu+L6xvwAANz4JkvKfxemI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmfdGp0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0FAC19423
	for <linux-efi@vger.kernel.org>; Fri, 24 Oct 2025 09:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761299367;
	bh=+rEgbmUg/T/QmQbXAyRzjpFQS6FK3emL01RgLGpF4yk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OmfdGp0vNDyyWrNqh8CtsTUNPmZLqV6R707YIIfKgGhPnZpWEKpextUGVrTueOP9o
	 0dsQoAHP1u0qmDvoxSr6GYJxhvZY77E6bkpKcX5Aa0mN2a48N6E1fTvulvkjBJj6GD
	 LpMmFl5r462BaXgcHmIa6/r0affuIuU0zfmdNsrWOFt+Z+82revkTYRbleGx5+cIGR
	 yx1tkMgmBLQVb9BHky+yWmWhXRk6B1d2v+hbPDGqb9x+vYTMbBHDOBkl3vXAIyslXB
	 E1QgcqkFkiFqAziJco7CxLJQ/MoL8jrCoI8creFMlo4yoBIkbXO3mOn/Re78+x6VlC
	 445zPB50o3MCw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-592ee9a16adso3044017e87.0
        for <linux-efi@vger.kernel.org>; Fri, 24 Oct 2025 02:49:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4YQG1P2LZ/V2bKDUMKxAsO8JaFibWJ/G0mmJ2OlH0qA6f3TInPZ5qnARm53lSPNmmnTHWBmvlRLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2qqYPth/H3Jy6QdQTgSVxbPPdczrTcUC+Qr+7sLXl4/IVVq6h
	vB/LxwPD0fKLOlLm1I0YPcP8mmNgDTwph7zcRwRObLvdMJ/jj2WwXX5/fZO1UO2TpQbGzs3WezQ
	XMWwmS2d5+wk9iC8SACO2VrF5Lr8kBU0=
X-Google-Smtp-Source: AGHT+IEM8ITtLMS8DxeBvT6/RmBya3PWaa0XUPnlbL99EeYraeRDcyolno2BS9TfqpcJNo0wZQGPxHyvlXA2cEsbcOw=
X-Received: by 2002:a05:6512:318b:b0:57d:6fca:f208 with SMTP id
 2adb3069b0e04-591d856642dmr9077716e87.45.1761299365868; Fri, 24 Oct 2025
 02:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f006338-e69b-4b3f-b91f-0cc683544011@kernel.org>
 <20251022114527.618908-1-adriana@arista.com> <20251022201953.GA206947-robh@kernel.org>
 <CAERbo5z6BzHqQxXdxPxmxE_eDR7GGGbt3A8kB0gQiWFBE-28Ug@mail.gmail.com>
 <CAMj1kXGYinTKiyYhNYWJvoJeUJScCGnyq=ozLgjKAm7_wzG8QA@mail.gmail.com>
 <CAERbo5waY-=6BLZ2SiJSFAXzvU57mJdM9q05vAZw8zR2yExQ5w@mail.gmail.com>
 <CAMj1kXHin5YacS98ttzHqFqy6HMukXKoLZtr-+bLwVRsWZUugQ@mail.gmail.com> <CAERbo5zgS8XoGcFB3wejqDpx14-SBr5oWn7pu3=PE0djRiKZqg@mail.gmail.com>
In-Reply-To: <CAERbo5zgS8XoGcFB3wejqDpx14-SBr5oWn7pu3=PE0djRiKZqg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 24 Oct 2025 11:49:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEnSKF4VcMdOvUUuM-pOEWB38qPhWvUm13rnkQiZXp6SA@mail.gmail.com>
X-Gm-Features: AS18NWCrHHLzkvtAZPunKzdDM8HCcW0w6gfwr-1cHOznNZj5IAF1RRNbsGn2J3A
Message-ID: <CAMj1kXEnSKF4VcMdOvUUuM-pOEWB38qPhWvUm13rnkQiZXp6SA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] DMI: Scan for DMI table from DTS info
To: Adriana Nicolae <adriana@arista.com>
Cc: Rob Herring <robh@kernel.org>, krzk@kernel.org, jdelvare@suse.com, 
	frowand.list@gmail.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, vasilykh@arista.com, arm.ebbr-discuss@arm.com, 
	boot-architecture@lists.linaro.org, linux-efi@vger.kernel.org, 
	uefi-discuss@lists.uefi.org, linux-arm-kernel@lists.infradead.org, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Oct 2025 at 16:48, Adriana Nicolae <adriana@arista.com> wrote:
>
> On Thu, Oct 23, 2025 at 4:54=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > (cc Ilias)
> >
> > On Thu, 23 Oct 2025 at 15:34, Adriana Nicolae <adriana@arista.com> wrot=
e:
> > >
> > > On Thu, Oct 23, 2025 at 11:21=E2=80=AFAM Ard Biesheuvel <ardb@kernel.=
org> wrote:
> > > >
> > > > On Thu, 23 Oct 2025 at 04:21, Adriana Nicolae <adriana@arista.com> =
wrote:
> > > > >
> > > > > On Wed, Oct 22, 2025 at 11:19=E2=80=AFPM Rob Herring <robh@kernel=
.org> wrote:
> > > > > >
> > > > > > On Wed, Oct 22, 2025 at 04:45:25AM -0700, adriana wrote:
> > > > > > > Some bootloaders like U-boot, particularly for the ARM archit=
ecture,
> > > > > > > provide SMBIOS/DMI tables at a specific memory address. Howev=
er, these
> > > > > > > systems often do not boot using a full UEFI environment, whic=
h means the
> > > > > > > kernel's standard EFI DMI scanner cannot find these tables.
> > > > > >
> > > > > > I thought u-boot is a pretty complete UEFI implementation now. =
If
> > > > > > there's standard way for UEFI to provide this, then that's what=
 we
> > > > > > should be using. I know supporting this has been discussed in c=
ontext of
> > > > > > EBBR spec, but no one involved in that has been CC'ed here.
> > > > >
> > > > > Regarding the use of UEFI, the non UEFI boot is used on Broadcom =
iProc which
> > > > > boots initially into a Hardware Security Module which validates U=
-boot and then
> > > > > loads it. This specific path does not utilize U-Boot's UEFI
> > > > > implementation or the
> > > > > standard UEFI boot services to pass tables like SMBIOS.
> > > > >
> > > >
> > > > What prevents this HSM validated copy of u-boot from loading the ke=
rnel via EFI?
> > > The vendor's U-Boot configuration for this specific secure boot path
> > > (involving the
> > > HSM) explicitly disables the CMD_BOOTEFI option due to security
> > > mitigations, only
> > > a subset of U-boot commands are whitelisted. We could patch the U-boo=
t
> > > to include
> > > that but it is preferable to follow the vendor's recommandations and
> > > just patch U-boot
> > > to fill that memory location with SMBIOS address or directly with the
> > > entry point.
> >
> > And what security mitigations are deemed needed for the EFI code? You
> > are aware that avoiding EFI boot means that the booting kernel keeps
> > all memory protections disabled for longer than it would otherwise. Is
> > this allowlisting based on simply minimizing the code footprint?
> >
> From the information I have, it might be just minimizing the footprint
> but the vendor's U-Boot configuration for this specific path
> explicitly disables the CMD_BOOTEFI option. While the vendor cites
> security mitigations for this configuration, the specific details
> could be a set of mitigation removing different boot methods and some
> memory access commands.
>
> The core issue is that this non-EFI boot path is the vendor-validated
> configuration. Enabling EFI would deviate from this setup, require
> significant revalidation, and could impact vendor support. Modifying
> U-Boot to populate the DT is a contained change without modifying the
> U-boot vendor configuration.
>

I'm not sure I follow why changing U-Boot's code would not require
revalidation if simply changing its build configuration without
modifying the source code would require that.

> Beyond our specific vendor constraints, this DT method might be used
> by any other non-UEFI arm system needing to expose SMBIOS tables to
> the kernel.
>

Fair point. So let's do this properly: get buy-in from the U-Boot
folks and contribute your u-boot changes as well. And ideally, we'd
get this into the DMTF spec but if you are not set up for that (I
think you might need to be a member to be able to contribute), we can
find some ARM folks who are.

