Return-Path: <linux-efi+bounces-5333-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E706DC2B1C4
	for <lists+linux-efi@lfdr.de>; Mon, 03 Nov 2025 11:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3053B2363
	for <lists+linux-efi@lfdr.de>; Mon,  3 Nov 2025 10:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152A52FF15E;
	Mon,  3 Nov 2025 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhsDnXUT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E492FF153
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166478; cv=none; b=gj2020nusUplOKfCwdAbnExZ3S+oegpbtm9PE0OgRROFi+GURcVT4TZ4qfBL4G/byv/IObh78yr526bqbfCbL4O2l/X4rYig0qnoGHI8vZlFbmDVofi469JtZF8JHvSqmOv1dcp+0y9i6Uw+ULbyl84Hbl/D2/VquKcs34+Lofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166478; c=relaxed/simple;
	bh=4+L+ObjyqfOUwix+6EX/7qwZHGaUzprYEoX/LweO6xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBSdp+EW+0idV/NuLClZtiJblctuGgfcZ3ujT0xSGGyL4cu173anpF3TAC/nlxJkmbC9nyC9h+2bk8c/Q7t9tH1s1BSS/5JQ4yIkwYOJzxCCEHUBYx8Hdz162I8G8nU8RzmkwtjNF5YuvfvnJIXXb6w5bmJ4gM+JtcHZ/uKvN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhsDnXUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E5BC116B1
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 10:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762166476;
	bh=4+L+ObjyqfOUwix+6EX/7qwZHGaUzprYEoX/LweO6xc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QhsDnXUTJ4QzYsBiKcMvy17ybcYo3CxzJUGxqhnzGVJdejFVm5phN2gH/gxX3opSd
	 UCJR/HuW829YOu1eeDk0ZJgTflynRaswd3FrC6/3Bflvgfvf9TLlLYGbeqzkTQt+2v
	 47c6PogC8hvjSFWvzygwdkj0vlESDL4ZtidUq3ws//6HKq+4ri72t12A7aPmmcv4zX
	 2WJSQuz2m7VVYi7I/khFNLKJokoNDaoeUUZzRfMugOh4dAb7HnP9c+/kz6cEN+yKTF
	 11UcijV5rYA15bUhOKASxjKpFFoIqB0UnaCdXGdSFQqE4qV9lSz7JBedUf4K4MmWMm
	 OFWTWkU17gC4g==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-594270ec7f9so1384476e87.3
        for <linux-efi@vger.kernel.org>; Mon, 03 Nov 2025 02:41:16 -0800 (PST)
X-Gm-Message-State: AOJu0Yy1LOBOKdR8vdvW8NmCabq7Ktaw9kUVoXCr45kwgdSp6EFRcUvM
	Icnt98UnvmytEvLqyPh2MN4RmUtecCTLW2euuxz8OGPXOS38CC3d6ieO8NUcf4yzhtbz8kn0WEk
	Ok+QCwM+0xfRoMU6gCh2hafGRVS+Q+f0=
X-Google-Smtp-Source: AGHT+IH5UkZg0NfeXp1cdWmyKntl1VU6TzxKZda6g/+Pg3BizkQm1WZ5S5JPmlPTZ6S15mgZIs7+xOimsTo8wTeXfL8=
X-Received: by 2002:a05:6512:3b08:b0:57b:8675:e361 with SMTP id
 2adb3069b0e04-5941d50e4c5mr4765289e87.14.1762166474790; Mon, 03 Nov 2025
 02:41:14 -0800 (PST)
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
Date: Mon, 3 Nov 2025 11:41:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEfvx+jDv_6OfHd1uM-TUe0RkdR7JO1NnKbzcvLRpOQbA@mail.gmail.com>
X-Gm-Features: AWmQ_blKqjh2udJeMdvwEYSdYDKaLcDMFQWXRtJi-V_zesZFSmqW0PqclhymSGI
Message-ID: <CAMj1kXEfvx+jDv_6OfHd1uM-TUe0RkdR7JO1NnKbzcvLRpOQbA@mail.gmail.com>
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
> Specifically at least the firmware version 478.0.0.0.0, released on
> 01/13/2023. I have no way to downgrade to check for other versions.
>
> From what I have read on internet this should not be the only model to
> be affected.
>
> The issue is that apple_match_product_name() fails to obtain its info
> via efi_get_smbios_record() and makes apple_set_os() fail too.
>

Fair enough.

But please move get_table_record() into x86-stub.c and call it
directly from apple_match_product_name() if the call to
efi_get_smbios_record() returns NULL. That way, the fallback is only
used where we know it is needed, and we don't go down this direct
path, e.g., on random arm64 boxes.

Also, struct smbios_entry_point can be moved into the .c file, as it
is not used anywhere else. And you can drop the __packed, I think - if
it is needed for alignment, you can use __aligned(1) instead (but all
the fields seem to be naturally aligned afaict)

