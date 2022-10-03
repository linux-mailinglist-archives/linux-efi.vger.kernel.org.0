Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53165F2964
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 09:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJCHS0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 03:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJCHRR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 03:17:17 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180A83F1D1
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 00:14:16 -0700 (PDT)
Date:   Mon, 3 Oct 2022 09:14:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=damhet.fr; s=key1;
        t=1664781255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8e2DqRm8Fr37UpMNtLFLVQfyrO3Y5Aqcz2YZzEZJH4o=;
        b=gUrJdGERjTT52lIiAObFEvLKM51KkcGeHshJqURxInKza672foN2CaUj+52RGSjE/EiJU2
        xfIziKYF2TxkldiYVzkbWwCIWELWr8oGnMpNMCuH0R2ltKd8j5X8wVLVcF04hYcLw1IGkk
        2Dt6FcPsV5tSw9x03Ql4s5tQmaO9jdo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Antoine Damhet <antoine@damhet.fr>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org
Subject: Re: Disable lockdown while keeping SecureBoot enabled
Message-ID: <20221003071412.gpjs3tb7p522rplz@tartarus.xdbob.net>
References: <20221002150037.ad3tgbllhvt6zwwy@tartarus.xdbob.net>
 <CAMj1kXGqtoX7yVgCu+5mmFUiRCytyxrgJnRjD6LwnA4C-L6=2w@mail.gmail.com>
 <20221002170624.sp2zyeoowqv4fjnu@tartarus.xdbob.net>
 <CAMj1kXHjMH7eC2FMAa_knYt7+V1976r0RGLcdcS5o1v-PdhCYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="suotwdmjm5dr2bhz"
Content-Disposition: inline
In-Reply-To: <CAMj1kXHjMH7eC2FMAa_knYt7+V1976r0RGLcdcS5o1v-PdhCYQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--suotwdmjm5dr2bhz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 02, 2022 at 11:15:28PM +0200, Ard Biesheuvel wrote:
> On Sun, 2 Oct 2022 at 19:06, Antoine Damhet <antoine@damhet.fr> wrote:
> >
> > On Sun, Oct 02, 2022 at 05:28:16PM +0200, Ard Biesheuvel wrote:
> > > On Sun, 2 Oct 2022 at 17:00, Antoine Damhet <antoine@damhet.fr> wrote:

[...]

> > > > Until now I disabled the lockdown by setting the `MokSBState` +
> > > > `MokSBStateRT` UEFI variables to 1. Now they need to be volatile.
> > > >
> > >
> > > OK, so this means the patch works as intended: MokSBState is owned by
> > > shim, and you are not booting via shim, and so honouring those
> > > variables was a bug.
> > >
> > > > Would you be open to either add a variable or a command-line argume=
nt to
> > > > disable the kernel lockdown while keeping SecureBoot enabled ?

[...]

Thank you for taking the time to answer,

>=20
> The distro kernels enable lockdown by default if secure boot is
> enabled, and the way to override that is to use shim and put it into
> insecure mode. So you have plenty of options here:
> - build your kernel without the lockdown LSM

It would work but would be inconvenient for most users IMHO.

> - use the distro kernel with shim

1. If the shim is in secure mode -> I'm back to square 1 and effectively
   the lockdown is enforced
2. Unsecure mode -> anyone can boot anything
3. I need a custom shim to both enforce the signature and tell the
   kernel it hasn't. It would work but I think I will loose the
   signature/integrity on my cmdline and initrd

> - create a [signed] driver or uefi app that sets the volatile
> variable, and install it as a Driver### or SysPrep#### boot option
>=20

I like this one, when I have some free time on my hands I will play
around it and keep the list informed.

> Adding command line options or any other setting that is not signed
> and is persistent kind of defeats the purpose, so I don't see a point
> in adding support for that.

On my case (I don't know how common it is), I bundle the
`kernel+initrd+cmdline` into a single EFI binary and sign the whole
thing. Making my command line a trusted source. I don't think the kernel
is aware of this and wonder if it could without some terrible hacks.

--=20
Antoine 'xdbob' Damhet

--suotwdmjm5dr2bhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAmM6i8AACgkQ3AmjLzzl
jz5u/gf9GgISJFDJa94J6P5yq1BVYwCRI0lIxBzpdE/szeZMveZz8HuPuL6OUV1g
yCmY9AUPeOFGwzGm7bKSdbztOlO5lslda8Vin4cTT7QnjxYxHFQTSpmQiypg//Na
SK1exhbWoQ5QF2IaDbvS1LkGg/yeuGtFFFMGJnS14hHZHpE0cfn64FxA8kYxvv0r
IcScyJ0WpCP7LwnaRAkh9JTuP/sdDwgEtMo06Yz30O1dAAqal+Vw10MYzlKLyQp9
0fubuP691EmgbxuSb56mS3AKj2HVZsQ0CFjBTA2ZlrJMRUClVVB6SAjCICz1x1vS
K9gQ6bYIsY975JO4iN1acvwDPGIZNw==
=AgNp
-----END PGP SIGNATURE-----

--suotwdmjm5dr2bhz--
