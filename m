Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738AD300F19
	for <lists+linux-efi@lfdr.de>; Fri, 22 Jan 2021 22:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbhAVVoL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Jan 2021 16:44:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbhAVVoC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 22 Jan 2021 16:44:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3120423B16;
        Fri, 22 Jan 2021 21:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611351801;
        bh=4zgFPmNOA6Z8GIxzLMjysWTP/oCdezevQw0xEahBAsA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CXd4x7iEHCVN5ZsizwrnzwJGYVucGmzALp3G+4rLBnPt1ANLZOrnOEjJszqBEYi9z
         COuY6KOzETtjM1kti6w1hsDxNeNzEjMMBmk1jiMFqh6AgMJiJtMVJa8x+1D2ttxGr3
         aV/81atPpL3pMMoAkc65hISs9NJH7JqIL27o+aQ1HlU28sGm8/W08A9DpAOfDeSsY/
         lHubXXzgz6Psrz1h/WkbJDMJc0ket6vqVgO1jlf9cssAyWvpDQs7B9UC+8C72A2IBd
         s5dyqdPotHBN1FIGezYKWrMIF//KGE1CpSyHYWA8+OA9ZmPcICtBtGC4Jgy6SnmfTZ
         85V/qw7b5dZRw==
Received: by mail-ot1-f51.google.com with SMTP id k8so6559756otr.8;
        Fri, 22 Jan 2021 13:43:21 -0800 (PST)
X-Gm-Message-State: AOAM531/SXB6EYagnQhXgqqX2w9RBa+gLbE/7hsAm/9PTdPsMFiDKQ89
        UDiefPdTstur01hyeZvDcQXM7grfcMD3U4QXd3k=
X-Google-Smtp-Source: ABdhPJztJ/vx8ZiY499xWS74B0H/9rFD38jvmEZAZhqoA9zqNEi5OcM2eA9ev0koSTU4/tuvfE5IDLuU7GkGyU+SyWs=
X-Received: by 2002:a05:6830:1614:: with SMTP id g20mr4782667otr.77.1611351800518;
 Fri, 22 Jan 2021 13:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20210120173800.1660730-1-jthierry@redhat.com> <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
 <186bb660-6e70-6bbf-4e96-1894799c79ce@redhat.com> <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
 <YAlkOFwkb6/hFm1Q@hirez.programming.kicks-ass.net> <CAMj1kXE+675mbS66kteKHNfcrco84WTaEL6ncVkkV7tQgbMpFw@mail.gmail.com>
 <20210121185452.fxoz4ehqfv75bdzq@treble> <20210122174342.GG6391@sirena.org.uk>
 <bebccb15-1195-c004-923e-74d8444250e1@linux.microsoft.com>
In-Reply-To: <bebccb15-1195-c004-923e-74d8444250e1@linux.microsoft.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 22 Jan 2021 22:43:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFr0wvx-hG6nBY4ibju9ww4x0CGhQber3MZQ2ZZn9LHWw@mail.gmail.com>
Message-ID: <CAMj1kXFr0wvx-hG6nBY4ibju9ww4x0CGhQber3MZQ2ZZn9LHWw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 22 Jan 2021 at 22:15, Madhavan T. Venkataraman
<madvenka@linux.microsoft.com> wrote:
>
>
>
> On 1/22/21 11:43 AM, Mark Brown wrote:
> > On Thu, Jan 21, 2021 at 12:54:52PM -0600, Josh Poimboeuf wrote:
> >
> >> 2) The shadow stack idea sounds promising -- how hard would it be to
> >>    make a prototype reliable unwinder?
> >
> > In theory it doesn't look too hard and I can't see a particular reason
> > not to try doing this - there's going to be edge cases but hopefully for
> > reliable stack trace they're all in areas where we would be happy to
> > just decide the stack isn't reliable anyway, things like nesting which
> > allocates separate shadow stacks for each nested level for example.
> > I'll take a look.
> >
>
> I am a new comer to this discussion and I am learning. Just have some
> questions. Pardon me if they are obvious or if they have already been
> asked and answered.
>
> Doesn't Clang already have support for a shadow stack implementation for ARM64?
> We could take a look at how Clang does it.
>
> Will there not be a significant performance hit? May be, some of it can be
> mitigated by using a parallel shadow stack rather than a compact one.
>
> Are there any longjmp style situations in the kernel where the stack is
> unwound by several frames? In these cases, the shadow stack must be unwound
> accordingly.
>

Hello Madhavan,

Let's discuss the details of shadow call stacks on a separate thread,
instead of further hijacking Julien's series.
