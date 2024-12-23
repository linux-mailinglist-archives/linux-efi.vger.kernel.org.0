Return-Path: <linux-efi+bounces-2432-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4519FAB10
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 08:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2EBA7A19C1
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 07:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2902D17E473;
	Mon, 23 Dec 2024 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwUNEdpV"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C327735;
	Mon, 23 Dec 2024 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734939061; cv=none; b=Q+aVccCRnfyQwoF1jwyurHa17OdnZ9NjvXJDNOy9YQyV77h4DxEah9c8lmEhz/XqveXoTop3EepqvHB/0GlWwtlhtdLGD+INRygN9gafC1EslQPbiJ9e9FW96866ach+HZ+xbbGoJJt2rXwR4zL7oL+MpH0BnF3QGE/+i8BDzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734939061; c=relaxed/simple;
	bh=Ygk6uUQxjvnjtMIv4tWwERicS++4MRefCsHhXVHUsRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZOjLR8mFzjAThfHaAqh3fQIrKm7MFq92wGYLUcAkHb6NtzZkzl+1sLUF64jab/tGfrMrwdmxtFfv+idAPmOoYpG+r2V7+jYKHyHxLWwJo/aercL/2bci/cZJcbPqrSOdmj8gEft9rpfC37NNpP2M5T381lFVYwET0MjB34MviE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwUNEdpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BFCC4CED4;
	Mon, 23 Dec 2024 07:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734939060;
	bh=Ygk6uUQxjvnjtMIv4tWwERicS++4MRefCsHhXVHUsRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UwUNEdpVksa3VeJ8fBbfU5ZM7cveMPPtJwrh5dBwK0gEoqVYDdF0NbABXvUPIJWBw
	 xCqUqJSqJL6xtKZr6qQ7jAhuhWd71QCPd5TxS1HecY9J/hvR45WyJpacDQHEAg8Nxb
	 2n3UaUf++ISc2NX01EI862mzeWJQXkc5aNu91d3n3AsdRCNSN+HKnHjEJRyLACr5nh
	 BOO26q4g07K6IBNRx5aV7gSAqtRZNsSUNg+1F39wB4XcAaYzRqeyumIAvWSZFAj19D
	 3ux6IHIQ91x+ZZx51WabplqJyaEEdtdtBHP6L6K1CKNx6HfC+4KG2P1qz8+vVZVY4x
	 5cGLrZr9Tq1ag==
Date: Mon, 23 Dec 2024 08:30:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-sound@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux1394-devel@lists.sourceforge.net, arm-scmi@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, netdev@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>, Alison Schofield <alison.schofield@intel.com>, 
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v4 04/11] driver core: Constify API device_find_child()
 then adapt for various usages
Message-ID: <mrix3q75mawxszrp25yzpsrvenlxx7bihfzyfdcnp7egubvxpf@lzp7fcaxwquc>
References: <20241211-const_dfc_done-v4-0-583cc60329df@quicinc.com>
 <20241211-const_dfc_done-v4-4-583cc60329df@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ziq55rb3fq2bwkl"
Content-Disposition: inline
In-Reply-To: <20241211-const_dfc_done-v4-4-583cc60329df@quicinc.com>


--2ziq55rb3fq2bwkl
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 04/11] driver core: Constify API device_find_child()
 then adapt for various usages
MIME-Version: 1.0

Hello,

On Wed, Dec 11, 2024 at 08:08:06AM +0800, Zijun Hu wrote:
>  drivers/pwm/core.c                     |  2 +-

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org> # for drivers/pwm

Best regards
Uwe

--2ziq55rb3fq2bwkl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdpEa8ACgkQj4D7WH0S
/k4bUAgAh9LrZmd2eRZtQQDD7RKfHIeOmRCpwZcKO4VAM76QCcEzfVerUpZH2Emh
tkSaCY38C9pM9hE0HsXsYV6zg/MBAVCwiVGbn+rgTAVtuiDiI8ygmP7cdzKnk7Ke
+l0xcXunQPwe3UHEzAvvPiu57dMcQ6h8732mqwqWrRh43gPAWdpAgktFqFLPCRQf
1sOslGEFNX866KAUqB1jjxQSZjq0v0dXyd20GSu7yjzm7s1JzRG+msGCSSxv0vRT
SWDRWVHepQ1AT5THBbY6xaXnaiwoTbnv6NCw4WFz8OHbBtIb6Fm7UUE1PNTnZM0t
qDtxzk9rG0eZFX23d+rXwSg2JlM3VQ==
=zwtk
-----END PGP SIGNATURE-----

--2ziq55rb3fq2bwkl--

