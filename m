Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746AC479027
	for <lists+linux-efi@lfdr.de>; Fri, 17 Dec 2021 16:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhLQPnY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Dec 2021 10:43:24 -0500
Received: from condef-08.nifty.com ([202.248.20.73]:39132 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhLQPnY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Dec 2021 10:43:24 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Dec 2021 10:43:24 EST
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-08.nifty.com with ESMTP id 1BHFUmWc026853
        for <linux-efi@vger.kernel.org>; Sat, 18 Dec 2021 00:30:48 +0900
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 1BHFUBk8029936;
        Sat, 18 Dec 2021 00:30:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1BHFUBk8029936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639755012;
        bh=hfJ9d6RpLXYl1jyObvt01PJ7w1ZoBGGznIL6GNi0520=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=euSZ4KV+8fpKo6vTTCHfPF4zDTqAoaHBV6PVBnhN5vCJK54eZXgvL7cCv8gCnW5CW
         /yJSjy5vVGih2Q7BtAoowDVl+FnXV0l0KsIHyoJ6QpUSkOKnTSpLU4J7aad7Bl+q8O
         b4C3mnGnA06F7PaMNPFW5j68/4i2xWrlqjW9k9iRqbKvzpA+Ck9TUgcMoSeMKKwjES
         Jn2rI+5AWiKofAYaThytWBALM67aAE3uppi9bn/yMyNDeHj9okbPUcVo1kx5k178E4
         eKv+lwNYcFGEz5qXorH4H5auY/U3A7fFn+v7wOroWASBRMvXLNvQ8khLqSd2qcraro
         oaOIIJtY29Htg==
X-Nifty-SrcIP: [209.85.216.44]
Received: by mail-pj1-f44.google.com with SMTP id n15-20020a17090a394f00b001b0f6d6468eso6051009pjf.3;
        Fri, 17 Dec 2021 07:30:11 -0800 (PST)
X-Gm-Message-State: AOAM5311hZ3J+PbuIZq1QIhJrB9sEsV17yUhMerCBTbCMSQW9AOn9oZa
        yUpg50DeZfELNr4fWHRfzi/sxcmsp/nUByIeR1M=
X-Google-Smtp-Source: ABdhPJwBR2raGXd1CdAgEc+Td0HN46gw2ZosAuDc2E7I7jyQyIJ9tF49dA8Cx/t4TbGG/77DdyYytMwdtJEDnr+GNoQ=
X-Received: by 2002:a17:902:bb0f:b0:148:b895:4995 with SMTP id
 im15-20020a170902bb0f00b00148b8954995mr3841419plb.99.1639755010875; Fri, 17
 Dec 2021 07:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20211013200536.1851070-1-willy@infradead.org> <CAMj1kXEJ+RThJ83H2VNAmOKkVdhTAUCUF61u9JTv6ccc9uVTDw@mail.gmail.com>
 <CAK7LNASfr4pxmXWO8WLPM4j1NiJ6+dAO_QyUmRREzJUXJNozFw@mail.gmail.com> <Ybu30C6Nc7Mbo8MQ@casper.infradead.org>
In-Reply-To: <Ybu30C6Nc7Mbo8MQ@casper.infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 18 Dec 2021 00:29:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNARugXVnFq+yZ_+s2S_m95WfOke-LObxUTuxgvm6a4j0CA@mail.gmail.com>
Message-ID: <CAK7LNARugXVnFq+yZ_+s2S_m95WfOke-LObxUTuxgvm6a4j0CA@mail.gmail.com>
Subject: Re: [PATCH] builddeb: Support signing kernels with a Machine Owner Key
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        efi@lists.einval.com,
        debian-kernel <debian-kernel@lists.debian.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 17, 2021 at 7:04 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Nov 04, 2021 at 06:28:40PM +0900, Masahiro Yamada wrote:
> > On Thu, Oct 14, 2021 at 6:47 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 13 Oct 2021 at 22:07, Matthew Wilcox (Oracle)
> > > <willy@infradead.org> wrote:
> > > >
> > > > If the config file specifies a signing key, use it to sign
> > > > the kernel so that machines with SecureBoot enabled can boot.
> > > > See https://wiki.debian.org/SecureBoot
> > > >
> > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > >
> > > For the change itself
> > >
> > > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > although I'd suggest to fix the subject not to refer to Machine Owner
> > > Keys, as I don't see anything shim related here (i.e., if you sign
> > > using a key that is listed in db, it should also work)
> > >
> > >
> > > > ---
> > > >  scripts/package/builddeb | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> > > > index 91a502bb97e8..4fa6ff2b5cac 100755
> > > > --- a/scripts/package/builddeb
> > > > +++ b/scripts/package/builddeb
> > > > @@ -147,7 +147,15 @@ else
> > > >         cp System.map "$tmpdir/boot/System.map-$version"
> > > >         cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
> > > >  fi
> > > > -cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
> > > > +
> > > > +vmlinux=$($MAKE -s -f $srctree/Makefile image_name)
> > > > +if is_enabled CONFIG_MODULE_SIG; then
> > > > +       cert=$srctree/$(grep ^CONFIG_MODULE_SIG_KEY= include/config/auto.conf | cut -d\" -f2)
> > > > +       key=${cert%pem}priv
> > > > +       sbsign --key $key --cert $cert "$vmlinux" --output "$tmpdir/$installed_image_path"
> > > > +else
> > > > +       cp "$vmlinux" "$tmpdir/$installed_image_path"
> > > > +fi
> > > >
> > > >  if is_enabled CONFIG_OF_EARLY_FLATTREE; then
> > > >         # Only some architectures with OF support have this target
> > > > --
> > > > 2.32.0
> > > >
> >
> > How to compile this patch?
> >
> > "make  bindeb-pkg" fails with
> > Can't load key from file './certs/signing_key.priv'
>
> I'm sorry; I missed this email.
>
> I don't know why you're seeing this error, exactly.  I'm just trying to
> automate the step here:

[1] Apply your patch
[2] Enable CONFIG_MODULE_SIG
[3] make bindeb-pkg

That's all.


> https://wiki.debian.org/SecureBoot#Using_your_key_to_sign_your_kernel
>
> Have you followed the other steps on that page; ie do you have:
> signing_key.priv, signing_key.der and signing_key.pem files?



certs/signing_key.pem is automatically generated by Kbuild.

There is no such file as signing_key.priv


You can see the content of certs/signing_key.pem
This file contains both certificate and private key.






>
> >
> > Also, sbsign emits "Invalid DOS header magic" error
> > if CONFIG_EFI_STUB is not set.
> >
> > The CONFIG name might depend on arch.
> > CONFIG_EFI for ARCH=arm64, but CONFIG_EFI_STUB for ARCH=x86.
> >
> >
> > If you require sbsign, you need to update Build-Depends ?
>
> It looks like we should add a few extra checks before running sbsign ...
>
> > sh ./scripts/package/builddeb
> > Can't load key from file './certs/signing_key.priv'
> > 139999825022720:error:02001002:system library:fopen:No such file or
> > directory:../crypto/bio/bss_file.c:69:fopen('./certs/signing_key.priv','r')
> > 139999825022720:error:2006D080:BIO routines:BIO_new_file:no such
> > file:../crypto/bio/bss_file.c:76:
> > make[4]: *** [scripts/Makefile.package:87: intdeb-pkg] Error 1
> > make[3]: *** [Makefile:1539: intdeb-pkg] Error 2
> > make[2]: *** [debian/rules:13: binary-arch] Error 2
> > dpkg-buildpackage: error: debian/rules binary subprocess returned exit status 2
> > make[1]: *** [scripts/Makefile.package:83: bindeb-pkg] Error 2
> > make: *** [Makefile:1539: bindeb-pkg] Error 2
>
>


-- 
Best Regards
Masahiro Yamada
