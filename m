Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23B0211D983
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 23:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfLLWic (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 17:38:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56254 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730707AbfLLWic (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 17:38:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so4156648wmj.5
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 14:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqwwHglR04KZFJa0WVQzIRil00GoxrnJkWObMPUACX8=;
        b=nNbwx4ZFzHpO/JWWsU0TrfQOMv8KM2fYU/t2WR3wKtK1Y8Q87Sggou6gtAhTdjQmZh
         dmcpz+IlhAcvSihaQtXs1iWvLIHmJnnLgpyjOvrhGBeDn7fnTyszI11YmoagHu9/60Tt
         ybL+s3Bh9PE4rZ2eClS8Bx/n2D+vebyIP5hSu8r0eND6VGbrGgLZNMAoI6cPUh/GwEwX
         IKnogX2LVWYE8LpOEDtlhH4xDf02Lrc3RzSetdEjDt0cK+TULSzSSBhaffDttGiRqFfD
         UpnlE0FitGY6+WzBv2J1CiL2EP8AkOaZxZcxt61sPG1k1tNyVT3qsL4wOGu+OS/d33al
         wTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqwwHglR04KZFJa0WVQzIRil00GoxrnJkWObMPUACX8=;
        b=mVVNelv+bfRAO8J3v3MgT2A/4g5sONBx9kn+4ErdWlvUcbtzru0bzdmmnp6Kqm6Sa6
         GfavZcbuBv2giGO4L0r8cvSqnsxOdKJgSMcEvewUFDok36Z3U2yGXYOf2ZKyxDX35ZWn
         j6ZUvrUU/lEZe3Jn1pm5QlbBDcm1r5SI7HhkVjNMJlpcWhsrIt05UpL+MWGbEbcvDab9
         TnhyGpcYLENcj/ssrMkg7uDG8L8a6ElKfZAcqmZp3vjalePQQbr4qWt7nJRwdnoTjauS
         lAL8OOMwXj0feTy+cevkk2RR7vQ3ZT6vbSI/DRIXkWdfeu6lvb/KoZqCoIOFSE34WDLw
         S7tA==
X-Gm-Message-State: APjAAAVzST0Fl1MRvD/WEOOcg1sj1alq+H/yXGV4XC43aQN2UnJ0ig7G
        +gNcZD/uSngEpTiOUvX8WWJsX/QkwYksw7F3yPg90A==
X-Google-Smtp-Source: APXvYqwbDQ9oDtyjMvs0/w73OXXIe7cZBN6i2OHMKr47s2vuq8P7Ir9uH4ICCfqurIyjFo3nJwLFGhUA71wWaQKrdNE=
X-Received: by 2002:a1c:a591:: with SMTP id o139mr8928478wme.95.1576190310417;
 Thu, 12 Dec 2019 14:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20191212213443.24128-1-nivedita@alum.mit.edu> <CAKv+Gu_EDan06Cm+LC3Rr8RZhrGsRELwLQWUOLHyzhToenuG8Q@mail.gmail.com>
 <20191212223516.GB10385@rani.riverdale.lan>
In-Reply-To: <20191212223516.GB10385@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 12 Dec 2019 22:38:29 +0000
Message-ID: <CAKv+Gu9TAzkRpyM21zAQRy61ywVHyRucTa9EX_urkB2ZQzsf6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] efi/gop: Merge 32/64-bit code
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 12 Dec 2019 at 23:35, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Dec 12, 2019 at 10:08:49PM +0000, Ard Biesheuvel wrote:
> > Hello Arvind,
> >
> > On Thu, 12 Dec 2019 at 22:34, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > This series unifies the 32-bit and 64-bit firmware functions in gop.c.
> > >
> > > Patches 1, 2 and 5 are bugfix/cleanup. The merge is in patches 3/4.
> > >
> >
> > Which tree are these patches based on? I get a conflict applying #3
> >
> Sorry, it's based on 5.5-rc1 + 3 earlier efi/gop patches in tip/efi/urgent:
>         efi/gop: Return EFI_NOT_FOUND if there are no usable GOPs
>         efi/gop: Return EFI_SUCCESS if a usable GOP was found
>         efi/gop: Fix memory leak in __gop_query32/64()
>
> > > Patch 1 removes __packed from the GOP structures, which is wrong but
> > > didn't impact their layout.
> > >
> > > The UEFI spec differs from the standard gcc layout for 32-bit systems,
> > > in that it specifies 64-bit alignment for 64-bit members. We have a bit
> > > of a mix in the type definitions currently, with different types doing
> > > one of the below:
> > >         (a) nothing, if a 64-bit member happens to fall naturally on a
> > >             64-bit boundary
> > >         (b) explicit padding fields
> > >         (c) use of __aligned_u64
> > > The last method is the only one that gets the alignment requirement of
> > > the structure itself correct as well as the internal layout -- is it
> > > worth fixing everything to use it?
> > >
> >
> > Absolutely.
> >
> Ok I will create a separate patch for that
> >
> > > Patch 5 is to make sure that we don't wind up with a >4G framebuffer on
> > > a 32-bit kernel that can only address 4G. I'm not sure if this can
> > > practically happen on anything that we can run a 32-bit kernel on, but
> > > UEFI specs the framebuffer physical address to be 64-bit even on 32-bit
> > > systems, so I figured we might as well cover this edge case.
> > >
> >
> > This cannot happen. The 32-bit kernel can only run on 32-bit firmware,
> > which cannot create mappings above 4 GB, so in that case, fb_base is
> > guaranteed to be 32-bit addressable.
> >
> Is that still true with PAE?

Yes

> i.e. is it conceivable that some system
> uses the 36-bit address space to map PCI memory to above 4G physical
> addresses, or can PAE only be used with actual RAM?
>

PAE can be used with anything, but UEFI won't map anything in places
where it cannot access it itself. (UEFI mandates a 1:1 mapping)


> I can mostly drop patch 5 if this can't happen. I'd still like to get
> rid of the unnecessary cast of fb_base if that's fine?

Sure. If it's unnecessary, let's get rid of it.
