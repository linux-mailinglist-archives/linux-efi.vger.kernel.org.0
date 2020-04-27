Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D111B97C9
	for <lists+linux-efi@lfdr.de>; Mon, 27 Apr 2020 08:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgD0Gwl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Apr 2020 02:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgD0Gwl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 27 Apr 2020 02:52:41 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2D38206B9;
        Mon, 27 Apr 2020 06:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587970361;
        bh=SXEGb6LTTKGu/qwb7zAbrCsuo/qhlGR1iqLf7e+m/4g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I6W2zcpTcQQUBXpvQrLKVxXyAtKVPcshHgUOpviTXOZGsQ4Fllfwl2aPL6PyWM+6H
         3iUInwn5KIi7ym1XJG6JgSYgRnYBWBqYf4ItC9qyPFPSzI/rYA3XVAfuDG06BvmmxL
         spKLWGKyQ6pR0kkeL3Q7Jdm5b5ygjwaOpy3MO9Nk=
Received: by mail-io1-f53.google.com with SMTP id o127so17674487iof.0;
        Sun, 26 Apr 2020 23:52:40 -0700 (PDT)
X-Gm-Message-State: AGi0PubNY8enL+EYlLKDlt2IQ87aOfsVpOgWGhTCtIIGkk/lKBlyqVXt
        3oboLL4ClXtezrnQBd2l+FLDAa9+LlilzJ/bGe8=
X-Google-Smtp-Source: APiQypLYfh2DXGdQLTmg+XU3QUKt5FEeozkZZy28VGrW7SVPCC2k5PiT5Q4wKEtoGybgbDAPe4Cs1Qr/zryB7LGnZ3E=
X-Received: by 2002:a6b:ef03:: with SMTP id k3mr19662018ioh.203.1587970360390;
 Sun, 26 Apr 2020 23:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200426194946.112768-1-xypron.glpk@gmx.de>
In-Reply-To: <20200426194946.112768-1-xypron.glpk@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 27 Apr 2020 08:52:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHo+utD4Y2BT0kcefEtYUKZsEWvqgzMNcJy0GE3Cw3jGA@mail.gmail.com>
Message-ID: <CAMj1kXHo+utD4Y2BT0kcefEtYUKZsEWvqgzMNcJy0GE3Cw3jGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: setup_graphics() do not return random data
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 26 Apr 2020 at 21:49, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Currently setup_graphics() ignores the return value of efi_setup_gop(). As
> AllocatePool() does not zero out memory the screen information table will
> contain random data in this case.
>
> We should free the screen information table if efi_setup_gop() returns an
> error code.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Thanks Heinrich

I will take this as a fix


> ---
>  drivers/firmware/efi/libstub/efi-stub.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index ee225b323687..60377e5ceab3 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -55,7 +55,11 @@ static struct screen_info *setup_graphics(void)
>                 si = alloc_screen_info();
>                 if (!si)
>                         return NULL;
> -               efi_setup_gop(si, &gop_proto, size);
> +               status = efi_setup_gop(si, &gop_proto, size);
> +               if (status != EFI_SUCCESS) {
> +                       free_screen_info(si);
> +                       return NULL;
> +               }
>         }
>         return si;
>  }
> --
> 2.26.2
>
