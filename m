Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85E81A8F0D
	for <lists+linux-efi@lfdr.de>; Wed, 15 Apr 2020 01:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392119AbgDNXVX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Apr 2020 19:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731159AbgDNXVS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Apr 2020 19:21:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B10FC061A0C
        for <linux-efi@vger.kernel.org>; Tue, 14 Apr 2020 16:21:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id u13so16138740wrp.3
        for <linux-efi@vger.kernel.org>; Tue, 14 Apr 2020 16:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Akt6ZAQGHaRTJUrRW2Zf3TKV1YjVqeM5FiXG7+zImvw=;
        b=Jw51V2KEOQMaSSYSL+gkRv7HTJqXzAef5ocUZ+sBQSJYxVxO7/IsfPqu4S17jQ0c2Y
         pbbEmiToUCtLfhPsSphan0fTlxvt0hWIh55QNbtoIX3Lp2IJAVqwJvSCeNvD11DnXVbV
         USM09YWvCFdCFBiVRoPcP2WsMNdbZ5YnJjMucFVrGyXpLU9Tz/mOYzvduHBsL98pdaPw
         6vawxpIL2SDsNPOHUaT+iSc97AhJtFJhWsNduAYYjlQ4xrea1VrlU0z81qcIhkH9FdyO
         wXYSIKYiEIt4vdqMY1eTTvDIbS9aLSM4r94e30nYpoTQfJacmhNOCDoMp13kzXlmDY19
         SRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Akt6ZAQGHaRTJUrRW2Zf3TKV1YjVqeM5FiXG7+zImvw=;
        b=ZObx6g0pTenbJU/KKGiFtK6dBcvCLx+WnbFx/XwA7aVBDD1sBB2GcNiffshBG35CZh
         ufSAw39Nyj/2H5aem85AhgCzOXg7GBRlpvu9JZy8x4WX2g1CFQSCNenphUCc0iIS02cK
         KkywHYkKA6yShCgTxDleFOY6/MyJWLhr8WvpX1Ih5Phnk9l5D36eF32MFhVto3BNYK2z
         NGCOyU5wj19nGTc3Qy4k+/SMTZE325Ii4sBcb0gs+0JhMvhKaKBMIpfn6biHWcxgoqw3
         G/9vfUPT8/AqXWeKjce3KCg3U1j9VmSQ4VqzJ+I9n6ox2WV0RJo9LDqpTpsND8AgwCGH
         OsdA==
X-Gm-Message-State: AGi0PuZ21Oj60GJJOBxfz578/IFIrhc7G6B0lslE5JJaemg8ltkYYamO
        suzNd+DEv5iAWpw5yhGpMBrFcACYlpZmRGzf896y
X-Google-Smtp-Source: APiQypL2Xl3d7jGjfVleYnu8TM4wOtvq8Jc0e2dxrEk+duqLr191UpFolPWLcboenobOiyjGumU7Elcku5YCr7JqH/k=
X-Received: by 2002:a5d:4443:: with SMTP id x3mr2157817wrr.162.1586906477109;
 Tue, 14 Apr 2020 16:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200413155521.24698-1-ardb@kernel.org> <20200413155521.24698-4-ardb@kernel.org>
In-Reply-To: <20200413155521.24698-4-ardb@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 14 Apr 2020 16:21:06 -0700
Message-ID: <CAOnJCUJa=XPdJnZX3QzZ7S79sa-=Njei-4g+NP3saR3NCk08Mg@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] efi/libstub/arm64: replace 'preferred' offset with
 alignment check
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, Jonathan.Cameron@huawei.com,
        nivedita@alum.mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 13, 2020 at 8:55 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The notion of a 'preferred' load offset for the kernel dates back to the
> times when the kernel's primary mapping overlapped with the linear region,
> and memory below it could not be used at all.
>
> Today, the arm64 kernel does not really care where it is loaded in physical
> memory, as long as the alignment requirements are met, and so there is no

Just for my understanding, why do we need a TEXT_OFFSET in that case ?
Is it just to provide an option for SoC vendors ?

> point in unconditionally moving the kernel to a new location in memory at
> boot. Instead, we can
> - check for a KASLR seed, and randomly reallocate the kernel if one is
>   provided
> - otherwise, check whether the alignment requirements are met for the
>   current placement of the kernel, and just run it in place if they are
> - finally, do an ordinary page allocation and reallocate the kernel to a
>   suitably aligned buffer anywhere in memory.
>
> By the same reasoning, there is no need to take TEXT_OFFSET into account
> if it is a round multiple of the minimum alignment, which is the usual
> case for relocatable kernels with TEXT_OFFSET randomization disabled.
> Otherwise, it suffices to use the relative misaligment of TEXT_OFFSET
> when reallocating the kernel.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 62 ++++++++------------
>  1 file changed, 25 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index fc9f8ab533a7..cfd535c13242 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -34,6 +34,15 @@ efi_status_t check_platform_features(void)
>         return EFI_SUCCESS;
>  }
>
> +/*
> + * Relocatable kernels can fix up the misalignment with respect to
> + * MIN_KIMG_ALIGN, so they only require a minimum alignment of EFI_KIMG_ALIGN
> + * (which accounts for the alignment of statically allocated objects such as
> + * the swapper stack.)
> + */
> +static const u64 min_kimg_align = IS_ENABLED(CONFIG_RELOCATABLE) ? EFI_KIMG_ALIGN
> +                                                                : MIN_KIMG_ALIGN;
> +
>  efi_status_t handle_kernel_image(unsigned long *image_addr,
>                                  unsigned long *image_size,
>                                  unsigned long *reserve_addr,
> @@ -43,7 +52,6 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>  {
>         efi_status_t status;
>         unsigned long kernel_size, kernel_memsize = 0;
> -       unsigned long preferred_offset;
>         u64 phys_seed = 0;
>
>         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> @@ -61,14 +69,8 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>                 }
>         }
>
> -       /*
> -        * The preferred offset of the kernel Image is TEXT_OFFSET bytes beyond
> -        * a 2 MB aligned base, which itself may be lower than dram_base, as
> -        * long as the resulting offset equals or exceeds it.
> -        */
> -       preferred_offset = round_down(dram_base, MIN_KIMG_ALIGN) + TEXT_OFFSET;
> -       if (preferred_offset < dram_base)
> -               preferred_offset += MIN_KIMG_ALIGN;
> +       if (image->image_base != _text)
> +               pr_efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
>
>         kernel_size = _edata - _text;
>         kernel_memsize = kernel_size + (_end - _edata);
> @@ -103,46 +105,32 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>
>                 *image_addr = *reserve_addr + offset;
>         } else {
> -               /*
> -                * Else, try a straight allocation at the preferred offset.
> -                * This will work around the issue where, if dram_base == 0x0,
> -                * efi_low_alloc() refuses to allocate at 0x0 (to prevent the
> -                * address of the allocation to be mistaken for a FAIL return
> -                * value or a NULL pointer). It will also ensure that, on
> -                * platforms where the [dram_base, dram_base + TEXT_OFFSET)
> -                * interval is partially occupied by the firmware (like on APM
> -                * Mustang), we can still place the kernel at the address
> -                * 'dram_base + TEXT_OFFSET'.
> -                */
> -               *image_addr = (unsigned long)_text;
> -               if (*image_addr == preferred_offset)
> -                       return EFI_SUCCESS;
> -
> -               *image_addr = *reserve_addr = preferred_offset;
> -               *reserve_size = round_up(kernel_memsize, EFI_ALLOC_ALIGN);
> -
> -               status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
> -                                    EFI_LOADER_DATA,
> -                                    *reserve_size / EFI_PAGE_SIZE,
> -                                    (efi_physical_addr_t *)reserve_addr);
> +               status = EFI_OUT_OF_RESOURCES;
>         }
>
>         if (status != EFI_SUCCESS) {
> -               *reserve_size = kernel_memsize + TEXT_OFFSET;
> +               if (IS_ALIGNED((u64)_text - TEXT_OFFSET, min_kimg_align)) {
> +                       /*
> +                        * Just execute from wherever we were loaded by the
> +                        * UEFI PE/COFF loader if the alignment is suitable.
> +                        */
> +                       *image_addr = (u64)_text;
> +                       *reserve_size = 0;
> +                       return EFI_SUCCESS;
> +               }
> +
> +               *reserve_size = kernel_memsize + TEXT_OFFSET % min_kimg_align;
>                 status = efi_low_alloc(*reserve_size,
> -                                      MIN_KIMG_ALIGN, reserve_addr);
> +                                      min_kimg_align, reserve_addr);
>
>                 if (status != EFI_SUCCESS) {
>                         pr_efi_err("Failed to relocate kernel\n");
>                         *reserve_size = 0;
>                         return status;
>                 }
> -               *image_addr = *reserve_addr + TEXT_OFFSET;
> +               *image_addr = *reserve_addr + TEXT_OFFSET % min_kimg_align;
>         }
>
> -       if (image->image_base != _text)
> -               pr_efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
> -
>         memcpy((void *)*image_addr, _text, kernel_size);
>
>         return EFI_SUCCESS;
> --
> 2.17.1
>

Looks good to me. FWIW,

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
