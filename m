Return-Path: <linux-efi+bounces-2200-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6759D8B24
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 18:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C525B16391E
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4451AC453;
	Mon, 25 Nov 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXBrj6Iu"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FFE191F91;
	Mon, 25 Nov 2024 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555103; cv=none; b=JGRBoeVW9qgi7LyHa+WIxRqmBjlLkyHeJvR5zs5uBJvIqDzcoo69nE+AKV8/KApoZZVYZRzfJJL2wN1aPcZ9fFnEby0tmizNG6fONi4GoAT7QN/i2e1zhp0/YPZtL/mS1wv9T9NOqP0HVLNt2mPRij1VSbWxtaxy8qchAnFLqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555103; c=relaxed/simple;
	bh=qv6niZQQLx41Nb3bAK4/DqwOTz0gNYInH/aOd0ZHP5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVPOCflx9VtmPCZCu6rCXEflUExKzsyKKPgD3mGjHmMW2nTmIdBXxdrrZ14is6eIHiDAkdTbsT4Yk0IzFelJS/JApag/JVxO8sXeRnZ13+siCtds6WU4ArEQE0AsteM6mbxpkI/ZmhuYMdtPYlwZMYyu5Kq9qbFK49xfJ6Jc7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXBrj6Iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D65FC4CECE;
	Mon, 25 Nov 2024 17:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732555101;
	bh=qv6niZQQLx41Nb3bAK4/DqwOTz0gNYInH/aOd0ZHP5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZXBrj6IuAF5G6BpBhuEPFvZZil8n3Bv9F83nD0V7elY/08uEX0qYJnG8VtJvg+rPF
	 +MQo0eziSsDuxn0oWFN9mpdGPSDmxnrI3ZyoRYDYSPn8n9IX7UJlIsXGeskah7SMi6
	 IvK8LzvP4OURw+nVdEoMVxPqEYXEXYJukbb/6ayMV7LAc2XTRgnSLoucIV/7KSZFNe
	 kR+rKUo6bJEOhCBlFzDWX9fjlSZVQOl9ed2Nd39sPgREn7GNfoYiQA9ogfIJ60JRCd
	 W2EZZRbXtog6nBqZB9HmFFzyMlteGGwm5ApheBEYUpYTaigwTexC+qf+nY+HuIWuPM
	 OibVcG8IvttDg==
Date: Mon, 25 Nov 2024 17:18:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ardb@kernel.org, sami.mujawar@arm.com, sudeep.holla@arm.com,
	pierre.gondois@arm.com, hagarhem@amazon.com,
	catalin.marinas@arm.com, will@kernel.org, guohanjun@huawei.com,
	Jonathan.Cameron@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] efi/fdt: ignore dtb when acpi option is used with
 force
Message-ID: <458d865b-5e3f-4c5b-94b3-8f4368d27677@sirena.org.uk>
References: <20241125170758.518943-1-yeoreum.yun@arm.com>
 <20241125170758.518943-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YV9P+puc7MWUbFlk"
Content-Disposition: inline
In-Reply-To: <20241125170758.518943-3-yeoreum.yun@arm.com>
X-Cookie: This bag is recyclable.


--YV9P+puc7MWUbFlk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 05:07:58PM +0000, Yeoreum Yun wrote:

>  	unsigned long fdt_addr =3D 0;
>  	unsigned long fdt_size =3D 0;
> +	bool acpi_force =3D false;
> +
>=20

Extra blank line added here.

>  	if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
> -	    efi_get_secureboot() !=3D efi_secureboot_mode_disabled) {
> +	    efi_get_secureboot() !=3D efi_secureboot_mode_disabled ||
> +			acpi_force) {

Should this line be aligned with the prior one?

The actual change looks sensible to me.

--YV9P+puc7MWUbFlk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdEsVUACgkQJNaLcl1U
h9AsWAf/QSGOqMYYd+eYGMnHrnZ0AgaaXNLrw3M3ayw57Jy3VehHfp4Mgm7JX++h
m/UHDaEswp+qVz6C1OAGrjwewp2VAkZuDckWvnQ2SjHgh3k2lWdG8yXkb1Wm6zT4
4untrM/28KHrRhsbKYdD6NXzKGyY5wO3zj0mEmo5RhZPcm++kytZASVdCsNF2auf
GQ7qGHrHxPAs9EJCHiF5FOr8mIXfvnSlRi693POc3RwX3WupYjlnfM9yoSnan01N
HfocNpYGRYXxiMN1vuDoTFWmyMM9bO1TIUzzStOIT8oJHlFmmtYmycSQpTN/J7QM
r/Y4X6sQ2Xwj3qYQXyZEH31pi/ltkg==
=NKy0
-----END PGP SIGNATURE-----

--YV9P+puc7MWUbFlk--

