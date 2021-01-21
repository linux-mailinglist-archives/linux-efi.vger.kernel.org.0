Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734B22FF482
	for <lists+linux-efi@lfdr.de>; Thu, 21 Jan 2021 20:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbhAUTam (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Jan 2021 14:30:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbhAUTH3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 21 Jan 2021 14:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611255962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wDDaUiv5d3X68/0Vuud9U+4TaL5HZM2FTefsitrYa6k=;
        b=AS3Uqr0i2ogt4SBUiJq3ABHYwzzHSm5q/YDsSOVnQ+dNF2wIxqYZQy2TJUPb2qh5JSjJik
        Fh3Z7kislctchLuCJO9BHXhCo1aYODSHKSqjE//QuRqwJ+91DFf/KZVUQppqjKwHZB0s/v
        mJhLtyYrbgVa7krNsji6cFbE03cO1Vo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-7vi9wlmxMGSTfbmUcpNGMw-1; Thu, 21 Jan 2021 13:55:00 -0500
X-MC-Unique: 7vi9wlmxMGSTfbmUcpNGMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA4248066E5;
        Thu, 21 Jan 2021 18:54:58 +0000 (UTC)
Received: from treble (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B1E3160BF3;
        Thu, 21 Jan 2021 18:54:54 +0000 (UTC)
Date:   Thu, 21 Jan 2021 12:54:52 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
Message-ID: <20210121185452.fxoz4ehqfv75bdzq@treble>
References: <20210120173800.1660730-1-jthierry@redhat.com>
 <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
 <186bb660-6e70-6bbf-4e96-1894799c79ce@redhat.com>
 <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
 <YAlkOFwkb6/hFm1Q@hirez.programming.kicks-ass.net>
 <CAMj1kXE+675mbS66kteKHNfcrco84WTaEL6ncVkkV7tQgbMpFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXE+675mbS66kteKHNfcrco84WTaEL6ncVkkV7tQgbMpFw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ard,

Sorry, I was late to the party, attempting to reply to the entire thread
at once.  Also, adding the live-patching ML.

I agree with a lot of your concerns.  Reverse engineering the control
flow of the compiled binary is kind of ridiculous.  I was always
surprised that it works.  I still am!  But I think it's more robust than
you give it credit for.

Most of the existing code just works, with (annual) tweaks for new
compiler versions.  In fact now it works well with both GCC and Clang,
across several versions.  Soon it will work with LTO.

It has grown many uses beyond stack validation: ORC, static calls,
retpolines validation, noinstr validation, SMAP validation.  It has
found a *lot* of compiler bugs.  And there will probably be more use
cases when we get vmlinux validation running fast enough.

But there is indeed a maintenance burden.  I often ask myself if it's
worth it.  So far the answer has been yes :-)  Particularly because it
has influenced many positive changes to the kernel.  And it helps now
that even more people are contributing and adding useful features.

But you should definitely think twice before letting it loose on your
arch, especially if you have some other way to ensure reliable stack
metadata, and if you don't have a need for the other objtool features.


Regarding your other proposals:

1) I'm doubtful we can ever rely on the toolchain to ensure reliable
   unwind metadata, because:

   a) most of the problems are in asm and inline-asm; good luck getting
      the toolchain to care about those.

   b) the toolchain is fragile; do we want to entrust the integrity of
      live patching to the compiler's frame pointer generation (or other
      unwind metadata) without having some sort of checking mechanism?


2) The shadow stack idea sounds promising -- how hard would it be to
   make a prototype reliable unwinder?


More comments below:


On Thu, Jan 21, 2021 at 12:48:43PM +0100, Ard Biesheuvel wrote:
> On Thu, 21 Jan 2021 at 12:23, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jan 21, 2021 at 12:08:23PM +0100, Ard Biesheuvel wrote:
> > > On Thu, 21 Jan 2021 at 11:26, Julien Thierry <jthierry@redhat.com> wrote:
> >
> > > > I'm not familiar with toolcahin code models, but would this approach be
> > > > able to validate assembly code (either inline or in assembly files?)
> > > >
> > >
> > > No, it would not. But those files are part of the code base, and can
> > > be reviewed and audited.
> >
> > x86 has a long history if failing at exactly that.
> 
> That's a fair point. But on the flip side, maintaining objtool does
> not look like it has been a walk in the park either.

I think you missed Peter's point: it's not that it's *hard* for humans
to continuously review/audit all asm and inline-asm; it's just not
feasible to do it 100% correctly, 100% of the time.

Like any other code, objtool requires maintenance, but its analysis is
orders of magnitude more robust than any human.

> What i am especially concerned about is things like 3193c0836f20,
> where we actually have to disable certain compiler optimizations
> because they interfere with objtool's ability to understand the
> resulting object code. Correctness and performance are challenging
> enough as requirements for generated code.

Well, you managed to find the worst case scenario.  I think that's the
only time we ever had to do that.  Please don't think that's normal, or
even a generally realistic concern.  Objtool tries really hard to stay
out of the way.

Long term we really want to prevent that type of thing with the help of
annotations from compiler plugins, similar to what Julien did here.

Yes, it would mean two objtool compiler plugins (GCC and Clang), but it
would ease the objtool maintenance burden and risk in many ways.  And
prevent situations like that commit you found.  It may sound fragile,
but it will actually make things simpler overall: less reverse
engineering of GCC switch jump tables and __noreturn functions is a good
thing.

> Mind you, I am not saying it is not worth it *for x86*, where there is
> a lot of other stuff going on. But on arm64, we don't care about ORC,
> about -fomit-frame-pointer, about retpolines or about any of the other
> things objtool enables.
> 
> On arm64, all it currently seems to provide is a way to capture the
> call stack accurately, and given that it needs a GCC plugin for this
> (which needs to be maintained as well, which is non-trivial, and also
> bars us from using objtool with Clang builds), my current position is
> simply that opening this can of worms at this point is just not worth
> it.

As far as GCC plugins go, it looks pretty basic to me.  Also this
doesn't *at all* prevent Clang from being used for live patching.  If
anybody actually tries running Julien's patches on a Clang-built kernel,
it might just work.  But if not, and the switch tables turn out to be
unparseable like on GCC, we could have a Clang plugin.  As I mentioned,
we'll probably end up having one anyway for x86.

-- 
Josh

