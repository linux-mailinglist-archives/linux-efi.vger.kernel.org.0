Return-Path: <linux-efi+bounces-3102-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB664A75110
	for <lists+linux-efi@lfdr.de>; Fri, 28 Mar 2025 20:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8C71894CAC
	for <lists+linux-efi@lfdr.de>; Fri, 28 Mar 2025 19:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7391E25E3;
	Fri, 28 Mar 2025 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX8b/jJB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3C440C;
	Fri, 28 Mar 2025 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743191842; cv=none; b=pEa7dw5elIHy/VZnTGakl/pfJzqlC7+b8es5ZZMYp19itXz2nwD2kQUohQfwN+kEBwayrIlzOh3tiJ4xspDyTBsCj3D44PPm/I8nrX4nGVeDk7L0FYWhPEcuQPBOZno7eoB7aFFyf0Sz7ru0swg/aEd8xzgBUrvB9s39oGCrjwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743191842; c=relaxed/simple;
	bh=WOyP51M5VG8gM9J1EQ7WxvSWTNgzj+fuAuQhwo2lTcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqJD/6BzrCSBD2LVH3zRuZ20jWnyaTpvEaOTVIv0Ysdcy35JJdGRjjyCPFrFqMMz7cP2LyMJPLVYkZkOPblGrGlwGBYU/cThYG//5328A/WDIrxm0wzisXBaRstZu6zH+1BGzx2lXdqGx50A0kQKTBN8titatLXfxTXiB2mNCCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VX8b/jJB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3997205e43eso2140576f8f.0;
        Fri, 28 Mar 2025 12:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743191839; x=1743796639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVRh/j2CYf82mbVK3ol4luVdl6Ntk/Flrnz5IBJyauc=;
        b=VX8b/jJBuLFGcF4dKVvcIC3avE+tvRN52DYCzfi1Pgo6yXnymnLPqjdSwM6ELyuX70
         EVyVRY5iAaEoORX+IKDFRd1OHWTuRkjM82jG0eeJxR9bB90gzSwauqgFECgedx3y2raH
         wCJUpWBRg1sXfLEGgP6QkNiPHdXEIK7Oblyr0Hsc5eNb5uQ/HsK5fpkikl2GZGd0MDBZ
         btoF9Vwxxaq3jJGyMsL4w01uOGAuW3ZYivdKoXdEJjX5Kt76pnsPnxkGsW4yPMZjFd2R
         iP4V9K1fqQG9AKlf7DIom2sTnR7uJ/Zmwy8bMM20Za7xWcLLbmfED0P+pvfPL9MQN9GV
         +Vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743191839; x=1743796639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVRh/j2CYf82mbVK3ol4luVdl6Ntk/Flrnz5IBJyauc=;
        b=SghVD3eO3YWkoTxh7zgNT8Yc+Ha7wshxgWXub2NtyJ4kk3nuHovWpIlhLrziZwhOdF
         5PAJPiU4WoNea39S0GpZdVEmcuS9WEOSxvtEMXHsumcNCTZculzJE0aFBBD2UAbpNJGf
         1W/N/BEAfBdRvQGdgk7OXqBBrWKY1metP3tj1YAdpW4utkDyJKYJAcAM4J+sE1hneOmn
         YDeGe4Etx2VNkujDFLvhKdkzgxApt5D82OITqndU6q1c131TX6gpF8GMAFbRg6LU4p+P
         xK3hh/FRQH3GKOWE8ioStmp8OFfF1dk96hhs/NvV4fBz94+AVpDwzHTuYQxEj06jzldc
         GaNA==
X-Forwarded-Encrypted: i=1; AJvYcCU+tOke/lz0238niGUCcyRllo8PRHvHU6GRqL4ActxfivwpFzTPv2Ey/SmjF5BYNXivZR09NOSF@vger.kernel.org, AJvYcCVUWBveXoFDu9Zq+mF9VD2qgRCZBuGdL+ACcSpQLELnYy7fGO4FDZ7IoFT12PsIhz1ZcnUFfHc80F6e6g==@vger.kernel.org, AJvYcCX8YCHpqKh9hUd7tXoJJXKQ1PCDu6vquNkQauH4ouAj3OmpZfeKg2n/6icYkdBIdApjNI1ewof9YJNR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KJVhPI2L3gz8YaNzy6FRDGJgVA0HHXxEJeIaA2sUxnUbZGQK
	Fb5CQPNJSvy48TlTchGim4+5MAoeNcg4DI8aIjjPWKvFh3wBc8zx
X-Gm-Gg: ASbGncs/wVoEFiatkoagRvq3f8kJvfLusHiy2lMz0TZHM2qc1PqnwCeDadVLs4m+pZu
	nJipKsa6kVaW79xMnUj4L5JFyWfNlKYPEy0xAhl8mZaa33u6lhWcgJaHqG7AsKkm5A6LwARxReb
	wdlXHpv74Cq/kUhjC+Bv0ecgLubNcNFAJkIpLLwSjv9avyVZoz2F0mlk7VCm8B/flHlaiP+7KZK
	9GqOYZuAJCmRwvbUDxGhuKgfZD+ZmudoKSxsZqQ0JwT+5j4H3BqOfvc0e/4baeAnSRraXGQuzPq
	0f4yFT731P5npUtGyAQ5wtq2gJyhMijJfPmReLZbkaz7ebayV3Uwp2SVcE0a2wmH7gbMU3qr+/9
	35HAjmQ8=
X-Google-Smtp-Source: AGHT+IFfCE7vy+jmjroDw/bDpWsw8c21bpFoAbgXY/5dzQEXhKrNDoe1GpwfCvWGEF2yEk9g/CLohw==
X-Received: by 2002:a05:6000:178b:b0:390:e1e0:1300 with SMTP id ffacd0b85a97d-39c120e3ee0mr296428f8f.33.1743191838874;
        Fri, 28 Mar 2025 12:57:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b663470sm3520481f8f.27.2025.03.28.12.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 12:57:18 -0700 (PDT)
Date: Fri, 28 Mar 2025 19:57:16 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-efi@vger.kernel.org, Olivier Gayot
 <olivier.gayot@canonical.com>, Mulhern <amulhern@redhat.com>, Davidlohr
 Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH V3] block: fix conversion of GPT partition name to 7-bit
Message-ID: <20250328195716.54325489@pumpkin>
In-Reply-To: <3fa05bba190bec01df2bc117cf7e3e2f00e8b946.camel@decadent.org.uk>
References: <20250305022154.3903128-1-ming.lei@redhat.com>
	<3fa05bba190bec01df2bc117cf7e3e2f00e8b946.camel@decadent.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Mar 2025 23:34:29 +0100
Ben Hutchings <ben@decadent.org.uk> wrote:

> On Wed, 2025-03-05 at 10:21 +0800, Ming Lei wrote:
> > From: Olivier Gayot <olivier.gayot@canonical.com>
> >=20
> > The utf16_le_to_7bit function claims to, naively, convert a UTF-16
> > string to a 7-bit ASCII string. By naively, we mean that it:
> >  * drops the first byte of every character in the original UTF-16 string
> >  * checks if all characters are printable, and otherwise replaces them
> >    by exclamation mark "!".
> >=20
> > This means that theoretically, all characters outside the 7-bit ASCII
> > range should be replaced by another character. Examples:
> >=20
> >  * lower-case alpha (=C9=92) 0x0252 becomes 0x52 (R)
> >  * ligature OE (=C5=93) 0x0153 becomes 0x53 (S)
> >  * hangul letter pieup (=E3=85=82) 0x3142 becomes 0x42 (B)
> >  * upper-case gamma (=C6=94) 0x0194 becomes 0x94 (not printable) so gets
> >    replaced by "!" =20
>=20
> Also any character with low 8 bits equal to 0 terminates the string.
>=20
> > The result of this conversion for the GPT partition name is passed to
> > user-space as PARTNAME via udev, which is confusing and feels questiona=
ble. =20
>=20
> Indeed.  But this change seems to make it worse!
>=20
> [...]
> > This results in many values which should be replaced by "!" to be kept
> > as-is, despite not being valid 7-bit ASCII. Examples:
> >=20
> >  * e with acute accent (=C3=A9) 0x00E9 becomes 0xE9 - kept as-is because
> >    isprint(0xE9) returns 1.
> >
> >  * euro sign (=E2=82=AC) 0x20AC becomes 0xAC - kept as-is because ispri=
nt(0xAC)
> >    returns 1. =20
> [...]
> > --- a/block/partitions/efi.c
> > +++ b/block/partitions/efi.c
> > @@ -682,7 +682,7 @@ static void utf16_le_to_7bit(const __le16 *in, unsi=
gned int size, u8 *out)
> >  	out[size] =3D 0;
> > =20
> >  	while (i < size) {
> > -		u8 c =3D le16_to_cpu(in[i]) & 0xff;
> > +		u8 c =3D le16_to_cpu(in[i]) & 0x7f;
> > =20
> >  		if (c && !isprint(c))
> >  			c =3D '!'; =20
>=20
> Now we map '=C3=A9' to 'i' and '=E2=82=AC' to ','.  Didn't we want to map=
 them to
> '!'?
>=20
> We shouldn't mask the input character; instead we should do a range
> check before calling isprint().  Something like:
>=20
> 	u16 uc =3D le16_to_cpu(in[i]);
> 	u8 c;
>=20
> 	if (uc < 0x80 && (uc =3D=3D 0 || isprint(uc)))

Given that, for 7-bit ascii, isprint(uc) is equivalent to (uc >=3D 0x20 && =
uc <=3D 0x7e)
you can do:
	if (uc >=3D 0x20 && uc <=3D 0x7e)
		c =3D uc;
	else
		c =3D uc ? '!' : 0;

  David

> 		c =3D uc;
> 	else
> 		c =3D '!';
>=20
> Ben.
>=20


