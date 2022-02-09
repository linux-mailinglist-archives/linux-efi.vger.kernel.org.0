Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707FD4B00E6
	for <lists+linux-efi@lfdr.de>; Thu, 10 Feb 2022 00:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiBIXEl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 18:04:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbiBIXEl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 18:04:41 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA21E05025B;
        Wed,  9 Feb 2022 15:04:41 -0800 (PST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 219N4MWl018835;
        Thu, 10 Feb 2022 08:04:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 219N4MWl018835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644447863;
        bh=JD3bCnrEHImzegmVdsIy2d76lHQ7wJFzdy4OTC7bGUE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bkWDNmm8nLRvce/X5cdYH6JnlURd6Sj5nIUfjN4httonnxgMhzz0ERKwqKcSl2jrD
         s3bncT8qg6IST+h2b+v/clxs2hmaxmRecryoorHvIWj2GKgimySRf257ITuzcsFyli
         bXIXU7zriOAKGgssLtRHNg0vaSVh5VsLmF8TYlsgUgiGU/zhVuYkgNjTySONwD8+OX
         IFMmInqD6ja0pXRMnA0K71nCmedVatzURHf70NydriRV1ulJueMwZLjeQjpWgMOilP
         qjAPwp8auhrl+RdBOVXbqJZS+VOrzr/9KDJg568MRAw7q4LXuzBiRUyxUWqkLKMMjG
         jASgG9humYJsw==
X-Nifty-SrcIP: [209.85.216.42]
Received: by mail-pj1-f42.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso498084pjb.1;
        Wed, 09 Feb 2022 15:04:22 -0800 (PST)
X-Gm-Message-State: AOAM532fmbTVvnjltev0DTtiYwwTNH5CbBu9CBSQ1kGTGOzmnrNQEQ6q
        rQaIp5Evd9Kmg6UZofeadUzxCrAHYZ7N+DAGNTM=
X-Google-Smtp-Source: ABdhPJzbnjrw/KmyMBO+YMmYwVY6E8qBn64TEpTpKommTq2t2glNIGKsdYKfqkNzF4BL6+ACmH1O1eFnVNuVdFrYEz4=
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr4565975plt.136.1644447861994;
 Wed, 09 Feb 2022 15:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20211218031122.4117631-1-willy@infradead.org> <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
 <YdSOV7LL0vWCMcWl@casper.infradead.org> <CAK7LNAQgixJSnDUMfjc+tg90oMdVoh+i5faEn-rqgmHR3Bk6dQ@mail.gmail.com>
 <20220208110122.2z4cmbqexmnxuxld@jak-t480s> <YgJrypdQium7AcWV@casper.infradead.org>
 <20220208161259.inytmx6gm4w34gct@jak-t480s>
In-Reply-To: <20220208161259.inytmx6gm4w34gct@jak-t480s>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 10 Feb 2022 08:03:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQaCF_Dj_s4NYrAgxinw7EbmF9w4vqdYGM-wBehiCTB_A@mail.gmail.com>
Message-ID: <CAK7LNAQaCF_Dj_s4NYrAgxinw7EbmF9w4vqdYGM-wBehiCTB_A@mail.gmail.com>
Subject: Re: [PATCH v2] builddeb: Support signing kernels with the module
 signing key
To:     Julian Andres Klode <julian.klode@canonical.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        efi@lists.einval.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        debian-kernel <debian-kernel@lists.debian.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 9, 2022 at 1:13 AM Julian Andres Klode
<julian.klode@canonical.com> wrote:
>
> On Tue, Feb 08, 2022 at 01:10:34PM +0000, Matthew Wilcox wrote:
> > On Tue, Feb 08, 2022 at 12:01:22PM +0100, Julian Andres Klode wrote:
> > > It's worth pointing out that in Ubuntu, the generated MOK key
> > > is for module signing only (extended key usage 1.3.6.1.4.1.2312.16.1.2),
> > > kernels signed with it will NOT be bootable.
> >
> > Why should these be separate keys?  There's no meaningful security
> > boundary between a kernel module and the ernel itself; a kernel
> > modulecan, for example, write to CR3, and that's game over for
> > any pretence at separation.
>
> I don't really _know_, but I believe the difference is that the
> kernel binaries runs in boot services, and calls ExitBootServices,
> whereas modules are loaded after ExitBootServices.
>
> But I don't know the full rationale why (a) the feature exists in
> the first place and (b) why the Ubuntu security team chose to require
> that constraint.
>
> My goal is just to make people aware of that so they can make
> informed decisions :)
>
> --
> debian developer - deb.li/jak | jak-linux.org - free software dev
> ubuntu core developer                              i speak de, en


So, this is the restriction only for Ubuntu.

If it works for Debian, I am fine with
adding the kernel signing to scripts/package/builddeb.

If it is annoying for some people, maybe we can add
some switch like KDEB_SIGN_KERNEL to conditionally
sign the kernel.

-- 
Best Regards
Masahiro Yamada
