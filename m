Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F87729CA7D
	for <lists+linux-efi@lfdr.de>; Tue, 27 Oct 2020 21:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504899AbgJ0Ukz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Oct 2020 16:40:55 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54346 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504864AbgJ0Ukz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Oct 2020 16:40:55 -0400
Received: by mail-pj1-f68.google.com with SMTP id az3so1401443pjb.4
        for <linux-efi@vger.kernel.org>; Tue, 27 Oct 2020 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XK2vhDOZfiB4rtHPEukgUGdcEQPpZW+i+EIpmvDwIRs=;
        b=iRu6J6h0ewW6b3k9tqtOhXtdCfOgge6iZYHWUcyAkDZ8YOegSkcVDF7gC3k4jPVF7H
         XDmHxVGoKISu5zXOadu/RMA1sFU4O4dAHwEyAtV+S5dU/8uSHiYI9AhEvqJg/UFm9rDK
         BIDEQe/9taUwEg2Aj3iILtgUniZGuwj41StKbFiGsyhl5hhuT0W9rym6qeUxDhs2UxJP
         Q4P1Jnev3zv7MB9JT++IZEz3rD5yJitVI4Bi2H7u64sS1JViNIRkct1S/Gm9foTkzDBW
         qZSbf3cwDZnvzrLr58fzt/JXWm21oFdsR2IgdQ53zTOUk79ToxWZhJE9tzEHuSAF7EiG
         9BkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XK2vhDOZfiB4rtHPEukgUGdcEQPpZW+i+EIpmvDwIRs=;
        b=kUe9xiPo2fqoXmBYc81LsxNvnXeiYv9+sHwB/Eg27fzUi2cdHADeYke1+VjJr5120o
         +uOIDqhPsM/eXgFcnN2p/TI8wooo29CgL1XQS190OwfSVgr/Hfr1wx2NxRX5GdEMSiNI
         xguHFkHgiZ669SVlDz7IWgSIp6k8mNXLQjmuEa7mAT2VuelXVJHQQdEe8lxecxo3Kg7C
         HP1RVDHcpUQPNnG0IX8LmyXWNHUgQ3YTiMdIBKMxRq4PgZB85ZXxQuIV/OESQL02CTl5
         xgimUdwciA5yHFGFcK+OqKL6RV9OVLBnK3gLrUwA6ZJvJ7ohZC7d3bvOXHqNMxXJ9i8z
         lLGQ==
X-Gm-Message-State: AOAM533bj9jshcPSbcvujMWQVd2it/i9V2PG3SAWIA/vBjiYTr4VeC+8
        hAf4HJ4LAxDKcSZnse72eS+3D/gS9HuTWNvjRcsTPw==
X-Google-Smtp-Source: ABdhPJyUA+vysDeRt7g/FxOhDlUe9n7QzIQqbpk84eLBA1OnEyJeHMW5A2zLyqWGlfAeg+O+kTmXuUW3uirw5pihg2Y=
X-Received: by 2002:a17:902:db82:b029:d6:3fe4:9825 with SMTP id
 m2-20020a170902db82b02900d63fe49825mr3886001pld.29.1603831254116; Tue, 27 Oct
 2020 13:40:54 -0700 (PDT)
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
 <CAKwvOd=8YO3Vm0DuaWpDigMiwni+fVdrpagZtsROGziinjLvig@mail.gmail.com> <20201027203001.GA1833548@rani.riverdale.lan>
In-Reply-To: <20201027203001.GA1833548@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Oct 2020 13:40:43 -0700
Message-ID: <CAKwvOdmrjeLpS8H_uf_cfbOYFvE-ZhOdJQ14o4VoNF8ugARA0Q@mail.gmail.com>
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
        kernel-toolchains@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 27, 2020 at 1:30 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Oct 27, 2020 at 01:17:55PM -0700, Nick Desaulniers wrote:
> > > >  (I feel the same about there
> > > > being an empty asm(); statement in the definition of asm_volatile_goto
> > > > for compiler-gcc.h).  Might be time to "fix the compiler."
> > > >
> > > > (It sounds like Arvind is both in agreement with my sentiment, and has
> > > > the root cause).
> > > >
> Btw, the bug mentioned in asm_volatile_goto seems like its been fixed in
> 4.9, so the hack could be dropped now?

https://lore.kernel.org/lkml/20180907222109.163802-1-ndesaulniers@google.com/

For the life of me I can't find Linus' response.  Maybe he shot it
down in the PR, but I can't find it...Miguel do you recall?  I could
paraphrase, but might be better to not rely on my memory.
-- 
Thanks,
~Nick Desaulniers
