Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCE55F120C
	for <lists+linux-efi@lfdr.de>; Fri, 30 Sep 2022 21:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiI3TAf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Sep 2022 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiI3TAY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Sep 2022 15:00:24 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42854BC93F;
        Fri, 30 Sep 2022 12:00:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7B4ED3200AE9;
        Fri, 30 Sep 2022 15:00:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 30 Sep 2022 15:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664564419; x=
        1664650819; bh=1He9L4siapS9LUXcCLtJSWJnW6PFsjgj1kBDJr0eMDw=; b=l
        0/zpu9Sf/NROKRkT6ABsdO4PeJJjirO0FastIrVTb3qWfj9KT1KuTtnmj1tLVQWm
        7LdbBQJhhr0J+BbFvg2QEaK8rLkbSPCGgBl6o5L+0p/FFipJsQPQAvj9MD+Aou6a
        Vzu/rx6qqADDZQFOREbpb3Ioqz8wgYlZcZhfqjVZ1EmGIVtt+kVpS2+HcAoGYzfC
        HfgGy2ML4qVvv9FofmlfAriXE2mx2RUX7ef3nMWB0+0mHdHHdBw29Fb7os+hooEG
        Gt2hHBaQm4HaGDg7yeEEhi0Ffg4Hn8GnMrVpe0hfx1Scn5pOLXDdY40eLOmr6qbV
        86M7fpkZKsJElw640cVRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664564419; x=1664650819; bh=1He9L4siapS9LUXcCLtJSWJnW6PF
        sjgj1kBDJr0eMDw=; b=E1EZ4nR4Rc40L0gTD+yy3+bGuW+VAIMNJUElqJU1ohWQ
        sO4UNfVFW/THiRNZ0SZwlM4Aqxr8R74gNdx2GnqkSQUMxhfxfgQOvcJVIs5yqZYw
        K6vLRpKhQCyVUTOHytOoYCvHrMjX44p8wgO3zAYIs6sjWuRbxQRQDe4Qsy+zF+1z
        05Jaq2pmPE/0t3QvxGjg39Z2+7abZKwhEoOZMHS6PxkPSZ+CO1vYEsftMCUAYWwE
        /pHD+9O9sdxNbSXq2e2oSPzQH6CpEGNOhTtlCiplniQzmf8ewMplmDFgzbEFrHyj
        He4YCxAzSUteo9oQFC8MXCysRePIwaC8cf6G/uxZ0A==
X-ME-Sender: <xms:wTw3Y86sSNtlaopnVw4O-sNPh1u34KmL5E4VCtFxMyDu4SkuY0BxQQ>
    <xme:wTw3Y97DEOOirOyBPBVWwvg7XD1W4YYKu8R4HOeJPH9lgH15u6WpKXfNJYFViteVF
    QoAvm_xocb8J1k>
X-ME-Received: <xmr:wTw3Y7cxJcqfnMXuYOFU4YEM8rweCeUoOBYXDXPm5kgxOZuoVpKv23RK-6VG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehvddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:wTw3YxIBGEjwZ60TxFmd1oUHKlXxIm5-kiziaHHDR2b5ldQXCiOtyg>
    <xmx:wTw3YwJlChhi0P8vHKahJKM--eEJETJg8iat1OvQ2MGDEM0HnPZ1dA>
    <xmx:wTw3Yyxq6-1SpTPOypoyGvBUMDReSOVHMymQCokdrlHDwj_xbNEjfQ>
    <xmx:wzw3Y1WKV9dbMwZ1QsX502urM6kymKw4PzBdJ-vwFPB7oWX1Umz59Q>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Sep 2022 15:00:17 -0400 (EDT)
Date:   Fri, 30 Sep 2022 15:00:08 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
Message-ID: <Yzc8v5Mzxvn9KJZd@itl-email>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
 <CAMj1kXH5tos5XVDUCcuEJG+fSNZBnY-xA1nb+Juu3H7AsM0DiQ@mail.gmail.com>
 <YzcypiqEzAXvuhKo@itl-email>
 <CAMj1kXHKsO+uUQdK1DCsi=qGEh8CELXUwOQTiXohHVp5py04GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="si9cRwJ00DjE2kEi"
Content-Disposition: inline
In-Reply-To: <CAMj1kXHKsO+uUQdK1DCsi=qGEh8CELXUwOQTiXohHVp5py04GQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--si9cRwJ00DjE2kEi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Sep 2022 15:00:08 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered

On Fri, Sep 30, 2022 at 08:42:41PM +0200, Ard Biesheuvel wrote:
> On Fri, 30 Sept 2022 at 20:17, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > On Fri, Sep 30, 2022 at 06:25:53PM +0200, Ard Biesheuvel wrote:
> > > On Fri, 30 Sept 2022 at 01:02, Demi Marie Obenour
> > > <demi@invisiblethingslab.com> wrote:
> > > >
> > > > Memory of type EFI_CONVENTIONAL_MEMORY, EFI_LOADER_CODE, EFI_LOADER=
_DATA,
> > > > EFI_BOOT_SERVICES_CODE, and EFI_BOOT_SERVICES_DATA may be clobbered=
 by
> > > > Xen before Linux gets to start using it.  Therefore, Linux under Xen
> > > > must not use EFI tables from such memory.  Most of the remaining EFI
> > > > memory types are not suitable for EFI tables, leaving only
> > > > EFI_ACPI_RECLAIM_MEMORY, EFI_RUNTIME_SERVICES_DATA, and
> > > > EFI_RUNTIME_SERVICES_CODE.  When running under Xen, Linux should on=
ly
> > > > use tables that are located in one of these types of memory.
> > > >
> > > > This patch ensures this, and also adds a function
> > > > (xen_config_table_memory_region_max()) that will be used later to
> > > > replace the usage of the EFI memory map in esrt.c when running under
> > > > Xen.  This function can also be used in mokvar-table.c and efi-bgrt=
=2Ec,
> > > > but I have not implemented this.
> > > >
> > > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > > ---
> > > >  drivers/firmware/efi/efi.c |  8 +++++---
> > > >  drivers/xen/efi.c          | 35 +++++++++++++++++++++++++++++++++++
> > > >  include/linux/efi.h        |  9 +++++++++
> > > >  3 files changed, 49 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > > index e4080ad96089abd7f84745dd8461c548bcbb7685..d344f3ff73d1c5ed0c6=
7e3251a9502e66719741d 100644
> > > > --- a/drivers/firmware/efi/efi.c
> > > > +++ b/drivers/firmware/efi/efi.c
> > > > @@ -574,7 +574,6 @@ int __init efi_config_parse_tables(const efi_co=
nfig_table_t *config_tables,
> > > >         unsigned long table;
> > > >         int i;
> > > >
> > > > -       pr_info("");
> > >
> > > Why are you removing these prints?
> >
> > If I left them, I would need to include a pr_cont("\n") later.
>=20
> There should always be one at the end of the loop, no? Or is this
> related to the diagnostic that gets printed in your helper?

My helper emits a diagnostic (at severity KERN_WARNING) if the table is
in memory that Xen has not reserved.

> > Checkpatch recommends against that.  What is the purpose of this print?
> > I assumed that since it prints an empty string it is superfluous.
> >
>=20
> It prints the leading [invisible] loglevel marker, and the 'efi: ' prefix.

Okay, that makes sense.

> > > >         for (i =3D 0; i < count; i++) {
> > > >                 if (!IS_ENABLED(CONFIG_X86)) {
> > > >                         guid =3D &config_tables[i].guid;
> > > > @@ -585,7 +584,6 @@ int __init efi_config_parse_tables(const efi_co=
nfig_table_t *config_tables,
> > > >
> > > >                         if (IS_ENABLED(CONFIG_X86_32) &&
> > > >                             tbl64[i].table > U32_MAX) {
> > > > -                               pr_cont("\n");
> > > >                                 pr_err("Table located above 4GB, di=
sabling EFI.\n");
> > > >                                 return -EINVAL;
> > > >                         }
> > > > @@ -594,10 +592,14 @@ int __init efi_config_parse_tables(const efi_=
config_table_t *config_tables,
> > > >                         table =3D tbl32[i].table;
> > > >                 }
> > > >
> > > > +#ifdef CONFIG_XEN_EFI
> > >
> > > We tend to prefer IS_ENABLED() for cases such as this one. That way,
> > > the compiler always gets to see the code inside the conditional block,
> > > which gives better build test coverage (even if CONFIG_XEN_EFI is
> > > disabled).
> >
> > Can I count on the compiler eliminating the code as unreachable?  With
> > CONFIG_XEN_EFI disabled xen_config_table_memory_region_max() would be an
> > undefined symbol.
> >
>=20
> If you drop the #ifdef in the .h file (as I suggested below) the code
> will compile fine, and the symbol reference will not be emitted into
> the object, so it will link fine even if the Xen objects are not being
> built.
>=20
> We rely on this behavior all over the Linux kernel.

Okay, thanks!

> > > > +               if (efi_enabled(EFI_PARAVIRT) && !xen_config_table_=
memory_region_max(table))
> > >
> > > So the question here is whether Xen thinks the table should be
> > > disregarded or not. So let's define a prototype that reflects that
> > > purpose, and let the implementation reason about how this should be
> > > achieved.
> >
> > xen_config_table_memory_region_max() doesn=E2=80=99t just return whethe=
r the
> > table should be disregarded, but also (if the table should not be
> > ignored) the end of the memory region containing it.
>=20
> But the calling code never uses that value, right?

The code in this patch does not use that value.  Patch 2 of 2 does use
it.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--si9cRwJ00DjE2kEi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM3PL4ACgkQsoi1X/+c
IsEIYA/9HsripL4/hkzbWBNFzQ1cou4naD3dTA15yeQYQxvydJtvrC0YAVVzAwet
BaLPdw6RnrFIV37yB/T3K2Q3MYWae7/d5taOjmSQMVxF8x2EVyLGfovsNkFtfWJ6
18esuHpVR4khfW7WI6380ZHgs1XpQtHAqzOGrYTnOYUShAu45w8S44/2QrV2KGV1
FKbsJp8yD4dHY/bmRM1EhCnb/cLjSPu0sFvTe2a0DIuJAyqFmWj3LzTPquOR54eH
zDhzWlsg8gYlQhYdIo2mgEA1Zb5xrakI8mwaG7tKPEFv2/yzorCT2EEA9dfJ1vo6
pUme0UgV0gjxrOEaTlPHCYM1s0Qm7yu4O1gdIMPaqC7vuHswoACCWuczdViCVzPZ
n8AIFefEjgAYLyPoiZ3SRvisWPBF8hxd+BHvF/f3Ij9GKxsmrNtQ2fSQ0nmWu5Ac
/JgLkz2cioulUl8ks+IO1/h607HYf7YYpxwc2DnnX63rykzwB2J7mIQeJx/PcPQI
bGrjFTBw70sI0OtG9vGL1j52Y5zpTU8CxMKdZzI6Jf007tYlLhzia6qqjNmJxb7Q
4ZYSmWxZYb36KwbnDw6PLIr762oYuR7623gmlgclySia3YnQjC30Ga5/vYIodMQ1
nQa5WE9WzYdeudxJv+mZGDuBFAA/nEt0Wi67Q/rpHSYmsj6Ufzc=
=Hyrk
-----END PGP SIGNATURE-----

--si9cRwJ00DjE2kEi--
