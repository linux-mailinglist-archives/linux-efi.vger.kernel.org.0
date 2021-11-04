Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7168244510C
	for <lists+linux-efi@lfdr.de>; Thu,  4 Nov 2021 10:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhKDJ32 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Nov 2021 05:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhKDJ31 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 4 Nov 2021 05:29:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F24360FED;
        Thu,  4 Nov 2021 09:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636018010;
        bh=8ql/+yTbdYJMr/JzakzOwBDumltKNduhMvRZDoRoF2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CH61flB4W0nfTBYWYkPs8/pnl82tubmamjI1VhF/JfrATWuJKmseso2EapEluk9mO
         ll3i+TX1mjFax2U0uCcaDG+4z8FV0/weAZDYUWZJfPkNy81F6U8kyc1WLyvkH4gMLQ
         YigkxEr7A1KyPXx3gYe4ed5FzyNMvZPs35t5UCO7HSaT4ES2f6+qnQ7PyNg3SNRvTp
         T88YiuUSar748eIrDghCkCl4Fn5as0J4ff6pGdaMdRKLU6MA4KRcll7ErmraayYpc0
         v0VU0EplN2OezRYfuUFJG0HlYKLjDx7fBjn+qSP1Op4EkRzmnl8JTJUkDoTzf3zqHA
         whKa71jbNEgLQ==
Received: by mail-ot1-f42.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so7434978ott.4;
        Thu, 04 Nov 2021 02:26:50 -0700 (PDT)
X-Gm-Message-State: AOAM530Ir+9T0u3vhUpG9XRg2HzXGHs24wPkVq5hOGVJGa6yjvwrP7V8
        k5e4OdIVVayMOBsNVoJye1khyurP3G3Il8u/8Gc=
X-Google-Smtp-Source: ABdhPJycIP3nqNCsf0Oah+JsUg669sDAFBnvPcKM79cUy7oyaXUPOxKnPHUA/zgwUkV5AvNqm10jJm/YiTIobKYJIak=
X-Received: by 2002:a05:6830:14c:: with SMTP id j12mr7427611otp.147.1636018009493;
 Thu, 04 Nov 2021 02:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211102020545.145840-1-cuigaosheng1@huawei.com>
In-Reply-To: <20211102020545.145840-1-cuigaosheng1@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Nov 2021 10:26:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFE1Gv41TowKZHqkwn+WVLsAOqJSFbi706KbMC0G_rqgw@mail.gmail.com>
Message-ID: <CAMj1kXFE1Gv41TowKZHqkwn+WVLsAOqJSFbi706KbMC0G_rqgw@mail.gmail.com>
Subject: Re: [PATCH -next,v2] efi/libstub: arm32: Use "align" for the size alignment
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2 Nov 2021 at 03:04, Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> We are doing page-based allocations, and both the address
> and size must meet alignment constraints, so using "align"
> for the size alignment is a better choice.
>

Why is it a better choice? If I allocate a 2 MB aligned block of
memory, why is it better to align the size to a multiple of 2 MB as
well?


> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  drivers/firmware/efi/libstub/randomalloc.c | 2 +-
>  drivers/firmware/efi/libstub/relocate.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
> index 724155b9e10d..7b7159bb035d 100644
> --- a/drivers/firmware/efi/libstub/randomalloc.c
> +++ b/drivers/firmware/efi/libstub/randomalloc.c
> @@ -76,7 +76,7 @@ efi_status_t efi_random_alloc(unsigned long size,
>         if (align < EFI_ALLOC_ALIGN)
>                 align = EFI_ALLOC_ALIGN;
>
> -       size = round_up(size, EFI_ALLOC_ALIGN);
> +       size = round_up(size, align);
>
>         /* count the suitable slots in each memory map entry */
>         for (map_offset = 0; map_offset < map_size; map_offset += desc_size) {
> diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
> index 8ee9eb2b9039..d6d27e8c23f8 100644
> --- a/drivers/firmware/efi/libstub/relocate.c
> +++ b/drivers/firmware/efi/libstub/relocate.c
> @@ -50,7 +50,7 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
>         if (align < EFI_ALLOC_ALIGN)
>                 align = EFI_ALLOC_ALIGN;
>
> -       size = round_up(size, EFI_ALLOC_ALIGN);
> +       size = round_up(size, align);
>         nr_pages = size / EFI_PAGE_SIZE;
>         for (i = 0; i < map_size / desc_size; i++) {
>                 efi_memory_desc_t *desc;
> --
> 2.30.0
>
