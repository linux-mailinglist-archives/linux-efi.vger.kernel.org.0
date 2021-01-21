Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCF62FE86C
	for <lists+linux-efi@lfdr.de>; Thu, 21 Jan 2021 12:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbhAULJ7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Jan 2021 06:09:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730129AbhAULJX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 21 Jan 2021 06:09:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C5782389B;
        Thu, 21 Jan 2021 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611227315;
        bh=YQUmONjuFJfQO3+w3c69Q/thFfuiexPRidAAdRiu/4I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eXsK4ulUYoxTk2pQDYKWUxkjrwfPKGUU+526ZmV12ldwenmvaBFJm9xAf7vl4HmiN
         mFHBBRKQp3StANweprRkvkcZCxpsEgmJevxTsqvsc/u/HRSHcnoOfQ8RNyceGtc2Ip
         hZmSUbNggiykJW5f6E8dyfluFZrTG4wt6wie0rgunTXkTfusziwCc72mPRlX9ZcFRf
         7EOdVIY9O0IO4pLA1hPmT1/0sA99AypH9VMTq5xlsQX9yfj2467cjGdnd4xyKE9bpU
         k1ABQFVHib30JVqtkfEakqEBnp5ye9s4atmS6/BJiXDOExGDuYsojPVhQRhgGiLR/m
         bhwVZi02T/tug==
Received: by mail-ot1-f43.google.com with SMTP id a109so1239068otc.1;
        Thu, 21 Jan 2021 03:08:35 -0800 (PST)
X-Gm-Message-State: AOAM533bLKqLTttwxTMy5O5YbSRDy+lDlYw7SYtiE+YihQ9xrFL6sROY
        ACIPGN8XWApAPc7t2RY31+UFo3c0mNiQf8OIRzA=
X-Google-Smtp-Source: ABdhPJwo2sFPs6RxXt98HDUEvN5NXptXToyY/QAZPOw9C1WUrfbLg/W7/BItjqYOvcV42L8f95DMK9wF2/uOi/M9Z1U=
X-Received: by 2002:a05:6830:1614:: with SMTP id g20mr4176607otr.77.1611227314720;
 Thu, 21 Jan 2021 03:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20210120173800.1660730-1-jthierry@redhat.com> <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
 <186bb660-6e70-6bbf-4e96-1894799c79ce@redhat.com>
In-Reply-To: <186bb660-6e70-6bbf-4e96-1894799c79ce@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 21 Jan 2021 12:08:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
Message-ID: <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 21 Jan 2021 at 11:26, Julien Thierry <jthierry@redhat.com> wrote:
>
> Hi Ard,
>
> On 1/21/21 10:03 AM, Ard Biesheuvel wrote:
> > Hello Julien,
> >
> > On Wed, 20 Jan 2021 at 18:38, Julien Thierry <jthierry@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> This series enables objtool to start doing stack validation on arm64
> >> kernel builds.
> >
> > Could we elaborate on this point, please? 'Stack validation' means
> > getting an accurate picture of all kernel code that will be executed
> > at some point in the future, due to the fact that there are stack
> > frames pointing to them. And this ability is essential in order to do
> > live patching safely?
> >
> > If this is the goal, I wonder whether this is the right approach for
> > arm64 (or for any other architecture, for that matter)
> >
> > Parsing/decoding the object code and even worse, relying on GCC
> > plugins to annotate some of the idioms as they are being generated, in
> > order to infer intent on the part of the compiler goes *way* beyond
> > what we should be comfortable with. The whole point of this exercise
> > is to guarantee that there are no false positives when it comes to
> > deciding whether the kernel is in a live patchable state, and I don't
> > see how we can ever provide such a guarantee when it is built on such
> > a fragile foundation.
> >
> > If we want to ensure that the stack contents are always an accurate
> > reflection of the real call stack, we should work with the toolchain
> > folks to identify issues that may interfere with this, and implement
> > controls over these behaviors that we can decide to use in the build.
> > In the past, I have already proposed adding a 'kernel' code model to
> > the AArch64 compiler that guarantees certain things, such as adrp/add
> > for symbol references, and no GOT indirections for position
> > independent code. Inhibiting optimizations that may impact our ability
> > to infer the real call stack from the stack contents is something we
> > might add here as well.
> >
>
> I'm not familiar with toolcahin code models, but would this approach be
> able to validate assembly code (either inline or in assembly files?)
>

No, it would not. But those files are part of the code base, and can
be reviewed and audited.

> > Another thing that occurred to me is that inferring which kernel code
> > is actually live in terms of pending function returns could be
> > inferred much more easily from a shadow call stack, which is a thing
> > we already implement for Clang builds.
> >
>
> I was not familiar with the shadow call stack. If I understand correctly
> that would be a stack of return addresses of function currently on the
> call stack, is that correct?
>
> That would indeed be a simpler approach, however I guess the
> instrumentation has a cost. Is the instrumentation also available with
> GCC? And is this instrumentation efficient enough to be suitable for
> production builds?
>

I am not aware of any plans to enable this in GCC, but the Clang
implementation is definitely intended for production use (it's a CFI
feature for ROP/JOP mitigation)

> If we can rely on shadow call stack to implement the reliable unwinder,
> I guess this could be the way to go.
>
> > In summary, I would not be in favor of enabling objtool on arm64 at
> > all until we have exhausted other options for providing the
> > functionality that we need it for (given that objtool provides many
> > other things that only x86 cares about, IIUC)
> >
> I understand the concern and appreciate the suggestion. I guess this
> does need some thorough discussions for the right approach.
>

Agreed.
