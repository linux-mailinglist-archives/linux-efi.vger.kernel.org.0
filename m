Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276C320BC1B
	for <lists+linux-efi@lfdr.de>; Sat, 27 Jun 2020 00:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFZWD7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Jun 2020 18:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgFZWD7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 26 Jun 2020 18:03:59 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 631B02089D;
        Fri, 26 Jun 2020 22:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593209038;
        bh=WOQTvXobQ4W5JjaUMq7kWZE0jMQeOGk5MGW4rZFNYmQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FJoUvBwf+2SSHz2fr5vxPYd6aoefwHL0tlm86G/9+r8GmMcp2ZfwG8v/QP7defuDT
         D6lsId8SoNK8CT/QFVljdlp7a2LKRNtj3CK7eEWI766szCKWXBke3IKnvh4VpFJvxX
         DKoi6BJrlVFKVMovm4nd8G3e0rQBjBfAenxKjkPE=
Received: by mail-oi1-f179.google.com with SMTP id k4so9332362oik.2;
        Fri, 26 Jun 2020 15:03:58 -0700 (PDT)
X-Gm-Message-State: AOAM5308w1Yb/XT7UKtcwSKFIgbRW2pJ7IzRgfo6kYgCPCk6Xf5Ao4AX
        UZGQBxQW5rAu8k34QGjVdAF9JQLu2NuQ3QcpBUg=
X-Google-Smtp-Source: ABdhPJyA7RXVNdsucLUlBYRk00ByTmKYmzuM59N4650Dy8dEYBHPZ8+pPQ4fBTN9TdwDgfB6PHfzTHaYzf0UmhXyeYs=
X-Received: by 2002:aca:ba03:: with SMTP id k3mr4145023oif.33.1593209037748;
 Fri, 26 Jun 2020 15:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200625234516.31406-1-atish.patra@wdc.com> <20200625234516.31406-2-atish.patra@wdc.com>
 <5e2ce2ae-5458-8579-576a-76721f7d3b08@gmx.de> <CAOnJCUKnB7kLdTh1-NaFNw4p6EammETzhUa-Uniq2rrC-7AaQg@mail.gmail.com>
In-Reply-To: <CAOnJCUKnB7kLdTh1-NaFNw4p6EammETzhUa-Uniq2rrC-7AaQg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 27 Jun 2020 00:03:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFyQiYPYB-81POq7agRW1ROt=2j3nN9wcpHGmr4YjmFCQ@mail.gmail.com>
Message-ID: <CAMj1kXFyQiYPYB-81POq7agRW1ROt=2j3nN9wcpHGmr4YjmFCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/11] efi: Fix gcc error around __umoddi3 for 32 bit builds
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 26 Jun 2020 at 23:56, Atish Patra <atishp@atishpatra.org> wrote:
>
> On Thu, Jun 25, 2020 at 7:43 PM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 6/26/20 1:45 AM, Atish Patra wrote:
> > > 32bit gcc doesn't support modulo operation on 64 bit data. It results in
> > > a __umoddi3 error while building EFI for 32 bit.
> > >
> > > Use bitwise operations instead of modulo operations to fix the issue.
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >  drivers/firmware/efi/libstub/alignedmem.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
> > > index cc89c4d6196f..1de9878ddd3a 100644
> > > --- a/drivers/firmware/efi/libstub/alignedmem.c
> > > +++ b/drivers/firmware/efi/libstub/alignedmem.c
> > > @@ -44,7 +44,7 @@ efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
> > >       *addr = ALIGN((unsigned long)alloc_addr, align);
> > >
> > >       if (slack > 0) {
> > > -             int l = (alloc_addr % align) / EFI_PAGE_SIZE;
> > > +             int l = (alloc_addr & (align - 1)) / EFI_PAGE_SIZE;
> >
> > Here you rely on the compiler to silently convert the division by
> > EFI_PAGE_SIZE into a right shift. Wouldn't it be cleaner to use
> > EFI_PAGE_SHIFT to explicitly avoid a dependency on __udivdi3()?
> >
> > slack = (align >> EFI_PAGE_SHIFT) - 1;
> > ...
> > int l = (alloc_addr & (align - 1)) >> EFI_PAGE_SHIFT;
> >
>
> Sure. I will update it in the next version. Thanks for the suggestion.

Please don't. Dividing by EFI_PAGE_SIZE is perfectly fine, and is more readable.
