Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2892C300A1B
	for <lists+linux-efi@lfdr.de>; Fri, 22 Jan 2021 18:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbhAVRpk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Jan 2021 12:45:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729636AbhAVRpG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 22 Jan 2021 12:45:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A71E23A68;
        Fri, 22 Jan 2021 17:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611337462;
        bh=Fbw7hbg4eFinWbI+ufZKhLlJam1o9Uua400X/NfxFCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tX8UzS/eD1cr7yrQUJIL18lkdaJbV4NkcQq6ejfOaQuFv2hdvx2Dk2NxHKCELL+tm
         gB5LH/E2jHzoODl+l5pC9LnH4BX3C8cNb+HMFLlzVvs2z9GeO5N2HamAgsoag69397
         xM9GyS+b9vSwcmDLtnJqh2UqiyZe/LtRxD0SvL15ZIehVGJ/1nwh5tcC5zdIfDSuTg
         UA9DbMktYrr+7xDQjw+RV13CbEuXa78wQrGoTQX5eF7DP8NsrLjY+eWMkokeOdrx4s
         IdtW124T7EH7s2t0LQV2LfAo+FSU6r0qSwCHNJSxp+ByPvpWcJ+fa8vzlsM7HV6JE0
         Wj6V1sT2vNblg==
Date:   Fri, 22 Jan 2021 17:43:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
Message-ID: <20210122174342.GG6391@sirena.org.uk>
References: <20210120173800.1660730-1-jthierry@redhat.com>
 <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
 <186bb660-6e70-6bbf-4e96-1894799c79ce@redhat.com>
 <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
 <YAlkOFwkb6/hFm1Q@hirez.programming.kicks-ass.net>
 <CAMj1kXE+675mbS66kteKHNfcrco84WTaEL6ncVkkV7tQgbMpFw@mail.gmail.com>
 <20210121185452.fxoz4ehqfv75bdzq@treble>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Content-Disposition: inline
In-Reply-To: <20210121185452.fxoz4ehqfv75bdzq@treble>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 21, 2021 at 12:54:52PM -0600, Josh Poimboeuf wrote:

> 2) The shadow stack idea sounds promising -- how hard would it be to
>    make a prototype reliable unwinder?

In theory it doesn't look too hard and I can't see a particular reason
not to try doing this - there's going to be edge cases but hopefully for
reliable stack trace they're all in areas where we would be happy to
just decide the stack isn't reliable anyway, things like nesting which
allocates separate shadow stacks for each nested level for example.
I'll take a look.

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmALDs0ACgkQJNaLcl1U
h9D+zggAgtOONPllLfslr6X/wB/43FjYYsgGfKtPctsQgrbSMbqrDXOu8z6jJTT9
WfzvJoic373/eZzXRIu2mQIAjMNLC9bsYKFSjL3YdM4QN17TuvxyawY6GTMi+7HK
p+wANJD/JE0Hze6QtsM4uyVUd3t16oHVTaJ7wn7bc9CThv4wtj7BMD7Lrj98OGJ2
BDwZKSWLroBkd1DBUdEnS1ROAlVq/QFvZ6VcqbrFobcsGsSoBiC9XgpEYzF68cW9
ywYhjF1o3mdhCtJF2actzFz6at/aWkfGWa0O93EZsRjON6DEklJLMVBf2ylexGBY
MoROeAM/bDf4oj3hrKxGNKy4Zm+C6w==
=6hN/
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
