Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F0B26AB26
	for <lists+linux-efi@lfdr.de>; Tue, 15 Sep 2020 19:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgIORwU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Sep 2020 13:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgIORwB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Sep 2020 13:52:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FB8C06174A
        for <linux-efi@vger.kernel.org>; Tue, 15 Sep 2020 10:51:52 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t7so177024pjd.3
        for <linux-efi@vger.kernel.org>; Tue, 15 Sep 2020 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUJXVal1T9lkOHh61E9/zYhKXGNr6sM1xyG4nDzvCM0=;
        b=Go0+SU6OxnS5J69Ze490rjsorVvBt5xKNRdnJr8hL6FOm24PqZYlHQeTLDOGXTb5Mb
         OGkThFEzlvqO9EmyA2MvVro0R1/NZgmFlDVzAo6gAzBVd+N8BWqGfrpJLhc0A4mRC6Cm
         IQcIESGJsSD+otEete5Lh7cbIrBjK555ssrLSIM4tXmZwHstMa60eEwcMlsd4+7IPzYH
         ZLQ0Ah0wkgKP5zieoy4lRr/+P89EkaamcM2IPoD/e7CnGBncUFPU7ybPRxu0k6WGj1E4
         i5/17zoDmhKHWpGD0aXJoKn4LYm/dvtMqO9jaoBJrEnc2PuYiHgOMcatJPrl+l9wAkZY
         g83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUJXVal1T9lkOHh61E9/zYhKXGNr6sM1xyG4nDzvCM0=;
        b=HbiDwZvu7WJ45rh9baM7IX195F2z1W/ps6UEYNgimMStBsIOVSShddZnSrgtYrC6GO
         Eu4YI9AnlvsvXU5bzcNlGbRzvgf4r8HWzglRcU9SB0LCuYbWaXAIhHnkMeWXKvMO+giE
         Mf2wSVj8pxErGHd1l0uPdB7xuDCOrubPeteJk5YWNnXWwnrLk5h10WRyU8heC0/U7Mqe
         uYMhK4Z7zcIYlDzlf1ikLmO3Y7cbNROJZ3nzNS0xiwRX5hq+6SmcTRTpc65V4BzAye+5
         ptZHiNk98Jaco5kRLYfDRcwf1zMPw6uO0ykENRSS6U0OCcIEDhe7kscT4k+QpBSLVk2T
         15Og==
X-Gm-Message-State: AOAM533AE1XJysr2hMqS4sBgsCUqBsWXuhz3lv34rOLwlyd1Xps8bGBd
        oTXMcyvsdAWiZZtJCVkHMTDzkwFuK7kDJVwW0E+Jrw==
X-Google-Smtp-Source: ABdhPJx3RcRf5KejtFp6FJHImqjd8g1OT5d8REUYqkYEfxzAg7k8ETLY7c3QMtkThlVVVTjnQpjd0fQXLOsNQeqt5V4=
X-Received: by 2002:a17:90b:889:: with SMTP id bj9mr469458pjb.101.1600192311693;
 Tue, 15 Sep 2020 10:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200914095706.3985-1-ardb@kernel.org> <20200914095706.3985-2-ardb@kernel.org>
 <CAMj1kXFmF_24d-7W8AWTJR-PCcja7bUdHhYKptGQmsV4vNp=sA@mail.gmail.com>
In-Reply-To: <CAMj1kXFmF_24d-7W8AWTJR-PCcja7bUdHhYKptGQmsV4vNp=sA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 10:51:40 -0700
Message-ID: <CAKwvOdm0YstZVnSaDujTa0bC6cEzfQcR2gi34wGqwe1wb19Nww@mail.gmail.com>
Subject: Re: [PATCH 01/12] ARM: assembler: introduce adr_l, ldr_l and str_l macros
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 15, 2020 at 12:35 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 14 Sep 2020 at 12:57, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> > index feac2c8b86f2..39e972eaaa3f 100644
> > --- a/arch/arm/include/asm/assembler.h
> > +++ b/arch/arm/include/asm/assembler.h
> > @@ -494,4 +494,88 @@ THUMB(     orr     \reg , \reg , #PSR_T_BIT        )
> >  #define _ASM_NOKPROBE(entry)
> >  #endif
> >
> > +       .macro          __adldst_l, op, reg, sym, tmp, c
> > +       .if             __LINUX_ARM_ARCH__ < 7
> > +       ldr\c           \tmp, .La\@
> > +       .subsection     1
> > +       .align          2
> > +.La\@: .long           \sym - .Lpc\@
> > +       .previous
> > +       .else
> > +       .ifnb           \c
> > + THUMB(        ittt            \c                      )
> > +       .endif
> > +       movw\c          \tmp, #:lower16:\sym - .Lpc\@
> > +       movt\c          \tmp, #:upper16:\sym - .Lpc\@
> > +       .endif
> > +
> > +#ifndef CONFIG_THUMB2_KERNEL
> > +       .set            .Lpc\@, . + 8                   // PC bias
> > +       .ifc            \op, add
> > +       add\c           \reg, \tmp, pc
> > +       .else
> > +       \op\c           \reg, [\tmp, pc]
>
> This should be
>
>        \op\c           \reg, [pc, \tmp]

That looks better.  I had tested this series yesterday and wasn't able
to build with either toolchains.  Was going to ask if I was using the
wrong base or if there was an issue with my version binutils.  All
good now, I'll try to hammer on this a bit.
-- 
Thanks,
~Nick Desaulniers
