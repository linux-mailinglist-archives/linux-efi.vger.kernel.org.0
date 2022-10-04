Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E0C5F48DE
	for <lists+linux-efi@lfdr.de>; Tue,  4 Oct 2022 19:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJDRqT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Oct 2022 13:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJDRqP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Oct 2022 13:46:15 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5839265661;
        Tue,  4 Oct 2022 10:46:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E91E85C0061;
        Tue,  4 Oct 2022 13:46:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 04 Oct 2022 13:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664905569; x=
        1664991969; bh=j1co2OtJjD7/vRKiHmQIV5tJWRkOaG0PZ91t7wBXB08=; b=b
        uVrn8e+X1yqcOFjSdZ2m0JtalxHee6ojtu6uxKe2dDP+PxZK0d4EdjiwOzV1qD4P
        DRVAYGUMQ46TQC79a8IgLyHmrHkLVd2QC5Vh5U1sE6FSxORGTmm75y1OZPH4v3Vd
        YOLDu2vqHupepX7WrjQlIbP64gbNo74NPBaE9ptLsTN4N/H6wPSoX22bYYkocbQQ
        eBJdolRQRQ+gKVKXvoWTloGYDF96rStVcIi3tu6nLwCY7+e5cYf9AS6ic37tTWwB
        OPGG3OG53Cp8Uk+VotAEbArlv+FOPRBZJyJbmdwdz7CeQ3B8je1pPvah42Ro7xAq
        mdOcG7DJ4DYF4qSZTmcaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664905569; x=1664991969; bh=j1co2OtJjD7/vRKiHmQIV5tJWRkO
        aG0PZ91t7wBXB08=; b=r4NdtuS3BOGr1usAHz1Iam2a95O9RnYq7uMZgqz6NPeC
        nmMgdbtqLBMJnydm3qRndZlnAI3JbV9SfcpY8aOYVwUJAkvZ9kc6sVQzglGI2yhO
        QmeBnPcU9NGkjl0yaJYbbzUTK490oMT9O3dRHta7GTJaJIAk4e6Kjse5jHVJUY/n
        fPlp2xHEHi2pVd/ti0qIJSASo78Tq4DoB2X6G9Wk9/t6e2S7Asj84T4bUfXXxHmS
        KhReL40qlqq/E5fWtontKTbYRpX42iVuQxjz3SikwRfvGUmaTgpduEcpwdsD2eoY
        KuSYRzIidx4UXsGyaNuTZeBYOGE3wIjELfzfOpmR5A==
X-ME-Sender: <xms:YXE8Y0_4RjLdTf4ZcV3fxbvSMSn51U_1XUAaIwoevXDni-ON5oKuIg>
    <xme:YXE8Y8vPGN5s4wWa0od220jNPMKCiaoBRECXsL7M9GsxjZlKf6ebq3m8iy0TgcCec
    0EqTyUiCBEXdAY>
X-ME-Received: <xmr:YXE8Y6AzxWvyrFtxe7TD7bo8JZ4ZV9K8qRldsUwxoQmS5X1lUQ9yc7B5yusd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiuddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:YXE8Y0cnvKuzY9DZ5FXWtpTEg2aicizrW0DVgeZ68EWorWDULA0Amg>
    <xmx:YXE8Y5NHHi7xxVk1ilJLeztFNySAVGgT99HRbkiFBWa3Gi84A9QyFg>
    <xmx:YXE8Y-knnc0OzmocImv-2pqZrzV2gA0TwN6wY7aPiktQ8QgGVy01Pw>
    <xmx:YXE8Y6HkQRHwNpRt3pYXDU_S_MQHBaR7CF7e4NSV-pAhw9LOJGDbog>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Oct 2022 13:46:08 -0400 (EDT)
Date:   Tue, 4 Oct 2022 11:46:59 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
Message-ID: <YzxxXuovwQt3NskE@itl-email>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
 <282a225d-8782-0321-6f0e-19dd4510dc42@suse.com>
 <CAMj1kXFQNqsW5RfHGac-eGbosJHBybu6+-Fap_bi_kVxWNpGeg@mail.gmail.com>
 <YzcjeiOW8+i2Zxsd@itl-email>
 <CAMj1kXHBBbCNV3CLesqZi7ttmmi8y4tZ1KO5vievy_CJrU2o3Q@mail.gmail.com>
 <YzeaKjmls1YI/3ox@itl-email>
 <01d22092-8292-8ed7-ece7-9ca32d15bbce@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lgxbz4vBgheHS+D8"
Content-Disposition: inline
In-Reply-To: <01d22092-8292-8ed7-ece7-9ca32d15bbce@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--lgxbz4vBgheHS+D8
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 4 Oct 2022 11:46:59 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered

On Tue, Oct 04, 2022 at 10:22:13AM +0200, Jan Beulich wrote:
> On 01.10.2022 02:30, Demi Marie Obenour wrote:
> > On Fri, Sep 30, 2022 at 08:27:09PM +0200, Ard Biesheuvel wrote:
> >> On Fri, 30 Sept 2022 at 19:12, Demi Marie Obenour wrote:
> >>> On Fri, Sep 30, 2022 at 06:30:57PM +0200, Ard Biesheuvel wrote:
> >>>> I know very little about Xen, but based on the context you provided =
in
> >>>> this thread, I'd say that the best approach from the Xen side is to
> >>>> convert all EfiBootServicesData regions that have configuration tabl=
es
> >>>> pointing into them into EfiAcpiReclaimMemory.
> >>>
> >>> Should Xen convert the entire region, or should it try to reserve only
> >>> the memory it needs?  The latter would require it to parse the
> >>> configuration tables.  Is there a list of configuration tables that c=
an
> >>> legitimately be in EfiBootServicesData regions?
> >>>
> >>
> >> Not really, no. So you would have to convert the entire region
> >> /unless/ Xen knows the GUID, and therefore knows how to derive the
> >> size of the table, allowing it to reserve memory more conservatively.
> >> However, I doubt whether this is worth it: splitting entries implies
> >> rewriting the memory map, which is a thing I'd rather avoid if I were
> >> in your shoes.
> >=20
> > I actually wonder if Xen needs to reserve *all* of EfiBootServicesData.
> > The reason is that some (probably buggy) firmware may store ACPI tables
> > there, and Xen does not have an ACPI implementation.
>=20
> We already have the -mapbs option as a workaround in such situations.

The problem is that there is no way for the user to know when it is
needed.  One option would be for dom0 to print a warning in the kernel
log if it needs to ignore a table due to it being in EfiBootServicesData.

> >  From my
> > perspective, a much safer approach would be to pass all of
> > EfiBootServicesData memory directly to dom0, and have dom0 give Xen back
> > what it doesn=E2=80=99t wind up using.  That allows dom0=E2=80=99s memo=
ry reservation
> > code to work properly, which it currently does not.
>=20
> As said already on a different thread: Giving memory to domains (incl
> Dom0) isn't related to their original memory type (neither EFI's nor
> E820's); the needed memory is taken from the general page allocator
> (with one exception for initrd, to avoid unnecessary copying around of
> data). Hence what you propose would end up as an (imo) awful hack in
> Xen. I also don't see how this relates to "dom0=E2=80=99s memory reservat=
ion
> code", but I'm sure you can clarify that for me.

Linux has a function called efi_mem_reserve() that is used to reserve
EfiBootServicesData memory that contains e.g. EFI configuration tables.
This function does not work under Xen because Xen could have already
clobbered the memory.  efi_mem_reserve() not working is the whole reason
for this thread, as it prevents EFI tables that are in
EfiBootServicesData from being used under Xen.

A much nicer approach would be for Xen to reserve boot services memory
unconditionally, but provide a hypercall that dom0 could used to free
the parts of EfiBootServicesData memory that are no longer needed.  This
would allow efi_mem_reserve() to work normally.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--lgxbz4vBgheHS+D8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM8VY8ACgkQsoi1X/+c
IsHLdA/+LM4HOMK+UqW8ug41g4/DBfgbjzO9EIOgBAXcDsotBsE2hgv+29Nd8k2/
x08K8YAFtt6tgef77/ZH2pFmtCbY3v9AbO+Y0AUn6TD8ownHkXRvQZcH4f+/q1qu
I/eMEvBHn2+Tcl5NLk8JbIj+iufNcZsgvuPxO5Bn6L6cs3uLKey68T+iBN1djFNc
LrhecxdhCSa1096qkvxAn6d7RRQcplv1//S4LXrCjt3q77T4Dg7y8sPcqDQw98W1
QW+6l9GDwVr0EDWse00UkigGhQK+GP3bEv3ucJoxiDFYCAQy24sOTBL/m4wfcZmv
t/43wgXv9010fUACW0Fl0kgKPWMKCMfUM1d7VLEj4GkWLaN41C8eZc5EBj5p37Df
AR1xqfFhR3X50gACUUyoUVfLw2LbohUdzmqncPIAhFOYnrZ4/EfaQjHEq1EMHsPi
X0ocJZhndjM12OXOgLpYdijTZ/1fl6LtYmEULzGdDP1ANinE85ihHsBmLOfUMF+R
MOsy9XDSKzYpi1naZ0Pt+hJzEsEmzoxV7JytqBSxCKihGlnsFf6PPF+eKa3UnFyp
ji4rdgWVtUqhrPa8SWHaxiNhTnNJSZ7VDYbj7hkwejS6dk08ZXmcfHmKDRo3FflR
Y4PVJCITmoxzY63hLDFPN5bDwiEYqRAVlHpsix40rjxGDMDq7EM=
=u0CQ
-----END PGP SIGNATURE-----

--lgxbz4vBgheHS+D8--
