Return-Path: <linux-efi+bounces-2289-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EED9E5274
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 11:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEBC1880605
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A342C1D63DB;
	Thu,  5 Dec 2024 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guWl3kaO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387291D3566;
	Thu,  5 Dec 2024 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395052; cv=none; b=ZUeEyGfyrhBpNHb6vQQyfLdJTIDJRXQUHgU6ZOBFr1vBV67tCnXM3LkPogLxrOCEt7aZ1t6PTfG+bgO3QRblaHi0e3OgW5ttH1J5v3Sfnk4qkFNgS1gRjdDqiwD+OQgWKvE4hJOwhtdT+HCXEaI7A3Saxakp882G0gnV1QbHUKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395052; c=relaxed/simple;
	bh=k0Ri1gJvfMPkkmwOG5H5IkESAn8lv1SqrkOcLFEGEog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhAYxoL7+WcdIHF1+5N4BwfzLBUQvE+KMxh8x9XANRk/hHxLWFRVVLZwpiPkVFJM2iPTLiRumMG7lv7zFyflgWx81gI4Se2z17zXBjawaFnHl6wbeV36pLzHYkxiuHBoHp84nP+VElKCuIRlXfgiYwvNHWqKFHID/71xyY+Ec9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guWl3kaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853FDC4CED1;
	Thu,  5 Dec 2024 10:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733395052;
	bh=k0Ri1gJvfMPkkmwOG5H5IkESAn8lv1SqrkOcLFEGEog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=guWl3kaOoGEK+6hAPbImxmyWGcZsuvgDfS+SvtpN9yapsfB7pqHGGfp5hVdYv+Q5w
	 vuRJCFOEzZPcd6Zebd/3fx8AKcwYYRIt2OSrHd1J3yxUb8h1Rom0Xy/H5DqebnGf5X
	 2dcCaDOq9qqgy/7JnLhrUhhwK5k8bnLOoFX2Tzhd9Y9CvAuLbKVQ0fdaEysiLRWUwk
	 SYb80dJWMM3YYx1tkOF51oLUhxScy1I23lx2EE8ZPxRTsY8jpWX6xygI0m+rKvAwdl
	 2OBp+y6LpIANTG9T4G1GK6HuX4jdFpJVpP8FmAHs6E8qRz13DpF2xkEdujO4j3Rh0T
	 szxkvQEuQm43Q==
Date: Thu, 5 Dec 2024 11:37:29 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-sound@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux1394-devel@lists.sourceforge.net, arm-scmi@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	open-iscsi@googlegroups.com, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 08/11] gpio: sim: Remove gpio_sim_dev_match_fwnode()
Message-ID: <eyu7nm5hvwfqxgysnrzsvianzf7abvlovpxfo7snsxowmuuhpj@tah3gkqm5ldj>
References: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
 <20241205-const_dfc_done-v3-8-1611f1486b5a@quicinc.com>
 <7ugfaj2h3sy77jpaadco5xtjalnten3gmvozowcle3g7zcdqs4@sqf5l47onbsi>
 <ac42e652-4128-44ea-976e-5234360d8183@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ak6zeaiacfbfwyki"
Content-Disposition: inline
In-Reply-To: <ac42e652-4128-44ea-976e-5234360d8183@quicinc.com>


--ak6zeaiacfbfwyki
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 08/11] gpio: sim: Remove gpio_sim_dev_match_fwnode()
MIME-Version: 1.0

On Thu, Dec 05, 2024 at 04:37:08PM +0800, quic_zijuhu wrote:
> On 12/5/2024 4:10 PM, Uwe Kleine-K=F6nig wrote:
> > On Thu, Dec 05, 2024 at 08:10:17AM +0800, Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> gpio_sim_dev_match_fwnode() is a simple wrapper of device_match_fwnode=
()
> >> Remvoe the unnecessary wrapper.

Just spotted: s/Remvoe/Remove/

> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> ---
> >>  drivers/gpio/gpio-sim.c | 7 +------
> >=20
> > I think if you move this patch before patch #4 in your series, you only
> > have to touch this file once.
>=20
> the precondition of this change is patch #4, it will have building error
> if moving it before #4.
>=20
> actually, we can only do simplifications with benefits brought by #4.

Ah I see. I thought that device_match_fwnode only got the const for the
2nd parameter in patch #4.

Best regards
Uwe

--ak6zeaiacfbfwyki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdRgmcACgkQj4D7WH0S
/k6zeggAlBhwMJaGpQIgAi04teyouKX4a/XAJG3tLwpz4YweEcrMm/fv0N42hp/d
7zUKHjQRRcVM6+TSObZ6uKEFMpac+G1YG1Fze2rNPdlf5IUOCrpKqKUaziMyvEc+
hhaccpLCXjp9gi7H7tEBDfmrR6/S3i1nnYOeDn6tYmhKVx14uA57l4Isj2h+CIax
P5d+Gq9NQl5IXDnqiEez80oo8LFhLQQIjIeO1YQM7GrbXaqoD+CfZTGXe4/woRc5
JjzksiJqSccUbPlwM+90bh5Oj0H2VARUaJTRcHTRANM4ZFTSfWCep0Wkg8DSw343
fYW4rY4vIXpWKVG9LM4j7NAoluIWvQ==
=myq/
-----END PGP SIGNATURE-----

--ak6zeaiacfbfwyki--

