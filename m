Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98483445143
	for <lists+linux-efi@lfdr.de>; Thu,  4 Nov 2021 10:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhKDJlL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Nov 2021 05:41:11 -0400
Received: from condef-06.nifty.com ([202.248.20.71]:22622 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhKDJlK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Nov 2021 05:41:10 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2021 05:41:09 EDT
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-06.nifty.com with ESMTP id 1A49TWVg018756
        for <linux-efi@vger.kernel.org>; Thu, 4 Nov 2021 18:29:32 +0900
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 1A49TIYo019688;
        Thu, 4 Nov 2021 18:29:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 1A49TIYo019688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1636018159;
        bh=Engq61LYr32cH+7VXpwvsMh9AxyYNgCaB/0faC5zmWg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KgJqK4VazGDZd6EJuBQyueLJTnx2tAQJFN3nPbVmEQQdTAArOppNG+d+6FMsnBM/A
         xopZ1ujmJGMKiQzIMeXk0mOD4AO+//LYmS1/PnfD9HkWPj3EuShEG42/CNNrYC5HDR
         OQYcvbY1/W6fd5JYQkUDgFp/gCZ/JwtAf5OtDbflDD+h1hKmghIdaTuONle8evTZeJ
         8IMy2AUGOeJcE6yNcGF5apwWpA4TxooIClAvEbF/dl72hfOerUnyFrdPWharXaPpPG
         pXLhtPDL93LMBgSUB1uQ2NmwRQspes6apHX9DDC+bk9lSdVDxblGYHkFV+mLqz+koe
         Jox9CtY3/mkbA==
X-Nifty-SrcIP: [209.85.210.173]
Received: by mail-pf1-f173.google.com with SMTP id s5so5299018pfg.2;
        Thu, 04 Nov 2021 02:29:18 -0700 (PDT)
X-Gm-Message-State: AOAM5331gDHkcoJZi0QktxaeeJx4VdFUdp2sOmFnPB3iG9gGW+VVJg28
        65SXKWI2FIBXf28pv1+/e6N+lZh/1rPc+HMms8E=
X-Google-Smtp-Source: ABdhPJzQ8NRbL88tAyenh+rSpPEjwwjlCJi2BW3STa61TzcbXNES6Vyc7f5Djw49zAyKhele1GAmoEtN6OdzZPKmvGg=
X-Received: by 2002:a05:6a00:1584:b0:489:4f9c:6e3a with SMTP id
 u4-20020a056a00158400b004894f9c6e3amr14063161pfk.32.1636018158060; Thu, 04
 Nov 2021 02:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211013200536.1851070-1-willy@infradead.org> <CAMj1kXEJ+RThJ83H2VNAmOKkVdhTAUCUF61u9JTv6ccc9uVTDw@mail.gmail.com>
In-Reply-To: <CAMj1kXEJ+RThJ83H2VNAmOKkVdhTAUCUF61u9JTv6ccc9uVTDw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 4 Nov 2021 18:28:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNASfr4pxmXWO8WLPM4j1NiJ6+dAO_QyUmRREzJUXJNozFw@mail.gmail.com>
Message-ID: <CAK7LNASfr4pxmXWO8WLPM4j1NiJ6+dAO_QyUmRREzJUXJNozFw@mail.gmail.com>
Subject: Re: [PATCH] builddeb: Support signing kernels with a Machine Owner Key
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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

On Thu, Oct 14, 2021 at 6:47 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 13 Oct 2021 at 22:07, Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> >
> > If the config file specifies a signing key, use it to sign
> > the kernel so that machines with SecureBoot enabled can boot.
> > See https://wiki.debian.org/SecureBoot
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>
> For the change itself
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> although I'd suggest to fix the subject not to refer to Machine Owner
> Keys, as I don't see anything shim related here (i.e., if you sign
> using a key that is listed in db, it should also work)
>
>
> > ---
> >  scripts/package/builddeb | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> > index 91a502bb97e8..4fa6ff2b5cac 100755
> > --- a/scripts/package/builddeb
> > +++ b/scripts/package/builddeb
> > @@ -147,7 +147,15 @@ else
> >         cp System.map "$tmpdir/boot/System.map-$version"
> >         cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
> >  fi
> > -cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
> > +
> > +vmlinux=$($MAKE -s -f $srctree/Makefile image_name)
> > +if is_enabled CONFIG_MODULE_SIG; then
> > +       cert=$srctree/$(grep ^CONFIG_MODULE_SIG_KEY= include/config/auto.conf | cut -d\" -f2)
> > +       key=${cert%pem}priv
> > +       sbsign --key $key --cert $cert "$vmlinux" --output "$tmpdir/$installed_image_path"
> > +else
> > +       cp "$vmlinux" "$tmpdir/$installed_image_path"
> > +fi
> >
> >  if is_enabled CONFIG_OF_EARLY_FLATTREE; then
> >         # Only some architectures with OF support have this target
> > --
> > 2.32.0
> >

How to compile this patch?

"make  bindeb-pkg" fails with
Can't load key from file './certs/signing_key.priv'


Also, sbsign emits "Invalid DOS header magic" error
if CONFIG_EFI_STUB is not set.

The CONFIG name might depend on arch.
CONFIG_EFI for ARCH=arm64, but CONFIG_EFI_STUB for ARCH=x86.


If you require sbsign, you need to update Build-Depends ?



My build log:


masahiro@grover:~/workspace/linux-kbuild$ make  bindeb-pkg -j8
sh ./scripts/package/mkdebian
dpkg-buildpackage -r"fakeroot -u" -a$(cat debian/arch)  -b -nc -uc
dpkg-buildpackage: info: source package linux-upstream
dpkg-buildpackage: info: source version 5.15.0-rc2+-1
dpkg-buildpackage: info: source distribution hirsute
dpkg-buildpackage: info: source changed by masahiro <masahiro@grover>
dpkg-buildpackage: info: host architecture amd64
 dpkg-source --before-build .
 debian/rules binary
make KERNELRELEASE=5.15.0-rc2+ ARCH=x86 KBUILD_BUILD_VERSION=1 -f ./Makefile
  DESCEND objtool
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
Kernel: arch/x86/boot/bzImage is ready  (#1)
make KERNELRELEASE=5.15.0-rc2+ ARCH=x86 KBUILD_BUILD_VERSION=1 -f
./Makefile intdeb-pkg
sh ./scripts/package/builddeb
Can't load key from file './certs/signing_key.priv'
139999825022720:error:02001002:system library:fopen:No such file or
directory:../crypto/bio/bss_file.c:69:fopen('./certs/signing_key.priv','r')
139999825022720:error:2006D080:BIO routines:BIO_new_file:no such
file:../crypto/bio/bss_file.c:76:
make[4]: *** [scripts/Makefile.package:87: intdeb-pkg] Error 1
make[3]: *** [Makefile:1539: intdeb-pkg] Error 2
make[2]: *** [debian/rules:13: binary-arch] Error 2
dpkg-buildpackage: error: debian/rules binary subprocess returned exit status 2
make[1]: *** [scripts/Makefile.package:83: bindeb-pkg] Error 2
make: *** [Makefile:1539: bindeb-pkg] Error 2





CC'ed Ben in case he has more comments.


-- 
Best Regards
Masahiro Yamada
