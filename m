Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45C3270742
	for <lists+linux-efi@lfdr.de>; Fri, 18 Sep 2020 22:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgIRUot (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Sep 2020 16:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgIRUot (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 18 Sep 2020 16:44:49 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C73235F8
        for <linux-efi@vger.kernel.org>; Fri, 18 Sep 2020 20:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600461888;
        bh=AnIARY4XPHNUbnJLVqMftLxwQaYiuOS4aRBYJLoLY0M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aeT/pHTJqqCtvXClialoV+cAUjNCHQzB2KxH5K6SuIwKi04g3wCB/hb/JlzccSbF5
         /MuVRlYpti26fkS0u4FMUX248D7xOCDaimpJtnvVaGhvrLKNQxBJqirrelgSB9t+sX
         RsEegz/BWyAbSAIBZJWj9fz84LJOeHIbX1TuLpAQ=
Received: by mail-oi1-f176.google.com with SMTP id n2so8614954oij.1
        for <linux-efi@vger.kernel.org>; Fri, 18 Sep 2020 13:44:48 -0700 (PDT)
X-Gm-Message-State: AOAM533doAmhERxlJb24Fv1TSvNIwQyqr55cT80L93+MXfz7gybc5YP5
        fYfqxnZ/8luOJxvSeaWpyHnHmqLoTB6ISwmGt88=
X-Google-Smtp-Source: ABdhPJzsdwuew5itTV6wdl7G9zZ1RDikq9pTE3lD4V9k9SuUzkU5MZdocEnN+5dt6O6a7/OeWVUQVic/fytYChvAKlE=
X-Received: by 2002:a05:6808:8e5:: with SMTP id d5mr10746303oic.33.1600461887317;
 Fri, 18 Sep 2020 13:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200914095706.3985-1-ardb@kernel.org> <CAKwvOdmSXm7cV3hB_Yp=DD0RwwDHtPzzDBU8Xj5kBREn3xqYdA@mail.gmail.com>
 <CAMj1kXGuFFUyT48EYvzFmjCP4QZi_Sk_GpBrBCaHjP7HKLhjBA@mail.gmail.com>
 <CAKwvOdmkNgi_+kfauTSLwtpVChipW851_KGJG+gBbhwRxJJORA@mail.gmail.com>
 <CAMj1kXHTkP7-8xscGZGXN_0Sq=BCSnt3zWqkcm8xdO11xmditA@mail.gmail.com>
 <CAKwvOd=G2Rr3StUJ=oWu1L4b5y615m+uYNW-Y5sis13uqBvrYQ@mail.gmail.com>
 <CAMj1kXHEpPc0MSoMrCxEkyb44AkLM2NJJGtOXLpr6kxBHS0vfA@mail.gmail.com>
 <CAKwvOd=Sq3XOquw4ACEi+cYCQp0-LW-JXoecFt+yy+jtmtuhiQ@mail.gmail.com>
 <CAMj1kXG9WBZb9WYCCng7CkJ+v8X=xHVhih274iuXMd5ua2nKPg@mail.gmail.com> <CAKwvOd=8QUQK6hCQaAGjX6o_jz_vgFewW6v+SPHZ7ZKi9LYcYw@mail.gmail.com>
In-Reply-To: <CAKwvOd=8QUQK6hCQaAGjX6o_jz_vgFewW6v+SPHZ7ZKi9LYcYw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 18 Sep 2020 22:44:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEM=bW6DdPDDeFOWi47O6JOu_czui9Y2BJfjiVdQ1CvOw@mail.gmail.com>
Message-ID: <CAMj1kXEM=bW6DdPDDeFOWi47O6JOu_czui9Y2BJfjiVdQ1CvOw@mail.gmail.com>
Subject: Re: [PATCH 00/12] ARM: use adr_l/ldr_l macros for PC-relative references
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jian Cai <jiancai@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 18 Sep 2020 at 22:03, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Wed, Sep 16, 2020 at 11:01 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 17 Sep 2020 at 00:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > Also, it looks like the GCC build of milbeaut_m10v_defconfig fails to
> > > boot for me in QEMU; so maybe not just a Clang bug (or maybe, more
> > > than one bug).  (or maybe one of my command line params to QEMU is
> > > wrong).
> > >
> >
> > I understand that this is actually an existing issue in -next, but in
> > general, why would you expect to be able to boot
> > milbeaut_m10v_defconfig on anything other than a Milbeaut MV10
> > machine?
>
> We've been booting other configs in QEMU for a few years now, so I
> don't see why yet another config would hurt.  Maybe there's some
> hardware dependency, but I guess we'd find that out trying to boot it
> in QEMU.  If it boots in QEMU, I guess not booting on metal wasn't so
> bad?  Maybe this is considered an antipattern, but you can see how if
> we've been getting away with it for years then that would lead to such
> expectations.
>
> > (whatever it is) Or does QEMU emulate a milbeaut machine?
>
> $ qemu-system-arm -machine help
>
> doesn't print anything that looks like it, on initial glance.  Looks
> like a socionext part:
> https://www.socionext.com/en/pr/sn_pr20170105_01e.pdf
>
> > If
> > not, better to stick with configs that are intended to boot on the
> > QEMU machine emulation that you are using.
>
> I can see in our CI that we've been building+boot testing
> multi_v5_defconfig, aspeed_g5_defconfig, and multi_v7_defconfig for a
> while now without specifying any machine.  Is there a preferred
> machine we should be using for those?  (It looks like qemu supports
> ast2500-evb and ast2600-evb; is ARM1176 and ARMv6 core? Is that what
> aspeed_g5 uses? Why is virt versioned? Ahhhh!!!!)
>

Milbeaut's serial output is on a "socionext,milbeaut-usio-uart" UART,
and its defconfig does not include drivers for the PL011 or 8250/16550
UARTs that you typically find on other boards. So how on earth would
you expect to get any output at all if QEMU does not emulate this
exact machine?

In general, if you use QEMU/mach-virt, the only defconfigs you should
reasonably be testing are the ones that contain CONFIG_ARCH_VIRT=y.


> > Also, while I see the point of regression testing of -next, using it
> > as a base to test arbitrary series and then report failures against it
> > produces a lot of noise. -next is *not* a good base for development,
> > because you get everybody else's half baked crap as well.
>
> Ack.
>
> > When you
> > test my stuff, please use a known good base so we're not off on a
> > goose chase every time.
>
> Goose Chase?! gOoSe ChAsE?! *gestures broadly at...everything*
> Monsieur, here at the zoo, chasing the geese is not out of our
> purview.  It's preferable to cleaning up after the elephants.

:-)
