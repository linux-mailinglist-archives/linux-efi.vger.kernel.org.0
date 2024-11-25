Return-Path: <linux-efi+bounces-2196-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4B39D89A3
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 16:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D790162690
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 15:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D477D29415;
	Mon, 25 Nov 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHgeyn6y"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F9291E;
	Mon, 25 Nov 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549730; cv=none; b=ABjntcsblD7J/whJREYxZveLPSIuVOBsiOF1pF37/n0+RqFlbjdgg7cAL7xfKQfpfNdhfZN2ZPX/ZG91fezrGKuDKydulVS/894fUCbbRGU5q0aOdsy5Bx/uMRngdgU3VC76FnYZJspUEXzv/6kgEfvINIvzB0KPXcRPfzLjuQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549730; c=relaxed/simple;
	bh=Jb/Nq2waVTH1amIlog0YhIHHgr3jAVLm6cbL0GKgILo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVOKFlLc0SiDt+B3Ibbp8LM3EWRR4C4qyIpUsVTcOF2MSPfSKjgUsjbNNUt8TwpGIQN0AeRsFk9roIFLaTKp4dw9H7Eb38zBuYbx0MWb7lAj7F5TdROxSDCJRhlD52WoErWjuDK0tlcMhxmhLZWYVec4p6yok5e2QV9MUDqqkSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHgeyn6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F35AC4CECE;
	Mon, 25 Nov 2024 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732549730;
	bh=Jb/Nq2waVTH1amIlog0YhIHHgr3jAVLm6cbL0GKgILo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IHgeyn6yO0S1PnqKQRn16ps0yWms0cpUjYN40YLAltVL66O1BhyMVRH/Z+Xeaz1D6
	 QrfSFpFUE2jVsCZrCbCrF92geoGZsj8300zP7uCrT2rx4JY7QFddTvQb/VAHUYO7cA
	 0iwKBJFxyoyau2gHgm2eYSFx3LnqCWDgX2iExLw+3Upt0diTG0C0VfZ5WKg5iCSw6C
	 SuaxL6I/dyoZuZe8zFBn1gFdLdv+K7jRszuq8JMKJov+ABtX5U+zdORh8Rm8Ra/ZDQ
	 nl6V8Nn9j/CdzIMgg3msaCGSQGJlcmSkJ6gh9zg00Mz8aTImwMvAMjRjk3fj5p1Wkl
	 cteX+Ng594+AA==
Date: Mon, 25 Nov 2024 15:48:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
	guohanjun@huawei.com, gshan@redhat.com, prarit@redhat.com,
	Jonathan.Cameron@huawei.com, dwmw@amazon.co.uk, ardb@kernel.org,
	hagarhem@amazon.com, linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH 1/2] arm64/acpi: panic when failed to init acpi table
 with acpi=force option
Message-ID: <4c8e92ac-1e16-4d0f-8710-96a167d75d97@sirena.org.uk>
References: <20241125145848.506347-1-yeoreum.yun@arm.com>
 <20241125145848.506347-2-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nrxKW/jgHeBrIHYk"
Content-Disposition: inline
In-Reply-To: <20241125145848.506347-2-yeoreum.yun@arm.com>
X-Cookie: This bag is recyclable.


--nrxKW/jgHeBrIHYk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 25, 2024 at 02:58:47PM +0000, Yeoreum Yun wrote:

> when the acpi=force option is used,
> the system does not fall back to the device tree (DT).
> If it fails to initialize the ACPI table, it cannot proceed further.
> In such cases, the system should invoke panic() to avoid contradicting
> the user's explicit intent, as failing or
> proceeding with unintended behavior would violate their wishes.

This makes sense to me:

Reviewed-by: Mark Brown <broonie@kernel.org>

--nrxKW/jgHeBrIHYk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdEnFsACgkQJNaLcl1U
h9BoiQf9E4P/46IN4hopKj75eay7kahmNncSYrOyfwgfTPR/lXVrTdqs3+yA0AQM
NXmioMTbFo07sWI6RLLZP32VPcTGS/Q7pJS6KThRhsOgqKc9FOfU6DDTcSDmceXq
mhbIz3MDvFuzXJc56oBcpEtD6ZkpZIfihSsdrXDXS8G/GTW6dnoglQoaFEoJuPY6
Hn78P46ynaz0Q8C10qldRrcfBi/EcfiLNmAhn7KX4ZwBdyLLX5Mw8y5LwpITtTHb
Q3ISd1I0ltakdhUZ44AHH3h7kPXZIMkCK7rPnuWLzJKC85YTcqNDrIpo/nTcJzX9
hu9gHBBtLO0iRyYYLjZnCrlsEnSAoQ==
=N3Jw
-----END PGP SIGNATURE-----

--nrxKW/jgHeBrIHYk--

