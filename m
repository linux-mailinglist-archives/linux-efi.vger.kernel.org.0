Return-Path: <linux-efi+bounces-4864-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 138F3B84BED
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 15:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61CB188E7D1
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED79305045;
	Thu, 18 Sep 2025 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X00LWdf8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B2215077;
	Thu, 18 Sep 2025 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201032; cv=none; b=l01WZwZbTcVdg9qkQzSu6qnv7wauJNSukbeC9rUFlGEMYpw50b8m9y0VyOKhuUF2Ln238g+Ef5KYeB9TdIq1ElPuw93gg1hA4EX6+B6X62bK+nN3Fj8vR9ARH9vTTwotjyGnN+u+G9/Zdq1JdpHpWMl7u7WFBL6WnQ2nStmEzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201032; c=relaxed/simple;
	bh=nbHRt1g80Tq6KxsCivdMgQCmoalxk31z9fbyCiLlgTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOvqc5z2eKJE3a4WzfuhO0KjG5xcyZ18IQ7LeEJG2mFvz3xgW1MQACc0oEpQrgU0RmQ9jqeSHV5SZEEJbvXVLn3YW2U0/Vm33refaCraUgCe/gcpyBY/g1lIr+dAoXSRJ+YcDxWAXf7hh3KPUAC7hbwyg02UF8jTvQ7v99iAU4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X00LWdf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A43FC4CEFA;
	Thu, 18 Sep 2025 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758201032;
	bh=nbHRt1g80Tq6KxsCivdMgQCmoalxk31z9fbyCiLlgTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X00LWdf8Vmbatq5ziWSDyuMeuA5uxvSt/PlYi+Y50NGUn8HoFAUTK2RATLGMCE41F
	 su6J1rOyif6a6yifBnjgYrH44s0WOFkytv9JRh4Dvw/QgNVM52E9amG8PZrbyzIHb/
	 fCucCCwgHyAoSME2x91uCwbAwwXpN/+zhWNhW+B3vzSje3mhimULse2E+3vNBdruR6
	 AqVevakly8Es6a90E9YBhUxPnJddUZMoZ++STGFo4TM74QZxfuLvekGQf993vQRZTu
	 PahVawQJfirvvmyQxk6qeaSHhVs25dwe7yLqjMYEPqiSSY8pHrsIgl3SVj90sTprf1
	 1TwPTpo9gMVFg==
Date: Thu, 18 Sep 2025 14:10:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 5/8] arm64/fpsimd: Drop special handling for EFI
 runtime services
Message-ID: <19b370e4-d6a8-4a60-bc14-4adb55616040@sirena.org.uk>
References: <20250918103010.2973462-10-ardb+git@google.com>
 <20250918103010.2973462-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n4RFNxpRHdoVFDfF"
Content-Disposition: inline
In-Reply-To: <20250918103010.2973462-15-ardb+git@google.com>
X-Cookie: Victory uber allies!


--n4RFNxpRHdoVFDfF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:30:16PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>

> Now that the use of kernel mode FP/SIMD is generally permitted when IRQs
> are disabled, the only purpose served by the EFI-specific fallback code
> in fpsimd.c is the case where an EFI call occurs from hardirq or NMI
> context. No such cases are known to occur in practice, and it is
> doubtful whether calling into the EFI firmware for any reason under such
> conditions would be a good idea to begin with.
>=20
> So disallow EFI runtime services in such cases. This means all the
> fallback code can be dropped.

This is a really nice simplification, with the fixup rolled in:

Reviewed-by: Mark Brown <broonie@kernel.org>

--n4RFNxpRHdoVFDfF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjMBMIACgkQJNaLcl1U
h9CwNgf/S4B1uo0oH1Q6yqQdYUKVpBpZ3XI7rNN3zbj+UNnKfjH6Npmjv2dKzYLT
CnFUIUbnHCo4/5jyDAI/6bcGWebEjTM8CpN5j1voWCe0aA8kaHWrqAvyrahXo2fC
BROXTJofeNL/8zOFXNtoo6ziKHWlZofFjTzQftZYwWBUQGeUA7JWGVBqs8zUhzuc
W9AjAWujXp5krX0fOut0NliQFk9sqRzGhaI2+zonHk+7MLZQAUc0Te4P94AmbXrf
T3eHYO0/jfDRGHlmUuNGkRKbUac0IZiiDZPk2i9oUNFRcjDkLByTBnTiBa9i0pae
Q6y6UxvCIZazRucK4+bMDjUbNtXC2A==
=YIPb
-----END PGP SIGNATURE-----

--n4RFNxpRHdoVFDfF--

