Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6972952BE
	for <lists+linux-efi@lfdr.de>; Wed, 21 Oct 2020 21:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436995AbgJUTJ7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Oct 2020 15:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395508AbgJUTJ7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 21 Oct 2020 15:09:59 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96EA324178;
        Wed, 21 Oct 2020 19:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603307398;
        bh=3mlDknj7gWWP20636gbskByHmbYqyI43SuULks1EPec=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gLg2ILm+s4gQls2IaDBWp6q28BNsfFHWgWqAIqg1EUPBkgNfd7BHL1Knac8P5TKsO
         9zxCd9ExNHO35uuHe+5mmeIJlA+ASBXYF0BwNaTDyKbMkjOIZ74ATXRBXB5ORVY2ok
         8ntewJ+KL98hBXWXsqjyAD9j4x/OqkX/+pv+4/Tw=
Received: by mail-oi1-f176.google.com with SMTP id t77so3262275oie.4;
        Wed, 21 Oct 2020 12:09:58 -0700 (PDT)
X-Gm-Message-State: AOAM533yemLpGdnZpxTP6kEmrVKERFQ6kE9c/yfD/PJsYHv3L7Yp8daK
        qvsQ1B0N5P48s4s7sUiMI2rIazRWoIEFfjCA4Bg=
X-Google-Smtp-Source: ABdhPJxJL56gVA6ltf41CqMODH2MtrRNMi76eXVY5qQKdaQNTz9kdX34PxHKq+Fpybp1eN85dayNjJkiiqGJYxzT3PM=
X-Received: by 2002:aca:5a56:: with SMTP id o83mr3085292oib.47.1603307397782;
 Wed, 21 Oct 2020 12:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <e9b1ba517f06b81bd24e54c84f5e44d81c27c566.camel@perches.com>
 <CAMj1kXHe0hEDiGNMM_fg3_RYjM6B6mbKJ+1R7tsnA66ZzsiBgw@mail.gmail.com> <1cecfbfc853b2e71a96ab58661037c28a2f9280e.camel@perches.com>
In-Reply-To: <1cecfbfc853b2e71a96ab58661037c28a2f9280e.camel@perches.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 21 Oct 2020 21:09:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFZteNourygxm1zEmW_sBgenpNZno0VefXd0W8GgWEPTQ@mail.gmail.com>
Message-ID: <CAMj1kXFZteNourygxm1zEmW_sBgenpNZno0VefXd0W8GgWEPTQ@mail.gmail.com>
Subject: Re: [PATCH -next] treewide: Remove stringification from __alias macro definition
To:     Joe Perches <joe@perches.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 21 Oct 2020 at 21:07, Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-10-21 at 21:02 +0200, Ard Biesheuvel wrote:
> > On Wed, 21 Oct 2020 at 20:58, Joe Perches <joe@perches.com> wrote:
> > > Like the __section macro, the __alias macro uses
> > > macro # stringification to create quotes around
> > > the section name used in the __attribute__.
> > >
> > > Remove the stringification and add quotes or a
> > > stringification to the uses instead.
> > >
> >
> > Why?
>
> Using quotes in __section caused/causes differences
> between clang and gcc.
>
> https://lkml.org/lkml/2020/9/29/2187
>
> Using common styles for details like this is good.
>
>

Ah, fair enough.

With this rationale added to the commit log:

Acked-by: Ard Biesheuvel <ardb@kernel.org>
