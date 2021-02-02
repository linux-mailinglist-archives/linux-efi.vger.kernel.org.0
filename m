Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4316830CF1A
	for <lists+linux-efi@lfdr.de>; Tue,  2 Feb 2021 23:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbhBBWez (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Feb 2021 17:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbhBBWeb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Feb 2021 17:34:31 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C201C0613ED
        for <linux-efi@vger.kernel.org>; Tue,  2 Feb 2021 14:33:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id nm1so3203442pjb.3
        for <linux-efi@vger.kernel.org>; Tue, 02 Feb 2021 14:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=df6pAHxeS3aJ78xgSJShNmAjNRSNKmi3Vx/fq6dvolA=;
        b=gnJJdDK50DARFPRWBNm51TSoFhO57kc+DrnUpG13DWdTHH1+iPf9T+QMDk3wV3ASQS
         MpZPNYRGCD0ose0Yd9/Ag5M1oX+z9jTh4mTSpKRD2nasbVV6/jbt3ilIdak1DY8f984l
         uKOhU0R2fKpVQavisyhS2gAMVzW3miboP/hKYArH9tY4bmzbu5QwvwHcOoYxWwqAQhkh
         MVLNCMWtE/Ef9D+Gx7IBvaK+qC7QEeMMsa8VQhM9oBXyV3adGu6hs8ZVhxW+aOr6riVA
         rclRjfRnlVoBKi7XRg9lPTpVj54xXa3ncTRkqqaAVo4E2lz6ayb2DvrPu8ghPzKDS0Eo
         BCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=df6pAHxeS3aJ78xgSJShNmAjNRSNKmi3Vx/fq6dvolA=;
        b=cG+orZmfjIG/D6AaTrBxXuer6iIR5rXeFVkaaG65yoPzlEKse7DP7x8GzykAgFuWri
         0vQfwtIvaaI7d9Nt6g2xbpE59sE1y0ftYYO+TOEf11m3VUeXaVCZsM6excja1MB6CoJJ
         k3OWCGlKqtMywyFbBKu+8fAL5oQwdsw7n9QywsKOl6UmO2ic45940zUDhd4BsGBuGThQ
         /bJ52jqROGEIw2ZYwMjAoSIv8Sq+cueJWyO6cOruWM2aMR5ZDSr4xFztdUThsPZS0aQS
         cC327liWAXIZl2HiO1PkoGNZxkFkYPEhEB+m/WhgMH7EG05CGSfmkNldSvEgTjQ3n/o4
         6tyA==
X-Gm-Message-State: AOAM5336rr0EsdsKKLugn5q4/WDZbzcQioIVH7dKopZxpaeBxFTE3eSz
        I4y+EDreyKrAXGdu/6zBiojXj6ER5lxKLLlxRf0ncvjMLZw0gg==
X-Google-Smtp-Source: ABdhPJzqRv16XbBEO0J78A4aRxbg7WdzV/kblT06ucDtK18GH5NBPAMKWCFcydqjSknCTdCnGcfJi40WNs1RPXRtXIo=
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr10799pjn.25.1612305230632;
 Tue, 02 Feb 2021 14:33:50 -0800 (PST)
MIME-Version: 1.0
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com> <20210127232651.rj3mo7c2oqh4ytsr@treble>
 <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
 <20210201214423.dhsma73k7ccscovm@treble> <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
 <20210202000203.rk7lh5mx4aflgkwr@treble>
In-Reply-To: <20210202000203.rk7lh5mx4aflgkwr@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Feb 2021 14:33:38 -0800
Message-ID: <CAKwvOd=R_ELec5Q3+oe9zuYXrwSGfLkqomAPOTr=UH=SZPtKUw@mail.gmail.com>
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>, raphael.gault@arm.com,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Bill Wendling <morbo@google.com>, swine@google.com,
        yonghyun@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 1, 2021 at 4:02 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Feb 01, 2021 at 03:17:40PM -0800, Nick Desaulniers wrote:
> > On the earlier thread, Julien writes:
> >
> > >> I think most people interested in livepatching are using GCC built
> > >> kernels, but I could be mistaken (althought in the long run, both
> > >> compilers should be supported, and yes, I realize the objtool solution
> > >> currently only would support GCC).
> >
> > Google's production kernels are using livepatching and are built with
> > Clang.  Getting similar functionality working for arm64 would be of
> > interest.
>
> Well, that's cool.  I had no idea.
>
> I'm curious how they're generating livepatch modules?  Because
> kpatch-build doesn't support Clang (AFAIK), and if they're not using
> kpatch-build then there are some traps to look out for.

Ok, I just met with a bunch of folks that are actively working on
this.  Let me intro
Yonghyun Hwang <yonghyun@google.com>
Pete Swain <swine@google.com>
who will be the folks on point for this from Google.

My understanding after some clarifications today is that Google is
currently using a proprietary kernel patching mechanism that developed
around a decade ago, "pre-ksplice Oracle acquisition."  But we are
looking to transition to kpatch, and help towards supporting arm64.
Live patching is important for deploying kernel fixes faster than
predetermined scheduled draining of jobs in clusters.

The first steps for kpatch transition is supporting builds with Clang.
Yonghyun is working on that and my hope is he will have patches for
you for that soon.

Curiously, the proprietary mechanism doesn't rely on stack validation.
I think that such dependency was questioned on the cover letter
patch's thread as well.  Maybe there's "some traps to look out for"
you're referring to there?  I'm not privy to the details, though I
would guess it has to do with ensuring kernel threads aren't executing
(or planning to return through) code regions that are trying to be
patched/unpatched.  I am curious about frame pointers never being
omitted for arm64; is frame pointer chasing is unreliable in certain
contexts?

The internal functionality has been used heavily in production for
almost a decade, though without it being public or supporting arm64;
I'm not sure precisely how they solve such issues (or how others might
review such an approach).

Either way, the dependencies for live patching are less important, so
long as they are toolchain portable.  The ability to live patch kernel
images is ___important___ to Google.

> > Objtool support on arm64 is interesting to me though, because it has
> > found bugs in LLVM codegen. That alone is extremely valuable.  But not
> > it's not helpful if it's predicated or tightly coupled to GCC, as this
> > series appears to do.
>
> I agree 100%, if there are actual Clang livepatch users (which it sounds
> like there are) then we should target both compilers.

Or will be. (Sorry, I didn't know we hadn't completed the transition
to kpatch yet.  It is "the opposite side of the house" from where I
work; I literally have 8 bosses, not kidding).

Though if kpatch moves to requiring GCC plugins for architectures we
use extensively or would like to use more of, that's probably going to
throw a wrench in multiple transition plans.  (The fleet's transition
to Clang is done, I'm not worried about that).

> And yes, objtool has been pretty good at finding compiler bugs, so the
> more coverage the better.
> > The idea of rebuilding control flow from binary analysis and using
> > that to find codegen bugs is a really cool idea (novel, even? idk),
> > and I wish we had some analog for userspace binaries that could
> > perform similar checks.
>
> Objtool is generic in many ways -- in fact I recently heard from a PhD
> candidate who used it successfully on another kernel for an ORC
> unwinder.

That's pretty cool!  Reuse outside the initial context is always a
good sign that something was designed right.

> It could probably be used on user space without much effort.  That was
> an early original stated goal but I definitely don't have the bandwidth
> or incentive to work on it.

Heh.  I'm a big fan of game theory; carrot or stick, right?
-- 
Thanks,
~Nick Desaulniers
