Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D3E5F1611
	for <lists+linux-efi@lfdr.de>; Sat,  1 Oct 2022 00:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiI3WZ0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Sep 2022 18:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiI3WZY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Sep 2022 18:25:24 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB04993229;
        Fri, 30 Sep 2022 15:25:22 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8E439320099F;
        Fri, 30 Sep 2022 18:25:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 30 Sep 2022 18:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664576721; x=
        1664663121; bh=T7Mg2JlqK1o7pUqTdBwT/w1PsDHF5gVYItjasG+Yjaw=; b=4
        Qo0fVOVATLnXNgpBfGgE2nZRkka8lvb+5XXCI/rpwkByGxjkKiagYk3eNdUm6336
        LQ/tvMQJHNBUa/fG1ACB+37mh+5YT4/dCMchhJcj3MXV8i1VFf2n+4xhHsNs6ByH
        q8pmV9ZDcvAZtWuVPek94nvd0KQfP2gaZjvaX3nlBZHXyu88YnY5mLdq6BRDl5q7
        vWIcL04AuqMRRlYZSGQjz8eXxyRnMBXSyCD+PDta93YFnc/IlGOpYDe91E7PP2VE
        4OcZS3HETZhyPIak5fE4r2ovOBQAVn2KvG4J6NRTAeSyXl5Fku+152WMQsdmoKV9
        IjWLxWJUwlgLit6von9EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664576721; x=1664663121; bh=T7Mg2JlqK1o7pUqTdBwT/w1PsDHF
        5gVYItjasG+Yjaw=; b=qoSpnm9F1vihQXumi7xwH/hjgZ9MOQ2yvOX2uOnvf8ST
        WTbTGiF8zmrfz6Ym5gVYQOA/uqYmJGfsUg08fQLjM6DTv6b1eRHaufHwC96CmBVs
        OlWiLFpKsdUcEn1VWmZskNrav/p6AhfjCQzFJK2727FIXHA3v3tdo5wpdU9Efz8k
        UsJmVrkXaOe8CRAU/TzLu+s+2R50Vvm8Dqg7DIyL674AQgWetQXLGs11B4J9pKl6
        Tq37IwdElNtVPI2IKoAMVlCnBdZ7XuIVUublUqcuMZYl62gID4AanZqPDPp1xQwD
        0FxiF3zBdALeVc1pP7UY3rQ/NImrxpZqyKlMxu5GPw==
X-ME-Sender: <xms:0Gw3Y6uk8K-QI997Ikq3NJ7QLoZnHb7SVeL1mutcTkcgXiivt1VlrQ>
    <xme:0Gw3Y_faAX2HbjQSQMyn0dMo4sXFzwzHqDO5X6xln-dLnk-rxOGi1Jm4PNxABZc3K
    My9h_hti_N8Feo>
X-ME-Received: <xmr:0Gw3Y1x9mOkAj74JaxsYDPPp_RksFOEVgBcuD_ID3KxiFm6IjaOFWXcnU5N7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehfedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepueeuveelheevvdeuvdfhiefhleff
    tdehuedvfefgveegfefgiefhudehveehtdefnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:0Ww3Y1N0QRTLJuV3h6Zp2ERp-KB0wQLkRIbIxwwXCkh1NqY6nj1YUQ>
    <xmx:0Ww3Y6_dKOG2PyNUqLt0KCWZ_wcYsDsnzdulsDEE9cs1N_6SnqfnhQ>
    <xmx:0Ww3Y9U5zDUT-whzg7WlEy4xLGMpBH9dDWTu9w17w7l3rNQLM45hyg>
    <xmx:0Ww3Y705ziCSLiZPsRi970aYitdus6uE6vVa_gF061iddkXMDg57xQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Sep 2022 18:25:20 -0400 (EDT)
Date:   Fri, 30 Sep 2022 18:25:14 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Jones <pjones@redhat.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Support ESRT in Xen dom0
Message-ID: <YzdszknqsmWsPsMZ@itl-email>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <5649176eacda434267f68676f1733d06c572d19e.1664298147.git.demi@invisiblethingslab.com>
 <CAMj1kXEs-o8jvNqRiW+Ue2i52RBgg4iktg8UONCACk8-Gx4XXA@mail.gmail.com>
 <YzczpIYop5olD4hj@itl-email>
 <CAMj1kXHGPzy9T1LcE8LX+woGtUGTzrDgbjDBJabJ+bwDVPbTag@mail.gmail.com>
 <YzdPv4+fYX3SG9P0@itl-email>
 <CAMj1kXGTZZmW=QZOL1FvrsBLsvFzN1GkvZCotuZ-C-gBVGY6CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W3TkS4UfiBitGDRa"
Content-Disposition: inline
In-Reply-To: <CAMj1kXGTZZmW=QZOL1FvrsBLsvFzN1GkvZCotuZ-C-gBVGY6CQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--W3TkS4UfiBitGDRa
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Sep 2022 18:25:14 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Peter Jones <pjones@redhat.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Support ESRT in Xen dom0

On Fri, Sep 30, 2022 at 10:59:49PM +0200, Ard Biesheuvel wrote:
> On Fri, 30 Sept 2022 at 22:21, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > On Fri, Sep 30, 2022 at 09:11:19PM +0200, Ard Biesheuvel wrote:
> > > On Fri, 30 Sept 2022 at 20:21, Demi Marie Obenour
> > > <demi@invisiblethingslab.com> wrote:
> > > >
> > > > On Fri, Sep 30, 2022 at 06:36:11PM +0200, Ard Biesheuvel wrote:
> > > > > On Fri, 30 Sept 2022 at 01:02, Demi Marie Obenour
> > > > > <demi@invisiblethingslab.com> wrote:
> > > > > >
> > > > > > fwupd requires access to the EFI System Resource Table (ESRT) to
> > > > > > discover which firmware can be updated by the OS.  Currently, L=
inux does
> > > > > > not expose the ESRT when running as a Xen dom0.  Therefore, it =
is not
> > > > > > possible to use fwupd in a Xen dom0, which is a serious problem=
 for e.g.
> > > > > > Qubes OS.
> > > > > >
> > > > > > Before Xen 4.17, this was not fixable due to hypervisor limitat=
ions.
> > > > > > The UEFI specification requires the ESRT to be in EfiBootServic=
esData
> > > > > > memory, which Xen will use for whatever purposes it likes.  The=
refore,
> > > > > > Linux cannot safely access the ESRT, as Xen may have overwritte=
n it.
> > > > > >
> > > > > > Starting with Xen 4.17, Xen checks if the ESRT is in EfiBootSer=
vicesData
> > > > > > or EfiRuntimeServicesData memory.  If the ESRT is in EfiBootSer=
vicesData
> > > > > > memory, Xen replaces the ESRT with a copy in memory that it has
> > > > > > reserved.  Such memory is currently of type EFI_RUNTIME_SERVICE=
S_DATA,
> > > > > > but in the future it will be of type EFI_ACPI_RECLAIM_MEMORY.  =
This
> > > > > > ensures that the ESRT can safely be accessed by the OS.
> > > > > >
> > > > > > When running as a Xen dom0, use the new
> > > > > > xen_config_table_memory_region_max() function to determine if X=
en has
> > > > > > reserved the ESRT and, if so, find the end of the memory region
> > > > > > containing it.  This allows programs such as fwupd which requir=
e the
> > > > > > ESRT to run under Xen, and so makes fwupd support in Qubes OS p=
ossible.
> > > > > >
> > > > > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > > >
> > > > > Why do we need this patch? I'd expect esrt_table_exists() to retu=
rn
> > > > > false when patch 1/2 is applied.
> > > >
> > > > efi_enabled(EFI_MEMMAP) is false under Xen, so there needs to be an
> > > > alternative way to get the end of the memory region containing the =
ESRT.
> > > > That is what this patch provides.
> > >
> > > OK. I don't think we need that to be honest. When running under Xen,
> > > we should be able to assume that the ESRT does not span multiple
> > > memory regions arbitrarily, so we can just omit this check if
> > > !efi_enabled(EFI_MEMMAP)
> > >
> > > IIRC (and Peter would know), we are trying to filter out descriptors
> > > that are completely bogus here: zero lenght, zero address, etc etc. I
> > > don't think we need that for Xen.
> >
> > Xen doesn=E2=80=99t uninstall bogus ESRTs, so there is no less reason t=
o worry
> > under Xen than on bare hardware.
>=20
> That may be true. But if Xen needs dom0 to be able to cross reference
> the EFI memory map, it should provide one (and set EFI_MEMMAP to
> enabled).

I agree, but it is also a significant amount of work compared to this
patch.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--W3TkS4UfiBitGDRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM3bM4ACgkQsoi1X/+c
IsGviA/9Ew7nTKujqShHMt0PH3J+T4Z7VEpnyrbvswGUdPqEwfkDIwWTVdXkY7LY
gP2IdAm6BeBxi6FM8+PC3Q27bXNgb79bEMTq2EkKSg6GRCNFr//A+CycEpUV8PIB
tawXGOkdstjChGDJcFGeYZv7vhWGjFhMWDAKkSBEKMA4ULwTOfSkAm7PKqa8Cdkz
oP6owcGuakCjzvb8Tneqp2ekAdGeENgpaEFS03WreCne6V1j3BH0iZh89q0Ztyq1
+6gowf5kkx+/4AFsUjBEnMJmTGaeumvc4HaqF1NCWJ1JD5MkdG7LYfe5mF3PZ9x6
xdb4NZQIBO5aooeGw4EiKa0k385DXLB2NuAAD/d/wn/vLdcjSCoVf3ox5qLGy5U6
dz7Vw6/bG4HTXxtwsCvQbr7+MTyVfHlv+u14/l0ESJw1+tGMXT5gylr6EJe6N7kX
nw7q+Cx2hUb8zhQuZpJNndAO0Z7u3lMiQwTNplO75SIVBzaX+JUDoN9yHUYNQc/A
8y7ZxatLuM9EEatkRfW3LWwMOXANlkHLoKOdTK7d7KbgliasMc2lCn3KRVsen/Q5
qxH8UpVicsSuMtucJ3d+TsnssjOnGBN9Lvpkphs2tTGkNbRu/SlBLzbm+6c6AAuu
g+riK0KOtO5qcExucLSQe3AKP8/9tYtWR+i85xcDz2ZhN88nVB4=
=hWqs
-----END PGP SIGNATURE-----

--W3TkS4UfiBitGDRa--
