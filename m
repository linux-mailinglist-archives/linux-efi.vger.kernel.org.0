Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ABA5F69E0
	for <lists+linux-efi@lfdr.de>; Thu,  6 Oct 2022 16:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiJFOnz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Oct 2022 10:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiJFOnx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Oct 2022 10:43:53 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C26AA3DA;
        Thu,  6 Oct 2022 07:43:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 965935C0159;
        Thu,  6 Oct 2022 10:43:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 06 Oct 2022 10:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1665067430; x=
        1665153830; bh=RIza5YEVq9kGHVwK/oXAKTC2G5qfFHbR5jwJnE/LvGw=; b=C
        jpqpAwYRLFwlef2LBQuo3eS2s8bXcvx+1/IziZsuDx8Vl8op9+rskQHaEc51kOqW
        Tq4M1/kHTCZJx3GLXcxnaP4VwiD7ZADzZwPT2AXOAh2ZfID+tgpSGaxu41k1PgNE
        zl8+gz42Xm1du7ERR3/i3/ch0tLQbt5kLQ/TsVl3o9woTUuLs8uPEk5Meob5gPIk
        oDMjnZd3F0BwwFMoXleO/s8AxS7c+DdH7oMWM437m6zipP0JLpg6+BvUQ6O/bs6s
        M+PBj4wC3dIBcsjuKafzNHK3Fx1+rDOQP/YGCfh8QI+eG7EAQFafXaL2tlbq8cmP
        d5bQYgE1CzCwDQintM7hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1665067430; x=1665153830; bh=RIza5YEVq9kGHVwK/oXAKTC2G5qf
        FHbR5jwJnE/LvGw=; b=0hXUyPVrVcGDGumEK8ou1p8RxJdVW1wBRrK6sht0NZfQ
        51CbSsYGroAOJzC9yqc6BUNzvz7mpp9SiggJ81smG0DtjJ3YAYItkFQqDe1nUltW
        /EyWb5Zw3H+H3K7eso0EvyH9xhMCisGekBNZq9G7Qmx2BBiP4XStoBFzRRHhzlv2
        EMP1RytYurSl2MM29PFuTZZfzYN6V9BTfLSQv8rbAMKb5b7DeYEbDSMZJ96yCjPl
        ICjMPbLbZhn9sbgzE0s5xKCaK5kk1oWEcSMAkG6cP2E4blMToxbwwT3Xz30ZyAcy
        MKiEFMhmgTruOxBaKvBvOAzbMHs4tCHiDVrCTcI6ag==
X-ME-Sender: <xms:pOk-Y0KDgcCf_xmLcbk33w22a6ontLsPrexU2Z97eQx5DYVjvidhqw>
    <xme:pOk-Y0JL4NdbCAlqtMHoKcWNcYb-_qGp3yLqb7K7-vTx-aor0BlV2r5ANNQEuVisK
    7FPt6glt8IxpnU>
X-ME-Received: <xmr:pOk-Y0uvVQK_1fMoj3OStxcoSj7oZyjf_ZLPyWHFUZhMj55F7GNFDegVr3SP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepudeileefueetvdelheeuteffjeeg
    jeegffekleevueelueekjeejudffteejkeetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:pOk-YxZxAOLfRVAzEhzErTSRJBaCCqz-UkN2U8gXfW_4lbPsW2kw1w>
    <xmx:pOk-Y7auVTCZKDo5JRGnyH6DsT0TFs22rQWy3f44_7dbiVNPGBZi-Q>
    <xmx:pOk-Y9CDIfRzzTVt_AVgsviDafU2t2am1fmB85s4cXXWlKUdprMpZg>
    <xmx:puk-Y4Ra_esZgB9IXtDuUP47nhTJ8FmUXQeEIGWodj9aTzw2Hz2u2w>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Oct 2022 10:43:47 -0400 (EDT)
Date:   Thu, 6 Oct 2022 10:43:43 -0400
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
Message-ID: <Yz7polT2R2OlT1aT@itl-email>
References: <YzcjeiOW8+i2Zxsd@itl-email>
 <CAMj1kXHBBbCNV3CLesqZi7ttmmi8y4tZ1KO5vievy_CJrU2o3Q@mail.gmail.com>
 <YzeaKjmls1YI/3ox@itl-email>
 <01d22092-8292-8ed7-ece7-9ca32d15bbce@suse.com>
 <YzxxXuovwQt3NskE@itl-email>
 <a0dc1158-01b1-4272-b86e-52f4996f0747@suse.com>
 <Yz3I2qwl243h9ZfZ@itl-email>
 <CAMj1kXHFi71SKQAQHEjZTLyp-YooRTYZ2-nqydRZA5hys7tkKw@mail.gmail.com>
 <Yz4yLyvX6un1rrqC@itl-email>
 <CAMj1kXFO9_yMw=_Fn2DBGgdYXgiK_OqafG5+TbJv1UKO1uQiJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZVyM5aEaeTsHYcp0"
Content-Disposition: inline
In-Reply-To: <CAMj1kXFO9_yMw=_Fn2DBGgdYXgiK_OqafG5+TbJv1UKO1uQiJQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--ZVyM5aEaeTsHYcp0
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 6 Oct 2022 10:43:43 -0400
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

On Thu, Oct 06, 2022 at 09:31:47AM +0200, Ard Biesheuvel wrote:
> On Thu, 6 Oct 2022 at 03:41, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > On Wed, Oct 05, 2022 at 11:28:29PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 5 Oct 2022 at 20:11, Demi Marie Obenour
> > > <demi@invisiblethingslab.com> wrote:
> > > >
> > > > On Wed, Oct 05, 2022 at 08:15:07AM +0200, Jan Beulich wrote:
> > > > > On 04.10.2022 17:46, Demi Marie Obenour wrote:
> > > > > > Linux has a function called efi_mem_reserve() that is used to r=
eserve
> > > > > > EfiBootServicesData memory that contains e.g. EFI configuration=
 tables.
> > > > > > This function does not work under Xen because Xen could have al=
ready
> > > > > > clobbered the memory.  efi_mem_reserve() not working is the who=
le reason
> > > > > > for this thread, as it prevents EFI tables that are in
> > > > > > EfiBootServicesData from being used under Xen.
> > > > > >
> > > > > > A much nicer approach would be for Xen to reserve boot services=
 memory
> > > > > > unconditionally, but provide a hypercall that dom0 could used t=
o free
> > > > > > the parts of EfiBootServicesData memory that are no longer need=
ed.  This
> > > > > > would allow efi_mem_reserve() to work normally.
> > > > >
> > > > > efi_mem_reserve() actually working would be a layering violation;
> > > > > controlling the EFI memory map is entirely Xen's job.
> > > >
> > > > Doing this properly would require Xen to understand all of the EFI
> > > > tables that could validly be in EfiBootServices* and which could be=
 of
> > > > interest to dom0.  It might (at least on some very buggy firmware)
> > > > require a partial ACPI and/or SMBIOS implementation too, if the fir=
mware
> > > > decided to put an ACPI or SMBIOS table in EfiBootServices*.
> > > >
> > > > > As to the hypercall you suggest - I wouldn't mind its addition, b=
ut only
> > > > > for the case when -mapbs is used. As I've indicated before, I'm o=
f the
> > > > > opinion that default behavior should be matching the intentions o=
f the
> > > > > spec, and the intention of EfiBootServices* is for the space to be
> > > > > reclaimed. Plus I'm sure you realize there's a caveat with Dom0 u=
sing
> > > > > that hypercall: It might use it for regions where data lives whic=
h it
> > > > > wouldn't care about itself, but which an eventual kexec-ed (or al=
ike)
> > > > > entity would later want to consume. Code/data potentially usable =
by
> > > > > _anyone_ between two resets of the system cannot legitimately be =
freed
> > > > > (and hence imo is wrong to live in EfiBootServices* regions).
> > > >
> > > > I agree, but currently some such data *is* in EfiBootServices* regi=
ons,
> > > > sadly.  When -mapbs is *not* used, I recommend uninstalling all of =
the
> > > > configuration tables that point to EfiBootServicesData memory before
> > > > freeing that memory.
> > > >
> > >
> > > That seems like a reasonable approach to me. Tables like MEMATTR or
> > > RT_PROP are mostly relevant for bare metal where the host kernel maps
> > > the runtime services, and in general, passing on these tables without
> > > knowing what they do is kind of fishy anyway. You might even argue
> > > that only known table types should be forwarded in the first place,
> > > regardless of the memory type.
> >
> > Which tables are worth handling in Xen?  I know about ACPI, SMBIOS, and
> > ESRT, but I am curious which others Xen should preserve.  Currently, Xen
> > does not know about RT_PROP or MEMATTR; could this be a cause of
> > problems?
>=20
> dom0 only has access to paravirtualized EFI runtime services, so
> consuming RT_PROP or MEMATTR should be up to Xen (they describe which
> runtime services remain available at runtime, and which permission
> attributes to use for the runtime services memory regions,
> respectively)

Xen does not do this right now.  I wonder if this could be the cause of
compatibility issues with various firmware implementations.

> Looking through the kernel code, I don't think there are any that dom0
> should care about beyond ACPI, SMBIOS and ESRT. But as you suggest,
> that means Xen should just mask them in the view of the EFI system
> table it exposes so dom0. Otherwise, the kernel may still try to map
> and parse them.

What about the BGRT and MOKvar?  I agree that Xen should not expose the
others.  Should it just hide the tables, or should it actually uninstall
them?  My intuition is that the second would be technically more
correct, but also more likely to trigger bugs in various firmware
implementations.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--ZVyM5aEaeTsHYcp0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM+6aIACgkQsoi1X/+c
IsFo8RAAgjtyIjW/PLv2jyj2EWtPqAVxnZFx2DTiTcEkOF2+OIcp6PR0K8iOiy7z
017KND97RHNpvCFF1/4smfeo8GW7cx/8H6M+Bk7ZqjyKLb/lJfw66FkNFCF1xER9
ZI6vTxKEfr64htLd4KKNl3isP5DHXFV2ydOW56C+Ztv7TlbvTiO/ZrsnZQFTvTpj
YafEHAmdIUveoL6/rg6at0bjhqrDYwbeAIAN/6l/ZDDTuLyn3cV6nhUg3norGohg
1rsYs7mDWUM/m/1bDhSGN/AYGA39K9cMwTWcw5zEOPxHflvpA2SYWOymnZQYO0ot
cD3/WIkNKk2l5hwNfOSkfzlPrukJg4XBjyWCNSppwlyUAQBcoecypZe8RjR6Ba24
qmzbYk9KqnUWiS/BUthQhvDI5YfcaWu5wxXoGH3pbPtPwelF1sUZQ8Bx37rh97bv
XCPOu6dpuk9OQ/FRM01qI3u5QbiAJsl7Pzd1vHMNeYI2h4KgVhKnb3vkOdlcIX7P
r8Ig9cRUB9YJVFr7T3R4DRNY7+hZLxSG74WUZx8f4IM5pnLO/oMNyQzVYtleqlYf
ZN4sdRDA81V3khHPHwKI1F5sNyWDu94+56e8Qq279hKnZkt4QNp0MgzTNWjTaB/3
bN2EGes0RD22Vt6Bhji1Bk8GnEHdHoYvgwhu0PEhK3BSJaSWh90=
=RkJ/
-----END PGP SIGNATURE-----

--ZVyM5aEaeTsHYcp0--
