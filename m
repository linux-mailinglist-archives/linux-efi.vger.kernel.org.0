Return-Path: <linux-efi+bounces-5655-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C779C7CEBB
	for <lists+linux-efi@lfdr.de>; Sat, 22 Nov 2025 12:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA1FB34E504
	for <lists+linux-efi@lfdr.de>; Sat, 22 Nov 2025 11:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246E82FE566;
	Sat, 22 Nov 2025 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ipvswz18"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8C2F90E0
	for <linux-efi@vger.kernel.org>; Sat, 22 Nov 2025 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763811792; cv=none; b=GLAV7G/W6gG6GKPenuiRz+LwRpd0EyFTiUQr+I72Q3Lj1KxwskLo1nJTxK5CvR3LPAK7QV2vWz+aGHxyBYKs4lxqEBPJL1si23i64rQGSx2G5+ts951Z+adG7yUOHfjZ8frfk+SuMAY6RX5cESkbJs70uqc0NGxvomplf24gUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763811792; c=relaxed/simple;
	bh=p8H88tgM9+gXap9lRijwllIzLZu5llgC1f7xv5nwybk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3yanYYUgOdY5Dl4BDbsiCSNZ0ugrO1pug+/87GfV1YVNBylHObRHVm6jGc+tRQz2TS2CCWzdFN4y6KqioIYfoYmwDzaTehzkzslPe/tjSLiUwjSeuH5o92+4Givei5FLq5mh2Q4gVNzyKlO2KZmaaf1E9zbFJNlKrwJ7dZ5Rc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ipvswz18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E1BC19424
	for <linux-efi@vger.kernel.org>; Sat, 22 Nov 2025 11:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763811791;
	bh=p8H88tgM9+gXap9lRijwllIzLZu5llgC1f7xv5nwybk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ipvswz18aqd0/TPfyaDV4JwDv6OLD0cZeJIq8CrXbsMPz1VZwsapYJAtdiVIc37YT
	 P/L0lbDBumBVIGHT+mEZV/7MD9cSmtv3T3DWptmTmc9qxDrBKkyRPXa4Ae8aE0PQUQ
	 HbDVsMpuUKTcGgV/9mxXWCLrCfILdEio7MaZrfnJFLJTlc/yk47dzUsqNJjonEuNfi
	 r7fYLuhO8HnGh2sORE0RhoxErJSvva28uDuBOu5ftFkehUDuNOUqLnkO6/lmnaImM7
	 hcZKmV+aF+35cjIVo76O+EsmfvKSnHRb4a8+jOL/NKN437gxi/5FmsRnI8XRWwG0Y8
	 yt3iC2HpajEig==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5942a631c2dso3364137e87.2
        for <linux-efi@vger.kernel.org>; Sat, 22 Nov 2025 03:43:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWALGoqvxxsbiOVjYtrv/ghbQXJbT9JtYUHJmPTMeQ1aKTK9oyCCoppp2mcCfX5XNFZM4KNAs0S4Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQuNo+22+hMAGXEVm6obk7VGRwb/V64ry4CnrgXHOMh1Cq74Cb
	kblSdtcQt51ZePCQGxIi8Xjcxx6HVKL6vSPPwV5gITH9woDq5qjBqUMHtCfj+R5mwyfeqNYU8uJ
	GGpu04v2g/AGHFdRFU0EzQ380xhzlIHQ=
X-Google-Smtp-Source: AGHT+IGKRFlgwehxRBm62tvmwTXy609E55PZi7OAqnBZ+de0+tT9jGT1vTKQcXSXNqsiURj9qycDJBw3M2X6JvRwZDY=
X-Received: by 2002:a05:6512:3b27:b0:592:fa8a:810d with SMTP id
 2adb3069b0e04-596a3ea7847mr1884146e87.16.1763811789974; Sat, 22 Nov 2025
 03:43:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121135624.494768-1-tzimmermann@suse.de> <96a8d591-29d5-4764-94f9-6042252e53ff@app.fastmail.com>
 <CAMj1kXF1Dh0RbuqYc0fhAPf-CM0mdYh8BhenM8-ugKVHfwnhBg@mail.gmail.com>
 <199e7538-5b4a-483b-8976-84e4a8a0f2fd@suse.de> <CAMj1kXE+mS1Sm5GaROU0P97J2w1pew0P_To4sKiw8h1iOMuLcg@mail.gmail.com>
 <d080729c-6586-4b9c-b234-470977849d3d@suse.de> <6dff8e7e-c99b-443d-a1d8-22650ca0b595@suse.de>
 <CAMj1kXGpC_162bFL65kQw=7qVP7ezYw77Q76y217dDs8pqHogw@mail.gmail.com>
 <8d0bc096-e346-462b-a274-f0cc1456eea3@suse.de> <CAMj1kXFdethf2sb1tm1V4wRW1SyPt-OnCmaAXc5cHNKuLJMXWA@mail.gmail.com>
 <4c716fd1-c989-4e48-9878-e7312fefc302@suse.de>
In-Reply-To: <4c716fd1-c989-4e48-9878-e7312fefc302@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 22 Nov 2025 12:42:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHO12LritnbMXapGBV8QnQOCVopJbaBi2ejMUgZQFGdSg@mail.gmail.com>
X-Gm-Features: AWmQ_blTv2LH7aQFylqJjjKyEMR6uIyXZhGHq7nWzAQ8kC07d8tB-75tF0Nly1A
Message-ID: <CAMj1kXHO12LritnbMXapGBV8QnQOCVopJbaBi2ejMUgZQFGdSg@mail.gmail.com>
Subject: Re: [PATCH 0/6] arch, sysfb: Move screen and edid info into single place
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Javier Martinez Canillas <javierm@redhat.com>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Nov 2025 at 11:52, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 21.11.25 um 17:31 schrieb Ard Biesheuvel:
> > On Fri, 21 Nov 2025 at 17:26, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Hi
> >>
> >> Am 21.11.25 um 17:19 schrieb Ard Biesheuvel:
> >>> On Fri, 21 Nov 2025 at 17:09, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>>>
> >>>> Am 21.11.25 um 17:08 schrieb Thomas Zimmermann:
> >>>>> Hi
> >>>>>
> >>>>> Am 21.11.25 um 16:56 schrieb Ard Biesheuvel:
> >>>>>> On Fri, 21 Nov 2025 at 16:53, Thomas Zimmermann <tzimmermann@suse.de>
> >>>>>> wrote:
> >>>>>>> Hi
> >>>>>>>
> >>>>>>> Am 21.11.25 um 16:16 schrieb Ard Biesheuvel:
> >>>>>>>> On Fri, 21 Nov 2025 at 16:10, Arnd Bergmann <arnd@arndb.de> wrote:
> >>>>>>>>> On Fri, Nov 21, 2025, at 14:36, Thomas Zimmermann wrote:
> >>>>>>>>>> Replace screen_info and edid_info with sysfb_primary_device of type
> >>>>>>>>>> struct sysfb_display_info. Update all users.
> >>>>>>>>>>
> >>>>>>>>>> Sysfb DRM drivers currently fetch the global edid_info directly,
> >>>>>>>>>> when
> >>>>>>>>>> they should get that information together with the screen_info
> >>>>>>>>>> from their
> >>>>>>>>>> device. Wrapping screen_info and edid_info in
> >>>>>>>>>> sysfb_primary_display and
> >>>>>>>>>> passing this to drivers enables this.
> >>>>>>>>>>
> >>>>>>>>>> Replacing both with sysfb_primary_display has been motivate by
> >>>>>>>>>> the EFI
> >>>>>>>>>> stub. EFI wants to transfer EDID via config table in a single entry.
> >>>>>>>>>> Using struct sysfb_display_info this will become easily possible.
> >>>>>>>>>> Hence
> >>>>>>>>>> accept some churn in architecture code for the long-term
> >>>>>>>>>> improvements.
> >>>>>>>>> This all looks good to me,
> >>>>>>>>>
> >>>>>>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >>>>>>> Thanks
> >>>>>>>
> >>>>>>>>> It should also bring us one step closer to eventually
> >>>>>>>>> disconnecting the x86 boot ABI from the kernel-internal
> >>>>>>>>> sysfb_primary_display.
> >>>>>>>>>
> >>>>>>>> Agreed
> >>>>>>>>
> >>>>>>>> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> >>>>>>> Thanks
> >>>>>>>
> >>>>>>>> I can take patches 1-2 right away, if that helps during the next
> >>>>>>>> cycle.
> >>>>>>>     From my sysfb-focused POV, these patches would ideally all go through
> >>>>>>> the same tree, say efi or generic arch, or whatever fits best. Most of
> >>>>>>> the other code is only renames anyway.
> >>>>>>>
> >>>>>> I don't mind queueing all of it, but I did get a conflict on
> >>>>>> drivers/pci/vgaarb.c
> >>>>> Probably from a78835b86a44 ("PCI/VGA: Select SCREEN_INFO on X86")
> >>>> https://lore.kernel.org/all/20251013220829.1536292-1-superm1@kernel.org/
> >>>>
> >>> Yes, if I merge back -rc2 first, I can apply patches 1-5 onto my
> >>> efi/next tree. But then I hit
> >>>
> >>> Applying: sysfb: Move edid_info into sysfb_primary_display
> >>> error: sha1 information is lacking or useless (drivers/gpu/drm/sysfb/efidrm.c).
> >>> error: could not build fake ancestor
> >>> Patch failed at 0006 sysfb: Move edid_info into sysfb_primary_display
> >>>
> >>> If you prefer, you can take the whole lot via the sysfb tree instead,
> >>> assuming it does not depend on the EDID changes I already queued up?
> >> Sure, I can also add it to the drm-misc tree. ETA in upstream would be
> >> v6.20-rc1.
> >>
> > But does that mean the EDID firmware on non-x86 will have to wait for
> > 6.21? I was trying to avoid making this a 6 month effort.
>
> No problem. Then let me rebase onto linux-next and put the existing EDID
> patches for EFI on top. It's mostly acked or reviewed already. Once we
> have it in good shape we can merged it all at once via the linux-efi
> tree. Does that work for you?
>

Sounds good.

