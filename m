Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161A620C072
	for <lists+linux-efi@lfdr.de>; Sat, 27 Jun 2020 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgF0JW7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Jun 2020 05:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgF0JW7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 27 Jun 2020 05:22:59 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8AE20768;
        Sat, 27 Jun 2020 09:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593249778;
        bh=ARyWigMo4Grv0OKY/VJy1kBAOavs8Wcx2VYSGAzPgks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=alfu06HdLDJlx9dHguCZCd6adJiGTpaZut2AgOBHIUONCJOpM+pf1RfMeMpQX6gYd
         FFWtixphoW0dkd7a4aOvlC3PWm4n10zA6kxsxqPe/qEi8Kxn9UDb4YPbPD8+DxA4/b
         Akehks0sO8iSVKe/feBFTukUQUImHpfY1YR2Gh18=
Received: by mail-oi1-f178.google.com with SMTP id e4so2061302oib.1;
        Sat, 27 Jun 2020 02:22:58 -0700 (PDT)
X-Gm-Message-State: AOAM53299oY+WOB4chkyeghUjkLw2/LlpvqcNZceQA/pHpSDC4dex6eh
        fybCaAN4Ajy+2m3cTgOe0EhWA3Q/8Gdf0V4WCnE=
X-Google-Smtp-Source: ABdhPJzXhP2MzfyfoCyaSQW0DSKdl3DV8flP5dJdRFPcAeVju94JAwoLPbhzsWceJ651vzoXIIf/QbZL/VTSeG7+3oo=
X-Received: by 2002:aca:d0d:: with SMTP id 13mr5614620oin.174.1593249777771;
 Sat, 27 Jun 2020 02:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200625234516.31406-1-atish.patra@wdc.com> <20200625234516.31406-2-atish.patra@wdc.com>
 <5e2ce2ae-5458-8579-576a-76721f7d3b08@gmx.de> <CAOnJCUKnB7kLdTh1-NaFNw4p6EammETzhUa-Uniq2rrC-7AaQg@mail.gmail.com>
 <CAMj1kXFyQiYPYB-81POq7agRW1ROt=2j3nN9wcpHGmr4YjmFCQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFyQiYPYB-81POq7agRW1ROt=2j3nN9wcpHGmr4YjmFCQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 27 Jun 2020 11:22:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFd3wpob228WOYOu3SG0r2SEbT0cZF1JkF6uwjzrmf2EQ@mail.gmail.com>
Message-ID: <CAMj1kXFd3wpob228WOYOu3SG0r2SEbT0cZF1JkF6uwjzrmf2EQ@mail.gmail.com>
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

On Sat, 27 Jun 2020 at 00:03, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 26 Jun 2020 at 23:56, Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Thu, Jun 25, 2020 at 7:43 PM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 6/26/20 1:45 AM, Atish Patra wrote:
> > > > 32bit gcc doesn't support modulo operation on 64 bit data. It results in
> > > > a __umoddi3 error while building EFI for 32 bit.
> > > >
> > > > Use bitwise operations instead of modulo operations to fix the issue.
> > > >
> > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > ---
> > > >  drivers/firmware/efi/libstub/alignedmem.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
> > > > index cc89c4d6196f..1de9878ddd3a 100644
> > > > --- a/drivers/firmware/efi/libstub/alignedmem.c
> > > > +++ b/drivers/firmware/efi/libstub/alignedmem.c
> > > > @@ -44,7 +44,7 @@ efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
> > > >       *addr = ALIGN((unsigned long)alloc_addr, align);
> > > >
> > > >       if (slack > 0) {
> > > > -             int l = (alloc_addr % align) / EFI_PAGE_SIZE;
> > > > +             int l = (alloc_addr & (align - 1)) / EFI_PAGE_SIZE;
> > >
> > > Here you rely on the compiler to silently convert the division by
> > > EFI_PAGE_SIZE into a right shift. Wouldn't it be cleaner to use
> > > EFI_PAGE_SHIFT to explicitly avoid a dependency on __udivdi3()?
> > >
> > > slack = (align >> EFI_PAGE_SHIFT) - 1;
> > > ...
> > > int l = (alloc_addr & (align - 1)) >> EFI_PAGE_SHIFT;
> > >
> >
> > Sure. I will update it in the next version. Thanks for the suggestion.
>
> Please don't. Dividing by EFI_PAGE_SIZE is perfectly fine, and is more readable.

Actually, I will take this patch as a fix right away - 32-bit ARM has
the same issue (although it does not actually incorporate this object
file)

In the meantime, please check how the stub gets pulled into your
kernel: the idea of a static library is that only the objects that are
used are included in the final build, but this turned out to be broken
for arm64 [0]. IOW, simply applying a similar change might fix your
build issue as well (assuming RISC-V does not actually call
efi_allocate_pages_aligned() anywhere)

[0] https://lore.kernel.org/linux-arm-kernel/20200604022031.164207-1-masahiroy@kernel.org/
