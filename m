Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902785F272B
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 01:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJBXQA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Oct 2022 19:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJBXPl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Oct 2022 19:15:41 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B899923382
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 16:10:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 21E2F5C00C0;
        Sun,  2 Oct 2022 19:00:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 02 Oct 2022 19:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664751636; x=
        1664838036; bh=cNciw2J5Orp3JpPbWkHqpqGm5hUpKrl4SmiJ2KcbhH8=; b=S
        tzowsnM8VUFP9jNA1d27nHp5QlrEviDhtKSxdP/MY6TEgnK0eo1T3cRCa3uUbiAp
        LZ1O6BUmN6C4ekbVXueBFi6AjnkRFhPvxXrdAB9XaW2Y5sCtlvebHdGNns4UaR87
        98i/+z6WvyBzUwjWQ8cil7CiyKb9ABrWpndfHtk6gFmyXjImddoCbmQluTyubJtX
        5lZfLA+UApxRN8NOH/cm/exfR8iZXVCoaqXRqFpY8Ekc+VHymtgrMUeXUEVjMTrJ
        fmae98hbjLeiiKG+5gHMs2zyrOPnyKSbHI3qLiaYubRW/XP9V89QkOeQ+GcMndnA
        8I7SUTC4bB3I1Npn0SqKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664751636; x=1664838036; bh=cNciw2J5Orp3JpPbWkHqpqGm5hUp
        Krl4SmiJ2KcbhH8=; b=JdGnrZ+iLYBG6LzPmDP3jOJv64VEFip/hOipznNdeiUc
        o1Jr+pN3OQR4ysJrt2y98O1kCDwbH7NCH+qQId8kJmKy0WUQZzgdPfo+5i7yx3+m
        kq/eYIepJPiaJQzchG26RMIvQY1WVVi9GESPCCE1DKavHdkQlDR0BTYS86PHCB0C
        xh+YJkgcnZMojUFJrB1zILldqNaLCXJX3TSrc1teEdcmxScZSYt1LTDUoq5x8VtV
        4UuifB4kj8CM9fWzuiOuINWARyICq0ohDm24kAvjeUUkkAjBTykAUoWeY/Sj0b4a
        qU+DfPJYWI8cPljqU3+FJHy5jm5uX9m4heWubMYhmQ==
X-ME-Sender: <xms:Exg6YyCbz9sByCIIQljqFgkNCPeuxQmDhsaMWa6wGicvjRytAzNjZg>
    <xme:Exg6Y8joOSZ5zzpJGsrYmbE6OgKkU77YXGXHirguXPjzIU9wxSsmPRMFtyRzZUj1-
    deQU6-SJF0l2wo>
X-ME-Received: <xmr:Exg6Y1kljE3_n27GmgMEjkJYhFGOwjkmF3RSb1z7zqcsL3TIETazcUH2zPpV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehkedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:Exg6YwxJKc-wmkmNwhLsxE2oIxI-nZaKtEDu19BrP2dB9JI0x_1L0g>
    <xmx:Exg6Y3SmiEcbMdqzdD3-2SdgO6W8Mq9hrs_m05kn1-FZ1jHUyqJsmw>
    <xmx:Exg6Y7azkcapAbTvHYgcytdLYYZuTmVS2fr3YExZybs-YQTgV-CF1w>
    <xmx:FBg6Y8_EkqLgAuteYDAfltj7vRVWKG2Qo7Dcaz-QTb_s47gjjlIv6w>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Oct 2022 19:00:34 -0400 (EDT)
Date:   Sun, 2 Oct 2022 19:00:01 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
        Peter Jones <pjones@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: Re: [RFC PATCH 4/5] efi: Apply allowlist to EFI configuration tables
 when running under Xen
Message-ID: <YzoYEewoSoj1a2Ss@itl-email>
References: <20221002095626.484279-1-ardb@kernel.org>
 <20221002095626.484279-5-ardb@kernel.org>
 <Yzm8H3iS7ziWsh7E@itl-email>
 <CAMj1kXFWS0kXp7f75x=BDYDyTHKNzMCTZ_bXg7v23Aw=pJtSzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PghubVJsF+8O07oQ"
Content-Disposition: inline
In-Reply-To: <CAMj1kXFWS0kXp7f75x=BDYDyTHKNzMCTZ_bXg7v23Aw=pJtSzQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--PghubVJsF+8O07oQ
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 2 Oct 2022 19:00:01 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
	Peter Jones <pjones@redhat.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [RFC PATCH 4/5] efi: Apply allowlist to EFI configuration tables
 when running under Xen

On Sun, Oct 02, 2022 at 11:22:58PM +0200, Ard Biesheuvel wrote:
> On Sun, 2 Oct 2022 at 18:28, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > On Sun, Oct 02, 2022 at 11:56:25AM +0200, Ard Biesheuvel wrote:
> > > As it turns out, Xen does not guarantee that EFI bootservices data
> > > regions in memory are preserved, which means that EFI configuration
> > > tables pointing into such memory regions may be corrupted before the
> > > dom0 OS has had a chance to inspect them.
> > >
> > > Demi Marie reports that this is causing problems for Qubes OS when it
> > > attempts to perform system firmware updates, which requires that the
> > > contents of the ESRT configuration table are valid when the fwupd user
> > > space program runs.
> > >
> > > However, other configuration tables such as the memory attributes
> > > table or the runtime properties table are equally affected, and so we
> > > need a comprehensive workaround that works for any table type.
> > >
> > > So let's first disregard all EFI configuration tables except the ones
> > > that are known (or can be expected) to reside in memory regions of a
> > > type that Xen preserves, i.e., ACPI tables (which are passed in
> > > EfiAcpiReclaimMemory regions) and SMBIOS tables (which are usually
> > > passed in EfiRuntimeServicesData regions, even though the UEFI spec o=
nly
> > > mentions this as a recommendation). Then, cross reference unknown tab=
les
> > > against either the EFI memory map (if available) or do a Xen hypercall
> > > to determine the memory type, and allow the config table if the type =
is
> > > one that is guaranteed to be preserved.
> > >
> > > Future patches can augment the logic in this routine to allow other
> > > table types based on the size of the allocation, or based on a table
> > > specific header size field.
> > >
> > > Co-developed-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  drivers/firmware/efi/efi.c |  7 ++
> > >  drivers/xen/efi.c          | 69 ++++++++++++++++++++
> > >  include/linux/efi.h        |  2 +
> > >  3 files changed, 78 insertions(+)
> > >
> > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > index 11857af72859..e8c0747011d7 100644
> > > --- a/drivers/firmware/efi/efi.c
> > > +++ b/drivers/firmware/efi/efi.c
> > > @@ -556,6 +556,13 @@ static __init int match_config_table(const efi_g=
uid_t *guid,
> > >
> > >       for (i =3D 0; efi_guidcmp(table_types[i].guid, NULL_GUID); i++)=
 {
> > >               if (!efi_guidcmp(*guid, table_types[i].guid)) {
> > > +                     if (IS_ENABLED(CONFIG_XEN_EFI) &&
> > > +                         !xen_efi_config_table_is_usable(guid, table=
)) {
> > > +                             if (table_types[i].name[0])
> > > +                                     pr_cont("(%s=3D0x%lx) ",
> > > +                                             table_types[i].name, ta=
ble);
> > > +                             return 1;
> > > +                     }
> > >                       *(table_types[i].ptr) =3D table;
> > >                       if (table_types[i].name[0])
> > >                               pr_cont("%s=3D0x%lx ",
> > > diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
> > > index d1ff2186ebb4..3f1f365b37d0 100644
> > > --- a/drivers/xen/efi.c
> > > +++ b/drivers/xen/efi.c
> > > @@ -292,3 +292,72 @@ void __init xen_efi_runtime_setup(void)
> > >       efi.get_next_high_mono_count    =3D xen_efi_get_next_high_mono_=
count;
> > >       efi.reset_system                =3D xen_efi_reset_system;
> > >  }
> > > +
> > > +static const efi_guid_t cfg_table_allow_list[] __initconst =3D {
> > > +     ACPI_20_TABLE_GUID,
> > > +     ACPI_TABLE_GUID,
> > > +     SMBIOS_TABLE_GUID,
> > > +     SMBIOS3_TABLE_GUID,
> > > +};
> >
> > This allowlist seems redundant.  Either the tables are already in memory
> > that Xen will preserve or they aren=E2=80=99t.  In both cases the subse=
quent
> > code will do the right thing.
>=20
> Will it? Currently, Xen simply accepts all ACPI and SMBIOS tables,
> regardless of what type of memory region they reside in (if any).
>=20
> So what will happen with buggy firmware where the ACPI or SMBIOS
> tables are not covered by the memory map at all? Currently, this works
> fine but now, it will be rejected. And without ACPI tables, the boot
> will not get far enough to even inform the user what is wrong. And
> SMBIOS tables are used for platform quirks, which means they might be
> essential for a platform to boot as well.

If the tables are not in the memory map at all, I recommend
add_taint(TAINT_FIRMWARE_WORKAROUND) but otherwise continuing to boot.
If the tables are somewhere nonsensical, then the platform is FUBAR
anyway.  Linux alone might be able to work by reserving the memory, but
under Xen that does not work.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--PghubVJsF+8O07oQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM6GBAACgkQsoi1X/+c
IsEE/A/+Ks8HuxLZxVxAaS7z+iHz3lOARj1WpxeoJRhXMQkVNeKQBniOhBUgxeGg
D2njhATzF7PGa/c+JFDXMoNWxMk5XC2nmgSvOL6WIXezXIx/foZomlWTMkMkTECh
Vc9qvu5xaRuGIj43UxxOsawMfS9mWEpv6HM56mpN26erPsm9uDqPzbWZLMVSh/tp
bfH9ZmrLP8T+k+S+gqzyf4kUhpVEyMNw7lz30n7dqvq9Nzjg4cEZ95zzJimUdSMe
MQWNTRFN1/OGLiDSn5JiUhfKboqfDMdBuFpGKD6xeP8Z3vl9ACDpPPZgYosKfil8
LjzkV+2lThyeqwfVSv5v/PpIQs9ZJtzfhCunWEsUscWu0Ak76XIcUCnGDdOV7bAB
ywAUl+KsrhCZeV+zvQugxUC2z/byEBFM0DxnI/VUbyo1gkaSurukIo54SMIerigy
tXPgk+/hohb/2qW1kYie9EeL98hGLgLiy4hZZRoFl23iJLCJKdVp/rICCyxwgGTf
iCBxekyikbYplQ5zOmsHzsJqeW79GxrzevS5HRxedrFCSHIseVGSD/g1G9+AkqBg
kuK0uxl3VGg3jIIcOmyBOrMJXYSmj6CXmPFVA1Uo0ZEyiu6aNtWFJJ85KtAKRczH
zAguzKPKMR5qR1/hcv4OKPFVIwBYdDbuATZfIf5D7WGIm/cx4sg=
=vFGe
-----END PGP SIGNATURE-----

--PghubVJsF+8O07oQ--
