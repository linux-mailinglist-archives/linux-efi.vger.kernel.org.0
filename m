Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B01F33627E
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2019 19:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFER1o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jun 2019 13:27:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40095 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfFER1o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jun 2019 13:27:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so12756059pgm.7
        for <linux-efi@vger.kernel.org>; Wed, 05 Jun 2019 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3Lwn5KZOUsmk/CRmt27tCNdDcr83HnHWyJ2IYSv5hU=;
        b=brFnAQBTHCmizluyZdMy/yCOBe4bRtDcpPheZP3WtwvWtaQLm6jSU5flAYbI3SyF/X
         NsSQ9cLWedTCWdSwLhFp9cCmNYDn1Del4bCQMvTIPxMeiIbXKwTdUcquEn7WTs1H/8pa
         lZggkmglMEYZFLnYzbg4r0SSdLGRyY918JaArc+/bhECb+Tdsokcp6QeBaAkrLv+qIvU
         usqKESIHK+0J2y16O/WpW867KbjhpP01d840yg7p9JAjtqLrVM0QtS9ef+RzQ/42215F
         MSeK8RpwOE2dQadDwMNvwIbstYHxZdGNrn5MBBL1t2TFeoaFDeEz2zmsQMBr6XVOgwep
         mFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3Lwn5KZOUsmk/CRmt27tCNdDcr83HnHWyJ2IYSv5hU=;
        b=EFLA3FxK2bU2Arfk0jaHMle4W8qUTbMv5pLRItMlHVj/t0fQwcvaIayZ31nA4wp18U
         YQAjD7JKz7g+aFvpELf/3wugh7Dl/l2xd+DKeUvLVxMmhrZbNIVn/2nJChuwjJO0Aukl
         IGG0ijtLeZr2YRG7VCmff7INjx9z/QMvJd+oejizoJX0vBRSurAf7zSHiYXkp5imiYx/
         zYgCX2HDueEr1zQUMcT0zbaCHky/ePREmmQY+hwtI8YX69VZl/W9z7Nzhe9EzeFToe9K
         /ou9kqq3i+kZgmejttMG+Ap7vW2xW92s1BMtpCOMX6d02/N+DdLBB8Gxw0yoxw+F5j+O
         I8IA==
X-Gm-Message-State: APjAAAUBuvnwyuNx4iFBQPosHMeUOT1Ph4ESki2B0iy2rto4d8m4veGa
        bWemGxX5gv/UeegZp/82YjH/at9YsqIBE4VLgSsX9Q==
X-Google-Smtp-Source: APXvYqwxZIYD2tLmmhQv3OzjZw27K48ikdGJtfISMIYl3KxAF7Me2oDV7nlo+eCZNjc9maLRAaXhTwTP5NQEEUdDxAw=
X-Received: by 2002:a62:1b85:: with SMTP id b127mr48116131pfb.165.1559755663352;
 Wed, 05 Jun 2019 10:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <779905244.a0lJJiZRjM@devpool35> <20190605162626.GA31164@kroah.com>
In-Reply-To: <20190605162626.GA31164@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Jun 2019 10:27:32 -0700
Message-ID: <CAKwvOdnegLvkAa+-2uc-GM63HLcucWZtN5OoFvocLs50iLNJLg@mail.gmail.com>
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
        Matthias Kaehlcke <mka@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 5, 2019 at 9:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 05, 2019 at 05:19:40PM +0200, Rolf Eike Beer wrote:
> > I decided to dig out a toy project which uses a DragonBoard 410c. This has
> > been "running" with kernel 4.9, which I would keep this way for unrelated
> > reasons. The vanilla 4.9 kernel wasn't bootable back then, but it was
> > buildable, which was good enough.
> >
> > Upgrading the kernel to 4.9.180 caused the boot to suddenly fail:
> >
> > aarch64-unknown-linux-gnueabi-ld: ./drivers/firmware/efi/libstub/lib.a(arm64-
> > stub.stub.o): in function `handle_kernel_image':
> > /tmp/e2/build/linux-4.9.139/drivers/firmware/efi/libstub/arm64-stub.c:63:
> > undefined reference to `__efistub__GLOBAL_OFFSET_TABLE_'
> > aarch64-unknown-linux-gnueabi-ld: ./drivers/firmware/efi/libstub/lib.a(arm64-
> > stub.stub.o): relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol
> > `__efistub__GLOBAL_OFFSET_TABLE_' which may bind externally can not be used
> > when making a shared object; recompile with -fPIC
> > /tmp/e2/build/linux-4.9.139/drivers/firmware/efi/libstub/arm64-stub.c:63:
> > (.init.text+0xc): dangerous relocation: unsupported relocation
> > /tmp/e2/build/linux-4.9.139/Makefile:1001: recipe for target 'vmlinux' failed
> > -make[1]: *** [vmlinux] Error 1
> >
> > This is caused by commit 27b5ebf61818749b3568354c64a8ec2d9cd5ecca from
> > linux-4.9.y (which is 91ee5b21ee026c49e4e7483de69b55b8b47042be), reverting
> > this commit fixes the build.
> >
> > This happens with vanilla binutils 2.32 and gcc 8.3.0 as well as 9.1.0. See
> > the attached .config for reference.
> >
> > If you have questions or patches just ping me.
>
> Does Linus's latest tree also fail for you (or 5.1)?
>
> Nick, do we need to add another fix that is in mainline for this to work
> properly?
>
> thanks,
>
> greg k-h

Doesn't immediately ring any bells for me.

+mka@ who helped test 91ee5b21ee026c49e4e7483de69b55b8b47042be.
Nothing in that series
(https://lore.kernel.org/lkml/20170818194947.19347-5-ard.biesheuvel@linaro.org/T/#u)
is immediately obvious.

Rolf, can you please email me your config so I can see if I can
reproduce?  Also, which version of GCC are you using, and binutils?
(would be good to know if you hit this in mainline too, as if not
maybe there's an existing fix to be backported to stable).
-- 
Thanks,
~Nick Desaulniers
