Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5832A477FC5
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 23:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbhLPWEK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Dec 2021 17:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbhLPWEI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Dec 2021 17:04:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E96EC061574;
        Thu, 16 Dec 2021 14:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WAO9hZDcRjB3YCaMlbfdToabQWYt+lhc7ogLYgYfO5A=; b=BWGZ6AuNjpRoC8kgaS6A7mi51K
        YFPoVwlchEV30CCdSpYhu0huiVuYRRrZu0SADS2YdW3szrKx1THYtThkjR/aEZ3h78wQP+KeDkTiS
        IAMLKNAjPtvKgsFYD2nggsPLjR0pF9NF6UThOYDcwJXp9Nwtr19GplvwXs8TOWcMpGOYkWA1cU+DO
        v/CiyT1lUk4WN98ka624Fur6Sh8EWIjiEkXTPUVEffDNXJmaMpfGItLmg21h5Y6JvX3Y4sJYy0EQi
        HaE4FYPYXGaM9Xd0/85bCmNV0kzRKE9WL4LmNpCCQkDYeBGxevc6fdGDEeu4KZMiYmkjzBTBz0mCM
        BWmglKEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxyr2-00G00R-Sb; Thu, 16 Dec 2021 22:04:00 +0000
Date:   Thu, 16 Dec 2021 22:04:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        efi@lists.einval.com,
        debian-kernel <debian-kernel@lists.debian.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] builddeb: Support signing kernels with a Machine Owner
 Key
Message-ID: <Ybu30C6Nc7Mbo8MQ@casper.infradead.org>
References: <20211013200536.1851070-1-willy@infradead.org>
 <CAMj1kXEJ+RThJ83H2VNAmOKkVdhTAUCUF61u9JTv6ccc9uVTDw@mail.gmail.com>
 <CAK7LNASfr4pxmXWO8WLPM4j1NiJ6+dAO_QyUmRREzJUXJNozFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASfr4pxmXWO8WLPM4j1NiJ6+dAO_QyUmRREzJUXJNozFw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 04, 2021 at 06:28:40PM +0900, Masahiro Yamada wrote:
> On Thu, Oct 14, 2021 at 6:47 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 13 Oct 2021 at 22:07, Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > >
> > > If the config file specifies a signing key, use it to sign
> > > the kernel so that machines with SecureBoot enabled can boot.
> > > See https://wiki.debian.org/SecureBoot
> > >
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >
> > For the change itself
> >
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > although I'd suggest to fix the subject not to refer to Machine Owner
> > Keys, as I don't see anything shim related here (i.e., if you sign
> > using a key that is listed in db, it should also work)
> >
> >
> > > ---
> > >  scripts/package/builddeb | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> > > index 91a502bb97e8..4fa6ff2b5cac 100755
> > > --- a/scripts/package/builddeb
> > > +++ b/scripts/package/builddeb
> > > @@ -147,7 +147,15 @@ else
> > >         cp System.map "$tmpdir/boot/System.map-$version"
> > >         cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
> > >  fi
> > > -cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
> > > +
> > > +vmlinux=$($MAKE -s -f $srctree/Makefile image_name)
> > > +if is_enabled CONFIG_MODULE_SIG; then
> > > +       cert=$srctree/$(grep ^CONFIG_MODULE_SIG_KEY= include/config/auto.conf | cut -d\" -f2)
> > > +       key=${cert%pem}priv
> > > +       sbsign --key $key --cert $cert "$vmlinux" --output "$tmpdir/$installed_image_path"
> > > +else
> > > +       cp "$vmlinux" "$tmpdir/$installed_image_path"
> > > +fi
> > >
> > >  if is_enabled CONFIG_OF_EARLY_FLATTREE; then
> > >         # Only some architectures with OF support have this target
> > > --
> > > 2.32.0
> > >
> 
> How to compile this patch?
> 
> "make  bindeb-pkg" fails with
> Can't load key from file './certs/signing_key.priv'

I'm sorry; I missed this email.

I don't know why you're seeing this error, exactly.  I'm just trying to
automate the step here:

https://wiki.debian.org/SecureBoot#Using_your_key_to_sign_your_kernel

Have you followed the other steps on that page; ie do you have:
signing_key.priv, signing_key.der and signing_key.pem files?

> 
> Also, sbsign emits "Invalid DOS header magic" error
> if CONFIG_EFI_STUB is not set.
> 
> The CONFIG name might depend on arch.
> CONFIG_EFI for ARCH=arm64, but CONFIG_EFI_STUB for ARCH=x86.
> 
> 
> If you require sbsign, you need to update Build-Depends ?

It looks like we should add a few extra checks before running sbsign ...

> sh ./scripts/package/builddeb
> Can't load key from file './certs/signing_key.priv'
> 139999825022720:error:02001002:system library:fopen:No such file or
> directory:../crypto/bio/bss_file.c:69:fopen('./certs/signing_key.priv','r')
> 139999825022720:error:2006D080:BIO routines:BIO_new_file:no such
> file:../crypto/bio/bss_file.c:76:
> make[4]: *** [scripts/Makefile.package:87: intdeb-pkg] Error 1
> make[3]: *** [Makefile:1539: intdeb-pkg] Error 2
> make[2]: *** [debian/rules:13: binary-arch] Error 2
> dpkg-buildpackage: error: debian/rules binary subprocess returned exit status 2
> make[1]: *** [scripts/Makefile.package:83: bindeb-pkg] Error 2
> make: *** [Makefile:1539: bindeb-pkg] Error 2


