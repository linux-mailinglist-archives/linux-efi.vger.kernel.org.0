Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265C8375987
	for <lists+linux-efi@lfdr.de>; Thu,  6 May 2021 19:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbhEFRjj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 May 2021 13:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236203AbhEFRji (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 6 May 2021 13:39:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BC6161041;
        Thu,  6 May 2021 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620322720;
        bh=9vsv25xDHEn9DYyHl7+Co+qGZtMsAbT0IdpxyXONZ50=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YbHz74moPS1lLguxjFQQILAqRZPoU5NI75HsgtF/jWitVrE/vPWy5vHNm0vmGEy9Q
         qJLuZS9yXYibSL40NL6R2Wvr2gLSvjUsCe/zyIFvspr3mHY7Cn6fYZK2Wjk40dVfIg
         h1jDduXHkN2dnXWe/8RfE1Ix0rmlxfGdDFGx6mn3+D3AkbxC9U8SZTkWFlJjR3MSn+
         Un/+/O9KTcTbeZujmnOPIaCZTTaEyN/xgFXwCZN7ay48DehBgh0bmVjgGe0SXazNXC
         FOm8qHNuz9KIra/j2WrmsMCMN3I7z0hpNaD0ct5JD9Mw1lO+GdF718wyvH4bRhhcyH
         H/F/emVdChneg==
Received: by mail-ot1-f53.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so1581848oto.0;
        Thu, 06 May 2021 10:38:40 -0700 (PDT)
X-Gm-Message-State: AOAM531C28+xWYrfNPHle7PzgxA4xQePVRBjd3Xns7cq3E/Ve2kd8wSU
        cvl/zU2Un6YOOdqVMr4oCWTCpCE9C8Yx7m+lZYA=
X-Google-Smtp-Source: ABdhPJwXEpoOxvHgAaPeN/+7cJpaeEFrHDT6pda8WVJ3PISpqG0EIxNmFZFX6lnLk4RSgb7G2ho0/JxiOv/srtQm3eM=
X-Received: by 2002:a05:6830:4da:: with SMTP id s26mr4624679otd.77.1620322719606;
 Thu, 06 May 2021 10:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210506115813.397657-1-willy@infradead.org> <CAMj1kXFPofJoXVhNribrNhf7ReUvcj_hpox020gboncpj5EPpA@mail.gmail.com>
 <20210506133623.GB388843@casper.infradead.org>
In-Reply-To: <20210506133623.GB388843@casper.infradead.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 6 May 2021 19:38:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFMwt+VGbvMeS+Ew1uGDMbJpGi6ALRj1NW2yZcM2CuwEw@mail.gmail.com>
Message-ID: <CAMj1kXFMwt+VGbvMeS+Ew1uGDMbJpGi6ALRj1NW2yZcM2CuwEw@mail.gmail.com>
Subject: Re: [PATCH] builddeb: Support signing kernels with a Machine Owner Key
To:     Matthew Wilcox <willy@infradead.org>,
        Peter Jones <pjones@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>, debian-efi@lists.debian.org,
        debian-kernel@lists.debian.org, efi@lists.einval.com,
        mjg59@srcf.ucam.org, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(+ Peter)

On Thu, 6 May 2021 at 15:37, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, May 06, 2021 at 02:01:53PM +0200, Ard Biesheuvel wrote:
> > On Thu, 6 May 2021 at 14:00, Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > >
> > > If the config file specifies a signing key, use it to sign
> > > the kernel so that machines with SecureBoot enabled can boot.
> > > See https://wiki.debian.org/SecureBoot
> > >
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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
> >
> > Shouldn't this be conditional on CONFIG_EFI as well?
>
> Maybe!  We're a long way outside my area of expertise.  I'm just chuffed
> I thought of using cut -d\" -f2.
>
> There should probably also be something conditional on sbsign actually
> being in $PATH, I guess?
>
> And I wasn't sure about putting all of this in builddeb -- does make
> rpm-pkg already have its own way of doing the same thing, or should this
> be somewhere more generic?
>

No, sbsign is Debian/Ubuntu specific. Fedora/Redhat uses something
else IIRC. But yes, it obviously helps if the tool exists.


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
> > > 2.30.2
> > >
