Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EEB5F1026
	for <lists+linux-efi@lfdr.de>; Fri, 30 Sep 2022 18:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiI3QjY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Sep 2022 12:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiI3QjX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Sep 2022 12:39:23 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D7A176AE8;
        Fri, 30 Sep 2022 09:39:22 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 52D043200A6D;
        Fri, 30 Sep 2022 12:39:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 30 Sep 2022 12:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664555957; x=
        1664642357; bh=DoeBKhNM231m+VnHzmoAfyLlv634Z/C2yHlE48QGwmE=; b=R
        AnXKkXOMSU+BfY4Svif+GgKtE3EZZR3FiZYcOA+s2P9XKphqptvxQcDvtBL7PzQP
        shp5xMoQBmWW7RNxGlVd+Bv6xE3OjATiKgCM5XGEBiwRC8AW7A4F1ux6kk0nCg2L
        XqhnZ6kb177nOJAU82R92cE+AupGNIelZS/xmvzxPgj2umJEpRHAHVbCrzbZYCbQ
        roKywPaJxZyfBR66TVyA4HuO1fWoQWza6Y5ASQ66iEVO3Y1+gBPG9ckXc+qR9ScY
        9QV7w5uWcsqdHoPxO5anCFwFHmfNBQ/2BbrUMvcrcFJbloqMtfwsEUk5+IwwsPGd
        awuq5w4dEiAtXBAqhPc2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664555957; x=1664642357; bh=DoeBKhNM231m+VnHzmoAfyLlv634
        Z/C2yHlE48QGwmE=; b=v6oSJCSW4ufsZYuHvjpdFCKETWg0LBcB5eaRsQ5vdWpt
        vxPD8C9cZc7gDuOAL2nzs3mEj6S9FW/e5pICSLp+1mnoZgBu4cBtpOhGeeD++oQ7
        7ZxUDAT511KNqeKQbk3ZgjdUKToYMY4zj2y7lXAIFn0N3kb+Wbg151SA2NqpXwBs
        srg9BqzDYH+w4tKSBGE5TQlVjS8hEnvnfucrPZoVVL9lYfNbAw1GqBzQVmmxGcxM
        Km0eT72RYcDN7q5QfGUDuISqLdBHYtnmSMNpsL9/mBmRvcCOFFOQnTf4urccjJtj
        V/myZcCnbX+TV4MQuV+i5mfsExXXNpEbumvzg9C5Rg==
X-ME-Sender: <xms:tRs3Y697v69hD6kc4RYG_ZxKzeIBGTJCbmddPgG2MVm6ZbTanhIjOA>
    <xme:tRs3Y6v_8OzS7k2GNYO-GzVj8ohhOhnI6iMbmMx1DWBBL5-ZpHt27fHyIsWPQ5fXK
    1K00qEl4WmQXe0>
X-ME-Received: <xmr:tRs3YwDWVFtdYlcoRdQoWWmN5e8RBmHUPLQrmzmuEYxKu_OI7xhscBi4Bq1x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehvddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeekteegiefhteehffegvdeggeej
    udelleeltdffveevtdetfeejuefgieeuhfeuleenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    uggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:tRs3YyeKRqjEvl4Ew9XCNU12lyit7CEJIay727nimibkdqX9xiuH_A>
    <xmx:tRs3Y_OgX3Dr0jONZpwrHdwYTwBd6h9pKcU-ZQowBbC0q_fk_AAsgg>
    <xmx:tRs3Y8l1PF7af2AT3iKc3Z_58XkvAg3EEHVv6jBB7675EZFoL8bU9Q>
    <xmx:tRs3YwFWDOb9fh3vAjFVtU0X_5qyl9pHqqJqoxPEbN5ShLCl2Frn7A>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Sep 2022 12:39:16 -0400 (EDT)
Date:   Fri, 30 Sep 2022 12:38:44 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
Message-ID: <Yzcbs6TYsFQU/I4f@itl-email>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
 <282a225d-8782-0321-6f0e-19dd4510dc42@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SGczFINJLmmUm2Ge"
Content-Disposition: inline
In-Reply-To: <282a225d-8782-0321-6f0e-19dd4510dc42@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--SGczFINJLmmUm2Ge
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Sep 2022 12:38:44 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered

On Fri, Sep 30, 2022 at 08:44:21AM +0200, Jan Beulich wrote:
> On 30.09.2022 01:02, Demi Marie Obenour wrote:
> > Memory of type EFI_CONVENTIONAL_MEMORY, EFI_LOADER_CODE, EFI_LOADER_DAT=
A,
> > EFI_BOOT_SERVICES_CODE, and EFI_BOOT_SERVICES_DATA may be clobbered by
> > Xen before Linux gets to start using it.  Therefore, Linux under Xen
> > must not use EFI tables from such memory.  Most of the remaining EFI
> > memory types are not suitable for EFI tables, leaving only
> > EFI_ACPI_RECLAIM_MEMORY, EFI_RUNTIME_SERVICES_DATA, and
> > EFI_RUNTIME_SERVICES_CODE.  When running under Xen, Linux should only
> > use tables that are located in one of these types of memory.
> >=20
> > This patch ensures this, and also adds a function
> > (xen_config_table_memory_region_max()) that will be used later to
> > replace the usage of the EFI memory map in esrt.c when running under
> > Xen.  This function can also be used in mokvar-table.c and efi-bgrt.c,
> > but I have not implemented this.
> >=20
> > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
>=20
> In Xen we don't clobber EfiBootServices{Code,Data} when xen.efi was passed
> "-mapbs". Should we perhaps extend the interface such that Dom0 can then
> also use tables located in such regions, perhaps by faking
> EFI_MEMORY_RUNTIME in the attributes returned by XEN_FW_EFI_MEM_INFO?

I can add a check for EFI_MEMORY_RUNTIME, but only if I can require a Xen
version with https://lore.kernel.org/xen-devel/cc0fbcb4-5ea3-178c-e691-9acb=
7cc9a3a7@suse.com/t/#u.
This is easy in Qubes OS via RPM dependencies, but I am not sure if it
is suitable for upstream without a mechanism for dom0 to verify that the
patch has been included.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--SGczFINJLmmUm2Ge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM3G7MACgkQsoi1X/+c
IsGoBxAA1qb1ePsiOtinAK894ShZXnVAj3jNHthhWj963jYXw6jD9iX2hYAeRFvw
ViOU6LodPurxZl4DJpiOW738pLkTYWf6CDfA01oPf2PD9nUA+kdD1doldC3PQ5Pf
yBpX0cPWDmP7xnNzdHW/ogcBCBVs6RBwiVFJsklGfKtQ9CfxRCW0q9KGL+YJTkL8
uSNTPe1v+4Q+ZdXs0Qsn/Yj33mOcg7ECO00cT8lgfF4lV/xIvi8jTgWjHVlkK3Qs
yxhmIiH0tvdegEu4uLcA15EmcFNi+l3Dkx8WU1674wDy/ZG1DdLljbFRSxp3HUjq
i5G2sixSYHn/PH6f6b8mOJFwHDasyDnV3FZbE9oEXAhz8Qz1zp6BlCQ3g/bFTyhU
lTVoMNL6AuXFFQ9eRAy5YWcNc/Ypt2eg/IBPXZDBP35Uq/BhYdzVkrlWUvYBhm82
iPZ7yyUsmjots3iLJkHgmA85ZbSDV1oMallsRmosYgTiam9N4/F7eHM3kIAjmnMD
yDaD4rQBPYY7a8+GEXfdS1EirIR94Ysb+D6zuMl0f9onBg1eW22955zWYtCgo4pW
dNE0NoMzSwdwvHi6VIA51K9Qz/LJMtXiin01RSbmk0vVyIuOnmKQElueQmw8S97O
tcxYwdZ6+4h6CZr3Iez+UXsH1rvB89qlW7bdkS3ETJH2RgGCsOo=
=pxje
-----END PGP SIGNATURE-----

--SGczFINJLmmUm2Ge--
