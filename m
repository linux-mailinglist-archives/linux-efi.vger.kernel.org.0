Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D02F4AD028
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 05:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346555AbiBHEKx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 23:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346551AbiBHEKh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 23:10:37 -0500
X-Greylist: delayed 53239 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 20:10:36 PST
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C8AC0401E5;
        Mon,  7 Feb 2022 20:10:35 -0800 (PST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2184A8dd013689;
        Tue, 8 Feb 2022 13:10:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2184A8dd013689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644293409;
        bh=E+V6j8SShKCKnUvb94ZDN8qqmAiMleuldICMqxNk3tY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yEXvwqXeVmpASEyhudK44MRKzeOH+qZkBs9I2Hai4TOGI5/uxB+IZuaf6y6WWKECA
         OOyhrt5tST/fJxM7fRdQeEmD0LZMc5atKdrBoe0R4c+fyrUQUeDziwEYRf1EIDvJz+
         OXxQnsILdgG5wP/8b3fo3QjbSw/7vkOda1jEiIzA0+/AwBHhshUKPdEHM3UhoYSNcY
         kLpRTWL04eHMRo6urhGFfsErdhP2+64lnedKNJs6tMQ8dLkPKhVE5BLgqYAxFgkUvh
         //QKz3NYfNgMQ74x6AndJR9FGcVAHVcwH16y7p3q1zguy+RcKn3PN46+mybFYCM8+9
         9tYV8eo31zo7Q==
X-Nifty-SrcIP: [209.85.214.180]
Received: by mail-pl1-f180.google.com with SMTP id z17so2818966plb.9;
        Mon, 07 Feb 2022 20:10:09 -0800 (PST)
X-Gm-Message-State: AOAM533A1o1I9MofQFIhxysXL4nrOyy57VZznbJGsu/gI17QqoiLMzCo
        MRPBu0inWQhMpA29kiE9Wc1Cf7q3Sd+xqt0wJfo=
X-Google-Smtp-Source: ABdhPJzzu81qls4q4z/BR+NdJ7uNu//QPmhrf32fuCb34ypu6aMT0BaPGfHIdqGKtyC8QBu9zv76jzo0rzV8BvoGrfY=
X-Received: by 2002:a17:903:22cd:: with SMTP id y13mr2746325plg.99.1644293408381;
 Mon, 07 Feb 2022 20:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20211218031122.4117631-1-willy@infradead.org> <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
 <YdSOV7LL0vWCMcWl@casper.infradead.org> <CAK7LNAQgixJSnDUMfjc+tg90oMdVoh+i5faEn-rqgmHR3Bk6dQ@mail.gmail.com>
 <YgEfDUh6R5A507QD@casper.infradead.org>
In-Reply-To: <YgEfDUh6R5A507QD@casper.infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 8 Feb 2022 13:09:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNASqvQYEf0tSS=hSkKtiZv50t0qFUbmkSdv0-QJ2iPYTfw@mail.gmail.com>
Message-ID: <CAK7LNASqvQYEf0tSS=hSkKtiZv50t0qFUbmkSdv0-QJ2iPYTfw@mail.gmail.com>
Subject: Re: [PATCH v2] builddeb: Support signing kernels with the module
 signing key
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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

On Mon, Feb 7, 2022 at 10:31 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Feb 07, 2022 at 09:33:46PM +0900, Masahiro Yamada wrote:
> > Added "Ben Hutchings <ben@decadent.org.uk>"
> >
> > On Wed, Jan 5, 2022 at 3:13 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Jan 05, 2022 at 12:39:57AM +0900, Masahiro Yamada wrote:
> > > > > +vmlinux=$($MAKE -s -f $srctree/Makefile image_name)
> > > > > +key=
> > > > > +if is_enabled CONFIG_EFI_STUB && is_enabled CONFIG_MODULE_SIG; then
> > > > > +       cert=$(grep ^CONFIG_MODULE_SIG_KEY= include/config/auto.conf | cut -d\" -f2)
> > > > > +       if [ ! -f $cert ]; then
> > > > > +               cert=$srctree/$cert
> > > > > +       fi
> > > > > +
> > > > > +       key=${cert%pem}priv
> > > > > +       if [ ! -f $key ]; then
> > > > > +               key=$cert
> > > > > +       fi
> > > >
> > > >
> > > > I still do not understand this part.
> > > >
> > > > It is true that the Debian document you referred to creates separate files
> > > > for the key and the certificate:
> > > >   # openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform
> > > > DER -out MOK.der -days 36500 -subj "/CN=My Name/" -nodes
> > > >
> > > > but, is such a use-case possible in Kbuild?
> > >
> > > If someone has followed the Debian instructions for creating a MOK,
> > > then they will have two separate files.  We should support both the case
> > > where someone has created a Debian MOK and the case where someone has
> > > used Kbuild to create this foolish blob with both private and public
> > > key in one file.
> >
> > But, this patch is doing different things than the Debian document.
> >
> >
> > The Debian document you referred to says:
> >   "Ubuntu puts its MOK key under /var/lib/shim-signed/mok/ and some
> >    software such as Oracle's virtualbox package expect the key there
> >    so we follow suit (see 989463 for reference) and put it at the same place"
>
> Uhh ... it does now.  It didn't when I originally wrote this patch.
> Apparently it was updated in November:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=989463


I checked the diff.

Back in November, the key/cert were generated in /root directory.

In the latest instruction, the recommended location is
/var/lib/shim-signed/mok/.






> > In Debian, MOK is generated under /var/lib/shim-signed/mok/,
> > and its primary use is for signing the kernel.
> > Then, you can reuse it for signing modules as well.
> >
> >
> > This patch adopts the opposite direction:
> >   Kbuild generates the module signing key, then
> >   this patch reuses it for singing the kernel.
>
> The patch only does this because you asked it to be changed to do this!
> Look back at the version I originally sent out.  It didn't generate
> the module signing key at all.  I had no idea the kernel build was even
> capable of doing such a thing until you pointed it out.

Sorry, I do not understand what you are talking about.

I assume you are talking about v1 patch.
https://patchwork.kernel.org/project/linux-kbuild/patch/20211013200536.1851070-1-willy@infradead.org/

Honestly, I did not have expert knowledge in the secure boot,
but anyway I observed build errors, and I pointed it out.

Other than the build error, your original patch was written in the way
to use CONFIG_MODULE_SIG_KEY  for signing the kernel.
This is the same between v1 and v2.

Looking at the instruction in the Debian page,
now I am wondering if this is the right thing to do
because signing the kernel and signing the modules
are different things.

The old debian page (I checked the old page back in November)
did not mention CONFIG_MODULE_SIG_KEY either.


> I followed the instructions in the Debian document *that existed at
> the time* (and now apparently we can't see because Debian uses an
> inept type of wiki that can't show old versions).  I generated a key
> and did not store it in the build tree.  I enrolled that key.
> And then I thought "It would be nice if I didn't have to do all this
> manual work after installing a new kernel so that my machine would
> boot".

I agree on this point.
It will be nice to avoid manual work in the kernel signing steps.



>
> And here we are, months later, and you're complaining about ...
> something?

Sorry for the delay and annoyance.

After reading the latest Debian doc closely, I think we can automate
the kernel signing by using the key located in /var/lib/shim-signed/mok/
instead of CONFIG_MODULE_SIG_KEY.


If I am wrong, I hope some input from people in the CC list.









>
> > The key is located in the kernel build tree
> > (that is, the key is lost when you run "make mrproper").
> >
> > You need to "mokutil --import path/to/module/sining/key"
> > every time Kbuild generates a new key.
> >
> >
> >
> > So, another possible approach is:
> >
> > builddeb signs the kernel with the key
> > in /var/lib/shim-signed/mok/.
> >
> > I think this is more aligned with the debian documenation.
> >
> > I added Ben Hutchings, who might give us insights.
> >
> >
> >
> >
> >
> >
> >
> > > > In the old days, yes, the key and the certificate were stored in separate files.
> > > > (the key in *.priv and the certificate in *.x509)
> > > >
> > > >
> > > > Please read this commit:
> > >
> > > Yes, I did.
> > >
> > > > The motivation for this change is still questionable to me;
> > > > the commit description sounds like they merged *.priv and *.x509
> > > > into *.pem just because they could not write a correct Makefile.
> > > > (If requested, I can write a correct Makefile that works in parallel build)
> > >
> > > I think that would be preferable.  Putting the private and public keys
> > > in the same file cannot be good security practice!
> >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada



--
Best Regards
Masahiro Yamada
