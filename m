Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1534E4ABFBF
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 14:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbiBGNiT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 08:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387139AbiBGNbB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 08:31:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC614C043181;
        Mon,  7 Feb 2022 05:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y4BPg2UKSHvSGU0CdwH8Mpx1zWYK6Fo9bjYIFzss50c=; b=gO+MTd+cuCgmd2NhvLdFsRvNn0
        akbAblQsskUvJ9vHv7dbfFYvvZxvaA7RsXU9uplrUQ/gx9JRWDyXTdesuAXL1d3887b0QH07Z1rr9
        TN1Wdhp4iwncQs2yrHloAGxOfkt7Lc9Xk1Cpj7Sm1RL7QKNbKFX1qDSkFstqs+Uns7l6RoDX9LeiL
        rw1sgmr6KyIYA3o7LWgRxqwV2B3Nmf24qgIULTi+GyC9fg+yEfmiozkituUB8Zpwf7Wwm+KLNsW84
        CWLyggEyqT/jVS3/KkdKnZKoEVnT3ZVKVxVFFPYMSOpKp91/LzjjLUmmfGXjWgjAy6MWH9M4KTWQJ
        kP7emuyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nH46X-000vOy-3D; Mon, 07 Feb 2022 13:30:53 +0000
Date:   Mon, 7 Feb 2022 13:30:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        efi@lists.einval.com,
        debian-kernel <debian-kernel@lists.debian.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Subject: Re: [PATCH v2] builddeb: Support signing kernels with the module
 signing key
Message-ID: <YgEfDUh6R5A507QD@casper.infradead.org>
References: <20211218031122.4117631-1-willy@infradead.org>
 <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
 <YdSOV7LL0vWCMcWl@casper.infradead.org>
 <CAK7LNAQgixJSnDUMfjc+tg90oMdVoh+i5faEn-rqgmHR3Bk6dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQgixJSnDUMfjc+tg90oMdVoh+i5faEn-rqgmHR3Bk6dQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 07, 2022 at 09:33:46PM +0900, Masahiro Yamada wrote:
> Added "Ben Hutchings <ben@decadent.org.uk>"
> 
> On Wed, Jan 5, 2022 at 3:13 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Jan 05, 2022 at 12:39:57AM +0900, Masahiro Yamada wrote:
> > > > +vmlinux=$($MAKE -s -f $srctree/Makefile image_name)
> > > > +key=
> > > > +if is_enabled CONFIG_EFI_STUB && is_enabled CONFIG_MODULE_SIG; then
> > > > +       cert=$(grep ^CONFIG_MODULE_SIG_KEY= include/config/auto.conf | cut -d\" -f2)
> > > > +       if [ ! -f $cert ]; then
> > > > +               cert=$srctree/$cert
> > > > +       fi
> > > > +
> > > > +       key=${cert%pem}priv
> > > > +       if [ ! -f $key ]; then
> > > > +               key=$cert
> > > > +       fi
> > >
> > >
> > > I still do not understand this part.
> > >
> > > It is true that the Debian document you referred to creates separate files
> > > for the key and the certificate:
> > >   # openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform
> > > DER -out MOK.der -days 36500 -subj "/CN=My Name/" -nodes
> > >
> > > but, is such a use-case possible in Kbuild?
> >
> > If someone has followed the Debian instructions for creating a MOK,
> > then they will have two separate files.  We should support both the case
> > where someone has created a Debian MOK and the case where someone has
> > used Kbuild to create this foolish blob with both private and public
> > key in one file.
> 
> But, this patch is doing different things than the Debian document.
> 
> 
> The Debian document you referred to says:
>   "Ubuntu puts its MOK key under /var/lib/shim-signed/mok/ and some
>    software such as Oracle's virtualbox package expect the key there
>    so we follow suit (see 989463 for reference) and put it at the same place"

Uhh ... it does now.  It didn't when I originally wrote this patch.
Apparently it was updated in November:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=989463

> In Debian, MOK is generated under /var/lib/shim-signed/mok/,
> and its primary use is for signing the kernel.
> Then, you can reuse it for signing modules as well.
> 
> 
> This patch adopts the opposite direction:
>   Kbuild generates the module signing key, then
>   this patch reuses it for singing the kernel.

The patch only does this because you asked it to be changed to do this!
Look back at the version I originally sent out.  It didn't generate
the module signing key at all.  I had no idea the kernel build was even
capable of doing such a thing until you pointed it out.

I followed the instructions in the Debian document *that existed at
the time* (and now apparently we can't see because Debian uses an
inept type of wiki that can't show old versions).  I generated a key
and did not store it in the build tree.  I enrolled that key.
And then I thought "It would be nice if I didn't have to do all this
manual work after installing a new kernel so that my machine would
boot".

And here we are, months later, and you're complaining about ...
something?

> The key is located in the kernel build tree
> (that is, the key is lost when you run "make mrproper").
> 
> You need to "mokutil --import path/to/module/sining/key"
> every time Kbuild generates a new key.
> 
> 
> 
> So, another possible approach is:
> 
> builddeb signs the kernel with the key
> in /var/lib/shim-signed/mok/.
> 
> I think this is more aligned with the debian documenation.
> 
> I added Ben Hutchings, who might give us insights.
> 
> 
> 
> 
> 
> 
> 
> > > In the old days, yes, the key and the certificate were stored in separate files.
> > > (the key in *.priv and the certificate in *.x509)
> > >
> > >
> > > Please read this commit:
> >
> > Yes, I did.
> >
> > > The motivation for this change is still questionable to me;
> > > the commit description sounds like they merged *.priv and *.x509
> > > into *.pem just because they could not write a correct Makefile.
> > > (If requested, I can write a correct Makefile that works in parallel build)
> >
> > I think that would be preferable.  Putting the private and public keys
> > in the same file cannot be good security practice!
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
