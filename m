Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DB11DEC97
	for <lists+linux-efi@lfdr.de>; Fri, 22 May 2020 17:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgEVP5O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 May 2020 11:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730653AbgEVP5O (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 May 2020 11:57:14 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34D3C061A0E
        for <linux-efi@vger.kernel.org>; Fri, 22 May 2020 08:57:13 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r145so9483827iod.12
        for <linux-efi@vger.kernel.org>; Fri, 22 May 2020 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=cxmtd928o4U9CKANHM8fZpYL8Nm8u9626T6YfVfGbRQ=;
        b=kDCwQkRoU3YHkLdmZhh0FRgBCASaczd9ABJCzT0wE80VCvbN/r6rIEoDh8xAfuiq2i
         DfW1ODV31b4zj4EH96PKxzYmWXDO/QnPDBw+EbTrAWzNEbWMq1z929i8ELFfm3epYw0m
         ttvuDtdVoaT/QFAjasSFnzwOoqO4gfAK3u8jWfvfgozp5x0thNnmXwFgKE0aateDEwGX
         97QOGz7Gq/InhImQQTv8Df0oxVhOk4zpu3lJ56lOm+QaT3bjsXX49YDnCmwH2nXx+uIn
         YjVdu6dRsAuKJs44MBJzsQScZFTza8s7YNXD2nkuuztIqZWVte/tDNvfKVw1xTm+zJcn
         8cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=cxmtd928o4U9CKANHM8fZpYL8Nm8u9626T6YfVfGbRQ=;
        b=tNcJy1PQG1yWr9Jp0wZCAcShwTK+LMqgdLp+w80u8CyA8u4TXXyIlYtF64tlgk28eP
         u1roz2NmkIs4moIqbJyMrjffPTUx39pGP5oFTkVLytCTOh/VzaF/J5hEhsNRXYh0iNdL
         seqTPK6EQvQtLh5wox2Hbi72O8bFfekEaLcD0Vb1z3sGkNjbDZ43dmOe+PJCs2gJBEN4
         wJjm8zT2PlVp+rTe+ApvqD3q7b9fp9VBFASzRAr/fiJRADM3HBVtZAs1GU4FIvdAmbnC
         HpnAls+7nPryuP4ZQps2r0QaPslH1aNv5Y53cKtFyOSiBOx+AMROT0GyoSti4JZgLsH5
         pf4A==
X-Gm-Message-State: AOAM531b7wllTmP+AYmD8RBXzczq+gGzhixUBghImQGMeri3WEKWCdvP
        OVD9Lh+ZOQ5Sre0uFBtO3j4DZNyVgSTULPJhGIU=
X-Google-Smtp-Source: ABdhPJx1OTQctv8kFtlOXG0U9tp0hqdD4im6HZyxDYb+YFm/QCeo4cVWDJr3++6N+14hYlZhgUUGfNxpOxWuy1AIAMQ=
X-Received: by 2002:a05:6602:2f06:: with SMTP id q6mr3634778iow.135.1590163033043;
 Fri, 22 May 2020 08:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200520182010.242489-1-maskray@google.com> <202005211942.6E5061433@keescook>
 <CA+icZUU58cY31rUYveXAwoQGmJjZf8C_zbBxA+8E5aquWQaScg@mail.gmail.com> <CAMj1kXFOdTcsqZB0jPMXLRYaQJLsHjTRp+_c0DQqDxLkgb163g@mail.gmail.com>
In-Reply-To: <CAMj1kXFOdTcsqZB0jPMXLRYaQJLsHjTRp+_c0DQqDxLkgb163g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 22 May 2020 17:57:01 +0200
Message-ID: <CA+icZUXmuJ8rka7zvGRV=eb3tdi_ro5R33o=yncGhRJ2DtB5=Q@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Discard .discard.unreachable for arch/x86/boot/compressed/vmlinux
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Fri, May 22, 2020 at 5:54 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 22 May 2020 at 08:51, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, May 22, 2020 at 4:43 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Wed, May 20, 2020 at 11:20:10AM -0700, 'Fangrui Song' via Clang Built Linux wrote:
> > > > In the latest efi tree, ce5e3f909fc0ed67e58367b9c56a54c20a51080b
> > > > "efi/printf: Add 64-bit and 8-bit integer support",
> > > > arch/x86/boot/compressed/vmlinux may have an undesired
> > > > .discard.unreachable section from drivers/firmware/efi/libstub/vsprintf.stub.o
> > > >
> > > > .discard.unreachable contains an R_X86_64_PC32 relocation, which will be
> > > > warned by LLD: a non-SHF_ALLOC section (.discard.unreachable) is not
> > > > part of the memory image, thus conceptually the distance between a
> > > > non-SHF_ALLOC and a SHF_ALLOC is not a constant which can be resolved at
> > > > link time.
> > > >
> > > > % ld.lld -m elf_x86_64 -T arch/x86/boot/compressed/vmlinux.lds ... -o arch/x86/boot/compressed/vmlinux
> > > > ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''
> > > >
> > > > Reuse the DISCARDS macro which includes .discard.* to drop .discard.unreachable
> > > >
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > Signed-off-by: Fangrui Song <maskray@google.com>
> > >
> > > Yay macro usage! :)
> > >
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > >
> >
> > Feel free to add...
> >
> >    Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # build and boot on
> > Linux v5.7-rc6+ with Clang and LLD v10.0.1-rc1
> >
> > ...together with one more patches in the x86/boot area:
> >
> > x86/boot: Correct relocation destination on old linkers
> >
> > Next run will include:
> >
> > x86/boot: Add .text.startup to setup.ld (v2)
> >
> > - Sedat -
> >
> > [1] https://github.com/llvm/llvm-project/releases/tag/llvmorg-10.0.1-rc1
>
> Thanks, I'll queue this up.

Just FYI:
It's in tip.git#x86/build already.

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/build&id=d6ee6529436a15a0541aff6e1697989ee7dc2c44
