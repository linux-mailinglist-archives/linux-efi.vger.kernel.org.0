Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E195D5F108E
	for <lists+linux-efi@lfdr.de>; Fri, 30 Sep 2022 19:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiI3RMc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Sep 2022 13:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiI3RMb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Sep 2022 13:12:31 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49AD1B0E28;
        Fri, 30 Sep 2022 10:12:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 57A833200A35;
        Fri, 30 Sep 2022 13:12:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 30 Sep 2022 13:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664557948; x=
        1664644348; bh=SmV33aTbZLMaSc7e6x6/a0yD1YxjcfyZWd4pX2uyxNI=; b=u
        pjub1rvphcp2BMPPN6KmzumKuGefLUM0bp0cVVJSfuTe+Og2D+VZzMDUA3IlqOOI
        46cWvOn4Piowd35V+LAQz3UNHY+7bOT5QJnX8RbTeDi8fJTORVfaRttziHhUXzIP
        3Ncp91P5Wc31GMsotZmhgvVKodWCCkCuX6iKyexRpaPicUcg4p6/aB5uAOPvIB58
        vi8TaEsBy9RMnslMiJORLxTkvwcqiyL84H6FVONEoJg9sc7mL4z3c21AmFaJDCrh
        Q1fbpOWck9E9wDjO70BhxUjsfFcbEX9dQJ/WhdK4VeRpmE0HO3Ct9z7JrivxJD77
        t2drz5P7gpFGrc8I+TIYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664557948; x=1664644348; bh=SmV33aTbZLMaSc7e6x6/a0yD1Yxj
        cfyZWd4pX2uyxNI=; b=MfoCeDlA0AzErgpeRbND50svu3p1X6qY5uB1ykZoN2Lp
        4jNTzojKDLLTEUu/DLSBWJuuK3KLP7cuUywLuZOEzd6ttE+iklRiabpAm0Tc+Ddr
        qU4lQdua9KF9BtePgXlviNc+EFvuWmCiMlhmnzbhioQXznJdJppc7OkhTe6JedmN
        NCG6lavcPLHcSWniFut3ZUa1PfFzfSLr3TMvcDh1FaAxBrqVRU0wlD4fEfcXmLtN
        aCicyEH5Q50Vry9j/HBKoA0XdizN/OZchTX2JnQk/NSQCkJeX4xi3Cg+Ttz73OW2
        +8sKOWQws3ibpwiIHH4VF4OAF9AxOIeDTFRNtK6Uiw==
X-ME-Sender: <xms:fCM3Y1Dfb7_HPSao6DB7VSdR8LyLwTedXVtb3L7EAHR6N05iogpskw>
    <xme:fCM3YzgR-or-YoVsz9FWRS2sRbWrFrDulYyvPnNRR-XPscAQrQwXx6rgtmrh10pQg
    3ONvqu3I8NmN_8>
X-ME-Received: <xmr:fCM3Ywn98T69EXkNJ9R4TOaKZKGl-Fi_T64O0-FgE-R6OR1XJETbBuvN_s0j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehvddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffej
    geejgeffkeelveeuleeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:fCM3Y_w-jo0WAVysk4mcybB6bczG1GvHmnqoWG9U9Nbn12u_3uyYUw>
    <xmx:fCM3Y6T9uubU5A9ks5pQufP4UQNm1Vtzncv4gK2iq2tdI-FPiFKSCQ>
    <xmx:fCM3Yybzlcm9CBBBgC9W2FXWSPv6WiQdaoHRZP7xeITlpKqH--Ryxw>
    <xmx:fCM3Y_JALAp8QmyP1KprmAp3d_6gZgXzzzxEWEcyub_lJzEjhjr2eA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Sep 2022 13:12:27 -0400 (EDT)
Date:   Fri, 30 Sep 2022 13:11:59 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Jan Beulich <jbeulich@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
Message-ID: <YzcjeiOW8+i2Zxsd@itl-email>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
 <282a225d-8782-0321-6f0e-19dd4510dc42@suse.com>
 <CAMj1kXFQNqsW5RfHGac-eGbosJHBybu6+-Fap_bi_kVxWNpGeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+TWbr9kogh5/wchI"
Content-Disposition: inline
In-Reply-To: <CAMj1kXFQNqsW5RfHGac-eGbosJHBybu6+-Fap_bi_kVxWNpGeg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--+TWbr9kogh5/wchI
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Sep 2022 13:11:59 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>, Jan Beulich <jbeulich@suse.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered

On Fri, Sep 30, 2022 at 06:30:57PM +0200, Ard Biesheuvel wrote:
> On Fri, 30 Sept 2022 at 08:44, Jan Beulich <jbeulich@suse.com> wrote:
> >
> > On 30.09.2022 01:02, Demi Marie Obenour wrote:
> > > Memory of type EFI_CONVENTIONAL_MEMORY, EFI_LOADER_CODE, EFI_LOADER_D=
ATA,
> > > EFI_BOOT_SERVICES_CODE, and EFI_BOOT_SERVICES_DATA may be clobbered by
> > > Xen before Linux gets to start using it.  Therefore, Linux under Xen
> > > must not use EFI tables from such memory.  Most of the remaining EFI
> > > memory types are not suitable for EFI tables, leaving only
> > > EFI_ACPI_RECLAIM_MEMORY, EFI_RUNTIME_SERVICES_DATA, and
> > > EFI_RUNTIME_SERVICES_CODE.  When running under Xen, Linux should only
> > > use tables that are located in one of these types of memory.
> > >
> > > This patch ensures this, and also adds a function
> > > (xen_config_table_memory_region_max()) that will be used later to
> > > replace the usage of the EFI memory map in esrt.c when running under
> > > Xen.  This function can also be used in mokvar-table.c and efi-bgrt.c,
> > > but I have not implemented this.
> > >
> > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> >
> > In Xen we don't clobber EfiBootServices{Code,Data} when xen.efi was pas=
sed
> > "-mapbs". Should we perhaps extend the interface such that Dom0 can then
> > also use tables located in such regions, perhaps by faking
> > EFI_MEMORY_RUNTIME in the attributes returned by XEN_FW_EFI_MEM_INFO?
> >
>=20
> I know this ship has sailed for x86, but for the sake of other
> architectures, I'd strongly recommend leaving the EFI_MEMORY_RUNTIME
> bits alone, for the same reasons I gave earlier. (Runtime mappings for
> the firmware code itself, page table fragmentation etc etc)

Why do you say that it has sailed for x86?

> I know very little about Xen, but based on the context you provided in
> this thread, I'd say that the best approach from the Xen side is to
> convert all EfiBootServicesData regions that have configuration tables
> pointing into them into EfiAcpiReclaimMemory.

Should Xen convert the entire region, or should it try to reserve only
the memory it needs?  The latter would require it to parse the
configuration tables.  Is there a list of configuration tables that can
legitimately be in EfiBootServicesData regions?

> I take it XEN_FW_EFI_MEM_INFO is an existing interface? If so, you
> might do the same for the returned type - EfiBootServicesData ->
> EfiAcpiReclaimMemory, and not muck about with the EFI_MEMORY_RUNTIME
> attribute.

It is indeed an existing interface, and this is a much better idea than
what you proposed.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--+TWbr9kogh5/wchI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM3I3kACgkQsoi1X/+c
IsHimRAAopJdHd1YzyxGmCQs/5C27GsZ6O2Z2oo4shynl65qxosa4wjyQ+hf0uBh
9UUbiWVqVuQHlw2SNR4RklZ9a4lVENb85rfkvFkGkb5JrGVU7PgCpYsNZJ0ZSDiW
SW4w4QR87BwF23Bk6GEiCL+dWTq1wH4iq89tX/S1LhvjaAh88tMf6Xm2lKuS2nek
EjfjWnWDtHLoj7K7M09b5m/8ofqofqiLvqCup6JRvambXHezEEgisxE3FeX3jmOA
Iw8e656o0sia+GK1mMfa1vf7+lHt+bmULbM9Qtjh4OzAim7NIycRj+8mNfnXmhWW
2hozW1E5ALre+lmdDuV9cRStlRmaXVv7YXNav+ia36xMDcxsTQP6V1scmdbkKk29
GxGq8fIU9ySZXmtrygIAF+RU4V4BLe72sqee/K+FcnHcUqJ6WaHW1TYP57eDNfoL
XThEJy7ZSwhVn7KxtQhr16aqysit7XeVr1OjRooP8ju5DouAumAdpEqZTUO8ruLH
dg2AN5DlD3WB8g5x5jFc/UHRvF5cEbNawEfEO6wkPVFozynIDXdvWQDQ/+0t5LnB
TbrEnfoeuiGn5PMB0paCrQKdr4mOxyZHe/EigAEhnMkWo4QyseG6yBme+Ee6N7sv
3A3g8YohKWHsRxRPHc7cdgVjAgc5Wsb1SlNNdgYwBVxW2udbzJ8=
=ag4U
-----END PGP SIGNATURE-----

--+TWbr9kogh5/wchI--
