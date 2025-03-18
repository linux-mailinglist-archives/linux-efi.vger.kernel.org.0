Return-Path: <linux-efi+bounces-3020-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A2A67633
	for <lists+linux-efi@lfdr.de>; Tue, 18 Mar 2025 15:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97D3164308
	for <lists+linux-efi@lfdr.de>; Tue, 18 Mar 2025 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9F620DD43;
	Tue, 18 Mar 2025 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTOZSFIY"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1736620D512
	for <linux-efi@vger.kernel.org>; Tue, 18 Mar 2025 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307680; cv=none; b=Cvf+md1qYsZv/hA7bjsXCQuvzovh4fQmynpTO0PmL6CioIbq7kYaKAny41WYuqDdz927AURR0mG4VWpWcsewxRuT2ioVmUDDOlOJF4rzlZ6ogzqBU/Mdnf4asLHY1tIxmrCfqVCYC4BOfbwm3LUlvXhLRuVq1AZ/EjeX6s2eJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307680; c=relaxed/simple;
	bh=Ih+kjkB7HKftfOjJe1nJYGQMWvErtDZ2Ypbjozb7+Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThrfUDoLKgZOJlqAU9TDum7mqznVPehxbj20mTXuFMDvhrUD5/s2ix5Og0A2DFUK3FaO0xrZ7yakOq8g95OLiYsYx+rrRYKjOOD+VYEjUWJxeMsxUOfZuJUkd/vsetT0mYU9AFIE247YpgkVjz92/PrL3Rby3x3DnlTc1+7M/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTOZSFIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADEBC4CEE3;
	Tue, 18 Mar 2025 14:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742307679;
	bh=Ih+kjkB7HKftfOjJe1nJYGQMWvErtDZ2Ypbjozb7+Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTOZSFIYyX4n2viWiXOPRLbe7cOlKQoYEyx4++tXXnSh11s2TIgIG9lTrVI/dOW0T
	 CqNIrmtree5/5qmJp22ICP3ZbHhS79vd816AstF39zWWRz8skAc2mboh7dyE8lKRCU
	 BIa07t42gaVyx2LIG8htwSy8y7FiSwFDUqbDvlWWdw6TBJQyn+kYJG4iQs+wyOCz45
	 0/0C0XPuLXI+4wGkfq0GZ57h057HQ83ELNJERjyHuXMNaOizlrvqvzs8GDm/o0khpy
	 ciqrOrpMHNLOq2eJHUQRO/HYeg2yJLvpQcPyb+yjyjHsAPZNX6yKOiIMgn9KikRyQc
	 dCGwl0xt/RhxA==
Date: Tue, 18 Mar 2025 14:21:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] arm64/fpsimd: Avoid unnecessary per-CPU buffers for EFI
 runtime calls
Message-ID: <5c025dd9-8a4a-4ebb-a2ae-ef55538cd39a@sirena.org.uk>
References: <20250318132421.3155799-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D4TwUy0V5R+g16wD"
Content-Disposition: inline
In-Reply-To: <20250318132421.3155799-2-ardb+git@google.com>
X-Cookie: Swim at your own risk.


--D4TwUy0V5R+g16wD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 02:24:22PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>=20
> The EFI specification has some elaborate rules about which runtime
> services may be called while another runtime service call is already in
> progress. In Linux, however, for simplicity, all EFI runtime service
> invocations are serialized via the efi_runtime_lock semaphore.

> This implies that calls to the helper pair arch_efi_call_virt_setup()
> and arch_efi_call_virt_teardown() are serialized too, and are guaranteed
> not to nest.  Furthermore, the arm64 arch code has its own spinlock to
> serialize use of the EFI runtime stack, of which only a single instance
> exists.

> This all means that the FP/SIMD and SVE state preserve/restore logic in
> __efi_fpsimd_begin() and __efi_fpsimd_end() are also serialized, and
> only a single instance of the associated per-CPU variables can ever be
> in use at the same time. There is therefore no need at all for per-CPU
> variables here, and they can all be replaced with singleton instances.
> This saves a non-trivial amount of memory on systems with many CPUs.

That makes life a lot easier all round, and like you say the memory
savings are nice.

Reviewed-by: Mark Brown <broonie@kernel.org>

> -		if (system_supports_sve() && likely(efi_sve_state)) {
> -			char *sve_state =3D this_cpu_ptr(efi_sve_state);
> +		if (system_supports_sve() && efi_sve_state !=3D NULL) {

The change does remove a bunch of these likely() annotations, though the
chances that they were ever having an impact seem minimal.

--D4TwUy0V5R+g16wD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfZgVkACgkQJNaLcl1U
h9CldQf9FlFtjzkirikfCb0Vd42eMQeijVyahtTwrU87pGcUvnxsvvAWDpXfP9G/
hWwlxfclGwHVdBTWm3gbvS/iuUTR8oL1SDlw9/dIPjgO8AWVsx62UWZGQjC0llLm
2ZIAlszTrGNMwuygljlt34KnKUucNXAis9CDXwfX+rfs2/SHXLH0YjBA390NqSUx
I3UJJvAJperIRdmf1fvGY91OZX4Hmj46NtOXOIcB53Edi0RPTGBEFe015XNLUOe3
CcHduHg2hOWWIPnoDk/6NxP1KbG6Z2yQ7fwwFRk37NFlg3stm1y1YozeqX3wtJLy
bybq3apM5TvtBtPrmfcCYYZnO6qEXw==
=tgZs
-----END PGP SIGNATURE-----

--D4TwUy0V5R+g16wD--

