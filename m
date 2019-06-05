Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B42E362FC
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2019 19:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfFERuh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jun 2019 13:50:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40001 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfFERuc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jun 2019 13:50:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so393761pla.7
        for <linux-efi@vger.kernel.org>; Wed, 05 Jun 2019 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69gfPapSEdMi+yvUYn9H/fvtRsee0abVJTNm1kq4LuQ=;
        b=pBEWo0NcAk4QU02NxTDdbliP+YTRia8y0ucJJGA7LQ27Dml7fTz0Jj7L+hvksvcg2l
         +6IqellipsEcoKmeMDdrTqJFm7m0lWacCdNP/p+k0ieaT5Y+8FFdYD3/7betJZ0yMFTR
         FgJBwbPs28J/ge+AbH9zZeGFNqKupC2AzM0Mm0nWibG0fHrmi7G7q5eBkZjYo0xkr+uc
         oonNEwzsr1anDnJzm4Md4Wd0hsQklfvAAxHZKgH3bGpylKvdpqtbFRId2W5hfa5wESvZ
         26WDbHB3TtkefLuqlQ/90mBXhDsrtvXIydkK9xsU6eOy+gWFaMHbAJ5e07OOGRWsKOw9
         SEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69gfPapSEdMi+yvUYn9H/fvtRsee0abVJTNm1kq4LuQ=;
        b=NKHQ25EBzZIAhdzRgH1cEO0BOARa/3YOdKo31gByzDC+AXTkMjjl7lGdOg2FiNwKrZ
         mDUot28hXrEFHUNlYOlahoewzBvJ78KcHh3/61nTRFJlG6WgX5DCL510W1nId0Ye1TNV
         jdePP1flfPwetAXo9qFefle9ucBr4aeWjifUX0IVV7mpzDa1O9INVBpGhoBqKz1PF9XA
         ZTVSqpLgTI8sT+UMG2LuTwrZS6u+CMQncGwf2ouXED5BB2AXCaU7c+MAN49VzUNHHsgg
         HPqweb6IJBRs/92UpcRmmDvIBRIYzNK9MsTSSO61zUZxMJJ0zBWD5G4P/m5WGgnQ7SrN
         M4pQ==
X-Gm-Message-State: APjAAAWz9QbY9mDQxGGUDyhUWf8ZSnkM8oVLfCr5YiSbb3vVzew+m5Iv
        IKajnspZEq3/ttGqhNKYQWndkC04MGQxQmKNfkmnOg==
X-Google-Smtp-Source: APXvYqwLtyAX66huw+EWEn7pqEiSvsjOHxjps51TIKjDTCKg+Rlihh78XZh/riSWS22J7XfNQBK0HViRRXtXzVrELs8=
X-Received: by 2002:a17:902:b696:: with SMTP id c22mr43639929pls.119.1559757030282;
 Wed, 05 Jun 2019 10:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <779905244.a0lJJiZRjM@devpool35> <20190605162626.GA31164@kroah.com>
 <CAKwvOdnegLvkAa+-2uc-GM63HLcucWZtN5OoFvocLs50iLNJLg@mail.gmail.com>
In-Reply-To: <CAKwvOdnegLvkAa+-2uc-GM63HLcucWZtN5OoFvocLs50iLNJLg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Jun 2019 10:50:19 -0700
Message-ID: <CAKwvOdn9g2Z=G_qz84S5xmn2GBNK7T-MWOGYT5C52sP0R=M_-Q@mail.gmail.com>
Subject: Re: Building arm64 EFI stub with -fpie breaks build of 4.9.x
 (undefined reference to `__efistub__GLOBAL_OFFSET_TABLE_')
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rolf Eike Beer <eb@emlix.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Matthias Kaehlcke <mka@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 5, 2019 at 10:27 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Jun 5, 2019 at 9:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 05, 2019 at 05:19:40PM +0200, Rolf Eike Beer wrote:
> > > I decided to dig out a toy project which uses a DragonBoard 410c. This has
> > > been "running" with kernel 4.9, which I would keep this way for unrelated
> > > reasons. The vanilla 4.9 kernel wasn't bootable back then, but it was
> > > buildable, which was good enough.
> > >
> > > Upgrading the kernel to 4.9.180 caused the boot to suddenly fail:
> > >
> > > aarch64-unknown-linux-gnueabi-ld: ./drivers/firmware/efi/libstub/lib.a(arm64-
> > > stub.stub.o): in function `handle_kernel_image':
> > > /tmp/e2/build/linux-4.9.139/drivers/firmware/efi/libstub/arm64-stub.c:63:
> > > undefined reference to `__efistub__GLOBAL_OFFSET_TABLE_'
> > > aarch64-unknown-linux-gnueabi-ld: ./drivers/firmware/efi/libstub/lib.a(arm64-
> > > stub.stub.o): relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol
> > > `__efistub__GLOBAL_OFFSET_TABLE_' which may bind externally can not be used
> > > when making a shared object; recompile with -fPIC
> > > /tmp/e2/build/linux-4.9.139/drivers/firmware/efi/libstub/arm64-stub.c:63:
> > > (.init.text+0xc): dangerous relocation: unsupported relocation
> > > /tmp/e2/build/linux-4.9.139/Makefile:1001: recipe for target 'vmlinux' failed
> > > -make[1]: *** [vmlinux] Error 1
> > >
> > > This is caused by commit 27b5ebf61818749b3568354c64a8ec2d9cd5ecca from
> > > linux-4.9.y (which is 91ee5b21ee026c49e4e7483de69b55b8b47042be), reverting
> > > this commit fixes the build.
> > >
> > > This happens with vanilla binutils 2.32 and gcc 8.3.0 as well as 9.1.0. See
> > > the attached .config for reference.
> > >
> > > If you have questions or patches just ping me.
> >
> > Does Linus's latest tree also fail for you (or 5.1)?
> >
> > Nick, do we need to add another fix that is in mainline for this to work
> > properly?
> >
> > thanks,
> >
> > greg k-h
>
> Doesn't immediately ring any bells for me.

Upstream commits:
dd6846d77469 ("arm64: drop linker script hack to hide __efistub_ symbols")
1212f7a16af4 ("scripts/kallsyms: filter arm64's __efistub_ symbols")

Look related to __efistub__ prefixes on symbols and aren't in stable
4.9 (maybe Rolf can try cherry picks of those).
-- 
Thanks,
~Nick Desaulniers
