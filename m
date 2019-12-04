Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BED1112E74
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 16:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfLDPa2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 10:30:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42848 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfLDPa2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 10:30:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so9100997wrf.9
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 07:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7xUe1ryP8r66KjFGj1627sd5TaEUN+rXTzGFQufa00=;
        b=El7040e6I9dVl/IkboPO5xreITA+0G+wev65uz2q1qQ2B+ltHuyJevWOzEg8s7NvMg
         ASiW1DdhjJoWF1I7Bw9HHBZ0wPisI8nyYPMZIFYtgjP6yt2kLrQVM9jvAVJjFFNY76vd
         dS1oBEbcrx1/YUQnQLs33cLtcDBAPtvqjizkbhPsVdLoKeQj5CvFluDjN4hlf8By1jd8
         dLbKcbQbLjwBDt7wYh25H+a6iFspx14mcTqMp4tjwCDJIQIpUEuTjKx9f8gm43aI4KH4
         8LNFzzbVHCJyIzKT4M8YY0BjlZAFlgMgviAx2HF5xH17641sCRBrWRhW5BMYoJtPHi9v
         PX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7xUe1ryP8r66KjFGj1627sd5TaEUN+rXTzGFQufa00=;
        b=Qecl9QKPifJ9YGVjyIkv7110QjZUJ34xhozdeh6JQ1BvFp7qnI4CbUwxNue2VEx5WC
         LlCSqnt45hNoesIdcGfYmalhVWRG+cy+s2mJimND7Ie078gdV6zNj8/zPjE+vCrBx58a
         mFCLTFNtaGnamoDea7gnyRttBb4J1Chk38nl/W+z9wbpN/tgKhbKCX6e4nctk98L7KPC
         kf2mGMn1LikV8CZ+PN0LUvgWjDKd9gL7X0w9tUFYHCmHTfwmmD6OOIo5IyTU01kZkqT7
         2tJWweAD589Ou17ldkwQNI29A1zLHhz9N0tsIM7Zld6K8ziHoFcNOTETsrqtHV/cGZLp
         ZBNg==
X-Gm-Message-State: APjAAAWCe8oPmCxJy1rw3Lh+3NEP/THiY9k5fU96g9A1PmPwi/iH3gl+
        ZXB9qrkkhTwEwTauLDdojRPfHtzjjvd9WLxs/k6uyA==
X-Google-Smtp-Source: APXvYqyvTOFu1eHfcSIWF0HUbiVtDO1kwf5sYS6CaE2jnlXyAUJbO6lrSCM3gbMAU26d/1mmK8hoa9lY4Raq7qS2tLA=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr4625038wrs.200.1575473425652;
 Wed, 04 Dec 2019 07:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20191203214728.19264-1-nivedita@alum.mit.edu> <20191203214728.19264-2-nivedita@alum.mit.edu>
 <CAKv+Gu9tckvD=H4nCbHeNNxEwnK3tHMT59zELf=pYokLS4Nb6g@mail.gmail.com> <20191204152744.GB626282@rani.riverdale.lan>
In-Reply-To: <20191204152744.GB626282@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Dec 2019 15:30:22 +0000
Message-ID: <CAKv+Gu9ZCvoLn+yoWFq=Q1n2hBz+=BLwSQbgAnjfgSq6hDM6bg@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi/gop: Fix memory leak in __gop_query32/64
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Dec 2019 at 15:27, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Dec 04, 2019 at 03:11:09PM +0000, Ard Biesheuvel wrote:
> > On Tue, 3 Dec 2019 at 21:47, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > gop->query_mode returns info in callee-allocated memory which must be
> > > freed by the caller.
> > >
> > > We don't actually need to call it in order to obtain the info for the
> > > current graphics mode, which is already there in gop->mode->info, so
> > > just access it directly.
> > >
> > > Also nothing uses the size of the info structure, so remove the
> > > argument.
> > >
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> >
> > Thanks Arvind
> >
> > I agree with this patch in principle, but I'd prefer it if we could
> > get rid of the __gop_queryXX routines altogether, or if we need a
> > helper, to at least merge them into on, taking gopXX->mode as an input
> > argument.
> >
>
> I can do that. I'm also planning a few patches later to merge the 32-bit
> and 64-bit versions together if there are no objections, but that needs
> a little more work. Right now the query code can't be merged together
> because mode's layout is different between 32-bit and 64-bit versions,
> but it can certainly be folded into the main setup routines.
>

Fair enough.

Are you building/testing this on x86 hardware only? That's perfectly
fine, but it would be good to know.

> >
> > > ---
> > >  drivers/firmware/efi/libstub/gop.c | 48 ++++++++----------------------
> > >  1 file changed, 12 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
> > > index 235a98797105..c8a39cd89b47 100644
> > > --- a/drivers/firmware/efi/libstub/gop.c
> > > +++ b/drivers/firmware/efi/libstub/gop.c
> > > @@ -83,28 +83,17 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
> > >         }
> > >  }
> > >
> > > -static efi_status_t
> > > +static void
> > >  __gop_query32(efi_system_table_t *sys_table_arg,
> > >               struct efi_graphics_output_protocol_32 *gop32,
> > >               struct efi_graphics_output_mode_info **info,
> > > -             unsigned long *size, u64 *fb_base)
> > > +             u64 *fb_base)
> > >  {
> > >         struct efi_graphics_output_protocol_mode_32 *mode;
> > > -       efi_graphics_output_protocol_query_mode query_mode;
> > > -       efi_status_t status;
> > > -       unsigned long m;
> > > -
> > > -       m = gop32->mode;
> > > -       mode = (struct efi_graphics_output_protocol_mode_32 *)m;
> > > -       query_mode = (void *)(unsigned long)gop32->query_mode;
> > > -
> > > -       status = __efi_call_early(query_mode, (void *)gop32, mode->mode, size,
> > > -                                 info);
> > > -       if (status != EFI_SUCCESS)
> > > -               return status;
> > >
> > > +       mode = (void *)(unsigned long)gop32->mode;
> > > +       *info = (void *)(unsigned long)mode->info;
> > >         *fb_base = mode->frame_buffer_base;
> > > -       return status;
> > >  }
> > >
> > >  static efi_status_t
> > > @@ -145,9 +134,8 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
> > >                 if (status == EFI_SUCCESS)
> > >                         conout_found = true;
> > >
> > > -               status = __gop_query32(sys_table_arg, gop32, &info, &size,
> > > -                                      &current_fb_base);
> > > -               if (status == EFI_SUCCESS && (!first_gop || conout_found) &&
> > > +               __gop_query32(sys_table_arg, gop32, &info, &current_fb_base);
> > > +               if ((!first_gop || conout_found) &&
> > >                     info->pixel_format != PIXEL_BLT_ONLY) {
> > >                         /*
> > >                          * Systems that use the UEFI Console Splitter may
> > > @@ -201,28 +189,17 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
> > >         return EFI_SUCCESS;
> > >  }
> > >
> > > -static efi_status_t
> > > +static void
> > >  __gop_query64(efi_system_table_t *sys_table_arg,
> > >               struct efi_graphics_output_protocol_64 *gop64,
> > >               struct efi_graphics_output_mode_info **info,
> > > -             unsigned long *size, u64 *fb_base)
> > > +             u64 *fb_base)
> > >  {
> > >         struct efi_graphics_output_protocol_mode_64 *mode;
> > > -       efi_graphics_output_protocol_query_mode query_mode;
> > > -       efi_status_t status;
> > > -       unsigned long m;
> > > -
> > > -       m = gop64->mode;
> > > -       mode = (struct efi_graphics_output_protocol_mode_64 *)m;
> > > -       query_mode = (void *)(unsigned long)gop64->query_mode;
> > > -
> > > -       status = __efi_call_early(query_mode, (void *)gop64, mode->mode, size,
> > > -                                 info);
> > > -       if (status != EFI_SUCCESS)
> > > -               return status;
> > >
> > > +       mode = (void *)(unsigned long)gop64->mode;
> > > +       *info = (void *)(unsigned long)mode->info;
> > >         *fb_base = mode->frame_buffer_base;
> > > -       return status;
> > >  }
> > >
> > >  static efi_status_t
> > > @@ -263,9 +240,8 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
> > >                 if (status == EFI_SUCCESS)
> > >                         conout_found = true;
> > >
> > > -               status = __gop_query64(sys_table_arg, gop64, &info, &size,
> > > -                                      &current_fb_base);
> > > -               if (status == EFI_SUCCESS && (!first_gop || conout_found) &&
> > > +               __gop_query64(sys_table_arg, gop64, &info, &current_fb_base);
> > > +               if ((!first_gop || conout_found) &&
> > >                     info->pixel_format != PIXEL_BLT_ONLY) {
> > >                         /*
> > >                          * Systems that use the UEFI Console Splitter may
> > > --
> > > 2.23.0
> > >
