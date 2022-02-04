Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7830A4AA321
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 23:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347604AbiBDWas (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Feb 2022 17:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241600AbiBDWas (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Feb 2022 17:30:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE04D210536;
        Fri,  4 Feb 2022 14:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xTp3Q2jI2XaBeoi1nbsAVKpQRvbNFVMVH1ilN5edRx4=; b=GH9JnzK99Po0eYdjai64S8QnF0
        Lj0VRYWj/+hscHz6Qkx997MjtRw0WFm/6BkGTHzav4FU4eBbj753B7c06LNRbu5duKmkoVV0mNfQa
        88nEWj1d4eM6hVg8r/q7aoMx64xXMcd51yE1C01pn6vLPX+ba6xVgEzdY7jGaMgAMwDNU6GrboSwA
        2Fgj7vuaiF4RAAdFWTvLzao9Vw7jhP9/IU6BcztMzbUUKVMJjOg8EL5HKsi2JKQqR96GzA5ywvCmr
        f+EEx8sC5ozcE+3g0RyC/FBloDMhsn0kFKBopi1BjUQcahk4LGpKLmVAfETjS3yxYr34/U9MAqaQq
        MamaUIEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG76J-007fDo-8l; Fri, 04 Feb 2022 22:30:43 +0000
Date:   Fri, 4 Feb 2022 22:30:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        efi@lists.einval.com,
        debian-kernel <debian-kernel@lists.debian.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Subject: Re: [PATCH v2] builddeb: Support signing kernels with the module
 signing key
Message-ID: <Yf2pE4BxpaBQhaJ9@casper.infradead.org>
References: <20211218031122.4117631-1-willy@infradead.org>
 <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 05, 2022 at 12:39:57AM +0900, Masahiro Yamada wrote:
> +CC the maintainers of CERTIFICATE HANDLING
> M:      David Howells <dhowells@redhat.com>
> M:      David Woodhouse <dwmw2@infradead.org>
> L:      keyrings@vger.kernel.org

Davids, can one of you respond to this?

> On Sat, Dec 18, 2021 at 12:11 PM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> >
> > If the config file specifies a signing key, use it to sign
> > the kernel so that machines with SecureBoot enabled can boot.
> > See https://wiki.debian.org/SecureBoot
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> > v2:
> >  - Handle private keys stored in the pem file as well as adjacent to the
> >    certificate
> >  - Handle certificate paths specified relative to both dsttree and srctree
> >    (as well as absolute)
> >  - Only try to sign the executable if EFI_STUB is enabled
> >  - Only try to execute sbsign if it's in $PATH
> >
> >  scripts/package/builddeb | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> > index 91a502bb97e8..9dd92fd02b12 100755
> > --- a/scripts/package/builddeb
> > +++ b/scripts/package/builddeb
> > @@ -147,7 +147,30 @@ else
> >         cp System.map "$tmpdir/boot/System.map-$version"
> >         cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
> >  fi
> > -cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
> > +
> > +vmlinux=$($MAKE -s -f $srctree/Makefile image_name)
> > +key=
> > +if is_enabled CONFIG_EFI_STUB && is_enabled CONFIG_MODULE_SIG; then
> > +       cert=$(grep ^CONFIG_MODULE_SIG_KEY= include/config/auto.conf | cut -d\" -f2)
> > +       if [ ! -f $cert ]; then
> > +               cert=$srctree/$cert
> > +       fi
> > +
> > +       key=${cert%pem}priv
> > +       if [ ! -f $key ]; then
> > +               key=$cert
> > +       fi
> 
> 
> I still do not understand this part.
> 
> It is true that the Debian document you referred to creates separate files
> for the key and the certificate:
>   # openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform
> DER -out MOK.der -days 36500 -subj "/CN=My Name/" -nodes
> 
> but, is such a use-case possible in Kbuild?

I don't think it matters whether *Kbuild* can generate one file or
two.  If somebody follows the *Debian* document, they will have
two files.  It would surely be desirable that if somebody has followed
the Debian instructions that we would then sign the kernel using the
keys they previously generated.

> In the old days, yes, the key and the certificate were stored in separate files.
> (the key in *.priv and the certificate in *.x509)
> 
> 
> Please read this commit:
> 
> 
> commit fb1179499134bc718dc7557c7a6a95dc72f224cb
> Author: David Woodhouse <David.Woodhouse@intel.com>
> Date:   Mon Jul 20 21:16:30 2015 +0100
> 
>     modsign: Use single PEM file for autogenerated key
> 
>     The current rule for generating signing_key.priv and signing_key.x509 is
>     a classic example of a bad rule which has a tendency to break parallel
>     make. When invoked to create *either* target, it generates the other
>     target as a side-effect that make didn't predict.
> 
>     So let's switch to using a single file signing_key.pem which contains
>     both key and certificate. That matches what we do in the case of an
>     external key specified by CONFIG_MODULE_SIG_KEY anyway, so it's also
>     slightly cleaner.
> 
>     Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
>     Signed-off-by: David Howells <dhowells@redhat.com>
> 
> 
> 
> 
> Since then, both key and certificate are stored in a single *.pem file.

I did read that commit.  I think it's a terrible idea.  If the
secret key & the certificate are stored in the same file, it's
no better than a symmetric cipher.  Not even SSH does this!

> The motivation for this change is still questionable to me;
> the commit description sounds like they merged *.priv and *.x509
> into *.pem just because they could not write a correct Makefile.
> (If requested, I can write a correct Makefile that works in parallel build)
> 
> But, anyway, as long as I read the current code, we never
> have a separate *.priv file.
> 
> 
> The help message of the config option supports my view.
> 
> 
> config MODULE_SIG_KEY
>         string "File name or PKCS#11 URI of module signing key"
>         default "certs/signing_key.pem"
>         depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
>         help
>          Provide the file name of a private key/certificate in PEM format,
>          or a PKCS#11 URI according to RFC7512. The file should contain, or
>          the URI should identify, both the certificate and its corresponding
>                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>          private key.
>          ^^^^^^^^^^^
> 
> 
> 
> I CC'ed  David Howells, David Woodhouse, keyrings@vger.kernel.org
> in case I understood wrong.
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> > +       if ! command -v sbsign >/dev/null; then
> > +               key=
> > +       fi
> > +fi
> > +
> > +if [ -n "$key" ]; then
> > +       sbsign --key $key --cert $cert "$vmlinux" --output "$tmpdir/$installed_image_path"
> > +else
> > +       cp "$vmlinux" "$tmpdir/$installed_image_path"
> > +fi
> >
> >  if is_enabled CONFIG_OF_EARLY_FLATTREE; then
> >         # Only some architectures with OF support have this target
> > --
> > 2.33.0
> >
> 
> 
> --
> Best Regards
> Masahiro Yamada
