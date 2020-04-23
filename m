Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D951B5AC0
	for <lists+linux-efi@lfdr.de>; Thu, 23 Apr 2020 13:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgDWLtU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Apr 2020 07:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbgDWLtU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 23 Apr 2020 07:49:20 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 532562098B
        for <linux-efi@vger.kernel.org>; Thu, 23 Apr 2020 11:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587642559;
        bh=fhN+xcgVOvDvyMkZUHLzYZ2fs6t4eybeDRgxIVFs5ZA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eo9N4O3Oj6dp/4W8C2GUl964dkWnzFCvPX1rEf+puflB84+oFFjz/hCNJHyM6I91L
         0iRS0C4tg9ZfOjwhdWh6aslQ0iC1Q7IJwXJze5MmZ/HdhyFpkAsagl+0LhlMKxTfua
         u3blbKlHvP4Ws0sFV8jINTsy2Zf7EGT0ey11424g=
Received: by mail-il1-f171.google.com with SMTP id e8so5216421ilm.7
        for <linux-efi@vger.kernel.org>; Thu, 23 Apr 2020 04:49:19 -0700 (PDT)
X-Gm-Message-State: AGi0PuYIBQxGrPsHGsOGgszChb0/BQbFsRtO8srrIXnRIIXG/MpStHaA
        B4aOosmTIdmYrRtmIdmaX70E3jUXCXHMJstTvBU=
X-Google-Smtp-Source: APiQypK/bzpZv6rmWwkgua0YR1rCUqt9YZNlkKRquyWm5NmOQyn7m+Z57GzfqOTnY7EyCEDCxB0NUHC46D/aWYajfDU=
X-Received: by 2002:a92:39dd:: with SMTP id h90mr3006481ilf.80.1587642558710;
 Thu, 23 Apr 2020 04:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200422172414.6662-1-ardb@kernel.org> <20200422172414.6662-8-ardb@kernel.org>
 <47e7e7a64905eeec1094116234c80a0553b02346.camel@wdc.com> <CAMj1kXEYrKQrQGjb8Z4b8tVgpPK3_LiZPYLL8mK3vQaBW2OXgA@mail.gmail.com>
In-Reply-To: <CAMj1kXEYrKQrQGjb8Z4b8tVgpPK3_LiZPYLL8mK3vQaBW2OXgA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 23 Apr 2020 13:49:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGX5gOkX5WMd2Gh4NJ8UXVe42gOGeDhfkGUuCQhc6yJUw@mail.gmail.com>
Message-ID: <CAMj1kXGX5gOkX5WMd2Gh4NJ8UXVe42gOGeDhfkGUuCQhc6yJUw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] RISC-V: Add EFI stub support.
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 23 Apr 2020 at 13:15, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 22 Apr 2020 at 20:48, Atish Patra <Atish.Patra@wdc.com> wrote:
> >
> > On Wed, 2020-04-22 at 19:24 +0200, Ard Biesheuvel wrote:
> > > From: Atish Patra <atish.patra@wdc.com>
> > >
> > > Add a RISC-V architecture specific stub code that actually copies the
> > > actual kernel image to a valid address and jump to it after boot
> > > services
> > > are terminated. Enable UEFI related kernel configs as well for RISC-
> > > V.
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > Link:
> > > https://lore.kernel.org/r/20200421033336.9663-4-atish.patra@wdc.com
> > > [ardb: - move hartid fetch into check_platform_features()
> > >        - use image_size not reserve_size
> > >        - moved asm/efi.h addition into separate patch ]
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/riscv/Kconfig                        |  20 ++++
> > >  arch/riscv/Makefile                       |   1 +
> > >  arch/riscv/configs/defconfig              |   1 +
> > >  drivers/firmware/efi/Kconfig              |   4 +-
> > >  drivers/firmware/efi/libstub/Makefile     |  10 ++
> > >  drivers/firmware/efi/libstub/riscv-stub.c | 109 ++++++++++++++++++++
> > >  6 files changed, 143 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index f05dd09acd48..54c78cafcd35 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -379,10 +379,30 @@ config CMDLINE_FORCE
> > >
> > >  endchoice
> > >
> > > +config EFI_STUB
> > > +     bool
> > > +
> > > +config EFI
> > > +     bool "UEFI runtime support"
> > > +     depends on OF
> > > +     select LIBFDT
> > > +     select UCS2_STRING
> > > +     select EFI_PARAMS_FROM_FDT
> > > +     select EFI_STUB
> > > +     select EFI_GENERIC_STUB
> >
> > As palmer suggested RISCV_ISA_C should be selected here to avoid
> > unintentional errors. Otherwise, every looks good.
> >
>
> Ah, I must have misunderstood. I thought using c.li instead of li was
> sufficient here.
>
>
> In any case, once Palmer confirms that he is ok with the approach I
> suggested, he can fix that up when applying the patches.
>

Actually, I can do slightly better, and put the asm/efi.h patch back
into this one.

I'll do a respin once we've agreed that this is the approach we are taking.
