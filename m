Return-Path: <linux-efi+bounces-3098-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 446C9A740FB
	for <lists+linux-efi@lfdr.de>; Thu, 27 Mar 2025 23:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7703716A67C
	for <lists+linux-efi@lfdr.de>; Thu, 27 Mar 2025 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B4B1D7E4F;
	Thu, 27 Mar 2025 22:34:49 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F5D15442A;
	Thu, 27 Mar 2025 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114889; cv=none; b=DGh/c/a4qbatThF6VlO9MjRH6WJj4kSeRY1FehgdlbFYVa8uUbxrfvVIbJ1UfGc6JxjLRz/JCGTCO15BYjTG+Y082eQkzpwrAgKhBzuiHlv3hcMmByQfIAQMkIVtFyKwEin+N/X2bDeXrUO5xbksOIY9vEdRsZsBV1BHZurUKu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114889; c=relaxed/simple;
	bh=3CSkkhDB3OkuUO8+fBRtj2a5+2D2468SNUFndQtMkHM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jkfiOOfrcsV/7g3bi9qb+o5EBcqkaN6s1/Qjb3IVSUIKdZGwOH8FP1iwrooXbwhD4uvYPS6BqtjbBd0ukKbeJwMWOpF7AsvLksj1r7TLWzCW1LUy23/AqDX6ZLMtkfV33qIlTy9uembrhlWC7uUyl/c+axJ/2k5saWduRvJAntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1txvo4-0002Xd-2s;
	Thu, 27 Mar 2025 22:34:35 +0000
Received: from ben by deadeye with local (Exim 4.98.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1txvo2-000000054em-1uCU;
	Thu, 27 Mar 2025 23:34:34 +0100
Message-ID: <3fa05bba190bec01df2bc117cf7e3e2f00e8b946.camel@decadent.org.uk>
Subject: Re: [PATCH V3] block: fix conversion of GPT partition name to 7-bit
From: Ben Hutchings <ben@decadent.org.uk>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Olivier Gayot <olivier.gayot@canonical.com>, 
 Mulhern <amulhern@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 stable@vger.kernel.org
Date: Thu, 27 Mar 2025 23:34:29 +0100
In-Reply-To: <20250305022154.3903128-1-ming.lei@redhat.com>
References: <20250305022154.3903128-1-ming.lei@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-RVoY/5FyFWWaQY8gMRQ4"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-RVoY/5FyFWWaQY8gMRQ4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-03-05 at 10:21 +0800, Ming Lei wrote:
> From: Olivier Gayot <olivier.gayot@canonical.com>
>=20
> The utf16_le_to_7bit function claims to, naively, convert a UTF-16
> string to a 7-bit ASCII string. By naively, we mean that it:
>  * drops the first byte of every character in the original UTF-16 string
>  * checks if all characters are printable, and otherwise replaces them
>    by exclamation mark "!".
>=20
> This means that theoretically, all characters outside the 7-bit ASCII
> range should be replaced by another character. Examples:
>=20
>  * lower-case alpha (=C9=92) 0x0252 becomes 0x52 (R)
>  * ligature OE (=C5=93) 0x0153 becomes 0x53 (S)
>  * hangul letter pieup (=E3=85=82) 0x3142 becomes 0x42 (B)
>  * upper-case gamma (=C6=94) 0x0194 becomes 0x94 (not printable) so gets
>    replaced by "!"

Also any character with low 8 bits equal to 0 terminates the string.

> The result of this conversion for the GPT partition name is passed to
> user-space as PARTNAME via udev, which is confusing and feels questionabl=
e.

Indeed.  But this change seems to make it worse!

[...]
> This results in many values which should be replaced by "!" to be kept
> as-is, despite not being valid 7-bit ASCII. Examples:
>=20
>  * e with acute accent (=C3=A9) 0x00E9 becomes 0xE9 - kept as-is because
>    isprint(0xE9) returns 1.
>
>  * euro sign (=E2=82=AC) 0x20AC becomes 0xAC - kept as-is because isprint=
(0xAC)
>    returns 1.
[...]
> --- a/block/partitions/efi.c
> +++ b/block/partitions/efi.c
> @@ -682,7 +682,7 @@ static void utf16_le_to_7bit(const __le16 *in, unsign=
ed int size, u8 *out)
>  	out[size] =3D 0;
> =20
>  	while (i < size) {
> -		u8 c =3D le16_to_cpu(in[i]) & 0xff;
> +		u8 c =3D le16_to_cpu(in[i]) & 0x7f;
> =20
>  		if (c && !isprint(c))
>  			c =3D '!';

Now we map '=C3=A9' to 'i' and '=E2=82=AC' to ','.  Didn't we want to map t=
hem to
'!'?

We shouldn't mask the input character; instead we should do a range
check before calling isprint().  Something like:

	u16 uc =3D le16_to_cpu(in[i]);
	u8 c;

	if (uc < 0x80 && (uc =3D=3D 0 || isprint(uc)))
		c =3D uc;
	else
		c =3D '!';

Ben.

--=20
Ben Hutchings
If God had intended Man to program,
we'd have been born with serial I/O ports.

--=-RVoY/5FyFWWaQY8gMRQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfl0nUACgkQ57/I7JWG
EQkwGQ/8DAz/Sk0ptrmxpyj5dLfoDsrDF3pR2z+3uhS3QzuqqDo1kp68oupVW9SD
5KosvmwQWwPMStwkK5yfRXHbBlp7mUbJK5Q4y2P+yL9QD95IzVLb6yH165MjRjY0
YxEVdPruGdxMzMU4GKx7ix4JC+xRrz3XLB7CI8cz1sKfvRQ1vAUNq3nVL305k1+o
Dt2zmkCtB5sB6pcvxKHjnOoIV5V6gnejryzWYc7XGD4JoRF0Xrp4ktBWINgMkdE/
bgdHtEhysFmxlGx9F5nOJcm173tl9ErgdKRzC0j5U5sd1A0kZTY1HpkoyqPDczIl
coVeiEwmP/POaATGR/2zmMRbq22WVObC6Q5H3oMUE4gkUf1Ht6DDpjlfKfy41jvy
Qb2omMUqM24szn5WbJxwHnbaGXpkv2k+ERIHI2tGsIp55tMX1CxqfUpOKPXPahW+
xiVb6MZPOTp1ZCo81nznDvIM9GE3ckUYnlH3i+Z/P8GsW5YHjNOJ696z4VRdpiVG
dRju1K2f4xHBISaQMVu3J7xvJjgdPsaDwLSe2W93wmwvIP9pHJ8Y8qCE19kWfSHo
fXjEz1NFEziGEeZ3pMwYEvOQLHf9zdtReB8scGK1YFUFIlbIcUM7a4OpKX0DWYHn
T8xSRXAylMM79sFy90LFGHhdS66o7rTtXgiKEDnNNQKW6vPjFKI=
=7cKK
-----END PGP SIGNATURE-----

--=-RVoY/5FyFWWaQY8gMRQ4--

