Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD45B6E51
	for <lists+linux-efi@lfdr.de>; Tue, 13 Sep 2022 15:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiIMN20 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Sep 2022 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiIMN2Z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Sep 2022 09:28:25 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E947192B3;
        Tue, 13 Sep 2022 06:28:21 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B3F95C017F;
        Tue, 13 Sep 2022 09:28:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 13 Sep 2022 09:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663075698; x=
        1663162098; bh=b5IwvONy+aPZig6uiZYmFqcObNpEzTolaCm7RCSv1cA=; b=Y
        ceNynn/q4lo+Tu+LKJ5+jVUGr691gly7lTNYG+/V5B7SSSUBCb3FamtoQPBnuDN0
        Dhx9DxLqajryeEinEA3GGYviHKWHpSJkg5W2BsNmIXg3I8Nd8dS4FABb/lcToQhb
        VAD5wxNRJH/xcVgJVqKfPqpkW/0fXCyqBOd3fEvQQ85LVr3hOJxHC23MK70M65/F
        VSdd/xNFbErJsueXmUFkWnU7nCFenJBt/tNOoqWz+nnUQVFAMV/zVtntzhYkcnnz
        V6Y3YpHbmzfdEDqI/VoTwSAtUNdDAm7XyorzSHNFyoQwClvyrvN1yu3wnLyQsYfz
        BJ7IY0DnaAY+wu3P4v5Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663075698; x=1663162098; bh=b5IwvONy+aPZig6uiZYmFqcObNpE
        zTolaCm7RCSv1cA=; b=qqNpaJjRAO5/+5GFPFLvA2RrnjZDadkpv0YqDbCnsMGS
        RDlR6r09f5ZfY+B124rHjgMVfmrKlb6kN4fCd5Y3jWCzKf1yCRmUEim1OP2hEKb1
        64U+w/zcZBB+UroOIrsLZptt5JYm4/S1ycqlTJs/2Ddmw9dfeX6GbFy35L/ElnXS
        yGUH0xNDLZBbkjsO1QhFSDw5CQrwR0OSa2DAAGEmPwifJ0+WhD7YLH+XGiIoPcNi
        hB2LzDXhX00wIxiS3JKPxg36m9oCUw6OHmvnvWQ3hJjL09uwxic48Zdg9MwE6NhQ
        rI8udxV14nmfqVmaFKsXUDbZusBdaemP4cSmAtL1iA==
X-ME-Sender: <xms:cYUgY1uyjxZ5-rO0gILp_xhoxY_3jQE6acWJP3iRBGDegoys46YYyQ>
    <xme:cYUgY-fORlPr9AMT3B_DOMuF9EAWpzqAy7xYPiA9qIUjewJOWN8ry7r3QyutL3FeE
    _zHPoPluaEbyic>
X-ME-Received: <xmr:cYUgY4z6XRkhGJFxWguCH5uU-LOWi3LkW7NGm2_Q0to0nAza4Ql2v_3JRX3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedugedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepudeileefueetvdelheeuteffjeeg
    jeegffekleevueelueekjeejudffteejkeetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:cYUgY8PhEOIgbOf8fbBV8A7NkVQTMzAwFR3q1L-FX16_MGchjUXWaw>
    <xmx:cYUgY18WDeIN1aaxQzVrTsi17xCXqTBQKgPDude8kwH3Ctfvs89qMA>
    <xmx:cYUgY8V8JoTzGuYJQ0zG2hmW-9HtDywX_9-xQ5Xth-TMiRzFGH8YPg>
    <xmx:coUgYxYkMX3h9gr-wEAH2mbW6cgo1PDT7O5uf0bto8OLHXK5oCGDwg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Sep 2022 09:28:17 -0400 (EDT)
Date:   Tue, 13 Sep 2022 09:27:53 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2] Add support for ESRT loading under Xen
Message-ID: <YyCFb7J6cJm5Ji9M@itl-email>
References: <20220828025158.1455-1-demi@invisiblethingslab.com>
 <CAMj1kXF5eH-HE1dkAEGGZ1qfG1eRThsNK7ayWkRmaHSO36sjfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="37mLKXCcYa6M0yBY"
Content-Disposition: inline
In-Reply-To: <CAMj1kXF5eH-HE1dkAEGGZ1qfG1eRThsNK7ayWkRmaHSO36sjfA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--37mLKXCcYa6M0yBY
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Sep 2022 09:27:53 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2] Add support for ESRT loading under Xen

On Mon, Sep 05, 2022 at 01:46:54PM +0200, Ard Biesheuvel wrote:
> On Sun, 28 Aug 2022 at 04:52, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > This is needed for fwupd to work in Qubes OS.
> >
>=20
> Please elaborate on:

Will do in v3.

> - the current situation

The ESRT is not available in dom0 under Xen.

> - why this is a problem

fwupd requires the ESRT to be available in dom0.  Without it, users
cannot update their firmware.

> - why your approach is a reasonable solution.

It is the approach already chosen by Xen upstream.  See below for
details.

> > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > ---
> > Changes since v1:
> >
> > - Use a different type (struct xen_efi_mem_info) for memory information
> >   provided by Xen, as Xen reports it in a different way than the
> >   standard Linux functions do.
> >
> >  drivers/firmware/efi/esrt.c | 49 +++++++++++++++++++++++++++----------
> >  drivers/xen/efi.c           | 32 ++++++++++++++++++++++++++
> >  include/linux/efi.h         | 18 ++++++++++++++
> >  3 files changed, 86 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> > index 2a2f52b017e736dd995c69e8aeb5fbd7761732e5..c0fc149a838044cc16bb08a=
374a0c8ea6b7dcbff 100644
> > --- a/drivers/firmware/efi/esrt.c
> > +++ b/drivers/firmware/efi/esrt.c
> > @@ -243,27 +243,50 @@ void __init efi_esrt_init(void)
> >         void *va;
> >         struct efi_system_resource_table tmpesrt;
> >         size_t size, max, entry_size, entries_size;
> > -       efi_memory_desc_t md;
> > -       int rc;
> >         phys_addr_t end;
> > -
> > -       if (!efi_enabled(EFI_MEMMAP))
> > -               return;
> > +       uint32_t type;
> >
> >         pr_debug("esrt-init: loading.\n");
> >         if (!esrt_table_exists())
> >                 return;
> >
> > -       rc =3D efi_mem_desc_lookup(efi.esrt, &md);
> > -       if (rc < 0 ||
> > -           (!(md.attribute & EFI_MEMORY_RUNTIME) &&
> > -            md.type !=3D EFI_BOOT_SERVICES_DATA &&
> > -            md.type !=3D EFI_RUNTIME_SERVICES_DATA)) {
> > -               pr_warn("ESRT header is not in the memory map.\n");
> > +       if (efi_enabled(EFI_MEMMAP)) {
> > +               efi_memory_desc_t md;
> > +
> > +               if (efi_mem_desc_lookup(efi.esrt, &md) < 0 ||
> > +                   (!(md.attribute & EFI_MEMORY_RUNTIME) &&
> > +                    md.type !=3D EFI_BOOT_SERVICES_DATA &&
> > +                    md.type !=3D EFI_RUNTIME_SERVICES_DATA)) {
> > +                       pr_warn("ESRT header is not in the memory map.\=
n");
> > +                       return;
> > +               }
> > +
> > +               type =3D md.type;
> > +               max =3D efi_mem_desc_end(&md);
> > +       } else if (IS_ENABLED(CONFIG_XEN_EFI) && efi_enabled(EFI_PARAVI=
RT)) {
> > +               struct xen_efi_mem_info info;
> > +
> > +               if (!xen_efi_mem_info_query(efi.esrt, &info)) {
> > +                       pr_warn("Failed to lookup ESRT header in Xen me=
mory map\n");
> > +                       return;
> > +               }
> > +
> > +               type =3D info.type;
> > +               max =3D info.addr + info.size;
> > +
> > +               /* Recent Xen versions relocate the ESRT to memory of t=
ype
> > +                * EfiRuntimeServicesData, which Xen will not reuse.  I=
f the ESRT
>=20
> This violates the EFI spec, which spells out very clearly that the
> ESRT must be in EfiBootServicesData memory. Why are you deviating from
> this?

Xen will freely use EfiBootServicesData memory for its own purposes
after calling ExitBootServices().  In particular, such memory may be
allocated to, and become writable by, other guests.  Since the ESRT is
(of necessity) trusted, it cannot be used by Linux unless it is
guaranteed to not be writable by other guests.

Earlier patches to Xen just reserved the region containing the ESRT in
the EFI memory map.  However, this was tricky to implement correctly and
required a new platform op to alert dom0 that the ESRT had been reserved
by Xen.  The final patch accepted upstream instead checks if the ESRT is
in EfiBootServicesData memory, and if it is, relocates it to
EfiRuntimeServicesData memory.  This allowes using existing hypercalls
to check if the ESRT has been reserved by Xen, which is exactly what
this patch does.

If I recall correctly, some firmware already allocates the ESRT from
EfiRuntimeServicesData memory, so operating systems already need to
support this case.  Furthermore, the ESRT must not be clobbered by the
OS or hypervisor, so EfiRuntimeServicesData is a more logical choice
anyway.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--37mLKXCcYa6M0yBY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmMghW8ACgkQsoi1X/+c
IsFXOA/+L49ME+tYwPJiJQHmriPMx44MCB0a+MT8Q1JIsuTPZnCxWeT2gs6FN5q5
zPncQzYMOOOzyFpKsAR9Q2AHKu8qIf3qFoX1bc1Dsc36lAW3ADWtQBSRDqMfK8WL
Q4oQX2ypgW4x3v9OHhKMSwHPIWxTsxLLoh7hLjm83phikRHy7I0EZYs2AviOYsen
u04rNCH/ZitfzDimI1BEy2Fqp2f0hskkn46TObnjrz3crtZndkld8n3f7AN5bXFi
8dE5t9pHKKzGyj/R2HnDa4YV+agG5+87MW+LQrM0CgZC2aHNW5MRmmRaz/KAWOO1
B7LYbcL0WWmhAMVaDegZDeQpTSVKHYR80z3JmKXEqL59SoNE+kC7ld2FlTdeFrFs
/+vo9UxLYX7VW4FLGFh/iMnozy6wf4VK82Il1nDNCJGnsgiRXoS4DCn7FbjSyidh
STdSZ6JE/OHtqUjmY8RUlZH9jUIiLUMfHa30xXP30mvP3yQ/ulvJgp9bVC3HxioG
lM9Ik6pZD4lSfFaOtdQRf/h8zL1grd+d2SEDbfIBlKd7jkid6d5gjoPjHIEUyETq
xxPJkEWGk33t/hSLhvlrB+FEcu5Egs11e+VMHt49bveiSOdMxPN5r5DUxjcwUvFI
iV0wewWHAEfemwiX5D6H8Tmx285a5EwLGWJd/zIogQwZ2W10r2k=
=78/p
-----END PGP SIGNATURE-----

--37mLKXCcYa6M0yBY--
