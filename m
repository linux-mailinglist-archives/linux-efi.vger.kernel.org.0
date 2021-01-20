Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02C92FD600
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 17:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403894AbhATQsv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 11:48:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403876AbhATQsm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 Jan 2021 11:48:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2CB023358
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611161279;
        bh=wlHr8FSIakTSJg6k7/Rj6OgjenxviMEpS89F+nfClzA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R0E8ikE5D0HJ9NTcB2oHyx7SxYf6ZZCWayPBdal9q+r1GAMQ/P0EvY/usm7x6eV2M
         TrSx1X+b/eVKHyaZiK76PML1PONWz/JelWjuG1NpzsapoMr13uke5t87Y55EvJVok/
         tMIURlMLBusm0BH9ZCBQW5jOYwsJPdCESR1nCT8v76JApNCUm8mLKrfcK9fvNVBkb8
         VCIxMtOzj2oDWU9y8Os4bzBtM/PJBkYHaqEQoQS6eWM8q8Usqy6XZ7mcC80rNN2nRe
         IZ+wlxVKwhKRyn2W4UOWBrai9UmI45P6w1S0WIzT+HLKkP8M4+6nW36Rmmli8foAjg
         TvKEas+aP0E9A==
Received: by mail-oi1-f177.google.com with SMTP id d189so25654249oig.11
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 08:47:59 -0800 (PST)
X-Gm-Message-State: AOAM530A5wzKFlmhoJ0TIcgHeY1yd7T5tBHtwNaFLgOocyPZtzSfurGj
        cUjWvzI6FkCSEXOZ8Fn3X4oZGJ7fFPg/xe0upjs=
X-Google-Smtp-Source: ABdhPJypqczqO8KufT6AwejIsvsF5rA48VwtCCWqBuCWef8VOkwYSmWuB2bgAV3tdKJqKssbQsV+0Ddj5frpRVyoXqw=
X-Received: by 2002:aca:210f:: with SMTP id 15mr3398826oiz.174.1611161279159;
 Wed, 20 Jan 2021 08:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20210120163810.14973-1-broonie@kernel.org>
In-Reply-To: <20210120163810.14973-1-broonie@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 20 Jan 2021 17:47:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFVRzvBX40sf=ue0=5ndd5gW6u+=OD-VAMGqaErd5wHYw@mail.gmail.com>
Message-ID: <CAMj1kXFVRzvBX40sf=ue0=5ndd5gW6u+=OD-VAMGqaErd5wHYw@mail.gmail.com>
Subject: Re: [PATCH v2] efi/arm64: Update debug prints to reflect other
 entropy sources
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 20 Jan 2021 at 17:38, Mark Brown <broonie@kernel.org> wrote:
>
> Currently the EFI stub prints a diagnostic on boot saying that KASLR will
> be disabled if it is unable to use the EFI RNG protocol to obtain a seed
> for KASLR.  With the addition of support for v8.5-RNG and the SMCCC RNG
> protocol it is now possible for KASLR to obtain entropy even if the EFI
> RNG protocol is unsupported in the system, and the main kernel now
> explicitly says if KASLR is active itself.  This can result in a boot
> log where the stub says KASLR has been disabled and the main kernel says
> that it is enabled which is confusing for users.
>
> Remove the explicit reference to KASLR from the diagnostics, the warnings
> are still useful as EFI is the only source of entropy the stub uses when
> randomizing the physical address of the kernel and the other sources may
> not be available.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>
> v2: Remove all reference to KASLR from the log messages and clarify
>     physical address randomization use of the EFI RNG seed.
>

Thanks Mark. I will merge this in efi/next

>  drivers/firmware/efi/libstub/arm64-stub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index 22ece1ad68a8..b69d63143e0d 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -61,10 +61,10 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>                         status = efi_get_random_bytes(sizeof(phys_seed),
>                                                       (u8 *)&phys_seed);
>                         if (status == EFI_NOT_FOUND) {
> -                               efi_info("EFI_RNG_PROTOCOL unavailable, KASLR will be disabled\n");
> +                               efi_info("EFI_RNG_PROTOCOL unavailable\n");
>                                 efi_nokaslr = true;
>                         } else if (status != EFI_SUCCESS) {
> -                               efi_err("efi_get_random_bytes() failed (0x%lx), KASLR will be disabled\n",
> +                               efi_err("efi_get_random_bytes() failed (0x%lx)\n",
>                                         status);
>                                 efi_nokaslr = true;
>                         }
> --
> 2.20.1
>
