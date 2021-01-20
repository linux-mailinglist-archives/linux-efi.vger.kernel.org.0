Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA2A2FD5BA
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 17:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403919AbhATQbz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 11:31:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404050AbhATQ3U (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 Jan 2021 11:29:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0960233F6;
        Wed, 20 Jan 2021 16:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611160118;
        bh=pTi96qz0vTR1SjLoc2U24l/17u/IXMSc/mQyHkDQVmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CBYKAcXPigHsGKGCrTc0Flxv5bmjOQIxydFAwQlznQb3wF/RKlkQp7N7p50iP4uFa
         L3vOVzAYqMV0oCYxbWGxJ2Y0wt0sL+dXJBgSi/9DM5OoowAYJLinmjxeeJZSMiwXzL
         Cf8I7+jNBN/tNoTnZn1Kku8SqVcoJZ2E8m/zw2OEm7HBSp0Bg2kyV4nUqjEwfKBEf2
         E3NYkVGXbT1U7uj8w7cI6unz4+2JRcuHnnugHHguHDVaUQAj/kiDuFpSq7scnPv7pW
         IPme/oVabwHG3J2t3/m5b0ZvtGuRs/+VAbDfjLN/FFm49eAW7XwQbRH5OYZxd5+xwY
         1SWSeA3x6NSoQ==
Date:   Wed, 20 Jan 2021 16:28:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] efi/arm64: Update debug prints to reflect other entropy
 sources
Message-ID: <20210120162800.GC6794@sirena.org.uk>
References: <20210119170742.20969-1-broonie@kernel.org>
 <CAMj1kXEryUp9eo3cufS2G+=zBdqNbLUwGTzYjLQGBx1EtXeRTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <CAMj1kXEryUp9eo3cufS2G+=zBdqNbLUwGTzYjLQGBx1EtXeRTQ@mail.gmail.com>
X-Cookie: Beware of Bigfoot!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 20, 2021 at 09:39:27AM +0100, Ard Biesheuvel wrote:

> The EFI stub randomizes the physical placement of the kernel as well,
> and this is no longer possible by the time we reach early_kaslr_init()
> in the kernel proper, so this is not something RNDR et al can make up
> for.

Ah, I'd not seen that the stub also did physical randomization.

> So perhaps change this to 'physical placement will not be randomized'
> or something along those lines? Or alternatively, just remove the
> second part of the sentence - we have better reporting of the KASLR
> state now anyway.

Probably easier to just remove it rather than bikeshed the log message,
it flags the error and avoids the issue I was seeing where the
diagnostics in the boot log claimed that we had both disabled and
enabled KASLR (quantum KASLR!).

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAIWg8ACgkQJNaLcl1U
h9DMtQf9E3ju39j4bLrGE8ua3xY+WOL4NBEbV9yT0RxAP0MiBcXLl0xxds0f4e/h
/HxvNBxZxmoM/+Aq9AV2r5zZYM+ts44S0O5Fn98hx61CqzSFZXQhzxZR/3jQrSRu
UNfWen8bld/mnFnQ7v36F826p8sWI8+U1eJs3vbmOtbuuefRrbLIxmqd2cTZPiu3
2rqvXPoYIfhJEZsHJcFL9z28iy6Q3CqdDxkm4sstxlIkvjpP9v1zIee7nkDtMEf0
TRqBPpYLuZ2YBjMY46cncVCxmuE+e7qIYzYWAA3vMpd/Fx/8/px034l3EzDgFqjS
DFAqB5ehqZgvqOHFs+wD8BfYPrjyWQ==
=Zruv
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
