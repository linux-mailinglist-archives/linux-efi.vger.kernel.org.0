Return-Path: <linux-efi+bounces-2287-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9C19E4F60
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 09:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2676288F4E
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9491D042A;
	Thu,  5 Dec 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpPs2GWb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8290A19645D;
	Thu,  5 Dec 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386229; cv=none; b=Q0C3uIbdHa90lrx7uDALFG5WrGe3826jY5SIwyYlC0lv8v40nqQSkfCnnNDbnR9hE7iP9KFkx/VoC37KI9EK5U/TkNz7tny2PAgEBMqsFGefV9Lhh4PZP6TkoRDIFm1H+6hGz1xXgCUAFkXeiTKR3S/Njz8wGudLR2CODozd044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386229; c=relaxed/simple;
	bh=dm+XaarJmRd4PNMM8493FEpsyQu1VayQlRTan4XCkBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLdZXHgoEBmit39Ln2LBdxYBUkhf1ffVUZbDQEmM8/TZfYQnYcUjp8kH160b8YGvLY9m7oAHS8HkLQlp8WkZvO0pzqscwkbl+iF1ri9ne5VHqD2lQUwehh+LBsCUvEowJuidvPi5Zj+/z7Wg5fn/E5ZN2AW61EarJ8o4fTWzTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpPs2GWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BB7C4CED1;
	Thu,  5 Dec 2024 08:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733386229;
	bh=dm+XaarJmRd4PNMM8493FEpsyQu1VayQlRTan4XCkBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FpPs2GWbGgUz5ytJZ+QuBg7XSizF7MBLb5wQ47CrA74Do8i70h2t2SfmkVVxQxJwp
	 RFeHBA6N+1cKlVI8Shsh2lySUArR5RSI6914U1xBrr+bvhH7rr7cEdzsA4Rgi1d66U
	 zkLJI2jbu5xXvGwGUD8mz6V+6eqzicBTjawuRRljctphJ44a5cfQaamr4YGrDaX/zh
	 IbgvB4IO9782E6ZkMrskDL8DfFasy49Ius/Vc5afr1384a7Ak3SKFeTCK94J8odFfT
	 MaHtfcFW9mpHPKOXqE35SDPO05JukSUMC0SYTE1DD/M4FAoBDI7at285cpbtMDTdO+
	 RFuFFL23OJDcA==
Date: Thu, 5 Dec 2024 09:10:25 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-sound@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux1394-devel@lists.sourceforge.net, arm-scmi@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	open-iscsi@googlegroups.com, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, 
	netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v3 08/11] gpio: sim: Remove gpio_sim_dev_match_fwnode()
Message-ID: <7ugfaj2h3sy77jpaadco5xtjalnten3gmvozowcle3g7zcdqs4@sqf5l47onbsi>
References: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
 <20241205-const_dfc_done-v3-8-1611f1486b5a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ya6wyfjwhlqhd5wu"
Content-Disposition: inline
In-Reply-To: <20241205-const_dfc_done-v3-8-1611f1486b5a@quicinc.com>


--ya6wyfjwhlqhd5wu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 08/11] gpio: sim: Remove gpio_sim_dev_match_fwnode()
MIME-Version: 1.0

On Thu, Dec 05, 2024 at 08:10:17AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>=20
> gpio_sim_dev_match_fwnode() is a simple wrapper of device_match_fwnode()
> Remvoe the unnecessary wrapper.
>=20
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/gpio/gpio-sim.c | 7 +------

I think if you move this patch before patch #4 in your series, you only
have to touch this file once.

Best regards
Uwe

--ya6wyfjwhlqhd5wu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdRX+8ACgkQj4D7WH0S
/k6rewf+KsN2Irmv5Td5FMMxi+83vZgDfjxwj+eoLUlf72jMXWx89mPqbHAWyq2W
DVJONM/HQoPhG9ILJDxvkaVLetBPRY7QPBSVY8bMUaDT9ljXmnbxed/NGNngiATy
r1JyYMzf3dqlGSgJl6LhRpugodssXbGiDv8oVNRtLIHFd5MLH+xlUr0CFu0KsPSd
E4NADLSFAkpDIDer3BYt19RGkXNgCrbqzP8rfGN50Q9t+xuS58qoK2oY5+jzT11a
qccGFlDCzdaHWCVsLHVwXYWN2L5mxrrm09Dv8aS/0TcFMueK4nsasVRpUAplw+Gd
j791qtNhdb4QQUhbiOamc5BP/g6LvQ==
=1ED3
-----END PGP SIGNATURE-----

--ya6wyfjwhlqhd5wu--

