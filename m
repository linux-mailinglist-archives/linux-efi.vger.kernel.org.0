Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93A036D73
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2019 09:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfFFHis (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jun 2019 03:38:48 -0400
Received: from mx1.emlix.com ([188.40.240.192]:35430 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfFFHis (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 6 Jun 2019 03:38:48 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 30E24602BA;
        Thu,  6 Jun 2019 09:38:45 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: Building arm64 EFI stub with -fpie breaks build of 4.9.x (undefined reference to `__efistub__GLOBAL_OFFSET_TABLE_')
Date:   Thu, 06 Jun 2019 09:38:41 +0200
Message-ID: <8696846.WsthzzWoxp@devpool35>
Organization: emlix GmbH
In-Reply-To: <20190605162626.GA31164@kroah.com>
References: <779905244.a0lJJiZRjM@devpool35> <20190605162626.GA31164@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6100540.dV2z5JSdMG"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--nextPart6100540.dV2z5JSdMG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Greg KH wrote:
> On Wed, Jun 05, 2019 at 05:19:40PM +0200, Rolf Eike Beer wrote:
> > I decided to dig out a toy project which uses a DragonBoard 410c. This =
has
> > been "running" with kernel 4.9, which I would keep this way for unrelat=
ed
> > reasons. The vanilla 4.9 kernel wasn't bootable back then, but it was
> > buildable, which was good enough.
> >=20
> > Upgrading the kernel to 4.9.180 caused the boot to suddenly fail:
> >=20
> > aarch64-unknown-linux-gnueabi-ld:
> > ./drivers/firmware/efi/libstub/lib.a(arm64- stub.stub.o): in function
> > `handle_kernel_image':
> > /tmp/e2/build/linux-4.9.139/drivers/firmware/efi/libstub/arm64-stub.c:6=
3:
> > undefined reference to `__efistub__GLOBAL_OFFSET_TABLE_'
> > aarch64-unknown-linux-gnueabi-ld:
> > ./drivers/firmware/efi/libstub/lib.a(arm64- stub.stub.o): relocation
> > R_AARCH64_ADR_PREL_PG_HI21 against symbol
> > `__efistub__GLOBAL_OFFSET_TABLE_' which may bind externally can not be
> > used when making a shared object; recompile with -fPIC
> > /tmp/e2/build/linux-4.9.139/drivers/firmware/efi/libstub/arm64-stub.c:6=
3:
> > (.init.text+0xc): dangerous relocation: unsupported relocation
> > /tmp/e2/build/linux-4.9.139/Makefile:1001: recipe for target 'vmlinux'
> > failed -make[1]: *** [vmlinux] Error 1
> >=20
> > This is caused by commit 27b5ebf61818749b3568354c64a8ec2d9cd5ecca from
> > linux-4.9.y (which is 91ee5b21ee026c49e4e7483de69b55b8b47042be), revert=
ing
> > this commit fixes the build.
> >=20
> > This happens with vanilla binutils 2.32 and gcc 8.3.0 as well as 9.1.0.
> > See
> > the attached .config for reference.
> >=20
> > If you have questions or patches just ping me.
>=20
> Does Linus's latest tree also fail for you (or 5.1)?

5.1.7 with the same config as before and "make olddefconfig" builds for me.

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart6100540.dV2z5JSdMG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXPjDAQAKCRCr5FH7Xu2t
/Pl6BACfD5jQd+TumD4sWaBGoQsHiYGBBixaf/rbCWtituWSjO/lhxnHM7JNGGhU
nwqqGrCEw9HpBR5bUXCTpgfF7C11ZD8nXYlDTwBIBWH7HKYFBaGrub8PXCyiZH9v
cyC8ctpHj9k/PeZ+tLq+Aie9x4uIlKJVgfTHwAygDH4CD5j5mg==
=WMEf
-----END PGP SIGNATURE-----

--nextPart6100540.dV2z5JSdMG--



