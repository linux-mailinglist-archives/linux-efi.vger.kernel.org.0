Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F532FCCE6
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 09:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbhATIks (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 03:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730960AbhATIkX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 Jan 2021 03:40:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25D23225AA
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611131979;
        bh=sszSjZ3LO3VSlgmeu0qVt/nqN9HznY3qWh7fkY/5+Us=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i5efAGJWVTEF4LY4OMukEl5HR5Qsabjk1Bi1vyxkSfD11272PBeYzzQYmMGf5t72m
         JMg/Elnmq1c5nPb8l9mL9/BWDu0XWuK5KNbnM81rWx/RJaXWemjXadIKMpiPa2h+oH
         Krgj65ZOwbVPWxl7aetNIKqW23N170k1lXtDRx83vMymUpG8MaKjZ/3RprXLM0TeFp
         mw/IbO3Iz9RH36O5Jpvq1UafXmnJG2B98xw6YZLuvsMQ/d6IPuF3Sofbm9o/j/0pXv
         dadPQlnHpvI0unpxbkigYUD5zVdqn5/Jsw6wsFTioerZBTpWe4HQS1yi/Hh0a+wV9n
         WwY+t1mSGB3Kw==
Received: by mail-oi1-f175.google.com with SMTP id p5so24253116oif.7
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 00:39:39 -0800 (PST)
X-Gm-Message-State: AOAM531iS1H+bciOhZHOAGVf5MLOP1QciTkvBs/1x8LTuq0CwQLRwTSZ
        s9dZd+61LPACSrkRPf8VlVXpuk55Pzoh5SvN0Pg=
X-Google-Smtp-Source: ABdhPJwFl3U5t1Gl0RMB5Y+QeQgkFcdkx3GZsTPMRral+e44nvJ8BPhPp0MwvLhf2KoX2zRZLzp3oVdGIMkMSagFnKY=
X-Received: by 2002:aca:dd03:: with SMTP id u3mr2281018oig.47.1611131978425;
 Wed, 20 Jan 2021 00:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20210119170742.20969-1-broonie@kernel.org>
In-Reply-To: <20210119170742.20969-1-broonie@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 20 Jan 2021 09:39:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEryUp9eo3cufS2G+=zBdqNbLUwGTzYjLQGBx1EtXeRTQ@mail.gmail.com>
Message-ID: <CAMj1kXEryUp9eo3cufS2G+=zBdqNbLUwGTzYjLQGBx1EtXeRTQ@mail.gmail.com>
Subject: Re: [PATCH] efi/arm64: Update debug prints to reflect other entropy sources
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 19 Jan 2021 at 19:26, Mark Brown <broonie@kernel.org> wrote:
>
> Currently the EFI stub prints a diagnostic on boot saying that KASLR will
> be disabled if it is unable to use the EFI RNG protocol to obtain a seed
> for KASLR. When this code was originally added there were no other entropy
> sources which KASLR would be able to obtain entropy from so this was
> accurate but with the addition of support of v8.5-RNG and the SMCCC RNG
> protocol it is now possible for KASLR to obtain entropy even if the EFI
> RNG protocol is unsupported in the system. This has been seen in emulated
> systems with EFI.
>
> Weaken the diagnostic to reflect the fact that KASLR may not be disabled,
> the warning is still useful as other sources may not be available and newer
> versions of both SBBR and EBBR require the RNG protocol and recommend that
> it be able to provide sufficient entropy for seeding KASLR.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index 22ece1ad68a8..94ade08b1054 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -61,10 +61,10 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>                         status = efi_get_random_bytes(sizeof(phys_seed),
>                                                       (u8 *)&phys_seed);
>                         if (status == EFI_NOT_FOUND) {
> -                               efi_info("EFI_RNG_PROTOCOL unavailable, KASLR will be disabled\n");
> +                               efi_info("EFI_RNG_PROTOCOL unavailable, KASLR may be disabled\n");
>                                 efi_nokaslr = true;
>                         } else if (status != EFI_SUCCESS) {
> -                               efi_err("efi_get_random_bytes() failed (0x%lx), KASLR will be disabled\n",
> +                               efi_err("efi_get_random_bytes() failed (0x%lx), KASLR may be disabled\n",
>                                         status);
>                                 efi_nokaslr = true;
>                         }
> --
> 2.20.1
>

The EFI stub randomizes the physical placement of the kernel as well,
and this is no longer possible by the time we reach early_kaslr_init()
in the kernel proper, so this is not something RNDR et al can make up
for.

So perhaps change this to 'physical placement will not be randomized'
or something along those lines? Or alternatively, just remove the
second part of the sentence - we have better reporting of the KASLR
state now anyway.
