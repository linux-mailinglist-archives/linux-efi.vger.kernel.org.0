Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251DF24844F
	for <lists+linux-efi@lfdr.de>; Tue, 18 Aug 2020 14:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHRMBl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Aug 2020 08:01:41 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:42825 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgHRMBk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Aug 2020 08:01:40 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4D77F30B;
        Tue, 18 Aug 2020 08:01:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 18 Aug 2020 08:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=DgoXOv
        nAOt0cGqmOdg039r1P/dHBMWwyVQaa74CZls4=; b=aSAH6WZLWPnkk1fhq6tIR3
        g73TSoS6N5bVGgHJuri/uTGC47X8vUbyy8eVRTpT/22wN+PNNfP9P3ANIsmylid+
        wpuFFzeQiMrLq2xR0m4VhItx0C7shUUy2X+cl3GGMaBGUrafKDEt0sDkRGciqqQ7
        38DWuM71IfVvxz+RvinEIAXpeNhyEcyiOSJdmiFC99UV3dGt5uskCltPU2gHfhqK
        ZCT152ku1Gt9OT+aeRG11JFjL+XPDsRmm2kk2BK1XNj94BV6Vf6lv8rI0EjRirmL
        TGo/4Ks1tmzkUH6dhfDKNGrt2CO4i0TiLp4DBzEKFHR/M05D+jEEWRD6F0NvnuMg
        ==
X-ME-Sender: <xms:IsM7X2ak7jBHrjY_mNOXC8hPeAYK9NFN3zg8rvZ2DdQbWqSqJMZRBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtiedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeetveff
    iefghfekhffggeeffffhgeevieektedthfehveeiheeiiedtudegfeetffenucfkpheple
    durdeigedrudejtddrkeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsg
    drtghomh
X-ME-Proxy: <xmx:IsM7X5a_TYfI2Mv3j_UAiOtPJAE6NE6K4wpB5ZIl8Vtdhsz8_sD_kA>
    <xmx:IsM7Xw-v4x9VqZASt4XkgsldVELcfKP9TA02V3mj1tQJEquWI25t5w>
    <xmx:IsM7X4pv8MtVgI26QDwP7sW-1VHJRrFBunHgsLI7WHIeNrLtzeL2rg>
    <xmx:IsM7XyAijo-bMl4qqhvqofDJZptiNDzv5S_gFuKqChyrBciCcxivRA>
Received: from mail-itl (ip5b40aa59.dynamic.kabel-deutschland.de [91.64.170.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id B7A6030600B9;
        Tue, 18 Aug 2020 08:01:37 -0400 (EDT)
Date:   Tue, 18 Aug 2020 14:01:35 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        norbert.kaminski@3mdeb.com, xen-devel@lists.xenproject.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi: discover ESRT table on Xen PV too
Message-ID: <20200818120135.GK1679@mail-itl>
References: <20200816001949.595424-1-marmarek@invisiblethingslab.com>
 <20200817090013.GN975@Air-de-Roger>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline
In-Reply-To: <20200817090013.GN975@Air-de-Roger>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] efi: discover ESRT table on Xen PV too

On Mon, Aug 17, 2020 at 11:00:13AM +0200, Roger Pau Monn=C3=A9 wrote:
> On Sun, Aug 16, 2020 at 02:19:49AM +0200, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > In case of Xen PV dom0, Xen passes along info about system tables (see
> > arch/x86/xen/efi.c), but not the memory map from EFI.
>=20
> I think that's because the memory map returned by
> XENMEM_machine_memory_map is in e820 form, and doesn't contain the
> required information about the EFI regions due to the translation done
> by efi_arch_process_memory_map in Xen?

Yes, I think so.

> > This makes sense
> > as it is Xen responsible for managing physical memory address space.
> > In this case, it doesn't make sense to condition using ESRT table on
> > availability of EFI memory map, as it isn't Linux kernel responsible for
> > it.
>=20
> PV dom0 is kind of special in that regard as it can create mappings to
> (almost) any MMIO regions, and hence can change it's memory map
> substantially.

Do you mean PV dom0 should receive full EFI memory map? Jan already
objected this as it would be a layering violation.

> > Skip this part on Xen PV (let Xen do the right thing if it deems
> > necessary) and use ESRT table normally.
>=20
> Maybe it would be better to introduce a new hypercall (or add a
> parameter to XENMEM_machine_memory_map) in order to be able to fetch
> the EFI memory map?
>
> That should allow a PV dom0 to check the ESRT is correct and thus not
> diverge from bate metal.

Note the EFI memory map there is used not just to check things, but to
actually modify it to reserve the region. I think that's rather Xen
responsibility, not dom0. See the comment from Ard.
=20
> >=20
> > This is a requirement for using fwupd in PV dom0 to update UEFI using
> > capsules.
> >=20
> > Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblething=
slab.com>
> > ---
> >  drivers/firmware/efi/esrt.c | 47 ++++++++++++++++++++-----------------
> >  1 file changed, 25 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> > index d5915272141f..5c49f2aaa4b1 100644
> > --- a/drivers/firmware/efi/esrt.c
> > +++ b/drivers/firmware/efi/esrt.c
> > @@ -245,36 +245,38 @@ void __init efi_esrt_init(void)
> >  	int rc;
> >  	phys_addr_t end;
> > =20
> > -	if (!efi_enabled(EFI_MEMMAP))
> > +	if (!efi_enabled(EFI_MEMMAP) && !efi_enabled(EFI_PARAVIRT))
> >  		return;
> > =20
> >  	pr_debug("esrt-init: loading.\n");
> >  	if (!esrt_table_exists())
> >  		return;
> > =20
> > -	rc =3D efi_mem_desc_lookup(efi.esrt, &md);
> > -	if (rc < 0 ||
> > -	    (!(md.attribute & EFI_MEMORY_RUNTIME) &&
> > -	     md.type !=3D EFI_BOOT_SERVICES_DATA &&
> > -	     md.type !=3D EFI_RUNTIME_SERVICES_DATA)) {
> > -		pr_warn("ESRT header is not in the memory map.\n");
> > -		return;
> > -	}
> > +	if (efi_enabled(EFI_MEMMAP)) {
> > +		rc =3D efi_mem_desc_lookup(efi.esrt, &md);
> > +		if (rc < 0 ||
> > +		    (!(md.attribute & EFI_MEMORY_RUNTIME) &&
> > +		     md.type !=3D EFI_BOOT_SERVICES_DATA &&
> > +		     md.type !=3D EFI_RUNTIME_SERVICES_DATA)) {
> > +			pr_warn("ESRT header is not in the memory map.\n");
> > +			return;
> > +		}
>=20
> Here you blindly trust the data in the ESRT in the PV case, without
> checking it matches the regions on the memory map, which could lead to
> errors if ESRT turns to be wrong.

I don't think checking merely if ESRT lives somewhere in
EFI_{BOOT,RUNTIME}_SERVICES_DATA area guarantees its correctness.

On the other hand, this seems to be done to prevent overwriting that
memory with something else (see that in case of EFI_BOOT_SERVICES_DATA
it is later marked as reserved. I think it should be rather done by Xen,
not dom0. Either by moving this whole check into dom0 (for this table
only? or perhaps for other tables too?), or by simply reserving the whole
EFI_BOOT_SERVICES_DATA (like the /mapbs boot switch does).
Then, I think dom0 could use e820 map to verify that this is reserved,
but do not modify the map anymore.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl87wx4ACgkQ24/THMrX
1ywa9wgAgKzWnowpaC/HqWkusUfY8KwPv+HFBqfhymqQhkcwbVgUcfBGo+yS3qhk
iR+89eSE/gjoqIZXCQsHB5LIpsdwCOZnG8dSM1FFHCW3wfOqTZzu1y9lkVFM8Isv
SBVX9sm0l9TmlcD2fq/nBe6E4QCdG9lKZ975zUPr1sWpYLj6+Q2cNVh5nv/rEpxs
LbohqVLdlLLcj/G14e+gJZ7f70p1fu6ge49VWiOMc8pL7J9Y1qzfalso5iRxXuta
fgKCpbBdkk6hXuhZiAJphdVIneCDc0oDwees8pdntUe8HjjQ+Qx7JtzQAjn4VuW4
+IvWBvscI+CTmBAPjKgPXkSVoLk20A==
=wEjx
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
