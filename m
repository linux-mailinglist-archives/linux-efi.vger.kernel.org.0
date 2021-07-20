Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5223CFA35
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 15:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhGTMb6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 08:31:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:57962 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235727AbhGTMbz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 08:31:55 -0400
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 16KDAJVj025797;
        Tue, 20 Jul 2021 08:10:19 -0500
Message-ID: <0e1280c9ca789e15a46b65f6796a8c333a9da18a.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] arm64: efi: kaslr: Fix boot failure if
 efi_random_alloc() fails
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org Will Deacon" <will@kernel.org>
Date:   Tue, 20 Jul 2021 23:10:18 +1000
In-Reply-To: <CAMj1kXEuuiGELD-9Yruens_jKr7vY=dH3LkuyfhkxTK2SPQZfw@mail.gmail.com>
References: <161920fc31ec4168290ca31b3e4ac7a75ac1df6b.camel@kernel.crashing.org>
         <CAMj1kXEuuiGELD-9Yruens_jKr7vY=dH3LkuyfhkxTK2SPQZfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2021-07-20 at 14:57 +0200, Ard Biesheuvel wrote:
> On Tue, 20 Jul 2021 at 13:14, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > If efi_random_alloc() fails, we still try to use EFI_KIMG_ALIGN
> > instead of MIN_KIMG_ALIGN to check the kernel image alignment,
> > which is incorrect, we need to fallback to MIN_KIMG_ALIGN (2M).
> > 
> 
> Why? Relocatable kernels can happily execute from any 64k aligned
> address, and the PE/COFF header carries this value of 64k as the
> minimum alignment.

This is not what I'm changing. If you look at the code before the
patch, it was *already* only allowing 64k alignment with kaslr enabled
(commit 7c116db24d94). There's even a big fat comment explaining why
though it could use more details.

In any case, the code isn't even testing for CONFIG_RELOCATABLE today,
it makes its decisions entirely based on kaslr and doesn't properly
handle the case where efi_random_alloc() fails.

This fixes it.

Cheers,
Ben.


> > This removes the not-that-useful min_kimg_align helper and instead
> > uses the appropriate aligment in the respective call sites:
> > 
> > efi_random_alloc() always wants EFI_KIMG_ALIGN as this is only
> > used when kaslr is on, and all other cases go into alignment
> > check code which always need to check (and enforce) MIN_KIMG_ALIGN
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Fixes: 7c116db24d94 (efi/libstub/arm64: Retain 2MB kernel Image alignment if !KASLR)
> > ---
> >  drivers/firmware/efi/libstub/arm64-stub.c | 27 ++++++++++-------------
> >  1 file changed, 12 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> > index 7bf0a7acae5e..e264ff90ba03 100644
> > --- a/drivers/firmware/efi/libstub/arm64-stub.c
> > +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> > @@ -34,18 +34,6 @@ efi_status_t check_platform_features(void)
> >         return EFI_SUCCESS;
> >  }
> > 
> > -/*
> > - * Although relocatable kernels can fix up the misalignment with respect to
> > - * MIN_KIMG_ALIGN, the resulting virtual text addresses are subtly out of
> > - * sync with those recorded in the vmlinux when kaslr is disabled but the
> > - * image required relocation anyway. Therefore retain 2M alignment unless
> > - * KASLR is in use.
> > - */
> > -static u64 min_kimg_align(void)
> > -{
> > -       return efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
> > -}
> > -
> >  efi_status_t handle_kernel_image(unsigned long *image_addr,
> >                                  unsigned long *image_size,
> >                                  unsigned long *reserve_addr,
> > @@ -84,15 +72,24 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
> >                 /*
> >                  * If KASLR is enabled, and we have some randomness available,
> >                  * locate the kernel at a randomized offset in physical memory.
> > +                *
> > +                * In that case, we don't need to preserve the 2M alignment
> >                  */
> > -               status = efi_random_alloc(*reserve_size, min_kimg_align(),
> > +               status = efi_random_alloc(*reserve_size, EFI_KIMG_ALIGN,
> >                                           reserve_addr, phys_seed);
> >         } else {
> >                 status = EFI_OUT_OF_RESOURCES;
> >         }
> > 
> >         if (status != EFI_SUCCESS) {
> > -               if (IS_ALIGNED((u64)_text, min_kimg_align())) {
> > +               /*
> > +                * Although relocatable kernels can fix up the misalignment with respect to
> > +                * MIN_KIMG_ALIGN, the resulting virtual text addresses are subtly out of
> > +                * sync with those recorded in the vmlinux when kaslr is disabled but the
> > +                * image required relocation anyway. Therefore retain 2M alignment unless
> > +                * KASLR is in use.
> > +                */
> > +               if (IS_ALIGNED((u64)_text, MIN_KIMG_ALIGN)) {
> >                         /*
> >                          * Just execute from wherever we were loaded by the
> >                          * UEFI PE/COFF loader if the alignment is suitable.
> > @@ -103,7 +100,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
> >                 }
> > 
> >                 status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
> > -                                                   ULONG_MAX, min_kimg_align());
> > +                                                   ULONG_MAX, MIN_KIMG_ALIGN);
> > 
> >                 if (status != EFI_SUCCESS) {
> >                         efi_err("Failed to relocate kernel\n");
> > 
> > 
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

