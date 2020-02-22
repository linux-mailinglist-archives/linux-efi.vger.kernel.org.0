Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86285169108
	for <lists+linux-efi@lfdr.de>; Sat, 22 Feb 2020 18:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBVRxi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Feb 2020 12:53:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgBVRxi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 22 Feb 2020 12:53:38 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70CC020707
        for <linux-efi@vger.kernel.org>; Sat, 22 Feb 2020 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582394017;
        bh=YgKrm0xiETHM9Cmfn3YsYzVL6NnGHRbjPZ0LttoOZPs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WHBit2bA6T3EHwMhwqLDdrr2CZGcZ4tX4F/1r5Lyk9AQFzU/OqaIeMgyCzk97aE/7
         O6S595fJcXq5KtBCozs3jOWCnHfAra61DJEVNImt3IcPoHBp16EPEQ+CCjyiaNIa+j
         0fH3UOISh+mdmW2T186huegR4ms51t3JnWEZ/IrE=
Received: by mail-wr1-f41.google.com with SMTP id t3so5586021wru.7
        for <linux-efi@vger.kernel.org>; Sat, 22 Feb 2020 09:53:37 -0800 (PST)
X-Gm-Message-State: APjAAAUPA01dJHHjZV7X6aVtdCKBz7NnXkBP+7GKnUQCfaOwuaO9EEgD
        ygh9+oFx6ZoraGsjO9wuHldte+66kvRi+H7tUq+hlA==
X-Google-Smtp-Source: APXvYqyWzaLbt4HYjpKwPlRQWQGBksiImz9hsJkpyk87ED2N2OOaMX24u0bAr90dNAd3Wc+csetD0svSTq78dij7MPk=
X-Received: by 2002:a5d:5188:: with SMTP id k8mr55791430wrv.151.1582394015897;
 Sat, 22 Feb 2020 09:53:35 -0800 (PST)
MIME-Version: 1.0
References: <20200221191829.18149-1-xypron.glpk@gmx.de>
In-Reply-To: <20200221191829.18149-1-xypron.glpk@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 22 Feb 2020 18:53:25 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_A1r7JYmUrgEyZjkiZam7oEB=rANuUiCfsFfkQAfxuCg@mail.gmail.com>
Message-ID: <CAKv+Gu_A1r7JYmUrgEyZjkiZam7oEB=rANuUiCfsFfkQAfxuCg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: error message in handle_cmdline_files()
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 21 Feb 2020 at 20:18, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> The memory for files is allocated not reallocated.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Queued in efi/next

Thanks,

> ---
>  drivers/firmware/efi/libstub/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
> index be78f64f8d80..d4c7e5f59d2c 100644
> --- a/drivers/firmware/efi/libstub/file.c
> +++ b/drivers/firmware/efi/libstub/file.c
> @@ -190,7 +190,7 @@ static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
>                                                             &alloc_addr,
>                                                             hard_limit);
>                         if (status != EFI_SUCCESS) {
> -                               pr_efi_err("Failed to reallocate memory for files\n");
> +                               pr_efi_err("Failed to allocate memory for files\n");
>                                 goto err_close_file;
>                         }
>
> --
> 2.25.0
>
