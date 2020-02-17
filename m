Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCCE160D92
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 09:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgBQIh7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 03:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbgBQIh7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Feb 2020 03:37:59 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5BAE2067D
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 08:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581928679;
        bh=OEYEsnHiPG+bbDAtNq8Y3KYQGtuOQ7X4K6jfDlfmg0s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=almyo8lEtdGcW/YK6xiEN5YsP6IougXe95O345/6cpifswCPx3X2QySoktEEZrfmu
         vRhJgT/DSNEAivN5e3HnH1K1c1iU7YyhhkRicLieD5R+vAyfdWsCxMflhXHwKhr44K
         WPOVPoBKR4aFkHuHW0iVNjd2GESyBduUUOCABbn4=
Received: by mail-wm1-f54.google.com with SMTP id a5so16178925wmb.0
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 00:37:58 -0800 (PST)
X-Gm-Message-State: APjAAAXzmdje86vf4/2zoOvrPkScsDqDhu9u5zQ3EQCbEe0gaZ/gTm4m
        OfS/BuoLCu5qtjg6VVL/TtDBUqwS/18Ch9EIPTbN+A==
X-Google-Smtp-Source: APXvYqyxuNjRyNRXggRupVSd2WRYP5sWapSYcLr4lLJjijhlrbJTrXEn7sHefsMSGvoow5y0+Eyf3SwDdJzB8ImIW9Q=
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr20340442wmf.40.1581928676930;
 Mon, 17 Feb 2020 00:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20200216184050.3100-1-xypron.glpk@gmx.de>
In-Reply-To: <20200216184050.3100-1-xypron.glpk@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Feb 2020 09:37:46 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_zevqzHRPMQaEcAeLPCYrTCLtbTbrZ2Ajz+ooYDb3m3A@mail.gmail.com>
Message-ID: <CAKv+Gu_zevqzHRPMQaEcAeLPCYrTCLtbTbrZ2Ajz+ooYDb3m3A@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: simplify efi_get_memory_map()
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 16 Feb 2020 at 19:40, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Do not check the value of status twice.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Thanks, I'll queue this one as well.

> ---
>  drivers/firmware/efi/libstub/mem.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> index c6a784ed640f..c25fd9174b74 100644
> --- a/drivers/firmware/efi/libstub/mem.c
> +++ b/drivers/firmware/efi/libstub/mem.c
> @@ -52,13 +52,14 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
>                 goto again;
>         }
>
> -       if (status != EFI_SUCCESS)
> +       if (status == EFI_SUCCESS) {
> +               if (map->key_ptr)
> +                       *map->key_ptr = key;
> +               if (map->desc_ver)
> +                       *map->desc_ver = desc_version;
> +       } else {
>                 efi_bs_call(free_pool, m);
> -
> -       if (map->key_ptr && status == EFI_SUCCESS)
> -               *map->key_ptr = key;
> -       if (map->desc_ver && status == EFI_SUCCESS)
> -               *map->desc_ver = desc_version;
> +       }
>
>  fail:
>         *map->map = m;
> --
> 2.25.0
>
