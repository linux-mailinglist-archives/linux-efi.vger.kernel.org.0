Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40272CFE7B
	for <lists+linux-efi@lfdr.de>; Sat,  5 Dec 2020 20:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgLETgz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Dec 2020 14:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgLETgy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 5 Dec 2020 14:36:54 -0500
X-Gm-Message-State: AOAM530zyfGX7xyg/p8wjyiN5xEAqIZwrhtDSGxcIs6RndBYbKexZILi
        pbU7nTl/34548WYfp0Y+DTRkCM2Jdoy6AjnRjpg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607196973;
        bh=sBZiwbc9G/QgjgUAGJx12HLC1iZUViENrn7bnf9AiX8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t6uZgz+vY0R5S6gScN6STOedcjxRl7EFEqjzoyC1bqQLU/2VD2xClYG01RHgYvG6K
         UIpC3cKH8RSMXgQjZY5sB0d3mrCfo9mF3gopkZE/150jMQOa4SAGp0jqUsvtFzhtj7
         St3NcMs3MbJNadTSM9E62nXQI1fM7wSmxD0s+kncGqIa8ZWUO3wMjMr8qGJwSaJnH1
         NG/QsWsEhQt2WcQz+dnfFTTobmIvj5JizPakNVhEAbm4aBwM8QTLkPbS+n0Z77uBWJ
         GFw22tBVs85VLWzpSvQrltNDKHLHD/aNClPNd9z5H057wp7EQrnDsGByYVgbOq6Gkb
         kf8H60IM+n9Gw==
X-Google-Smtp-Source: ABdhPJwX6KHVuyK/9dwgVWPIbbXlyDKpT5/pV2DyPPrgiGPRAukrNtOblzAemLWN4NiefZh96whfA/OX5ZTybZBrcSY=
X-Received: by 2002:a9d:12c:: with SMTP id 41mr7857297otu.77.1607196973105;
 Sat, 05 Dec 2020 11:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
 <20201204170319.20383-8-laniel_francis@privacyrequired.com>
 <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com> <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
In-Reply-To: <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 5 Dec 2020 20:36:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
Message-ID: <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 07/12] efi: Replace strstarts() by str_has_prefix().
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     laniel_francis@privacyrequired.com,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 4 Dec 2020 at 19:02, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2020-12-04 at 18:07 +0100, Ard Biesheuvel wrote:
> > On Fri, 4 Dec 2020 at 18:06, <laniel_francis@privacyrequired.com>
> > wrote:
> > > From: Francis Laniel <laniel_francis@privacyrequired.com>
> > >
> > > The two functions indicates if a string begins with a given prefix.
> > > The only difference is that strstarts() returns a bool while
> > > str_has_prefix()
> > > returns the length of the prefix if the string begins with it or 0
> > > otherwise.
> > >
> >
> > Why?
>
> I think I can answer that.  If the conversion were done properly (which
> it's not) you could get rid of the double strings in the code which are
> error prone if you update one and forget another.  This gives a good
> example: 3d739c1f6156 ("tracing: Use the return of str_has_prefix() to
> remove open coded numbers"). so in your code you'd replace things like
>
>     if (strstarts(option, "rgb")) {
>         option += strlen("rgb");
>         ...
>
> with
>
>     len = str_has_prefix(option, "rgb");
>     if (len) {
>         option += len
>         ...
>
> Obviously you also have cases where strstart is used as a boolean with
> no need to know the length ... I think there's no value to converting
> those.
>

This will lead to worse code being generated. strlen() is evaluated at
build time by the compiler if the argument is a string literal, so
your 'before' version gets turned into 'option += 3', whereas the
latter needs to use a runtime variable.

So I don't object to using str_has_prefix() in new code in this way,
but I really don't see the point of touching existing code.
