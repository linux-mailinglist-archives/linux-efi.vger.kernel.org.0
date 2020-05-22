Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD8E1DEC8B
	for <lists+linux-efi@lfdr.de>; Fri, 22 May 2020 17:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgEVPym (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 May 2020 11:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:32914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730751AbgEVPyl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 22 May 2020 11:54:41 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA54E207F9
        for <linux-efi@vger.kernel.org>; Fri, 22 May 2020 15:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590162880;
        bh=/qaAye3tFTexz1Cmh4OcZDtmH3EqRX9XUKUchbLHn2E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=orRgHtSyxOr//hZynG2qFEVcm1x6HwLdawuSU+QFXXc0Pa9ERZUmCZiOR0b0w8t+X
         DwzYtuwRggai6n0OmwxPr7C9d3ULj+K9RMaYN7aExN7i8/gLtgkPu4Nuvi0zy0jD1P
         /ybSRblKMrs2YoAnzu+YtpBAOHGRLGAyCzAUX9oc=
Received: by mail-il1-f182.google.com with SMTP id n11so11149952ilj.4
        for <linux-efi@vger.kernel.org>; Fri, 22 May 2020 08:54:40 -0700 (PDT)
X-Gm-Message-State: AOAM533NVlRZVK7NmcNgcfylsjYkKLpW1XAqnWIsCYf9DD5vZ9/rUIXl
        xhglPdyRNYYOHSE8LjK5Mgdlj9RchlBWJacrpXY=
X-Google-Smtp-Source: ABdhPJwPhuwBRWGhR5b4bNtRy6xodW8u0m5Vf2OUx0nK1jkb2Dg8EjjvuHy1KZtpMei1MDKaIjsdqAqrpcy6XdA3kag=
X-Received: by 2002:a92:5ec1:: with SMTP id f62mr11330415ilg.80.1590162880279;
 Fri, 22 May 2020 08:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200520182010.242489-1-maskray@google.com> <202005211942.6E5061433@keescook>
 <CA+icZUU58cY31rUYveXAwoQGmJjZf8C_zbBxA+8E5aquWQaScg@mail.gmail.com>
In-Reply-To: <CA+icZUU58cY31rUYveXAwoQGmJjZf8C_zbBxA+8E5aquWQaScg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 22 May 2020 17:54:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFOdTcsqZB0jPMXLRYaQJLsHjTRp+_c0DQqDxLkgb163g@mail.gmail.com>
Message-ID: <CAMj1kXFOdTcsqZB0jPMXLRYaQJLsHjTRp+_c0DQqDxLkgb163g@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Discard .discard.unreachable for arch/x86/boot/compressed/vmlinux
To:     sedat.dilek@gmail.com
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>, X86 ML <x86@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 22 May 2020 at 08:51, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, May 22, 2020 at 4:43 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, May 20, 2020 at 11:20:10AM -0700, 'Fangrui Song' via Clang Built Linux wrote:
> > > In the latest efi tree, ce5e3f909fc0ed67e58367b9c56a54c20a51080b
> > > "efi/printf: Add 64-bit and 8-bit integer support",
> > > arch/x86/boot/compressed/vmlinux may have an undesired
> > > .discard.unreachable section from drivers/firmware/efi/libstub/vsprintf.stub.o
> > >
> > > .discard.unreachable contains an R_X86_64_PC32 relocation, which will be
> > > warned by LLD: a non-SHF_ALLOC section (.discard.unreachable) is not
> > > part of the memory image, thus conceptually the distance between a
> > > non-SHF_ALLOC and a SHF_ALLOC is not a constant which can be resolved at
> > > link time.
> > >
> > > % ld.lld -m elf_x86_64 -T arch/x86/boot/compressed/vmlinux.lds ... -o arch/x86/boot/compressed/vmlinux
> > > ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''
> > >
> > > Reuse the DISCARDS macro which includes .discard.* to drop .discard.unreachable
> > >
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Signed-off-by: Fangrui Song <maskray@google.com>
> >
> > Yay macro usage! :)
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
>
> Feel free to add...
>
>    Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # build and boot on
> Linux v5.7-rc6+ with Clang and LLD v10.0.1-rc1
>
> ...together with one more patches in the x86/boot area:
>
> x86/boot: Correct relocation destination on old linkers
>
> Next run will include:
>
> x86/boot: Add .text.startup to setup.ld (v2)
>
> - Sedat -
>
> [1] https://github.com/llvm/llvm-project/releases/tag/llvmorg-10.0.1-rc1

Thanks, I'll queue this up.
