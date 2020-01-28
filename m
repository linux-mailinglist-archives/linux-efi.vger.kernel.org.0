Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617A514B17C
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jan 2020 10:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgA1JIv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jan 2020 04:08:51 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39853 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgA1JIu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jan 2020 04:08:50 -0500
Received: by mail-qv1-f67.google.com with SMTP id y8so5886961qvk.6
        for <linux-efi@vger.kernel.org>; Tue, 28 Jan 2020 01:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9xAyfYvshxDtwWMgT0zgZJ0j7N3J44CYOXm6ENX55s=;
        b=UBM+ALw8CpI4ev4pjKDHghR0t6BBgD/1R2c9dxpJJ6uPN9cRyxne6hUg5PZwNOH19H
         hALAbYYOUfFDKSm9eXlQN/NN9tzITc8DjLZasBqt0hIvKjly0Ib0N0yaoST95Mz7bcOH
         yHUd/Ry/FDID53tCKpDPzxkj2EC5C/cx2d3fJ5OCFyt/5hV84RF+AVzLtLlKjUUmLdPv
         PIDvbbRM4Azq4pGaUJRRihjz1nnK1UZxiMh5EIoaA2yPIjBtT0ylGPpHdc8NExuKyL76
         3FToEHAO9Du/AIujx4S9AAJSMPjihk4fOihEnKx8WkOM42Nx51bgYn4zoo+7/j+a0o2i
         B/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9xAyfYvshxDtwWMgT0zgZJ0j7N3J44CYOXm6ENX55s=;
        b=VvqJQAwp9dJR3pM3AB+QZiBbMNhiTNdlw1F4yrogk5tT4CHnzJ1bJVbHQlFeVxYm29
         36cKzmDrYs5ylaLRj7rsDaS/BA+xhoHVjZQlm5WYWRsTz0vhOTJz6LmS+OD5AqCdHvVV
         69Rg8fEPi7JrohEwADnH9TpH3A701TEQFQ5q74+L5fTrrAdx4wStKc6tX8voydnAZ0Qp
         DTgzI9jAhHWn6jMS9ylyhYz1G1eRLSHjKY7z1sgHDk2jCt7s7bSenkZlDIt0E3z5s4Ug
         ZpFOaWzTn71BGe7UWS85yWT0rz7DywOggcq+cfAGILfIprPQ+MtEhwyCH6fAo2dHZfFH
         e5GA==
X-Gm-Message-State: APjAAAWd6MqRXIcbDvO9vBoq5asNnbKhZyMoR0v+MvbP0KTSzdr48ern
        IPcC95AV89okZq6hYHYyQf4Lp0wTcsN55+YqGD4oXg==
X-Google-Smtp-Source: APXvYqyLGSeVtyPa6QvM+kGBBxvn+S/PP0KC3EUV34HcvopeZQfmGmHJBrOqaSvVp0ThT/bYujA9Vllz/L/0apuA1W4=
X-Received: by 2002:a05:6214:1874:: with SMTP id eh20mr21684750qvb.122.1580202529263;
 Tue, 28 Jan 2020 01:08:49 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu8ZcO3jRMuMJL_eTmWtuzJ+=qEA9muuN5DpdpikFLwamg@mail.gmail.com>
 <E600649B-A8CA-48D3-AD86-A2BAAE0BCA25@lca.pw> <CACT4Y+a5q1dWrm+PhWH3uQRfLWZ0HOyHA6Er4V3bn9tk85TKYA@mail.gmail.com>
 <CAKv+Gu8ZRjqvQvOJ5JXpAQXyApMQNAFz7cRO9NSjq9u=WnjkTA@mail.gmail.com>
In-Reply-To: <CAKv+Gu8ZRjqvQvOJ5JXpAQXyApMQNAFz7cRO9NSjq9u=WnjkTA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 28 Jan 2020 10:08:37 +0100
Message-ID: <CACT4Y+Z+vYF=6h0+ioMXGX6OHVnAXyHqOQLNFmngT9TqNwAgKA@mail.gmail.com>
Subject: Re: mmotm 2020-01-23-21-12 uploaded (efi)
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Qian Cai <cai@lca.pw>, Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.cz>, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 28, 2020 at 8:33 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> > > > Should be fixed by
> > > >
> > > > https://lore.kernel.org/linux-efi/20200121093912.5246-1-ardb@kernel.org/
> > >
> > > Cc kasan-devel@
> > >
> > > If everyone has to disable KASAN for the whole subdirectories like this, I am worried about we are losing testing coverage fairly quickly. Is there a bug in compiler?
> >
> > My understanding is that this is invalid C code in the first place,
> > no? It just happened to compile with some compilers, some options and
> > probably only with high optimization level.
>
> No, this is not true. The whole point of favoring IS_ENABLED(...) over
> #ifdef ... has always been that the code remains visible to the
> compiler, regardless of whether the option is selected or not, but
> that it gets optimized away entirely. The linker errors prove that
> there is dead code remaining in the object files, which means we can
> no longer rely on IS_ENABLED() to work as intended.

I agree that exposing more code to compiler is good, I prefer to do it
as well. But I don't see how this proves anything wrt this particular
code being invalid C. Called functions still need to be defined. There
is no notion of dead code in C. Yes, this highly depends on compiler,
options, optimization level, etc. Some combinations may work, some
won't. E.g. my compiler compiles it just fine (clang 10) without
disabling instrumentation... what does it prove? I don't know.

To clarify: I completely don't object to patching this case in gcc
with -O2, it just may be hard to find anybody willing to do this work
if we are talking about fixing compilation of invalid code.



> > There is a known, simple fix that is used throughout the kernel -
> > provide empty static inline stub, or put whole calls under ifdef.
>
> No, sorry, that doesn't work for me. I think it is great that we have
> diagnostic features that are as powerful as KASAN, but if they require
> code changes beyond enable/disable, I am not going to rely on them.
