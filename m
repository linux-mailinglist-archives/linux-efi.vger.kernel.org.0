Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436AE26BC00
	for <lists+linux-efi@lfdr.de>; Wed, 16 Sep 2020 07:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIPFzF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Sep 2020 01:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgIPFzE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Sep 2020 01:55:04 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B739E22204
        for <linux-efi@vger.kernel.org>; Wed, 16 Sep 2020 05:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600235703;
        bh=ZQ4+VQTRAq/x/Ifch7FEd2luHCVVlmppKDQVlC9ZW0s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aO6mjhblYLgWNUGiwjO043OCYM0MQRyDnmj11RCxVuqON1druGVBdS2i78AlxRinj
         7Si0crii00wO3Gf8Ev+iXC2ouhBU3Cz2UPiqH/64H4wmCl4bu7lNvOlOsgPZ5TGFl8
         A7xZ2mFvRZCg16OMW/MtBGWOhn7EdFlB2cAQdenI=
Received: by mail-oi1-f181.google.com with SMTP id c13so6806083oiy.6
        for <linux-efi@vger.kernel.org>; Tue, 15 Sep 2020 22:55:03 -0700 (PDT)
X-Gm-Message-State: AOAM532sbQTe1f9LAoGHrZDgzeG+yOnibQjMh+rjsqcKDha4sAguU506
        VyJrAorccS4Q2OHbAgUgdtWjkUu0l6M+TIl8ugY=
X-Google-Smtp-Source: ABdhPJw2gxrHIc/g4Wrr8JKveY0Bas6j0uYN3EXPrtqdkIctqsWz818fHnqq2VkabP2C+AjDdi8J3EanLAGpNoe+WoE=
X-Received: by 2002:aca:d845:: with SMTP id p66mr1941259oig.47.1600235703000;
 Tue, 15 Sep 2020 22:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200914095706.3985-1-ardb@kernel.org> <CAKwvOdmSXm7cV3hB_Yp=DD0RwwDHtPzzDBU8Xj5kBREn3xqYdA@mail.gmail.com>
 <CAMj1kXGuFFUyT48EYvzFmjCP4QZi_Sk_GpBrBCaHjP7HKLhjBA@mail.gmail.com> <CAKwvOdmkNgi_+kfauTSLwtpVChipW851_KGJG+gBbhwRxJJORA@mail.gmail.com>
In-Reply-To: <CAKwvOdmkNgi_+kfauTSLwtpVChipW851_KGJG+gBbhwRxJJORA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 16 Sep 2020 08:54:52 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHTkP7-8xscGZGXN_0Sq=BCSnt3zWqkcm8xdO11xmditA@mail.gmail.com>
Message-ID: <CAMj1kXHTkP7-8xscGZGXN_0Sq=BCSnt3zWqkcm8xdO11xmditA@mail.gmail.com>
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

On Wed, 16 Sep 2020 at 02:31, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Sep 15, 2020 at 2:30 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Excellent, thanks for testing. Do you have any coverage for Thumb2
> > builds as well? (CONFIG_THUMB2_KERNEL=y)
>
> Ah, right, manually testing ARCH=arm defconfig with
> CONFIG_THUMB2_KERNEL enabled via menuconfig:
>
> Builds and boots for clang.
>
> (Also needed https://lore.kernel.org/lkml/20200915225751.274531-1-ndesaulniers@google.com/T/#u
> for an unrelated issue).
>
> For GCC, I observe:
>
> arch/arm/vfp/vfphw.o: in function `vfp_support_entry':
> (.text+0xa): relocation truncated to fit: R_ARM_THM_JUMP19 against
> symbol `vfp_kmode_exception' defined in .text.unlikely section in
> arch/arm/vfp/vfpmodule.o
>

Interesting. And this is using ld.bfd ?

> There doesn't seem to be a config option to work around that for now.
> Though it's not caused by your series; if I drop your series, I can
> still reproduce.
>
> Is there a different config I should be testing rather than
> defconfig+manual testing, like one of the existing configs? Looks like
> only milbeaut_m10v_defconfig enable THUMB2 by default.  I should add
> that to my CI and kernelCI for coverage with clang.
> https://github.com/ClangBuiltLinux/continuous-integration/issues/94#issuecomment-693030376
>
> milbeaut_m10v_defconfig
> builds with your series for clang.  Looks like that config may be
> currently broken for GCC?
> Looks like it doesn't boot with Clang, so I'll need to debug that.
> Again, both of the two past sentences are regardless of your series.
> So your series still LGTM.

Cheers.

I usually build multi_v7_defconfig with/wihout CONFIG_LPAE x
with/without CONFIG_THUMB2_KERNEL (LPAE affects the size of
dma_addr_t, and uses a different page table format, so it is a useful
bit to flick in testing)
