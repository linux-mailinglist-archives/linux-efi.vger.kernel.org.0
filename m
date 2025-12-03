Return-Path: <linux-efi+bounces-5769-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C918AC9E756
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 10:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0DE54E39C1
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 09:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAF42DC79E;
	Wed,  3 Dec 2025 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SL7hIz6U"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80022DC79D
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764753901; cv=none; b=TUmb+AA4D8hA8yOJZpwHBHuIK68d22h51wHiZ7fxSrCQWfwXg4jkQ12p1bpu1Tq+S6+v9dFjsnk0jdGkVQRaaBPvynveDAKSpEAUHzBfnd+fBXKvqz/9amOiwhJHSwL1nDXfiYIRUTpE+7fSGokM504gJZqmj3rSyUAEYAmOYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764753901; c=relaxed/simple;
	bh=5cQoZpxXJzGLGcDuGVHuzwpNUqJ1VJI8wGDmQJMjGLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2momsNl+MOqMXfak74QaPLAdaGq8TB4CryoCRiy2xgV/VHS10uaJBbzXyPyyfXt6afUzIy5G+lTV9s40JX1Y947vdLSgYx957CxRVVtNNH2ZXYl8JMUyA/adFBoLRkDJbSSoiaaTYr/UktSwXm0M1T4RP8sUN3LwoNPQGvTrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SL7hIz6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C98AC19421
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 09:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764753901;
	bh=5cQoZpxXJzGLGcDuGVHuzwpNUqJ1VJI8wGDmQJMjGLI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SL7hIz6UipAnpMLsmTBfauhq3ESkZYG+TAd3NSg6QWzpKaDv17JCWRaEJHBNvMUSD
	 4zC3BZCvp0DN72cM8I7PkTsJUKIBcyfkVqlLjTzdf8WGJFsxbUNPKcIFRlWcFIPX9v
	 bKXBD1i8E3O013+lXOoaVIxyItFs/BHoMv4AsQhwZjhxUKXtfVPySlU81SAJ2dNT4C
	 qzdPaDP0oxy6melPZA1M6SClJF9anpiMb414dU1SzmhGXU+5fbqPcrjJU3NK0m0eBC
	 2k1lFeRQGgmG/K/FpsZZyouuuUoP7F49ogD1sCkGM4wtyai8dmcbvpU544r5xuyTU8
	 3UdMp0LWugyPA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37d13ddaa6aso45637161fa.1
        for <linux-efi@vger.kernel.org>; Wed, 03 Dec 2025 01:25:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXC3WTn6gFpK/vJAlWlotEYhRmPM6AsEkmFM5YXYTSSEw6nqVYSx2OuOBB4+9mHjYQNo0Kz3Zv3mi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywac2+TYZ34caQor/baPabW2H2mvIegoQEtRs95kfJbiB4rMeRp
	kAVvYqVdT6oc/tgAdJWVo98MI86Wt/3kURv83m2uQ+SFYCQiQWiGT1OUb3P1ekt4ae47vBpRUNg
	qZkMPuASXYeP42XLi4DtRb9OAndMYvcQ=
X-Google-Smtp-Source: AGHT+IFUbFPZkRMHj2S1PXyiHO3cOXOvhIvDv5bYE0J9aAY+JiOdXG5FhZFjbaahnOKR7FFqFseH404EH0QCN7gWjV0=
X-Received: by 2002:a05:6512:3056:b0:594:55a3:c191 with SMTP id
 2adb3069b0e04-597d3f234d8mr656196e87.14.1764753899534; Wed, 03 Dec 2025
 01:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203090706.53778-1-tvrtko.ursulin@igalia.com> <20251203090706.53778-5-tvrtko.ursulin@igalia.com>
In-Reply-To: <20251203090706.53778-5-tvrtko.ursulin@igalia.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 3 Dec 2025 10:24:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHKAo-kspA73DPYMhrDtqFAQNMVCqRa4nbEGzrf_WBR2g@mail.gmail.com>
X-Gm-Features: AWmQ_bkpPZGAIs3QlRVhpm1kUYO97u4UYkzmVKBIAJTGNV3gFzrV0rAmH2swZ4c
Message-ID: <CAMj1kXHKAo-kspA73DPYMhrDtqFAQNMVCqRa4nbEGzrf_WBR2g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] efi: sysfb_efi: Fix efidrmfb and simpledrmfb on
 Valve Steam Deck
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, 
	Thomas Zimmermann <tzimmermann@suse.de>, Melissa Wen <mwen@igalia.com>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Dec 2025 at 10:07, Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
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
>  drivers/firmware/efi/sysfb_efi.c | 56 +++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 5 deletions(-)
>

Thanks for respinning this. But seeing the result, I think we can
simplify this substantially by using two separate callbacks for the
two cases.

> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> index eacf9a50eab2..566492e67798 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -231,16 +231,42 @@ static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
>         {},
>  };
>
> +struct efifb_mode_fixup {
> +       unsigned int width;
> +       unsigned int height;
> +       unsigned int linelength;
> +};
> +
>  static int __init efifb_swap_width_height(const struct dmi_system_id *id)
>  {

Leave this one alone, and add

static int __init efifb_check_and_swap_width_height(const struct
dmi_system_id *id)
{
        const struct efifb_mode_fixup *data = id->driver_data;

        if (data->width == screen_info.lfb_width &&
            data->height == screen_info.lfb_height) {
                swap(screen_info.lfb_width, screen_info.lfb_height);
                screen_info.lfb_linelength = data->linelength;
                screen_info.lfb_size = data->linelength * data->width;
        }
        return 1;
}

Note that we should always return 1 here, given that there is no point
in trying other matches, even if the width/height check fails.

And please make efifb_steamdeck_mode_fixup __initconst as well

