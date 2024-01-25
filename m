Return-Path: <linux-efi+bounces-429-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E3D83BB61
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jan 2024 09:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877DE1F211BD
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jan 2024 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B423179AF;
	Thu, 25 Jan 2024 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKzD/Zxy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A81179A7;
	Thu, 25 Jan 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170367; cv=none; b=q/Kpaqtfoq6a5HSKc8UjfQtfZxDuUxhzy8O3gcOXw3jrork32COA6dV34giGdYMni4j/gfjocw6Zmw1eMerCll6Ru7GoKZR5TZs9pvjcgS2204BpRS7JH5fLgX1pB3Fs/hg8CnAhKt2vL563EKSvfHRKcn78f5hhSvXDG4aXTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170367; c=relaxed/simple;
	bh=KYhAA6lbh1xlFPF4g0tLNLt2+ZEzx+nnfioRTgNZ+Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqdzgWrpspDeZ3q2cZSWssn/CmsHND7J2P0Z8gipHeh/htTPNg+kdPPA7LoE93Lbp76Ll54XRHkg6z/cPEdl+hRHKcZUobN5PlbBZTPFQ2fhQSmHH0pSVpnSLc+z2ubllmq2M5Jk8siP9+lr/uN4tBntJYwS64yoQ54KuB9saJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKzD/Zxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633CCC43399;
	Thu, 25 Jan 2024 08:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706170366;
	bh=KYhAA6lbh1xlFPF4g0tLNLt2+ZEzx+nnfioRTgNZ+Pk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OKzD/ZxyGHc+z0bHJb1IHx9Uz9aB3Hs8MyqrZOkb2rxEMoe04osHQidq0G79q99j9
	 nfE5+zzGjsy5p6r/g706f594qOn7Xjw5dV3M2DSScJzJDXSniIPYATEYX/nKVMvoLW
	 H+gnXV3I9TwrPs3IJX3ABmkh3Lcx1IY1paBXbZrD8dqUZjZGpb6HOwLvjNBvSY1PoO
	 IGMjV7UTaE8EwE/Yhh39ShGUhMowxmydfhA+QHiuDOMi0TBQAMuYe9Ti8wUT5k+bX1
	 ErEfXC7wYUGIblhdTB8eUeiaA2Ncm2WkNgejUPR0pWz5qb39wAbOnyyyOEOsX3yNXW
	 sAoKw/w7tAgIg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so8045982e87.0;
        Thu, 25 Jan 2024 00:12:46 -0800 (PST)
X-Gm-Message-State: AOJu0Yyp9SV7F2qay2ZA246uUO6aw2Vc5pz2LNKqj4i8bdpTY3ZE3WWY
	/dkX0kMociEXCr/XxEJ+O1hY6l+vPHOSXyh+M+izIyeucFjfijU/yQqm0vVhR175fm40M6CUbuU
	5Icxi6XQFCr4M4VCaXH2CGJelYBA=
X-Google-Smtp-Source: AGHT+IEzX6x1uB9XZGr96SYyMy6G30ijHjldN1YhIU6+Shq6eYNHzD8BbKTQbvRQqwDcA/k0tQfpNbWEGHAKQhmivn8=
X-Received: by 2002:a05:6512:2388:b0:510:cfb:5817 with SMTP id
 c8-20020a056512238800b005100cfb5817mr408947lfv.53.1706170364598; Thu, 25 Jan
 2024 00:12:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122231507.1307793-1-timschumi@gmx.de> <CAMj1kXHSSRacU3hp6D3sdUKDESi1FoD33Qi=5Df+=_biZ-vqhA@mail.gmail.com>
 <223a4e75-2e06-4bc6-a70c-823f0eb308d7@gmx.de> <CAMj1kXEKF_a6wLtoMYCwBKEVDo6k1u=Cas-=4Ar4WnANHNu+cg@mail.gmail.com>
 <b58a112f-767f-4918-8262-63ac1dbfebbf@gmx.de> <CA+g+hrh_REk-bcTt-D+eSngofxdejeRXuXKhf1O15wzn+qMy6Q@mail.gmail.com>
In-Reply-To: <CA+g+hrh_REk-bcTt-D+eSngofxdejeRXuXKhf1O15wzn+qMy6Q@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 25 Jan 2024 09:12:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG1Fkpy2UDFAuGr9czTCft6N-tUQ0CTOvysqW5mX_xMTQ@mail.gmail.com>
Message-ID: <CAMj1kXG1Fkpy2UDFAuGr9czTCft6N-tUQ0CTOvysqW5mX_xMTQ@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: Iterate variables with increasing name buffer sizes
To: Peter Jones <pjones@redhat.com>
Cc: Tim Schumacher <timschumi@gmx.de>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org, 
	Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jan 2024 at 22:25, Peter Jones <pjones@redhat.com> wrote:
>
> On Tue, Jan 23, 2024 at 12:33=E2=80=AFPM Tim Schumacher <timschumi@gmx.de=
> wrote:
> >
> > On 23.01.24 15:09, Ard Biesheuvel wrote:
> > > On Tue, 23 Jan 2024 at 14:55, Tim Schumacher <timschumi@gmx.de> wrote=
:
> > >>
> > >> I'd rather avoid introducing deviations from the specifications on t=
he
> > >> kernel side as well.
> > >
> > > Which specification would this deviate from?
> >
> > The preexisting comment claims "Per EFI spec", and it appears that I go=
t
> > mislead by that. Neither the UEFI specification, nor the newest revisio=
n
> > of the EFI specification (which I guess is what would have been current
> > back in 2004, when this comment was introduced) seem to make any mentio=
n
> > of a maximum length for the variable name.
>
> Curiously, I can't find it in the 1.02 spec (the oldest I can find)
> either.  When I inherited efibootmgr around 2013, this was a
> limitation there, but I don't see anything in that tree that claims
> it's a spec limitation either.  My suspicion is this is a former
> Itanium firmware limit that got promoted to "the spec says" by word of
> mouth, or was in some very early ia64 implementation spec.
>

Also, the comment (and similar ones I've seen in the past) seem to
refer to the entire variable (name + payload) rather than just the
name.

So I am still leaning towards simply reducing this to 512 bytes.

