Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB9626D376
	for <lists+linux-efi@lfdr.de>; Thu, 17 Sep 2020 08:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIQGKe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Sep 2020 02:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgIQGKc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 17 Sep 2020 02:10:32 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF602137B
        for <linux-efi@vger.kernel.org>; Thu, 17 Sep 2020 06:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600322485;
        bh=jiadvDpMiHyZa5k9Csp8Rdv0X1I4Z4ViyU3IO/sGl98=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XSLn6+0VeOupxdazuTTMNx80pNV71qhB2j40S0zfebiZy1UnQ7mMPSHwpb+rJnHu0
         EnX/wTRRZx1UzBpl1LrOQvgFCiKBi8HJELLlvmCt4o/X/iCanTWhyQ+00TiKXl0AWI
         TDhKCLYPnlyBUGFL79SkVaHZToE1jFOwjOSXjLNI=
Received: by mail-ot1-f49.google.com with SMTP id o6so862985ota.2
        for <linux-efi@vger.kernel.org>; Wed, 16 Sep 2020 23:01:25 -0700 (PDT)
X-Gm-Message-State: AOAM530B0lw3BXZO4X/XmfB4Pe7PRUqcfQLGTchqVXGZQBHmJxeGBoFz
        T3hNdHPJuEqPVxuG8+imqRrcx9t+xTwKF42OCTs=
X-Google-Smtp-Source: ABdhPJy1by83H0KJT+20Vky8RaBEg6PViTjCejVVW1B1NhMkIwFDn7oIjBuE1f4aTHMiV4AuzSHy4/wh73EpcH/gLxo=
X-Received: by 2002:a9d:6250:: with SMTP id i16mr19900890otk.77.1600322484572;
 Wed, 16 Sep 2020 23:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200914095706.3985-1-ardb@kernel.org> <CAKwvOdmSXm7cV3hB_Yp=DD0RwwDHtPzzDBU8Xj5kBREn3xqYdA@mail.gmail.com>
 <CAMj1kXGuFFUyT48EYvzFmjCP4QZi_Sk_GpBrBCaHjP7HKLhjBA@mail.gmail.com>
 <CAKwvOdmkNgi_+kfauTSLwtpVChipW851_KGJG+gBbhwRxJJORA@mail.gmail.com>
 <CAMj1kXHTkP7-8xscGZGXN_0Sq=BCSnt3zWqkcm8xdO11xmditA@mail.gmail.com>
 <CAKwvOd=G2Rr3StUJ=oWu1L4b5y615m+uYNW-Y5sis13uqBvrYQ@mail.gmail.com>
 <CAMj1kXHEpPc0MSoMrCxEkyb44AkLM2NJJGtOXLpr6kxBHS0vfA@mail.gmail.com> <CAKwvOd=Sq3XOquw4ACEi+cYCQp0-LW-JXoecFt+yy+jtmtuhiQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=Sq3XOquw4ACEi+cYCQp0-LW-JXoecFt+yy+jtmtuhiQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 17 Sep 2020 09:01:13 +0300
X-Gmail-Original-Message-ID: <CAMj1kXG9WBZb9WYCCng7CkJ+v8X=xHVhih274iuXMd5ua2nKPg@mail.gmail.com>
Message-ID: <CAMj1kXG9WBZb9WYCCng7CkJ+v8X=xHVhih274iuXMd5ua2nKPg@mail.gmail.com>
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
        Jian Cai <jiancai@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 17 Sep 2020 at 00:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Wed, Sep 16, 2020 at 1:45 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 16 Sep 2020 at 22:53, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Tue, Sep 15, 2020 at 10:55 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Wed, 16 Sep 2020 at 02:31, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > >
> > > > > On Tue, Sep 15, 2020 at 2:30 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > Excellent, thanks for testing. Do you have any coverage for Thumb2
> > > > > > builds as well? (CONFIG_THUMB2_KERNEL=y)
> > > > >
> > > > > Ah, right, manually testing ARCH=arm defconfig with
> > > > > CONFIG_THUMB2_KERNEL enabled via menuconfig:
> > > > >
> > > > > Builds and boots for clang.
> > > > >
> > > > > (Also needed https://lore.kernel.org/lkml/20200915225751.274531-1-ndesaulniers@google.com/T/#u
> > > > > for an unrelated issue).
> > > > >
> > > > > For GCC, I observe:
> > > > >
> > > > > arch/arm/vfp/vfphw.o: in function `vfp_support_entry':
> > > > > (.text+0xa): relocation truncated to fit: R_ARM_THM_JUMP19 against
> > > > > symbol `vfp_kmode_exception' defined in .text.unlikely section in
> > > > > arch/arm/vfp/vfpmodule.o
> > > > >
> > > >
> > > > Interesting. And this is using ld.bfd ?
> > >
> > > $ arm-linux-gnueabihf-ld --version
> > > GNU ld (GNU Binutils for Debian) 2.34
> > >
> > > .text.unlikely reminds me of the sections created when profiling data
> > > is present.  That's obviously not the case here, so maybe there's
> > > other ways this section can be created by GCC?  I may have added a
> > > patch recently for placing this section explicitly, which was a
> > > prerequisite for Kees' series explicitly placing all sections.
> > > https://lore.kernel.org/lkml/159896087937.20229.4955362311782724603.tip-bot2@tip-bot2/
> > > Maybe that can be improved?
> > >
> > > IIRC, LLD is able to emit range extension thunks for these cases, but
> > > BFD does not.
> >
> > ld.bfd will usually emit veneers for branches that turn out to be out
> > of range in the final link stage.
> >
> > Does the following help?
> >
> > diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
> > index 4fcff9f59947..f1468702fbc9 100644
> > --- a/arch/arm/vfp/vfphw.S
> > +++ b/arch/arm/vfp/vfphw.S
> > @@ -82,6 +82,7 @@ ENTRY(vfp_support_entry)
> >         ldr     r3, [sp, #S_PSR]        @ Neither lazy restore nor FP exceptions
> >         and     r3, r3, #MODE_MASK      @ are supported in kernel mode
> >         teq     r3, #USR_MODE
> > +THUMB( it      ne                      )
> >         bne     vfp_kmode_exception     @ Returns through lr
> >
> >         VFPFMRX r1, FPEXC               @ Is the VFP enabled?
>
> Yes, it does!  I'm curious why though?  I've seen the "it prefixes"
> before (is that what they're called?), but I don't recall what they're
> for.  How come that solves this issue?
>

It forces the use of an instruction encoding that has more space for
an immediate.

> (Feel free to use my tested by tag on a subsequent resulting patch
> that uses that).  That fix is irrespective of this series, so you
> should send it maybe separately?
>

I will, thanks.

> Also, it looks like the GCC build of milbeaut_m10v_defconfig fails to
> boot for me in QEMU; so maybe not just a Clang bug (or maybe, more
> than one bug).  (or maybe one of my command line params to QEMU is
> wrong).
>

I understand that this is actually an existing issue in -next, but in
general, why would you expect to be able to boot
milbeaut_m10v_defconfig on anything other than a Milbeaut MV10
machine? (whatever it is) Or does QEMU emulate a milbeaut machine? If
not, better to stick with configs that are intended to boot on the
QEMU machine emulation that you are using.

Also, while I see the point of regression testing of -next, using it
as a base to test arbitrary series and then report failures against it
produces a lot of noise. -next is *not* a good base for development,
because you get everybody else's half baked crap as well. When you
test my stuff, please use a known good base so we're not off on a
goose chase every time.



> Stepping through start_kernel(), the call to setup_arch() seems to
> hang in qemu.  For both GCC and Clang builds. A breakpoint in panic()
> never gets hit.  Looks like the deepest I can get is:
>
> Looks like:
> #0  memblock_alloc_try_nid (size=108, align=4, min_addr=0, max_addr=0,
> nid=-1) at mm/memblock.c:1601
> #1  0xc060f0b4 in memblock_alloc (size=<optimized out>,
> align=<optimized out>) at ./include/linux/memblock.h:409
> #2  cma_init_reserved_mem (base=1543503872, size=67108864,
> order_per_bit=0, name=0xc04b9240 "reserved", res_cma=0xc07ccbdc
> <dma_contiguous_default_area>) at mm/cma.c:190
> #3  0xc060f2c0 in cma_declare_contiguous_nid (base=1543503872,
> size=67108864, limit=1610612736, alignment=8388608, order_per_bit=0,
> fixed=false, name=0xc04b9240 "reserved",
>     res_cma=0xc07ccbdc <dma_contiguous_default_area>, nid=-1) at mm/cma.c:352
> #4  0xc0608cb6 in cma_declare_contiguous (alignment=<optimized out>,
> order_per_bit=<optimized out>, name=<optimized out>,
> res_cma=<optimized out>, fixed=<optimized out>,
>     limit=<optimized out>, size=<optimized out>, base=<optimized out>)
> at ./include/linux/cma.h:28
> #5  dma_contiguous_reserve_area (size=<optimized out>, base=<optimized
> out>, limit=<optimized out>, res_cma=0xc07ccbdc
> <dma_contiguous_default_area>, fixed=false)
>     at kernel/dma/contiguous.c:201
> #6  0xc0608d22 in dma_contiguous_reserve (limit=<optimized out>) at
> kernel/dma/contiguous.c:171
> #7  0xc0604584 in arm_memblock_init (mdesc=0xc061bfe8
> <__mach_desc_GENERIC_DT.35641>) at arch/arm/mm/init.c:230
> #8  0xc060302c in setup_arch (cmdline_p=<optimized out>) at
> arch/arm/kernel/setup.c:1132
> #9  0xc06007d2 in start_kernel () at init/main.c:857
>
> there's a call to memset that seems to hang.  I wonder if memset() was
> defined in terms of __builtin_memset, which oft can result in infinite
> loops?  (IIRC there's an AEABI related memset; this kind of thing has
> hit android userspace before).
>
> (gdb) layout asm
>
> shows that the source call to memset is transformed into a call to mmioset.
>
> (gdb) bt
> #0  mmioset () at arch/arm/lib/memset.S:19
> #1  0xc060e2dc in memblock_alloc_try_nid (size=108, align=<optimized
> out>, min_addr=0, max_addr=0, nid=-1) at mm/memblock.c:1602
> #2  0xc060f0b4 in memblock_alloc (size=<optimized out>,
> align=<optimized out>) at ./include/linux/memblock.h:409
> #3  cma_init_reserved_mem (base=1543503872, size=67108864,
> order_per_bit=0, name=0xc04b9240 "reserved", res_cma=0xc07ccbdc
> <dma_contiguous_default_area>) at mm/cma.c:190
> #4  0xc060f2c0 in cma_declare_contiguous_nid (base=1543503872,
> size=67108864, limit=1610612736, alignment=8388608, order_per_bit=0,
> fixed=false, name=0xc04b9240 "reserved",
>     res_cma=0xc07ccbdc <dma_contiguous_default_area>, nid=-1) at mm/cma.c:352
> #5  0xc0608cb6 in cma_declare_contiguous (alignment=<optimized out>,
> order_per_bit=<optimized out>, name=<optimized out>,
> res_cma=<optimized out>, fixed=<optimized out>,
>     limit=<optimized out>, size=<optimized out>, base=<optimized out>)
> at ./include/linux/cma.h:28
> #6  dma_contiguous_reserve_area (size=<optimized out>, base=<optimized
> out>, limit=<optimized out>, res_cma=0xc07ccbdc
> <dma_contiguous_default_area>, fixed=false)
>     at kernel/dma/contiguous.c:201
> #7  0xc0608d22 in dma_contiguous_reserve (limit=<optimized out>) at
> kernel/dma/contiguous.c:171
> #8  0xc0604584 in arm_memblock_init (mdesc=0xc061bfe8
> <__mach_desc_GENERIC_DT.35641>) at arch/arm/mm/init.c:230
> #9  0xc060302c in setup_arch (cmdline_p=<optimized out>) at
> arch/arm/kernel/setup.c:1132
> #10 0xc06007d2 in start_kernel () at init/main.c:857
>
> Using `si` in gdb, it looks like we maybe hit an exception vector?
> x   1202                .section .vectors, "ax", %progbits
>
>                                             x
> x   1203        .L__vectors_start:
>
>                                             x
> x   1204                W(b)    vector_rst
>
>                                             x
> x   1205                W(b)    vector_und
>
>                                             x
> x   1206                W(ldr)  pc, .L__vectors_start + 0x1000
>
>                                             x
> x  >1207                W(b)    vector_pabt
>
> Is the last thing I see, then `si` stops working.  Not sure if `pabt`
> is a recognizable acronym to anyone more familiar with ARM?
>
> Happens regardless of your series, FWIW.
> --
> Thanks,
> ~Nick Desaulniers
