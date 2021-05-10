Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609A53792EB
	for <lists+linux-efi@lfdr.de>; Mon, 10 May 2021 17:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhEJPks (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 May 2021 11:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231845AbhEJPko (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 May 2021 11:40:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D848C611C1;
        Mon, 10 May 2021 15:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620661179;
        bh=CudXjd0hQkvW0675tw9uDcMFK77kr+Yf/Cpj1A3k0ws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l8PSD+ZoAScwk8qp8Lntnu/ZV0qrcPXNjNKCwuN5A75ajOKvRYCOwjVx614CGy6e+
         7LEBzW3wPyL8YPOCLBOW85lGUd649nUgR+owzNH0Nl05zFyRiREuuCxacHjCYJHrFq
         cCbtDKIBq/zGWQbbqHx3XvvYz/x9jZdbnkGVtM1DxNqQpZiEHixqKpFvFbTwhJIcMV
         BhhRkEchhrUN2dr2KMgcUOpXbapydyxrqAU9EGDAneweikYcD10s+qgINcuIRQ7fpf
         SCGGhuClC8fo0VZnt5IBX0s9/2loaDxeFZLitxJkmloWoZZgGoqu7+bF0lvfUubOin
         aR+zZcKcRunaQ==
Received: by mail-oo1-f50.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so3560885ool.1;
        Mon, 10 May 2021 08:39:39 -0700 (PDT)
X-Gm-Message-State: AOAM533STcQQOFuQl4A6BAKGAYY44lCsGtX9oYJC232s3nxA7PqqBDVr
        wkIC8ZuGhiNDV0UHwgxf78vuvlqqGsG49Ddqrvc=
X-Google-Smtp-Source: ABdhPJwOfNMKZ24sY/aXHzYc5zvDGIwk1+GBWD3EPBDZmfFULQUgBO8gIOkxhhHWdtFyWhIYgiISwzZkEoBbTYtDXcI=
X-Received: by 2002:a4a:b997:: with SMTP id e23mr19330421oop.13.1620661179176;
 Mon, 10 May 2021 08:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210421194636.1540448-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20210421194636.1540448-1-linux@rasmusvillemoes.dk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 May 2021 17:39:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE9MjzoQdt+ZHjmrf6MmVXXmkoJAm1y6qunLkQLDz+yKw@mail.gmail.com>
Message-ID: <CAMj1kXE9MjzoQdt+ZHjmrf6MmVXXmkoJAm1y6qunLkQLDz+yKw@mail.gmail.com>
Subject: Re: [PATCH] efi: cper: fix snprintf() use in cper_dimm_err_location()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alex Kluver <alex.kluver@hpe.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 21 Apr 2021 at 21:46, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>
> snprintf() should be given the full buffer size, not one less. And it
> guarantees nul-termination, so doing it manually afterwards is
> pointless.
>
> It's even potentially harmful (though probably not in practice because
> CPER_REC_LEN is 256), due to the "return how much would have been
> written had the buffer been big enough" semantics. I.e., if the bank
> and/or device strings are long enough that the "DIMM location ..."
> output gets truncated, writing to msg[n] is a buffer overflow.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/firmware/efi/cper.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index e15d484b6a5a..ea7ca74fc173 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -276,8 +276,7 @@ static int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
>         if (!msg || !(mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE))
>                 return 0;
>
> -       n = 0;
> -       len = CPER_REC_LEN - 1;
> +       len = CPER_REC_LEN;
>         dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
>         if (bank && device)
>                 n = snprintf(msg, len, "DIMM location: %s %s ", bank, device);
> @@ -286,7 +285,6 @@ static int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
>                              "DIMM location: not present. DMI handle: 0x%.4x ",
>                              mem->mem_dev_handle);
>
> -       msg[n] = '\0';
>         return n;
>  }
>
> --
> 2.29.2
>

Thanks, I will queue this up.
