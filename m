Return-Path: <linux-efi+bounces-2290-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853CC9E52C0
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 11:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C75618813DF
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 10:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354911F8AC0;
	Thu,  5 Dec 2024 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnMLmm3t"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E81D63C7;
	Thu,  5 Dec 2024 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395320; cv=none; b=Q+bdYvbVHfK5izp5vVwzXUbLwdp206/jX08VmwRn1JljuzKBzAby/0d3rOe9gDEUJtW7pkCYr/3nfq1j4spwfYmrfgTy9o27twMsPuDkggzVRuKjjIZA9/xEO5IPZ/NOF0PhqqpCF4RD+x/CNitcKj+9QM/JfgPtsN+AuN3n8Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395320; c=relaxed/simple;
	bh=NZpLIj+aF6yV18wyiV+hZZsvH1NLZeOx7bLmfti8dgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCI9FrCK1VolvGDDZF4jeniyUIGQJAs2fyqalzv26BVCawgEzBN9F3DsziPVUT5euLx1agvK+uiPgDTVVwnZ29k/wvMXcShqas862dywiD+B9FtuQyO+2ttuWcKzTBadFdtqHkmga2CqUnXArfKX713jAIfxJWoEEBY2Xx0ko5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnMLmm3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73D7C4CED1;
	Thu,  5 Dec 2024 10:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733395319;
	bh=NZpLIj+aF6yV18wyiV+hZZsvH1NLZeOx7bLmfti8dgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VnMLmm3tlYwB1Ys4r5Vn/PjbwurVtHQJbu2Sp9+upCl8vyYMiKZJtRNZi9p41s3dd
	 +QwXcCDWaVNsFDd7tYDQKJycBt3wIkC592WOq5c2OCWOox4WrIqAu/bKBeyRsi9N93
	 T1aLVwyzqHihZ94hruw1akFGxr+cDy3yHC2zrIbMFU3LuOjZrbl8eYf2Xf9teq8jxz
	 2r20V8p90hvV6R/o7HM9bEiRQkiL/bJUld2qbg2DALga5ZVfRhhR8QSVihRYtnbPZN
	 Wqeewe7ZalHOUg6pZrwnuZb9WoFgbLJW6wGDJL2UxBTqsu9BZIZAp8fWpe9+R5mTX7
	 45eztKwfLgngQ==
Date: Thu, 5 Dec 2024 11:41:56 +0100
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
Message-ID: <h4pndknfwvck5yjnbs5rdmrxkqeksfxldwj4qbjqyvdzs5cjbf@i4afsjsg3obw>
References: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
 <20241205-const_dfc_done-v3-4-1611f1486b5a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7cmlxza5fdv22slz"
Content-Disposition: inline
In-Reply-To: <20241205-const_dfc_done-v3-4-1611f1486b5a@quicinc.com>


--7cmlxza5fdv22slz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 04/11] driver core: Constify API device_find_child()
 then adapt for various usages
MIME-Version: 1.0

On Thu, Dec 05, 2024 at 08:10:13AM +0800, Zijun Hu wrote:
> diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
> index 07933d75ac815160a2580dce39fde7653a9502e1..1a1a9d6b8f2e8dfedefafde84=
6315a06a167fbfb 100644
> --- a/arch/sparc/kernel/vio.c
> +++ b/arch/sparc/kernel/vio.c
> @@ -419,13 +419,13 @@ struct vio_remove_node_data {
>  	u64 node;
>  };
> =20
> -static int vio_md_node_match(struct device *dev, void *arg)
> +static int vio_md_node_match(struct device *dev, const void *arg)
>  {
>  	struct vio_dev *vdev =3D to_vio_dev(dev);
> -	struct vio_remove_node_data *node_data;
> +	const struct vio_remove_node_data *node_data;
>  	u64 node;
> =20
> -	node_data =3D (struct vio_remove_node_data *)arg;
> +	node_data =3D (const struct vio_remove_node_data *)arg;

You can just drop the cast here. But maybe that is better be done i a
separate change.

>  	node =3D vio_vdev_node(node_data->hp, vdev);
> =20

Best regards
Uwe

--7cmlxza5fdv22slz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdRg3IACgkQj4D7WH0S
/k6XGAf6Av8yk2DAhSYXPrLn/Ud4m0Je4HKR7wDERTkoucUo/owwlaJH19v3/SEN
BoXiIS4oqDNVJbzYsEPr2ZJQLZUTvBMyzKLJ4oNU1RzaivgdSipCPyK6I0OAHNui
CtQI8qTG+gSxHLhoEeFCl2kcnUCtV4nGeXk44by5/Mu3CkC/pXRfbRn7iLrDX34F
XHQ9MMrA6tMoRuStbxo3xHkRI7CkjOJVO6hWgv6PPAoKdFb63QX7jdTrZQTIoNtP
2SMqVunbF87nTNTOQZWDCN1E3vELVsVjs6YsrlJeMYI9Gs7tcbVD4OHKUvrtSf86
UHoREl5N4LOf8l+HqvTaxQnH6pb+QQ==
=qufa
-----END PGP SIGNATURE-----

--7cmlxza5fdv22slz--

