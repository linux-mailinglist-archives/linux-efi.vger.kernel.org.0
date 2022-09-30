Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22305F1170
	for <lists+linux-efi@lfdr.de>; Fri, 30 Sep 2022 20:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiI3SRR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Sep 2022 14:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiI3SRQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Sep 2022 14:17:16 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EBCC6971;
        Fri, 30 Sep 2022 11:17:15 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A4AC63200A07;
        Fri, 30 Sep 2022 14:17:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 30 Sep 2022 14:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664561833; x=
        1664648233; bh=VpYTTsodVQHL/iFliX+gGBf/BbYg00nAJ9Xv1F4ugA4=; b=3
        e65tjs+7F3/HNpFfNnYu6g+RWANNRgNCFWuScT5j+7LlSBh703nntOn1JzO2djaR
        8+icN8UwVz6eqwrVVpovvILbczGwVr3erAvm1GHYJrIUy9Olkm1eIPPuqzozWN+V
        emZTZOZ6ODtVeh9XxNW58qTNe+Q66UiniFj6jBAB19eOBGj+bBTTo2rwe9DArIjG
        8r0jPFUNBjVzxTXT0fxpcF5QY+n5UB1g+3n4K9uZfgcqpVSob/VSts2fxA1f5+OJ
        94EM0WzShtRhaxWcTH3Wp8hQFm8BtIQ5M12l+2x0kpg1KUvRWh5S51w66w1j66Oh
        hlnf2zYsAkZch4J6Q0U7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664561833; x=1664648233; bh=VpYTTsodVQHL/iFliX+gGBf/BbYg
        00nAJ9Xv1F4ugA4=; b=RpbMDvD2QHg/KXDWKztkGAqmq/6hrla6dvE1nI3LDWwS
        hlTbl89LFNJ58QjKgDw267Yvdv3UzqEvN65RSeZY0JHEmRVvT4bVFcazvmBmnzgN
        gy0xcmNfkWCbXkQz0I7wh3DNwlO3tXxdJhn+p+E2FQKf7bmALQU2+CewScG/OAjo
        kmJlLpY1pjbULuiQZdk4DI7jNScC8MMzKli9nnddYwdgj4slIZbCk7RJJmJ4VGk9
        j6UCaBOrzaaJvLSG7ZtSyTfTsly1HeZBSWUlwb/I6HJVSKqNIkaDy7SIklgsF3uf
        zlfqn3czhoZ/8CAthumZnqoQt8p0vh4oPqbjaPgDyg==
X-ME-Sender: <xms:qDI3Y77L6WQj3bt28MoV17vTSvoicBx2mHL1GmpzQzebULTb4-A_6A>
    <xme:qDI3Yw6QtuPo59YR8OJfemuezyLjv-pMEy-am_sLVDSugxkM6iWHYw7s8KQVdGOXz
    GiqqvFLmKJ8RHY>
X-ME-Received: <xmr:qDI3YydCcOKH_SQxoHFYsd0aeLRcovr6DCyKfWzk9vsuBvqFBDjinTJ2qTG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehvddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeeuueevleehvedvuedvhfeihfel
    ffdtheeuvdefgfevgeefgfeihfduheevhedtfeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:qDI3Y8KgElgvD8nAXi8dsKs_B0ar79F8zeAQtRmqjXCIA1wdllfjwA>
    <xmx:qDI3Y_KCeOdol72wfpuy8zfufsOTh5LSHblt7_khVK_aPHfedq9D5g>
    <xmx:qDI3Y1zJ8-f_y58YFa6wRCF0xYZqfU0a8yFZxB6syOZKuY3BRYKgSQ>
    <xmx:qTI3YwV2-Tb8j47s-lX0bOUIwPjM8NErFBCZWxJ8bUKxgaWTB9TeUA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Sep 2022 14:17:11 -0400 (EDT)
Date:   Fri, 30 Sep 2022 14:15:37 -0400
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
Message-ID: <YzcypiqEzAXvuhKo@itl-email>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
 <CAMj1kXH5tos5XVDUCcuEJG+fSNZBnY-xA1nb+Juu3H7AsM0DiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5yHUO7Al/LX7+UiX"
Content-Disposition: inline
In-Reply-To: <CAMj1kXH5tos5XVDUCcuEJG+fSNZBnY-xA1nb+Juu3H7AsM0DiQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--5yHUO7Al/LX7+UiX
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Sep 2022 14:15:37 -0400
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

On Fri, Sep 30, 2022 at 06:25:53PM +0200, Ard Biesheuvel wrote:
> On Fri, 30 Sept 2022 at 01:02, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > Memory of type EFI_CONVENTIONAL_MEMORY, EFI_LOADER_CODE, EFI_LOADER_DAT=
A,
> > EFI_BOOT_SERVICES_CODE, and EFI_BOOT_SERVICES_DATA may be clobbered by
> > Xen before Linux gets to start using it.  Therefore, Linux under Xen
> > must not use EFI tables from such memory.  Most of the remaining EFI
> > memory types are not suitable for EFI tables, leaving only
> > EFI_ACPI_RECLAIM_MEMORY, EFI_RUNTIME_SERVICES_DATA, and
> > EFI_RUNTIME_SERVICES_CODE.  When running under Xen, Linux should only
> > use tables that are located in one of these types of memory.
> >
> > This patch ensures this, and also adds a function
> > (xen_config_table_memory_region_max()) that will be used later to
> > replace the usage of the EFI memory map in esrt.c when running under
> > Xen.  This function can also be used in mokvar-table.c and efi-bgrt.c,
> > but I have not implemented this.
> >
> > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > ---
> >  drivers/firmware/efi/efi.c |  8 +++++---
> >  drivers/xen/efi.c          | 35 +++++++++++++++++++++++++++++++++++
> >  include/linux/efi.h        |  9 +++++++++
> >  3 files changed, 49 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index e4080ad96089abd7f84745dd8461c548bcbb7685..d344f3ff73d1c5ed0c67e32=
51a9502e66719741d 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -574,7 +574,6 @@ int __init efi_config_parse_tables(const efi_config=
_table_t *config_tables,
> >         unsigned long table;
> >         int i;
> >
> > -       pr_info("");
>=20
> Why are you removing these prints?

If I left them, I would need to include a pr_cont("\n") later.
Checkpatch recommends against that.  What is the purpose of this print?
I assumed that since it prints an empty string it is superfluous.

> >         for (i =3D 0; i < count; i++) {
> >                 if (!IS_ENABLED(CONFIG_X86)) {
> >                         guid =3D &config_tables[i].guid;
> > @@ -585,7 +584,6 @@ int __init efi_config_parse_tables(const efi_config=
_table_t *config_tables,
> >
> >                         if (IS_ENABLED(CONFIG_X86_32) &&
> >                             tbl64[i].table > U32_MAX) {
> > -                               pr_cont("\n");
> >                                 pr_err("Table located above 4GB, disabl=
ing EFI.\n");
> >                                 return -EINVAL;
> >                         }
> > @@ -594,10 +592,14 @@ int __init efi_config_parse_tables(const efi_conf=
ig_table_t *config_tables,
> >                         table =3D tbl32[i].table;
> >                 }
> >
> > +#ifdef CONFIG_XEN_EFI
>=20
> We tend to prefer IS_ENABLED() for cases such as this one. That way,
> the compiler always gets to see the code inside the conditional block,
> which gives better build test coverage (even if CONFIG_XEN_EFI is
> disabled).

Can I count on the compiler eliminating the code as unreachable?  With
CONFIG_XEN_EFI disabled xen_config_table_memory_region_max() would be an
undefined symbol.

> > +               if (efi_enabled(EFI_PARAVIRT) && !xen_config_table_memo=
ry_region_max(table))
>=20
> So the question here is whether Xen thinks the table should be
> disregarded or not. So let's define a prototype that reflects that
> purpose, and let the implementation reason about how this should be
> achieved.

xen_config_table_memory_region_max() doesn=E2=80=99t just return whether the
table should be disregarded, but also (if the table should not be
ignored) the end of the memory region containing it.  I will make
xen_efi_config_table_valid() a wrapper around
xen_config_table_memory_region_max(), as the former also needs to print
a warning if the table is in an invalid location.

> So
>=20
> if (IS_ENABLED(CONFIG_XEN_EFI) &&
>     efi_enabled(EFI_PARAVIRT) &&
>     xen_efi_config_table_valid(guid, table)
>         continue
>=20
> I should note here, though, that EFI_PARAViRT is only set on x86 not
> on other architectures that enable CONFIG_XEN_EFI so this will not
> work anywhere else.

What should I use instead?

> > +                       continue;
> > +#endif
> > +
> >                 if (!match_config_table(guid, table, common_tables) && =
arch_tables)
> >                         match_config_table(guid, table, arch_tables);
> >         }
> > -       pr_cont("\n");
> >         set_bit(EFI_CONFIG_TABLES, &efi.flags);
> >
> >         if (efi_rng_seed !=3D EFI_INVALID_TABLE_ADDR) {
> > diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
> > index d1ff2186ebb48a7c0981ecb6d4afcbbb25ffcea0..c2274ddfcc63304008ef0fd=
78fd9fa416f75d073 100644
> > --- a/drivers/xen/efi.c
> > +++ b/drivers/xen/efi.c
> > @@ -28,6 +28,7 @@
> >  #include <xen/interface/platform.h>
> >  #include <xen/xen.h>
> >  #include <xen/xen-ops.h>
> > +#include <xen/page.h>
> >
> >  #include <asm/page.h>
> >
> > @@ -271,6 +272,40 @@ static void xen_efi_reset_system(int reset_type, e=
fi_status_t status,
> >         }
> >  }
> >
> > +__init u64 xen_config_table_memory_region_max(u64 addr)
>=20
> It is more idiomatic for Linux to put __init after the return type.
> And if we adopt my suggestion above, this becomes
>=20
> bool __init xen_efi_config_table_valid(const efi_guid_t *guid, u64 table)
>=20
> Alternatively, you could pass the string identifier of the table
> instead of the guid (or both) to print in the diagnostic message.

Will fix in v5.

> > +{
> > +       static_assert(XEN_PAGE_SHIFT =3D=3D EFI_PAGE_SHIFT,
> > +                     "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHI=
FT");
>=20
> Is this the only place where this matters? And this never happens on x86,=
 right?

My understanding is that it should never happen on any architecture.
That=E2=80=99s why I static_assert() it.  I have no idea if this is the only
place it matters, though.

> > +       struct xen_platform_op op =3D {
> > +               .cmd =3D XENPF_firmware_info,
> > +               .u.firmware_info =3D {
> > +                       .type =3D XEN_FW_EFI_INFO,
> > +                       .index =3D XEN_FW_EFI_MEM_INFO,
> > +                       .u.efi_info.mem.addr =3D addr,
> > +                       .u.efi_info.mem.size =3D U64_MAX - addr,
> > +               }
> > +       };
> > +       union xenpf_efi_info *info =3D &op.u.firmware_info.u.efi_info;
> > +       int rc =3D HYPERVISOR_platform_op(&op);
> > +
> > +       if (rc) {
> > +               pr_warn("Failed to lookup header %llu in Xen memory map=
: error %d\n",
> > +                       (unsigned long long)addr, rc);
> > +               return 0;
> > +       }
> > +
> > +       switch (info->mem.type) {
> > +       case EFI_RUNTIME_SERVICES_CODE:
> > +       case EFI_RUNTIME_SERVICES_DATA:
> > +       case EFI_ACPI_RECLAIM_MEMORY:
>=20
> If we are listing all memory types that Xen preserves, you might add
> EFI_RESERVED_MEMORY here. Otherwise, please only list the ones that
> you need to permit explicitly.

My understanding was that EFI_RESERVED_MEMORY should never be touched by
the OS, so I left it out.  Which types would you permit?

> > +               return info->mem.addr + info->mem.size;
> > +       default:
> > +               pr_warn("Table %llu is in memory of type %d, ignoring i=
t\n",
> > +                       (unsigned long long)addr, info->mem.type);
> > +               return 0;
> > +       }
> > +}
> > +
> >  /*
> >   * Set XEN EFI runtime services function pointers. Other fields of str=
uct efi,
> >   * e.g. efi.systab, will be set like normal EFI.
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index d2b84c2fec39f0268324d1a38a73ed67786973c9..fc81e4b984398cdb399e788=
6b2cae7f33bf91613 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -1324,4 +1324,13 @@ struct linux_efi_coco_secret_area {
> >  /* Header of a populated EFI secret area */
> >  #define EFI_SECRET_TABLE_HEADER_GUID   EFI_GUID(0x1e74f542, 0x71dd, 0x=
4d66,  0x96, 0x3e, 0xef, 0x42, 0x87, 0xff, 0x17, 0x3b)
> >
> > +#ifdef CONFIG_XEN_EFI
>=20
> Please drop this #ifdef

Will fix in v5.

> > +/*
> > + * Returns the end of the memory region containing the given config ta=
ble,
> > + * or 0 if the given address does not reside in memory that can validly
> > + * contain EFI configuration tables.
> > + */
> > +__init u64 xen_config_table_memory_region_max(u64 addr);
>=20
> You can drop the __init here

Will fix in v5.

> > +#endif
> > +
> >  #endif /* _LINUX_EFI_H */
> > --
> > Sincerely,
> > Demi Marie Obenour (she/her/hers)
> > Invisible Things Lab
> >

--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--5yHUO7Al/LX7+UiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM3MqYACgkQsoi1X/+c
IsGqLg/+LrbdkNwJvPos2mErIP/759qjWMrHuwkpugajU5HC3On9q3mpBvKkO49o
5hPrK7Bs4AoP/g2CPc+w4XFtEqAPhRUu6eADfXff83bIbKmlqlzbBn/EUmSG6uz+
7UGw+WmiizX1ycoimA4BuK2OjfnxS/RVUwXIO8aaeVEoSK8vA2iJMZLNTVlLffAf
XjcaHqfX5TeuqGR4hAmtcBUwzSqHly932UE/RoACBiuRJ0bLl9VuW8iaafzHqkPJ
CWJsEInho4cR+DXrEZMKOfPpnFzsKHQ8EzdQYkaF2p6Jp5acZmA2Szy3yQgJF+6B
imsLzNK8xcqrrdP7HcFBZHSEt5x7h5HMz3KQ0jzLos47e+uIyMhN70AdXBdGf4Ae
kNYJ7P/3795g3/wLh74FvJLj6+CS1nXC8bYgHvSmyu596/bebYRhUveZn2p/9OxT
1DZBNLvdX38gI/GmqZ5qeevVuXy+rrVff9gti9K9ruKF9J5R33ROxI6yUhfcPNhU
7QF2QbrPh59DprG/sIAUptS1pXpoXl9KTsWaUC/9oC81gGVTbZDVM5ud3W5C0GR8
8VWWHTToKr8H6NqDredfQKvmDrs6LTosiv7RYfwf5x/uBJYp2tWO//eVCzAvd1+X
x5FA+raBCIhvvn0OB2386X7El4qS0AnINvGfXpHGPWBQK8CSFR0=
=C5Ld
-----END PGP SIGNATURE-----

--5yHUO7Al/LX7+UiX--
