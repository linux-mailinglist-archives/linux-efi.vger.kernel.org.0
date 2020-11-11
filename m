Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54F02AE98C
	for <lists+linux-efi@lfdr.de>; Wed, 11 Nov 2020 08:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgKKHT1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Nov 2020 02:19:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgKKHT1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 11 Nov 2020 02:19:27 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 573D721D7F;
        Wed, 11 Nov 2020 07:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605079166;
        bh=CAQVZqtxtSOwUyW8EqmnyD/K8yMmd2zuMQylnTG3pAg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=guq6CmAiRLq4R57MddTf3q6FwEUAeGMSddkiHps3KcyrTTkyZgtGjcSmcOIsYZj0M
         RIXnQSaNESRz5bdvVKxisfCpa82vtPflR7f31OGH6AfHdtg9UUX+aLE+fkQkqYSZm9
         ibIc3iuUQl0WCalegb6OGnkKiHD0ZFDeAI5/tccU=
Received: by mail-ot1-f43.google.com with SMTP id i18so1301416ots.0;
        Tue, 10 Nov 2020 23:19:26 -0800 (PST)
X-Gm-Message-State: AOAM531102nF+TmYgHnqKLijp4Ay8DngYbSXrdz5bO/NrSJ9+SJv0zhU
        Q32FXfif3rTNKqT927zHMOBOHCbDykmPTOvtOQQ=
X-Google-Smtp-Source: ABdhPJy/FX3/haQPkbbnTxCEyFCfcbR6nBwOK2StlreaD3AMalrsdDe04JmnBGrk4RF2qWP6H6cn3ss1V/mpW5hPHIQ=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr7308063otd.90.1605079165545;
 Tue, 10 Nov 2020 23:19:25 -0800 (PST)
MIME-Version: 1.0
References: <e9b1ba517f06b81bd24e54c84f5e44d81c27c566.camel@perches.com>
 <20201022073307.GP2628@hirez.programming.kicks-ass.net> <133aa0c8c5e2cbc862df109200b982e89046dbc0.camel@perches.com>
In-Reply-To: <133aa0c8c5e2cbc862df109200b982e89046dbc0.camel@perches.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 11 Nov 2020 08:19:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF_0_bu0nbJyUU-yBDCOAirRvGkX-V8kQPVh_GHO2WM-g@mail.gmail.com>
Message-ID: <CAMj1kXF_0_bu0nbJyUU-yBDCOAirRvGkX-V8kQPVh_GHO2WM-g@mail.gmail.com>
Subject: Re: [PATCH -next] treewide: Remove stringification from __alias macro definition
To:     Joe Perches <joe@perches.com>, Russell King <linux@armlinux.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

(+ Russell)

On Thu, 22 Oct 2020 at 18:20, Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-10-22 at 09:33 +0200, Peter Zijlstra wrote:
> > On Wed, Oct 21, 2020 at 11:58:25AM -0700, Joe Perches wrote:
> > > Like the __section macro, the __alias macro uses
> > > macro # stringification to create quotes around
> > > the section name used in the __attribute__.
> > >
> > > Remove the stringification and add quotes or a
> > > stringification to the uses instead.
> >
> > There's a complete lack of rationale for this change.
>
> I'll eventually post V2.
> I'm waiting to see if there are more comments.
>
> As I wrote in reply to Ard:
>
> https://lore.kernel.org/lkml/1cecfbfc853b2e71a96ab58661037c28a2f9280e.camel@perches.com/
>
> Using quotes in __section caused/causes differences
> between clang and gcc.
>
> https://lkml.org/lkml/2020/9/29/2187
>
> Using common styles for details like this is good.
>

This patch is now causing problems in the ARM tree, because some new
uses of __alias() have been queued (for KASAN), and since this is a
non-backwards compatible change, we have to choose between breaking
the maintainer's tree or breaking -next (given that the change has
been pulled in there now)

I am still not convinced we need this change, as I don't see how the
concerns regarding __section apply to __alias. But if we do, can we
please use the same approach, i.e., revert the current patch, and
queue it again after v5.11-rc1 with all new occurrences covered as
well?
