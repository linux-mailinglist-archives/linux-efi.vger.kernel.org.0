Return-Path: <linux-efi+bounces-5335-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCF5C2C02B
	for <lists+linux-efi@lfdr.de>; Mon, 03 Nov 2025 14:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102B41899E8C
	for <lists+linux-efi@lfdr.de>; Mon,  3 Nov 2025 13:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FAD30CDA3;
	Mon,  3 Nov 2025 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmrfrpGk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE430DD2F
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175504; cv=none; b=o77d9O8LOYFaXKb3xPJ19Sa/kmPzAsOuAZhlamSs7kkeRM8pNZr6osvMRyN8AR6GqtTzGQXYhiAguN77AZ44ybJ/Zd2mL0aYMzA4cUU/pPeBa34j4LE440jYG65zZ2A9rk+zkphXC9mw5dn3Tj2ZKdhbKSfvd4WFUGZ8rHzbsRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175504; c=relaxed/simple;
	bh=hkcGjhSNuBJqCDYhFpR4HKv0LE//ewMc0aXjMlRYi98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXukrsZgDfEFlu4JOhNTbljhjkexyZ42QGWmKLLTlGAguvK15eyzHAvtsczEWrHyWy/y4C0MGcvXgt//v6LQUzqMAZ9N3YAA7okMc+wm4N0SG2MS9NbzpTxoot0XZkpDpHtd/TkhmdCDrZ/0SFMCJ0brg6eiXkoggiurwhXy1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmrfrpGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDEAC4CEE7
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 13:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762175504;
	bh=hkcGjhSNuBJqCDYhFpR4HKv0LE//ewMc0aXjMlRYi98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mmrfrpGkhMITojffvKGNDcddl0UEu7QMnAG2g04RUytAzLUnHaaphT873ni6FLbCw
	 zHc2lft27/r/sZgzZM2eTBZXy8wUGTz/rpfagFr167S8aq6j3fX9ExLHVLA5YA+NgG
	 m76B6Ds3f0iBVd82Z8d5yJe7NApk443iPKsBIorKs8N6I+WEuBEmvFf3AzUHpEwMXm
	 aGv/4d3RoEL6yZyQw5nvfjmCYNlxa2p0SB79T73DuxO36pmPgaUb+3DhFr4UUexMe+
	 aODqmDS6xc82zzqlzfrGhW0wdbO0dKI4kWeJEVvqX//SlpNsCv04lBfkKrMzcbw5M1
	 tyxxIy89nV1oA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-586883eb9fbso5437961e87.1
        for <linux-efi@vger.kernel.org>; Mon, 03 Nov 2025 05:11:44 -0800 (PST)
X-Gm-Message-State: AOJu0YwwPCDkHFlKMBVequR/UC2MmB5LDWdfCgb6QwizEHVMx8X195DN
	GmDO5DeOHPYVeRZzjR46wgDMlGaKYyV07P5jeqVw872wsiAZusGuuTTpVs2mjVJYssSKf6CBnVX
	jIbm8KiEZxFsySe5BxfrRA0zU5jEPok8=
X-Google-Smtp-Source: AGHT+IE0jF9ZZS4oGUlH8lSkm+TnmRLYAlDNV0H1c5FaAI7HL/ZiatfAAVaCzegcKT5f+lxtSTUGbWeL+sfp356f2Hs=
X-Received: by 2002:a05:6512:1191:b0:592:f2ac:779f with SMTP id
 2adb3069b0e04-5941d500f9cmr4188118e87.18.1762175502721; Mon, 03 Nov 2025
 05:11:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102001411.108385-1-francescopompo2@gmail.com>
 <CAMj1kXEUL-Uv4tCx5NLVHDRo-BdEK1xJdee-UYs-ymE-mLxv0Q@mail.gmail.com> <CADr=TJdTcss14P43_jAj4tsEYukt=Z18SnjUNqMD95O_5KkNVA@mail.gmail.com>
In-Reply-To: <CADr=TJdTcss14P43_jAj4tsEYukt=Z18SnjUNqMD95O_5KkNVA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 3 Nov 2025 14:11:31 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEP=nByL5+R2Ch-PLSKnziEyyK_rLZL=wcvKRNcBPTJbg@mail.gmail.com>
X-Gm-Features: AWmQ_bkpgqE5vV6wNEMZwdayegSnXFcHcSy_rz1vjnzV6CjuL5B4TuzcLRvW758
Message-ID: <CAMj1kXEP=nByL5+R2Ch-PLSKnziEyyK_rLZL=wcvKRNcBPTJbg@mail.gmail.com>
Subject: Re: [PATCH] efistub/smbios: Add fallback for SMBIOS record lookup
To: =?UTF-8?Q?Francesco_Pomp=C3=B2?= <francescopompo2@gmail.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Nov 2025 at 11:15, Francesco Pomp=C3=B2 <francescopompo2@gmail.co=
m> wrote:
>
> Il giorno lun 3 nov 2025 alle ore 09:19 Ard Biesheuvel
> <ardb@kernel.org> ha scritto:
> >
> > Hello Francesco,
> >
> > On Sun, 2 Nov 2025 at 01:14, Francesco Pompo <francescopompo2@gmail.com=
> wrote:
> > >
> > > Some UEFI firmware implementations do not provide the SMBIOS Protocol=
,
> > > causing efi_get_smbios_record() to fail. This prevents retrieval of
> > > system information such as product name, which is needed by
> > > apple_set_os() to enable the integrated GPU on dual-graphics Intel
> > > MacBooks.
> > >
> > > Add a fallback that directly parses the SMBIOS entry point table when
> > > the protocol is unavailable. Log when the fallback is used.
> > >
> > > Signed-off-by: Francesco Pompo <francescopompo2@gmail.com>
> > > ---
> > >  drivers/firmware/efi/libstub/efistub.h | 17 +++++
> > >  drivers/firmware/efi/libstub/smbios.c  | 99 ++++++++++++++++++++++++=
+-
> > >  2 files changed, 113 insertions(+), 3 deletions(-)
> > >
> >
> > On which platform does this fix an actual existing issue?
>
> Hello Ard,
>
> My Macbook Pro Late 2013, product name Macbook11,3 is affected.

You meant MacbookPro11,3, right?

