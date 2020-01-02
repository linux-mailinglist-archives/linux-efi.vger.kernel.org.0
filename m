Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A496912E989
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 18:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgABRtG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 12:49:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38762 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgABRtG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 12:49:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so40057629wrh.5
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 09:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YEMwwjZAvMTp8LOCkFvDi9nu8Ix8F+X8P1H/77LIIc=;
        b=sWKpvNePH6SWHm0O0mL7lqc3reAgzWnUCKR+55PuGrC+2OsAWgDlOXK6yYCCyHChlA
         ft9wZmb/Z5ogVdLg+qoJotpDxZQNra99QrLRwfVdrYbo7oD+cL5wSf4N6jSP55wViikn
         yS0hjbhbe3BXWJa9xEQ1v4DBdXGXzaG75EMtAGPtBUFcfhmIjqy/mvrJHtCgFUgugDje
         pO7/Ozc0fREGyWUNMoptpxrPY2YYtMto759yWUYaKps1+OVkgOj0agCo2gjTYA9p01dA
         zCxOc3xYryIKtjTk+3mHU7lDhFcJHeWzm6LpHFSBtqedW89XiE+duwBKdWkKkGKx6dU0
         Boog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YEMwwjZAvMTp8LOCkFvDi9nu8Ix8F+X8P1H/77LIIc=;
        b=aCOKNCNZwXQyo5N8gHgDngGsrKr10niSJXtPNA9KKdGXzzv3wYPI8NZdbNktlW/1Sz
         87OSnmaNsQgjIdBuI+AKulRC2B23Eok0yadRO57zuOwJPcsvL6Omfo5hNsToFlohMwe+
         /WS1zc+++kMuZA644T341/1tOlNDhdsKDDm2DJ5PvG2Pz0JAtmJNFDIrtEv/g4otQJBA
         RhGVYl/eV6ufbYVXgsLDzly/4GxjnXiTm5dnVvZsHvu1QjeSZVuzlUJkiibC52gGYzwG
         s5bJHtoHRm7glJ+A23DIx+jv+xa7H3uqZTrXchHQyTH9cDYuM0eduuCqjy4GH2wZqGSO
         wPUg==
X-Gm-Message-State: APjAAAXKwDaOKRMzn1I20Dy3t2f5a4vO09pOuQYdjYjOAEcWbibJhyJc
        eaLKWniZYfpd34PO6nubNThVfVC/1tGURoZfm5BveA==
X-Google-Smtp-Source: APXvYqxRdJiplAGrzPObc7DA1tzNuNwScP9j18vYyyRSAY6SZil9KY98wybg1abzwpz9gELjcKmiResVZtdsZpY8+qs=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr72128116wrj.325.1577987343924;
 Thu, 02 Jan 2020 09:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20200101190844.GA208136@rani.riverdale.lan> <CAKv+Gu-XRgRXgiuDEe+DXdcEzOuUWG6fWMO_oa41f2Ugki5kCA@mail.gmail.com>
 <20200102140653.GA626673@rani.riverdale.lan> <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
 <20200102155129.GA668939@rani.riverdale.lan> <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
 <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
 <CAKv+Gu8m5vtJ6_TUgqy-Aa_7FNyhYBx=gsh1c62_impS2G99AQ@mail.gmail.com>
 <20200102172637.GB701372@rani.riverdale.lan> <CAKv+Gu9eEC+yQM1BsLTWLYkxCugVw76-nPQOQ14EavkJHGtcdg@mail.gmail.com>
 <20200102174142.GA713602@rani.riverdale.lan>
In-Reply-To: <20200102174142.GA713602@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 Jan 2020 18:48:52 +0100
Message-ID: <CAKv+Gu-NDps2EP865v45sUbKRwSc2fwvcfLt64BKX_D=ErmvMQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2 Jan 2020 at 18:41, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Jan 02, 2020 at 06:30:46PM +0100, Ard Biesheuvel wrote:
> > On Thu, 2 Jan 2020 at 18:26, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Thu, Jan 02, 2020 at 05:59:27PM +0100, Ard Biesheuvel wrote:
> > > > On Thu, 2 Jan 2020 at 17:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > > >
> > > > > On Thu, 2 Jan 2020 at 16:58, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > > > >
> > > > > > On Thu, 2 Jan 2020 at 16:51, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 02, 2020 at 04:20:46PM +0100, Ard Biesheuvel wrote:
> > > > > > > >
> > > > > > > > Yeah, good point.
> > > > > > > >
> > > > > > > > I pushed as branch here;
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-libstub-attr-const
> > > > > > > >
> > > > > > > > Could you please check if that fixes the issue for efi_is_64bit() ?
> > > > > > >
> > > > > > > Haven't built it yet -- but how does this handle the GOT issues you
> > > > > > > mentioned?
> > > > > >
> > > > > > It doesn't. The trick is to add __attribute__((visibility("hidden")))
> > > > > > to the extern declaration of efi_is64, but I am having trouble to
> > > > > > reproduce the original issue.
> > > > >
> > > > > Some background:
> > > > >
> > > > > https://lore.kernel.org/lkml/5405E186.2080406@canonical.com/
> > > > > https://lore.kernel.org/lkml/20140919104021.GA11552@gmail.com/
> > > >
> > > > OK, I have done a bit more digging, and it seems like recent
> > > > toolchains can optimize away GOT indirections using R_386_GOT32X
> > > > relocations, which can be converted into R_386_GOTOFF relocations by
> > > > the linker if it is building a fully linked binary, making the actual
> > > > contents of the GOT entries irrelevant.
> > > >
> > > > Note that even if the GOT entries are not fixed up, assigning a global
> > > > variable and then using it again may work by accident if the memory it
> > > > points to is writable, which is why it is not easy to reproduce
> > > > reliably.
> > > >
> > > > efi_is64 only exists on 64-bit, so annotating that as 'hidden' should
> > > > work. But efi_system_table() is also used on 32-bit, so I'll leave
> > > > that one alone for now.
> > >
> > > With hidden visibility, 32-bit compiler seems to generate GOTOFF
> > > relocations directly so it shouldn't depend on recent toolchain?
> > >
> > > https://godbolt.org/z/79iA_3
> >
> > Yes, that was my assumption at the time as well, but we still ended up
> > with /some/ absolute GOT dereferences for some reason in the 32-bit
> > kernel.
>
> Do you remember if we ever figured out what was wrong with Matt
> Fleming's patch to fixup the GOT for the EFI stub too?
>

No, I don't think we did. It is simply infeasible to diagnose this on
someone else's laptop who is on the other side of the world.

> For efi_system_table, if we don't want to risk creating GOT entries, one
> option would be to do what you did for is64, but define the wrapper
> function as an out-of-line function in the assembler code and declare it
> const.

Yeah, that would work. It would be for 32-bit only, so we could have a
__weak implementation in C, and an asm one for i386.

Currently, I am not managing to get the 64-bit compiler to emit any
GOT based references for efi_is64, though, even without the attribute,
so I am not sure what's going on there.
