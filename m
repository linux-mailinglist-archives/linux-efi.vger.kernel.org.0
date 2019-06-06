Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9662370EF
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2019 11:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfFFJyz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jun 2019 05:54:55 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35377 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbfFFJyy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jun 2019 05:54:54 -0400
Received: by mail-it1-f196.google.com with SMTP id n189so2165988itd.0
        for <linux-efi@vger.kernel.org>; Thu, 06 Jun 2019 02:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8P8yzaRHEtc9JnJhJ2Vcca1eVVavzK9/2U+jP565fm0=;
        b=soldPpgwSbwWi7a0R2nLws0VmYyEMoN2MS6nALAIJ2i8Ny6tl1OSqjSZ/ScD8YR4+z
         /MUIhRqMAswM8bnBZUwQUBXderhwnAMhb09fpeeviwpQMgB+M6FeSdkFanasIMI9cXXj
         siA7L6gR7LpSIdujqDGXl7vKvKNpYNnmLYP5Yv+jvOvFIDUCkFnauTX6Xnz014PIEKho
         3c8DPdOBy9jEjvoTVGJUwcWaTONl21AbTcm3vmeAnpirAmfhkpAi7o/Qnmv43+uw+YQ+
         QKaU8tZe/eoILactvgNvkdS5vQhGvuYXLv9XWakLeadWlEBbrIUkY4Ha78NZPOxXvSf3
         CTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8P8yzaRHEtc9JnJhJ2Vcca1eVVavzK9/2U+jP565fm0=;
        b=B01MFYOYZQiCozamcBAiG8VWRehiishGNcEi/bHO963fc71P0N9RKqGLykqXRB4auY
         M3qXzuP6Y81PoBo+tOmH7+bTMmEvZc8WWMSztaUYdo0fZ2DGHtAju/iecyTjZwUjqZmu
         KELHP/GkcvJan302Cjj2+9+O5qc/znZegMxG8Af2dedSw6U7BLD/rv5z9Z9noVCTVTHI
         HrFqAFDPuiIoeyErAFXYNhO+MAToCj5Zm9bD1/pHiU9i1GS6u6JWrPPwSLC2aE1sbXXk
         4n+zKhXC1aZXxQALY9HlyBx/Cg5Qmr7zKY9/6e8FfOvZRlXtb9QhgCRvi6plpyFcZeed
         qwYQ==
X-Gm-Message-State: APjAAAU1V3TT+li+Fw/mLxc1OJHFgH/bSGjUk4pZ7TvJS8N1S69BYWTU
        rXJJ0Q6T5m0+8NJOwkMm5Ujmdo2rU04RAOHm0VJfzA==
X-Google-Smtp-Source: APXvYqz6XRs3yBdb3JcP7AkuvjidH9m/e8zfPFvfRXiSbwTxc22Z2J/y3l2mcT9Y1/3ogKBHOBlDgqUV4+rbTiVEyBw=
X-Received: by 2002:a02:b01c:: with SMTP id p28mr30692269jah.130.1559814891244;
 Thu, 06 Jun 2019 02:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <779905244.a0lJJiZRjM@devpool35> <1993275.kHlTELq40E@devpool35>
 <CAKv+Gu9oq+LseNvB9h1u+Q7QVOJFJwm_RyE1dMRgeVuL6D9fNQ@mail.gmail.com> <2433398.iiuBUrR0On@devpool35>
In-Reply-To: <2433398.iiuBUrR0On@devpool35>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Jun 2019 11:54:37 +0200
Message-ID: <CAKv+Gu_GOprKzXmm0kzi50hR8MJ6g02uZBAnKi=5x+kFOuqz1w@mail.gmail.com>
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

On Thu, 6 Jun 2019 at 11:40, Rolf Eike Beer <eb@emlix.com> wrote:
>
> Ard Biesheuvel wrote:
> > On Thu, 6 Jun 2019 at 09:50, Rolf Eike Beer <eb@emlix.com> wrote:
> > > Am Donnerstag, 6. Juni 2019, 09:38:41 CEST schrieb Rolf Eike Beer:
> > > > Greg KH wrote:
> > > > > On Wed, Jun 05, 2019 at 05:19:40PM +0200, Rolf Eike Beer wrote:
> > > > > > I decided to dig out a toy project which uses a DragonBoard 410c.
> > > > > > This
> > > > > > has
> > > > > > been "running" with kernel 4.9, which I would keep this way for
> > > > > > unrelated
> > > > > > reasons. The vanilla 4.9 kernel wasn't bootable back then, but it
> > > > > > was
> > > > > > buildable, which was good enough.
> > > > > >
> > > > > > Upgrading the kernel to 4.9.180 caused the boot to suddenly fail:
> > > > > >
> > > > > > aarch64-unknown-linux-gnueabi-ld:
> > > > > > ./drivers/firmware/efi/libstub/lib.a(arm64- stub.stub.o): in
> > > > > > function
> > > > > > `handle_kernel_image':
> > > > > > /tmp/e2/build/linux-4.9.139/drivers/firmware/efi/libstub/arm64-stub.
> > > > > > c:63
> > > > > >
> > > > > > undefined reference to `__efistub__GLOBAL_OFFSET_TABLE_'
> > > > > > aarch64-unknown-linux-gnueabi-ld:
> > > > > > ./drivers/firmware/efi/libstub/lib.a(arm64- stub.stub.o): relocation
> > > > > > R_AARCH64_ADR_PREL_PG_HI21 against symbol
> > > > > > `__efistub__GLOBAL_OFFSET_TABLE_' which may bind externally can not
> > > > > > be
> > > > > > used when making a shared object; recompile with -fPIC
> > > > > > /tmp/e2/build/linux-4.9.139/drivers/firmware/efi/libstub/arm64-stub.
> > > > > > c:63
> > > > > >
> > > > > > (.init.text+0xc): dangerous relocation: unsupported relocation
> > > > > > /tmp/e2/build/linux-4.9.139/Makefile:1001: recipe for target
> > > > > > 'vmlinux'
> > > > > > failed -make[1]: *** [vmlinux] Error 1
> > > > > >
> > > > > > This is caused by commit 27b5ebf61818749b3568354c64a8ec2d9cd5ecca
> > > > > > from
> > > > > > linux-4.9.y (which is 91ee5b21ee026c49e4e7483de69b55b8b47042be),
> > > > > > reverting
> > > > > > this commit fixes the build.
> > > > > >
> > > > > > This happens with vanilla binutils 2.32 and gcc 8.3.0 as well as
> > > > > > 9.1.0.
> > > > > > See
> > > > > > the attached .config for reference.
> > > > > >
> > > > > > If you have questions or patches just ping me.
> > > > >
> > > > > Does Linus's latest tree also fail for you (or 5.1)?
> > > >
> > > > 5.1.7 with the same config as before and "make olddefconfig" builds for
> > > > me.
> > >
> > > Just for the fun of it: both 4.19 and 4.19.48 also work.
>
> > Could you please check whether patch
> > 60f38de7a8d4e816100ceafd1b382df52527bd50 applies cleanly, and whether
> > it fixes the problem? Thanks.
>
> The part in drivers/firmware/efi/libstub/arm-stub.c needs to be applied by
> hand, but afterwards things build fine.
>

Thanks.

I'll send out a backport.
