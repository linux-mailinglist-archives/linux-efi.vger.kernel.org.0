Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA383CBA77
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 18:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhGPQVu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 12:21:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhGPQVu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 12:21:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FB04613CC;
        Fri, 16 Jul 2021 16:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626452335;
        bh=WAk9IVAreIzP0iiUk08WueaWZP/KWWYlRc+hny6iQ9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i50ltLmOJvjao+LSejGpAfKJLiyIoC8QSamxCcuGE3u3oMMREfgRK2iON57lJdgIx
         6ab5mhnhOsdGHUeH4YlyJUq/vaCXiuE7AGrV+30y21kUFUXdrTrX9sZYlcgt5Vwv9C
         UJqhnCu8AZF1p4l5vn4HZeQFcrVKDISvUOj+JN1IAWBNxHTaGQEgJkzIor+J/lVcVl
         s/FQvufZTIpzMuA9Y/WCbFIqv/ZtE2KlbbpMoPoP4evTL8aJwUyvD72cmZOveX1A5V
         U1qu/xZXv8DSMDiFDKPAD7c+FS2nQ2P/Pyrfv7O4lSf9ziRPTl69NDR1SGkS2mZFd4
         AE+mmVWPQeWCw==
Received: by mail-ot1-f41.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so10380319otq.11;
        Fri, 16 Jul 2021 09:18:55 -0700 (PDT)
X-Gm-Message-State: AOAM533JyF2bBrEKBEMwZwk5cNZ9V6PtjJ6NUmzO6f7m4/lm/zKzHbCK
        q0Iwi5fPdvhOTJOLL0di14yDWa8E/4zHTuKl/Gk=
X-Google-Smtp-Source: ABdhPJxrrOStaOTD1Lcs6eKNHNHVBRCd3/a0llUST1/uknmaLxfC3pzmTGMjOUPYV2cx6qNGAMxTpDy4Fx2RsEgb69o=
X-Received: by 2002:a05:6830:3494:: with SMTP id c20mr2354717otu.108.1626452334532;
 Fri, 16 Jul 2021 09:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210702191044.988401-1-atish.patra@wdc.com>
In-Reply-To: <20210702191044.988401-1-atish.patra@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 16 Jul 2021 18:18:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFVj8RFxy5Ujio7Ah6=HFOhNtHVWiCiPKzzQUF4ahY=xw@mail.gmail.com>
Message-ID: <CAMj1kXFVj8RFxy5Ujio7Ah6=HFOhNtHVWiCiPKzzQUF4ahY=xw@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Fix the efi_load_initrd function description
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2 Jul 2021 at 21:10, Atish Patra <atish.patra@wdc.com> wrote:
>
> The soft_limit and hard_limit in the function efi_load_initrd describes
> the preferred and max address of initrd loading location respectively.
> However, the description wrongly describes it as the size of the
> allocated memory.
>
> Fix the function description.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Now queued up, thanks.

> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index aa8da0a49829..ae87dded989d 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -630,8 +630,8 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
>   * @image:     EFI loaded image protocol
>   * @load_addr: pointer to loaded initrd
>   * @load_size: size of loaded initrd
> - * @soft_limit:        preferred size of allocated memory for loading the initrd
> - * @hard_limit:        minimum size of allocated memory
> + * @soft_limit:        preferred address for loading the initrd
> + * @hard_limit:        upper limit address for loading the initrd
>   *
>   * Return:     status code
>   */
> --
> 2.31.1
>
