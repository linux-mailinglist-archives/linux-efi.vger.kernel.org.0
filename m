Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F505F2415
	for <lists+linux-efi@lfdr.de>; Sun,  2 Oct 2022 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJBQ2S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Oct 2022 12:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJBQ2R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Oct 2022 12:28:17 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1678331DD7
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 09:28:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BBD9F3200312;
        Sun,  2 Oct 2022 12:28:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 02 Oct 2022 12:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664728095; x=
        1664814495; bh=MiecNKyXd2mjQKvsiXXO7VUmoA5W7UHlKNcygluiYqQ=; b=d
        IS0utWmebj985wLTUYcwtwPGdLb/rcuFhmqLL4Q/gW/kiEj5WKLtLLKgmztqiEAm
        CUkVGzXH+ztEb1QecYfLoqcMHRJYBX4yKKKalT89gwS9WaTIV9GAeIAhoLuq1USh
        t/jKBYsG86yfhCxGJ3kgUXOaseOK1OFJpDbkf35MfqEIIJqMXO0ybVSw3hB1gB3M
        d1RDx/4+Ru0K2yWQGAXQvnJqd6dyZNhcWT760K3pwFfwPEJ8AHpt0QvXSRqG41va
        iJsGUGFVbCNp1fuZJ1So2yzH+yjyWQ10mMWfKdK5gM+m668wjea45jh7aqC1vWVF
        SF+Uu13kg0gLhB19gZ16Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664728095; x=1664814495; bh=MiecNKyXd2mjQKvsiXXO7VUmoA5W
        7UHlKNcygluiYqQ=; b=wOZdpC3j8qBpb/YpaHsXpp1cVz4CLQJ1jlIgjmziRtnh
        J+tmUA4dcgoq6E86tHV4Qn1FUZ1OAhN1M5Z5WosdbPcdHrx+UWAjhiwj9ZQyEsF5
        pDemQSyJ9kyT1U6bdw5sfZHByiI1kjE3moiA5Frifhr9vAezX/z7rX4I4PjVnCyG
        /k6kmQAp1t0vTf56gLGXUHiO0esOW7sZbLMWUXMsXgodW93+8YrncWWkWikPoqiU
        OjUjtvHrquWOwhcFvAwgCdecBUBbRuPRfovNIM31RRqXdyI1TTderDmgQbgnhR/U
        N9rz2vLmQiMImpELeNDw8rCv9xVHUhctkG4qU/Ak3w==
X-ME-Sender: <xms:Hrw5Y1J49C4jmA53GcWuk7dtf2LN8dfTrPedyYhHj9ooDOn7jAAXmw>
    <xme:Hrw5YxIDv_HF6ZhWP25CohWp91uf1FA4IQTWF1dovLPc6fOL8_WKwcv9I_K3uirPr
    Lwe0UWkq0q134k>
X-ME-Received: <xmr:Hrw5Y9vSDvP-7wY4IgaeW6bUwY9tRnNaVyXovEkntJL_0xxCU6FlNbDhZ1b5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehjedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:Hrw5Y2b1h18k9DkfRUlh5XU_7Vat04XMHgsb2Fo9laHllyRj2zpAdQ>
    <xmx:Hrw5Y8bkqL3K5OAVjumTnOzquydFVgYiohkqpZXNc9mgJVfJ5jNalQ>
    <xmx:Hrw5Y6Do4ZmpspLh-PfUIdrJUDUUcAQy43hT5Oc_BsJY1Cg9SJsIyg>
    <xmx:H7w5Y6k7veAW2bt3yGZlllmkjXHtrmhsjXPeBSg7hF2-hM_SydZD1Q>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Oct 2022 12:28:14 -0400 (EDT)
Date:   Sun, 2 Oct 2022 12:27:45 -0400
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
Subject: Re: [RFC PATCH 5/5] efi: esrt: Omit region sanity check when no
 memory map is available
Message-ID: <Yzm8HIccvuxyicYx@itl-email>
References: <20221002095626.484279-1-ardb@kernel.org>
 <20221002095626.484279-6-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QQU1t/S22Mb/zn2F"
Content-Disposition: inline
In-Reply-To: <20221002095626.484279-6-ardb@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--QQU1t/S22Mb/zn2F
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 2 Oct 2022 12:27:45 -0400
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
Subject: Re: [RFC PATCH 5/5] efi: esrt: Omit region sanity check when no
 memory map is available

On Sun, Oct 02, 2022 at 11:56:26AM +0200, Ard Biesheuvel wrote:
> In order to permit the ESRT to be used when doing pseudo-EFI boot
> without a EFI memory map, e.g., when booting inside a Xen dom0 on x86,
> make the sanity checks optional based on whether the memory map is
> available.
>=20
> If additional validation is needed, it is up to the Xen EFI glue code to
> implement this in its xen_efi_config_table_is_valid() helper, or provide
> a EFI memory map like it does on other architectures.

I don=E2=80=99t like this.  It is easy to use a hypercall to get the end of=
 the
memory region containing the config table, which is what my one of my
previous patches actually does.  Skipping all of the validation could
easily lead to a regression.  I understand wanting to get Xen-specific
code out of esrt.c, but this isn=E2=80=99t the answer.  Some sort of abstra=
ction
over both cases would be a much better solution.

> Co-developed-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/platform/efi/quirks.c |  3 +
>  drivers/firmware/efi/esrt.c    | 61 +++++++++++---------
>  2 files changed, 37 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirk=
s.c
> index b0b848d6933a..9307be2f4afa 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -250,6 +250,9 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u6=
4 size)
>  	int num_entries;
>  	void *new;
> =20
> +	if (!efi_enabled(EFI_MEMMAP))
> +		return;
> +

This function does not actually work under Xen, even if EFI_MEMMAP is
set.  When running under Xen, either this function must never be
called (in which case there should be at least a WARN()), or it should
return an error that callers must check for.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--QQU1t/S22Mb/zn2F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM5vBwACgkQsoi1X/+c
IsEwCxAAlyb5VQUqy3kjfzT9uVV2XGHHsFY5oUp2S1DOf2/vSL4zaWmqVB/AkYDt
kavthj4HgkbYaZcwxMtxlwQ+W0dLDoTjRQrIVOmT09JmQptihevWVjOrCEqIxSt9
BUw04yrgVUaG6GgkI0oierJOfgUpUfYSk2Le3kDR+KmparUv5zVHbVYmmERPOQnF
zNYuYx9s+Vw8TeOXvO7a6uba41ebD6eLbd+pWtBT/qaP7+0tqUGbGSEemesC4/us
XU/pHjJZAyyNc60c12xziMd+dCCcHD0SJ8iuevAOUD6dgXE2WAhiGxMeXH34tLGK
cCEPwSYf34OW77qeOZLDuqzRUmidh5U87a57onxkcnYBsP2sWP/2INXcfP0LhZkI
XRhO7xJQewPkAvAY7KYVByXarMmCEosSwSuwyu6FncBwrvrSEW6BaPmDmv2lW49A
5+OUaLXuUPW9/9AHoaneIssBmd/f1cpnFE+6coHk0EakKyUtxLb+BAOzk3krT6Hd
Og9qaOOrttTVwkTvegPcsAyElcJ23KJk6HbJDYeSvN/BIihyHkE3yUpYbD35qgM6
xpdR/B7y5/+YDxi1NopNBZSha6VM24+THP9qVT6M2dzxdtG+HpwPq7mtP70vpI6j
aR6qe3DIJWdbnI68PXWOtu8xLW7y5UIv7KIqblKYmXdTBXAKQhM=
=za8l
-----END PGP SIGNATURE-----

--QQU1t/S22Mb/zn2F--
