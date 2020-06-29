Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8166E20DBD4
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jun 2020 22:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgF2UKJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Jun 2020 16:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgF2UKI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Jun 2020 16:10:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D42CC061755
        for <linux-efi@vger.kernel.org>; Mon, 29 Jun 2020 13:10:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so17848092wrv.9
        for <linux-efi@vger.kernel.org>; Mon, 29 Jun 2020 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DuXPs2KRc0kRkrIeNHomDGkRgeQMj5m4hx2hmqHrvd0=;
        b=RwCEbkr7yIXMwaL6oCI6h3TFBrn9VLnCgp8TQCTIrSgyVQuzK7Iywclm3ny1C/A1j6
         CiUUsHeusFGkR4ofBNlMT4xs3Kk14kgzfpLpcB8o5VTHHC+x3qfdunD/jM1rZKGu8j+1
         HFbJcxtTP50PS+jYQqGKvl03Itsy8M6Zm5+f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DuXPs2KRc0kRkrIeNHomDGkRgeQMj5m4hx2hmqHrvd0=;
        b=gW8FUNukyRFF+7YGc3uh4tRXHXggghkvGjtKYg/dQkg27tQ0iSMAOfm1xM4+OQNilS
         OrWZ9VtIntb3KC8ZnEsALXefOhHn4QYALc3+JmsVKNBTPMH2FXUeU1ZwHzFiU5OJs1f5
         i1nVBr/V4Rt18KCUF8VBxWZisBqiY5XiMDI0Xh4qcDuaQFfnwBIfomXXajDIG4avKb4K
         n0COjh7tHKqbTx4owwxURTZGvXPlJwd5uXVFXX5FnnY5j88mQNDnjFTfzvEjWoaWhA2N
         2kbrP9YQ1WAx6fsmwEovGH17g5dEX5nGLkfWZJeZc5PtWczkeA/8YoK9DiaAzDrpbJrq
         MXEQ==
X-Gm-Message-State: AOAM533IjO8niiUunIfgwXEeCIUrMVleKdy67/sdQaY/mppxTqxBWtK3
        OoK136QDX4xHLocej3wqJqp6oEgbWuiayl9g3X9Y
X-Google-Smtp-Source: ABdhPJxHxREtLEN5Xz2f+V7HyVEy8DgsTaByjDILcaX0i/Qvfu6F12G1pzyMk4t6el/9QubVSfamdtO8NvLTSslFfjc=
X-Received: by 2002:adf:e884:: with SMTP id d4mr17770822wrm.176.1593461406779;
 Mon, 29 Jun 2020 13:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200625234516.31406-1-atish.patra@wdc.com> <20200625234516.31406-2-atish.patra@wdc.com>
 <5e2ce2ae-5458-8579-576a-76721f7d3b08@gmx.de> <CAOnJCUKnB7kLdTh1-NaFNw4p6EammETzhUa-Uniq2rrC-7AaQg@mail.gmail.com>
 <CAMj1kXFyQiYPYB-81POq7agRW1ROt=2j3nN9wcpHGmr4YjmFCQ@mail.gmail.com> <CAMj1kXFd3wpob228WOYOu3SG0r2SEbT0cZF1JkF6uwjzrmf2EQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFd3wpob228WOYOu3SG0r2SEbT0cZF1JkF6uwjzrmf2EQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 29 Jun 2020 13:09:55 -0700
Message-ID: <CAOnJCUJAdMoTEtxn8Q0Frxi9fw6PS052e3jp2CSJszmGBPp4kA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/11] efi: Fix gcc error around __umoddi3 for 32 bit builds
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Sat, Jun 27, 2020 at 2:22 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sat, 27 Jun 2020 at 00:03, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 26 Jun 2020 at 23:56, Atish Patra <atishp@atishpatra.org> wrote:
> > >
> > > On Thu, Jun 25, 2020 at 7:43 PM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > On 6/26/20 1:45 AM, Atish Patra wrote:
> > > > > 32bit gcc doesn't support modulo operation on 64 bit data. It results in
> > > > > a __umoddi3 error while building EFI for 32 bit.
> > > > >
> > > > > Use bitwise operations instead of modulo operations to fix the issue.
> > > > >
> > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > > ---
> > > > >  drivers/firmware/efi/libstub/alignedmem.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
> > > > > index cc89c4d6196f..1de9878ddd3a 100644
> > > > > --- a/drivers/firmware/efi/libstub/alignedmem.c
> > > > > +++ b/drivers/firmware/efi/libstub/alignedmem.c
> > > > > @@ -44,7 +44,7 @@ efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
> > > > >       *addr = ALIGN((unsigned long)alloc_addr, align);
> > > > >
> > > > >       if (slack > 0) {
> > > > > -             int l = (alloc_addr % align) / EFI_PAGE_SIZE;
> > > > > +             int l = (alloc_addr & (align - 1)) / EFI_PAGE_SIZE;
> > > >
> > > > Here you rely on the compiler to silently convert the division by
> > > > EFI_PAGE_SIZE into a right shift. Wouldn't it be cleaner to use
> > > > EFI_PAGE_SHIFT to explicitly avoid a dependency on __udivdi3()?
> > > >
> > > > slack = (align >> EFI_PAGE_SHIFT) - 1;
> > > > ...
> > > > int l = (alloc_addr & (align - 1)) >> EFI_PAGE_SHIFT;
> > > >
> > >
> > > Sure. I will update it in the next version. Thanks for the suggestion.
> >
> > Please don't. Dividing by EFI_PAGE_SIZE is perfectly fine, and is more readable.
>
> Actually, I will take this patch as a fix right away - 32-bit ARM has
> the same issue (although it does not actually incorporate this object
> file)
>

Thanks. I will drop it from my next version in that case.

> In the meantime, please check how the stub gets pulled into your
> kernel: the idea of a static library is that only the objects that are
> used are included in the final build, but this turned out to be broken
> for arm64 [0]. IOW, simply applying a similar change might fix your
> build issue as well (assuming RISC-V does not actually call
> efi_allocate_pages_aligned() anywhere)
>
Sorry. I missed this thread earlier. Yes. Applying a similar change
fixes the static library linking for RISC-V. I don't see
efi_allocate_pages_aligned or efi_random_alloc
in vmlinux anymore. I will update my patch. Thanks.

I did not see any new version of the next patch in that series [1].
Thus, I am leaving libstub/Makefile changes
as it is. Please let me know if I missed something.

[1] https://lore.kernel.org/linux-efi/CAMj1kXGg-w6N7jyG0pBJmeRctAhG2wWGoU=ryWj+Qi2UH-_m9Q@mail.gmail.com/

> [0] https://lore.kernel.org/linux-arm-kernel/20200604022031.164207-1-masahiroy@kernel.org/



-- 
Regards,
Atish
