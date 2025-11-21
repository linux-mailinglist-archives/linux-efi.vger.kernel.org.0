Return-Path: <linux-efi+bounces-5645-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B364DC7ACFD
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 17:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 272CB3487DE
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 16:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64F31328B;
	Fri, 21 Nov 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVn7sgHi"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E442C08D5
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741999; cv=none; b=prGTHRcL4njnHRHyty22wVDZ/ne4poN0/yTjJCoTl8PkZjShIZlvGyXIJw6uYQ6fBSJqj2gMHO67yR+3OovPIqqpO+ZEIKefClM5o+tfpHCd8POhH0kaTmpSmoUIlciuaDnIi8WuPqfWe+ZudjCM7/5CKpdkbKYZrR1Er3RoE9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741999; c=relaxed/simple;
	bh=cET4fLR+Sx0tqItmiU0JPHurpZgDU1nqYWJPQ7uvhYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQ4ERIEkTxnDYRPSpEvgXILopBYmjt13aUXoGzcjuIx0xXu14FhocXqIhMSCU/P3/6BroRQK7UW6LNjLMjyah35ImBlFz5hNrJ9LCn/QGwtvv7Df0ENtGLpIA1W36R2FcJK6Pi2r1EULFsqRztc2hBxv7xcbrfhrqYRR+UCkNGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVn7sgHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6BCC116C6
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763741998;
	bh=cET4fLR+Sx0tqItmiU0JPHurpZgDU1nqYWJPQ7uvhYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LVn7sgHiTk6RLTGHtFAYvT5jt8uzinAFRBsJxMA1SfZel1bMIJ1hFT843Hnfd20C6
	 yJGuhMhYYhggX1rZbeXzTJCiyw2JtfyOjPdE+gZyUeZuHTa/3fich29WX1yfpBasMI
	 +pp3yZJV7CyDiEY2ErtONnDXBelFq5fitTil+cntXvg4ftcD+K4w6Y/2+c3n+JqRod
	 RKqEoEU/bqquH5adcQVN11faw3W7KgplzC+Js1wPpvpvsdHqhTqSANFBA4dC1xnUXv
	 TXqyK+KZNpwLWL/7XkONE899kog8Wbxb7wgM3KGd+kdA3ao++oNai2xTACQ3304AlS
	 7mJu7ZkTqBQIg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5957d7e0bf3so3076064e87.0
        for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 08:19:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhVlmshO0Wtyg7puN++0c6OZl/VROGh21IGgvFbCSAoY5ng+881kd7+BFwx/uHhtBbPGyQ3NO+OAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XDpHDUDvxdxrEt1G+Nd3XWhZfl6wA+9EobkmAU8WR/9keBmQ
	8V4lcNfhc81mTfKKWXKI3kPkCDX3/2o03YV0H51IUrkcmoMktKvxvVLtV0PP32bk5k5d7mm2BMh
	Fdxf+iuADhLBXsIG6JeRaGDG9RHq6Y7A=
X-Google-Smtp-Source: AGHT+IGeSY0QcKkdeUCs++wMYjj72N3cUYU9kW2Fl9IQJ23AXOiUCrIM5BGdicOeoDbtfPEdjzSeYm/zK81S5JjGD00=
X-Received: by 2002:ac2:4e04:0:b0:595:90ce:df8e with SMTP id
 2adb3069b0e04-596a3740821mr1260884e87.5.1763741997082; Fri, 21 Nov 2025
 08:19:57 -0800 (PST)
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
In-Reply-To: <6dff8e7e-c99b-443d-a1d8-22650ca0b595@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 21 Nov 2025 17:19:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGpC_162bFL65kQw=7qVP7ezYw77Q76y217dDs8pqHogw@mail.gmail.com>
X-Gm-Features: AWmQ_bn-6TfeudJLq0R8hLHr8efLSQaLZUt3gyg8tPWks9v2PmiXguu4ImOLBA0
Message-ID: <CAMj1kXGpC_162bFL65kQw=7qVP7ezYw77Q76y217dDs8pqHogw@mail.gmail.com>
Subject: Re: [PATCH 0/6] arch, sysfb: Move screen and edid info into single place
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Javier Martinez Canillas <javierm@redhat.com>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 17:09, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
>
>
> Am 21.11.25 um 17:08 schrieb Thomas Zimmermann:
> > Hi
> >
> > Am 21.11.25 um 16:56 schrieb Ard Biesheuvel:
> >> On Fri, 21 Nov 2025 at 16:53, Thomas Zimmermann <tzimmermann@suse.de>
> >> wrote:
> >>> Hi
> >>>
> >>> Am 21.11.25 um 16:16 schrieb Ard Biesheuvel:
> >>>> On Fri, 21 Nov 2025 at 16:10, Arnd Bergmann <arnd@arndb.de> wrote:
> >>>>> On Fri, Nov 21, 2025, at 14:36, Thomas Zimmermann wrote:
> >>>>>> Replace screen_info and edid_info with sysfb_primary_device of type
> >>>>>> struct sysfb_display_info. Update all users.
> >>>>>>
> >>>>>> Sysfb DRM drivers currently fetch the global edid_info directly,
> >>>>>> when
> >>>>>> they should get that information together with the screen_info
> >>>>>> from their
> >>>>>> device. Wrapping screen_info and edid_info in
> >>>>>> sysfb_primary_display and
> >>>>>> passing this to drivers enables this.
> >>>>>>
> >>>>>> Replacing both with sysfb_primary_display has been motivate by
> >>>>>> the EFI
> >>>>>> stub. EFI wants to transfer EDID via config table in a single entry.
> >>>>>> Using struct sysfb_display_info this will become easily possible.
> >>>>>> Hence
> >>>>>> accept some churn in architecture code for the long-term
> >>>>>> improvements.
> >>>>> This all looks good to me,
> >>>>>
> >>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >>> Thanks
> >>>
> >>>>> It should also bring us one step closer to eventually
> >>>>> disconnecting the x86 boot ABI from the kernel-internal
> >>>>> sysfb_primary_display.
> >>>>>
> >>>> Agreed
> >>>>
> >>>> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> >>> Thanks
> >>>
> >>>> I can take patches 1-2 right away, if that helps during the next
> >>>> cycle.
> >>>   From my sysfb-focused POV, these patches would ideally all go through
> >>> the same tree, say efi or generic arch, or whatever fits best. Most of
> >>> the other code is only renames anyway.
> >>>
> >> I don't mind queueing all of it, but I did get a conflict on
> >> drivers/pci/vgaarb.c
> >
> > Probably from a78835b86a44 ("PCI/VGA: Select SCREEN_INFO on X86")
>
> https://lore.kernel.org/all/20251013220829.1536292-1-superm1@kernel.org/
>

Yes, if I merge back -rc2 first, I can apply patches 1-5 onto my
efi/next tree. But then I hit

Applying: sysfb: Move edid_info into sysfb_primary_display
error: sha1 information is lacking or useless (drivers/gpu/drm/sysfb/efidrm.c).
error: could not build fake ancestor
Patch failed at 0006 sysfb: Move edid_info into sysfb_primary_display

If you prefer, you can take the whole lot via the sysfb tree instead,
assuming it does not depend on the EDID changes I already queued up?

