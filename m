Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BD24B0486
	for <lists+linux-efi@lfdr.de>; Thu, 10 Feb 2022 05:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiBJEh5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 23:37:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiBJEh4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 23:37:56 -0500
X-Greylist: delayed 7199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 20:37:56 PST
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10691A6;
        Wed,  9 Feb 2022 20:37:56 -0800 (PST)
Received: from 168.7-181-91.adsl-dyn.isp.belgacom.be ([91.181.7.168] helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1nHw1T-0005JC-Hv; Thu, 10 Feb 2022 00:05:15 +0100
Received: from ben by deadeye with local (Exim 4.95)
        (envelope-from <ben@decadent.org.uk>)
        id 1nHw1S-001XDV-Ug;
        Thu, 10 Feb 2022 00:05:14 +0100
Message-ID: <b5a402d4931a089140ae8dc99ee149e6dd698270.camel@decadent.org.uk>
Subject: Re: [PATCH v2] builddeb: Support signing kernels with the module
 signing key
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        efi@lists.einval.com,
        debian-kernel <debian-kernel@lists.debian.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Date:   Thu, 10 Feb 2022 00:05:09 +0100
In-Reply-To: <CAK7LNATT_LMLu1hXy4kANGXN4PRiDq-Pf_kbwJztPDJnLDEF0Q@mail.gmail.com>
References: <20211218031122.4117631-1-willy@infradead.org>
         <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
         <Yf2pE4BxpaBQhaJ9@casper.infradead.org>
         <CAK7LNATT_LMLu1hXy4kANGXN4PRiDq-Pf_kbwJztPDJnLDEF0Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-aBq2oCejIqdjMCDPMBMu"
User-Agent: Evolution 3.42.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 91.181.7.168
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--=-aBq2oCejIqdjMCDPMBMu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2022-02-07 at 22:22 +0900, Masahiro Yamada wrote:
> On Sat, Feb 5, 2022 at 7:30 AM Matthew Wilcox <willy@infradead.org> wrote=
:
> >=20
> > On Wed, Jan 05, 2022 at 12:39:57AM +0900, Masahiro Yamada wrote:
> > > +CC the maintainers of CERTIFICATE HANDLING
> > > M:      David Howells <dhowells@redhat.com>
> > > M:      David Woodhouse <dwmw2@infradead.org>
> > > L:      keyrings@vger.kernel.org
> >=20
> > Davids, can one of you respond to this?
> >=20
> > > On Sat, Dec 18, 2021 at 12:11 PM Matthew Wilcox (Oracle)
> > > <willy@infradead.org> wrote:
> > > >=20
> > > > If the config file specifies a signing key, use it to sign
> > > > the kernel so that machines with SecureBoot enabled can boot.
> > > > See https://wiki.debian.org/SecureBoot
> > > >=20
> > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > ---
> > > > v2:
> > > >  - Handle private keys stored in the pem file as well as adjacent t=
o the
> > > >    certificate
> > > >  - Handle certificate paths specified relative to both dsttree and =
srctree
> > > >    (as well as absolute)
> > > >  - Only try to sign the executable if EFI_STUB is enabled
> > > >  - Only try to execute sbsign if it's in $PATH
> > > >=20
> > > >  scripts/package/builddeb | 25 ++++++++++++++++++++++++-
> > > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> > > > index 91a502bb97e8..9dd92fd02b12 100755
> > > > --- a/scripts/package/builddeb
> > > > +++ b/scripts/package/builddeb
> > > > @@ -147,7 +147,30 @@ else
> > > >         cp System.map "$tmpdir/boot/System.map-$version"
> > > >         cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
> > > >  fi
> > > > -cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$install=
ed_image_path"
> > > > +
> > > > +vmlinux=3D$($MAKE -s -f $srctree/Makefile image_name)
> > > > +key=3D
> > > > +if is_enabled CONFIG_EFI_STUB && is_enabled CONFIG_MODULE_SIG; the=
n
> > > > +       cert=3D$(grep ^CONFIG_MODULE_SIG_KEY=3D include/config/auto=
.conf | cut -d\" -f2)
> > > > +       if [ ! -f $cert ]; then
> > > > +               cert=3D$srctree/$cert
> > > > +       fi
> > > > +
> > > > +       key=3D${cert%pem}priv
> > > > +       if [ ! -f $key ]; then
> > > > +               key=3D$cert
> > > > +       fi
> > >=20
> > >=20
> > > I still do not understand this part.
> > >=20
> > > It is true that the Debian document you referred to creates separate =
files
> > > for the key and the certificate:
> > >   # openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform
> > > DER -out MOK.der -days 36500 -subj "/CN=3DMy Name/" -nodes
> > >=20
> > > but, is such a use-case possible in Kbuild?
> >=20
> > I don't think it matters whether *Kbuild* can generate one file or
> > two.  If somebody follows the *Debian* document, they will have
> > two files.  It would surely be desirable that if somebody has followed
> > the Debian instructions that we would then sign the kernel using the
> > keys they previously generated.
>=20
>=20
> If I am not wrong, extracting the key path from
> CONFIG_MODULE_SIG_KEY is not Debian's way.
>=20
>=20
> I checked the kernel configuration on bullseye,
> CONFIG_MODULE_SIG_KEY is empty,
> while the module signing itself is enabled.
[...]

For Debian's own packages,=C2=A0we didn't want to use ephemeral module
signing keys (which break reproducibility) or to expose signing keys to
the regular build machines.  Instead, Debian has a separate signing
service that handles the few packages that need it.

The closest thing to "the Debian way" for signing custom kernels would
be that wiki page.  But personally, I think making each computer build
and sign its own kernel and modules undermines any value that Secure
Boot could provide.

Ben.

--=20
Ben Hutchings
Who are all these weirdos? - David Bowie, on joining IRC

--=-aBq2oCejIqdjMCDPMBMu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmIESKYACgkQ57/I7JWG
EQmb6xAAkNQWAGFtqSPFwnPlFI0yN9VItk1/F+f3uTCM/OSPBbcDaYHeG49CDATX
ivBhSfSosSSNOez4xWelKCnlsNgw8G6nQ+dbalYveO4maeKnq9R3q2loABaQVu6X
zj0l5CErlRIYHiSjLBm4GM40CnD9BWtK1v2afYNCEzJr+Pv7OQHsX9sL+HVUJPkO
RiNr3KiCotqYDWs6kPmFDwl7BX5QlYCBKzKCUcQLxwzWsri4oI+9fWOTn9pDxFBg
J3PqzOcqbS0RuSo+8IqTRSrb4jE1iiEtoTOF8c6536O1Sw+uplhRpbx1x+j+5hmN
dywjZ6Vv8q5VtIK3gQaPqmF2VzQw2vB/YYmqJW9VGfvyFdFOWHh8WJ96eXor3db+
VYXRuJD0AjgSgWhApo4NuOYq9Iw9eGD/1BKvgGmgKYSidtMY15PSl440QyHvR7Hj
CL3y3p9EePAdvRi2SpK59x9yCEA+/z9vVpsM0Q+3/wreJK5Z72Y60rozxpPnMmK7
9sVcxX90AUZCzeM5oBnZSMvMKqrMatgXlR7N9RQQQQFilcd5AhqrR5RHPNRFVBgM
YEtI3FkFbN8AvD/O+3AD+IwbDEIeRDBOA2xumFYE+4OmXAEbzQxFg0cLuofiC6hg
WO/TCcl2oYO22JXQyqAUBQPtx9wwY7hUWUIIH2+mfTykM68GTK0=
=PubA
-----END PGP SIGNATURE-----

--=-aBq2oCejIqdjMCDPMBMu--
