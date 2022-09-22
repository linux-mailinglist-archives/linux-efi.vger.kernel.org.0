Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18B95E57C0
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 03:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIVBJe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 21:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIVBJd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 21:09:33 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B60E4E;
        Wed, 21 Sep 2022 18:09:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 51BAE5C00AD;
        Wed, 21 Sep 2022 21:09:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 21 Sep 2022 21:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663808967; x=
        1663895367; bh=htQy3Ooh2pcw6WQAzMWu1eJmwAJOudfKc06grWuOtqo=; b=J
        ppbHTkcAFfStvVNejhrKmL8Vjr+wtGhXXvgEhHIs8h9U3iLq8cx5s9mWdr6TfLQO
        72OvoxnG7Lge1fbuasPFvIENf2zq2PfhF4/iNw2ckSTY9EExanmQymr/ch8KZRq9
        TYJ0eXWbnPE6kD6aNJbNkxZfhOO8s2lObaHAmiGLmQOlYAtr6/fEwlgDNi7ONJA4
        UGs7YPJK+kq5Pfpgb7wOooDeUOeiwNlS+VX84fxdb4q2aLhI3euEFrotcwhyjY5X
        XcMG4ABQFqiSepX79FlEg75lc5KMo7XsvoaVLAqzwA+3UPqAbMj6Tx+f/HsHNQ5t
        6/MoM4wnh89Nxor6YHXVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663808967; x=1663895367; bh=htQy3Ooh2pcw6WQAzMWu1eJmwAJO
        udfKc06grWuOtqo=; b=fi2ORdOBN0I0CWaBP5fkIsaUCTcc8JskD/lUqsRzAxIe
        S3jXMZyJNYUiUaPM/K1aDNTKGY+YrgLIopl8gI2LaxIq8zwJCssFNEc7BhrE7TEt
        bnhpd3Dr3SmZz47P6cML9w6JAekP6t5ejVHFGyXToDzF0JfR2Tqlfr590MP1vNL1
        gG1srjL58zA2VpbVbWKkqS353Mgk4i6NkcYmcbx8qaKIFIaVSVDnzs1tXRTFsg/s
        04su869qXdoiobHdKV+mXbbwR80uAH5afElVhwliNJtwONEpUha95e1Bmf8obN6z
        lN9BUQdHTcE0h0LA9fbprTV4wCqMBeNy8ymsDCL7wg==
X-ME-Sender: <xms:xrUrY-oqOCfAwsY8K5tUzhYvnlV3SMbx3MJmMDAwvgisyOoHxcFIsg>
    <xme:xrUrY8qdJu1-2S85E0tuhbAD2xj-XHFQR42WIVRLa3SEHg-19LHQU2sRTj-1sdjBD
    dIAnIDBwCAe5Jg>
X-ME-Received: <xmr:xrUrYzMDzUQkCN0aRPJrF_hm6tATLnscVF9ltunxuY9OgXpcUlr6-BG8hGPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:xrUrY96aEe6N-RbSnBDICudK_fZdSMt6Yq_jjlYlQ0dfzSbfdiaGqw>
    <xmx:xrUrY94ojrMfqmAc_RGCQZG4_d14g4aTNzqBYuBNoPx21csak4ogNA>
    <xmx:xrUrY9h2zd0zja9pRnVvztaG15ox3LOfMjrLA0puI4IZcrH7L-gyJQ>
    <xmx:x7UrY6seDkP0rjltPFiY8IGcJCvTrI6-dXUNdmG9Rm52sLpAJIXQUA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 21:09:26 -0400 (EDT)
Date:   Wed, 21 Sep 2022 21:09:21 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jan Beulich <jbeulich@suse.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v3] Support ESRT in Xen dom0
Message-ID: <Yyu1xC7Tlf9sS7Ro@itl-email>
References: <20220919193257.2031-1-demi@invisiblethingslab.com>
 <CAMj1kXEBfJUfTQ3THqqKxsU09_S98B_TjTECKwGM0WAv_5tZaA@mail.gmail.com>
 <7930b617-d473-94dd-c7e4-33ffa19da13e@suse.com>
 <CAMj1kXEJ9d3-8xa7rkczY7ur2zDm9CjqM7u1eEdHHmPG=Oo=xA@mail.gmail.com>
 <3671fd52-6034-7149-ebe4-f7560c0dc6b0@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h6mSater0Rbyeym3"
Content-Disposition: inline
In-Reply-To: <3671fd52-6034-7149-ebe4-f7560c0dc6b0@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--h6mSater0Rbyeym3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Sep 2022 21:09:21 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Jan Beulich <jbeulich@suse.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v3] Support ESRT in Xen dom0

On Wed, Sep 21, 2022 at 10:34:04PM +0200, Jan Beulich wrote:
> On 20.09.2022 18:09, Ard Biesheuvel wrote:
> > On Tue, 20 Sept 2022 at 17:54, Jan Beulich <jbeulich@suse.com> wrote:
> >>
> >> On 20.09.2022 17:36, Ard Biesheuvel wrote:
> >>> On Mon, 19 Sept 2022 at 21:33, Demi Marie Obenour
> >>> <demi@invisiblethingslab.com> wrote:
> >>>>
> >>>> fwupd requires access to the EFI System Resource Table (ESRT) to
> >>>> discover which firmware can be updated by the OS.  Currently, Linux =
does
> >>>> not expose the ESRT when running as a Xen dom0.  Therefore, it is not
> >>>> possible to use fwupd in a Xen dom0, which is a serious problem for =
e.g.
> >>>> Qubes OS.
> >>>>
> >>>> Before Xen 4.16, this was not fixable due to hypervisor limitations.
> >>>> The UEFI specification requires the ESRT to be in EfiBootServicesData
> >>>> memory, which Xen will use for whatever purposes it likes.  Therefor=
e,
> >>>> Linux cannot safely access the ESRT, as Xen may have overwritten it.
> >>>>
> >>>> Starting with Xen 4.17, Xen checks if the ESRT is in EfiBootServices=
Data
> >>>> or EfiRuntimeServicesData memory.  If the ESRT is in EfiBootServices=
Data
> >>>> memory, Xen allocates some memory of type EfiRuntimeServicesData, co=
pies
> >>>> the ESRT to it, and finally replaces the ESRT pointer with a pointer=
 to
> >>>> the copy.  Since Xen will not clobber EfiRuntimeServicesData memory,
> >>>> this ensures that the ESRT can safely be accessed by the OS.  It is =
safe
> >>>> to access the ESRT under Xen if, and only if, it is in memory of type
> >>>> EfiRuntimeServicesData.
> >>>>
> >>>
> >>> Thanks for the elaborate explanation. This is really helpful.
> >>>
> >>> So here, you are explaining that the only way for Xen to prevent
> >>> itself from potentially clobbering the ESRT is by creating a
> >>> completely new allocation?
> >>
> >> There are surely other ways, e.g. preserving BootServices* regions
> >> alongside RuntimeServices* ones. But as the maintainer of the EFI
> >> code in Xen I don't view this as a reasonable approach.
> >=20
> > Why not?
>=20
> Because it's against the intentions the EFI has (or at least had)
> for this memory type. Much more than EfiAcpiReclaimMemory this
> type is intended for use as ordinary RAM post-boot.

What about giving that memory to dom0?  dom0=E2=80=99s balloon driver will =
give
anything dom0 doesn=E2=80=99t wind up using back to Xen.

> >>> TBH I still don't think this is a scalable approach. There are other
> >>> configuration tables that may be passed in EFI boot services memory,
> >>> and MS especially were pushing back in the UEFI forum on adding table
> >>> types that were passed in anything other the EfiBootServicesData.
> >>
> >> Within Xen we might abstract the approach currently implemented in
> >> case more such pieces of data appear.
> >>
> >> While I can easily believe MS might be advocating for this model,
> >> I view it as problematic not only for Xen. How would you pass on
> >> this information across kexec, for example, without introducing
> >> further producer-consumer dependencies requiring separate protocols
> >> to be followed?
> >>
> >=20
> > In this case, I don't think this is unreasonable for configuration
> > tables, which only have a GUID and a base address. If the OS knows the
> > GUID, and knows how to interpret the contents, it can decide for
> > itself whether or not to preserve it. If it doesn't know the GUID, the
> > memory is just treated as available memory [after EBS()]
> >=20
> > I personally think reclaimable memory is more suitable for these
> > cases, which is why I am willing to consider that as well. Note that
> > the EFI spec now also mandates device trees on ARM to be passed via
> > EfiAcpiReclaimMemory, simply because it is the memory type suitable
> > for firmware tables that only the OS consumes.
>=20
> We do preserve EfiAcpiReclaimMemory, for the simple reason that with
> Xen "the OS" is ambiguous: Is that Xen or Dom0? Most of ACPI is
> handled by Dom0, so we can't very well discard the data before Dom0
> starts. (This then also matters for what you've said in the earlier
> paragraph. In particular the sets of known GUIDs may be dissimilar
> for Xen and the Dom0 kernel. Considering your other remark about
> fragmentation you might agree that preserving in-place is not very
> desirable.)
>=20
> Especially with DT mandated to use EfiAcpiReclaimMemory I'm willing
> to consider using that type for the storing of ESRT (and whatever
> else may appear along these lines). Demi, you may want to check for
> both types in your Linux side patch ...

EfiAcpiReclaimMemory does seem like a better choice.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--h6mSater0Rbyeym3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmMrtcMACgkQsoi1X/+c
IsF4ShAAoQ8npwnu+o4G9Co3qQBtUWUNxsL4Q0H1H63aMfkgzDXCdlhT5VMrfvBE
Sjao2soGkDlHVDwDIjefkpjUz96lrnwPODeVAKZQYNRodi4R3XYUemgJKlclWQ93
sHxvtqvwEPISD586PUeoQZwHl0qtZOd8A/IT+JzGRwoNkhL+2xoNzEvyFflNlSGy
hzyTirzRW1v5CDbqG7uy6V6vmFMe8jbbLzm6WlST0IWZijg+hinjuKCzN5G12HAn
PmSTodvi/pPoYLO8dEZz8/UnFgNy2LnProNaLhaeY4ZBpNOOcdCSTW2Ai6CayRTs
hNwMrXbuv+JDBXsqlp60payK0QCRTgsIho/HRENHybsJtKHK1jPBjBJAkzGTPazn
J2czQOf6uyDXzF4nZmB52Tn7YN+FIPa7UPHcjw9EWJYX/gL++Kc53Hd7uIfunogD
ZCeoXDj8XtZKoGeywKSnqYy3wjCxdCpyaEogKrjFfGNaaDs/NXyoXasF2odiAy5j
VoSN2p1TTPQNCup8ubzEYKxS36rtJ+FR2R4pxRHydcWXhNnIMairy2acnlSamGv5
EaV4efRS3lAYi7PphAuNA3yGtaDL6hXl11sIEdE8re80Y1aG1NHUjTzJus8bWojk
lBNNTSXBAosaTrOMvNowF9yYvQMkIjPMEfDeN1s9toalzvpQa38=
=DzpQ
-----END PGP SIGNATURE-----

--h6mSater0Rbyeym3--
