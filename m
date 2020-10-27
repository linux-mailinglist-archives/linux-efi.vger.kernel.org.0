Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F6029CA44
	for <lists+linux-efi@lfdr.de>; Tue, 27 Oct 2020 21:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1797070AbgJ0Ugc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Oct 2020 16:36:32 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36853 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbgJ0Ugc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Oct 2020 16:36:32 -0400
Received: by mail-pj1-f65.google.com with SMTP id d22so1345857pjz.1
        for <linux-efi@vger.kernel.org>; Tue, 27 Oct 2020 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=33VjU+F7xAlvSJckVmNE4QUId8MWatGSN2KXkENeBPE=;
        b=La6FRGr/jeDbtsIvtAxz+uiQhOjm4dAyWcaXp8Bqngku+6eQxP7PosB8B+goA+kSqN
         vre0Yh4pGYryxRzhBbj4WTAawGpKZXq8Q+xPmH9Zynqe3X5rtfcpPxwKfvRLiasuYvJS
         lYVbQeLtj9n49BX32DstNGop1I1QBd0qFZjDtslG4IJ5dZyxg+g7qbQ4zI31ec4EwbA/
         ZDtEGqpX1SibS06EBpU+DuE1qpkKhWs8jccGCYiXAGNMeadZ88esGcIw/ZBfVFgKEPFv
         rJT1EKacmQ+dYTEVHzy4S9Kf5DJX2+4TgmZ5Kqv74555mr4NtUjjpGWRLdH1y4keHXjw
         pSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=33VjU+F7xAlvSJckVmNE4QUId8MWatGSN2KXkENeBPE=;
        b=U4bBvgCHyH6RAzIN8pWizKaqNBXmcnSE5/DhAK5MaeYSOHa2IRnX+L/yHYChFQhmgd
         1gM5lBJQ8cEWrqDtiQ/2qIbkkdmnz/o8cFasb2/U6tRE3lV0Fc3oGwu1z9bBTbwYLLZv
         xs+5rrJThSdawbFNCkynnGRvUSPSqK8OAnaaFtOjyVrr0Bdmf3Nv/luXrFoH8ETdJpKG
         Rsz3pd1QQOJMH7sT+Lzy97NBi2/P6KGgaK8WCEl5F7ZSlnTcWz5ZMLaqoTGD1G9s5eMM
         lGFPrKiz4fkpgI64MSnR+cFe0bthBbJXc7OwukeAPV+QBoSel/w1ruxj6/tg1YUmQfC9
         Eypw==
X-Gm-Message-State: AOAM530si3FWGJXLSn9zZGfnLmhcQ6gQpP1CTn88htrV3AXH1o+44LGG
        RTjb+MN0sqZsmSGYBXzFJTY8AzdezNTWSbNSCQMYsw==
X-Google-Smtp-Source: ABdhPJyYjkI+PB3DKa7DZijWYM08uiHSD3LXT+KkzFwyEX8TmBIceh63CEoOK884l4tYvAjukIuxCjNXYggMXH//kmc=
X-Received: by 2002:a17:90a:6b04:: with SMTP id v4mr3652441pjj.101.1603830991134;
 Tue, 27 Oct 2020 13:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
 <CAMuHMdV4jKccjKkoj38EFC-5yN99pBvthFyrX81EG4GpassZwA@mail.gmail.com>
 <CAKwvOdkq3ZwW+FEui1Wtj_dWBevi0Mrt4fHa4oiMZTUZKOMi3g@mail.gmail.com>
 <CAMuHMdUDOzJbzf=0jom9dnSzkC+dkMdkyY_BOBMAivbJfF+Gmg@mail.gmail.com>
 <CAKwvOdkE=ViGOhvoBRcV=9anjowC_vb4Vtefp9010+sC4c_+Sw@mail.gmail.com>
 <CAMj1kXEhcQ_ngNVWddV76NqEz6d0tDhfStYGd5diydefzVLvdQ@mail.gmail.com>
 <CAKwvOdm9kuKoVnQoVo7T91gRb9QiCTp2G_PnwbdPM=o710Lx5A@mail.gmail.com> <20201027203210.GB1833548@rani.riverdale.lan>
In-Reply-To: <20201027203210.GB1833548@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Oct 2020 13:36:20 -0700
Message-ID: <CAKwvOd=ufk3G8moNb8Z1Ruw9hm1YkynZ5mQNf2k1FsmkXfCJiw@mail.gmail.com>
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 27, 2020 at 1:32 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Oct 27, 2020 at 01:28:02PM -0700, Nick Desaulniers wrote:
> > > commit 3193c0836f203a91bef96d88c64cccf0be090d9c
> > > Author: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Date:   Wed Jul 17 20:36:45 2019 -0500
> > >
> > >     bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()
> > >
> > > has
> > >
> > > Fixes: e55a73251da3 ("bpf: Fix ORC unwinding in non-JIT BPF code")
> > >
> > > and mentions objtool and CONFIG_RETPOLINE.
> >
> > Thanks for the context.  It might be time to revisit the above commit.
> > If I revert it (small conflict that's easy to fixup),
> > kernel/bpf/core.o builds cleanly with defconfig+GCC-9.3, so maybe
> > obtool did get smart enough to handle that case?  Probably regresses
> > the performance of that main dispatch loop for BPF, but not sure what
> > folks are expecting when retpolines are enabled.
> > --
> > Thanks,
> > ~Nick Desaulniers
>
> The objtool issue was with RETPOLINE disabled.

Ah, sorry, in that case default-CONFIG_RETPOLINE+gcc-9.3:
kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x8d4: sibling
call from callable instruction with modified stack frame
-- 
Thanks,
~Nick Desaulniers
