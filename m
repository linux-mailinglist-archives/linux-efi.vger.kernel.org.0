Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5683B2707C5
	for <lists+linux-efi@lfdr.de>; Fri, 18 Sep 2020 23:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIRVGx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Sep 2020 17:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRVGw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Sep 2020 17:06:52 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84333C0613CE
        for <linux-efi@vger.kernel.org>; Fri, 18 Sep 2020 14:06:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x18so3625604pll.6
        for <linux-efi@vger.kernel.org>; Fri, 18 Sep 2020 14:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3/trMYxvoOh6hxMkstnG+j5yeJdNnsdtZ9F9ako3WM=;
        b=udkhQ9JUlG3kweMvMykwQYyS5ksXYU3CJa8WsCBADjB2nk86Sv++0OdoHlh/guhsL8
         c9ZsVMFSO+hS5/muckv+hjNG5O90JaBADAmgJZrDsrgTLMRMHlsO2zkLRt7xx5CWn92X
         NOuDGpnmO1n3p9YtP8m1nhPrkDnnPPi7As0tT6e+NAyyx1VSZ6ezgUL4Jg89614MG66G
         FX/UjKYvN+BbFHLISxn2CIDy4dS70NQSqBDVSHyVJdxb6goh+FCG6IXMU1F8ZpXkn6fG
         9eFkQWvCOpm0tzGx75BKj2VtY26ET9T9qd35KqXclpyJMCDHjW3rCgqq76EZ6ra7758Y
         96uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3/trMYxvoOh6hxMkstnG+j5yeJdNnsdtZ9F9ako3WM=;
        b=bEy6ys2KJwuDrg/vNJJYBFOPcC2xfRsxJUlMBKeOtktG7+q5Kc+jllNivdBEMDHwA5
         yqAIp+5grGsnAEXHVHMAEcSKdRR2KUtyrleYF5+sm58bX2BOUhaD1l6zOQ1x171BF2q2
         UStsWLfR6mgUmHCfC4iCETyyZx3pUihDqGUbDFdU0N+SSef9VHv+NNwR8RS49GUbZgR9
         aJjw3fWR35spFQRDxPhyp9m1qrvkyqHrQYbsTYjzmDjW4jIGHnTBqmm/uthSaHAw6srm
         UORXsCR3JCZoJHKnDhGoBqXnI8yJgaNYkdNSOY8zL1PrmFVMBAO9JG5t6DJxqoVCN95T
         iV/w==
X-Gm-Message-State: AOAM53352fTvw/Hk++I1ISZVWkPqthwjhgMXGtd9/VDBvIy6Ra/IgD+J
        kMRMweTJ6RTjiLLU2KATxm9otYvqryxzYMasU9sSKA==
X-Google-Smtp-Source: ABdhPJyiRzFh8gLn7o5cxEZgjbZX0Yog7y389y19yS7PGhscoOHQJ35iNbDqpMTushVzg7PB2OXLrVlGYLsJKKKTkIU=
X-Received: by 2002:a17:902:ed11:b029:d1:f385:f4e7 with SMTP id
 b17-20020a170902ed11b02900d1f385f4e7mr11944535pld.56.1600463211751; Fri, 18
 Sep 2020 14:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200914095706.3985-1-ardb@kernel.org> <CAKwvOdmSXm7cV3hB_Yp=DD0RwwDHtPzzDBU8Xj5kBREn3xqYdA@mail.gmail.com>
 <CAMj1kXGuFFUyT48EYvzFmjCP4QZi_Sk_GpBrBCaHjP7HKLhjBA@mail.gmail.com>
 <CAKwvOdmkNgi_+kfauTSLwtpVChipW851_KGJG+gBbhwRxJJORA@mail.gmail.com>
 <CAMj1kXHTkP7-8xscGZGXN_0Sq=BCSnt3zWqkcm8xdO11xmditA@mail.gmail.com>
 <CAKwvOd=G2Rr3StUJ=oWu1L4b5y615m+uYNW-Y5sis13uqBvrYQ@mail.gmail.com>
 <CAMj1kXHEpPc0MSoMrCxEkyb44AkLM2NJJGtOXLpr6kxBHS0vfA@mail.gmail.com>
 <CAKwvOd=Sq3XOquw4ACEi+cYCQp0-LW-JXoecFt+yy+jtmtuhiQ@mail.gmail.com>
 <CAMj1kXG9WBZb9WYCCng7CkJ+v8X=xHVhih274iuXMd5ua2nKPg@mail.gmail.com>
 <CAKwvOd=8QUQK6hCQaAGjX6o_jz_vgFewW6v+SPHZ7ZKi9LYcYw@mail.gmail.com> <CAMj1kXEM=bW6DdPDDeFOWi47O6JOu_czui9Y2BJfjiVdQ1CvOw@mail.gmail.com>
In-Reply-To: <CAMj1kXEM=bW6DdPDDeFOWi47O6JOu_czui9Y2BJfjiVdQ1CvOw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Sep 2020 14:06:40 -0700
Message-ID: <CAKwvOdnrKcvJpomHPt_SCjQSW3iBOLFE=7hf0L1H3X1rW6GkQQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] ARM: use adr_l/ldr_l macros for PC-relative references
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Fri, Sep 18, 2020 at 1:44 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 18 Sep 2020 at 22:03, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Wed, Sep 16, 2020 at 11:01 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 17 Sep 2020 at 00:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > Also, it looks like the GCC build of milbeaut_m10v_defconfig fails to
> > > > boot for me in QEMU; so maybe not just a Clang bug (or maybe, more
> > > > than one bug).  (or maybe one of my command line params to QEMU is
> > > > wrong).
> > > >
> > >
> > > I understand that this is actually an existing issue in -next, but in
> > > general, why would you expect to be able to boot
> > > milbeaut_m10v_defconfig on anything other than a Milbeaut MV10
> > > machine?
> >
> > We've been booting other configs in QEMU for a few years now, so I
> > don't see why yet another config would hurt.  Maybe there's some
> > hardware dependency, but I guess we'd find that out trying to boot it
> > in QEMU.  If it boots in QEMU, I guess not booting on metal wasn't so
> > bad?  Maybe this is considered an antipattern, but you can see how if
> > we've been getting away with it for years then that would lead to such
> > expectations.
> >
> > > (whatever it is) Or does QEMU emulate a milbeaut machine?
> >
> > $ qemu-system-arm -machine help
> >
> > doesn't print anything that looks like it, on initial glance.  Looks
> > like a socionext part:
> > https://www.socionext.com/en/pr/sn_pr20170105_01e.pdf
> >
> > > If
> > > not, better to stick with configs that are intended to boot on the
> > > QEMU machine emulation that you are using.
> >
> > I can see in our CI that we've been building+boot testing
> > multi_v5_defconfig, aspeed_g5_defconfig, and multi_v7_defconfig for a
> > while now without specifying any machine.  Is there a preferred
> > machine we should be using for those?  (It looks like qemu supports
> > ast2500-evb and ast2600-evb; is ARM1176 and ARMv6 core? Is that what
> > aspeed_g5 uses? Why is virt versioned? Ahhhh!!!!)
> >
>
> Milbeaut's serial output is on a "socionext,milbeaut-usio-uart" UART,
> and its defconfig does not include drivers for the PL011 or 8250/16550
> UARTs that you typically find on other boards. So how on earth would
> you expect to get any output at all if QEMU does not emulate this
> exact machine?

breakpoints in panic()/printk(), lx-dmesg in GDB via
CONFIG_GDB_SCRIPTS=y generally works. :^)

I guess one thing I don't understand is how to check what UART or what
the name of the tty device would be.  I can grep for
"socionext,milbeaut-usio-uart" and see where it's defined, but I never
would have/still don't know how to find that. Please teach me how to
fish.  I understand the point of DT, and see

arch/arm/boot/dts/milbeaut-m10v.dtsi
76:                     compatible = "socionext,milbeaut-usio-uart";

but the comment about ttyUSI0 is confusing to me; that identifier
doesn't appear anywhere else in the kernel sources.

I generally have the same problem trying to run Pixel kernels in QEMU;
I don't understand how to determine which serial driver is being used,
and what the tty device would be named.  So I just enable the PLO11
driver.

Only last week I found that trying to use a shell as init without any
serial output can result in the shell exiting, panicking the kernel,
which doesn't print over serial...goose chase...

> In general, if you use QEMU/mach-virt, the only defconfigs you should
> reasonably be testing are the ones that contain CONFIG_ARCH_VIRT=y.

Looks like then that would only be multi_v7_defconfig.  How do we
continue to verify we can boot ARMv6 or ARMv5 under virtualization?
There are such machines in QEMU, but then no defconfigs in the kernel.
-- 
Thanks,
~Nick Desaulniers
