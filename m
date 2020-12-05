Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341C92CFEF8
	for <lists+linux-efi@lfdr.de>; Sat,  5 Dec 2020 21:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgLEU6T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Dec 2020 15:58:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbgLEU6S (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 5 Dec 2020 15:58:18 -0500
X-Gm-Message-State: AOAM533TiQpXkFR/loqScTk9b+TQGvZ4+PzM3RUoMP1urVktIwIyCZ8N
        E009eyiy/Pm2cNCUrVCaNXE8pK49O89CbN8Ghf4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607201857;
        bh=6uR1ro3FB6gF6Hso009vX3qFoBF8H98C3imWvG68XRg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=khfVwD0LglSW4w+rMzBOp+lYdau1zTJfVpqupVQ2dWKgA5YbANCzrZoHWlPgymzki
         n5TAJV6DpFp0ZhSYnvRCw01BMbd4GzJk86mrRe31ffWCv/SHLBraSLriB2lDIlFY2O
         vrWdFvPLdK4CbspcJ+VxhEdw+RRbfIbjDmHzM08JYz2zsDp3ksEwdxUCxHo09dTm4X
         0hT+T47vZJVzneNd4S5xaAjEG/o8V8XF/5GXwIszSzIo38If2WWJyX3IlyaZQotEwz
         6bSodRRyCEmOcK4F6Un5k81d0qLzKcQnbtEk6KnMdcWMwBJeaYyeAUJbh8uq6HSZTW
         iEMEyWLNCkuIA==
X-Google-Smtp-Source: ABdhPJxleCCXYN4K0eCOrEPSbYje5f4WYryrU3EcXbdLcwvt52PPpQ2PJvlScKqxpBclIz8Nc9d2tWfVYLMoXLGVFmU=
X-Received: by 2002:aca:dd0b:: with SMTP id u11mr7493751oig.47.1607201857245;
 Sat, 05 Dec 2020 12:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
 <20201204170319.20383-8-laniel_francis@privacyrequired.com>
 <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
 <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
 <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com> <3161fc13d69c388b1f51f59c6ecea48dcd0a7856.camel@HansenPartnership.com>
In-Reply-To: <3161fc13d69c388b1f51f59c6ecea48dcd0a7856.camel@HansenPartnership.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 5 Dec 2020 21:57:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFZ1_05O=s37n7pJbFxRm_-hAVFHKqc6OtALfBMVZVYnQ@mail.gmail.com>
Message-ID: <CAMj1kXFZ1_05O=s37n7pJbFxRm_-hAVFHKqc6OtALfBMVZVYnQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 07/12] efi: Replace strstarts() by str_has_prefix().
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     laniel_francis@privacyrequired.com,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 5 Dec 2020 at 21:24, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sat, 2020-12-05 at 20:36 +0100, Ard Biesheuvel wrote:
> > On Fri, 4 Dec 2020 at 19:02, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > On Fri, 2020-12-04 at 18:07 +0100, Ard Biesheuvel wrote:
> > > > On Fri, 4 Dec 2020 at 18:06, <laniel_francis@privacyrequired.com>
> > > > wrote:
> > > > > From: Francis Laniel <laniel_francis@privacyrequired.com>
> > > > >
> > > > > The two functions indicates if a string begins with a given
> > > > > prefix. The only difference is that strstarts() returns a bool
> > > > > while str_has_prefix() returns the length of the prefix if the
> > > > > string begins with it or 0 otherwise.
> > > > >
> > > >
> > > > Why?
> > >
> > > I think I can answer that.  If the conversion were done properly
> > > (which it's not) you could get rid of the double strings in the
> > > code which are error prone if you update one and forget
> > > another.  This gives a good example: 3d739c1f6156 ("tracing: Use
> > > the return of str_has_prefix() to remove open coded numbers"). so
> > > in your code you'd replace things like
> > >
> > >     if (strstarts(option, "rgb")) {
> > >         option += strlen("rgb");
> > >         ...
> > >
> > > with
> > >
> > >     len = str_has_prefix(option, "rgb");
> > >     if (len) {
> > >         option += len
> > >         ...
> > >
> > > Obviously you also have cases where strstart is used as a boolean
> > > with no need to know the length ... I think there's no value to
> > > converting those.
> > >
> >
> > This will lead to worse code being generated. strlen() is evaluated
> > at build time by the compiler if the argument is a string literal, so
> > your 'before' version gets turned into 'option += 3', whereas the
> > latter needs to use a runtime variable.
>
> str_has_prefix() is an always_inline function so it should be build
> time evaluated as well.  I think most compilers see len as being a
> constant and unchanged, so elide the variable.  This means the code
> generated should be the same.
>

Fair enough. I wasn't aware str_has_prefix() was __always_inline.

> > So I don't object to using str_has_prefix() in new code in this way,
> > but I really don't see the point of touching existing code.
>
> That's your prerogative as a Maintainer ... I was just explaining what
> the original author had in mind when str_has_prefix() was created.
>

Sure, I fully understand you are not the one proposing these changes.

But if the pattern in question is so common, couldn't we go one step
further and define something like

static inline const u8 *skip_prefix_or_null(const u8 *str, const u8 *prefix)
{
}

which returns a pointer into the original string, or NULL if the
prefix is not present.

The current patch as proposed has no benefit whatsoever, but even the
meaningful alternative you are proposing is not actually an
improvement, given that it is not self-explanatory from the name
'str_has_prefix' what it returns, and so the code becomes more
difficult to understand.
