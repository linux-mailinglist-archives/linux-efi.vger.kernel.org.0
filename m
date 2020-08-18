Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AFD248417
	for <lists+linux-efi@lfdr.de>; Tue, 18 Aug 2020 13:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHRLp1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Aug 2020 07:45:27 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:58567 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726273AbgHRLpZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Aug 2020 07:45:25 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 152A0B70;
        Tue, 18 Aug 2020 07:45:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 18 Aug 2020 07:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=u0/uCy
        /0jYOzVUR6bLEIJYYHx2p0pFbcL5YM13UhPbw=; b=kMS/bm7h9E8v793HxF5HlS
        reFVSpsTJ9LRnb5in6cSE7CDNZCPkmoI5Gb+8ZAKAfCy4/Wrhlcc7S4gE842yc6t
        37rYkXMerl4JbdInFdjeG0fM+9PYC4FgJViUnPTegInWSAdYPSqkjIZ6qmLv8264
        RkT9CwBFBRlZFoprfE1155gOkgB8k3cifqfH3BwIB9A0lfIbsRZ/DrzzLrTbh429
        hcoGlvsn/uP3JPxU/45N6XtsT6gREbGruWLEhuP1Z6WMQkCXzIpUp5xhUDHP/eSz
        +MAU7UqNPVXDDWS9thoX7oe+dlq0ZwZeSZ8aqfXxAdwGQecyh5KnQx1rBfz+tNeg
        ==
X-ME-Sender: <xms:Ur87X731USiQLlJTdDBntxwlig2jdEDb0bLCC_JJVQjyZwY68_3igA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtiedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeetveff
    iefghfekhffggeeffffhgeevieektedthfehveeiheeiiedtudegfeetffenucfkpheple
    durdeigedrudejtddrkeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsg
    drtghomh
X-ME-Proxy: <xmx:Ur87X6GL34WQFUkFrb3xFf0fmNskIBHixMCifeOxvg7hF5YV-2l9EA>
    <xmx:Ur87X75xbSUfYvUNU4Oyy8SAR2hmpqxqrcaqp2FH26vi_tUclutW0A>
    <xmx:Ur87Xw2O1Schc_99pT6-FWa2nL-Lvf4X8PNMQmvxrIoYOwVlQryyMg>
    <xmx:Ur87X5PIg2eleK1py02bENxJhXX4zDg0jcnduRdkQeC5FucSGTq2_w>
Received: from mail-itl (ip5b40aa59.dynamic.kabel-deutschland.de [91.64.170.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id 512F23280065;
        Tue, 18 Aug 2020 07:45:21 -0400 (EDT)
Date:   Tue, 18 Aug 2020 13:45:18 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, norbert.kaminski@3mdeb.com,
        xen-devel@lists.xenproject.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi: discover ESRT table on Xen PV too
Message-ID: <20200818114518.GA226001@mail-itl>
References: <20200816001949.595424-1-marmarek@invisiblethingslab.com>
 <CAMj1kXEQ2mpmcNke0K2MZPAAo9wGZ4h3pCmMg9Hm7CPXOCV7fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <CAMj1kXEQ2mpmcNke0K2MZPAAo9wGZ4h3pCmMg9Hm7CPXOCV7fQ@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] efi: discover ESRT table on Xen PV too

On Mon, Aug 17, 2020 at 10:16:07AM +0200, Ard Biesheuvel wrote:
> > @@ -331,7 +333,8 @@ void __init efi_esrt_init(void)
> >
> >         end =3D esrt_data + size;
> >         pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, =
&end);
> > -       if (md.type =3D=3D EFI_BOOT_SERVICES_DATA)
> > +
> > +       if (efi_enabled(EFI_MEMMAP) && md.type =3D=3D EFI_BOOT_SERVICES=
_DATA)
> >                 efi_mem_reserve(esrt_data, esrt_data_size);
> >
>=20
> This does not look correct to me. Why doesn't the region need to be
> reserved on a Xen boot? The OS may overwrite it otherwise.

In case of Xen, it is Xen responsibility to do that. Otherwise even if dom0
would not use it, Xen could allocate that physical memory to another
guest.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl87v04ACgkQ24/THMrX
1ywRDAgAgL6lTfIrcAbuddaDfuNoozejb/lFN0VlxjT6NKiJX9lpQRA/YRCe1TaL
xq6ELDuC0y9T7tn8smiyhnZ4t1oXKvk85uQBGfozl2vW2Zb6EEsNQOwa7HQF2Eh0
xvhMtxHrFWtWQk+KT0cVHnQHQ5lkNh0V4ARPUjN8Cbb4g285XMMo0DHzUYYUJOxj
55eRZbrVZhCiQHgAXDcdjJVrhCoCEfXWhS9L++HWcCnR42elRBuaX5Mrzx6PrYIT
xnWW37aUUO42wIeRiMw9unqAbyB6V34ApjF1zGGgvCKQDRES2I2mg7EidBkmMZaO
fzRSp3FZxlTusI1ZV8EFQ+uAEAdEdg==
=wVff
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
