Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B98300A80
	for <lists+linux-efi@lfdr.de>; Fri, 22 Jan 2021 19:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbhAVR7M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Jan 2021 12:59:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730010AbhAVRzk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 22 Jan 2021 12:55:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECA2423AC8;
        Fri, 22 Jan 2021 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611338096;
        bh=AYFiX4zVoFw1zc21BTNTrpcrcdxIXokJIpPNH+bgg4o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M/RdoYta0yYvxyxrVm1MwF9jMowYeci9nw51o8xr81Rrjxay9o6aIN0uHyLNYLz23
         jqVK5Evzma3qJfNbOgcyeEqy3QqtoqYYOl9GXHIc/IkjzjRhOZpljDFyAcV24iAJq5
         o8wT+0ox1CBYBIFCBppwxMBmQgNoLdzN28/VcW5lBj7pyNbCaKeN0B2kvFGGuxdim1
         OQiNbQVwuLvpEP37uUJFjsXM0U/ZGtjvEwVRGsHoYeFJe03N4tQbb1kh3Rd+uo0OTD
         M5fQ+embtPzr1N7lS4XBBkAsM1fcBJ/5SYH77ZFIo/HArEQSlVq3yBgZc/6u12BBxl
         Ft29gIcXrW0Fg==
Received: by mail-ot1-f43.google.com with SMTP id 36so5914549otp.2;
        Fri, 22 Jan 2021 09:54:55 -0800 (PST)
X-Gm-Message-State: AOAM533AH0+us2U3skTvQu9mNZa0SmmQLesuX1jQBfmDa8IikwSSi589
        zAWxi20wc2K/3w2/yh2EY1MCwkBp8YeKRKQhmf0=
X-Google-Smtp-Source: ABdhPJx0hc/N3OuLdXaocPstvcNOS7WFFfWzpNbqXVjBFk/Ywwb2F+cfkQeYh8iEnYVpre/A5EJl/hugMJ1hMmEibHA=
X-Received: by 2002:a05:6830:1158:: with SMTP id x24mr4118875otq.108.1611338095288;
 Fri, 22 Jan 2021 09:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20210120173800.1660730-1-jthierry@redhat.com> <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
 <186bb660-6e70-6bbf-4e96-1894799c79ce@redhat.com> <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
 <YAlkOFwkb6/hFm1Q@hirez.programming.kicks-ass.net> <CAMj1kXE+675mbS66kteKHNfcrco84WTaEL6ncVkkV7tQgbMpFw@mail.gmail.com>
 <20210121185452.fxoz4ehqfv75bdzq@treble> <20210122174342.GG6391@sirena.org.uk>
In-Reply-To: <20210122174342.GG6391@sirena.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 22 Jan 2021 18:54:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF31FxCTbo4M8MX0aaegaq7AQXMUdCtsm6xrKUFSpkzjA@mail.gmail.com>
Message-ID: <CAMj1kXF31FxCTbo4M8MX0aaegaq7AQXMUdCtsm6xrKUFSpkzjA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
To:     Mark Brown <broonie@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 22 Jan 2021 at 18:44, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jan 21, 2021 at 12:54:52PM -0600, Josh Poimboeuf wrote:
>
> > 2) The shadow stack idea sounds promising -- how hard would it be to
> >    make a prototype reliable unwinder?
>
> In theory it doesn't look too hard and I can't see a particular reason
> not to try doing this - there's going to be edge cases but hopefully for
> reliable stack trace they're all in areas where we would be happy to
> just decide the stack isn't reliable anyway, things like nesting which
> allocates separate shadow stacks for each nested level for example.
> I'll take a look.

This reminds me - a while ago, I had a stab at writing a rudimentary
GCC plugin that pushes/pops return addresses to a shadow call stack
pointed to by x18 [0]
I am by no means suggesting that we should rely on a GCC plugin for
this, only that it does seem rather straight-forward for the compiler
to manage a stack with return addresses like that (although the devil
is probably in the details, as usual)

[0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm64-scs-gcc
