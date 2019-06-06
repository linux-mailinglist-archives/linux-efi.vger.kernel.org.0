Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F03236F58
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2019 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfFFJBk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jun 2019 05:01:40 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54200 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfFFJBk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jun 2019 05:01:40 -0400
Received: by mail-it1-f193.google.com with SMTP id m187so2000481ite.3
        for <linux-efi@vger.kernel.org>; Thu, 06 Jun 2019 02:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dv2WG1P4LjGl9htxi8ki1M85cFA09s4aSi2ztouswF0=;
        b=zzYruU5/yv3X3MlFghh/z+xye0n/tQWAIaEqAwbUGoDidiM9qML6aHBOgqhV64UbjT
         RPSYJHLYgx82k45AhD85pqDyd/wsfRBQQGaqe6jJqGAKjdnRiidIdTB8+n7ZRLnpp6Cb
         004JCYY+4uRtsRlkJClJ+DmEhhfgLjT2NpaD3bxEM54y2NB1NEpwCx/z4igTkr8cOHdZ
         aCynjpFrCtSVugnDA6MKNsWNgQ8WB9b/w27bzJtgkf75OY8NnK0vPhxTeK2YoYRuqPJj
         7CW4QZL7KTco3/9La0nnjcaQMuDNIylHUVsg+XqO3xwuMhlQk+H0D8CAdMG05y4FrzRl
         d2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dv2WG1P4LjGl9htxi8ki1M85cFA09s4aSi2ztouswF0=;
        b=hiXO6X/WiNQneY8Olagv+vRiFbkAT+88G4D6Po7glDjDxivOD0rH9BHuWP+SFupAY/
         uJZJ5h7wpGOSkDDA5e0IDwXvPFrNkeo0MxyYuLZMWgdL0jcc0y4hmpC9LLgT1P1+Bamp
         WgfqIaCKJZDc4bxypP2LJEbM/u5FgcucdVBrGc0lnx9sJ2voBVVpMTfCFm4l3hqEeGDs
         VJUaU3ldxBfruu4d+xLl1qS22DZkxA+r3+5i799W2PfxvFneclgLQdpqe1tAqr209z/6
         hns6oQ1INdqQB1nv61qHEB07ByMczTIB+YJfACaLiEIjj9bYn14Jr6c9q1g+dn4WjZOs
         zcAA==
X-Gm-Message-State: APjAAAWtk9VxliZoPwvMxjYLyXs4/O1cii0LmgVcBfiJb7l7BVhTF77d
        50ioIlYBUzGq1b7ktA+/cMUfZG7daEmi1BBfhXB9DA==
X-Google-Smtp-Source: APXvYqwToJWtoVVGRYuxXLAxq/qFM4S6nRzLQkRyaXZ8ORDXXXZqh/aB/0OMI7vljblumoE5aJmqEm+rvCIjADZ+owU=
X-Received: by 2002:a05:660c:44a:: with SMTP id d10mr9193730itl.153.1559811699927;
 Thu, 06 Jun 2019 02:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <779905244.a0lJJiZRjM@devpool35> <20190605162626.GA31164@kroah.com>
 <8696846.WsthzzWoxp@devpool35> <1993275.kHlTELq40E@devpool35>
In-Reply-To: <1993275.kHlTELq40E@devpool35>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Jun 2019 11:01:26 +0200
Message-ID: <CAKv+Gu9oq+LseNvB9h1u+Q7QVOJFJwm_RyE1dMRgeVuL6D9fNQ@mail.gmail.com>
Subject: Re: Building arm64 EFI stub with -fpie breaks build of 4.9.x
 (undefined reference to `__efistub__GLOBAL_OFFSET_TABLE_')
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 6 Jun 2019 at 09:50, Rolf Eike Beer <eb@emlix.com> wrote:
>
> Am Donnerstag, 6. Juni 2019, 09:38:41 CEST schrieb Rolf Eike Beer:
> > Greg KH wrote:
> > > On Wed, Jun 05, 2019 at 05:19:40PM +0200, Rolf Eike Beer wrote:
> > > > I decided to dig out a toy project which uses a DragonBoard 410c. This
> > > > has
> > > > been "running" with kernel 4.9, which I would keep this way for
> > > > unrelated
> > > > reasons. The vanilla 4.9 kernel wasn't bootable back then, but it was
> > > > buildable, which was good enough.
> > > >
> > > > Upgrading the kernel to 4.9.180 caused the boot to suddenly fail:
> > > >
> > > > aarch64-unknown-linux-gnueabi-ld:
> > > > ./drivers/firmware/efi/libstub/lib.a(arm64- stub.stub.o): in function
> > > > `handle_kernel_image':
> > > > /tmp/e2/build/linux-4.9.139/drivers/firmware/efi/libstub/arm64-stub.c:63
> > > > :
> > > > undefined reference to `__efistub__GLOBAL_OFFSET_TABLE_'
> > > > aarch64-unknown-linux-gnueabi-ld:
> > > > ./drivers/firmware/efi/libstub/lib.a(arm64- stub.stub.o): relocation
> > > > R_AARCH64_ADR_PREL_PG_HI21 against symbol
> > > > `__efistub__GLOBAL_OFFSET_TABLE_' which may bind externally can not be
> > > > used when making a shared object; recompile with -fPIC
> > > > /tmp/e2/build/linux-4.9.139/drivers/firmware/efi/libstub/arm64-stub.c:63
> > > > :
> > > > (.init.text+0xc): dangerous relocation: unsupported relocation
> > > > /tmp/e2/build/linux-4.9.139/Makefile:1001: recipe for target 'vmlinux'
> > > > failed -make[1]: *** [vmlinux] Error 1
> > > >
> > > > This is caused by commit 27b5ebf61818749b3568354c64a8ec2d9cd5ecca from
> > > > linux-4.9.y (which is 91ee5b21ee026c49e4e7483de69b55b8b47042be),
> > > > reverting
> > > > this commit fixes the build.
> > > >
> > > > This happens with vanilla binutils 2.32 and gcc 8.3.0 as well as 9.1.0.
> > > > See
> > > > the attached .config for reference.
> > > >
> > > > If you have questions or patches just ping me.
> > >
> > > Does Linus's latest tree also fail for you (or 5.1)?
> >
> > 5.1.7 with the same config as before and "make olddefconfig" builds for me.
>
> Just for the fun of it: both 4.19 and 4.19.48 also work.
>

Thanks Rolf

Could you please check whether patch
60f38de7a8d4e816100ceafd1b382df52527bd50 applies cleanly, and whether
it fixes the problem? Thanks.
