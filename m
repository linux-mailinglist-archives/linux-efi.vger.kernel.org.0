Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A793754DA
	for <lists+linux-efi@lfdr.de>; Thu,  6 May 2021 15:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhEFNib (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 May 2021 09:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbhEFNiW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 May 2021 09:38:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257EBC061761;
        Thu,  6 May 2021 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NeEyq+p8Nc+GBmAF6vn7qCJuLlX2xlC2AIuuNvNNw7U=; b=kptLlUAG+ouolnYzpiqg4I+OOY
        usaRYODDtbGJJTUBzflt2+9yTkl7Fbqqz/Hwe/g8MEyMQkJgHUB0A+iRlxy+mo0Vt10ufPkqMLF20
        DAj1UzKEn9xFVK4k0zWiSLx5Ak3KYpjkdGXRVtvqkHmpAXoIP4f0jlQxNEsDS2YcfU7FWWqsU1N89
        tgHDDABLSJQhqBol1AHQQqNcCvZQRO8526LTzthP5pg9OnhaDqcuON+Y7HIglz7jUx0jiH9MDYhiv
        0CHVipcFUqHFpn9cHWf1C95bEV9PDzooDkdR2rElveHjnWGiLiH7hJe7fddirjwiwgooccfmYNfld
        ANhZVFrA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leeAx-001lX9-8j; Thu, 06 May 2021 13:36:47 +0000
Date:   Thu, 6 May 2021 14:36:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, debian-efi@lists.debian.org,
        debian-kernel@lists.debian.org, efi@lists.einval.com,
        mjg59@srcf.ucam.org, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH] builddeb: Support signing kernels with a Machine Owner
 Key
Message-ID: <20210506133623.GB388843@casper.infradead.org>
References: <20210506115813.397657-1-willy@infradead.org>
 <CAMj1kXFPofJoXVhNribrNhf7ReUvcj_hpox020gboncpj5EPpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFPofJoXVhNribrNhf7ReUvcj_hpox020gboncpj5EPpA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 06, 2021 at 02:01:53PM +0200, Ard Biesheuvel wrote:
> On Thu, 6 May 2021 at 14:00, Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> >
> > If the config file specifies a signing key, use it to sign
> > the kernel so that machines with SecureBoot enabled can boot.
> > See https://wiki.debian.org/SecureBoot
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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
> 
> Shouldn't this be conditional on CONFIG_EFI as well?

Maybe!  We're a long way outside my area of expertise.  I'm just chuffed
I thought of using cut -d\" -f2.

There should probably also be something conditional on sbsign actually
being in $PATH, I guess?

And I wasn't sure about putting all of this in builddeb -- does make
rpm-pkg already have its own way of doing the same thing, or should this
be somewhere more generic?

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
> > 2.30.2
> >
