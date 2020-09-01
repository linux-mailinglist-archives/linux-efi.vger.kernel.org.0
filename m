Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F969259DCD
	for <lists+linux-efi@lfdr.de>; Tue,  1 Sep 2020 20:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgIASCS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Sep 2020 14:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgIASCP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Sep 2020 14:02:15 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C23C061244
        for <linux-efi@vger.kernel.org>; Tue,  1 Sep 2020 11:02:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e33so1100944pgm.0
        for <linux-efi@vger.kernel.org>; Tue, 01 Sep 2020 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85apg5NRwahAocGqqv4gi+n4yORybk6Y48nEDadq/2g=;
        b=ubDddq84UdfD6pp9neg2X/djSllMkEZgfNKHLcl+/8Tqh7gB+v1dXHMnCbcajfMT5r
         B7/HeT9cdXORcYS9REmjQuFYNKX/+HwMqwfjFIrSj0bnWwsMrw7vrC0SUO/iJmurMuzm
         +CsE7mT59ZRE14OUZf5ZSXV//2DBLTrM+8uvBGzWpbTeqBZl1ytvNHFJw8W5Gg8v2q3Y
         5KDAf5GVHYDlOxIl2Ji6J7BYxCQ1bTXLn463uNqsLhwWqC8XCfeJMcIOMRJrQ9eu5qTq
         L3SbQ00tnlmCMr6xPqxE9U+UouLTzvhmY2jkp7o2QQgSXT1HsSWTbgmMXHD2Ekx0imif
         6JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85apg5NRwahAocGqqv4gi+n4yORybk6Y48nEDadq/2g=;
        b=m0qv+vLJE+pHehiVopXT/Spjtu+MxsU1GDLw+9S+NPK06fp/AKA2vetLH8X242hGWn
         Dq9EI/6JpWWk8KnTjZvN33X243/UXXBq9GyeFrHgqWeRZ7hsSykcOxuFYuSjkB0RInCN
         2zjrXmJUSPIz+0QO2KP8CHLjcmyHSsT92SGW4Qg0BnwDIUcM0ie1YVpQsP8Jis66MR4S
         W3S8KNkGmig5p2iTLxa7PMVQKLske3EiGEIesccgP0/ncviKzMsOWtlvehGMFzT4eceB
         3RLFHD/3sQ9wySIu3Ppwj8RBtUBg92k8tJvErlxsTSd7tT1IHqb4WDFUOPZ8YHAovbLZ
         EcxQ==
X-Gm-Message-State: AOAM53183Z2u4cOZQp9KpEgcvTU7PbQx5oSZsdMpkzq/3Z/BACPvhmwg
        GVFX9IrirUVl9EimoWK6g8BSoUKrdxFIGGn+0W8Thg==
X-Google-Smtp-Source: ABdhPJwkwBKhhro217bYWSqHNomm7qIIAgduwKeGfJHsiyITvjqOPbNbQycIH6PhlZ5uZJRTHxZepZmCUJ4CnKKgUyQ=
X-Received: by 2002:a63:9d09:: with SMTP id i9mr2397873pgd.381.1598983334165;
 Tue, 01 Sep 2020 11:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org>
 <202008311240.9F94A39@keescook> <20200901071133.GA3577996@gmail.com>
 <20200901075937.GA3602433@gmail.com> <20200901081647.GB3602433@gmail.com> <202009010816.80F4692@keescook>
In-Reply-To: <202009010816.80F4692@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Sep 2020 11:02:02 -0700
Message-ID: <CAKwvOdnn3wxYdJomvnveyD_njwRku3fABWT_bS92duihhywLJQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/29] Warn on orphan section placement
To:     Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 1, 2020 at 8:17 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Sep 01, 2020 at 10:16:47AM +0200, Ingo Molnar wrote:
> >
> > * Ingo Molnar <mingo@kernel.org> wrote:
> >
> > >
> > > * Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > > >
> > > > * Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > > On Fri, Aug 21, 2020 at 12:42:41PM -0700, Kees Cook wrote:
> > > > > > Hi Ingo,
> > > > > >
> > > > > > Based on my testing, this is ready to go. I've reviewed the feedback on
> > > > > > v5 and made a few small changes, noted below.
> > > > >
> > > > > If no one objects, I'll pop this into my tree for -next. I'd prefer it
> > > > > go via -tip though! :)
> > > > >
> > > > > Thanks!
> > > >
> > > > I'll pick it up today, it all looks very good now!
> > >
> > > One thing I found in testing is that it doesn't handler older LD
> > > versions well enough:
> > >
> > >   ld: unrecognized option '--orphan-handling=warn'
>
> Oh! Uhm, yikes. Thanks for noticing this.
>
> > > Could we just detect the availability of this flag, and emit a warning
> > > if it doesn't exist but otherwise not abort the build?
>
> Yeah, I'll respin those patches.
>
> > > This is with:
> > >
> > >   GNU ld version 2.25-17.fc23
>
> (At best, this is from 2015 ... but yes, min binutils in 2.23.)

Ah, crap! Indeed arch/powerpc/Makefile wraps this in ld-option.

Uh oh, the ppc vdso uses cc-ldoption which was removed! (I think by
me; let me send patches)  How is that not an error?  Yes, guilty,
officer.
commit 055efab3120b ("kbuild: drop support for cc-ldoption").
Did I not know how to use grep, or?  No, it is
commit f2af201002a8 ("powerpc/build: vdso linker warning for orphan sections")
that is wrong.
-- 
Thanks,
~Nick Desaulniers
