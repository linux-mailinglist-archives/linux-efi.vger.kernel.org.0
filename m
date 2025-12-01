Return-Path: <linux-efi+bounces-5728-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D48DC969C7
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 11:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3763C3A2309
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117F9302747;
	Mon,  1 Dec 2025 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArPFKiUY"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D4302160
	for <linux-efi@vger.kernel.org>; Mon,  1 Dec 2025 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584336; cv=none; b=QeCLK82dKNT68iovuX/G53HElbKr1p6DhNdUB3ZJsbh+pdnvOYh/JpylNQRJpeMJMetkgWi2cnzmZajMnagEowdGZy0XKgtE/2bv1g7JeSYvTYG8/bKUjUa5gNQI0NkwYFHb7Be6p1RF/Ik9i6U1Xk7WtqlkRC1ssyIs46B8EC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584336; c=relaxed/simple;
	bh=DrLqAdNwBw5YRo7VEw5A1I7PKi0nrRfDMr6YxKXTh3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzb2itr55rBNVoWR0dqUK6IXgIaCL0M2W8NvrlFgdxnwpRMQDgPHAFtg0wCfTlsXkcfQ+jnRN8apsVYEnOxHTVspDprAau15kBA+eEyK/6pinfvP1An1GG6fzXjcfJfhYACo16tTwN+Ya3lsw2D1+UjS2dwuIvsoc0Ces9FlZbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArPFKiUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7482EC19424
	for <linux-efi@vger.kernel.org>; Mon,  1 Dec 2025 10:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764584335;
	bh=DrLqAdNwBw5YRo7VEw5A1I7PKi0nrRfDMr6YxKXTh3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ArPFKiUYSmw6yj41estDRt++IDbfEMc0GGHUc2jpHZUzuDmF7U1H9j1zlmHczHGuR
	 kndD52C6efQWiPDwGqSY7psjYaelZdKMg5Bv3iuq3o+SaoAJEnibsmKeiBnUtifrGl
	 0FJyeWR3szT+QkREEAjghbwYp1jQ5ZZZUwkchWU6LQ6E5FgVXiBPxxEzjaF4LfkutV
	 yDs+YdtB0s75Bzu/aenE9rfqXH04R2/k2hALRz0/wAa6jGLFjP2Ky3qbvHZT2MnB00
	 LwgjuaR9N7b1e4bDKkKTJp/rXkVpQtzQ6Ubp4r7WKzE8SdyEfhyGPv3jw54v8aiF5p
	 OWv8MlXXIh+Lg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37ce27af365so32442011fa.0
        for <linux-efi@vger.kernel.org>; Mon, 01 Dec 2025 02:18:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7DhTU7i7wO38y/FYU6sg9R46NsCrQe4nqIue1olV4fbTUY5YwSHoKUu767LxvYv8xqYyC0jRkgjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzovwuu8oGFEE+loxl5IVg3hweAQ4EwqyWH3d5vUO3MF9hx2t4m
	1cGqKIoholvF2ll0YROYuZwUMhtO0qk6djkrs1RXPUhFPU33NY6UHX0Vv1Jn+B5rS9oGv2f+xLa
	WgP0xVVQh9vSkcGqMuFT3X7eEIXVJSEI=
X-Google-Smtp-Source: AGHT+IEUy2v6WnipllIUc+PU2OTaL0jzpQ1EQ7W4mbArybn1W0gf3t6uBpJnIbNkNgDytuTBZOGNmZScQGl07MlPnb0=
X-Received: by 2002:a2e:3c04:0:b0:372:8d61:c26f with SMTP id
 38308e7fff4ca-37cd9194b4amr80861861fa.11.1764584333799; Mon, 01 Dec 2025
 02:18:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128150403.11567-1-tvrtko.ursulin@igalia.com>
 <ce41c2d1-c659-4632-8469-761762202800@suse.de> <660c5469-086f-40b4-99f1-72c1bc613ece@igalia.com>
 <1df5a480-2510-43b9-9d79-51d842518036@suse.de> <b146fb1b-80e9-403c-acd1-b50ef1aaa646@igalia.com>
 <1b73df5b-5f47-4ce4-abd4-83d550cc0dea@suse.de> <e7c4a76e-5cef-4a75-847f-59c53a554327@igalia.com>
In-Reply-To: <e7c4a76e-5cef-4a75-847f-59c53a554327@igalia.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 1 Dec 2025 11:18:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFOS9jAzhh2Z_4rarEGd+kGPyNCu9PFoMhFbBVEF8NwJw@mail.gmail.com>
X-Gm-Features: AWmQ_bmEzRdXOGR5-nOwHSbUF1lXTVJLXlfPx7ephUKhlSkjmuvxViZ02hhKHIc
Message-ID: <CAMj1kXFOS9jAzhh2Z_4rarEGd+kGPyNCu9PFoMhFbBVEF8NwJw@mail.gmail.com>
Subject: Re: [RFX] efi: sysfb_efi: Fix simpledrmfb on Steam Deck
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	kernel-dev@igalia.com, Javier Martinez Canillas <javierm@redhat.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Melissa Wen <mwen@igalia.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Dec 2025 at 11:03, Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
>
>
> On 01/12/2025 09:39, Thomas Zimmermann wrote:
> > Hi
> >
> > Am 01.12.25 um 10:20 schrieb Tvrtko Ursulin:
> >>
> >> On 01/12/2025 07:32, Thomas Zimmermann wrote:
> >>> Hi
> >>>
> >>> Am 29.11.25 um 11:44 schrieb Tvrtko Ursulin:
> >>>>
> >>>> On 28/11/2025 17:07, Thomas Zimmermann wrote:
> >>>>> Hi,
> >>>>>
> >>>>> thanks for the bug report
> >>>>>
> >>>>> Am 28.11.25 um 16:04 schrieb Tvrtko Ursulin:
> >>>>>> I am not sure how is simpledrmfb on top of EFI supposed to work,
> >>>>>> but at
> >>>>>> least at the moment it appears there is a missing link in the
> >>>>>> "discovery"
> >>>>>> of frame buffer parameters.
> >>>>>>
> >>>>>> What I can see is that EFI GOP reads some parameters from the
> >>>>>> firmware and
> >>>>>> infers the other, such as in this case problematic pitch, or stride.
> >>>>>
> >>>>> The pitch/stride value comes from the firmware via
> >>>>> pixels_per_scanline [1].
> >>>>>
> >>>>> Can you verify that this value is really 800 instead of 832 (eq
> >>>>> 3328 bytes) ?
> >>>>>
> >>>>> [1] https://elixir.bootlin.com/linux/v6.17.9/source/drivers/
> >>>>> firmware/ efi/libstub/gop.c#L493
> >>>>
> >>>> I actually got confused a bit in following the flow so thank you for
> >>>> asking me to double check.
> >>>>
> >>>> GOP actually reports 1280x800 with a stride of 5120. So it kind of
> >>>> reports a rotated view already, kind of.
> >>>
> >>> These are correct values.
> >>>
> >>> But the stream deck is this device: [1], right? It uses landscape-
> >>> mode orientation. Why does it require rotation at all?
> >>>
> >>> [1] https://de.wikipedia.org/wiki/Steam_Deck#/media/
> >>> Datei:Steam_Deck_(front).png
> >>
> >> That's the device yes. For the user the screen is landscape, but the
> >> actual panel is 800x1280 portrait. Left edge is top of the display.
> >> (Hence the pre-existing entry in drm_get_panel_orientation_quirk.)
> >
> > I see. So the EFI display settings are configured as if this was a
> > landscape panel.
> >
> > What happens if you leave the EFI settings as-is and simply remove the
> > panel-orientation quirk?
>
> That would create effectively the same situation as without my patch
> because the panel-orientation quirk does not trigger unless detected
> screen is 800x1280. Result is corrupted console since fbcon thinks it is
> a landscape 1280x800 screen.
> >>>> Only when the rotation quirk from efifb_dmi_swap_width_height
> >>>> triggers the stride gets incorrectly recalculated:
> >>>>
> >>>>         u16 temp = screen_info.lfb_width;
> >>>>
> >>>>         screen_info.lfb_width = screen_info.lfb_height;
> >>>>         screen_info.lfb_height = temp;
> >>>>         screen_info.lfb_linelength = 4 * screen_info.lfb_width;
> >>>>
> >>>> So this is where things go wrong, well, they actually go wrong a
> >>>> little bit even earlier, in gop.c:
> >>>>
> >>>>     si->lfb_size = si->lfb_linelength * si->lfb_height;
> >>>>
> >>>> Which potentially underestimates the fb size. If GOP was forward
> >>>> looking enough to give us the size we could derive the pitch based
> >>>> on size..
> >>>>
> >>>> Anyway, as it stands it looks a quirk in sysfb_apply_efi_quirks
> >>>> looks it is required to fix it all up.
> >>>>
> >>>> I am a bit uneasy about declaring the fb size larger than what was
> >>>> implied by firmware provided pitch * height * depth but limited to a
> >>>> specific DMI match and if it looks visually okay I think it is a
> >>>> safe assumption the quirked size is actually correct and safe.
> >>>
> >>> Yeah, we better not do that.
> >> You mean declare it a firmware bug and live with the corrupt console
> >> until the final fb driver takes over?
> >
> > I only mean that we should not use more video memory than provided by EFI.
>
> Right, but that information is not available in the GOP, right? Ie. as I
> wrote above it appears assumed:
>
>     si->lfb_size = si->lfb_linelength * si->lfb_height;
>
> Do we have any other options apart from corruption or assume firmware
> configured GOP screen info incorrectly?
>

How does it make sense to recalculate the line length? Those invisible
pixels at the end of the scanline are not going to be transposed to
the other dimension, right?

