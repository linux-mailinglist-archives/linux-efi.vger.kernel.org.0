Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58BF316181A
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 17:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgBQQk7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 11:40:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729456AbgBQQk7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Feb 2020 11:40:59 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 741F022B48
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 16:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581957658;
        bh=EoA3g9FlSn4zCAWPQ5Sox2P3Ayv2IqWTw44IzvMbP8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zPJgUtCVZC99+auVAcQz2+rjPgJDFHhR3FU1KlQYrwu+Ocjwuyg8obMxwVRrv6Rpn
         JDuyQUW+nI3lCv2U9agkk7TI9fL2hfHz8GFEQbMNaXRKzG3ryyOP/ufBNMj/k20WvR
         LT8QNdP7J4eieNdDtuAMw99tiqKNn/H+tri59aTQ=
Received: by mail-wr1-f47.google.com with SMTP id z3so20586709wru.3
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 08:40:58 -0800 (PST)
X-Gm-Message-State: APjAAAWkA8zoA/q0S5ux5dPRE7+UxnjxQBxGzP9p5gllqFI8EYeW5uhw
        u/RPbdE2JZE+4le1AhBwrtSV1i/RrK4STNX76Nd8wQ==
X-Google-Smtp-Source: APXvYqxgn21QikW7+oWFJgAPas/0ltn2nw7EqemkL4I0Ks6Pz+xyncdMD9NpLPSPp1izD7bOZBKWUPx5+rVIwEUYWgo=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr22703919wrw.126.1581957656727;
 Mon, 17 Feb 2020 08:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20200217123354.21140-1-Jason@zx2c4.com> <CAKv+Gu83dOKGbYU1t3_KZevB_rn-ktoropFrjASjsv3DozrV1A@mail.gmail.com>
 <20200217155402.GB1461852@kroah.com> <CAKv+Gu_uQvONH=vAcckPEn+HWOOsiQdt_Dsscw2Y3KEUObafxA@mail.gmail.com>
 <20200217163318.GF1502885@kroah.com>
In-Reply-To: <20200217163318.GF1502885@kroah.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Feb 2020 17:40:45 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9v0AffO_A_T11aGwGAgWqEEvai7S0_0Tw1B+OfxOm8ow@mail.gmail.com>
Message-ID: <CAKv+Gu9v0AffO_A_T11aGwGAgWqEEvai7S0_0Tw1B+OfxOm8ow@mail.gmail.com>
Subject: Re: [PATCH] efi: READ_ONCE rng seed size before munmap
To:     Greg KH <greg@kroah.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 17 Feb 2020 at 17:33, Greg KH <greg@kroah.com> wrote:
>
> On Mon, Feb 17, 2020 at 05:09:00PM +0100, Ard Biesheuvel wrote:
> > On Mon, 17 Feb 2020 at 16:54, Greg KH <greg@kroah.com> wrote:
> > >
> > > On Mon, Feb 17, 2020 at 04:23:03PM +0100, Ard Biesheuvel wrote:
> > > > On Mon, 17 Feb 2020 at 13:34, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > >
> > > > > This function is consistent with using size instead of seed->size
> > > > > (except for one place that this patch fixes), but it reads seed->size
> > > > > without using READ_ONCE, which means the compiler might still do
> > > > > something unwanted. So, this commit simply adds the READ_ONCE
> > > > > wrapper.
> > > > >
> > > > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > > > Cc: stable@vger.kernel.org
> > > >
> > > > Thanks Jason
> > > >
> > > > I've queued this in efi/urgent with a fixes: tag rather than a cc:
> > > > stable, since it only applies clean to v5.4 and later.
> > >
> > > Why do that?  That just makes it harder for me to know to pick it up for
> > > 5.4 and newer.
> > >
> > > > We'll need a
> > > > backport to 4.14 and 4.19 as well, which has a trivial conflict
> > > > (s/add_bootloader_randomness/add_device_randomness/) but we'll need to
> > > > wait for this patch to hit Linus's tree first.
> > >
> > > Ok, if you are going to send it on to me for stable, that's fine, but
> > > usually you can just wait for the rejection notices for older kernels
> > > before having to worry about this.  In other words, you are doing more
> > > work than you have to here :)
> > >
> >
> > So just
> >
> > Cc: <stable@vger.kernel.org>
> >
> > without any context is your preferred method?
>
> If you can provide a "Fixes:" tag showing what commit it does fix,
> that's even better as that way I _know_ to try to apply it to older
> kernels and if it fails, you will get an email saying it failed.  With
> just a cc: stable, I do a "best guess" and don't work very hard if older
> kernels do not apply as I don't know if it is relevant or not.
>

OK, will do.
