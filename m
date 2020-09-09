Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AF6262D60
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 12:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgIIKoB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 06:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIIKoA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Sep 2020 06:44:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B58AC061755
        for <linux-efi@vger.kernel.org>; Wed,  9 Sep 2020 03:43:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so1779317pfa.10
        for <linux-efi@vger.kernel.org>; Wed, 09 Sep 2020 03:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0Fsk6Jnv3MENMkT7rSPlLPNZLuDbdUcu1ivYDd9EO0=;
        b=vhes60Wkr9Kt3qUeQbVH8RN+X5EzMn0QmaJddT0jEaWXocVnHucaji2O2s5Oh9f/23
         uVSYg3RVfFqRgz36/BQJmkdCyVZ3jA5AjPUbuFRl1oaQ5p8gRzioL629EXrriaZ6/Ofh
         zpaBYpN5wQDVWmBR3/u5ii5mmvxUUBSAg4ecgai43reuH9v1IKq/8qctGrpAavVAxjFl
         s6Tyi49bYt0sNubyHnHVYgBMVPygeP39h43tzKoTZosMrNTyHU5dX7sqyCHognLlXJIR
         cIg4NIoqI/Jo+o7JzE65jTPSSsgnPgEEZsQ1MxpfCG+LFfl7qHKFD1zxyVd8siqNhgyz
         Ispg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0Fsk6Jnv3MENMkT7rSPlLPNZLuDbdUcu1ivYDd9EO0=;
        b=P30b/901NLVCWb94AB55yIAQrDlr4oURMM7Bvlb8/pZTBepGf+PrPXaF6cF45P72wm
         huCnS6wImEO6mQ3mLWMNb8IMeELaiHfhPpF4TPtkA76iTsBIr3IQ85TrP0s28ZPi1Gkn
         t9uzZnqz46duNY6DBznGxuGBZvFhCn0C7NlO95TMULYzqA14yIM5A9pCmhY8WS51xdD/
         bjJq4vNAMLefHFKKSUQBJjDN7kVq4/fwc+jYSOkcjwGPUI5RqXxlHshqivTXgReOHFlr
         CeR/Uy/HkuokUrLyiTxFmkxIXMFxdXMhmcBtNYcWSIL/VrKM7KB5aPeLMsdFIJBtpy/+
         1t6w==
X-Gm-Message-State: AOAM5303dAapnWxGvRUWIuqA/mFcMPVa4E2qkicQ/LMc40xOCrjJ9/4A
        42/cX6O/h+6G/I93+OjBplZ5srwyrV851eJjdDWSbQ==
X-Google-Smtp-Source: ABdhPJymEDwwlQuvxiiyEaaVzM1aZJrgbnlYUQRMEvYlaiHYHvqHej7N4Z67i1Dy5Kxx115NyL3NACF6oAFptlzDLCk=
X-Received: by 2002:a62:8349:: with SMTP id h70mr287020pfe.47.1599648239050;
 Wed, 09 Sep 2020 03:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155025.55718-1-xypron.glpk@gmx.de> <CAMj1kXGYpMMrQPgL-SNde75EbDX8RZBDrboEuMcjJ7-cyEJUXg@mail.gmail.com>
In-Reply-To: <CAMj1kXGYpMMrQPgL-SNde75EbDX8RZBDrboEuMcjJ7-cyEJUXg@mail.gmail.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Wed, 9 Sep 2020 13:43:48 +0300
Message-ID: <CAD8XO3YGUUz6B4NDBC-f4Rfhhyya6GPwjW2oxP=GANRoNyydsQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: DRAM base calculation
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 9 Sep 2020 at 11:17, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (+ Atish, Palmer)
>
> On Fri, 4 Sep 2020 at 18:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > In the memory map the regions with the lowest addresses may be of type
> > EFI_RESERVED_TYPE. The reserved areas may be discontinuous relative to the
> > rest of the memory. So for calculating the maximum loading address for the
> > device tree and the initial ramdisk image these reserved areas should not
> > be taken into account.
> >
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >  drivers/firmware/efi/libstub/efi-stub.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> > index c2484bf75c5d..13058ac75765 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub.c
> > @@ -106,7 +106,8 @@ static unsigned long get_dram_base(void)
> >         map.map_end = map.map + map_size;
> >
> >         for_each_efi_memory_desc_in_map(&map, md) {
> > -               if (md->attribute & EFI_MEMORY_WB) {
> > +               if (md->attribute & EFI_MEMORY_WB &&
> > +                   md->type != EFI_RESERVED_TYPE) {
> >                         if (membase > md->phys_addr)
> >                                 membase = md->phys_addr;
> >                 }
> > --
> > 2.28.0
> >
>
> This is not the right fix - on RPi2, for instance, which has some
> reserved memory at the base of DRAM, this change will result in the
> first 16 MB of memory to be wasted.
>
In the EFI memmap provided to the kernel efi stub it will be 2
regions. First is EFI_RESERVED and second is EFI_CONVENTIONAL_MEMORY.
Even if they follow each other.
And for_each_efi_memory_desc_in_map will just return the second one.
Do not see where the problem is here.

> What I would prefer to do is get rid of get_dram_base() entirely -
> arm64 does not use its return value in the first place, and for ARM,
> the only reason we need it is so that we can place the uncompressed
> kernel image as low in memory as possible, and there are probably
> better ways to do that. RISC-V just started using it too, but only
> passes it from handle_kernel_image() to efi_relocate_kernel(), and
> afaict, passing 0x0 there instead would not cause any problems.

For prior 5.8 kernels there was limitation for maximum address to
unpack the kernel. As I understand that was copy-pasted from x86 code,
and now is missing in 5.9. That is why the suggestion was to point
dram_base to the region where it's possible to allocate. I.e. I assume
that
patch was created not to the latest kernel. Removing the upper
allocation limit should work here.

Maxim.
