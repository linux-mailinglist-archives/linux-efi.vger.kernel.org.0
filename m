Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500DA30DA97
	for <lists+linux-efi@lfdr.de>; Wed,  3 Feb 2021 14:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhBCNGZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Feb 2021 08:06:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhBCNGY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 3 Feb 2021 08:06:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89FE964E38;
        Wed,  3 Feb 2021 13:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612357542;
        bh=OSBHuUI8og5Vfp1FBOELDBA9lFmC6WOrg2hzohSc4Ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bE3VV0lsArjMZgba11em/bAn62/vpuKCIk3rBNO0syg2HdcvQ7i/ApMC6sC5QKKCV
         WDQE7DA5yWLZxF8/CTMufJKH9eifbJslYZ7ZRHtuY1y5m3WuoiW+AfmhJQKoUOlKRq
         TSHLPkiWb1BPJxPlnX2BjP4m5ocPnsl2HsZGu/GSSQRtOU4SM4HflfziC8yYMeV6OO
         yzvFKIaHdXMBIzrmWVJsAClnGAqh5wJqScIOKN1GeDC2cprQg9Ynw2sqzJ+CgN6XUn
         aKS/0P//pyCfY/ymysil2/T1msQSjHlso2GZBNGlqp+mAEWEEII72CAcRf+sZlyyXH
         DBUEofTmHtYfw==
Date:   Wed, 3 Feb 2021 13:04:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>, raphael.gault@arm.com,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Bill Wendling <morbo@google.com>, swine@google.com,
        yonghyun@google.com
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
Message-ID: <20210203130453.GB4880@sirena.org.uk>
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com>
 <20210127232651.rj3mo7c2oqh4ytsr@treble>
 <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
 <20210201214423.dhsma73k7ccscovm@treble>
 <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
 <671f1aa9-975e-1bda-6768-259adbdc24c8@redhat.com>
 <CAKwvOdkqWyDbAvMJAd6gkc2QAEL7DiZg6_uRJ6NUE4tCip4Jvw@mail.gmail.com>
 <20210203001414.idjrcrki7wmhndre@treble>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <20210203001414.idjrcrki7wmhndre@treble>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 02, 2021 at 06:14:14PM -0600, Josh Poimboeuf wrote:
> On Tue, Feb 02, 2021 at 03:01:22PM -0800, Nick Desaulniers wrote:

> > I wonder if PAC or BTI also make this slightly more complex?  PAC at
> > least has implications for unwinders, IIUC.

> What is PAC/BTI?

PAC and BTI are ARM architecture extensions.  PAC uses a tag in pointers
to sign and verify them, presenting a barrier to ROP, and when BTI is
active only specific instructions can be branched to.  Since PAC
modifies pointers when it is active the unwinder has to undo the tagging
to understand what's being pointed to, that's already there.

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAan3UACgkQJNaLcl1U
h9CR6Af/a+hTHn/OAxEoRg8U3FQ8sbGU1efy2c412xJU7ZqPnGW5l96P6lNt4mXY
85GyLjKkQYBjZkC4t20+ug13zhghrfPoQt6sN+8nBjswZiOPqd/Zpwsznos8Eut/
8On39npKp4ur2GziLiDkTXZT77zknCoDVtH/gpEhAURL7mDcnhmesHIqEKcgbM9S
3WvuL6K8FFnXfECt09m1s6qP8jD9h/l4CV6dIhz/Ievk6hLOpX4ucTcJGVduTqjv
qa5xuLBioxKOC5PHo0iob9HaJClu9F5vCyPj8RdTxsyJs0TO6pW299UemUoOj40T
Dw4EtudvTIp662frrw8FTbvr930r3Q==
=DA8Q
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
