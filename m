Return-Path: <linux-efi+bounces-2303-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7767B9E67CD
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 08:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D4E16339D
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 07:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133421DC1AB;
	Fri,  6 Dec 2024 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+wG9rcY"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990E71D63D1;
	Fri,  6 Dec 2024 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469664; cv=none; b=QfeDiMMWc5Bs0wkk3k2iDmPs19vJFOuy5uQQ10oBSpu8l7bjqNFQCzslVL3uoN3tB3AMQXox7aQT0Djm7ImF8noAnb/ha8N4HYiP7Xi3EndSDIc6DIHd/ei1msZ8pmds4X4iGn3wKdKZKmYD0GUwOGNEkR+LvDnRHBMhRASU7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469664; c=relaxed/simple;
	bh=eXgkPnSuV1DLMSpxicSxCmpRMc11qSId1Ps39ZgC62E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgGs0eLziaCw/VfWhS12larD8OcwilOKczfSyb5h9dRhYsRfc0T5NRgHEbWMkf4493OE9qUZo90pxQUTG26Pw4MyydRR2weEyiRXY0jX8tUnaDB6EPNvf/kXqmEoLglnFBpZQuvUrJnhLMeLIlzwnpql6qdp6rMooeRPbcGKHWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+wG9rcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F657C4CED1;
	Fri,  6 Dec 2024 07:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733469664;
	bh=eXgkPnSuV1DLMSpxicSxCmpRMc11qSId1Ps39ZgC62E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o+wG9rcYnotlrUeuc0PL7wpQWKlXXxbgXtHgvJy7YCCwHVZ9BkccRLmauWqsz+ZV/
	 iY49BGCvaEwufLj74wUd4KOO2j4hv4jUIw8urqblrYMJBpAv6CgCbIU/8R6GyV73VK
	 9c58t+wda7Myy5qJF2WzOXzK3/BQJ0i/AkjHXsZFMr7s3vepRv5asoxKqYToTl/hYB
	 VNEio9U05OacRjqjaygqmLG9eUZQ17GF0aovEsH5OsM54NY9ccCb7HeNz79C2xEmMj
	 yLXMkRkJbjJNx0ViCQboZDxE2VKg3DG3+oa6CDnctzD5D0J8giHgftdS96ghXZOqUx
	 A94yQD2wKTalw==
Date: Fri, 6 Dec 2024 08:21:01 +0100
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
Subject: Re: [PATCH v3 04/11] driver core: Constify API device_find_child()
 then adapt for various usages
Message-ID: <7ylfj462lf6g3ej6d2cmsxadawsmajogbimi7cl4pjemb7df4h@snr73pd7vaid>
References: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
 <20241205-const_dfc_done-v3-4-1611f1486b5a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="owd7bvwanf7sxd4s"
Content-Disposition: inline
In-Reply-To: <20241205-const_dfc_done-v3-4-1611f1486b5a@quicinc.com>


--owd7bvwanf7sxd4s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 04/11] driver core: Constify API device_find_child()
 then adapt for various usages
MIME-Version: 1.0

Hello,

On Thu, Dec 05, 2024 at 08:10:13AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>=20
> Constify the following API:
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> To :
> struct device *device_find_child(struct device *dev, const void *data,
>                                  device_match_t match);
> typedef int (*device_match_t)(struct device *dev, const void *data);
> with the following reasons:
>=20
> - Protect caller's match data @*data which is for comparison and lookup
>   and the API does not actually need to modify @*data.
>=20
> - Make the API's parameters (@match)() and @data have the same type as
>   all of other device finding APIs (bus|class|driver)_find_device().
>=20
> - All kinds of existing device match functions can be directly taken
>   as the API's argument, they were exported by driver core.
>=20
> Constify the API and adapt for various existing usages by simply making
> various match functions take 'const void *' as type of match data @data.

With the discussion that a new name would ease the conversion, maybe
consider device_find_child_device() to also align the name (somewhat) to
the above mentioned (bus|class|driver)_find_device()?

Do you have a merge plan already? I guess this patch will go through
Greg's driver core tree?

Best regards
Uwe

--owd7bvwanf7sxd4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdSpdoACgkQj4D7WH0S
/k4dIQf/Zne0n0ncNUTb3GbDwFv4sf3wAVH368SbrNYMV23ZdWpNl4KZPovf5L1+
5nMlPkc2I/CBZGE2OJcZWUhHI7cZ2ZYDHBBAf/TYhsY9f0+6wXgdi2cc+bbbQpo1
JdabxMtgPX9tQ1Rbtv6jNu1AUvx8pONwQvUe5vmIBeLFDx5+wEwm4LppEVU+x9zB
dApq6D2VfLguHwMf8HDycoa0nd0GL3R4KIJF4+taiSmhz9q+yjewqiXD2ag3fYrF
1IeZ6pnyXoaq0aTwLmXXhI6se14Q+IZIVQPRXVQ5i9A8kbsWN0Fj2LfXnnNWhmHl
YR8uP+UVLcfagxTg7ascr+SuV4OlCw==
=cpdm
-----END PGP SIGNATURE-----

--owd7bvwanf7sxd4s--

