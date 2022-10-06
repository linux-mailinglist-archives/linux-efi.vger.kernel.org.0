Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5935F5E6B
	for <lists+linux-efi@lfdr.de>; Thu,  6 Oct 2022 03:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiJFBlL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Oct 2022 21:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJFBlK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Oct 2022 21:41:10 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC45922BDC;
        Wed,  5 Oct 2022 18:41:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B1BC35C0078;
        Wed,  5 Oct 2022 21:41:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Oct 2022 21:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1665020466; x=
        1665106866; bh=5JWGlL6qjpOxQyyZ9FB1dSYfeN4n/a+nsPGWR+zeiYc=; b=M
        6og2O85RYor/MEkEK9NUu3wiW+BhmIu4XsJu4ZWKsQ32+PtEx3auXlLV1Vxy7xCx
        SuI29dbENT/pW51oqx/kKeS6rYWGQwO2yuV9nwxF4IQXSPo69Mu4lgacDtNbCOYp
        bHksDrcsO7vbcW+uZ1/Wf70s/W4ScBIsqxe51/dUt0D+yD3h7t+H8qxRp7GF3K5E
        /4VgeIWd24J9IPhs25G7EMJNO8dRhNtn5Aw4zxmYm7gi0oUYz6pACaojGon7jAxF
        +2YE+Es//c6MkE71uARRgLeLOlBu5qv7NvSw5PXWeLh5vVEwKo8aaqVJknV37n4d
        cD2ft0lwigYokY8F72dQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1665020466; x=1665106866; bh=5JWGlL6qjpOxQyyZ9FB1dSYfeN4n
        /a+nsPGWR+zeiYc=; b=IapvrxS+eu9CRM2Y2xpRmwAEBSC07HId3PKvuDlordFq
        FQn0PYGstKTIn1EWy6IVXIsBiQnr5wyq1G0GIAsX3XAUrn0lIOCLn2IK4K2n5OTC
        ELdOXmbc9wR+smndYtDC4+ix/FHk0EvYSjGccIhTRcKnP6o5EZkejB6+fuoIjyF4
        cviqYKjPJwuw3acPHvb+8nrJUcZxsPkMwg2mKliK9ztNYB7lKg405v7U8rqyLOmM
        ynm6gc+s3YcVooFIZYt+T9Rjf1Lrk3t8Txnc3y3JjHGhgJtSjXPA4r1wWPQqMxQm
        QgQXgsN2cI0VH/YhaXOP0pSdMkYwfIVVADA2+5TjWA==
X-ME-Sender: <xms:MjI-Y0MK-kjrVZXrycLY6OoQgV_MAbR9y9PIHIxuls04COsCSIiFmA>
    <xme:MjI-Y6-saI900FsdoMpNk91DHjxo-wuJSng511L3OZ9yMKioyJL633KFRTdz8nYqY
    kAuJNXUWhsQpHE>
X-ME-Received: <xmr:MjI-Y7QYawW0W1P_KkiHSTjB7-0xTVDxzwjuqk3SVwhvCxJ3epBqnVYRHCS4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeigedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepudeileefueetvdelheeuteffjeeg
    jeegffekleevueelueekjeejudffteejkeetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:MjI-Y8uonqngOyQ1TDOcwx7-ZJi0gr1uWyVsWeVAwYOcNsdoEWXjlQ>
    <xmx:MjI-Y8cEnKUQHfG8rFoPIKgLBC-vABsCntJtptGD09gTSlEmvwrKoA>
    <xmx:MjI-Yw1vEyoZd-y5Ech6-96fX-3e4uyELk8VRXQSRiE1sCau-rYNJA>
    <xmx:MjI-Y9VWOZ-b012cWbwraT3IrzSYRvS_471wcRHzbXVqAH4KpMJ2xg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Oct 2022 21:41:05 -0400 (EDT)
Date:   Wed, 5 Oct 2022 21:40:58 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
Message-ID: <Yz4yLyvX6un1rrqC@itl-email>
References: <282a225d-8782-0321-6f0e-19dd4510dc42@suse.com>
 <CAMj1kXFQNqsW5RfHGac-eGbosJHBybu6+-Fap_bi_kVxWNpGeg@mail.gmail.com>
 <YzcjeiOW8+i2Zxsd@itl-email>
 <CAMj1kXHBBbCNV3CLesqZi7ttmmi8y4tZ1KO5vievy_CJrU2o3Q@mail.gmail.com>
 <YzeaKjmls1YI/3ox@itl-email>
 <01d22092-8292-8ed7-ece7-9ca32d15bbce@suse.com>
 <YzxxXuovwQt3NskE@itl-email>
 <a0dc1158-01b1-4272-b86e-52f4996f0747@suse.com>
 <Yz3I2qwl243h9ZfZ@itl-email>
 <CAMj1kXHFi71SKQAQHEjZTLyp-YooRTYZ2-nqydRZA5hys7tkKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O1bm1sqCXF+z9Gl5"
Content-Disposition: inline
In-Reply-To: <CAMj1kXHFi71SKQAQHEjZTLyp-YooRTYZ2-nqydRZA5hys7tkKw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--O1bm1sqCXF+z9Gl5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 5 Oct 2022 21:40:58 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered

On Wed, Oct 05, 2022 at 11:28:29PM +0200, Ard Biesheuvel wrote:
> On Wed, 5 Oct 2022 at 20:11, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > On Wed, Oct 05, 2022 at 08:15:07AM +0200, Jan Beulich wrote:
> > > On 04.10.2022 17:46, Demi Marie Obenour wrote:
> > > > Linux has a function called efi_mem_reserve() that is used to reser=
ve
> > > > EfiBootServicesData memory that contains e.g. EFI configuration tab=
les.
> > > > This function does not work under Xen because Xen could have already
> > > > clobbered the memory.  efi_mem_reserve() not working is the whole r=
eason
> > > > for this thread, as it prevents EFI tables that are in
> > > > EfiBootServicesData from being used under Xen.
> > > >
> > > > A much nicer approach would be for Xen to reserve boot services mem=
ory
> > > > unconditionally, but provide a hypercall that dom0 could used to fr=
ee
> > > > the parts of EfiBootServicesData memory that are no longer needed. =
 This
> > > > would allow efi_mem_reserve() to work normally.
> > >
> > > efi_mem_reserve() actually working would be a layering violation;
> > > controlling the EFI memory map is entirely Xen's job.
> >
> > Doing this properly would require Xen to understand all of the EFI
> > tables that could validly be in EfiBootServices* and which could be of
> > interest to dom0.  It might (at least on some very buggy firmware)
> > require a partial ACPI and/or SMBIOS implementation too, if the firmware
> > decided to put an ACPI or SMBIOS table in EfiBootServices*.
> >
> > > As to the hypercall you suggest - I wouldn't mind its addition, but o=
nly
> > > for the case when -mapbs is used. As I've indicated before, I'm of the
> > > opinion that default behavior should be matching the intentions of the
> > > spec, and the intention of EfiBootServices* is for the space to be
> > > reclaimed. Plus I'm sure you realize there's a caveat with Dom0 using
> > > that hypercall: It might use it for regions where data lives which it
> > > wouldn't care about itself, but which an eventual kexec-ed (or alike)
> > > entity would later want to consume. Code/data potentially usable by
> > > _anyone_ between two resets of the system cannot legitimately be freed
> > > (and hence imo is wrong to live in EfiBootServices* regions).
> >
> > I agree, but currently some such data *is* in EfiBootServices* regions,
> > sadly.  When -mapbs is *not* used, I recommend uninstalling all of the
> > configuration tables that point to EfiBootServicesData memory before
> > freeing that memory.
> >
>=20
> That seems like a reasonable approach to me. Tables like MEMATTR or
> RT_PROP are mostly relevant for bare metal where the host kernel maps
> the runtime services, and in general, passing on these tables without
> knowing what they do is kind of fishy anyway. You might even argue
> that only known table types should be forwarded in the first place,
> regardless of the memory type.

Which tables are worth handling in Xen?  I know about ACPI, SMBIOS, and
ESRT, but I am curious which others Xen should preserve.  Currently, Xen
does not know about RT_PROP or MEMATTR; could this be a cause of
problems?
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--O1bm1sqCXF+z9Gl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM+Mi8ACgkQsoi1X/+c
IsFC3Q/+LInS5fyLV5q0WDsphEUWJpSm3d2wDWvD98SyzEt/5YAunxvLkGFXYcLS
P8Q2FOVyDqmBG457YSSZSS8Qt0EPxbntfAIgJT6c81xrAYpAFFHfblt1uHnrnzBJ
5iGIkr1j184qHSf/iK8xlaxFe2eZDjZM3Y0RFGeII6+RdqmF8Wm1yd2+JlVEqGgO
GSHwnQtt+Ut5ahm7+XKh6CdyMOeP7A7Z8+AVk74mFvWrCrJQgDPvXCAxQYX2EXCw
TrMvLfhv4RBOOaMmCcLevbEs+3MbQ7owXtiMS0uydsezCedtWoyS9tcQdFzuJHfX
h68Aj+kiVe07m/9Gpx43Ed+C+k4aNXqja9skqUhqStUigzOzX0Q/tNsSZV7nlyhL
xYmlU+pdkPSNK8cXngU/OK1GjZLoNs5oc+pGT6oIq5ipWaZpO4eLriu1lMBWSS6s
iExS7Awf7owOnc6AjaaiIRIN0W7NJ7auK10lCXX9IjzlOp9WCfA9xNLXuMQHNxCr
gj0r+7UbcQAQP7bDRYIS/lddXF3jiubTiYeuQIdG2Y/+mIg1x1EZcNApa3rVsrSN
xM9ex0yrDJxj9EODFHvIF9K8meqbQKTbBKtLE86Kmz6LzU4B0qwq1eQHc1M/Mo/L
glmKRPDzx+ys9qrdIVnBCoMRNFpqK8+ybCzZ4TFHDLhht4N6iBE=
=+br+
-----END PGP SIGNATURE-----

--O1bm1sqCXF+z9Gl5--
