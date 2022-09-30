Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D50F5F11D2
	for <lists+linux-efi@lfdr.de>; Fri, 30 Sep 2022 20:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiI3Svg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Sep 2022 14:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiI3Svf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Sep 2022 14:51:35 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A5C15ED1E;
        Fri, 30 Sep 2022 11:51:34 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 016DA32009EF;
        Fri, 30 Sep 2022 14:51:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 30 Sep 2022 14:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664563892; x=
        1664650292; bh=fYpDprIN3a0QBYjQ4tUxQgz2zg/uZs+W5f8j5BODhiU=; b=n
        QJzj1FvmL8Kwk0PhtwriiOt+wNGQq+LIzGENkfG+EsF0IRd5Xw7WtfGA+DDsCe9p
        +PpQuFwBbGpwjIuutkWKiOyKiGGOncOghxsAjoD3BjuUTOmbYrq+oupT7fNICvVS
        0hK2inyzRhkzO+E0wbOjer52jWrojjLB6G77fcK5OkeKA03rvsV4APnf2l4tacqd
        CoI6hS7q6gYq6q4tWmMbRMfQ46VpkWBNJMABJ55mVhtYnMgaeCPcmkbHN+GTEe4V
        Fkp3qrz4gxY2VC0/WUmzVnV1kXw3tjH93jNHjb8IWZvsJYBox+JG11zaONzqCl6R
        iXfOpR5rk8uJQ9ue82v5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664563892; x=1664650292; bh=fYpDprIN3a0QBYjQ4tUxQgz2zg/u
        Zs+W5f8j5BODhiU=; b=viHjFCA0aDXrouvCHGo4zHi8dFMSnEOyn5bXsrYmOkm3
        0baiUtYd8KEB/pBkUIjkCNpA5+HJzbrodX6VySobo+jVIBpkDvnDJB0Ti/za0YXY
        e8OvS9lIsJ+YDm6EjAeana9Zo5VDMaPAv5i91rNfZ/M5NvczcRf8B9S1zSDbo/lF
        DkpyZhKmCRNctXCIONbhz6Y3O0/o6fpJA+6sbqbaVeyyYCo2UOitS8+Y2865UlzR
        DiCS4ztWciFzRAZJCAiZ6rqU61ILmh0IXHiRKmxH1K+IQMH9BVGwgrWezBS522MS
        ICrneDu/OZRCLEoQjMrSEDbvEoUz8skyy0hl3vIEmA==
X-ME-Sender: <xms:tDo3YyPmH2c6vTOUY-l5OA4LVjur41pvtfmBfHSd9cl39tN8IFrKUw>
    <xme:tDo3Yw-Lklt5a_55HvLqaruzui7CcNB1X1rT0L56oVnHXkPD7PoqX63AqLyHzp2YE
    FFjw8u4lVPQW4k>
X-ME-Received: <xmr:tDo3Y5QHidEWTHO_95x4HxCWEf_GqpmUQlFgqWqRcSHyYHDp7Q59e2_o0C5->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehvddgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffej
    geejgeffkeelveeuleeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:tDo3Yyueeu3bxSDliKYu8chBS-iZcQYSOIMEhyLt8DUYT-5RpDwQPg>
    <xmx:tDo3Y6e-N52sIat_MnXVRT7W8KRcuUPu3CFL2G8PsKqBlhkcSejb5w>
    <xmx:tDo3Y23T4BqkRwlvlCNfFnisuyPORMjn0jZ5rO42UprX1sdMJzku4A>
    <xmx:tDo3Y7VIt-4UumDF28CNY2of1s0rjr_kYBMXTGVQcH-qf3xQINUNaQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Sep 2022 14:51:31 -0400 (EDT)
Date:   Fri, 30 Sep 2022 14:50:40 -0400
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
Message-ID: <Yzc6sh9mQlA+InwK@itl-email>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
 <282a225d-8782-0321-6f0e-19dd4510dc42@suse.com>
 <CAMj1kXFQNqsW5RfHGac-eGbosJHBybu6+-Fap_bi_kVxWNpGeg@mail.gmail.com>
 <YzcjeiOW8+i2Zxsd@itl-email>
 <CAMj1kXHBBbCNV3CLesqZi7ttmmi8y4tZ1KO5vievy_CJrU2o3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n+z3R9W5aeSXpiDo"
Content-Disposition: inline
In-Reply-To: <CAMj1kXHBBbCNV3CLesqZi7ttmmi8y4tZ1KO5vievy_CJrU2o3Q@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--n+z3R9W5aeSXpiDo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Sep 2022 14:50:40 -0400
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

On Fri, Sep 30, 2022 at 08:27:09PM +0200, Ard Biesheuvel wrote:
> On Fri, 30 Sept 2022 at 19:12, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > On Fri, Sep 30, 2022 at 06:30:57PM +0200, Ard Biesheuvel wrote:
> > > On Fri, 30 Sept 2022 at 08:44, Jan Beulich <jbeulich@suse.com> wrote:
> > > >
> > > > On 30.09.2022 01:02, Demi Marie Obenour wrote:
> > > > > Memory of type EFI_CONVENTIONAL_MEMORY, EFI_LOADER_CODE, EFI_LOAD=
ER_DATA,
> > > > > EFI_BOOT_SERVICES_CODE, and EFI_BOOT_SERVICES_DATA may be clobber=
ed by
> > > > > Xen before Linux gets to start using it.  Therefore, Linux under =
Xen
> > > > > must not use EFI tables from such memory.  Most of the remaining =
EFI
> > > > > memory types are not suitable for EFI tables, leaving only
> > > > > EFI_ACPI_RECLAIM_MEMORY, EFI_RUNTIME_SERVICES_DATA, and
> > > > > EFI_RUNTIME_SERVICES_CODE.  When running under Xen, Linux should =
only
> > > > > use tables that are located in one of these types of memory.
> > > > >
> > > > > This patch ensures this, and also adds a function
> > > > > (xen_config_table_memory_region_max()) that will be used later to
> > > > > replace the usage of the EFI memory map in esrt.c when running un=
der
> > > > > Xen.  This function can also be used in mokvar-table.c and efi-bg=
rt.c,
> > > > > but I have not implemented this.
> > > > >
> > > > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > >
> > > > In Xen we don't clobber EfiBootServices{Code,Data} when xen.efi was=
 passed
> > > > "-mapbs". Should we perhaps extend the interface such that Dom0 can=
 then
> > > > also use tables located in such regions, perhaps by faking
> > > > EFI_MEMORY_RUNTIME in the attributes returned by XEN_FW_EFI_MEM_INF=
O?
> > > >
> > >
> > > I know this ship has sailed for x86, but for the sake of other
> > > architectures, I'd strongly recommend leaving the EFI_MEMORY_RUNTIME
> > > bits alone, for the same reasons I gave earlier. (Runtime mappings for
> > > the firmware code itself, page table fragmentation etc etc)
> >
> > Why do you say that it has sailed for x86?
> >
>=20
> The x86 EFI code in Linux makes changes to the EFI memory map in many
> different places in the code. On other architectures, we have managed
> to avoid this, so that the EFI memory map is always identical to the
> one provided by the firmware at boot.
>=20
> > > I know very little about Xen, but based on the context you provided in
> > > this thread, I'd say that the best approach from the Xen side is to
> > > convert all EfiBootServicesData regions that have configuration tables
> > > pointing into them into EfiAcpiReclaimMemory.
> >
> > Should Xen convert the entire region, or should it try to reserve only
> > the memory it needs?  The latter would require it to parse the
> > configuration tables.  Is there a list of configuration tables that can
> > legitimately be in EfiBootServicesData regions?
> >
>=20
> Not really, no.

Is there a list of tables that can be in EfiBootServicesData and which
Linux cares about?

> So you would have to convert the entire region
> /unless/ Xen knows the GUID, and therefore knows how to derive the
> size of the table, allowing it to reserve memory more conservatively.

My worry is that this will wind up being equivalent to mapping all (or
most) of EfiBootServicesData memory.

> However, I doubt whether this is worth it: splitting entries implies
> rewriting the memory map, which is a thing I'd rather avoid if I were
> in your shoes.

Xen actually uses a different approach: instead of rewriting the memory
map, it uses the EFI pool allocator to allocate memory of the desired
type, copies the table to the newly allocated memory, and installs the
new table in place of the old one.  That only works for tables Xen
understands, though.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--n+z3R9W5aeSXpiDo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM3OrEACgkQsoi1X/+c
IsFXVw//fXEjFMwU9Qb0gHHWn8DmCyj0+4RN+aQXRl+6ZAQ++x44gm2ltJs7G9xS
wnTtwQruHfGhQZKtFxFANBBSGEcpnZCPjRdjphnsmsAwq+bLEPEEW32XQJqNTrRX
WD+Zor4IM35Mi+rX8o5+V5MfeNt6GnKUYd9AE7o/9+mOK6VwSGG+hbRsbhDqN7+6
d4mJO6lv44jepmB7Kr5RsmCSbBdhVomq7wI4Lp35pDmWxUm7FYT89eGGV1uZC3ew
J6Gyl3V1I2w+ioDC4ap6wMMsIfv10m7JQ9s0/tArE7tjQ6PcxtazO+DuI6B2tce2
icXbKXzaKpnhHGECV+k+brhXLLpNbSTPLiMRA8zkbRQpHFmvEdxtNv6gqyUZTGfp
REFFselwm4RSiNDTXZgq4xA+ZR9B5FapuihyD0ka94EjMvOgo+U7Q9p3qy1edcC6
4LbwGiQ02fdlxKKF61RB2NX4YJf9Im/98jzUxZ5Z5ke36fy7osSlJsfO4/E/MOjf
dO2cEyt08MyDFUt/pcPriE3ZPNKqVncHEArv6cHwOhLDbBRAKe4w8S+0ul7ebGP5
WTzPiLBxioOD750zg354ULE78WikH/5Ir8H3zvTSG52/76dgZKUodOUiuhOXmHOu
BZc7XikDleUdGinwUR7SBf0cYqjHhucnJ9wusRtj4vODQaQ7a0o=
=nfqH
-----END PGP SIGNATURE-----

--n+z3R9W5aeSXpiDo--
