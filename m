Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA15F5990
	for <lists+linux-efi@lfdr.de>; Wed,  5 Oct 2022 20:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJESLr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Oct 2022 14:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJESLq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Oct 2022 14:11:46 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C0D4AD70;
        Wed,  5 Oct 2022 11:11:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A648B5C0066;
        Wed,  5 Oct 2022 14:11:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 05 Oct 2022 14:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664993502; x=
        1665079902; bh=QbCwngRgoYYz/l1YN30XHGdNSPXH235wrNnuhXtSynU=; b=m
        dofbwBSXXpVc47Gw1UKfW0vy+ZwFa54+XYyP6WxQdDjvqxoBR5y6lizxIKXT9aH9
        LXYnXvrAx6VCW98nyL8n10sjKJfGEqr77IvgOvTKDTheQGrEKKgC3R05//KhQfpw
        Vz1iRtp2zR8cdqmLG7/XCXkos1F0cZE8PZKNrd9zP3Nss6GtCSrjUki7twc9To6V
        EbjrxeR5Cchvk+ZWfjP1ThTbhmm/qTrFM5ACx3CFWnrrHiVZjH26xeGx/kLx5GJT
        jp/wpXSXOTLtaxT5R07RCVuIZoFw1fsFPT7Nw7LA5buVGvOQIjsYZewAbLP5bZcU
        AFVX4XSw4JgZLhAr8x1Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664993502; x=1665079902; bh=QbCwngRgoYYz/l1YN30XHGdNSPXH
        235wrNnuhXtSynU=; b=G340+HVxAL5emcB+vjDp5hw4bDA+v5WG1ZFCwRdgNZGB
        Is33jyKhwM5ZwlBW244da9wDkRroz1YoMn7kcgRKy5MPeWPQpCCD63CdtOXKBivs
        3M2bDK4bKjhTN7ajrAFNbjXoAeNxP/RiV321XVsAkTnLEuzFw9qlgZPBO/n2WjJZ
        OlJQSFxrILKELZy/0icUhenIfwTKegtMGc5XOxHtSPMfN4Tc9w6CJP87zdK11NQw
        PFHUa2S0M2JXFAPht8QpxDvxaOdbK2sgsNjRLHBzLuHFq97zkuX4cXharEcoVpnB
        nu5TINRyuxEDXXclOR19n3tvgwZnO9WuOFtuefBk1w==
X-ME-Sender: <xms:3cg9Y7lqjpZMxu-QxWl1OrPIlI4w-Wb46EPUu26JSfbRb3T1d0ZMPA>
    <xme:3cg9Y-3CBycGN4IY_3GxzOZEHP7PrmyNgy2APil8kg02MS7gJwtXY4uolb4ZImHCQ
    vv9b_cydzjV02I>
X-ME-Received: <xmr:3cg9YxpFS8ffE2bMi3LeAmtxeEKoFts6WEjpuT7dz4A8v_2oqjlurj9KDOb7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeifedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffej
    geejgeffkeelveeuleeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:3cg9Yzk0_f9FDheCCp8-NE0pehcvboQOGQtsBViZGaLkuhmUaluhoQ>
    <xmx:3cg9Y502ikq_7tu_9kpRVAP2sWh4o9tM1o7HfPlsd_x5YuTLciU7TA>
    <xmx:3cg9YyvrjOlaQPguFvYnGfddah9HMMSE4vbpOjMgW0XRbo0nT8-U5g>
    <xmx:3sg9YyuqDzGmeCycYAl5Avr_jWlIbwHesCToCsPRFtkwgIAloXqnRA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Oct 2022 14:11:40 -0400 (EDT)
Date:   Wed, 5 Oct 2022 14:11:35 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
Message-ID: <Yz3I2qwl243h9ZfZ@itl-email>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
 <282a225d-8782-0321-6f0e-19dd4510dc42@suse.com>
 <CAMj1kXFQNqsW5RfHGac-eGbosJHBybu6+-Fap_bi_kVxWNpGeg@mail.gmail.com>
 <YzcjeiOW8+i2Zxsd@itl-email>
 <CAMj1kXHBBbCNV3CLesqZi7ttmmi8y4tZ1KO5vievy_CJrU2o3Q@mail.gmail.com>
 <YzeaKjmls1YI/3ox@itl-email>
 <01d22092-8292-8ed7-ece7-9ca32d15bbce@suse.com>
 <YzxxXuovwQt3NskE@itl-email>
 <a0dc1158-01b1-4272-b86e-52f4996f0747@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MP5CI1py1S/x6cIa"
Content-Disposition: inline
In-Reply-To: <a0dc1158-01b1-4272-b86e-52f4996f0747@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--MP5CI1py1S/x6cIa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 5 Oct 2022 14:11:35 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered

On Wed, Oct 05, 2022 at 08:15:07AM +0200, Jan Beulich wrote:
> On 04.10.2022 17:46, Demi Marie Obenour wrote:
> > Linux has a function called efi_mem_reserve() that is used to reserve
> > EfiBootServicesData memory that contains e.g. EFI configuration tables.
> > This function does not work under Xen because Xen could have already
> > clobbered the memory.  efi_mem_reserve() not working is the whole reason
> > for this thread, as it prevents EFI tables that are in
> > EfiBootServicesData from being used under Xen.
> >=20
> > A much nicer approach would be for Xen to reserve boot services memory
> > unconditionally, but provide a hypercall that dom0 could used to free
> > the parts of EfiBootServicesData memory that are no longer needed.  This
> > would allow efi_mem_reserve() to work normally.
>=20
> efi_mem_reserve() actually working would be a layering violation;
> controlling the EFI memory map is entirely Xen's job.

Doing this properly would require Xen to understand all of the EFI
tables that could validly be in EfiBootServices* and which could be of
interest to dom0.  It might (at least on some very buggy firmware)
require a partial ACPI and/or SMBIOS implementation too, if the firmware
decided to put an ACPI or SMBIOS table in EfiBootServices*.

> As to the hypercall you suggest - I wouldn't mind its addition, but only
> for the case when -mapbs is used. As I've indicated before, I'm of the
> opinion that default behavior should be matching the intentions of the
> spec, and the intention of EfiBootServices* is for the space to be
> reclaimed. Plus I'm sure you realize there's a caveat with Dom0 using
> that hypercall: It might use it for regions where data lives which it
> wouldn't care about itself, but which an eventual kexec-ed (or alike)
> entity would later want to consume. Code/data potentially usable by
> _anyone_ between two resets of the system cannot legitimately be freed
> (and hence imo is wrong to live in EfiBootServices* regions).

I agree, but currently some such data *is* in EfiBootServices* regions,
sadly.  When -mapbs is *not* used, I recommend uninstalling all of the
configuration tables that point to EfiBootServicesData memory before
freeing that memory.

> In a way one could view the Dom0 kernel as an "or alike" entity ...

It is indeed such an entity.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--MP5CI1py1S/x6cIa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM9yNoACgkQsoi1X/+c
IsGIrRAAqlFxw4VhBVBYtbOHJoeLu1cjHKS/FF5d16yMLnb2yCt9fGSDRIb0L8dR
EG8AmPkMpyXINDJYGR4H4jvLqMF3a51W708ZkLKsT6uEFkVfsjB3VD4BYCzZ5ss7
O84Lfv4GXaxIQn0oXU+SGM47bgA9ahrhmWeDi2AthvrIkb6+1rd9lrd0oiGwfE90
IW5ojsRQaQl7sr1gnm97lg5/Pv9zDh4RMsPMqMOuOg9Pq7wkZVCUYmkjdsA4CRnB
3lNeJdK5IMlL1tmstWZxvWoHrLMWYeGtKslJKYJcWN5CGjgoXs3g8HakbIfOxnif
D5ikSG1A++CqpHTxieovQ8Q5yIQBFTHNTuncXoZp0iqjq6bMfx9qo2tNJda9Oay8
TEqzSDiSeruz4bS5iiILCqNME02ZtcQAXizR9PZ/wNmbfb2EEhu9R2L2aPLBrgNp
hs56nrJ9McRpJXlmqENxwrTgp81rMEgb2cZsxymNqsEzBhRHP/peWjoHby1BVHb0
Q5oNp+rn1lnPJDV1bGrLlUxDfU/ttucJEsEttGCp42GFgnzNihtni3mMFTCWQG1B
X335/qvdsVqBkm5775p+u1MoPNdrEtYAID3ubhp1rfhgp9peup1Ua9Fv2oZ5j90G
T2YYIkuLpo07nXGKRO/JffO0EdLAMvjz0DeSJRQwbQtsGqeLekE=
=C84z
-----END PGP SIGNATURE-----

--MP5CI1py1S/x6cIa--
