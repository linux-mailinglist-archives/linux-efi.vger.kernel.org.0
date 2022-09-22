Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607455E663C
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiIVO4P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 10:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiIVO4N (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 10:56:13 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F91DE0C9;
        Thu, 22 Sep 2022 07:56:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B3AB63200124;
        Thu, 22 Sep 2022 10:56:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 22 Sep 2022 10:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663858570; x=
        1663944970; bh=zkbm06ADn/Z0FztsvCeHV5g6JLx4lp21pgu9fNEq2/I=; b=j
        ngIEaLE28Aml2WqeTX1u+TmlmoRdpw86O/8Ni4qYngg/B7qzA9y6kryrFgIfBxwu
        jhLzGTA3vPWOftDXIPXrJuSl6uqgsqOmbmsW44+1MwXqLguumUY+brtCNVtQ5F4W
        FtLL9GnLknCIxdlWsnMChlGEktvh2Jkcvz5pkF+Ks6uFLaMfLHpRzZz6sTV33h2/
        v6KFvvB/OHhE6E3yXfIEpRQfozLycwka8rCFDH08pnsbat0bu6qhCUpTHchXt44f
        RyKP4zqVWrx3PqiIC8y005N85eYb09UQohTS/aABXm2R7eDWsQPPRWhc1Z+Gp49J
        zxxDVuvvCZl2d32xicFXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663858570; x=1663944970; bh=zkbm06ADn/Z0FztsvCeHV5g6JLx4
        lp21pgu9fNEq2/I=; b=tUywip4W7b9b4sYdV6KEMIRYgWGRaUI48i6JEhIEd1kd
        YawxkarPA67Sbiei4uy6W62UFCiXY33+hjd6xyhK5mANDPHhAgBNVqiE+/p2M3p+
        cRgcHGB8UEA4itvNHT1/5+vysAaW2RmGvsDqp9U2u5tHDMDUqBvuA1SOnzCOCjhn
        dfZ4RgnqZF19TU0TwhFROz4aEAB1cFVUUcRzP4DkxRYChadANHt0CoCCmy0fvzq6
        n/4muytoiycONrnek2CRpgrcehcxv35+C9OnzngM/dDSOM0W/sosWzmfsV36nCZb
        9g7zgZINwrXAlcjA7qrfeDaHR0KrivMiso6SDFwC7Q==
X-ME-Sender: <xms:iXcsY-r9jeoDpCEdOsIPfDhqr7MlS-JYI0nxb93LFU-toBYvGx3TUQ>
    <xme:iXcsY8p0Q7gpYeLhcPerAQVncXJF7NxLBRlQDnV23Mrgr3ZyXhIH2WFfL3IOcEcsJ
    Fc3yZTW2xR4w9g>
X-ME-Received: <xmr:iXcsYzOOPt2ZljHb-K8x6scWodysWPTZLih1fVeKGrgGriiBI7hso9bCupRI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:iXcsY97JS_078ydi37iHEAOdjmf-jJDpnYfnFS3FnvdQqKPXx12N6w>
    <xmx:iXcsY94rjsmv-5HyBQR6LffE9NCfTT8xd8GMKf4IvzeSnUkUQOWppg>
    <xmx:iXcsY9i9gAL7gPm2rvF7F-DRBDeWhXzxOengiwK18SGgoWiqeW_9rg>
    <xmx:incsY6uxfiNKihOd1IWez8jE3VI1OWb5lXRGiXbAemku3xoG_gt8ew>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Sep 2022 10:56:09 -0400 (EDT)
Date:   Thu, 22 Sep 2022 10:55:40 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3] Support ESRT in Xen dom0
Message-ID: <Yyx3hlE/MDBeEdtu@itl-email>
References: <20220919193257.2031-1-demi@invisiblethingslab.com>
 <CAMj1kXEBfJUfTQ3THqqKxsU09_S98B_TjTECKwGM0WAv_5tZaA@mail.gmail.com>
 <7930b617-d473-94dd-c7e4-33ffa19da13e@suse.com>
 <CAMj1kXEJ9d3-8xa7rkczY7ur2zDm9CjqM7u1eEdHHmPG=Oo=xA@mail.gmail.com>
 <3671fd52-6034-7149-ebe4-f7560c0dc6b0@suse.com>
 <Yyu1xC7Tlf9sS7Ro@itl-email>
 <6f42a382-c5aa-ba16-f330-69a07476e2aa@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GpPEXFLkdw7UWuLD"
Content-Disposition: inline
In-Reply-To: <6f42a382-c5aa-ba16-f330-69a07476e2aa@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--GpPEXFLkdw7UWuLD
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Sep 2022 10:55:40 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3] Support ESRT in Xen dom0

On Thu, Sep 22, 2022 at 08:12:14AM +0200, Jan Beulich wrote:
> On 22.09.2022 03:09, Demi Marie Obenour wrote:
> > On Wed, Sep 21, 2022 at 10:34:04PM +0200, Jan Beulich wrote:
> >> On 20.09.2022 18:09, Ard Biesheuvel wrote:
> >>> On Tue, 20 Sept 2022 at 17:54, Jan Beulich <jbeulich@suse.com> wrote:
> >>>>
> >>>> On 20.09.2022 17:36, Ard Biesheuvel wrote:
> >>>>> On Mon, 19 Sept 2022 at 21:33, Demi Marie Obenour
> >>>>> <demi@invisiblethingslab.com> wrote:
> >>>>>>
> >>>>>> fwupd requires access to the EFI System Resource Table (ESRT) to
> >>>>>> discover which firmware can be updated by the OS.  Currently, Linu=
x does
> >>>>>> not expose the ESRT when running as a Xen dom0.  Therefore, it is =
not
> >>>>>> possible to use fwupd in a Xen dom0, which is a serious problem fo=
r e.g.
> >>>>>> Qubes OS.
> >>>>>>
> >>>>>> Before Xen 4.16, this was not fixable due to hypervisor limitation=
s.
> >>>>>> The UEFI specification requires the ESRT to be in EfiBootServicesD=
ata
> >>>>>> memory, which Xen will use for whatever purposes it likes.  Theref=
ore,
> >>>>>> Linux cannot safely access the ESRT, as Xen may have overwritten i=
t.
> >>>>>>
> >>>>>> Starting with Xen 4.17, Xen checks if the ESRT is in EfiBootServic=
esData
> >>>>>> or EfiRuntimeServicesData memory.  If the ESRT is in EfiBootServic=
esData
> >>>>>> memory, Xen allocates some memory of type EfiRuntimeServicesData, =
copies
> >>>>>> the ESRT to it, and finally replaces the ESRT pointer with a point=
er to
> >>>>>> the copy.  Since Xen will not clobber EfiRuntimeServicesData memor=
y,
> >>>>>> this ensures that the ESRT can safely be accessed by the OS.  It i=
s safe
> >>>>>> to access the ESRT under Xen if, and only if, it is in memory of t=
ype
> >>>>>> EfiRuntimeServicesData.
> >>>>>>
> >>>>>
> >>>>> Thanks for the elaborate explanation. This is really helpful.
> >>>>>
> >>>>> So here, you are explaining that the only way for Xen to prevent
> >>>>> itself from potentially clobbering the ESRT is by creating a
> >>>>> completely new allocation?
> >>>>
> >>>> There are surely other ways, e.g. preserving BootServices* regions
> >>>> alongside RuntimeServices* ones. But as the maintainer of the EFI
> >>>> code in Xen I don't view this as a reasonable approach.
> >>>
> >>> Why not?
> >>
> >> Because it's against the intentions the EFI has (or at least had)
> >> for this memory type. Much more than EfiAcpiReclaimMemory this
> >> type is intended for use as ordinary RAM post-boot.
> >=20
> > What about giving that memory to dom0?  dom0=E2=80=99s balloon driver w=
ill give
> > anything dom0 doesn=E2=80=99t wind up using back to Xen.
>=20
> While perhaps in principle possible, this would require special casing
> in Xen. Except for the memory the initrd comes in, we don't directly
> hand memory to Dom0. Instead everything goes through the page allocator
> first. Plus if we really were convinced boot services memory needed
> retaining, then it would also need retaining across kexec (and hence
> shouldn't be left to Dom0 to decide what to do with it).

So how should dom0 handle the various EFI tables other than the ESRT?
Right now most uses of these tables in Linux are not guarded by any
checks for efi_enabled(EFI_MEMMAP) or similar.  If some of them are in
EfiBootServicesData memory, they might be corrupted before Linux gets
them.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--GpPEXFLkdw7UWuLD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmMsd4cACgkQsoi1X/+c
IsEBoA//b/usaepDm+lyniu3r0moNjjY3zaQmtdSXTMeHqFzBrABiAz5AZyBFCtr
wzSdmzo4rlrvNR2/et8taDq0qOcjGouCgWLLS4p5pbW+PkV/0RzLPVCQaanRm+g5
ZKeQbIFHeClEw7c4AWgY1mmlhiSdPYPCpXDdL4NCKeZgSTRykBp4J+Rg6rjwWKHD
NAcWWs5MP6S4uVPVyZJQW4Blp087xPx3y/dFe5Fj3SeV37FDE9mvALy2+eJkDwnb
7EPnOmczl7BSHg6L0xxClF1AFedsP7Ao/ANIs+kAR3EhbKnvczvLgANTMBRo+JUk
Z6JST57bnRNtR4nSs8txTfjA4OqBy6RgJAwzN2lgd9zjZJnUgRVaungMKi0hmanS
QMDtB6EGnCj8m6TaJiISxNjNeK8TQRh11GyNCcFgsUnfi7KlYbybeMnoOOWg3Hwz
n5xXPsO9YSplCPsJ+aqfKp5yhUoE7ePskiGzyRThLBzx5HMgM/qFnXvtvi2/cY+G
XEfQo9fWiss6Or47D3ekcw0FtYrU2EKUVsVEmRR0f8aRSJl4phCSu9mbU6aikQzK
ADdLyxZ/Cle6oGy44fVcevif3qp/gO5/u3AxegTqBL9Xu9mtz3RyZrDxAaZoLUEh
b6UgO0JZhueI7F9B48R4cKAfOzJ/+9srYZyIZHLQZYPzMDzOaV4=
=tj0J
-----END PGP SIGNATURE-----

--GpPEXFLkdw7UWuLD--
