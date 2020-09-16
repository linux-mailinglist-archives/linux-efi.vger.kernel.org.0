Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A226CCF5
	for <lists+linux-efi@lfdr.de>; Wed, 16 Sep 2020 22:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgIPUv7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Sep 2020 16:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgIPUvQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Sep 2020 16:51:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED39DC061788
        for <linux-efi@vger.kernel.org>; Wed, 16 Sep 2020 13:51:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so74585ljg.9
        for <linux-efi@vger.kernel.org>; Wed, 16 Sep 2020 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/B3tg9mEqhX8yqMwp1vCIDfTluhhgC8XBbInuGB0y1U=;
        b=fCFbOm7OGys3JHsak63mho5fmUiz+6Rx13OBJSnlo+37M6tmhp1NPXk5LzgKmocDEk
         ngEK1HuZ5OcI2YhcWTx6Yv3lJca+noyHwCIfYEqi3E7yJ1ZjXm00VMr5RtgYSvB+o6BE
         IF3ak0zGg7mbJ9cuXee4TXI6tiHj6BBR7jvQb/kNj+8jsfoXXeKP7p2aSA1d7Q2+KW90
         Hh2Oafqs5eYZnoOWkxQINe60DNAkXP8iMw8dDh/D0wY6L+RY26rjJq7Zg+xswSmvCh2W
         /LqGmtLJ25aRbXGrgYmvDQ+pBeBUBXKEjgWoDyz6PD1ojeCGKs32pYSCrHmon2vjyiuQ
         9amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/B3tg9mEqhX8yqMwp1vCIDfTluhhgC8XBbInuGB0y1U=;
        b=cBFDYk6H3vDxf0yz3HLnkXWPKx0N2pzH4BnCjONbDhUPn9u667C51hgJtTJUXd0gLI
         NNBHe8EE21vQ5St2QR3jSr9W0gcGKXKFYvwwFyKf3VZesg5N4RktfuQpvWC6uOrrvEX2
         ADSzNx+B9883G1sGr5kXoP5G4mqPMn4FKP60mjbEWL1SbS9w82NU50puH15ZjO6pFzlD
         waAz1vYUpWRgqMoxFTHgXjpCsDb28WZt3AaoKLHRmhE8wZt9j30ippo7AWDzz5ynfz1S
         ieCTTCzECW1Afz677B7bigLuQLM9ewFVog6WOqE0+SN2uKsgiHYUyCQyOF57wlKh6DHo
         NXxA==
X-Gm-Message-State: AOAM53346y35a8p8oo/4+o3dp9AKiSMiIuuMmZZJxEXTZ8vsAhu4G3pO
        p+WaKBu1hb0+tAy3cZt9D9KNhxUNdTCOm//sQqY=
X-Google-Smtp-Source: ABdhPJyeABlCk64uPrLpJPYYyVWBJ1jXklwt6Z3VWdUJEc9QQDCCGFe9Ntjvtp8HEIL2C6tGj6KcZFuRcXQSi+mmFtI=
X-Received: by 2002:a05:651c:22d:: with SMTP id z13mr8363263ljn.412.1600289474339;
 Wed, 16 Sep 2020 13:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200914213535.933454-1-nivedita@alum.mit.edu>
 <20200914213535.933454-2-nivedita@alum.mit.edu> <CAMj1kXHy4d6zEJhJtdkHyYx-jnhJJzJ4Xi+qyawhjg6hXhAQgw@mail.gmail.com>
 <CAO18KQi9icju0YJ-dGe70NC8oFN0GL0hM1_fn8xE9dEkcrU_8A@mail.gmail.com> <20200916174550.GA1281480@rani.riverdale.lan>
In-Reply-To: <20200916174550.GA1281480@rani.riverdale.lan>
From:   Jacobo Pantoja <jacobopantoja@gmail.com>
Date:   Wed, 16 Sep 2020 22:51:02 +0200
Message-ID: <CAO18KQgrAGCy3E5k2W52GhNY7VF5HNjc=i0Gw4nW4VnMCvCUtQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi/x86: Add a quirk to support command line
 arguments on Dell EFI firmware
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 16 Sep 2020 at 19:45, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Sep 16, 2020 at 06:50:15PM +0200, Jacobo Pantoja wrote:
> > Hi, I'd like to update my testing and share my thoughts.
> >
> > Regarding the patches:
> > 1) The patches in email 1/2 (the functions "efi_warn", etc.) are not working
> > properly. I got some suggestions for testing from Ard in a separate email.
> >   3a. If, in this 2nd patch, I switch the "efi_warn_once" with an
> > "efi_printk", the
> >   messages appear.
> >   1a. I've set CONFIG_CONSOLE_LOGLEVEL_DEFAULT=5, same result
> >   2a. I've switched from "efi_warn_once" to "efi_warn", same result.
>
> I had tested on QEMU, and the messages appear there. Not sure what might
> cause efi_warn to not work if efi_printk is working.

I was changing the wrong "config", so LOGLEVEL was really 4. Now, being set
as 5, everything appears as expected (after almost 2 hours recompiling, lucky
ThreadRipper owners).
Sorry for the noise

>
> > 2) Even if they would be working, since it is not logged anywhere, I
> > don't really
> > think these messages make sense. Idk if these can be made available to dmesg.
>
> They're useful mostly in the case the boot hangs in the EFI stub. If the
> boot works, they will generally disappear very quickly, making them
> difficult to notice/read.
>
> > 3) The function "efi_apply_loadoptions_quirk" is called twice, it seems to me
> > that calling it from the "file.c" is redundant, but probably I'm
> > missing something.
>
> file.c reads the original UTF-16 command line. It's possible to refactor
> the code so it doesn't have to quirk twice, but this was the smallest
> change for now.
>

Understood, thanks for the explanation.

> >
> > Regarding the quirk itself, in my opinion we should wait for Mario's
> > news, since,
> > again in my opinion, this is something that should be fixed in the
> > firmware itself.
> > Being Dell a serious company, I think it is feasible that, at least
> > for their enterprise
> > products, they might fix it.
> >
> > On Tue, 15 Sep 2020 at 17:09, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Tue, 15 Sep 2020 at 00:35, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > At least some versions of Dell EFI firmware pass the entire
> > > > EFI_LOAD_OPTION descriptor, rather than just the OptionalData part, to
> > > > the loaded image. This was verified with firmware revision 2.15.0 on a
> > > > Dell Precision T3620 by Jacobo Pontaja.
> >
> > Please be so kind to correct my name, if it's being included in the commit msg.
>
> Oops, sorry about that. Ard, can you fix that up?
Thanks
>
> Thanks.
