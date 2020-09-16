Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341C126CC7E
	for <lists+linux-efi@lfdr.de>; Wed, 16 Sep 2020 22:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgIPUpV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Sep 2020 16:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgIPUpP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Sep 2020 16:45:15 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 723FA22209
        for <linux-efi@vger.kernel.org>; Wed, 16 Sep 2020 20:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600289114;
        bh=H+Jf2Rb5N44OvThgUBPqcuzZeUs9HZROwBKHbuKp18s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fGCYWboAHqupZMHrC080APLEk8R1jnQGWXquhQTq8U3QkXF3+cIHLsd1mLMmR83Ka
         XcVbibzI+OGaDBwhCvFZIA8fMUF5MnYnHsDQA1+AqJlA5QwbcNaUv+upyYr0sSzGqQ
         3HwUYEdqe2PWJGxwsMQ5TnMoZUUc62t9ET5YWDvU=
Received: by mail-oi1-f175.google.com with SMTP id c13so9662457oiy.6
        for <linux-efi@vger.kernel.org>; Wed, 16 Sep 2020 13:45:14 -0700 (PDT)
X-Gm-Message-State: AOAM532F4oqWGLpnD5N+Sf/EPHwQJV2n5fifyWfsDwikF0m2HM1eFODq
        gpGqrsgku9D3sD/00MD2xQeAy1Y4Fbe3D4H2Z/c=
X-Google-Smtp-Source: ABdhPJxjXKMzZENARKUKetF4eF2z+pHg4UdsouHKDIVdc91W0bBXnYbFVkm9v65TjgJXeZ/nHJXN8cxKnUd4OBTSSo0=
X-Received: by 2002:aca:d845:: with SMTP id p66mr4091532oig.47.1600289113732;
 Wed, 16 Sep 2020 13:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200914095706.3985-1-ardb@kernel.org> <CAKwvOdmSXm7cV3hB_Yp=DD0RwwDHtPzzDBU8Xj5kBREn3xqYdA@mail.gmail.com>
 <CAMj1kXGuFFUyT48EYvzFmjCP4QZi_Sk_GpBrBCaHjP7HKLhjBA@mail.gmail.com>
 <CAKwvOdmkNgi_+kfauTSLwtpVChipW851_KGJG+gBbhwRxJJORA@mail.gmail.com>
 <CAMj1kXHTkP7-8xscGZGXN_0Sq=BCSnt3zWqkcm8xdO11xmditA@mail.gmail.com> <CAKwvOd=G2Rr3StUJ=oWu1L4b5y615m+uYNW-Y5sis13uqBvrYQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=G2Rr3StUJ=oWu1L4b5y615m+uYNW-Y5sis13uqBvrYQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 16 Sep 2020 23:45:02 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHEpPc0MSoMrCxEkyb44AkLM2NJJGtOXLpr6kxBHS0vfA@mail.gmail.com>
Message-ID: <CAMj1kXHEpPc0MSoMrCxEkyb44AkLM2NJJGtOXLpr6kxBHS0vfA@mail.gmail.com>
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
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 16 Sep 2020 at 22:53, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Sep 15, 2020 at 10:55 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 16 Sep 2020 at 02:31, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Tue, Sep 15, 2020 at 2:30 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > Excellent, thanks for testing. Do you have any coverage for Thumb2
> > > > builds as well? (CONFIG_THUMB2_KERNEL=y)
> > >
> > > Ah, right, manually testing ARCH=arm defconfig with
> > > CONFIG_THUMB2_KERNEL enabled via menuconfig:
> > >
> > > Builds and boots for clang.
> > >
> > > (Also needed https://lore.kernel.org/lkml/20200915225751.274531-1-ndesaulniers@google.com/T/#u
> > > for an unrelated issue).
> > >
> > > For GCC, I observe:
> > >
> > > arch/arm/vfp/vfphw.o: in function `vfp_support_entry':
> > > (.text+0xa): relocation truncated to fit: R_ARM_THM_JUMP19 against
> > > symbol `vfp_kmode_exception' defined in .text.unlikely section in
> > > arch/arm/vfp/vfpmodule.o
> > >
> >
> > Interesting. And this is using ld.bfd ?
>
> $ arm-linux-gnueabihf-ld --version
> GNU ld (GNU Binutils for Debian) 2.34
>
> .text.unlikely reminds me of the sections created when profiling data
> is present.  That's obviously not the case here, so maybe there's
> other ways this section can be created by GCC?  I may have added a
> patch recently for placing this section explicitly, which was a
> prerequisite for Kees' series explicitly placing all sections.
> https://lore.kernel.org/lkml/159896087937.20229.4955362311782724603.tip-bot2@tip-bot2/
> Maybe that can be improved?
>
> IIRC, LLD is able to emit range extension thunks for these cases, but
> BFD does not.

ld.bfd will usually emit veneers for branches that turn out to be out
of range in the final link stage.

Does the following help?

diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 4fcff9f59947..f1468702fbc9 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -82,6 +82,7 @@ ENTRY(vfp_support_entry)
        ldr     r3, [sp, #S_PSR]        @ Neither lazy restore nor FP exceptions
        and     r3, r3, #MODE_MASK      @ are supported in kernel mode
        teq     r3, #USR_MODE
+THUMB( it      ne                      )
        bne     vfp_kmode_exception     @ Returns through lr

        VFPFMRX r1, FPEXC               @ Is the VFP enabled?
