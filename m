Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3B1112DFA
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 16:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfLDPDL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 10:03:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53513 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfLDPDK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 10:03:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id u18so45946wmc.3
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 07:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPkgow0XXzIjxmPPjv46nwaBinZCCIZjvPXWysfmjic=;
        b=rFfpFnSjKLBeGp4eccvr0vs6a5l/ZoCc2lwsUwYrp7A2A11qgddQlCF5I0ExPflRs1
         iilm8RURI+jFqX9PFZr6Aa0ZSeuBQlpTLa7lIQUeZzyFANqWjHmHRDovypuQ9J3r+pOm
         H4cc9mnfCvw6r9Dv6Nb/RsuUN8usXWEWWAl0k5dHknUR5cQ/torGwmiysPbOYIYCXBBT
         JpBiMaXjj6+jzaYr988QTmpxkhpCTKS/KG1zSRoWxW1FtaufYNKRMBUOFkUhHfRUj68o
         SKaLdXuy4Vsd/RvUSqwb3aV6OiQtBwkstrhcmpO8PhHn/gOQZuSU3qLRIhOC58Vga3Td
         3BGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPkgow0XXzIjxmPPjv46nwaBinZCCIZjvPXWysfmjic=;
        b=dF7STe0T4TVDXycYkHGkeYLbWQlZsKhVg1TUJ8Rr27eSzth8LNoyS0n2lE3tZbF7E4
         YgLYjwvSB9E5u2vx+/rY65TzTxWsMmkaviG6yRFk5phi5NKMP2C+mj0dDQqN+ichTnsa
         w5j5RKTGaYtUhkGJ50vvcFAs+nyr+W9DrPmRVUP4H/Wbx5wEPJ6o2VOTtK3Qv/+3HU0H
         brYLW7ew8F/vp/l4dpCIT7oPeZoP7OHg3sNFINjE4zt5U9/ydPd3Jc6YRtPVc+jdWl3q
         b13wu27RZbLvGLeDdjsHFnAnBnwU6fle7idp8MAx+Qks3aXB3EVSxCD+7k0ZkqKlHNmb
         K/EA==
X-Gm-Message-State: APjAAAUsSuqPZhIh6aBayZa5zHfA1wmOxof4qiVqNxqN/gmFAZh5m+bz
        ijUbjgTS6XglAWqLCg1CeuEeiIvU9p+ikz0zeIWSmw==
X-Google-Smtp-Source: APXvYqxoQlW3d0Y8DOQl1OUxK4Uh3H9ny5UNB2LXLqInAdYN9X4Fdy4DZzjTIUW2HDX0RglINodzV77FyGSbc3YxDUc=
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr23419wmf.136.1575471788246;
 Wed, 04 Dec 2019 07:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20191203214728.19264-1-nivedita@alum.mit.edu>
In-Reply-To: <20191203214728.19264-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Dec 2019 15:03:04 +0000
Message-ID: <CAKv+Gu-xTUBhV3Git9opPRs5sJvsCSHrcy9-=5Ac+nMaZhe7-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/gop: Fix return value of setup_gop32/64
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 3 Dec 2019 at 21:47, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> There are two ways the status return of setup_gop32/64 could be
> incorrect.
>
> 1. If we don't find a usable GOP because none of them have a framebuffer
> (i.e. they were all PIXEL_BLT_ONLY), but all the efi calls succeeded, we
> will return EFI_SUCCESS even though we didn't find a usable GOP. Return
> EFI_NOT_FOUND instead, allowing the caller to probe for UGA instead.
>
> 2. If we do find a usable GOP, but one of the subsequent ones fails in
> an EFI call while checking if any support console output, we may return
> an EFI error code even though we found a usable GOP. Fix this by always
> returning EFI_SUCCESS if we got a usable GOP.
>

Please split this into 2 patches

> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  drivers/firmware/efi/libstub/gop.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
> index 0101ca4c13b1..235a98797105 100644
> --- a/drivers/firmware/efi/libstub/gop.c
> +++ b/drivers/firmware/efi/libstub/gop.c
> @@ -119,7 +119,6 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
>         u64 fb_base;
>         struct efi_pixel_bitmask pixel_info;
>         int pixel_format;
> -       efi_status_t status = EFI_NOT_FOUND;

Is it really necessary to move this declaration?

>         u32 *handles = (u32 *)(unsigned long)gop_handle;
>         int i;
>
> @@ -134,6 +133,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
>                 void *dummy = NULL;
>                 efi_handle_t h = (efi_handle_t)(unsigned long)handles[i];
>                 u64 current_fb_base;
> +               efi_status_t status;
>
>                 status = efi_call_early(handle_protocol, h,
>                                         proto, (void **)&gop32);
> @@ -175,7 +175,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
>
>         /* Did we find any GOPs? */
>         if (!first_gop)
> -               goto out;
> +               return EFI_NOT_FOUND;
>
>         /* EFI framebuffer */
>         si->orig_video_isVGA = VIDEO_TYPE_EFI;
> @@ -197,8 +197,8 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
>         si->lfb_size = si->lfb_linelength * si->lfb_height;
>
>         si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
> -out:
> -       return status;
> +
> +       return EFI_SUCCESS;
>  }
>
>  static efi_status_t
> @@ -237,7 +237,6 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
>         u64 fb_base;
>         struct efi_pixel_bitmask pixel_info;
>         int pixel_format;
> -       efi_status_t status = EFI_NOT_FOUND;
>         u64 *handles = (u64 *)(unsigned long)gop_handle;
>         int i;
>
> @@ -252,6 +251,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
>                 void *dummy = NULL;
>                 efi_handle_t h = (efi_handle_t)(unsigned long)handles[i];
>                 u64 current_fb_base;
> +               efi_status_t status;
>
>                 status = efi_call_early(handle_protocol, h,
>                                         proto, (void **)&gop64);
> @@ -293,7 +293,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
>
>         /* Did we find any GOPs? */
>         if (!first_gop)
> -               goto out;
> +               return EFI_NOT_FOUND;
>
>         /* EFI framebuffer */
>         si->orig_video_isVGA = VIDEO_TYPE_EFI;
> @@ -315,8 +315,8 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
>         si->lfb_size = si->lfb_linelength * si->lfb_height;
>
>         si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
> -out:
> -       return status;
> +
> +       return EFI_SUCCESS;
>  }
>
>  /*
> --
> 2.23.0
>
