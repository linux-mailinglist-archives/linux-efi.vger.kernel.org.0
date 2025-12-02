Return-Path: <linux-efi+bounces-5754-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E845C9B3CB
	for <lists+linux-efi@lfdr.de>; Tue, 02 Dec 2025 11:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6B9C4E40CC
	for <lists+linux-efi@lfdr.de>; Tue,  2 Dec 2025 10:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5A230146B;
	Tue,  2 Dec 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bScvELhh"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C9728506B
	for <linux-efi@vger.kernel.org>; Tue,  2 Dec 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764672977; cv=none; b=MInJHKLEepjnMl9cGO9kevNJAshipkTo8TSez5keX4rO7teyey1VE5c4uw7uAdajDFkQFJeK8ZOnv1e4epGBwpVfAx4UiSpziLUkSOUxHIemOFf9hv1IhIwvEI7XWrXAVqtkNhaE1mGkG6U8eGmJjF8KTiPXVZ3ifZwL+d3y0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764672977; c=relaxed/simple;
	bh=WbsFxgUvFNsH1LWnzvQQyArPbtWnxPR5v5iGOIRmQUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXCie4cznmOZgwvkVj9yJiY8bDAa/60GrKPc8V14zn1Y/HZNlhYv6R2h6i6FHZLZO3R48RxYHpcmbWnqhZ8eItuFQP2mPfbyGNygDtd2kfd7r+Z6zr14vgR0wX07PTkxhCGVVsd8qf7dLTAOSfB+geKgGWSVjFf0GIV4WiFQNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bScvELhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E82C19425
	for <linux-efi@vger.kernel.org>; Tue,  2 Dec 2025 10:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764672977;
	bh=WbsFxgUvFNsH1LWnzvQQyArPbtWnxPR5v5iGOIRmQUA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bScvELhhMo8y4ZfPkhM3GnIK0cX6Uz8AhjbqGecl3i1KyBEnMozeJFK9qTBVqK7yB
	 qFYrx0ijsBKmyoU0D3RZRFAdjZq/Vw703fJJ+gbuo1mEcCqcQsZJObho0vs1W6Znns
	 i7+EerpXfCY2AoHjILlv9YPVILNg6Y4yZ3SdDGIRfYbrBhIcC6CjfbpjevrZYSVyFp
	 Pek2CC4TwJhu23kLtVaDLjFpoPmG8FaH4DmDktTgiz40xKKEgN8VFrPupvzy2psWHv
	 /qHxqHWcSKIzyd+PQEeFH1Tc1t7mIpVNGZpODDhtiqpmx3X8QQBSRiw5z5XN6zQ/BY
	 6HeIR30ksywCw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5957ac0efc2so5902929e87.1
        for <linux-efi@vger.kernel.org>; Tue, 02 Dec 2025 02:56:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6ABTjdpXQAIJ6id6XyXN1i0VfwlkVjS5O1iy/AIYpPhGd30+fNOPuAry8gW2ABAMauM/CrdKZYLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nqCJ1NLAeoqgzBMsxIVVTHlx2FmRSref2kD3GeZKrncsQQRX
	J0W33H6XhYXhqGG+SUTpIrgxQvKoxhPs1h+DSr+7o2X6qORmTbJ3YHvF+5gQhLzuAFarI6Lv5q5
	jcGNqhyTADeW2tX4EnmCegweHx3IqBC8=
X-Google-Smtp-Source: AGHT+IGaao0VQuFxgIUhHcRPyQd5enqGXiDoMj1fS82VL+ycDa/o21UypCk9+vyoSkRa/WELk4whH8lhe4Le4CFu5Io=
X-Received: by 2002:a05:6512:12d3:b0:595:8350:5824 with SMTP id
 2adb3069b0e04-596a3e9fbf8mr15614048e87.7.1764672975353; Tue, 02 Dec 2025
 02:56:15 -0800 (PST)
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
 <CAMj1kXFOS9jAzhh2Z_4rarEGd+kGPyNCu9PFoMhFbBVEF8NwJw@mail.gmail.com>
 <07212b84-fc2a-4efe-a39b-5b536b6dd602@igalia.com> <CAMj1kXH3FyhNinT3-_FqROB53p_574ft6hsoF6aGYeYkhLd+TQ@mail.gmail.com>
 <086cf4fd-6401-46ce-a55f-ea2fd96a73d1@igalia.com> <f4dfd1b4-76c0-4b88-aefb-f0536e706f96@suse.de>
 <74e89e3b-b237-424c-a5cb-f4b3e026b61f@igalia.com>
In-Reply-To: <74e89e3b-b237-424c-a5cb-f4b3e026b61f@igalia.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 2 Dec 2025 11:56:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEGNOUkM0HC1GODDO7e33aRmLi71GLDefeEE7Pb=F1ZtQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmnKkI5ul0i3PBkuQzIZ7XsTG3GsV-i3zW8N-3_vZ-KL_6NYwmSJ0R3iks
Message-ID: <CAMj1kXEGNOUkM0HC1GODDO7e33aRmLi71GLDefeEE7Pb=F1ZtQ@mail.gmail.com>
Subject: Re: [RFX] efi: sysfb_efi: Fix simpledrmfb on Steam Deck
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	kernel-dev@igalia.com, Javier Martinez Canillas <javierm@redhat.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Melissa Wen <mwen@igalia.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Dec 2025 at 11:44, Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
>
>
> On 02/12/2025 07:34, Thomas Zimmermann wrote:
> > Hi
> >
> > Am 01.12.25 um 16:43 schrieb Tvrtko Ursulin:
> >>
> >> On 01/12/2025 15:00, Ard Biesheuvel wrote:
> >>> On Mon, 1 Dec 2025 at 11:33, Tvrtko Ursulin
> >>> <tvrtko.ursulin@igalia.com> wrote:
> >>>>
> >>>>
> >>>> On 01/12/2025 10:18, Ard Biesheuvel wrote:
> >>>>> On Mon, 1 Dec 2025 at 11:03, Tvrtko Ursulin
> >>>>> <tvrtko.ursulin@igalia.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 01/12/2025 09:39, Thomas Zimmermann wrote:
> >>>>>>> Hi
> >>>>>>>
> >>>>>>> Am 01.12.25 um 10:20 schrieb Tvrtko Ursulin:
> >>>>>>>>
> >>>>>>>> On 01/12/2025 07:32, Thomas Zimmermann wrote:
> >>>>>>>>> Hi
> >>>>>>>>>
> >>>>>>>>> Am 29.11.25 um 11:44 schrieb Tvrtko Ursulin:
> >>>>>>>>>>
> >>>>>>>>>> On 28/11/2025 17:07, Thomas Zimmermann wrote:
> >>>>>>>>>>> Hi,
> >>>>>>>>>>>
> >>>>>>>>>>> thanks for the bug report
> >>>>>>>>>>>
> >>>>>>>>>>> Am 28.11.25 um 16:04 schrieb Tvrtko Ursulin:
> >>>>>>>>>>>> I am not sure how is simpledrmfb on top of EFI supposed to
> >>>>>>>>>>>> work,
> >>>>>>>>>>>> but at
> >>>>>>>>>>>> least at the moment it appears there is a missing link in the
> >>>>>>>>>>>> "discovery"
> >>>>>>>>>>>> of frame buffer parameters.
> >>>>>>>>>>>>
> >>>>>>>>>>>> What I can see is that EFI GOP reads some parameters from the
> >>>>>>>>>>>> firmware and
> >>>>>>>>>>>> infers the other, such as in this case problematic pitch, or
> >>>>>>>>>>>> stride.
> >>>>>>>>>>>
> >>>>>>>>>>> The pitch/stride value comes from the firmware via
> >>>>>>>>>>> pixels_per_scanline [1].
> >>>>>>>>>>>
> >>>>>>>>>>> Can you verify that this value is really 800 instead of 832 (eq
> >>>>>>>>>>> 3328 bytes) ?
> >>>>>>>>>>>
> >>>>>>>>>>> [1] https://elixir.bootlin.com/linux/v6.17.9/source/drivers/
> >>>>>>>>>>> firmware/ efi/libstub/gop.c#L493
> >>>>>>>>>>
> >>>>>>>>>> I actually got confused a bit in following the flow so thank
> >>>>>>>>>> you for
> >>>>>>>>>> asking me to double check.
> >>>>>>>>>>
> >>>>>>>>>> GOP actually reports 1280x800 with a stride of 5120. So it
> >>>>>>>>>> kind of
> >>>>>>>>>> reports a rotated view already, kind of.
> >>>>>>>>>
> >>>>>>>>> These are correct values.
> >>>>>>>>>
> >>>>>>>>> But the stream deck is this device: [1], right? It uses landscape-
> >>>>>>>>> mode orientation. Why does it require rotation at all?
> >>>>>>>>>
> >>>>>>>>> [1] https://de.wikipedia.org/wiki/Steam_Deck#/media/
> >>>>>>>>> Datei:Steam_Deck_(front).png
> >>>>>>>>
> >>>>>>>> That's the device yes. For the user the screen is landscape, but
> >>>>>>>> the
> >>>>>>>> actual panel is 800x1280 portrait. Left edge is top of the display.
> >>>>>>>> (Hence the pre-existing entry in drm_get_panel_orientation_quirk.)
> >>>>>>>
> >>>>>>> I see. So the EFI display settings are configured as if this was a
> >>>>>>> landscape panel.
> >>>>>>>
> >>>>>>> What happens if you leave the EFI settings as-is and simply
> >>>>>>> remove the
> >>>>>>> panel-orientation quirk?
> >>>>>>
> >>>>>> That would create effectively the same situation as without my patch
> >>>>>> because the panel-orientation quirk does not trigger unless detected
> >>>>>> screen is 800x1280. Result is corrupted console since fbcon thinks
> >>>>>> it is
> >>>>>> a landscape 1280x800 screen.
> >>>>>>>>>> Only when the rotation quirk from efifb_dmi_swap_width_height
> >>>>>>>>>> triggers the stride gets incorrectly recalculated:
> >>>>>>>>>>
> >>>>>>>>>>           u16 temp = screen_info.lfb_width;
> >>>>>>>>>>
> >>>>>>>>>>           screen_info.lfb_width = screen_info.lfb_height;
> >>>>>>>>>>           screen_info.lfb_height = temp;
> >>>>>>>>>>           screen_info.lfb_linelength = 4 * screen_info.lfb_width;
> >>>>>>>>>>
> >>>>>>>>>> So this is where things go wrong, well, they actually go wrong a
> >>>>>>>>>> little bit even earlier, in gop.c:
> >>>>>>>>>>
> >>>>>>>>>>       si->lfb_size = si->lfb_linelength * si->lfb_height;
> >>>>>>>>>>
> >>>>>>>>>> Which potentially underestimates the fb size. If GOP was forward
> >>>>>>>>>> looking enough to give us the size we could derive the pitch
> >>>>>>>>>> based
> >>>>>>>>>> on size..
> >>>>>>>>>>
> >>>>>>>>>> Anyway, as it stands it looks a quirk in sysfb_apply_efi_quirks
> >>>>>>>>>> looks it is required to fix it all up.
> >>>>>>>>>>
> >>>>>>>>>> I am a bit uneasy about declaring the fb size larger than what
> >>>>>>>>>> was
> >>>>>>>>>> implied by firmware provided pitch * height * depth but
> >>>>>>>>>> limited to a
> >>>>>>>>>> specific DMI match and if it looks visually okay I think it is a
> >>>>>>>>>> safe assumption the quirked size is actually correct and safe.
> >>>>>>>>>
> >>>>>>>>> Yeah, we better not do that.
> >>>>>>>> You mean declare it a firmware bug and live with the corrupt
> >>>>>>>> console
> >>>>>>>> until the final fb driver takes over?
> >>>>>>>
> >>>>>>> I only mean that we should not use more video memory than
> >>>>>>> provided by EFI.
> >>>>>>
> >>>>>> Right, but that information is not available in the GOP, right?
> >>>>>> Ie. as I
> >>>>>> wrote above it appears assumed:
> >>>>>>
> >>>>>>       si->lfb_size = si->lfb_linelength * si->lfb_height;
> >>>>>>
> >>>>>> Do we have any other options apart from corruption or assume firmware
> >>>>>> configured GOP screen info incorrectly?
> >>>>>>
> >>>>>
> >>>>> How does it make sense to recalculate the line length? Those invisible
> >>>>> pixels at the end of the scanline are not going to be transposed to
> >>>>> the other dimension, right?
> >>>>
> >>>> Not sure what you meant here. The line above is from gop.c and the
> >>>> context is that GOP screen info appears to not carry the frame buffer
> >>>> size in bytes so it is implied.
> >>>>
> >>>> Elsewhere in the patch I quirk the pitch to the correct value so
> >>>> rotated
> >>>> rendering is correct.
> >>>>
> >>>> But the corrected pitch also means that in principle we need to adjust
> >>>> the frame buffer size, since it is larger than the size implied with
> >>>> the
> >>>> incorrect pitch.
> >>>>
> >>>
> >>> OK, so if I understand all of the above correctly, you have a 800x1280
> >>> panel with 832 pixels per scanline, right? And the 5120 pitch is
> >>> simply bogus, but needed to maintain the fiction that the panel is
> >>> 1280 pixels wide, and so the resulting lfb_size is bogus too?
> >>>
> >>> Since we know that the PixelsPerScanline value is incorrect, I don't
> >>> think there is any point in attempting to cross reference this against
> >>> other firmware provided data. But it would make sense imho to apply
> >>> the quirk only if the exact combination of incorrect values (i.e.,
> >>> 1280x800/5120) is encountered.
> >>
> >> Right, the whole 1280x800 mode I *think* could be "bogus", that is,
> >> some kind of a software rotated mode implemented by the firmware.
> >>
> >> Default mode is 800x1280 (pitch 832), while this second native
> >> resolution mode is 1280x800 (pitch 1280).
> >>
> >> If default mode is left then both simpledrmfb and efidrmfb work fine.
> >> The existing panel orientation quirk will trigger on 800x1280 and tell
> >> fbcon to rotate.
> >>
> >> But if someone, like for example grub2, changed the mode to this
> >> software rotated one then the existing DRM quirk will not work.
> >
> > So this is a bug in grub? Should it supply the original mode?
> >
> >
> > Apologies for only asking dump questions here. I find this very confusing.
>
> Not at all, it is complicated and open whether it is worth improving.
>
> I don't think it is a grub bug. To me it seems like an unfortunate
> consequence of protocol limitations.
>
> > In the correct mode 800x1280, the first native pixel should be on the
> > lower left corner. and the second pixel should be 'up form it'. And
> > because it's marked as rotated CCW, fbcon adapts correctly.
> >
> > If the display is in the bogus mode 1280x800, in which direction does it
> > draw by default?  The framebuffer's first pixel should still be in one
> > of the corners. And the second pixel is nearby. In which direction does
> > it advance?
>
> I am not a grub expert, but I had a brief look at its codebase, and
> AFAICT it draws by software rendering into a shadow frame buffer and
> calls GOP->Blit to update the screen.
>
> As such my assumption is that with the fake 1280x800 mode, firmware
> implements the blit to rotate under the hood.
>
> So for grub everything is fine. It sets 1280x800, sees 1280x800, renders
> the menu in there, and courtesy of firmware blit the menu is presented
> in the human friendly orientation.
>

Indeed - GRUB never draws into the EFI GOP linear frame buffer
directly, and this seems to be what makes it work in this case.

Could you boot with video=efifb:list on the kernel command line to see
how the GOP modes are reported? I suppose the bug here is that the
mode in question is not reported with PixelFormat==PixelBltOnly as it
should be.

