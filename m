Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4C811D976
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 23:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfLLWgC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 17:36:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54492 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731111AbfLLWgC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 17:36:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so4145115wmj.4
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 14:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GLYzlRo9oliSzKUddjBWpha7TBPJGZrHXax9ZmPQz7o=;
        b=a5JkxBBOMS3Vg2uOb/qDce60XR+YCDpkl1iY3S4LzXSOy0W3GsnoZTa2fonBgOpcZa
         aXxhjXtbwP4xQ/HfvINSpsBHZbvROCESZl1QN3hk4WtANaI0UHu2SNpVGr2jL4vkRTbP
         D0Lm0Ly6w1G7+FB5/+OGxAkWcTs+1mqjmpeaQrixMO9vUox1Uu0t4VH7Auz/QG8HZ1NI
         wEvWF5ScbUxfkKPEfDafuVQFM35x7oe0UioKq1Nl64rAuOiX2H0G5TovL+qyFjbF1SD7
         /4ASacs3x/pFXOmSpAL/Vh3+QmoDpcSF6NWRDHMYGfvQn+jCZyYlrsHaSE5xXV2/EWHz
         SIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GLYzlRo9oliSzKUddjBWpha7TBPJGZrHXax9ZmPQz7o=;
        b=Ame94SrNe59VicPS8TXr9BVn/Rh4YN5+YM5e+fyan/B1785lH6yo2BdZqT9IbUJp9f
         WbqdN3EeBMghIp6Ba/8ViTFpxCqKefxk4/EQ34e0mnCNsYr63nUB6FwrYWi0HhVc6Ucf
         y7Lv2+oy8ausR2Mm5bDPf6mxM11YCoKIStjzKm4ErioNCCNst6RvMstD3B4XTFxaaCrw
         dvkLl12gmkJTb0pfWD1YHQAtSzdCOAB0w63m9je9d8hgcjE1KUxH04XMq0CmvxAIB4B9
         VOuZ73A9qgjgxS4vjJlY5noNLEfN9VzcqKxNKACN7jAF0MsVwgnAIVUV4CMYrJmz4ps/
         xe/g==
X-Gm-Message-State: APjAAAWyy/BI7thMWSGlQeZZZaCx+HhKK/WtbhEToTsowgrj1SDtn/aY
        gDqYXrfCpnVKOEx5Szt0XJZs71nqqURBeqlEj1NiQA==
X-Google-Smtp-Source: APXvYqzXnxdZmmD7/cgyYuMpH3Xv4lDFMmz1flKj/KIxvWiJpBUFU0IJxhPzG3ydQ8lSY4qPtS3J9f8MC+gYh7qIAJI=
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr523561wme.148.1576190158961;
 Thu, 12 Dec 2019 14:35:58 -0800 (PST)
MIME-Version: 1.0
References: <20191212213443.24128-1-nivedita@alum.mit.edu> <20191212213443.24128-4-nivedita@alum.mit.edu>
In-Reply-To: <20191212213443.24128-4-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 12 Dec 2019 22:35:56 +0000
Message-ID: <CAKv+Gu804kOz2BJw=O1o8F3XF828E3BYp_UnJu1VSwy7gKm-7g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] efi/gop: Convert GOP structures to typedef and
 cleanup some types
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 12 Dec 2019 at 22:34, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Use typedef for the GOP structures, in anticipation of unifying
> 32/64-bit code. Also use more appropriate types in the non-bitness
> specific structures for the framebuffer address and pointers.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>


This gives me

/home/ardbie01/linux/drivers/firmware/efi/libstub/gop.c: In function
=E2=80=98setup_gop32=E2=80=99:
/home/ardbie01/linux/drivers/firmware/efi/libstub/gop.c:96:27: error:
storage size of =E2=80=98pixel_info=E2=80=99 isn=E2=80=99t known
  struct efi_pixel_bitmask pixel_info;
                           ^~~~~~~~~~
/home/ardbie01/linux/drivers/firmware/efi/libstub/gop.c:125:38: error:
dereferencing pointer to incomplete type =E2=80=98struct
efi_graphics_output_protocol_32=E2=80=99
   mode =3D (void *)(unsigned long)gop32->mode;
                                      ^~
/home/ardbie01/linux/scripts/Makefile.build:265: recipe for target
'drivers/firmware/efi/libstub/gop.o' failed
make[5]: *** [drivers/firmware/efi/libstub/gop.o] Error 1
make[5]: *** Waiting for unfinished jobs....


> ---
>  drivers/firmware/efi/libstub/gop.c | 26 ++++++++---------
>  include/linux/efi.h                | 46 +++++++++++++++---------------
>  2 files changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/li=
bstub/gop.c
> index b7bf1e993b8b..a0c1ef64d445 100644
> --- a/drivers/firmware/efi/libstub/gop.c
> +++ b/drivers/firmware/efi/libstub/gop.c
> @@ -35,7 +35,7 @@ static void find_bits(unsigned long mask, u8 *pos, u8 *=
size)
>
>  static void
>  setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
> -                struct efi_pixel_bitmask pixel_info, int pixel_format)
> +                efi_pixel_bitmask_t pixel_info, int pixel_format)
>  {
>         if (pixel_format =3D=3D PIXEL_RGB_RESERVED_8BIT_PER_COLOR) {
>                 si->lfb_depth =3D 32;
> @@ -87,13 +87,13 @@ static efi_status_t
>  setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
>              efi_guid_t *proto, unsigned long size, void **gop_handle)
>  {
> -       struct efi_graphics_output_protocol_32 *gop32, *first_gop;
> +       efi_graphics_output_protocol_32_t *gop32, *first_gop;
>         unsigned long nr_gops;
>         u16 width, height;
>         u32 pixels_per_scan_line;
>         u32 ext_lfb_base;
> -       u64 fb_base;
> -       struct efi_pixel_bitmask pixel_info;
> +       efi_physical_addr_t fb_base;
> +       efi_pixel_bitmask_t pixel_info;
>         int pixel_format;
>         efi_status_t status;
>         u32 *handles =3D (u32 *)(unsigned long)gop_handle;
> @@ -104,13 +104,13 @@ setup_gop32(efi_system_table_t *sys_table_arg, stru=
ct screen_info *si,
>
>         nr_gops =3D size / sizeof(u32);
>         for (i =3D 0; i < nr_gops; i++) {
> -               struct efi_graphics_output_protocol_mode_32 *mode;
> -               struct efi_graphics_output_mode_info *info =3D NULL;
> +               efi_graphics_output_protocol_mode_32_t *mode;
> +               efi_graphics_output_mode_info_t *info =3D NULL;
>                 efi_guid_t conout_proto =3D EFI_CONSOLE_OUT_DEVICE_GUID;
>                 bool conout_found =3D false;
>                 void *dummy =3D NULL;
>                 efi_handle_t h =3D (efi_handle_t)(unsigned long)handles[i=
];
> -               u64 current_fb_base;
> +               efi_physical_addr_t current_fb_base;
>
>                 status =3D efi_call_early(handle_protocol, h,
>                                         proto, (void **)&gop32);
> @@ -184,13 +184,13 @@ static efi_status_t
>  setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
>             efi_guid_t *proto, unsigned long size, void **gop_handle)
>  {
> -       struct efi_graphics_output_protocol_64 *gop64, *first_gop;
> +       efi_graphics_output_protocol_64_t *gop64, *first_gop;
>         unsigned long nr_gops;
>         u16 width, height;
>         u32 pixels_per_scan_line;
>         u32 ext_lfb_base;
> -       u64 fb_base;
> -       struct efi_pixel_bitmask pixel_info;
> +       efi_physical_addr_t fb_base;
> +       efi_pixel_bitmask_t pixel_info;
>         int pixel_format;
>         efi_status_t status;
>         u64 *handles =3D (u64 *)(unsigned long)gop_handle;
> @@ -201,13 +201,13 @@ setup_gop64(efi_system_table_t *sys_table_arg, stru=
ct screen_info *si,
>
>         nr_gops =3D size / sizeof(u64);
>         for (i =3D 0; i < nr_gops; i++) {
> -               struct efi_graphics_output_protocol_mode_64 *mode;
> -               struct efi_graphics_output_mode_info *info =3D NULL;
> +               efi_graphics_output_protocol_mode_64_t *mode;
> +               efi_graphics_output_mode_info_t *info =3D NULL;
>                 efi_guid_t conout_proto =3D EFI_CONSOLE_OUT_DEVICE_GUID;
>                 bool conout_found =3D false;
>                 void *dummy =3D NULL;
>                 efi_handle_t h =3D (efi_handle_t)(unsigned long)handles[i=
];
> -               u64 current_fb_base;
> +               efi_physical_addr_t current_fb_base;
>
>                 status =3D efi_call_early(handle_protocol, h,
>                                         proto, (void **)&gop64);
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 8be59ec77dee..5daac58fa675 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1415,69 +1415,69 @@ struct efi_simple_text_output_protocol {
>  #define PIXEL_BLT_ONLY                                 3
>  #define PIXEL_FORMAT_MAX                               4
>
> -struct efi_pixel_bitmask {
> +typedef struct {
>         u32 red_mask;
>         u32 green_mask;
>         u32 blue_mask;
>         u32 reserved_mask;
> -};
> +} efi_pixel_bitmask_t;
>
> -struct efi_graphics_output_mode_info {
> +typedef struct {
>         u32 version;
>         u32 horizontal_resolution;
>         u32 vertical_resolution;
>         int pixel_format;
> -       struct efi_pixel_bitmask pixel_information;
> +       efi_pixel_bitmask_t pixel_information;
>         u32 pixels_per_scan_line;
> -};
> +} efi_graphics_output_mode_info_t;
>
> -struct efi_graphics_output_protocol_mode_32 {
> +typedef struct {
>         u32 max_mode;
>         u32 mode;
>         u32 info;
>         u32 size_of_info;
>         u64 frame_buffer_base;
>         u32 frame_buffer_size;
> -};
> +} efi_graphics_output_protocol_mode_32_t;
>
> -struct efi_graphics_output_protocol_mode_64 {
> +typedef struct {
>         u32 max_mode;
>         u32 mode;
>         u64 info;
>         u64 size_of_info;
>         u64 frame_buffer_base;
>         u64 frame_buffer_size;
> -};
> +} efi_graphics_output_protocol_mode_64_t;
>
> -struct efi_graphics_output_protocol_mode {
> +typedef struct {
>         u32 max_mode;
>         u32 mode;
> -       unsigned long info;
> +       efi_graphics_output_mode_info_t *info;
>         unsigned long size_of_info;
> -       u64 frame_buffer_base;
> +       efi_physical_addr_t frame_buffer_base;
>         unsigned long frame_buffer_size;
> -};
> +} efi_graphics_output_protocol_mode_t;
>
> -struct efi_graphics_output_protocol_32 {
> +typedef struct {
>         u32 query_mode;
>         u32 set_mode;
>         u32 blt;
>         u32 mode;
> -};
> +} efi_graphics_output_protocol_32_t;
>
> -struct efi_graphics_output_protocol_64 {
> +typedef struct {
>         u64 query_mode;
>         u64 set_mode;
>         u64 blt;
>         u64 mode;
> -};
> +} efi_graphics_output_protocol_64_t;
>
> -struct efi_graphics_output_protocol {
> -       unsigned long query_mode;
> -       unsigned long set_mode;
> -       unsigned long blt;
> -       struct efi_graphics_output_protocol_mode *mode;
> -};
> +typedef struct {
> +       void *query_mode;
> +       void *set_mode;
> +       void *blt;
> +       efi_graphics_output_protocol_mode_t *mode;
> +} efi_graphics_output_protocol_t;
>
>  extern struct list_head efivar_sysfs_list;
>
> --
> 2.23.0
>
