Return-Path: <linux-efi+bounces-5761-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E2C9BF91
	for <lists+linux-efi@lfdr.de>; Tue, 02 Dec 2025 16:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D91A3A9149
	for <lists+linux-efi@lfdr.de>; Tue,  2 Dec 2025 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B8C24E4AF;
	Tue,  2 Dec 2025 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flABiI2X"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3939242D7C
	for <linux-efi@vger.kernel.org>; Tue,  2 Dec 2025 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689671; cv=none; b=QaC6XlA8k3FOIn+2f4Y2e3k8GTCQiOaNcbtYXr8yE85KBDK26FusWbhsbnGEueVOQ8G08X02GKdiquigwD2BmKnJXc+zA2hROYgswuKTtuPyP3idpHgTwOQFUJaFjBAtKscbmjVtKuimFYYeiY68iA0b5cR9RVsD8Xb26JLcyQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689671; c=relaxed/simple;
	bh=jozvaljBn6JHxPjUwp1p4E4w2fzyLTNFBjEZa4hwY+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRS+hKJFo8qA6TJ4PBn+//0GPVqSLmBHpT2ORGK9KmkFjqcKC21JLbto7f6f5KJISP5gOaTwoyjp5yOqbFzLZD4BL5pKMpyFM2d5fU7v8PeCoyKK4JhWFK1VS5uWrBdzwphiXDeQbRjZKsbgnAuhAD2nEfLQyh3XtQX0bitvQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flABiI2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D0BC116B1
	for <linux-efi@vger.kernel.org>; Tue,  2 Dec 2025 15:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764689670;
	bh=jozvaljBn6JHxPjUwp1p4E4w2fzyLTNFBjEZa4hwY+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=flABiI2X7UyGRnvW0iV4UEX0gxzVSkS/GmNQGoemJq4tteFG6IixB+TTGQ+tDRap7
	 Jk8q0f0rAj+80v46r3wEVRb0uLQZSH/QiNIuH/APozAyFEhnqDlGwlNIhZqR2lfpFP
	 XcFcP7q99vx+6+dGTRYXL/uxInkJhyW53REaARtU/140UP+xDBvLsqY9i4g2pnHqTP
	 y91PwS+OG3Z5OHhjrVN6lOI1D1p+6vaHBvVeyZmhcBGLksLEd3WC9AOmnx04WCDIre
	 MvxFLQfQ1xFEMZtyGOGzBQR6u49FrSoAgJ73xFlgA5yvGh3Kl2mM+vsJ6p59W8P+et
	 0GBOu3n+QE+dQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59581e32163so5537906e87.1
        for <linux-efi@vger.kernel.org>; Tue, 02 Dec 2025 07:34:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWw9foihqMjzSt1fSF6M21CR574PC0m8Yo4AOyxsIdnk8BXnsmAfiA1rgvqWeA2p/RIZ/skZdKS9CI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6UkOHi2WEHUlDOSyDUR5jc7x+SpebZSymvNYtBFIUBFcFDWSS
	jlp82oGkqYkl7ezguGJjfrSmU944AtQBo5wOP+9Kpz+upso4pqUnexBw5GixSlHUoMvY8iURfc4
	bkcBV7PrqJeZulCA6LnKFM1LCRERHsNI=
X-Google-Smtp-Source: AGHT+IHgxGPqPBF+lBxpgveIspdXn+0htdD0xbNQ0e4+ocfqQfdZ3ZnohWHokZWaF4K5r3oKpxFEy1tqP5PLg5l5rrA=
X-Received: by 2002:a05:6512:1286:b0:594:557b:2282 with SMTP id
 2adb3069b0e04-596b4e5b043mr10395466e87.19.1764689668887; Tue, 02 Dec 2025
 07:34:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202141025.723-1-tvrtko.ursulin@igalia.com> <20251202141025.723-4-tvrtko.ursulin@igalia.com>
In-Reply-To: <20251202141025.723-4-tvrtko.ursulin@igalia.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 2 Dec 2025 16:34:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGbo9Td5ydyO=rqkb28b6DUw9-H0bkJ9PhGKz0V8LufnQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmYy1cP39Phz7QTVctIu9KyCjmbFIfZC4jp3xZNsQOFci_1IWeW6d3ND-E
Message-ID: <CAMj1kXGbo9Td5ydyO=rqkb28b6DUw9-H0bkJ9PhGKz0V8LufnQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi: sysfb_efi: Fix efidrmfb and simpledrmfb on Valve
 Steam Deck
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, 
	Thomas Zimmermann <tzimmermann@suse.de>, Melissa Wen <mwen@igalia.com>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Dec 2025 at 15:10, Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
>
> Valve Steam Deck has a 800x1280 portrait screen installed in a landscape
> orientation. The firmware offers a software rotated 1280x800 mode which
> GRUB can be made to switch to when displaying a boot menu. If this mode
> was selected frame buffer drivers will see this fake mode and fbcon
> rendering will be corrupted.
>
> Lets therefore add a selective quirk inside the current "swap with and
> height" handling, which will detect this exact mode and fix it up back to
> the native one.
>
> This will allow the DRM based frame buffer drivers to detect the correct
> mode and, apply the existing panel orientation quirk, and render the
> console in landscape mode with no corruption.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: linux-efi@vger.kernel.org
> ---
>  drivers/firmware/efi/sysfb_efi.c | 69 +++++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> index 2dea98395784..6458b3193093 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -231,6 +231,27 @@ static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
>         {},
>  };
>
> +struct efifb_mode_fixup {
> +       unsigned int width;
> +       unsigned int height;
> +       unsigned int pitch;
> +};
> +
> +static const struct efifb_mode_fixup efifb_steamdeck_mode_fixup = {
> +       /*
> +        * Valve Steam Deck has a 800x1280 portrait screen installed in a
> +        * landscape orientation. The firmware offers a software rotated
> +        * 1280x800 mode which GRUB can be made to switch to when displaying a
> +        * boot menu. If this mode was selected we need to fix it up back to the
> +        * native mode so frame buffer drivers can correctly probe, detect the
> +        * panel orientation quirk based on it, and the console renders with no
> +        * corruption in the software rotated mode.
> +        */

I don't think we need this wall of text. The only material difference
between this quirk and the other ones is that the pitch is not simply
4x the width, but I suspect that in the other cases, it also only
works when using the Blit() interface, and I guess this is what
Windows uses.

> +       .width = 1280,
> +       .height = 800,
> +       .pitch = 3328,

Can we call this 'linelength' instead?

> +};
> +
>  /*
>   * Some devices have a portrait LCD but advertise a landscape resolution (and
>   * pitch). We simply swap width and height for these devices so that we can
> @@ -281,6 +302,24 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
>                 },
>         },
> +       {
> +               /* Valve Steam Deck (Jupiter) */
> +               .matches = {
> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
> +               },
> +               .driver_data = (void *)&efifb_steamdeck_mode_fixup,
> +       },
> +       {
> +               /* Valve Steam Deck (Galileo) */
> +               .matches = {
> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
> +               },
> +               .driver_data = (void *)&efifb_steamdeck_mode_fixup,
> +       },
>         {},
>  };
>
> @@ -351,16 +390,34 @@ static struct fwnode_handle efifb_fwnode;
>
>  __init void sysfb_apply_efi_quirks(void)
>  {
> +       const struct dmi_system_id *match;
> +
>         if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
>             !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
>                 dmi_check_system(efifb_dmi_system_table);
>
> -       if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
> -           dmi_check_system(efifb_dmi_swap_width_height)) {
> -               swap(screen_info.lfb_width, screen_info.lfb_height);
> -               screen_info.lfb_linelength = (unsigned)screen_info.lfb_depth *
> -                                            screen_info.lfb_width /
> -                                            BITS_PER_BYTE;
> +       if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> +               return;
> +
> +       for (match = dmi_first_match(efifb_dmi_swap_width_height);
> +            match;
> +            match = dmi_first_match(match + 1)) {
> +               const struct efifb_mode_fixup *data = match->driver_data;
> +
> +               if (!data ||
> +                   (data->width == screen_info.lfb_width &&
> +                    data->height == screen_info.lfb_height)) {
> +                       swap(screen_info.lfb_width, screen_info.lfb_height);
> +
> +                       if (data && data->pitch) {
> +                               screen_info.lfb_linelength = data->pitch;
> +                               screen_info.lfb_size = data->pitch * data->width;


> +                       } else {
> +                               screen_info.lfb_linelength = (unsigned)screen_info.lfb_depth *

Please don't use bare 'unsigned' as a type. Is it really needed in the
first place? Is it because it gets promoted to (signed int) otherwise?


> +                                                            screen_info.lfb_width /
> +                                                            BITS_PER_BYTE;
> +                       }
> +               }

I'd prefer to avoid all this boilerplate, and use a callback instead
(but perhaps combined with the previous fix):

static int __init efifb_swap_width_height(const struct dmi_system_id *id)
{
        swap(screen_info.lfb_width, screen_info.lfb_height);
        screen_info.lfb_linelength = screen_info.lfb_depth *
screen_info.lfb_width / BITS_PER_BYTE;

        return 1;
}

and then add the handling of id->data in this patch.

You'll need to add .callback fields to the dmi_system_id array,
though, but this only takes up space that is already statically
allocated anyway.

Then, the code in sysfb_apply_efi_quirks() just becomes

        if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI)
            dmi_check_system(efifb_dmi_swap_width_height);

