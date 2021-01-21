Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B35E2FECD3
	for <lists+linux-efi@lfdr.de>; Thu, 21 Jan 2021 15:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbhAUOZO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Jan 2021 09:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729321AbhAUOZC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 21 Jan 2021 09:25:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AFB8239D1;
        Thu, 21 Jan 2021 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611239061;
        bh=kv/pVGLXQi9SIxQZUvMuUQoER4ZiAqUomytKzezlGnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vDYTKC9hSClRzYZmczK2R8BY79Lab3Orwuve5YD1pgCp490UjBy8JkOsc84Urxuu/
         qr5Epy/m42uLfvRCYCYUA6VN4I4iEsJOA7/5sjAEtRIK1RBvyirRtpRfXVv552CUM5
         v2lamAIMN7Lsg7P/AsOgqilgH4YuKEfKz3g2axmBR/inX5knruS7iiwKS8yJNn4a7a
         ut47+sA7cn7X4YCj3MveUgkg3vj5e58wFIROjzP+LbZ/QvLsfz2sdRDY2aJysPSo6g
         c/hTcdA1iiSksiX0bAg+uJSezy6l5faY7rPR7SdbQaDyVQgndGx8IqsGlWDZQ9Ncez
         qM6CBMq/t16Qw==
Date:   Thu, 21 Jan 2021 14:23:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
Message-ID: <20210121142342.GD4588@sirena.org.uk>
References: <20210120173800.1660730-1-jthierry@redhat.com>
 <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
 <186bb660-6e70-6bbf-4e96-1894799c79ce@redhat.com>
 <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
 <6e21cd51-017e-2135-ed9d-33a60f22a457@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
In-Reply-To: <6e21cd51-017e-2135-ed9d-33a60f22a457@redhat.com>
X-Cookie: Generic Fortune.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 21, 2021 at 02:23:53PM +0100, Julien Thierry wrote:
> On 1/21/21 12:08 PM, Ard Biesheuvel wrote:

> > I am not aware of any plans to enable this in GCC, but the Clang
> > implementation is definitely intended for production use (it's a CFI
> > feature for ROP/JOP mitigation)

> I think most people interested in livepatching are using GCC built kernels,
> but I could be mistaken (althought in the long run, both compilers should be
> supported, and yes, I realize the objtool solution currently only would
> support GCC).

There definitely seem to be some users interested in both livepatch and
clang built kernels so it might come up relatively quickly.

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAJjm4ACgkQJNaLcl1U
h9A9zgf8DemVKmPSSW3tOaAAroHKKGZKezs9pF8k8n+yoIghmXnPxd9hrb57ukiw
4tsd0Hdo6TGipkLTKBKf1YiRzEVmMaaskDpl8Fw3nLEswci00beU+AFOF2j67W2Q
e6BgBsvxeLbZ3Ga2JDUOFmkAWgHxfb2uPzDcMMWK4kv7aULZuRnaZkK01atGNiEI
ApztA5bVxoXBfhtWTDi7mG6Z7fq90/TBnCEkSWAT8xZvzxVCZUlAOBGamkYTmJUx
VEebhpacGYMGST8NW/C2AUCOfeYnGIDHpcVipkh49EjelaASMZxmnzF8mQfH6n2B
Sly4xPl4R9faZqsqEKsXDfh0uKAbQQ==
=CROq
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
