Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48CC20DEDA
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jun 2020 23:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733310AbgF2U3v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Jun 2020 16:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732239AbgF2U3u (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Jun 2020 16:29:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9D9C061755
        for <linux-efi@vger.kernel.org>; Mon, 29 Jun 2020 13:29:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u5so8386970pfn.7
        for <linux-efi@vger.kernel.org>; Mon, 29 Jun 2020 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1nXbjmGuO9YghPzUiSigrzs5/9GT5Q6NNhUBnZ5BL6o=;
        b=eQJ4C1Og5DxGMyP8fWLcdR8Z3CwksZFnIGnuQop7YqAIDkKSYG4ONb22hCetVI2dMa
         XlTHs1YnKZwKbNTsc1vYgLQApn6CEsy11cVvAH0W8MA9tpog/jILDFawLHvAbnz6wbLc
         MOr/DpyFN5amUZuAcTF6xCkw3l5ZA5IZ2aVkLt4pQ4hbAulAODM2O4kjrlBTBDFdFrsk
         HN+QhWO3ClmIpA86xpuWF6l/Rt/cKlJGag5/A6V0kEXZvqbq1uaiEQ7D74BMh9YiBgqt
         uN/F18cFPt8yiVVK3bgo2KkS/XgGaS4veeK+BkZYPP8LfdLBnFFHKYruXHYXkltdQrqW
         5tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nXbjmGuO9YghPzUiSigrzs5/9GT5Q6NNhUBnZ5BL6o=;
        b=GdnjHE/eGEt3xhZvh2dxiwqb0hLDNUQQAlubkdKmDSZQhF9hrEZDoDhp0ea9YZUgcD
         mHy9ioVp2D738uRyl6KS2DL77xQk46/QNaMGPuFJiD5ogk5n8DcOgVaezkJO7l+5mVy4
         1ZldeWAo8X+OOI5sR9RYTi+rj46tWe1m01Ayfv9ZZrrSlWtQ0FJCw7U162rZSXPzIZY9
         D9C9uIvYy6VnvNMYRWWDL7o5Lmadc+tdDqAszS/uuXhM931FYRJD9Ymuv4hsTQDybfV3
         NFV1Sz4F145sjrgtCDdf5p/orx4mHaTBMq9hRUhL38vSYI1lnqalFhPpadQSAzjJwI+K
         W0bQ==
X-Gm-Message-State: AOAM531WssWU3ZoLwMaAbH4yDcohAa+rZYmZI31Z7+Vef+oLn69CsuWh
        OAHlWQwI1MFdUYXaYbPr39ujIT/pGL2DavqAbucDEg==
X-Google-Smtp-Source: ABdhPJwv6SUxAiJU3OMeQLtrnFcvI/h1iY82pIlt6qbyAGsh50kqhWEDWLaUBKiAJzLF7/INflMcJGpqQT2M4cbcb6s=
X-Received: by 2002:a05:6a00:15ca:: with SMTP id o10mr16122175pfu.169.1593462589513;
 Mon, 29 Jun 2020 13:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-9-keescook@chromium.org> <CAKwvOd=r6bsBfSZxVYrnbm1Utq==ApWBDjx+0Fxsm90Aq3Jghw@mail.gmail.com>
 <9b7f9c3aed7223e49def6e775d3b250aa780e562.camel@perches.com>
In-Reply-To: <9b7f9c3aed7223e49def6e775d3b250aa780e562.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jun 2020 13:29:38 -0700
Message-ID: <CAKwvOdnOCEZ8LUEY6+gVcTcNuaabRnj4hXG6-pcb_6fcQJsr6w@mail.gmail.com>
Subject: Re: [PATCH v4 08/17] arm64/mm: Remove needless section quotes
To:     Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 29, 2020 at 1:03 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-06-29 at 12:53 -0700, Nick Desaulniers wrote:
> > On Sun, Jun 28, 2020 at 11:18 PM Kees Cook <keescook@chromium.org> wrote:
> > > Fix a case of needless quotes in __section(), which Clang doesn't like.
> > >
> > > Acked-by: Will Deacon <will@kernel.org>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Yep, I remember bugs from this.  Probably should scan the kernel for
> > other instances of this.  +Joe for checkpatch.pl validation.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> $ git grep -P -n '__section\s*\(\s*\"'
> arch/arm64/mm/mmu.c:45:u64 __section(".mmuoff.data.write") vabits_actual;
> include/linux/compiler.h:211:   __section("___kentry" "+" #sym )                        \
> include/linux/export.h:133:     static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
> include/linux/srcutree.h:127:           __section("___srcu_struct_ptrs") = &name
>
> My recollection is I submitted a patch
> to _add_ quotes
>
> https://lore.kernel.org/patchwork/patch/1125785/

Hey, yeah!  Did you end up sending v2?

-- 
Thanks,
~Nick Desaulniers
