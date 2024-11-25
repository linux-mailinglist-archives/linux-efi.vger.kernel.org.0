Return-Path: <linux-efi+bounces-2203-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79269D8B78
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 18:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7E9280CA2
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 17:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D021B652B;
	Mon, 25 Nov 2024 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWVhjoTd"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5AE14D43D;
	Mon, 25 Nov 2024 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556513; cv=none; b=T3InPYokIm9apMXN/v1c49YMHZAvTFRbC+02yy7NBXWFkZiPAa2ucJD9l2dYsbq6zUyH//lAzE/ew6goLMFiPiib+aPH2Kb/dC/k9xqlIlFtfaIpSniFQz+w9ruafDtPqb+oHiUR6Fev/Y0L2SRFpM0OUN5qdmIU+cdLiMONvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556513; c=relaxed/simple;
	bh=HchR7eqLEhGdO5syyKmCBTdvwApjTTWJf4CXSLg7iYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCy0RgxdLi0AskrVnsKooixilgVbarSHxDaU8v+aIkhRh1q7fF7pSB/bHRGCRFyO40Lnb9gcPC+36h01D7735RIUjjLe6sW2207KaVOZNyazKzBxSE5eHNbPoO97JCTe+z2FlFP/Lb5yxQzX494CKl7j4pCmEtZslwFLT+efafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWVhjoTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F6BC4CECE;
	Mon, 25 Nov 2024 17:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732556512;
	bh=HchR7eqLEhGdO5syyKmCBTdvwApjTTWJf4CXSLg7iYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWVhjoTdSNKsn5Lj7hc2ilrvggXa8jSSI+Oo4tgKNpU5RBv6rWn985Ah+cLcEtAWD
	 3/aWfAam33Lj3TfVBYKBLJG2tG8mazASWzVvHaGps3BaxH86NdvjQ6uvqLZm6g2cl2
	 m7R5y0I6xA17vPl0eZ1DNRgbFU79F3An+qlToksJ41ZL5wsMsq7qzwmer8j+LF2s8V
	 rjME5hAXGSdzr7T4OkxVQTZRGFzf1kNVsRNuXo2Xt5gD9TDvU2+5G0i4h1H5J/NXGv
	 nqm65D43x1vqZoz8aTgxb6S1zUgpxGXdtm0I/DPEA8H9jEKpD+sQ5Im24NJGpRv9IZ
	 mctRu3wpTufKw==
Date: Mon, 25 Nov 2024 17:41:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, sami.mujawar@arm.com,
	sudeep.holla@arm.com, pierre.gondois@arm.com, hagarhem@amazon.com,
	catalin.marinas@arm.com, will@kernel.org, guohanjun@huawei.com,
	Jonathan.Cameron@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64/acpi: panic when failed to init acpi table
 with acpi=force option
Message-ID: <bcd83518-8652-409e-b614-30edab6f9b16@sirena.org.uk>
References: <20241125170758.518943-1-yeoreum.yun@arm.com>
 <20241125170758.518943-2-yeoreum.yun@arm.com>
 <CAMj1kXGBnYQi05qh0QZk2hVLjVhS774-nT=HLdL_kW1d7nxMVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hHRh/nwM6yH7lXJH"
Content-Disposition: inline
In-Reply-To: <CAMj1kXGBnYQi05qh0QZk2hVLjVhS774-nT=HLdL_kW1d7nxMVg@mail.gmail.com>
X-Cookie: This bag is recyclable.


--hHRh/nwM6yH7lXJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 25, 2024 at 06:30:06PM +0100, Ard Biesheuvel wrote:
> On Mon, 25 Nov 2024 at 18:08, Yeoreum Yun <yeoreum.yun@arm.com> wrote:

> > when the acpi=force option is used,
> > the system does not fall back to the device tree (DT).
> > If it fails to initialize the ACPI table, it cannot proceed further.
> > In such cases, the system should invoke panic() to avoid contradicting
> > the user's explicit intent, as failing or
> > proceeding with unintended behavior would violate their wishes.

> Calling panic() at this point does not achieve anything useful,
> though. Without ACPI tables or a DT, the only way to observe this
> panic message is by using earlycon= with an explicit MMIO address, and
> it might be better to limp on instead. Is there anything bad that
> might happen because of this, other than the user's wishes getting
> violated?

It does rather depend why the user specified acpi=force, it's kind of an
unusual thing to specify on most systems...

--hHRh/nwM6yH7lXJH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdEttoACgkQJNaLcl1U
h9DzsQf+IGMIeshhv77ZAquZomdaxPmEtaA6sYAZAjvbcbHh3BECtKQT594GUARe
l/ju3Ag+xrsZEUqjoZqwdBaI/EZ7S8IIO3syZOz+nEN+sDQ2uyGMNyPR9MkxUWjT
0114DNTF3uc0w+Jb6mAxg8WzL7xK1B59hfnpOomc/wHeAiQeBc49EAViE4eKUYRb
4csUE7hcUdoS9uL5VEt6tbTcn4HWpe8zsM4wf3F1bjzpadmVMIkzWYHDZZULwDfC
9T05CbGuMipEmhtC2OOI5EwOYlt5LHN8CgG+TElPNWV8UzMetEqNGnZ8209SQrav
oi4SPhn+5DSyI5CiF/yvqhNgkha8Wg==
=M7LL
-----END PGP SIGNATURE-----

--hHRh/nwM6yH7lXJH--

