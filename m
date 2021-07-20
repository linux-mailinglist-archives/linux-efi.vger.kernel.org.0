Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0C53CFB45
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 15:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbhGTNND (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 09:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239145AbhGTNI3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 09:08:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A271E61164
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626788947;
        bh=Sdr8iqFPmQ+a70CVxKmCouaJgiJrqvqbjTzPlIv17Wo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s+q9eVEFcPPTnZ48vn+J/MPkE7vm0Uue/vVZGvD9yq9oAHJe7Y3uBzPgaJv8zARQE
         SkYnCdrAZfR10HV3Ww2mGT7aPeTfs7lEb90RFE9AzOHa4eDUt1T26zuQ7Fq8d7uBAi
         dBF9OxvCSSbgUzcrbt/+X2DbtVgn6daOH7L0vO9lkuA7QvmU/j2611gG8lxR/zlpas
         Y/Ndv1aeW4oUPoNbKt6GKn9g+Hh0KYj+D0vjNnySMsINHHNyVDRbRrTl1YecpTBm/Z
         xHG3CT2skCHoWD5DLY8AXbzsee0rZsAPF1eIydqx6F+4e6JLiylG/F4MRwLpEXP67b
         bEVv//oCRsxGA==
Received: by mail-ot1-f49.google.com with SMTP id t4-20020a05683014c4b02904cd671b911bso13501161otq.1
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 06:49:07 -0700 (PDT)
X-Gm-Message-State: AOAM531rU7Rl/JddEtZxORhxEUGf0MOXfujlszuhxm8q8OtlOy5J48Kl
        xbgMCxlUKWfrwwa0ZolnmLURqh5uLuwesMjKUCA=
X-Google-Smtp-Source: ABdhPJwjzW+xrvy/9VA5epjDOM/OtOrR/zhUgXQbZjbgvm9za8rfLuYhZpBfFrEUij4mYb9MOuoXyDZcpd7iRCpipD8=
X-Received: by 2002:a05:6830:2316:: with SMTP id u22mr22387932ote.90.1626788946995;
 Tue, 20 Jul 2021 06:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <161920fc31ec4168290ca31b3e4ac7a75ac1df6b.camel@kernel.crashing.org>
 <CAMj1kXEuuiGELD-9Yruens_jKr7vY=dH3LkuyfhkxTK2SPQZfw@mail.gmail.com> <0e1280c9ca789e15a46b65f6796a8c333a9da18a.camel@kernel.crashing.org>
In-Reply-To: <0e1280c9ca789e15a46b65f6796a8c333a9da18a.camel@kernel.crashing.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 20 Jul 2021 15:48:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEwFyTjoERo8KO2jWRYePCOAB2E8_y6jmv9LSfazc2t9g@mail.gmail.com>
Message-ID: <CAMj1kXEwFyTjoERo8KO2jWRYePCOAB2E8_y6jmv9LSfazc2t9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: efi: kaslr: Fix boot failure if
 efi_random_alloc() fails
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org Will Deacon" <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 20 Jul 2021 at 15:10, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Tue, 2021-07-20 at 14:57 +0200, Ard Biesheuvel wrote:
> > On Tue, 20 Jul 2021 at 13:14, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > > If efi_random_alloc() fails, we still try to use EFI_KIMG_ALIGN
> > > instead of MIN_KIMG_ALIGN to check the kernel image alignment,
> > > which is incorrect, we need to fallback to MIN_KIMG_ALIGN (2M).
> > >
> >
> > Why? Relocatable kernels can happily execute from any 64k aligned
> > address, and the PE/COFF header carries this value of 64k as the
> > minimum alignment.
>
> This is not what I'm changing. If you look at the code before the
> patch, it was *already* only allowing 64k alignment with kaslr enabled
> (commit 7c116db24d94). There's even a big fat comment explaining why
> though it could use more details.
>

But that only takes effect if efi_nokaslr is true, which is the
default if CONFIG_RANDOMIZE_BASE is not set

> In any case, the code isn't even testing for CONFIG_RELOCATABLE today,

No, it tests for CONFIG_RANDOMIZE_BASE, which implies CONFIG_RELOCATABLE.

> it makes its decisions entirely based on kaslr and doesn't properly
> handle the case where efi_random_alloc() fails.
>
> This fixes it.
>

You are replacing min_kimg_align() with MIN_KIMG_ALIGN in a place
where it could return either value: efi_nokaslr will be false by
default on relocatable kernels, in which case min_kimg_align() will
return EFI_KIMG_ALIGN, unless you specifically request KASLR to be
disabled.

The result is that relocatable kernels that would not require to be
moved will now be moved to a 2 MB aligned offset before booting them.

Similarly for the efi_allocate_pages_aligned() call: that call would
only request 64k alignment before on a relocatable kernel if booting
without randomization.



> > > This removes the not-that-useful min_kimg_align helper and instead
> > > uses the appropriate aligment in the respective call sites:
> > >
> > > efi_random_alloc() always wants EFI_KIMG_ALIGN as this is only
> > > used when kaslr is on, and all other cases go into alignment
> > > check code which always need to check (and enforce) MIN_KIMG_ALIGN
> > >
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Fixes: 7c116db24d94 (efi/libstub/arm64: Retain 2MB kernel Image alignment if !KASLR)
> > > ---
> > >  drivers/firmware/efi/libstub/arm64-stub.c | 27 ++++++++++-------------
> > >  1 file changed, 12 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> > > index 7bf0a7acae5e..e264ff90ba03 100644
> > > --- a/drivers/firmware/efi/libstub/arm64-stub.c
> > > +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> > > @@ -34,18 +34,6 @@ efi_status_t check_platform_features(void)
> > >         return EFI_SUCCESS;
> > >  }
> > >
> > > -/*
> > > - * Although relocatable kernels can fix up the misalignment with respect to
> > > - * MIN_KIMG_ALIGN, the resulting virtual text addresses are subtly out of
> > > - * sync with those recorded in the vmlinux when kaslr is disabled but the
> > > - * image required relocation anyway. Therefore retain 2M alignment unless
> > > - * KASLR is in use.
> > > - */
> > > -static u64 min_kimg_align(void)
> > > -{
> > > -       return efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
> > > -}
> > > -
> > >  efi_status_t handle_kernel_image(unsigned long *image_addr,
> > >                                  unsigned long *image_size,
> > >                                  unsigned long *reserve_addr,
> > > @@ -84,15 +72,24 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
> > >                 /*
> > >                  * If KASLR is enabled, and we have some randomness available,
> > >                  * locate the kernel at a randomized offset in physical memory.
> > > +                *
> > > +                * In that case, we don't need to preserve the 2M alignment
> > >                  */
> > > -               status = efi_random_alloc(*reserve_size, min_kimg_align(),
> > > +               status = efi_random_alloc(*reserve_size, EFI_KIMG_ALIGN,
> > >                                           reserve_addr, phys_seed);
> > >         } else {
> > >                 status = EFI_OUT_OF_RESOURCES;
> > >         }
> > >
> > >         if (status != EFI_SUCCESS) {
> > > -               if (IS_ALIGNED((u64)_text, min_kimg_align())) {
> > > +               /*
> > > +                * Although relocatable kernels can fix up the misalignment with respect to
> > > +                * MIN_KIMG_ALIGN, the resulting virtual text addresses are subtly out of
> > > +                * sync with those recorded in the vmlinux when kaslr is disabled but the
> > > +                * image required relocation anyway. Therefore retain 2M alignment unless
> > > +                * KASLR is in use.
> > > +                */
> > > +               if (IS_ALIGNED((u64)_text, MIN_KIMG_ALIGN)) {
> > >                         /*
> > >                          * Just execute from wherever we were loaded by the
> > >                          * UEFI PE/COFF loader if the alignment is suitable.
> > > @@ -103,7 +100,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
> > >                 }
> > >
> > >                 status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
> > > -                                                   ULONG_MAX, min_kimg_align());
> > > +                                                   ULONG_MAX, MIN_KIMG_ALIGN);
> > >
> > >                 if (status != EFI_SUCCESS) {
> > >                         efi_err("Failed to relocate kernel\n");
> > >
> > >
> > >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
