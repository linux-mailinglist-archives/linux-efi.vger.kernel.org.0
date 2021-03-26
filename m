Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E36C34A927
	for <lists+linux-efi@lfdr.de>; Fri, 26 Mar 2021 14:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCZN6K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Mar 2021 09:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhCZN5s (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 26 Mar 2021 09:57:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EAB061A1E;
        Fri, 26 Mar 2021 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616767068;
        bh=CtPkKxNXAFOwDCyjqkdra5XFgYEFZjQ87hGk/XR8cfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LQbYXY0c66QiMRrNvdZD63b1ht8Cg7a1Z6oSZ2sYH8mvYJMNwz/d+6SIcm5MI77Fi
         px+MXJVa4Tvdh9XQkhQsQ6PcK68ng/llZ9i9KvJjDCWW8XI0T2sPzW9NKKhy4Ljto/
         nEXy3+302+i5kWYGI2TtU077PtOvW+4r1HQwewYA3SwFzJ/7Oa5PiIkAvIs3X/iig5
         ZheDHM4an6hL3auItM+6TtxDEHAqU1JeJSeG0uRLELiinG4EfsfQczXFCG9WxkyTyp
         OFZNhap9iqoRQ4N+snOi0s+/qjXaIdCURf8xdVCEGmeHyB92YyIl9O3hK8T04ZeIRo
         kV5eNr29RGJ7A==
Received: by mail-ot1-f41.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so5271016ote.6;
        Fri, 26 Mar 2021 06:57:48 -0700 (PDT)
X-Gm-Message-State: AOAM533RH0UmBLCjfgDiwzzVVtKjtYTR/pbL3H4jzF2Jo8V4svkbIS1t
        CmJAeS89MN7/mwOVzQlBTmpgObAINVER66YzilQ=
X-Google-Smtp-Source: ABdhPJw2W8ndU6vqWokiypCezNCBVaB+LIzgUdu9+pe2C79c/8Ebz3uTRhswUlzp6ZAR2fRYkvk0P6o+nTuGa+542AI=
X-Received: by 2002:a9d:600a:: with SMTP id h10mr11317876otj.90.1616767067400;
 Fri, 26 Mar 2021 06:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210324145435.19753-1-changbin.du@gmail.com>
In-Reply-To: <20210324145435.19753-1-changbin.du@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 26 Mar 2021 14:57:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHxHDEVbUz9L5d6pSMRB6wLFL_GiqA18X6XN4XbnifsXQ@mail.gmail.com>
Message-ID: <CAMj1kXHxHDEVbUz9L5d6pSMRB6wLFL_GiqA18X6XN4XbnifsXQ@mail.gmail.com>
Subject: Re: [PATCH] efi/fdt: fix panic when no valid fdt found
To:     Changbin Du <changbin.du@gmail.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 24 Mar 2021 at 15:54, Changbin Du <changbin.du@gmail.com> wrote:
>
> setup_arch() would invoke efi_init()->efi_get_fdt_params(). If no
> valid fdt found then initial_boot_params will be null. So we
> should stop further fdt processing here. I encountered this
> issue on risc-v.
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

I'll queue this up, thanks.

> ---
>  drivers/firmware/efi/fdtparams.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/efi/fdtparams.c b/drivers/firmware/efi/fdtparams.c
> index bb042ab7c2be..e901f8564ca0 100644
> --- a/drivers/firmware/efi/fdtparams.c
> +++ b/drivers/firmware/efi/fdtparams.c
> @@ -98,6 +98,9 @@ u64 __init efi_get_fdt_params(struct efi_memory_map_data *mm)
>         BUILD_BUG_ON(ARRAY_SIZE(target) != ARRAY_SIZE(name));
>         BUILD_BUG_ON(ARRAY_SIZE(target) != ARRAY_SIZE(dt_params[0].params));
>
> +       if (!fdt)
> +               return 0;
> +
>         for (i = 0; i < ARRAY_SIZE(dt_params); i++) {
>                 node = fdt_path_offset(fdt, dt_params[i].path);
>                 if (node < 0)
> --
> 2.30.2
>
