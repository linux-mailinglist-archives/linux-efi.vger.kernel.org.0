Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8550112E50
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 16:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfLDP1s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 10:27:48 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37539 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbfLDP1s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 10:27:48 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so126670qtk.4
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 07:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=55jEwkNUMSWVolqockNf21n0aO1/jY2OMSwqK68T/ao=;
        b=uz4VnWtagmPrEbx92v2HKp3bsjrlNcsNWUAs2+pAyMNRKXduQHO/VUn1rTeZBIt8Wc
         o9j1rrp9HP4nVgxqIT4W/etQrdxbicHtDGoecGRaJalvvWEmJPnQ0v3QQ8VrLgUvUf9h
         f6Hc+WFAofj5ezKS9NiB54uwhH+TQ40nrZ5tTLQqjRcmm+VbHMW80gWcs3eVZfhJDr6U
         w6NVvCmAxOPt7necw0hReKa7XlsfeIQ5AxgxFLDOlohRPnprKJcnLknXBfMF6ookRKv0
         GVOgdPTmZPKWBjxcGc89nhHzH4MOs41cYmlHodqCqJsO/bfvqLaaEfp+8cIHH6mha0Qd
         AdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=55jEwkNUMSWVolqockNf21n0aO1/jY2OMSwqK68T/ao=;
        b=oE4ClnLNQVf4sXW616T01fVzp+gzIZre1tDMP9TR3l9NZm4R0xsk7TPNuyjf/Sndqx
         nY5b1EcmJrZ7GaIl6e1eQoKK9i73z27rDe0v7hIodOuz6vud0wSKexXwJf3nmv05jbeR
         9jFejrenD1MtXg69x6OT7Jhqp0w5Qwjm3j+ew+f9SHQffGEGP/OxvF6dtkLE06UGf1by
         9yb8JarGDxC4uU4xFnv+PzHHCO+rnToxl0NhSCqpbX6JPQQCxAZjlB+UgLnfDedjrEYs
         8OjtJhaWpRNRdqLsUF/KVne87v6aP7EB25fGSj8lCakN4HZQXm5TL/V0Ys4sjtJ71lVP
         CSsQ==
X-Gm-Message-State: APjAAAWw9dIqLLJhTrQX1oJEsbW5EEAhJViHmY/JpXt8FAAcTBArvgko
        8bLux/tCc239qRuH86D5/NE=
X-Google-Smtp-Source: APXvYqxzsP4KmllFc34NY+z5utWKjBD9xuic6LOVVKMUm4Sv1eJ1NBQqw2za+xEtXvqiPQ21h2zYEw==
X-Received: by 2002:ac8:22c4:: with SMTP id g4mr3184654qta.45.1575473267158;
        Wed, 04 Dec 2019 07:27:47 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a16sm2209653qkn.48.2019.12.04.07.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:27:46 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 4 Dec 2019 10:27:45 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 2/2] efi/gop: Fix memory leak in __gop_query32/64
Message-ID: <20191204152744.GB626282@rani.riverdale.lan>
References: <20191203214728.19264-1-nivedita@alum.mit.edu>
 <20191203214728.19264-2-nivedita@alum.mit.edu>
 <CAKv+Gu9tckvD=H4nCbHeNNxEwnK3tHMT59zELf=pYokLS4Nb6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9tckvD=H4nCbHeNNxEwnK3tHMT59zELf=pYokLS4Nb6g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 04, 2019 at 03:11:09PM +0000, Ard Biesheuvel wrote:
> On Tue, 3 Dec 2019 at 21:47, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > gop->query_mode returns info in callee-allocated memory which must be
> > freed by the caller.
> >
> > We don't actually need to call it in order to obtain the info for the
> > current graphics mode, which is already there in gop->mode->info, so
> > just access it directly.
> >
> > Also nothing uses the size of the info structure, so remove the
> > argument.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> Thanks Arvind
> 
> I agree with this patch in principle, but I'd prefer it if we could
> get rid of the __gop_queryXX routines altogether, or if we need a
> helper, to at least merge them into on, taking gopXX->mode as an input
> argument.
> 

I can do that. I'm also planning a few patches later to merge the 32-bit
and 64-bit versions together if there are no objections, but that needs
a little more work. Right now the query code can't be merged together
because mode's layout is different between 32-bit and 64-bit versions,
but it can certainly be folded into the main setup routines.

> 
> > ---
> >  drivers/firmware/efi/libstub/gop.c | 48 ++++++++----------------------
> >  1 file changed, 12 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
> > index 235a98797105..c8a39cd89b47 100644
> > --- a/drivers/firmware/efi/libstub/gop.c
> > +++ b/drivers/firmware/efi/libstub/gop.c
> > @@ -83,28 +83,17 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
> >         }
> >  }
> >
> > -static efi_status_t
> > +static void
> >  __gop_query32(efi_system_table_t *sys_table_arg,
> >               struct efi_graphics_output_protocol_32 *gop32,
> >               struct efi_graphics_output_mode_info **info,
> > -             unsigned long *size, u64 *fb_base)
> > +             u64 *fb_base)
> >  {
> >         struct efi_graphics_output_protocol_mode_32 *mode;
> > -       efi_graphics_output_protocol_query_mode query_mode;
> > -       efi_status_t status;
> > -       unsigned long m;
> > -
> > -       m = gop32->mode;
> > -       mode = (struct efi_graphics_output_protocol_mode_32 *)m;
> > -       query_mode = (void *)(unsigned long)gop32->query_mode;
> > -
> > -       status = __efi_call_early(query_mode, (void *)gop32, mode->mode, size,
> > -                                 info);
> > -       if (status != EFI_SUCCESS)
> > -               return status;
> >
> > +       mode = (void *)(unsigned long)gop32->mode;
> > +       *info = (void *)(unsigned long)mode->info;
> >         *fb_base = mode->frame_buffer_base;
> > -       return status;
> >  }
> >
> >  static efi_status_t
> > @@ -145,9 +134,8 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
> >                 if (status == EFI_SUCCESS)
> >                         conout_found = true;
> >
> > -               status = __gop_query32(sys_table_arg, gop32, &info, &size,
> > -                                      &current_fb_base);
> > -               if (status == EFI_SUCCESS && (!first_gop || conout_found) &&
> > +               __gop_query32(sys_table_arg, gop32, &info, &current_fb_base);
> > +               if ((!first_gop || conout_found) &&
> >                     info->pixel_format != PIXEL_BLT_ONLY) {
> >                         /*
> >                          * Systems that use the UEFI Console Splitter may
> > @@ -201,28 +189,17 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
> >         return EFI_SUCCESS;
> >  }
> >
> > -static efi_status_t
> > +static void
> >  __gop_query64(efi_system_table_t *sys_table_arg,
> >               struct efi_graphics_output_protocol_64 *gop64,
> >               struct efi_graphics_output_mode_info **info,
> > -             unsigned long *size, u64 *fb_base)
> > +             u64 *fb_base)
> >  {
> >         struct efi_graphics_output_protocol_mode_64 *mode;
> > -       efi_graphics_output_protocol_query_mode query_mode;
> > -       efi_status_t status;
> > -       unsigned long m;
> > -
> > -       m = gop64->mode;
> > -       mode = (struct efi_graphics_output_protocol_mode_64 *)m;
> > -       query_mode = (void *)(unsigned long)gop64->query_mode;
> > -
> > -       status = __efi_call_early(query_mode, (void *)gop64, mode->mode, size,
> > -                                 info);
> > -       if (status != EFI_SUCCESS)
> > -               return status;
> >
> > +       mode = (void *)(unsigned long)gop64->mode;
> > +       *info = (void *)(unsigned long)mode->info;
> >         *fb_base = mode->frame_buffer_base;
> > -       return status;
> >  }
> >
> >  static efi_status_t
> > @@ -263,9 +240,8 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
> >                 if (status == EFI_SUCCESS)
> >                         conout_found = true;
> >
> > -               status = __gop_query64(sys_table_arg, gop64, &info, &size,
> > -                                      &current_fb_base);
> > -               if (status == EFI_SUCCESS && (!first_gop || conout_found) &&
> > +               __gop_query64(sys_table_arg, gop64, &info, &current_fb_base);
> > +               if ((!first_gop || conout_found) &&
> >                     info->pixel_format != PIXEL_BLT_ONLY) {
> >                         /*
> >                          * Systems that use the UEFI Console Splitter may
> > --
> > 2.23.0
> >
