Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8BA4ABFC2
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 14:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiBGNiT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 08:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447089AbiBGMxW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 07:53:22 -0500
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 04:53:21 PST
Received: from condef-08.nifty.com (condef-08.nifty.com [202.248.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B8EC0401C1;
        Mon,  7 Feb 2022 04:53:20 -0800 (PST)
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-08.nifty.com with ESMTP id 217CYfOO006569;
        Mon, 7 Feb 2022 21:34:41 +0900
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 217CYN2K029695;
        Mon, 7 Feb 2022 21:34:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 217CYN2K029695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644237263;
        bh=9zKrPVPrkksURJV3q1ADM90/dTQqSdo5AISbXfRbAK8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ncgNidLu5reIUSqWMWHKjwcp1pH8YB2Nl81GvQ0hpGnx78rZFCVFxFRPAqaszZw/2
         dtUs614cqV/1Xz451imobbGRu/hvXbtxlF3ZfTD3WRWDZpfMQkIlu5PqWgblXK56Ei
         HH7kYXenqhXRVZNEd6CPHTBzOTY0+UwNTbP8TdJdskvIRA2xhID06vWqZzduuXywao
         CW61Xtx3JOtQBi8WkQnv+ieoidDZsTOnqLESj4LdpNqzofVS/2qxNYdm3qW8HSLkbQ
         dLd4b0T2tLs3UY9acXOCyeXvHKMxC5b2KI4/CTBQhVBPZhdOH6jdb0gj7+ZjDGRetb
         YTgr+HMQZfHtg==
X-Nifty-SrcIP: [209.85.214.174]
Received: by mail-pl1-f174.google.com with SMTP id z17so1009414plb.9;
        Mon, 07 Feb 2022 04:34:23 -0800 (PST)
X-Gm-Message-State: AOAM531P+CO1a3ScQZp+4a4qpUGL/PwsPN0ubKSR2KMZpO903RW/kuMk
        Fglse2NSftWLHUwLVHo0dKwn74gj7L9VHIR1dPs=
X-Google-Smtp-Source: ABdhPJw3cX3TxmQPv1QYgm1VN+3TehX/6SKbg9GVGNoFJP8Soe+of9JeFW0Lh7zcdp1x15eRDqMYFJrt4S2w8Y3RoUM=
X-Received: by 2002:a17:90b:4a4b:: with SMTP id lb11mr13886889pjb.144.1644237262520;
 Mon, 07 Feb 2022 04:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20211218031122.4117631-1-willy@infradead.org> <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
 <YdSOV7LL0vWCMcWl@casper.infradead.org>
In-Reply-To: <YdSOV7LL0vWCMcWl@casper.infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 7 Feb 2022 21:33:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQgixJSnDUMfjc+tg90oMdVoh+i5faEn-rqgmHR3Bk6dQ@mail.gmail.com>
Message-ID: <CAK7LNAQgixJSnDUMfjc+tg90oMdVoh+i5faEn-rqgmHR3Bk6dQ@mail.gmail.com>
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

Added "Ben Hutchings <ben@decadent.org.uk>"

On Wed, Jan 5, 2022 at 3:13 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jan 05, 2022 at 12:39:57AM +0900, Masahiro Yamada wrote:
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
> If someone has followed the Debian instructions for creating a MOK,
> then they will have two separate files.  We should support both the case
> where someone has created a Debian MOK and the case where someone has
> used Kbuild to create this foolish blob with both private and public
> key in one file.

But, this patch is doing different things than the Debian document.


The Debian document you referred to says:
  "Ubuntu puts its MOK key under /var/lib/shim-signed/mok/ and some
   software such as Oracle's virtualbox package expect the key there
   so we follow suit (see 989463 for reference) and put it at the same place"



In Debian, MOK is generated under /var/lib/shim-signed/mok/,
and its primary use is for signing the kernel.
Then, you can reuse it for signing modules as well.


This patch adopts the opposite direction:
  Kbuild generates the module signing key, then
  this patch reuses it for singing the kernel.

The key is located in the kernel build tree
(that is, the key is lost when you run "make mrproper").

You need to "mokutil --import path/to/module/sining/key"
every time Kbuild generates a new key.



So, another possible approach is:

builddeb signs the kernel with the key
in /var/lib/shim-signed/mok/.

I think this is more aligned with the debian documenation.

I added Ben Hutchings, who might give us insights.







> > In the old days, yes, the key and the certificate were stored in separate files.
> > (the key in *.priv and the certificate in *.x509)
> >
> >
> > Please read this commit:
>
> Yes, I did.
>
> > The motivation for this change is still questionable to me;
> > the commit description sounds like they merged *.priv and *.x509
> > into *.pem just because they could not write a correct Makefile.
> > (If requested, I can write a correct Makefile that works in parallel build)
>
> I think that would be preferable.  Putting the private and public keys
> in the same file cannot be good security practice!



-- 
Best Regards
Masahiro Yamada
