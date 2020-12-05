Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172932CFF2D
	for <lists+linux-efi@lfdr.de>; Sat,  5 Dec 2020 22:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgLEVVY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Dec 2020 16:21:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgLEVVX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 5 Dec 2020 16:21:23 -0500
X-Gm-Message-State: AOAM530rQ9mcCOpWwl0/T382tWesDrJZmEfalOOSj61nYX9eU71vTwv/
        /SVegILy5d00sUe8m4GaR1rzcICpEazRMdgeeME=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607203242;
        bh=EN+ljGMFS/G0bufAArtw3xqqisKkIlDYhiEWJWKFY/w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PgUSDQo2YuLlsZ1Lr7KHVTiqBIkV0p/J/FUGPR+dSKov26CEwmTZ9Q7ANtxJw1vFA
         VtZMvvtlO1CrBSmUHmxF1/xiEsKpnquqOL/YojvImRsXcYv+GEDMKnNZrDu/xEi5Aw
         ltuIuoF71A7eCbclFsFsz3xYdLKTxAee+9hTvBP6bsl8WKfepdtnw9x0zN15mv3G9T
         qQ8siAT0U911SHR7go9eaMamCPr4UxMag/yftxPFCkCS+WGy+AUWbFUlIgHkw5zD8y
         18i283EjHfSrLx/3FJ+kUdgBYADIgf5PmS18PPzZT2fbTqC4pRKYvcULmuy/Zzg++k
         2dfU6pK/bvZ3g==
X-Google-Smtp-Source: ABdhPJzkCBHOp6nSaISK31eFoXDF2irb2y8zT5SYfOr9H8HnKJ/z19Ua5PnKNIsWSMrSJm7lhHrETRNKcfxdGIImeug=
X-Received: by 2002:aca:b809:: with SMTP id i9mr7466914oif.174.1607203242072;
 Sat, 05 Dec 2020 13:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
 <20201204170319.20383-8-laniel_francis@privacyrequired.com>
 <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
 <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
 <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
 <3161fc13d69c388b1f51f59c6ecea48dcd0a7856.camel@HansenPartnership.com>
 <CAMj1kXFZ1_05O=s37n7pJbFxRm_-hAVFHKqc6OtALfBMVZVYnQ@mail.gmail.com> <043040d9c092cedcab8bf88b0ec805616d3be44d.camel@HansenPartnership.com>
In-Reply-To: <043040d9c092cedcab8bf88b0ec805616d3be44d.camel@HansenPartnership.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 5 Dec 2020 22:20:31 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHj0y9b+yGPDjyToFL6HYyyu23BuX3FMYmjGo5+6sgjUQ@mail.gmail.com>
Message-ID: <CAMj1kXHj0y9b+yGPDjyToFL6HYyyu23BuX3FMYmjGo5+6sgjUQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 07/12] efi: Replace strstarts() by str_has_prefix().
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     laniel_francis@privacyrequired.com,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 5 Dec 2020 at 22:15, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> [Rostedt added because this is all his fault]
> On Sat, 2020-12-05 at 21:57 +0100, Ard Biesheuvel wrote:
> > On Sat, 5 Dec 2020 at 21:24, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> [...]
> > > > So I don't object to using str_has_prefix() in new code in this
> > > > way, but I really don't see the point of touching existing code.
> > >
> > > That's your prerogative as a Maintainer ... I was just explaining
> > > what the original author had in mind when str_has_prefix() was
> > > created.
> > >
> >
> > Sure, I fully understand you are not the one proposing these changes.
> >
> > But if the pattern in question is so common, couldn't we go one step
> > further and define something like
> >
> > static inline const u8 *skip_prefix_or_null(const u8 *str, const u8
> > *prefix)
> > {
> > }
> >
> > which returns a pointer into the original string, or NULL if the
> > prefix is not present.
> >
> > The current patch as proposed has no benefit whatsoever, but even the
> > meaningful alternative you are proposing is not actually an
> > improvement, given that it is not self-explanatory from the name
> > 'str_has_prefix' what it returns, and so the code becomes more
> > difficult to understand.
>
> Ah, so this is the kernel maintainer's syndrome: you see an API which
> isn't quite right for your use case, so you update or change it.  Then
> you see other use cases for it and suddenly to you it becomes the best
> thing since sliced bread and with a one ring to rule them all mentality
> you exhort everyone to use this new API everywhere.  See this comment
> in the merge commit (495d714ad1400) which comes from the merge cover
> letter:
>
> >     - Addition of str_has_prefix() and a few use cases. There
> >       currently is a similar function strstart() that is used in a
> >       few places, but only returns a bool and not a length. These
> >       instances will be removed in the future to use
> >       str_has_prefix() instead.
>
> Then you forget about it until someone else acts on your somewhat ill
> considered instruction and actually tries the replacement.  Once
> someone takes up your cause, the API shows up in dozens of emails and
> the actual debate about whether or not this is such a good API really
> begins, with the poor person who picked it up caught in the crossfire.
>
> As maintainers we really should learn to put the cart before the horse.
>

I am not disagreeing with any of this, but I simply don't see a point
in merging patches that apparently result in the exact same machine
code to be generated, and don't substantially make the code itself any
better.
