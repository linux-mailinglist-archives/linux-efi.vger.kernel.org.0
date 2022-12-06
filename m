Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF7A644F7E
	for <lists+linux-efi@lfdr.de>; Wed,  7 Dec 2022 00:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLFXTZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Dec 2022 18:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLFXTY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Dec 2022 18:19:24 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FFAD117
        for <linux-efi@vger.kernel.org>; Tue,  6 Dec 2022 15:19:23 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 26F613200951;
        Tue,  6 Dec 2022 18:19:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 06 Dec 2022 18:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1670368759; x=
        1670455159; bh=rkkLUDnPS0FoZRsSkbO54KMARkn+y+gsDF3JLs8f2pM=; b=H
        zKv5upLZ47GBmhQMTAPZSO1XzChLhWPnqUvDPKqSP7mMErrdGcVs/x4P50rvD3gt
        R10DJjOLLtQCFHmfV1yfes8m+5WyxY6b1ROr7SmzNkBwE4z2+m6RRpDLPACp4bxs
        X4h6yzqWs/1T1SXLn1ROnNkqxTWlA1qsekkeoxnGgJ/dJ9tg4pF+myhCKh1JZHZV
        ouLYm9IYqk3U3iNsXEWC6UTLLvLFMm91CjrtJ6DRWBZGHzEcC8ISwhs+kEG8jQdt
        +OLkqDzbvLCL4srV37NCAWfgcQ75FCjHIs543VyYf0PtEPxWXNWyq4xhzjZ4tB+g
        tOODsJXi4nR/FmfwHn2Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670368759; x=1670455159; bh=rkkLUDnPS0FoZRsSkbO54KMARkn+
        y+gsDF3JLs8f2pM=; b=Ar4PeWWgpPIJEiVDNf7mWbNeFN7ViJpSzqO1pmxJ68Ae
        IPW/Q1VMJHmRw2HtNSStSVsJUKYfpxSY0ofU1G8du0D6ABRyG6ORBMeJzQB65r3p
        7bb8hx1yWvo5QB21DYzybPdsahqmlNo28OsF+ImxKnbleILwhnE7JSPUEqATFoHw
        Tur7FR7GU5QON2uXVs9YQmsCsUdh+Plbx/U1sdzVJ4s95H17MDMZSzlbEkjomzLE
        Ce5AruK8Hjugbx/JV6f0P20qC6EJij3C0KhJeWZnL+MY/ScspvCWXVgWEJS0lqaS
        boOJWD7fdbBq9gF9bAkSX7hf55t1H7YqMgugXZ4OCA==
X-ME-Sender: <xms:9s2PY-RPiMt5T69xpRurCAgHys2d-042fHQL8dM1vmyIFhHZevhewQ>
    <xme:9s2PYzz49sYne5g9HLkc1jTDZ_UgIQS0htzvQR3M5M9mDQSo3OOJefxKt3hVfCn2T
    PPVK8GGdz5fCR8>
X-ME-Received: <xmr:9s2PY73x3XAPGcFhueJEurpdAj0EN0c6xIUWfRY_q3sXR2axa42Oonrxc940>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghmihcu
    ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffejgeej
    geffkeelveeuleeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhl
    rggsrdgtohhm
X-ME-Proxy: <xmx:9s2PY6Anz3rsRLhI3T_pwP9dNlu0bovHLiu_3UVPY-yCEZnwQTSJHw>
    <xmx:9s2PY3hjkeuIwgEksYRgD-aFhH4z0eYjjl-9rD-CEVlP1fdm53zdRQ>
    <xmx:9s2PY2rGyy949l-8dH_tsBlPVQX8s5zs41ddkRmJNhEEd5Rzalc_-Q>
    <xmx:982PY2Nwfd7hSu1tRpEaRy4dYy0a3mf2X2E0t1HlLoE2d_mfn7U-2w>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Dec 2022 18:19:18 -0500 (EST)
Date:   Tue, 6 Dec 2022 18:19:15 -0500
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
Subject: Re: [PATCH v2 6/6] efi: Apply allowlist to EFI configuration tables
 when running under Xen
Message-ID: <Y4/N9N8CrNmZYb/M@itl-email>
References: <20221003112625.972646-1-ardb@kernel.org>
 <20221003112625.972646-7-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yFL3xKiDvU6MCqho"
Content-Disposition: inline
In-Reply-To: <20221003112625.972646-7-ardb@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--yFL3xKiDvU6MCqho
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 6 Dec 2022 18:19:15 -0500
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
Subject: Re: [PATCH v2 6/6] efi: Apply allowlist to EFI configuration tables
 when running under Xen

On Mon, Oct 03, 2022 at 01:26:25PM +0200, Ard Biesheuvel wrote:
> As it turns out, Xen does not guarantee that EFI bootservices data
> regions in memory are preserved, which means that EFI configuration
> tables pointing into such memory regions may be corrupted before the
> dom0 OS has had a chance to inspect them.
>=20
> Demi Marie reports that this is causing problems for Qubes OS when it
> attempts to perform system firmware updates, which requires that the
> contents of the ESRT configuration table are valid when the fwupd user
> space program runs.
>=20
> However, other configuration tables such as the memory attributes
> table or the runtime properties table are equally affected, and so we
> need a comprehensive workaround that works for any table type.
>=20
> So when running under Xen, check the EFI memory descriptor covering the
> start of the table, and disregard the table if it does not reside in
> memory that is preserved by Xen.
>=20
> Co-developed-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/efi.c |  7 ++++++
>  drivers/xen/efi.c          | 24 ++++++++++++++++++++
>  include/linux/efi.h        |  2 ++
>  3 files changed, 33 insertions(+)
>=20
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 2c12b1a06481..0a4583c13a40 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -560,6 +560,13 @@ static __init int match_config_table(const efi_guid_=
t *guid,
> =20
>  	for (i =3D 0; efi_guidcmp(table_types[i].guid, NULL_GUID); i++) {
>  		if (!efi_guidcmp(*guid, table_types[i].guid)) {
> +			if (IS_ENABLED(CONFIG_XEN_EFI) &&
> +			    !xen_efi_config_table_is_usable(guid, table)) {
> +				if (table_types[i].name[0])
> +					pr_cont("(%s=3D0x%lx) ",
> +						table_types[i].name, table);
> +				return 1;
> +			}
>  			*(table_types[i].ptr) =3D table;
>  			if (table_types[i].name[0])
>  				pr_cont("%s=3D0x%lx ",
> diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
> index 74f3f6d8cdc8..c275a9c377fe 100644
> --- a/drivers/xen/efi.c
> +++ b/drivers/xen/efi.c
> @@ -326,3 +326,27 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory_de=
sc_t *out_md)
> =20
>          return 0;
>  }
> +
> +bool __init xen_efi_config_table_is_usable(const efi_guid_t *guid,
> +					   unsigned long table)
> +{
> +	efi_memory_desc_t md;
> +	int rc;
> +
> +	if (!efi_enabled(EFI_PARAVIRT))
> +		return true;
> +
> +	rc =3D efi_mem_desc_lookup(table, &md);
> +	if (rc)
> +		return false;
> +
> +	switch (md.type) {
> +	case EFI_RUNTIME_SERVICES_CODE:
> +	case EFI_RUNTIME_SERVICES_DATA:
> +	case EFI_ACPI_RECLAIM_MEMORY:
> +	case EFI_RESERVED_TYPE:

Some firmware uses EFI_ACPI_MEMORY_NVS to store ACPI tables, so this
needs to be added to the allowlist.  Otherwise affected systems will not
boot.  Xen treats EFI_ACPI_MEMORY_NVS the way it treats
EFI_ACPI_RECLAIM_MEMORY, so this is safe.

> +		return true;
> +	}
> +
> +	return false;
> +}
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index e0ee6f6da4b4..b0cba86352ce 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1352,4 +1352,6 @@ struct linux_efi_initrd {
>  /* Header of a populated EFI secret area */
>  #define EFI_SECRET_TABLE_HEADER_GUID	EFI_GUID(0x1e74f542, 0x71dd, 0x4d66=
,  0x96, 0x3e, 0xef, 0x42, 0x87, 0xff, 0x17, 0x3b)
> =20
> +bool xen_efi_config_table_is_usable(const efi_guid_t *, unsigned long ta=
ble);
> +
>  #endif /* _LINUX_EFI_H */
> --=20
> 2.35.1
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--yFL3xKiDvU6MCqho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmOPzfQACgkQsoi1X/+c
IsHZ7Q/+JBs5ynGubAFJvx5kyi83tgpkjIadoLi9c/79upH+rZbuMh9ZGDJI7iT0
MSnAiR4sq1LiHOdJP7YsgJ38ueXthUNu/dOYqVrxIAIwnT+LwJGX8xBaJYIVeGIX
qCZlG79QINtMEzjOiDfqX/NBPPt4TebgWFcIEDxP000me1yLFTOjW84sHzt1diAa
BDGNCdc7Cf/V+keVdqJdN6mGf1b1i64ZHQTD1ImBamLPrXsNWPGJPEDdItb21DSq
QFSeQSgs50yDWjq+nXj99xutymTAbMM2RvcsgFAXqmfYKpO1bvRFNgLxORBVBJps
kdRiNBAt88+itifXs2pfdurEFOuWZO0up0YhgeTNgB6TrcLPUPJ8LJHbOrUufZXO
+RXVe4S7VJ7hXRqILlvhG+IpauX44GxKi4Gm0ZQWW7IUD7GuffBkDldwYZseFZwk
A70ASRFfUKfb9UKCJgRvou8TKCQdAgJpZh0i2GLigZJIgOtQfHKd6OUUv6/Dn5r8
p00PbOq7mlI15NdYTLE+9ELMkWIaCG6X6o/3THsS1GB+ZwoKFn5GsHSd61zqcld/
reyu3J8snKDlUZ3azyDVsgLz1vUiJXeeuyobrJEI5b4Fn4KrNZcH+G1bXgxz7RKV
At5gPBO6x9+fdhlUCVsjfcdmTDqii0gJ+oPHY9Ldguscll+dCTQ=
=2I76
-----END PGP SIGNATURE-----

--yFL3xKiDvU6MCqho--
