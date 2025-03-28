Return-Path: <linux-efi+bounces-3101-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4A5A7500A
	for <lists+linux-efi@lfdr.de>; Fri, 28 Mar 2025 19:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449D73BBABA
	for <lists+linux-efi@lfdr.de>; Fri, 28 Mar 2025 18:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351261DB933;
	Fri, 28 Mar 2025 18:03:44 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE71DE3CF;
	Fri, 28 Mar 2025 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743185024; cv=none; b=Un0yhwaYaM9zblw0JDGBk2paPQIYA0xrQQMtxKllaP/0zOluKawgknr6aQM/tCQa4N8P0dAZ3/O6HXLJeRGOTnsJ4PoDJsdgL+ODNidKxn9KY29vaHsIRXuswhR2xrZD0hIM4eBq8imWfPjs1iy0HU9icSI+b81xPTQ4QFzCHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743185024; c=relaxed/simple;
	bh=IWz0jtZ6+4vXPupTEZOFTGaUWXOG/rvX0o464gLivlI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b/AcpBk66HMNjY0Z7GLlgpLA1IyNuN8Tqqcg73MypCyb9OO0w2gqJexCg9hQMp0aaDWZe+R2Zr0RU9ph2lNMgJqzwcYEDCNZIQtj5rk+DLzlzUXa0FMkXqB6DtcOWed5oxh/aLFYickFbt3uk9SDcocA2OvUtr3ahLoAyot1SHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1tyE3M-0006IW-0p;
	Fri, 28 Mar 2025 18:03:35 +0000
Received: from ben by deadeye with local (Exim 4.98.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1tyE3J-000000002Rz-33YE;
	Fri, 28 Mar 2025 19:03:33 +0100
Message-ID: <56332722d85e0893884e7bacaf28cebd8665adec.camel@decadent.org.uk>
Subject: Re: [PATCH V3] block: fix conversion of GPT partition name to 7-bit
From: Ben Hutchings <ben@decadent.org.uk>
To: Olivier Gayot <olivier.gayot@canonical.com>, Ming Lei
 <ming.lei@redhat.com>,  Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Mulhern <amulhern@redhat.com>, Davidlohr
 Bueso	 <dave@stgolabs.net>, stable@vger.kernel.org
Date: Fri, 28 Mar 2025 19:03:23 +0100
In-Reply-To: <7afc3a7e-1dd8-4dbb-b243-75bd554c00da@canonical.com>
References: <20250305022154.3903128-1-ming.lei@redhat.com>
	 <3fa05bba190bec01df2bc117cf7e3e2f00e8b946.camel@decadent.org.uk>
	 <7afc3a7e-1dd8-4dbb-b243-75bd554c00da@canonical.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-QaH22s1ONrOgfyQFf70Q"
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


--=-QaH22s1ONrOgfyQFf70Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-03-28 at 10:29 +0100, Olivier Gayot wrote:
> > We shouldn't mask the input character; instead we should do a range
> > check before calling isprint().  Something like:
> >=20
> > 	u16 uc =3D le16_to_cpu(in[i]);
> > 	u8 c;
> >=20
> > 	if (uc < 0x80 && (uc =3D=3D 0 || isprint(uc)))
> > 		c =3D uc;
> > 	else
> > 		c =3D '!';
>=20
> Sounds like a good alternative to me.
>=20
> Would a conversion from utf-16-le to utf-8 be a viable solution?

If we were adding partition name support today I think UTF-8 conversion
would be reasonable, but I would guess that there are now consumers that
depend on the output being restricted to ASCII.

Also I think we would still want to replace non-printable code points,
and we don't have iswprint() in the kernel.

Ben.

--=20
Ben Hutchings
If at first you don't succeed, you're doing about average.

--=-QaH22s1ONrOgfyQFf70Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfm5GsACgkQ57/I7JWG
EQmoDRAAlGEJhib5bEgBApYoART1rmhAfp5kK7hFigKNY2QNvq4GZx1yFD16Bnv7
w3zTpcnaYjdHxKj67/JdJR6PJ4E9OmbHYpUslwbV3JFn5FgkddeKDcmImmAfg3rX
xQ3lt/pjm8nJPGG+Ddk7sEcjgAewvLWyMX0GdSfkOmtv/2Kbcs0e7IclREB+JbJO
vLAuZDnD2ESCED2RIYlp6INfSXyimtblX8zrS52XcHfqTmde0Ky4YIdpvTQiy3qh
uFhagwnixPCnyz9zoCJdC50NMsS9kuHrCWwjXpi4etwwlDIxHknpezbvncIb1tOt
ZRwXdC0oT8TLcckWKxWkHvz9CvlDZTHg6qJAu7AwLVtc8HvQBX1uR+45z4vvv7J+
FhSjF/TeDgGAE+l0JehBSWNMjr8Aak5Gfsmr2/IZV3tjluU41RIAWfSoSUG4G7hR
s4b9boJQYhciJ4Crxu07ztxJ1+j1wvBHwddIJclrItYbMKvOGj6IqfmFHBmHi0pM
OFaVtpsswMTyEE7XZP5dlZprFnpmJGMs2IlS4OMEzG7BqV4Qi2PuUzgp52Tc5yHM
GwuV7iMYS5yUk89z0x6V2Xg/OJE4AJv3y3NbaWafHzkJK5XZ/gqwS3rv0htTVyx/
mQE2va4TeZSxQNFhlbwQbvsK1sVYW0BCpPzizi/+Ka+8ZIeOg7c=
=qxbz
-----END PGP SIGNATURE-----

--=-QaH22s1ONrOgfyQFf70Q--

