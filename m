Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68E0302DA4
	for <lists+linux-efi@lfdr.de>; Mon, 25 Jan 2021 22:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbhAYV22 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Jan 2021 16:28:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732663AbhAYVVI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Jan 2021 16:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611609577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gfg/hxSYIFb+RC3VgIgWh3IEpOrZKtS57wEA5wqW8hY=;
        b=SwrOybOEYPAvJyWi5Pq0PABaqgnKcCC6JQEZ8govD8xx30nstLKZbSqHLjcqvbW0zAEizW
        CjjzWtpu1Amo4u5nipfn3YJScJFgEqY2LMj+6ka6tUo4dkzzOPmJ398R4OmafxRwdLiEJW
        AJc2ygXWhPvF/gc+XEwmTBrAo1IHJS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-7J9p8aPkNCeVG5QgMZHZjg-1; Mon, 25 Jan 2021 16:19:35 -0500
X-MC-Unique: 7J9p8aPkNCeVG5QgMZHZjg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 133E710054FF;
        Mon, 25 Jan 2021 21:19:33 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23F015D6AB;
        Mon, 25 Jan 2021 21:19:31 +0000 (UTC)
Date:   Mon, 25 Jan 2021 15:19:29 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Julien Thierry <jthierry@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org, live-patching@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
Message-ID: <20210125211929.62e6gzvl54hpmwn2@treble>
References: <20210120173800.1660730-1-jthierry@redhat.com>
 <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
 <186bb660-6e70-6bbf-4e96-1894799c79ce@redhat.com>
 <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
 <YAlkOFwkb6/hFm1Q@hirez.programming.kicks-ass.net>
 <CAMj1kXE+675mbS66kteKHNfcrco84WTaEL6ncVkkV7tQgbMpFw@mail.gmail.com>
 <20210121185452.fxoz4ehqfv75bdzq@treble>
 <20210122174342.GG6391@sirena.org.uk>
 <bebccb15-1195-c004-923e-74d8444250e1@linux.microsoft.com>
 <CAMj1kXFr0wvx-hG6nBY4ibju9ww4x0CGhQber3MZQ2ZZn9LHWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFr0wvx-hG6nBY4ibju9ww4x0CGhQber3MZQ2ZZn9LHWw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 22, 2021 at 10:43:09PM +0100, Ard Biesheuvel wrote:
> On Fri, 22 Jan 2021 at 22:15, Madhavan T. Venkataraman <madvenka@linux.microsoft.com> wrote:
> > On 1/22/21 11:43 AM, Mark Brown wrote:
> > > On Thu, Jan 21, 2021 at 12:54:52PM -0600, Josh Poimboeuf wrote:
> > >
> > >> 2) The shadow stack idea sounds promising -- how hard would it be to
> > >>    make a prototype reliable unwinder?
> > >
> > > In theory it doesn't look too hard and I can't see a particular reason
> > > not to try doing this - there's going to be edge cases but hopefully for
> > > reliable stack trace they're all in areas where we would be happy to
> > > just decide the stack isn't reliable anyway, things like nesting which
> > > allocates separate shadow stacks for each nested level for example.
> > > I'll take a look.
> > >
> >
> > I am a new comer to this discussion and I am learning. Just have some
> > questions. Pardon me if they are obvious or if they have already been
> > asked and answered.
> >
> > Doesn't Clang already have support for a shadow stack implementation for ARM64?
> > We could take a look at how Clang does it.
> >
> > Will there not be a significant performance hit? May be, some of it can be
> > mitigated by using a parallel shadow stack rather than a compact one.
> >
> > Are there any longjmp style situations in the kernel where the stack is
> > unwound by several frames? In these cases, the shadow stack must be unwound
> > accordingly.
> >
> 
> Hello Madhavan,
> 
> Let's discuss the details of shadow call stacks on a separate thread,
> instead of further hijacking Julien's series.

It's quite relevant to this thread.  There's no need to consider merging
Julien's patches if you have a better approach.  Why not discuss it
here?  I'm also interested in the answers to Madhavan's questions.

-- 
Josh

