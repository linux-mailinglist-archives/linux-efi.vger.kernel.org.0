Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430EA3FAB82
	for <lists+linux-efi@lfdr.de>; Sun, 29 Aug 2021 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhH2MyZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Aug 2021 08:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235372AbhH2MyX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 29 Aug 2021 08:54:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D250D60F35;
        Sun, 29 Aug 2021 12:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630241611;
        bh=Ic5ZHECdsknHEfSrciqjEtVP3Tg1eHs6eteJ9awSWzM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u10XVH9l/Fa/oSFbbvdwyJYcnMMM2ANoc7EJ2Up+VXVrEIIHYp4OE50itX6owz6TR
         aT+V73gP8Viu6qQMu6G72dL6mMzdYtpYV9+aUzG2eFXlAi6SGGIiffJUWAu1KS07Bg
         HCFRE/ogbFlYNrmAHXbmzQP5MsB22HbthTJTYXdZtXFmwFdOYQE5kfyir/+es4S5hh
         OGSPxlGYnlIcESCiOCsLnGTiOxeBTRoajdT6H7P3KPDK/vEfLjKUflWybg0hx/LhKy
         Ox8pI5QsQg8idI3pc+zwoTnI9DbqQyWA/99SIXSbWvw8OX0pfwqAR+7j9cQbM9n+pl
         8z9B7B0Gn9N9A==
Received: by mail-ot1-f50.google.com with SMTP id x10-20020a056830408a00b004f26cead745so14652474ott.10;
        Sun, 29 Aug 2021 05:53:31 -0700 (PDT)
X-Gm-Message-State: AOAM533q1zjF8aKTu7GKQVWmSElz6i2cRvNkc0G8rxl/jug41w0JLl7Y
        w3C5neWkaa+qZMqC37EwMSCsY9XL9CN4XQDlJ0Q=
X-Google-Smtp-Source: ABdhPJzamthf/IKI8DFaN/0LmwqJ+nUtteQLdQMjkdjk3rVIVtLnCDLZdTvpVdROQcXftCtaDx+Tng/zxOdhSwnh95g=
X-Received: by 2002:a05:6830:719:: with SMTP id y25mr9497930ots.77.1630241611165;
 Sun, 29 Aug 2021 05:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210829124955.74429-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20210829124955.74429-1-heinrich.schuchardt@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 29 Aug 2021 14:53:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFg30tk6pRb_QS3gNqRBsSqWAtkO=-T=7tbNVTXByrJWA@mail.gmail.com>
Message-ID: <CAMj1kXFg30tk6pRb_QS3gNqRBsSqWAtkO=-T=7tbNVTXByrJWA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: "Exiting bootservices" message
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Heinrich Schuchardt <xypron.gpk@gmx.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 29 Aug 2021 at 14:50, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The message
>
>     "Exiting boot services and installing virtual address map...\n"
>
> is even shown if we have efi=novamap on the command line or the firmware
> does not provide EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP.
>
> To avoid confusion we should print
>
>     "Exiting boot services...\n"
>
> in this case.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Hello Heinrich,

I agree with the analysis but I'd prefer to simply go with the shorter
string in all cases.

Thanks,
Ard.

> -
>  drivers/firmware/efi/libstub/fdt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 365c3a43a198..d871b1ac4d8b 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -271,7 +271,10 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>                 return status;
>         }
>
> -       efi_info("Exiting boot services and installing virtual address map...\n");
> +       if (efi_novamap)
> +               efi_info("Exiting boot services...\n");
> +       else
> +               efi_info("Exiting boot services and installing virtual address map...\n");
>
>         map.map = &memory_map;
>         status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, ULONG_MAX);
> --
> 2.30.2
>
