Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6E030CFF1
	for <lists+linux-efi@lfdr.de>; Wed,  3 Feb 2021 00:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhBBXid (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Feb 2021 18:38:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229731AbhBBXiT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Feb 2021 18:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612309011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jss9BHM8ER2sH3J1Y701o3PQpwb7W/xqsNFGP2giOhw=;
        b=h5rAIlrfwxa0SE2lGNn0XlDSuwNf3NDU40jVlPUo9OErv2rTnt9KUTI8D0oswAwjSE964K
        /0qMN33KfeV8ZSAB6RAzU+m6l3XeGYYBfWFUrnCuH+x9RDgGuURQbztsz2yY6TCJoQs9st
        DuYxgRqxV5zwvxoUju0viSEz/mgQnZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-sH3jKwTvP9a0zdxKzgF-SA-1; Tue, 02 Feb 2021 18:36:49 -0500
X-MC-Unique: sH3jKwTvP9a0zdxKzgF-SA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58CD51015C80;
        Tue,  2 Feb 2021 23:36:46 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A89B6E510;
        Tue,  2 Feb 2021 23:36:43 +0000 (UTC)
Date:   Tue, 2 Feb 2021 17:36:36 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
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
        yonghyun@google.com, live-patching@vger.kernel.org
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
Message-ID: <20210202233636.nvbl6wivgnhacbvg@treble>
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com>
 <20210127232651.rj3mo7c2oqh4ytsr@treble>
 <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
 <20210201214423.dhsma73k7ccscovm@treble>
 <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
 <20210202000203.rk7lh5mx4aflgkwr@treble>
 <CAKwvOd=R_ELec5Q3+oe9zuYXrwSGfLkqomAPOTr=UH=SZPtKUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=R_ELec5Q3+oe9zuYXrwSGfLkqomAPOTr=UH=SZPtKUw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 02, 2021 at 02:33:38PM -0800, Nick Desaulniers wrote:
> On Mon, Feb 1, 2021 at 4:02 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Mon, Feb 01, 2021 at 03:17:40PM -0800, Nick Desaulniers wrote:
> > > On the earlier thread, Julien writes:
> > >
> > > >> I think most people interested in livepatching are using GCC built
> > > >> kernels, but I could be mistaken (althought in the long run, both
> > > >> compilers should be supported, and yes, I realize the objtool solution
> > > >> currently only would support GCC).
> > >
> > > Google's production kernels are using livepatching and are built with
> > > Clang.  Getting similar functionality working for arm64 would be of
> > > interest.
> >
> > Well, that's cool.  I had no idea.
> >
> > I'm curious how they're generating livepatch modules?  Because
> > kpatch-build doesn't support Clang (AFAIK), and if they're not using
> > kpatch-build then there are some traps to look out for.
> 
> Ok, I just met with a bunch of folks that are actively working on
> this.  Let me intro
> Yonghyun Hwang <yonghyun@google.com>
> Pete Swain <swine@google.com>
> who will be the folks on point for this from Google.

Nice to meet you all.  Adding the live-patching ML sub-thread.

> My understanding after some clarifications today is that Google is
> currently using a proprietary kernel patching mechanism that developed
> around a decade ago, "pre-ksplice Oracle acquisition."  But we are
> looking to transition to kpatch, and help towards supporting arm64.
> Live patching is important for deploying kernel fixes faster than
> predetermined scheduled draining of jobs in clusters.
> 
> The first steps for kpatch transition is supporting builds with Clang.
> Yonghyun is working on that and my hope is he will have patches for
> you for that soon.

That would be great!

> Curiously, the proprietary mechanism doesn't rely on stack validation.

If this proprietary mechanism relies on stack traces, that could
problematic.  Livepatch originally made the same assumption, but it was
shot down quickly:

  https://lwn.net/Articles/634649/
  https://lwn.net/Articles/658333/

> I think that such dependency was questioned on the cover letter
> patch's thread as well.

Yes, though it's generally agreed that unvalidated compiler-generated
unwinder metadata isn't going to be robust enough for kernel live
patching.

> Maybe there's "some traps to look out for" you're referring to there?

The "traps" are more about how the patches are generated.  If they're
built with source code, like a normal kernel module, you have to be
extra careful because of function ABI nastiness.  kpatch-build avoids
this problem.  Unfortunately this still isn't documented.

> I'm not privy to the details, though I would guess it has to do with
> ensuring kernel threads aren't executing (or planning to return
> through) code regions that are trying to be patched/unpatched.

Right.  There are some good details in
Documentation/livepatch/livepatch.rst.

> I am curious about frame pointers never being omitted for arm64; is
> frame pointer chasing is unreliable in certain contexts?

Yes, problematic areas are interrupts, exceptions, inline asm,
hand-coded asm.  A nice document was recently added in
Documentation/livepatch/reliable-stacktrace.rst which covers a lot of
this stuff.

> The internal functionality has been used heavily in production for
> almost a decade, though without it being public or supporting arm64;
> I'm not sure precisely how they solve such issues (or how others might
> review such an approach).

Very impressive to run it in production that long.  Their experience and
expertise is definitely welcome.

> Either way, the dependencies for live patching are less important, so
> long as they are toolchain portable.  The ability to live patch kernel
> images is ___important___ to Google.
> 
> > > Objtool support on arm64 is interesting to me though, because it has
> > > found bugs in LLVM codegen. That alone is extremely valuable.  But not
> > > it's not helpful if it's predicated or tightly coupled to GCC, as this
> > > series appears to do.
> >
> > I agree 100%, if there are actual Clang livepatch users (which it sounds
> > like there are) then we should target both compilers.
> 
> Or will be. (Sorry, I didn't know we hadn't completed the transition
> to kpatch yet.  It is "the opposite side of the house" from where I
> work; I literally have 8 bosses, not kidding).
> 
> Though if kpatch moves to requiring GCC plugins for architectures we
> use extensively or would like to use more of, that's probably going to
> throw a wrench in multiple transition plans.  (The fleet's transition
> to Clang is done, I'm not worried about that).

Hopefully we can just forget the GCC plugin idea.

It would be really nice to see some performance numbers for
-fno-jump-tables so we can justify doing that instead, at least in the
short-term.  I'd suspect the difference isn't measurable in the real
world.

(In the case of GCC+retpolines, it would be a performance improvement.)

> > And yes, objtool has been pretty good at finding compiler bugs, so the
> > more coverage the better.
> > > The idea of rebuilding control flow from binary analysis and using
> > > that to find codegen bugs is a really cool idea (novel, even? idk),
> > > and I wish we had some analog for userspace binaries that could
> > > perform similar checks.
> >
> > Objtool is generic in many ways -- in fact I recently heard from a PhD
> > candidate who used it successfully on another kernel for an ORC
> > unwinder.
> 
> That's pretty cool!  Reuse outside the initial context is always a
> good sign that something was designed right.

So basically you're saying objtool is both useful and well-designed.  I
will quote you on that!

-- 
Josh

