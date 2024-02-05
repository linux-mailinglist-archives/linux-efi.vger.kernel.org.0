Return-Path: <linux-efi+bounces-483-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B9F849DF7
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 16:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02554287C18
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3772D634;
	Mon,  5 Feb 2024 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0Q8V1h/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D662D627
	for <linux-efi@vger.kernel.org>; Mon,  5 Feb 2024 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146606; cv=none; b=DWd3tkpCgooWMJSgPCD0lJsrLz52DoQJOFz2HvpVPh9XMtUJHn+CxFUi5asdLGnCCTStcDV+01RBupMa56XHSGNKGJaOtMAxnsiaPTfQK/O5DdtJNfIUyQicPjMzvgkoTunaVHtzlpF1W2Y7nht6Liu5V6cs5feQkPhlBW+zAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146606; c=relaxed/simple;
	bh=XnZ+F/bEb7mOdH7oOJsAt+16KHV9aNIp1PgetTU9EPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1wNX6dC8a6HMR3GX3jhuQJIJ7SkdP2eOh27QScifuIcDkmj4BibukbJ9yM2O6Q6Dv7C1sPBVc9dwzN5EKkC316zXl9CJ3ERpHMi/PEe2dYIAcTWxJ+6gnmZSWdX6VA8S6kw2CdirFgSWUamlCVdvTLJTetvWCKMYuvwxlFPBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0Q8V1h/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C98C43399
	for <linux-efi@vger.kernel.org>; Mon,  5 Feb 2024 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707146606;
	bh=XnZ+F/bEb7mOdH7oOJsAt+16KHV9aNIp1PgetTU9EPU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F0Q8V1h/lo9JCgiZsptq2ZgI7v+T6q9Sfs1MdEHarrxdG4qLIMOOShj2eNtkH8olC
	 eGEzkvzcm+8nHFHXZ6kq0u+QTwogJZ+zpOERshFrWMgY3eVXLwqqR5l29tV3AkVW2q
	 I2r253opCON0L1a1UZ3439B1b0SPWyUI8zDUJHd8BF0x65mWzKiyYqCvRc6hNTtk3K
	 JRkYxnCP7342Z3FfdVw+JJRfG/2ROZAekS6lpUe7HeVqNUwf46H//TP7I/SqS3wp7e
	 qgn9CpwDVm3SHnNIXeO6T8IsI6hFhlGG83IuvaBDajCREQ6Ky0hIKKEuTtVH/5GUtm
	 LdwvdV7qA3LYg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-511413e52d4so2554000e87.1
        for <linux-efi@vger.kernel.org>; Mon, 05 Feb 2024 07:23:26 -0800 (PST)
X-Gm-Message-State: AOJu0YxdaRSxzj8R3cOKH3dk19LnTcFffx9Jd3Sl1W/vNypLTdwdTZ0e
	udWQNYvKwHqY4Ga1Xt87CtDNc0J4JhHaBrWnCrSZpmJSf8kajy4vEl5yPrwoRhs4kDN/rGr8MUh
	vpx0OklPc4vKWZ8qq8w2vLOhYWcE=
X-Google-Smtp-Source: AGHT+IFEjDLJA0IB/Nag+F9f15yX9w6xuGWFL7kLr9dfpcTiOMata9L6OjqmD9ZyCzByPw6zWjFXNB/s4/tFIZB5qWE=
X-Received: by 2002:a05:6512:34cc:b0:511:4ff1:e8e8 with SMTP id
 w12-20020a05651234cc00b005114ff1e8e8mr1755776lfr.16.1707146604584; Mon, 05
 Feb 2024 07:23:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707141974.git.baskov@ispras.ru> <82e66a8c9ae70e416eb8ae5229cf5a93f17921b9.1707141974.git.baskov@ispras.ru>
 <CAMj1kXHTyq6=hVOYa3u2y0GRcrG6wCFA8OqrELZXQD+EGwdMuA@mail.gmail.com> <62e0169a301b68f2b985d1a8659f1363@ispras.ru>
In-Reply-To: <62e0169a301b68f2b985d1a8659f1363@ispras.ru>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 5 Feb 2024 15:23:13 +0000
X-Gmail-Original-Message-ID: <CAMj1kXGg4c=4Tk4PCSJRCpMTRQ-M2c54QqrfRuOzZoWBYab3oQ@mail.gmail.com>
Message-ID: <CAMj1kXGg4c=4Tk4PCSJRCpMTRQ-M2c54QqrfRuOzZoWBYab3oQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/boot: Order sections by their RVAs
To: Evgeniy Baskov <baskov@ispras.ru>
Cc: Mike Beaton <mjsbeaton@gmail.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 15:13, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> On 2024-02-05 17:49, Ard Biesheuvel wrote:
> > On Mon, 5 Feb 2024 at 14:44, Evgeniy Baskov <baskov@ispras.ru> wrote:
> >>
> >> Image loaders which check the contiguity of executable images consider
> >> sections adjacent in the section table to be adjacent in virtual
> >> memory.
> >>
> >> Sort sections by their RVAs in PE section table.
> >>
> >> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> >> ---
> >>  arch/x86/boot/header.S | 56
> >> +++++++++++++++++++++---------------------
> >>  1 file changed, 28 insertions(+), 28 deletions(-)
> >>
> >
> > Hi,
> >
> > I just sent a fix for this issue:
> >
> > https://lore.kernel.org/linux-efi/20240205081106.2415414-2-ardb+git@google.com/T/#u
> >
> > Could you please check whether it works for you as well?
> >
>
> Yes, your patch works fine as well. Thanks!
>

Thanks for confirming!

I tried your patch too, and it makes the signing tools unhappy (see
below), so I am going to stick with my version. But thanks for sending
a fix in any case.



$ sbsign --key ~/sb/PK.key --cert ~/sb/PK.crt arch/x86/boot/bzImage
warning: gap in section table:
    .setup  : 0x00001000 - 0x00003a00,
    .text   : 0x00004000 - 0x00d0b000,
warning: gap in section table:
    .data   : 0x00d0b000 - 0x00d0c200,
    .compat : 0x00003a00 - 0x00004000,
gaps in the section table may result in different checksums
Signing Unsigned original image

