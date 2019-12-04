Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D7D112E11
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 16:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfLDPLQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 10:11:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55991 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfLDPLQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 10:11:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so61391wmj.5
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 07:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIvzW4bFlXSLpuHvixfgspcB6a7+gJuANVEQun0Q/u8=;
        b=pc6o1vwx13ChlYztM8K0t+IYZkX+DB5JfKXqe5lcZ/czYmLXSiYSKDuHICrtmTArlH
         qUQ9tDuK/zcD3Kc1G5S9tB9x8TR77kP/FwBYT6ibdn/4Lx52jUTiNq3KFzGbMPj+uBhP
         +1hjhUjnhlYsa/cVvsxXMOgrVt4BN6o/O6eSYXDV8NXduTynzLbrQOltvDNsFHxuZVEz
         zTwzmdsK4eiA4yw56WDfatUWVNeX5mZyE6//EyfCsko25+76ARzrlvnLo0vh9Tsb5+0n
         2yJxkkHxlKksBezEkIYbVCQZ8fo/Bz1FEG4uZg0jYA62t6fwL7uGn7Y6EvlE7PVz79I7
         cCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIvzW4bFlXSLpuHvixfgspcB6a7+gJuANVEQun0Q/u8=;
        b=bb8PFAd/Hr2ord12XtWH7uMHfzeSbiSeZQNG3y2/fn1yXzhfgYtTZ6pXgr2i75dHhj
         MvUoRsha0LvLXc1L7MUa6v1UeMqYKPXbQeNhwFPmbEn9dcLrKPioN4XFQB37qIPw982K
         nKqkQkBdgDrP5peP3Gt/xpxMkql5b2FqJ32KZTncAHRAlSyRvER0jofMRcldP1YFgyk7
         mS20Th+0fkCWTQSEP88lNTm/G9XiQ+1mkVrRlipaLR7KiX+0MTqsh8ga4hXNjkxt/NYG
         Dwud2DAceklMILO8AnJoU4qIkSUcPIh4T59zM5nvgaDenFrsAKDonOChipRt38Ig4YbJ
         ti1w==
X-Gm-Message-State: APjAAAUmn862WfOGQji+yePGihNFLezWuFoMCRccS7hkYq7lix0hcT+B
        77FerlnuUct3Vum36M7Rn6dM5itCbvTmRt22u2LbeJ98GcfgnA==
X-Google-Smtp-Source: APXvYqymg1NgWJOmIRq7E6myL/nbeeqSPT+ApXFn3KdG/8Oh2DEw6XFmvDweR2+BhY6EUg3SrZ00jGxqmf1mRhfVDWU=
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr43900wml.67.1575472273115;
 Wed, 04 Dec 2019 07:11:13 -0800 (PST)
MIME-Version: 1.0
References: <20191203214728.19264-1-nivedita@alum.mit.edu> <20191203214728.19264-2-nivedita@alum.mit.edu>
In-Reply-To: <20191203214728.19264-2-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Dec 2019 15:11:09 +0000
Message-ID: <CAKv+Gu9tckvD=H4nCbHeNNxEwnK3tHMT59zELf=pYokLS4Nb6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi/gop: Fix memory leak in __gop_query32/64
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
> gop->query_mode returns info in callee-allocated memory which must be
> freed by the caller.
>
> We don't actually need to call it in order to obtain the info for the
> current graphics mode, which is already there in gop->mode->info, so
> just access it directly.
>
> Also nothing uses the size of the info structure, so remove the
> argument.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Thanks Arvind

I agree with this patch in principle, but I'd prefer it if we could
get rid of the __gop_queryXX routines altogether, or if we need a
helper, to at least merge them into on, taking gopXX->mode as an input
argument.


> ---
>  drivers/firmware/efi/libstub/gop.c | 48 ++++++++----------------------
>  1 file changed, 12 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
> index 235a98797105..c8a39cd89b47 100644
> --- a/drivers/firmware/efi/libstub/gop.c
> +++ b/drivers/firmware/efi/libstub/gop.c
> @@ -83,28 +83,17 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
>         }
>  }
>
> -static efi_status_t
> +static void
>  __gop_query32(efi_system_table_t *sys_table_arg,
>               struct efi_graphics_output_protocol_32 *gop32,
>               struct efi_graphics_output_mode_info **info,
> -             unsigned long *size, u64 *fb_base)
> +             u64 *fb_base)
>  {
>         struct efi_graphics_output_protocol_mode_32 *mode;
> -       efi_graphics_output_protocol_query_mode query_mode;
> -       efi_status_t status;
> -       unsigned long m;
> -
> -       m = gop32->mode;
> -       mode = (struct efi_graphics_output_protocol_mode_32 *)m;
> -       query_mode = (void *)(unsigned long)gop32->query_mode;
> -
> -       status = __efi_call_early(query_mode, (void *)gop32, mode->mode, size,
> -                                 info);
> -       if (status != EFI_SUCCESS)
> -               return status;
>
> +       mode = (void *)(unsigned long)gop32->mode;
> +       *info = (void *)(unsigned long)mode->info;
>         *fb_base = mode->frame_buffer_base;
> -       return status;
>  }
>
>  static efi_status_t
> @@ -145,9 +134,8 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
>                 if (status == EFI_SUCCESS)
>                         conout_found = true;
>
> -               status = __gop_query32(sys_table_arg, gop32, &info, &size,
> -                                      &current_fb_base);
> -               if (status == EFI_SUCCESS && (!first_gop || conout_found) &&
> +               __gop_query32(sys_table_arg, gop32, &info, &current_fb_base);
> +               if ((!first_gop || conout_found) &&
>                     info->pixel_format != PIXEL_BLT_ONLY) {
>                         /*
>                          * Systems that use the UEFI Console Splitter may
> @@ -201,28 +189,17 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
>         return EFI_SUCCESS;
>  }
>
> -static efi_status_t
> +static void
>  __gop_query64(efi_system_table_t *sys_table_arg,
>               struct efi_graphics_output_protocol_64 *gop64,
>               struct efi_graphics_output_mode_info **info,
> -             unsigned long *size, u64 *fb_base)
> +             u64 *fb_base)
>  {
>         struct efi_graphics_output_protocol_mode_64 *mode;
> -       efi_graphics_output_protocol_query_mode query_mode;
> -       efi_status_t status;
> -       unsigned long m;
> -
> -       m = gop64->mode;
> -       mode = (struct efi_graphics_output_protocol_mode_64 *)m;
> -       query_mode = (void *)(unsigned long)gop64->query_mode;
> -
> -       status = __efi_call_early(query_mode, (void *)gop64, mode->mode, size,
> -                                 info);
> -       if (status != EFI_SUCCESS)
> -               return status;
>
> +       mode = (void *)(unsigned long)gop64->mode;
> +       *info = (void *)(unsigned long)mode->info;
>         *fb_base = mode->frame_buffer_base;
> -       return status;
>  }
>
>  static efi_status_t
> @@ -263,9 +240,8 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
>                 if (status == EFI_SUCCESS)
>                         conout_found = true;
>
> -               status = __gop_query64(sys_table_arg, gop64, &info, &size,
> -                                      &current_fb_base);
> -               if (status == EFI_SUCCESS && (!first_gop || conout_found) &&
> +               __gop_query64(sys_table_arg, gop64, &info, &current_fb_base);
> +               if ((!first_gop || conout_found) &&
>                     info->pixel_format != PIXEL_BLT_ONLY) {
>                         /*
>                          * Systems that use the UEFI Console Splitter may
> --
> 2.23.0
>
