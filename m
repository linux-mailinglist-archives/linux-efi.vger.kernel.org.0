Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8DD3CF9F2
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhGTMRN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 08:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhGTMRM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 08:17:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1C70611C1
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626785870;
        bh=dmwCAbPzzugPfcBEh8+m9p9BBzUOd3QdAcJqITZsWK4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cFalQnwOyEZq3moumRc1Ke9aE+tOXqv4qaouODjdvZdkmJZW5UffL+xqUlYdKX/mL
         8PfNXxjxRTf0IGQr40Tza7EPbiOFg1AOB7xYN3T5WIUyFNsMVHmhjLRvNHGWR2uwLU
         olsn/gaOsSAwZtq5qduqyqqHJTWxJdADpa8zq25gF8o6OBuBJlLpJYmwKttd41tzBK
         bqUFkYOVpg+8Yro1QqAwjJ7zJcoCBmqvj9IrY4DdsvA8RU5rtpqP0/Z5uNtKvwBhmk
         CkfnYqdxEKvDNs9pzS+qxnPBRCqRTiLU/1DGpZxRHnjkmasH/yKoPiVArYNSfYFe+B
         r6To0Iz+nKTpg==
Received: by mail-oi1-f181.google.com with SMTP id t143so24375056oie.8
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 05:57:50 -0700 (PDT)
X-Gm-Message-State: AOAM530AQKRpOBglCEAUvZfvZBMbQGDsYl4FWJ0+a4hZn0CdU/WJJZ7L
        RX7kByN2lmCWfLirSwTBTlU47SDlhu3nLqGLy0Q=
X-Google-Smtp-Source: ABdhPJxHEL6G7qxxdro/y4rnEBsWoIPONzUsfP1AyQJyksrHA/QXBtS6WpycXDPQOpoSDy5m9WkCdRJGrbPuFQNIZL4=
X-Received: by 2002:aca:5a04:: with SMTP id o4mr20661479oib.33.1626785869976;
 Tue, 20 Jul 2021 05:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <161920fc31ec4168290ca31b3e4ac7a75ac1df6b.camel@kernel.crashing.org>
In-Reply-To: <161920fc31ec4168290ca31b3e4ac7a75ac1df6b.camel@kernel.crashing.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 20 Jul 2021 14:57:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEuuiGELD-9Yruens_jKr7vY=dH3LkuyfhkxTK2SPQZfw@mail.gmail.com>
Message-ID: <CAMj1kXEuuiGELD-9Yruens_jKr7vY=dH3LkuyfhkxTK2SPQZfw@mail.gmail.com>
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

On Tue, 20 Jul 2021 at 13:14, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> If efi_random_alloc() fails, we still try to use EFI_KIMG_ALIGN
> instead of MIN_KIMG_ALIGN to check the kernel image alignment,
> which is incorrect, we need to fallback to MIN_KIMG_ALIGN (2M).
>

Why? Relocatable kernels can happily execute from any 64k aligned
address, and the PE/COFF header carries this value of 64k as the
minimum alignment.

> This removes the not-that-useful min_kimg_align helper and instead
> uses the appropriate aligment in the respective call sites:
>
> efi_random_alloc() always wants EFI_KIMG_ALIGN as this is only
> used when kaslr is on, and all other cases go into alignment
> check code which always need to check (and enforce) MIN_KIMG_ALIGN
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: 7c116db24d94 (efi/libstub/arm64: Retain 2MB kernel Image alignment if !KASLR)
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 27 ++++++++++-------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index 7bf0a7acae5e..e264ff90ba03 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -34,18 +34,6 @@ efi_status_t check_platform_features(void)
>         return EFI_SUCCESS;
>  }
>
> -/*
> - * Although relocatable kernels can fix up the misalignment with respect to
> - * MIN_KIMG_ALIGN, the resulting virtual text addresses are subtly out of
> - * sync with those recorded in the vmlinux when kaslr is disabled but the
> - * image required relocation anyway. Therefore retain 2M alignment unless
> - * KASLR is in use.
> - */
> -static u64 min_kimg_align(void)
> -{
> -       return efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
> -}
> -
>  efi_status_t handle_kernel_image(unsigned long *image_addr,
>                                  unsigned long *image_size,
>                                  unsigned long *reserve_addr,
> @@ -84,15 +72,24 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>                 /*
>                  * If KASLR is enabled, and we have some randomness available,
>                  * locate the kernel at a randomized offset in physical memory.
> +                *
> +                * In that case, we don't need to preserve the 2M alignment
>                  */
> -               status = efi_random_alloc(*reserve_size, min_kimg_align(),
> +               status = efi_random_alloc(*reserve_size, EFI_KIMG_ALIGN,
>                                           reserve_addr, phys_seed);
>         } else {
>                 status = EFI_OUT_OF_RESOURCES;
>         }
>
>         if (status != EFI_SUCCESS) {
> -               if (IS_ALIGNED((u64)_text, min_kimg_align())) {
> +               /*
> +                * Although relocatable kernels can fix up the misalignment with respect to
> +                * MIN_KIMG_ALIGN, the resulting virtual text addresses are subtly out of
> +                * sync with those recorded in the vmlinux when kaslr is disabled but the
> +                * image required relocation anyway. Therefore retain 2M alignment unless
> +                * KASLR is in use.
> +                */
> +               if (IS_ALIGNED((u64)_text, MIN_KIMG_ALIGN)) {
>                         /*
>                          * Just execute from wherever we were loaded by the
>                          * UEFI PE/COFF loader if the alignment is suitable.
> @@ -103,7 +100,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>                 }
>
>                 status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
> -                                                   ULONG_MAX, min_kimg_align());
> +                                                   ULONG_MAX, MIN_KIMG_ALIGN);
>
>                 if (status != EFI_SUCCESS) {
>                         efi_err("Failed to relocate kernel\n");
>
>
>
