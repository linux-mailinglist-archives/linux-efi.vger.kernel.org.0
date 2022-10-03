Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6925F325F
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 17:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJCPSk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 11:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJCPSk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 11:18:40 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF78010FA
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 08:18:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E34D032003D3;
        Mon,  3 Oct 2022 11:18:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 03 Oct 2022 11:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664810314; x=
        1664896714; bh=Py0ty9ifkS6fLvi4hjmq1ycGUuwx6IScsmBddMLzPWU=; b=V
        rRF51RMI8oANz1XxQNAcGR/QlH50xQL5scFfPG00HlS89olSMC7BQ6Gr3jOlpmKs
        FT+PS6ompEhwru8DZaWhG3zftnDu7Lref69Ub5aa5BErFy2OtKwC3xbMQewfSTbO
        puW4WkD7+B3hWl5BphOLcXdz600hdW+leMW54eycyIC307I14IUH4M+bahaImoTy
        nNUKzvQkj+aLATv7/P5he1KF3JlechvlFqRzhahCZb4CtYdZmWsMhbGnzeHmY2BF
        27olmYby5sNriGwPdFGDf9SpLZG4UoM31ZVdHqS6o+PYBBYhkmEd90xb0T/e3T8Z
        pfmrSrpcuqgKa04RkXx7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664810314; x=1664896714; bh=Py0ty9ifkS6fLvi4hjmq1ycGUuwx
        6IScsmBddMLzPWU=; b=z2zesEfRcXGt+xEOhQZLsbOeanVP/lIoTLZGeEhTvRWA
        4d21aV9sgFc44Zni03Il5HQqILUpflH6xlvKoyED9iklewILcn5LWHkJTBpLw0Nz
        JCoSMKO/KjcJihgT/3Hp1NUFRCjARCM4Qf19T+FT/O8P9vxag+js8YhiPI1St8YH
        fFhncL8lhD0QZcW6AVWaTrlOwNE/SAXPeCgnBWu1IQLlZ1eOfRK9DiPJgLpxwP5M
        VjsmiqNcoYSDxY43x8soK4WY6YlF73MFep2WUHvkcRVSKQCYH8SZaO0VJkhnO0eC
        VGICMBB2SfGfRaVQ7ey07IIsbYO2btgqPYazJU9wXg==
X-ME-Sender: <xms:Sv06Y1RKu8ncaBd9MazYHjbTM3_DHt_U8gaKAi5ht8luH38eQkUzRw>
    <xme:Sv06Y-w57M7d-SvXhIZvux0KwVzIFOLXdv9aTJw6sJR5ewOGDbkFS_VTvoHatSEJX
    mLjww2uq54A8dQ>
X-ME-Received: <xmr:Sv06Y60Jj1vV7HExBJadrZi3kh0ZtbgRtUi6vG0ZubwcrhxVtYzdxnrP4vtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehledgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepudeileefueetvdelheeuteffjeeg
    jeegffekleevueelueekjeejudffteejkeetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:Sv06Y9D497QzQtkaSCYzou14tIDSRMs2EKDb2guxpBThN1-Rci430w>
    <xmx:Sv06Y-iUI9PoQkgQsiGM_m6mlbX9q4dcD9pku1YWvAhH9GmbLQFGsg>
    <xmx:Sv06YxpztdSl9eHfVqYVcZAi42OR3JVdTtBoVbpYMO00YuZKr2mwcw>
    <xmx:Sv06Y5PtPL4vlffVJ7Z3PHuA0h0lEyvweVheNCyaPCJz0VQlTq9yKQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Oct 2022 11:18:33 -0400 (EDT)
Date:   Mon, 3 Oct 2022 11:18:06 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, Peter Jones <pjones@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v2 4/6] efi: memmap: Disregard bogus entries instead of
 returning them
Message-ID: <Yzr9R2ziBAJgzAqR@itl-email>
References: <20221003112625.972646-1-ardb@kernel.org>
 <20221003112625.972646-5-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M+fOFbwZi3N7oSNW"
Content-Disposition: inline
In-Reply-To: <20221003112625.972646-5-ardb@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--M+fOFbwZi3N7oSNW
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 3 Oct 2022 11:18:06 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc: xen-devel@lists.xenproject.org, Peter Jones <pjones@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v2 4/6] efi: memmap: Disregard bogus entries instead of
 returning them

On Mon, Oct 03, 2022 at 01:26:23PM +0200, Ard Biesheuvel wrote:
> The ESRT code currently contains some sanity checks on the memory
> descriptor it obtains, but these can only trigger when the descriptor is
> invalid (if at all).
>=20
> So let's drop these checks, and instead, disregard descriptors entirely
> if the start address is misaligned, or the number of pages reaches
> beyond the end of the address space. Note that the memory map as a whole
> could still be inconsistent, i.e., multiple entries might cover the same
> area, or the address could be outside of the addressable VA space, but
> validating that goes beyond the scope of these helpers.
>=20
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/efi.c  | 13 +++++++------
>  drivers/firmware/efi/esrt.c | 18 +-----------------
>  2 files changed, 8 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 11857af72859..55bd3f4aab28 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -461,19 +461,20 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory_d=
esc_t *out_md)
>  	efi_memory_desc_t *md;
> =20
>  	if (!efi_enabled(EFI_MEMMAP)) {
> -		pr_err_once("EFI_MEMMAP is not enabled.\n");
> +		pr_warn_once("EFI_MEMMAP is not enabled.\n");
>  		return -EINVAL;
>  	}
> =20
> -	if (!out_md) {
> -		pr_err_once("out_md is null.\n");
> -		return -EINVAL;
> -        }
> -

Nit: this seems unrelated.

>  	for_each_efi_memory_desc(md) {
>  		u64 size;
>  		u64 end;
> =20
> +		/* skip bogus entries */
> +		if ((md->phys_addr & (EFI_PAGE_SIZE - 1)) ||
> +		    (md->phys_addr > 0 &&
> +		     (md->num_pages > (U64_MAX - md->phys_addr + 1) >> EFI_PAGE_SHIFT)=
))
> +			continue;

Should this also check if md->num_pages is 0?  Also, should this check
be part of for_each_efi_memory_desc()?

> +
>  		size =3D md->num_pages << EFI_PAGE_SHIFT;
>  		end =3D md->phys_addr + size;
>  		if (phys_addr >=3D md->phys_addr && phys_addr < end) {
> diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> index 2a2f52b017e7..8f86f2b0734b 100644
> --- a/drivers/firmware/efi/esrt.c
> +++ b/drivers/firmware/efi/esrt.c
> @@ -247,9 +247,6 @@ void __init efi_esrt_init(void)
>  	int rc;
>  	phys_addr_t end;
> =20
> -	if (!efi_enabled(EFI_MEMMAP))
> -		return;
> -
>  	pr_debug("esrt-init: loading.\n");
>  	if (!esrt_table_exists())
>  		return;
> @@ -263,21 +260,8 @@ void __init efi_esrt_init(void)
>  		return;
>  	}
> =20
> -	max =3D efi_mem_desc_end(&md);
> -	if (max < efi.esrt) {
> -		pr_err("EFI memory descriptor is invalid. (esrt: %p max: %p)\n",
> -		       (void *)efi.esrt, (void *)max);
> -		return;
> -	}
> -
> +	max =3D efi_mem_desc_end(&md) - efi.esrt;
>  	size =3D sizeof(*esrt);
> -	max -=3D efi.esrt;
> -
> -	if (max < size) {
> -		pr_err("ESRT header doesn't fit on single memory map entry. (size: %zu=
 max: %zu)\n",
> -		       size, max);
> -		return;
> -	}

This can still happen if the ESRT pointer is very very close to the end
of a memory map entry, unless there is another check that handles
such cases.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--M+fOFbwZi3N7oSNW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM6/UcACgkQsoi1X/+c
IsFK/BAA3eyncFILFOM4XIr//iy+YArKCUuZ1/AgikhNXeDrV/ydg2N3BSdsutHi
VZDGtuofMKthtmInOu57DQCbb/K+6FT79KVaRLtOdejEr7I77W/XmDe/gf5ijbxe
y9wTYBGXTBltM4jgd0xPtamE/bRZcK0Jad5h0R7BQOf0mmK7GQRe7Iw+ld8xR5gC
SHZ+J8D780wwrOXeIcq77IWy/YPelNtzPS23IRn7uSJkoEXFwAoUUH7FFebILE4F
VOCI3uLLKOUVrMyiRYE9K4F/uJUOt2XXzlX1ppPN+VHxRhveukWr+JfnqdAknwRT
TaxnlcF9MfeQoxZaAzImTN84z3ooAX2VpG0cNfwmZcvoKcnHFpxNhrWLlmQQXAPh
FGb/PNrwHrB8uo+AN4zATQOwE+4Hymf5MNGW0+QjXVy5kKSb0/jZ0T3sXYBTyYz9
2Jw+vw7JHTna+6x26IC6XdOk/n+lfeG/BBYXz5ii2B96DmVN6yoODQzQULMaDn3h
qjSVVdgd2hwlKylY63ENrpDUOqT1GPfvNkpTj/Knm9pP2G97z30Ru0vkNRgiglsf
Nq9THQNpxw2X17yckR7c4JQj5Y4IyKCCqYIXjwd7qykdQkPGGDSn2nCytolTU3ya
+QBQ36Jtk2+pVcQGYoTR8GESXuBWJp6KRf+nOXYTaNHBdvgDQyk=
=R1Pm
-----END PGP SIGNATURE-----

--M+fOFbwZi3N7oSNW--
