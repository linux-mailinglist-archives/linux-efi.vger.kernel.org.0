Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDA14ABFC1
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 14:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiBGNgO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 08:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358176AbiBGN11 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 08:27:27 -0500
Received: from condef-06.nifty.com (condef-06.nifty.com [202.248.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858EAC043181;
        Mon,  7 Feb 2022 05:27:26 -0800 (PST)
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-06.nifty.com with ESMTP id 217DNHuN002857;
        Mon, 7 Feb 2022 22:23:17 +0900
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 217DMi4G006239;
        Mon, 7 Feb 2022 22:22:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 217DMi4G006239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644240165;
        bh=20MF4Z52MkQknKMZA00D6mT1FlSU6sN+FRYl/U/PoKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0BF/UR39Nt8Q0EIvhiYmNZsikGa9huzlDvAF54FitYMDlRIwFgSGTHjwY5m/2XBwj
         SQMpuWb/zJDQLbssmVu9Gf36ixAYt/yQlQHypE6AwwfAXHtN7hnOn8leWMphzvo4gA
         /5pK/XwKv+ggx245WwxxfHTbMJHoCY9/TzlBwmmdRatzNaLgw8Q6Wz5QJUzKcF/bCa
         JHqmR1EE7XLIpHm9F/Q5NHNjYREYvA33dZ1tHJCoLd9HTh0m/G3hvEGVX3r9W6TQqg
         JLED90dV+OCfOC/H3brMnn6ur0dB8whDYJQpvbCx8G/1hhw1tT2lz9JxvB2SXVVzBO
         lvfKNF2/hHnpA==
X-Nifty-SrcIP: [209.85.214.178]
Received: by mail-pl1-f178.google.com with SMTP id z17so1108920plb.9;
        Mon, 07 Feb 2022 05:22:45 -0800 (PST)
X-Gm-Message-State: AOAM531Bukp9CkdVZ4aKbUbDPgKaHcHlQxP0tccL2twUWApgt3XeF7Or
        ilWDtHOsspwIgEaMq8qJCa7cpvJUMCs7BbYhZmk=
X-Google-Smtp-Source: ABdhPJxEyo1T3ln9JppDTxKhiz1XGX+eTI6sTwQ1OUO7dcOyUbiSj0u1tkldPSCttLGd+8DEMVNE56AKOuC31uOo9JE=
X-Received: by 2002:a17:902:e782:: with SMTP id cp2mr15851163plb.162.1644240164339;
 Mon, 07 Feb 2022 05:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20211218031122.4117631-1-willy@infradead.org> <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
 <Yf2pE4BxpaBQhaJ9@casper.infradead.org>
In-Reply-To: <Yf2pE4BxpaBQhaJ9@casper.infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 7 Feb 2022 22:22:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNATT_LMLu1hXy4kANGXN4PRiDq-Pf_kbwJztPDJnLDEF0Q@mail.gmail.com>
Message-ID: <CAK7LNATT_LMLu1hXy4kANGXN4PRiDq-Pf_kbwJztPDJnLDEF0Q@mail.gmail.com>
Subject: Re: [PATCH v2] builddeb: Support signing kernels with the module
 signing key
To:     Matthew Wilcox <willy@infradead.org>,
        Ben Hutchings <ben@decadent.org.uk>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        efi@lists.einval.com,
        debian-kernel <debian-kernel@lists.debian.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Feb 5, 2022 at 7:30 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jan 05, 2022 at 12:39:57AM +0900, Masahiro Yamada wrote:
> > +CC the maintainers of CERTIFICATE HANDLING
> > M:      David Howells <dhowells@redhat.com>
> > M:      David Woodhouse <dwmw2@infradead.org>
> > L:      keyrings@vger.kernel.org
>
> Davids, can one of you respond to this?
>
> > On Sat, Dec 18, 2021 at 12:11 PM Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > >
> > > If the config file specifies a signing key, use it to sign
> > > the kernel so that machines with SecureBoot enabled can boot.
> > > See https://wiki.debian.org/SecureBoot
> > >
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > > v2:
> > >  - Handle private keys stored in the pem file as well as adjacent to the
> > >    certificate
> > >  - Handle certificate paths specified relative to both dsttree and srctree
> > >    (as well as absolute)
> > >  - Only try to sign the executable if EFI_STUB is enabled
> > >  - Only try to execute sbsign if it's in $PATH
> > >
> > >  scripts/package/builddeb | 25 ++++++++++++++++++++++++-
> > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> > > index 91a502bb97e8..9dd92fd02b12 100755
> > > --- a/scripts/package/builddeb
> > > +++ b/scripts/package/builddeb
> > > @@ -147,7 +147,30 @@ else
> > >         cp System.map "$tmpdir/boot/System.map-$version"
> > >         cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
> > >  fi
> > > -cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
> > > +
> > > +vmlinux=$($MAKE -s -f $srctree/Makefile image_name)
> > > +key=
> > > +if is_enabled CONFIG_EFI_STUB && is_enabled CONFIG_MODULE_SIG; then
> > > +       cert=$(grep ^CONFIG_MODULE_SIG_KEY= include/config/auto.conf | cut -d\" -f2)
> > > +       if [ ! -f $cert ]; then
> > > +               cert=$srctree/$cert
> > > +       fi
> > > +
> > > +       key=${cert%pem}priv
> > > +       if [ ! -f $key ]; then
> > > +               key=$cert
> > > +       fi
> >
> >
> > I still do not understand this part.
> >
> > It is true that the Debian document you referred to creates separate files
> > for the key and the certificate:
> >   # openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform
> > DER -out MOK.der -days 36500 -subj "/CN=My Name/" -nodes
> >
> > but, is such a use-case possible in Kbuild?
>
> I don't think it matters whether *Kbuild* can generate one file or
> two.  If somebody follows the *Debian* document, they will have
> two files.  It would surely be desirable that if somebody has followed
> the Debian instructions that we would then sign the kernel using the
> keys they previously generated.


If I am not wrong, extracting the key path from
CONFIG_MODULE_SIG_KEY is not Debian's way.


I checked the kernel configuration on bullseye,
CONFIG_MODULE_SIG_KEY is empty,
while the module signing itself is enabled.


masahiro@debian:~$ cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
NAME="Debian GNU/Linux"
VERSION_ID="11"
VERSION="11 (bullseye)"
VERSION_CODENAME=bullseye
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"

masahiro@debian:~$ grep CONFIG_MODULE_SIG  /boot/config-$(uname -r)
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
# CONFIG_MODULE_SIG_ALL is not set
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_SIG_KEY=""


Presumably, the reason is that distributions cannot
be shipped with the private key.







> > In the old days, yes, the key and the certificate were stored in separate files.
> > (the key in *.priv and the certificate in *.x509)
> >
> >
> > Please read this commit:
> >
> >
> > commit fb1179499134bc718dc7557c7a6a95dc72f224cb
> > Author: David Woodhouse <David.Woodhouse@intel.com>
> > Date:   Mon Jul 20 21:16:30 2015 +0100
> >
> >     modsign: Use single PEM file for autogenerated key
> >
> >     The current rule for generating signing_key.priv and signing_key.x509 is
> >     a classic example of a bad rule which has a tendency to break parallel
> >     make. When invoked to create *either* target, it generates the other
> >     target as a side-effect that make didn't predict.
> >
> >     So let's switch to using a single file signing_key.pem which contains
> >     both key and certificate. That matches what we do in the case of an
> >     external key specified by CONFIG_MODULE_SIG_KEY anyway, so it's also
> >     slightly cleaner.
> >
> >     Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> >     Signed-off-by: David Howells <dhowells@redhat.com>
> >
> >
> >
> >
> > Since then, both key and certificate are stored in a single *.pem file.
>
> I did read that commit.  I think it's a terrible idea.  If the
> secret key & the certificate are stored in the same file, it's
> no better than a symmetric cipher.  Not even SSH does this!


I am with you on this point, but
separating the cert and priv is another story.












>
> > The motivation for this change is still questionable to me;
> > the commit description sounds like they merged *.priv and *.x509
> > into *.pem just because they could not write a correct Makefile.
> > (If requested, I can write a correct Makefile that works in parallel build)
> >
> > But, anyway, as long as I read the current code, we never
> > have a separate *.priv file.
> >
> >
> > The help message of the config option supports my view.
> >
> >
> > config MODULE_SIG_KEY
> >         string "File name or PKCS#11 URI of module signing key"
> >         default "certs/signing_key.pem"
> >         depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
> >         help
> >          Provide the file name of a private key/certificate in PEM format,
> >          or a PKCS#11 URI according to RFC7512. The file should contain, or
> >          the URI should identify, both the certificate and its corresponding
> >                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >          private key.
> >          ^^^^^^^^^^^
> >
> >
> >
> > I CC'ed  David Howells, David Woodhouse, keyrings@vger.kernel.org
> > in case I understood wrong.
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > > +       if ! command -v sbsign >/dev/null; then
> > > +               key=
> > > +       fi
> > > +fi
> > > +
> > > +if [ -n "$key" ]; then
> > > +       sbsign --key $key --cert $cert "$vmlinux" --output "$tmpdir/$installed_image_path"
> > > +else
> > > +       cp "$vmlinux" "$tmpdir/$installed_image_path"
> > > +fi
> > >
> > >  if is_enabled CONFIG_OF_EARLY_FLATTREE; then
> > >         # Only some architectures with OF support have this target
> > > --
> > > 2.33.0
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada



--
Best Regards
Masahiro Yamada
