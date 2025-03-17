Return-Path: <linux-efi+bounces-3006-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF2EA652D4
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 15:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C5518850DC
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFEF23F438;
	Mon, 17 Mar 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5RIiOEC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DFF38DEC;
	Mon, 17 Mar 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221265; cv=none; b=LXvr1awAGmwCgu4Kbg7BdKcg5VB7YAoC8Ayb/gs1mELLuZZY43r0QPg3R+kb6j6hKj82vRKafg/cRjr2ukHvrZyAkEMfR/Wnz0ST0Qmj/r9EuXIuBsH4jdW1YoDOs3JJp0sDn8VTXCv5BprL0VgIz4rF+Qn7/0qVSP/ppQFEToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221265; c=relaxed/simple;
	bh=TAMZO+Www2JXyEzVnkPyMCDlKAnsJn0Ra9/i84lCzU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImGclvEXrIEZ7rmOE8UPVViltMQowzdNlkhVn5JlPE5+deyucIrSmgCtr72TtLo4rleWo8QqRC3OMFN4ncvIhRfl9c3ZyiMXZ+fkPe5Inf6Sz5iQ+qLDSsSlDEbtvt3sWlhOixwxqYAhiD6m/etlk8fKWEvJL3iRknqy+VIWYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5RIiOEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF198C4CEE3;
	Mon, 17 Mar 2025 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742221265;
	bh=TAMZO+Www2JXyEzVnkPyMCDlKAnsJn0Ra9/i84lCzU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5RIiOECnb6LikTPnK6WERMaIGdBYP74g15Dw9IDaRyga31AvzNbL9Ub6VbrItoZi
	 AiSpVG60ZnpTuCjJjbgDO+Q/Sh8vdGcU8DQzkYISRqcZ5upfvnubcqKV2mkA9hAkDC
	 y/6neFTYR6OFo7co4+iuLQYsmLL3aJgRya74lMmMwla7wMw4uTi7kfx+MU5ssJ/mQg
	 9pWmyqPDk44U+Q5JiSMTAo36yKOZqHofAe2UXHEdqEuVu8O/gp0c38v/+H+dd2hLOl
	 5NG3qq4xHnNOYhvNB6XVCOh0RCtOYhpO/+LYz5RG54S0DODRrMq9b2lXDoqVhVnGX/
	 2/9E4tXepoZrA==
Date: Mon, 17 Mar 2025 14:20:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/9] drivers: Transition to the faux device interface
Message-ID: <b13eb5b3-198e-43e3-831a-45172e9975e9@sirena.org.uk>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PFsotoYFiaefK9IS"
Content-Disposition: inline
In-Reply-To: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!


--PFsotoYFiaefK9IS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 17, 2025 at 10:13:12AM +0000, Sudeep Holla wrote:

> All the patches are independent of each other.

If that's the case don't send them in a series, it makes things more
complicated to apply and the CCs cause more mail.  Split independent
things up by subsystem.

--PFsotoYFiaefK9IS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfYL8kACgkQJNaLcl1U
h9Brtgf/ed8/iheDRmn5QcrxD/Fq2JDB0jFynURxgNQDHy+TfIECBMxr4+ouEvh0
6BYWqGbAjfU+qCRpcQM+3aIA/MyFE8Ckz6XBD3PkopN9hUwfkaBifc3cZLtPeeap
OINXiEIOTl/jV4+0xkx0PVsCUy1BXiXCgfReCECnjB3tQxMEYZM5dFxgNYHq125y
8VIE6wPZd2RtOg12Yg8I4++7o1vI8MP03+hy3P8HEmrzubZ8P/2t52y8OmWaQekJ
9leSB9QSiycWUZ61emRRcVl6GzExoNf4mvPBTNuWEMFrUAD8AmU7AVtjddGPnSrx
XFpbyUiXwtvodfzzg6B0KEx5kU9WEQ==
=ALbI
-----END PGP SIGNATURE-----

--PFsotoYFiaefK9IS--

