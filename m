Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05ACC24BE06
	for <lists+linux-efi@lfdr.de>; Thu, 20 Aug 2020 15:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgHTNRi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Aug 2020 09:17:38 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44945 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728439AbgHTJfA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Aug 2020 05:35:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BA2BA5C00E2;
        Thu, 20 Aug 2020 05:34:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 20 Aug 2020 05:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=KlpKEu
        wCoUOMNODDk2NCxK/d+w7GprnH5JN5nth+uqI=; b=GxjAAHVEytKq/BXRBWsDxY
        Dxd+QGSxNyMLn8B6w2bmBHtKm0VvhbkJfRUN+wyQ76fLyGOXps4Bp6lYyc4OslUw
        CviOtRimIJz9e2GPwAWHPkkz3VZaVHMy2Z6/iya0NhhpWD5ntBeJ90TymbMmOduH
        3krwawSMZhRk62Fen4KFAIwaFpKwtMjkHuPsycm80afeY8OO2MMdzaVumezTlJuR
        KNdi/GebTHioOcjUAw+WHIL42E1ecSYrMhFzPEmoMIHdf2zRwB0mvdaIyXsWN/X3
        Y3J3scEeV/uBB9xAOB9U+m+IL8p1ufOJM6tCcD6E2OXIw8nHg8Q0JAp/YVuc6/DA
        ==
X-ME-Sender: <xms:w0M-X1DHNrYONv3eKsbyxF6ogxOn86preXDIu8-vS1TG9SLjSV9H_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddutddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeetveff
    iefghfekhffggeeffffhgeevieektedthfehveeiheeiiedtudegfeetffenucfkpheple
    durdeigedrudejtddrkeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsg
    drtghomh
X-ME-Proxy: <xmx:w0M-XzjZGjLAp3n9_azWu0HJ-2LvhXEr0Nw-aGIfzOfEUa-iC2utxg>
    <xmx:w0M-XwkllzvvDnn213E9uwXCMcpLM26j6UTX6b_kkAMDZan5hXrRSA>
    <xmx:w0M-X_xG0GH2nOXoQYwBW64vVgXzNJnUgZ3q0__ohYa9b3uWuoJnZg>
    <xmx:w0M-X4efRSIXmsgZm_bWKk2FYgEeFvwbXRzwjLNLAlD7ehekjMRMOw>
Received: from mail-itl (ip5b40aa59.dynamic.kabel-deutschland.de [91.64.170.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id 60BFA3280060;
        Thu, 20 Aug 2020 05:34:58 -0400 (EDT)
Date:   Thu, 20 Aug 2020 11:34:54 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc:     Norbert Kaminski <norbert.kaminski@3mdeb.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        open list <linux-kernel@vger.kernel.org>,
        Maciej Pijanowski <maciej.pijanowski@3mdeb.com>,
        piotr.krol@3mdeb.com
Subject: Re: [PATCH] efi: discover ESRT table on Xen PV too
Message-ID: <20200820093454.GS1626@mail-itl>
References: <20200816001949.595424-1-marmarek@invisiblethingslab.com>
 <20200817090013.GN975@Air-de-Roger>
 <20200818120135.GK1679@mail-itl>
 <20200818124710.GK828@Air-de-Roger>
 <20200818150020.GL1679@mail-itl>
 <20200818172114.GO828@Air-de-Roger>
 <20200818184018.GN1679@mail-itl>
 <20200819081930.GQ828@Air-de-Roger>
 <3d405b0c-4e2b-0d29-56bb-e315f4c21d03@3mdeb.com>
 <20200820093025.GT828@Air-de-Roger>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pssgfZQbIK00CPi6"
Content-Disposition: inline
In-Reply-To: <20200820093025.GT828@Air-de-Roger>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--pssgfZQbIK00CPi6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] efi: discover ESRT table on Xen PV too

On Thu, Aug 20, 2020 at 11:30:25AM +0200, Roger Pau Monn=C3=A9 wrote:
> Right, so you only need access to the ESRT table, that's all. Then I
> think we need to make sure Xen doesn't use this memory for anything
> else, which will require some changes in Xen (or at least some
> checks?).
>=20
> We also need to decide what to do if the table turns out to be placed
> in a wrong region. How are we going to prevent dom0 from using it
> then? My preference would be to completely hide it from dom0 in that
> case, such that it believes there's no ESRT at all if possible.

Yes, that makes sense. As discussed earlier, that probably means
re-constructing SystemTable before giving it to dom0. We'd need to do
that in PVH case anyway, to adjust addresses, right? Is there something
like this in the Xen codebase already, or it needs to be written from
scratch?

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--pssgfZQbIK00CPi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl8+Q74ACgkQ24/THMrX
1yw4EQgAk4AIcF8Tu2i2t9vctatIRr4NIxuooAyuGeLDLt9gHLT6RnXWj19wse+9
mkWk5O2lq9WtIrO4gWqBScO0uPAbH9EV6RapfhhGHc/gTtG2rXieaCOiwOW1QKuA
1QhKHmzSWb16MAQD30cNvyThc7CWEtDz87/gPzxYSOzSEtPIRp3SwJDXifNOPAUK
w5rzHYjmANwxAw2kNmGuF+AmwZgHQhGkCLzUMMkZ7hPEGxnKRferTQHmU2Hs3WBC
hDiq05yOY5i4YUsJiPJrkGLuhwRRjbq38Rb3CWlwhLRMEzQhw4i6+T/EETRy8MZm
2t/zlNB3JyO+sFY32S+zBBXoYBe+lg==
=7TLR
-----END PGP SIGNATURE-----

--pssgfZQbIK00CPi6--
