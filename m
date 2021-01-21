Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD262FE951
	for <lists+linux-efi@lfdr.de>; Thu, 21 Jan 2021 12:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbhAULuF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Jan 2021 06:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729951AbhAULtl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 21 Jan 2021 06:49:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90D07239D3;
        Thu, 21 Jan 2021 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611229735;
        bh=4LoYAC73s65Y5H0iYwUuGzJLofq3OtSrbEyyV4z/Kog=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oBpyGboZuZUjl523dwPWQwgTBZSYXSYF7piXJkDfjOhUnVt0mpF8tpsy6IyLDmxlw
         qEEdYZQyh7zk9SiuMR9gAne8ettknwKIH/ju5oblc2y0c8cPAUbRYfRSGNlkO0j1m5
         2FEsgxre++Ar5NxlVBxnqODtLjLTLhKARflHZfGoN/TgbXUdsYgKdTh45LAroo4mZ1
         KrNgaP/zIEMCm4OYGIAbJrPzRzEjpubHHEu8KTitI8Y9Di8C5W4rZvaOFat+emLEP9
         CFszvu3uSFjl4ka4jogtXmDQEiwwvM0XQJx+6s9dFEcoSFPXRNu8TODLF5zOVsnT1c
         Zv/hYiVOlhZrQ==
Received: by mail-ot1-f45.google.com with SMTP id 36so1322264otp.2;
        Thu, 21 Jan 2021 03:48:55 -0800 (PST)
X-Gm-Message-State: AOAM533gRuAtpuHrz4A9DAiBfvMD331Nq3NGfb4Thi7F7IcWhzt4L/Er
        qpo8xB4FjnfFhXyjNReCt/fa7uaOM+Ud7cl8VU8=
X-Google-Smtp-Source: ABdhPJwd56HgLproI09sgiWpE983hjJPCQ2fDWHVcfiofuOXt425n9x+OHdx1ZUjKLrj2FNAoQtyENmXNJ9zYiszajE=
X-Received: by 2002:a05:6830:1e2a:: with SMTP id t10mr4636246otr.90.1611229734707;
 Thu, 21 Jan 2021 03:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20210120173800.1660730-1-jthierry@redhat.com> <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
 <186bb660-6e70-6bbf-4e96-1894799c79ce@redhat.com> <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
 <YAlkOFwkb6/hFm1Q@hirez.programming.kicks-ass.net>
In-Reply-To: <YAlkOFwkb6/hFm1Q@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 21 Jan 2021 12:48:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE+675mbS66kteKHNfcrco84WTaEL6ncVkkV7tQgbMpFw@mail.gmail.com>
Message-ID: <CAMj1kXE+675mbS66kteKHNfcrco84WTaEL6ncVkkV7tQgbMpFw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 21 Jan 2021 at 12:23, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 21, 2021 at 12:08:23PM +0100, Ard Biesheuvel wrote:
> > On Thu, 21 Jan 2021 at 11:26, Julien Thierry <jthierry@redhat.com> wrote:
>
> > > I'm not familiar with toolcahin code models, but would this approach be
> > > able to validate assembly code (either inline or in assembly files?)
> > >
> >
> > No, it would not. But those files are part of the code base, and can
> > be reviewed and audited.
>
> x86 has a long history if failing at exactly that.

That's a fair point. But on the flip side, maintaining objtool does
not look like it has been a walk in the park either.

What i am especially concerned about is things like 3193c0836f20,
where we actually have to disable certain compiler optimizations
because they interfere with objtool's ability to understand the
resulting object code. Correctness and performance are challenging
enough as requirements for generated code.

Mind you, I am not saying it is not worth it *for x86*, where there is
a lot of other stuff going on. But on arm64, we don't care about ORC,
about -fomit-frame-pointer, about retpolines or about any of the other
things objtool enables.

On arm64, all it currently seems to provide is a way to capture the
call stack accurately, and given that it needs a GCC plugin for this
(which needs to be maintained as well, which is non-trivial, and also
bars us from using objtool with Clang builds), my current position is
simply that opening this can of worms at this point is just not worth
it.
