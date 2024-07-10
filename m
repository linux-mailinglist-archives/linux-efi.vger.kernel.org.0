Return-Path: <linux-efi+bounces-1387-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0BE92CEB2
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 11:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB18289977
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC6918FA20;
	Wed, 10 Jul 2024 09:59:23 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78A517FD;
	Wed, 10 Jul 2024 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720605563; cv=none; b=d0H+RGrIiBgK5Ai0tABAcAml+yeIXPhXLZbckDjCishc58eSf4/FhF/a66ibww7jvmwEwGaGbHh/lomlbPioztrF4qRBoL8ShkdI6hjqr+i9N45BD5knFl5InWnDuiod4prPuPgj8+cYxzf84qKZrPaxJxJd8orvzEyMD8K4Eeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720605563; c=relaxed/simple;
	bh=BaCZzjmg8GC3UEj2EVodIg9vJl+VTk1i0cGEJeC89Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDR1o6YYOLH/WuvstQjGke6bka2LDxztyVYSuT9veRHNZm6oMlxEXStQnhbLoHZpzQkSB1s3YZQoPYNA9jmKm7W9rM3emsYVOhWNB3xotT9fca0XvDP1qmJohwvpftBdZIue6fyDdgRqb6eg9qvBnrvyyzgg4t618aK38uRp7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 146831C009E; Wed, 10 Jul 2024 11:59:19 +0200 (CEST)
Date: Wed, 10 Jul 2024 11:59:18 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>,
	linux-hardening@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 07/29] efi: pstore: Return proper errors on
 UEFI failures
Message-ID: <Zo5bdtz0vrA71vwX@duo.ucw.cz>
References: <20240618124018.3303162-1-sashal@kernel.org>
 <20240618124018.3303162-7-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+LLDe38b+Fw9GN0g"
Content-Disposition: inline
In-Reply-To: <20240618124018.3303162-7-sashal@kernel.org>


--+LLDe38b+Fw9GN0g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 7c23b186ab892088f76a3ad9dbff1685ffe2e832 ]
>=20
> Right now efi-pstore either returns 0 (success) or -EIO; but we
> do have a function to convert UEFI errors in different standard
> error codes, helping to narrow down potential issues more accurately.
>=20
> So, let's use this helper here.

I don't believe we need this in stable.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+LLDe38b+Fw9GN0g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZo5bdgAKCRAw5/Bqldv6
8rpxAJ9kRQeo22P62JMVNulvCl7OpJdjwwCeJC7y4AdHjBkg/KS78Nm0Ao/8VTs=
=BFBc
-----END PGP SIGNATURE-----

--+LLDe38b+Fw9GN0g--

