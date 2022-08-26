Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B5E5A2DED
	for <lists+linux-efi@lfdr.de>; Fri, 26 Aug 2022 20:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiHZSBx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Aug 2022 14:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiHZSBw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Aug 2022 14:01:52 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB34F9C2C9;
        Fri, 26 Aug 2022 11:01:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 83D115C005A;
        Fri, 26 Aug 2022 14:01:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 26 Aug 2022 14:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1661536907; x=
        1661623307; bh=4ZXRyN/6PHKsITnMYINhCH0rT/aFKu8us2ywc2yLlP8=; b=r
        lN/Qgp4Ox4hRkAMkIleMZWd3BQFtE22obvxFQz6e5uIHUX2Qhc9onokA6JNj6i37
        qUUWf3061ZOc6dPK6xruRt4U0tI7mis4iaEoMJgOaT9i7pl2694VUoLC6XlpAq9C
        Fe7rBunn4SRpRMg87pcsOi/ZNUQna17Y9u/SDugETJsQFhh9S7pI3F4B+sF6crDK
        DAuMHFS1KEg4omYJjmTMkDbklI1DbGVL3OFC7WbnMGY5+NsQwYadn08lyYQeXcKz
        eF13MnTyW58glKdS1JR9Oo1M6kmrD8/NdEIouAWs5me6TKFty7b36H1wOczQhOo1
        vrM6W5RrSbb0Sc5AWwjWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661536907; x=1661623307; bh=4ZXRyN/6PHKsITnMYINhCH0rT/aF
        Ku8us2ywc2yLlP8=; b=L9FlE9ul12nEuEC58bhyKNhS70s04eTVfzKbu4p/fN4N
        Ihz9P298WwGN/bYbzFmBnqz02kby9wy3LeupppoB5houwB8GPiLZQQX2FLyvhVFF
        zVJPb3W5UZFnWQAmQ/cdOYDL9qhZjwmNzJzhlsVo+BS+67btWEF4DLoSeb4+E3SH
        QZBB5mlYiF6GKgwapsFcQ/Hy9XN0bMh2Sodsx35PP6uTsDuRiw9JvmSzqg6Qi06H
        SOa0V6BZPIA4JMgBiMJS0BTTWj6iWu1GijZEIhpeVYHRgRLJs4PvQQXi7ksw73iP
        3RSCs1TsspiazogWnaSp+pQL1IoaUzUE655xyE1YDw==
X-ME-Sender: <xms:iwoJY55NzO8Vt9zEuykAJRZlnv7zeV4duwcK0GW3taDfvF4vlKO_hQ>
    <xme:iwoJY24cV4H7r1Lmx02voPSX555_C0SVuOFbP5_GxhMn2ep3SHZj0wOEn73HLqKYs
    2E2aoV-To5156Y>
X-ME-Received: <xmr:iwoJYwdHauY1-FaOTKVRAGqXvtDlhXpGro8ICoR6WzuK0FxJYqC-0ztxajVF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffej
    geejgeffkeelveeuleeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:iwoJYyL0Z2gideEIq_sT4AwxbVgTaYLdWbKW0X84Gxy1o2C7AS6rBQ>
    <xmx:iwoJY9JCNaE2sHJZgMNW8CA340lq3V7MrULGmCet7SaGn3ewacXl-A>
    <xmx:iwoJY7y7NLQA0_lINcm6kXi-oxe1mMLLqfER1GzRakvkTmM3ZvCeQA>
    <xmx:iwoJY7jLSEODOCfwPCe0qwbeRCAk6ucGspsO12s6KnVTiAt9yDUamQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Aug 2022 14:01:46 -0400 (EDT)
Date:   Fri, 26 Aug 2022 14:01:44 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, Ard Biesheuvel <ardb@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH] Add support for ESRT loading under Xen
Message-ID: <YwkKiFIKHG4IcCmH@itl-email>
Mail-Followup-To: Jan Beulich <jbeulich@suse.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, Ard Biesheuvel <ardb@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20220825215218.1606-1-demi@invisiblethingslab.com>
 <c2a22672-b9dd-7aa4-b61e-ccb0faaa3b01@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ADaG3VrA093Bc+/S"
Content-Disposition: inline
In-Reply-To: <c2a22672-b9dd-7aa4-b61e-ccb0faaa3b01@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--ADaG3VrA093Bc+/S
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Aug 2022 14:01:44 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, Ard Biesheuvel <ardb@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH] Add support for ESRT loading under Xen

On Fri, Aug 26, 2022 at 09:53:29AM +0200, Jan Beulich wrote:
> On 25.08.2022 23:52, Demi Marie Obenour wrote:
> > @@ -40,6 +41,38 @@
> > =20
> >  #define efi_data(op)	(op.u.efi_runtime_call)
> > =20
> > +static_assert(XEN_PAGE_SHIFT =3D=3D EFI_PAGE_SHIFT,
> > +              "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHIFT");
> > +
> > +bool xen_efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *md)
> > +{
> > +	struct xen_platform_op op =3D {
> > +		.cmd =3D XENPF_firmware_info,
> > +		.u.firmware_info =3D {
> > +			.type =3D XEN_FW_EFI_INFO,
> > +			.index =3D XEN_FW_EFI_MEM_INFO,
> > +			.u.efi_info.mem.addr =3D phys_addr,
> > +			.u.efi_info.mem.size =3D ((u64)-1ULL) - phys_addr,
> > +		}
> > +	};
> > +	union xenpf_efi_info *info =3D &op.u.firmware_info.u.efi_info;
> > +	int rc;
> > +
> > +	memset(md, 0, sizeof(*md)); /* initialize md even on failure */
> > +	rc =3D HYPERVISOR_platform_op(&op);
> > +	if (rc) {
> > +		pr_warn("Could not obtain information on address %llu from Xen: "
> > +			"error %d\n", phys_addr, rc);
> > +		return false;
> > +	}
> > +
> > +	md->attribute =3D info->mem.attr;
> > +	md->type =3D info->mem.type;
> > +	md->num_pages =3D info->mem.size >> XEN_PAGE_SHIFT;
> > +	md->phys_addr =3D info->mem.addr;
>=20
> As indicated in reply to your patch changing XEN_FW_EFI_MEM_INFO in
> the hypervisor: While this may fit the ESRT purpose, the address you
> return here is not necessarily the start of the region, and hence
> this function is not a general Xen replacement for the non-Xen
> function. Therefore I think it also shouldn't give the impression of
> doing so.

Is this just a matter of renaming the function?  Is it possible to
implement the original function with the current hypervisor?
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--ADaG3VrA093Bc+/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmMJCogACgkQsoi1X/+c
IsEOXA/+KcxojsYfgCdCpNKkR9XEwx/tYKqs5TYjfEtdS8+dyEV3WCb90RA95rJf
nPCqsC3lqKs1xKCZCVQ9Qnsk0PtD+NBfjUnPDNZxSXOanSrfHTlqCE5v73Wsx3U9
vDOgx8fpvsR7pLQJ1nD56zKgomKkHJw1sv+Ac+y85CdZDkCB4JHPnobHx7cRsrg7
7+ZQbU3HdHQc655XDIK6a5HisFsLDvwHHCAPFUeyq3VEfFIWTuXBnYxVRgb2VGF8
uwfuQ13QaS8yu+yTQ444X4N/vwTj0ZGwjHdwS8UGM1skUcW4NSig5ymt4MAlIfnr
SdHutMhenm0+JuKwg9QNTbNb2q3XRKH+9FJ1tCX3fFirqz6H07PNLVKMJKM4VHbz
DAREFZtuFRtxxeymiSmrxJkNNByDXOwx5JdxEPZYAHhHOT13NCpv4M/I0UihEkXU
0Z6sUYHKam/XhYUtC08K9KQWt/65f7PjouulEp60cL7U14yZKi/yHzhGugWzPUUl
/6lXXaICO9JohvISVWlnfvYDyMrzXgo3MSGBk3ByUDzNaaby+xPyS4aTsmOHW91G
Jr5JUFNVRR6gAJO1UX5ZzH7b64ybpCzBC/DRMtTyhZnBkuv9dG0E8G45zyw06BoZ
ltToA0VyXeJcPm2hpB6RqtcPT+ZacoRO9vE/D4ihNruF+9cw1pg=
=t2WL
-----END PGP SIGNATURE-----

--ADaG3VrA093Bc+/S--
