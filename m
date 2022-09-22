Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EC15E5849
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 03:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiIVByZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 21:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiIVByY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 21:54:24 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF00A99EC;
        Wed, 21 Sep 2022 18:54:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4808B5C00BB;
        Wed, 21 Sep 2022 21:54:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 21 Sep 2022 21:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663811663; x=
        1663898063; bh=m6GkpIVXRWxbqQje5T7MQLuORENRyeMk/BRQajKA+yU=; b=e
        +t8Ws5tYc7yEGRZyMWpUL1hxuYiS+x7F2acMwVX7AYyRVaR5EAMP34EO3VVOu5er
        kL6QdRjcmIJNOHq8wZXN0zL1l1Zjjl+BTXWgGPE+E5SexMjV3mr93Wp1Tuv0PYf+
        XiUF6FL2xy/sRkM2tFto50/TwymoaTtMZ8fQ+pvZnJyfmpPKIaCOR/I7ccYC4Juy
        QdUybFmGAuC5O2vfK3nmNX7cvcFo6fldDb9lRQWiWVzNpdksC2pqBtsqK0B4+Ny5
        zcmLBekrkIBa0b+CUVsimo2bYMoFQcPYRXWuUlaNo1wLdnK7/SsNR+ccGujWCMB9
        czHAFLSs7gI9PaOlj/ctQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663811663; x=1663898063; bh=m6GkpIVXRWxbqQje5T7MQLuORENR
        yeMk/BRQajKA+yU=; b=XiCOhhnuDN7uxs3IlRF6TuEIqmkNUn9nwv4aYq0tdo+w
        KErcVnxBh4KErOpVOCQWLChFskCLeBhcikbebcr25Lw5AHtg2z0Plx6Z55qACXHr
        sXGJq21WX57ZdGI94zr+m+XIc7iAr605FURKpfcs5KVNMEpI7YC2UzbxFJX7pO2D
        6Gh8xnl5FCQiZyxfX7k1nhOXVa1/mVoUwTlcpyaN/GOu5m8Bnc3OZuualxlS1ORA
        lVVbS7VOxS1zh1h/0FvEwf8J38Nj4t4YfPs3t3P7dnCtbUDXD7EbrrUufWk7ILOI
        BoPksSmexvl+HaW/YsQB5Hgg+SNPa8z+MFyfG6Ji8A==
X-ME-Sender: <xms:T8ArY2QrQruOV70n4xHrI6Tpb_daSBZWSnWBM-axQgczwDG1k78I5A>
    <xme:T8ArY7xtTi58W1jFltAwPOCXIhwGpxVsbBR5Fx9SGLNZ1LCR2mAzSqwaBaPJp1zMN
    Dk9IM7jvwFd8G8>
X-ME-Received: <xmr:T8ArYz35q1Zdv_JlGdsjW7F-d9H0NqnA6FzUK_E555ZCUAeW9QkGgI5V12aN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepudeileefueetvdelheeuteffjeeg
    jeegffekleevueelueekjeejudffteejkeetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:T8ArYyBZRVgJlxt5ImfDe-XRY2Q2SZRdUixxLZEnpFjT5K4EdC53iA>
    <xmx:T8ArY_h2XQkG2N9biX_mslyN2rUHuA0Y9OEU4fnAjUcaJDoVAvBwUA>
    <xmx:T8ArY-oTNTN4wwjsLtB-TqT9kE07W1QSKffBkJguT92rxpqVko0fDQ>
    <xmx:T8ArY1aAR7ZhRHtuWj5OjyUkSi2FbkaBPugBjQxrvXD71FqXWq0kfQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 21:54:22 -0400 (EDT)
Date:   Wed, 21 Sep 2022 21:53:47 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3] Support ESRT in Xen dom0
Message-ID: <YyvATLLjX1jTOWGU@itl-email>
References: <20220919193257.2031-1-demi@invisiblethingslab.com>
 <CAMj1kXEBfJUfTQ3THqqKxsU09_S98B_TjTECKwGM0WAv_5tZaA@mail.gmail.com>
 <7930b617-d473-94dd-c7e4-33ffa19da13e@suse.com>
 <CAMj1kXEJ9d3-8xa7rkczY7ur2zDm9CjqM7u1eEdHHmPG=Oo=xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="05nNIFABQReCPqy0"
Content-Disposition: inline
In-Reply-To: <CAMj1kXEJ9d3-8xa7rkczY7ur2zDm9CjqM7u1eEdHHmPG=Oo=xA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--05nNIFABQReCPqy0
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Sep 2022 21:53:47 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>, Jan Beulich <jbeulich@suse.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3] Support ESRT in Xen dom0

On Tue, Sep 20, 2022 at 06:09:49PM +0200, Ard Biesheuvel wrote:
> On Tue, 20 Sept 2022 at 17:54, Jan Beulich <jbeulich@suse.com> wrote:
> >
> > On 20.09.2022 17:36, Ard Biesheuvel wrote:
> > > On Mon, 19 Sept 2022 at 21:33, Demi Marie Obenour
> > > <demi@invisiblethingslab.com> wrote:
> > >>
> > >> fwupd requires access to the EFI System Resource Table (ESRT) to
> > >> discover which firmware can be updated by the OS.  Currently, Linux =
does
> > >> not expose the ESRT when running as a Xen dom0.  Therefore, it is not
> > >> possible to use fwupd in a Xen dom0, which is a serious problem for =
e.g.
> > >> Qubes OS.
> > >>
> > >> Before Xen 4.16, this was not fixable due to hypervisor limitations.
> > >> The UEFI specification requires the ESRT to be in EfiBootServicesData
> > >> memory, which Xen will use for whatever purposes it likes.  Therefor=
e,
> > >> Linux cannot safely access the ESRT, as Xen may have overwritten it.
> > >>
> > >> Starting with Xen 4.17, Xen checks if the ESRT is in EfiBootServices=
Data
> > >> or EfiRuntimeServicesData memory.  If the ESRT is in EfiBootServices=
Data
> > >> memory, Xen allocates some memory of type EfiRuntimeServicesData, co=
pies
> > >> the ESRT to it, and finally replaces the ESRT pointer with a pointer=
 to
> > >> the copy.  Since Xen will not clobber EfiRuntimeServicesData memory,
> > >> this ensures that the ESRT can safely be accessed by the OS.  It is =
safe
> > >> to access the ESRT under Xen if, and only if, it is in memory of type
> > >> EfiRuntimeServicesData.
> > >>
> > > TBH I still don't think this is a scalable approach. There are other
> > > configuration tables that may be passed in EFI boot services memory,
> > > and MS especially were pushing back in the UEFI forum on adding table
> > > types that were passed in anything other the EfiBootServicesData.
> >
> > Within Xen we might abstract the approach currently implemented in
> > case more such pieces of data appear.
> >
> > While I can easily believe MS might be advocating for this model,
> > I view it as problematic not only for Xen. How would you pass on
> > this information across kexec, for example, without introducing
> > further producer-consumer dependencies requiring separate protocols
> > to be followed?
> >
>=20
> In this case, I don't think this is unreasonable for configuration
> tables, which only have a GUID and a base address. If the OS knows the
> GUID, and knows how to interpret the contents, it can decide for
> itself whether or not to preserve it. If it doesn't know the GUID, the
> memory is just treated as available memory [after EBS()]

Should an OS uninstall any configuration tables that it does not
preserve if it ever plans to kexec()?  Does Linux do this?
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--05nNIFABQReCPqy0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmMrwEsACgkQsoi1X/+c
IsETXhAAjr/+MWrA8eEVIEoYZ4PVctW84sTRXfBslltf7TZULl9zyWi/RSuYwj5K
a+a4Os05PC9xpu/GvyWO/6QTr1PwCIFIBkvi2eyfjem3KDbDdDA+qrLsoya/LD6C
1rnDabmZzzPcQsh19Mzc6ngipdbX7bLYjJkxwFpJ4KFKZi1ug4x2URa5VASYFuIv
i0I6imccxH5+92DXTaQBmSg2wHxG6zBkNYlEmbY16SgYV5mfWLpqw/85d2TMOOkt
uCohyxjC6uj7wyJ+QZ4fofo+yEl0Al4evWCve0Om5CknYJt+43Q2P89XJzmkxnJ8
T8x+BraQZ287kph/PCCzS/kLAt2dqjgS8XjZeP4g9AYF9H85FMa0g0lNFzhtkiEp
OvYedpSzFMR/XREw1yV9YBqMakfoI7VE2Kv3yqDXVfByFyDUMfBmGWyrGbr/ZtjE
9lhCgStB+qWnhYJluP6VyI7/gF/Q3MBuz9emMk+dDryMKTmMyo3ae2ADKgol4ASw
iF6pZD6y4JRYxIgpo5RT8mnkcEzGIoOAK5tPLb0XXzsJXUScskxE5Aoizvlf7HDQ
GukOXADUe0g+KyVhCDidy6bZK5a1FFyMLiJhe8hcU/PgRJDQ6R7/WDl5DmNX1eyv
acqYpMno6laktT9yopfjGGdZ9YanM3oN8DskXXD2L/u9ClNIQv4=
=l07Z
-----END PGP SIGNATURE-----

--05nNIFABQReCPqy0--
