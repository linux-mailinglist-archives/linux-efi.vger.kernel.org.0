Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891515F2430
	for <lists+linux-efi@lfdr.de>; Sun,  2 Oct 2022 19:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJBRGf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Oct 2022 13:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJBRGf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Oct 2022 13:06:35 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A8D23153
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 10:06:33 -0700 (PDT)
Date:   Sun, 2 Oct 2022 19:06:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=damhet.fr; s=key1;
        t=1664730391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dc3Ex2h/+3bH4/09X2E0J8LhtQpu1oshxwWKo7mgAgM=;
        b=VFdXFrvz0FmUZFe7o60XG7tOop+hI6bO0nCrv7g5MOe2Quh37v2aTYqEn8nTxLihmCqlJx
        uEs/KMmTPdWJ0RhJO2RIIQgB5CNHI5Z3L+n81OGn9/PGvnYSbBhofZsc0d7LgPEMF8gKWc
        lqQKvAa3pT88ZuB1qRAYC8o8pZ1pjZg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Antoine Damhet <antoine@damhet.fr>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org
Subject: Re: Disable lockdown while keeping SecureBoot enabled
Message-ID: <20221002170624.sp2zyeoowqv4fjnu@tartarus.xdbob.net>
References: <20221002150037.ad3tgbllhvt6zwwy@tartarus.xdbob.net>
 <CAMj1kXGqtoX7yVgCu+5mmFUiRCytyxrgJnRjD6LwnA4C-L6=2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6pd2jm4ibqg6ezju"
Content-Disposition: inline
In-Reply-To: <CAMj1kXGqtoX7yVgCu+5mmFUiRCytyxrgJnRjD6LwnA4C-L6=2w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--6pd2jm4ibqg6ezju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 02, 2022 at 05:28:16PM +0200, Ard Biesheuvel wrote:
> On Sun, 2 Oct 2022 at 17:00, Antoine Damhet <antoine@damhet.fr> wrote:
> >
> > Hello,
> >
> > Since `5f56a74cc0a6d9b9f8ba89cea29cd7c4774cb2b1`[1] I can't have both
> > SecureBoot enabled and lockdown disabled (I need to do that to allow
> > undervolting on my intel laptop).
> >
> > My current bootchain is:
> >
> > systemd-boot -> kernel+initrd+cmdline as a unified kernel image and
> > signed using a personal custom key. I don't use the shim loader.
> >
> > Until now I disabled the lockdown by setting the `MokSBState` +
> > `MokSBStateRT` UEFI variables to 1. Now they need to be volatile.
> >
>=20
> OK, so this means the patch works as intended: MokSBState is owned by
> shim, and you are not booting via shim, and so honouring those
> variables was a bug.
>=20
> > Would you be open to either add a variable or a command-line argument to
> > disable the kernel lockdown while keeping SecureBoot enabled ?
>=20
> Can't you just omit the lockdown LSM from your kernel build?

It would probably work but I'm using a downstream Fedora build, I
would rather find a solution that would work in a default configure
state (eg: that distributions would be willing to use) if it's possible.

>=20
> > If so
> > what would be the right way to express it ?
> >
> > Thanks,
> >
> > [1]: https://lore.kernel.org/linux-efi/20220920153743.3598053-1-ardb@ke=
rnel.org/
> >
> > --
> > Antoine 'xdbob' Damhet

--=20
Antoine 'xdbob' Damhet

--6pd2jm4ibqg6ezju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAmM5xQ0ACgkQ3AmjLzzl
jz5Gnwf1EK67oLfaKfF8oMvZLqBvd6Y2xOOjwcSzJGICtjj2JWH0wr3Im1PBkzm0
W4LOpSoK8+5CjhzfDNoyeNYu2C7LUCgsQC6agKJanEz2TsWzD4HoTJtD+zauNmAB
FVKtYCZaXIDbqNepXuNj80k3EnfqRqb8sEBerS86tyrB4kuN/osb82cP38v1uRiO
/D4O7UDPapAGthTzidiNzV/O1peMPq4v3J+WN9lv0D9tA3aUz9WzsWbFiVncfW04
L7ZINQFmyaiBA/4rn2wSdUUOrTSblWZ7LkTII5vD6/+Bbnv9on81M/kNADXCOfsZ
ylGg9dTJPgURcFityIfgY84Focub
=+seg
-----END PGP SIGNATURE-----

--6pd2jm4ibqg6ezju--
