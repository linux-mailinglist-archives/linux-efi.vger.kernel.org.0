Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3325E1DE022
	for <lists+linux-efi@lfdr.de>; Fri, 22 May 2020 08:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgEVGvt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 May 2020 02:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgEVGvt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 May 2020 02:51:49 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE85C061A0E
        for <linux-efi@vger.kernel.org>; Thu, 21 May 2020 23:51:48 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d5so780388ios.9
        for <linux-efi@vger.kernel.org>; Thu, 21 May 2020 23:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=xdvsxmwUKO7Fv5eHUB9PeRikncRekct95ZZzbVNJGJE=;
        b=V6bu6wMyqFsGNsSUKD4b+ZkgKnhlhcieiGZs1OUQvH4dKN+7ftSRu+W6Mj7uiEGv2j
         g9KWP4oi5uYlcae7imZ96CRRg5LFVx90dVVqio+XQPFT5Juayp2474mwkHuT5/2vTgpF
         AL9Pua3bK7aVQQHbN58vPwa/Y2xOhIHOEYkxsNfO0DHh9JzIEIiNoeIrLLQ9yhIwTZ57
         cV5oAmy3JgNIBXru6voreZRAgSU6fOeA+JQYd47cZpsezPxP4ZqKHxpOj/9H/QQ1GEtW
         EG/3vaVuwvPEa+GSwC95Cb4meTM8I8JLASrKg6DEdqarvuEbGLdTUDYOvD3dpIwWdsuT
         jX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=xdvsxmwUKO7Fv5eHUB9PeRikncRekct95ZZzbVNJGJE=;
        b=PqmKqjHKYYnd+a6eFArdpK6OHqHBrWjvU43Gm9WBSz2ONeE+T0YgB7l3L7gf/dAr4T
         knV8AQt7aloNB0lRdGiKFSwc+wDFtckqgXNeIHO/0tIn7b7PqefFH/tRL9wl15waqcdA
         YqLS3LboaqGaIl6aCEs/AKdOpR2TU54h0SDDWacSvndkXE6ymGV6MfTQPSuRelt4UGyF
         vRYca73GjsbJbTwB2Rvw6Zsa30s1FloBEvp09mqOGbsJWRjl9QgqyUT6MychVLSIACBm
         ljwVpEIlS4b5hADsWcKi0pELjeqrYXuYWRFulMMCIbgdhtdzzxbCjhiq3MKm6uvlLQYN
         hjBA==
X-Gm-Message-State: AOAM533EX95DHCyId3SU6tfty4MKloce0sng0AOT1jFCG7S3WctLOgAl
        aXenSOtC0hKIc6D/ot2BZqtYW7pWBnk78nl/pUA=
X-Google-Smtp-Source: ABdhPJzQwdhwl9jqrc5m+oV0AirdLJBaZlQruxsQVKjjpHd/1i5de1mhBZ9kLo7B6/z2SBQjtqrBRO5T9OJDA4S0Lyk=
X-Received: by 2002:a05:6602:1616:: with SMTP id x22mr1967924iow.70.1590130307320;
 Thu, 21 May 2020 23:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200520182010.242489-1-maskray@google.com> <202005211942.6E5061433@keescook>
In-Reply-To: <202005211942.6E5061433@keescook>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 22 May 2020 08:51:35 +0200
Message-ID: <CA+icZUU58cY31rUYveXAwoQGmJjZf8C_zbBxA+8E5aquWQaScg@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Discard .discard.unreachable for arch/x86/boot/compressed/vmlinux
To:     Kees Cook <keescook@chromium.org>
Cc:     Fangrui Song <maskray@google.com>, x86@kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 22, 2020 at 4:43 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, May 20, 2020 at 11:20:10AM -0700, 'Fangrui Song' via Clang Built Linux wrote:
> > In the latest efi tree, ce5e3f909fc0ed67e58367b9c56a54c20a51080b
> > "efi/printf: Add 64-bit and 8-bit integer support",
> > arch/x86/boot/compressed/vmlinux may have an undesired
> > .discard.unreachable section from drivers/firmware/efi/libstub/vsprintf.stub.o
> >
> > .discard.unreachable contains an R_X86_64_PC32 relocation, which will be
> > warned by LLD: a non-SHF_ALLOC section (.discard.unreachable) is not
> > part of the memory image, thus conceptually the distance between a
> > non-SHF_ALLOC and a SHF_ALLOC is not a constant which can be resolved at
> > link time.
> >
> > % ld.lld -m elf_x86_64 -T arch/x86/boot/compressed/vmlinux.lds ... -o arch/x86/boot/compressed/vmlinux
> > ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''
> >
> > Reuse the DISCARDS macro which includes .discard.* to drop .discard.unreachable
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Fangrui Song <maskray@google.com>
>
> Yay macro usage! :)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>

Feel free to add...

   Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # build and boot on
Linux v5.7-rc6+ with Clang and LLD v10.0.1-rc1

...together with one more patches in the x86/boot area:

x86/boot: Correct relocation destination on old linkers

Next run will include:

x86/boot: Add .text.startup to setup.ld (v2)

- Sedat -

[1] https://github.com/llvm/llvm-project/releases/tag/llvmorg-10.0.1-rc1
