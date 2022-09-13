Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37C45B6E79
	for <lists+linux-efi@lfdr.de>; Tue, 13 Sep 2022 15:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiIMNg2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Sep 2022 09:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiIMNgZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Sep 2022 09:36:25 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F0B578B6;
        Tue, 13 Sep 2022 06:36:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 92E015C0165;
        Tue, 13 Sep 2022 09:36:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 13 Sep 2022 09:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663076183; x=
        1663162583; bh=Tc0xVHPsREMfS7uj8Z2PW8B/PBM01asP+Nsn6MzfR0o=; b=r
        GhhcP3aZj/0sP2D4/h+WRgh7wExihpOYP7qcV3LQcEI0rY+L/5skGRoSuf+oYUjV
        hdvVV+/1Wl46Qdz/77jnXUplPOGlGDHaTUkaB9Cp1NjLSuR5a85ZV5VRmLwHIG8V
        dnxfPLqgnMWczNxm442z895Gw3WTNXGbiXzFCY7KA5wbNLP4o7/KPbkdxnydeMgf
        1NBGyxOM183OqEeOlGbQZa9+lqhX5/1fTFHFjAX06wbgvPcH/hCuCR7kkiFm+lor
        GMRY94HRUizfwn2E31cPXJA2MzoMnoqrz+1lh9eNNtYRIHTJltx29jPY+zmMyuKL
        DsSopt2eXvPC7pT5lPkUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663076183; x=1663162583; bh=Tc0xVHPsREMfS7uj8Z2PW8B/PBM0
        1asP+Nsn6MzfR0o=; b=mxO4UwB6KgMan8JCywEwkBkA1UrDDtHz/D8l62ibI+J6
        oeBPN+Z4I1p4WPRASDl7CHp6TMcomBhIIaaChQPJFsE+nKaLGfvp3any/QQORi9D
        T+l+37vm9GQ8A4esLCYFTacK+g6M/QgJ1LNLY407ARpkpRd0+3ttAbkGpU+lobzq
        No2PkVU9WgxT5ASXpZldNqswt1nv6e1qhmL1oNDKP/I01tjrwgaPiDunD4QP/U/b
        qqw5JY91tXStTZCgn3rYhJDxDvzCEIktrU226SuU0fJzW6BHaG0+V0viqXvvWe+t
        W796riM3UtFJEsdHPbmTw7bL1gG5AEGZMoUOOfSj9w==
X-ME-Sender: <xms:V4cgY4d7nywV6OjyWM6jWF-r3PAQDdLu2MZdAtuUcCLdDnM4G80wdA>
    <xme:V4cgY6P-TIOk4BSixSi6zdIh9CTHvAuG9juxX0RvOR5SjV6zd9UHZdcYtFNrvnDDR
    VGScM_Bghz-BNc>
X-ME-Received: <xmr:V4cgY5g1MyQ4bBkq9RytBDxlbBfKGaXYecHqvWW-JIYo0d4dduoOB1IvkJeo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedugedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:V4cgY9_N9-j8nx1nNqJ5DDsNzxlIedPy4Cw88--W-Vdheys8vKn46w>
    <xmx:V4cgY0vGUDwLD28seUY_HtRxYOaDS6J8N3YtPnTjSAdgI40_4JNUnA>
    <xmx:V4cgY0FslpieESCcdVMYHaXsnsO_SF0mAOdz1LApoNTx16zk9VhLTw>
    <xmx:V4cgY-UIE7m_KlBV-zh6o6arpppQK4XMMDcVDbDUXeXBIskhTlWRiA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Sep 2022 09:36:22 -0400 (EDT)
Date:   Tue, 13 Sep 2022 09:36:18 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, Ard Biesheuvel <ardb@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH] Add support for ESRT loading under Xen
Message-ID: <YyCHVdoStC7pGnXA@itl-email>
References: <20220825215218.1606-1-demi@invisiblethingslab.com>
 <c2a22672-b9dd-7aa4-b61e-ccb0faaa3b01@suse.com>
 <YwkKiFIKHG4IcCmH@itl-email>
 <2a1a9e8c-0635-e207-e858-0e0bd1df0f11@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HB29iMzKquh2KHmV"
Content-Disposition: inline
In-Reply-To: <2a1a9e8c-0635-e207-e858-0e0bd1df0f11@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--HB29iMzKquh2KHmV
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Sep 2022 09:36:18 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, Ard Biesheuvel <ardb@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH] Add support for ESRT loading under Xen

On Tue, Sep 06, 2022 at 08:49:54AM +0200, Jan Beulich wrote:
> On 26.08.2022 20:01, Demi Marie Obenour wrote:
> > On Fri, Aug 26, 2022 at 09:53:29AM +0200, Jan Beulich wrote:
> >> On 25.08.2022 23:52, Demi Marie Obenour wrote:
> >>> @@ -40,6 +41,38 @@
> >>> =20
> >>>  #define efi_data(op)	(op.u.efi_runtime_call)
> >>> =20
> >>> +static_assert(XEN_PAGE_SHIFT =3D=3D EFI_PAGE_SHIFT,
> >>> +              "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHIFT");
> >>> +
> >>> +bool xen_efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *md)
> >>> +{
> >>> +	struct xen_platform_op op =3D {
> >>> +		.cmd =3D XENPF_firmware_info,
> >>> +		.u.firmware_info =3D {
> >>> +			.type =3D XEN_FW_EFI_INFO,
> >>> +			.index =3D XEN_FW_EFI_MEM_INFO,
> >>> +			.u.efi_info.mem.addr =3D phys_addr,
> >>> +			.u.efi_info.mem.size =3D ((u64)-1ULL) - phys_addr,
> >>> +		}
> >>> +	};
> >>> +	union xenpf_efi_info *info =3D &op.u.firmware_info.u.efi_info;
> >>> +	int rc;
> >>> +
> >>> +	memset(md, 0, sizeof(*md)); /* initialize md even on failure */
> >>> +	rc =3D HYPERVISOR_platform_op(&op);
> >>> +	if (rc) {
> >>> +		pr_warn("Could not obtain information on address %llu from Xen: "
> >>> +			"error %d\n", phys_addr, rc);
> >>> +		return false;
> >>> +	}
> >>> +
> >>> +	md->attribute =3D info->mem.attr;
> >>> +	md->type =3D info->mem.type;
> >>> +	md->num_pages =3D info->mem.size >> XEN_PAGE_SHIFT;
> >>> +	md->phys_addr =3D info->mem.addr;
> >>
> >> As indicated in reply to your patch changing XEN_FW_EFI_MEM_INFO in
> >> the hypervisor: While this may fit the ESRT purpose, the address you
> >> return here is not necessarily the start of the region, and hence
> >> this function is not a general Xen replacement for the non-Xen
> >> function. Therefore I think it also shouldn't give the impression of
> >> doing so.
> >=20
> > Is this just a matter of renaming the function?
>=20
> Besides renaming the function perhaps it also shouldn't give the
> impression of being generally usable. I would expect it to be a static
> helper somewhere, or even be expanded inline.

I would be fine with doing this, but I didn=E2=80=99t want to litter esrt.c=
 with
Xen-specific code.  IIUC Linux prefers to avoid #ifdef in .c files.

> >  Is it possible to
> > implement the original function with the current hypervisor?
>=20
> Yes, but doing so would be ugly: You'd need to "bisect" your way to
> the start of the region.
>=20
> As an aside (I think I did point this out before): Can you please
> adjust the way your mail program sends mails? When I respond to your
> mail (using Thunderbird), I find all the people previously on Cc on
> the To: list, while your address is lost. As indicated I believe
> this is a result of the Mail-Followup-To: tag your reply came with
> (and I further think that TB's treatment of that tag is a reasonable
> one, albeit perhaps there are other reasonable treatments as well; I
> am not aware of this tag having any formally specified treatment).

This was a misconfiguration on my end: I marked xen-devel as subscribed
in my muttrc.  I fixed this and also unset followup_to, so the
Mail-Followup-To header should no longer be generated.  Please let me
know if this is still a problem.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--HB29iMzKquh2KHmV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmMgh1QACgkQsoi1X/+c
IsEMWg/+K/M5YDFYGZvZG8t9UVyp5AVxc+to/61bec+l2gPk2YyH3Bz4pd4Co1hH
1ZfIIW0nybYkWTXacg26fTMYqg7124vu+VH9mOEmfDp7ZmjWg/QvMYjOEevEQcFQ
SWPhLavQ1pQvJJJacNrEtbk7ivAvYFaKzLPs4yvseBR9r3JyWFQU2fZfbDgi7Q9y
XmuUxqVNerg5/9RQOn2d/+N8J4Bs8v1hclkr/J3KS7a44qukUa28TIEjlhbU3h3b
WM+8zuTN/ksbHQ6/wWaG8KXt5+4UemsQhYOsgI/42eaM4YjjAPL/6d3Vb/bnr1cT
Lk1A1/IXrMVq10GzZZ47sKnnZRD0t9QvXyP16trFJFPoNC2IniFyKfbm1cj5zrOl
DJgvlRzNuFlTA3tHA+U9TW2HZ2xw9reQHWSGUmlB2q0JQ69ZiXOGT57WX5qPSepR
OBXrf0yORshR6UkVewsQgPeGn7jzWpxFlR3y2NpZH1BOp6mVRIhKg6i6GRZqmCai
/M+1IMFZn2CrNBxowxMGkn6Ixh5Zfz71/UTAArx1Ad7VUvrtnC2z/yCBUJ4JcSuQ
hr9FnW/4TNH7OuB/Txm0smyJv4G9UUtSl932lqnOaqkPH12aXDJxjhtxH8y+hLga
vU/DZwgOfeGRXHP4LBtP8cDDmDsModBrHDGOJQWd175eTbKiRiY=
=7Q0Y
-----END PGP SIGNATURE-----

--HB29iMzKquh2KHmV--
