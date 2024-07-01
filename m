Return-Path: <linux-efi+bounces-1334-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F5B91D779
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 07:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F4DB20A95
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 05:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D66E2F34;
	Mon,  1 Jul 2024 05:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jx1Xt2qB"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871510E6;
	Mon,  1 Jul 2024 05:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719812332; cv=none; b=r/u9+0l6Lm9JwKRzYpt6lsX8U9gWmqh7Jl7XLbTPzyKWumTbi5cOIG+Z22qXS4q7MeED1UgNL9trTBXSl5IkZOMNRkeyljzO9wbrzqA+9RRoNchEJKO8abFEIbdAMmYrb/luRPlx8PLKxVO8wWkhlQ6GaY++qaYNep6JuNoCcwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719812332; c=relaxed/simple;
	bh=q6h+aEr/APEX/Xjs1jlC1Eb8ftOqQJoONxRWUmJdwwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKHTvcS1JrwbY2gLX7RB9gT5vjwSurLckVYw21QjmEi4ePytOqTUs4JnWKH88xJ6XnivjaLBWhjjXGOJVPkCq1qoNe94zXlq3FlIgG0Iuw1iREbSfJ08XY3CLxlXdoDJtkrBa+WR0SA1nWTsfQn857XV2Pr3hOXC1C0HfTKAK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jx1Xt2qB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A19C4AF0E;
	Mon,  1 Jul 2024 05:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719812331;
	bh=q6h+aEr/APEX/Xjs1jlC1Eb8ftOqQJoONxRWUmJdwwc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jx1Xt2qBXKo9JK97/ziJkf6bPwIH4/RsTECwdcOGawJBOs+r6ltQVt+OfE4DghaKD
	 qhrbpVoXSeou4LfwPhGo8czsH324fDrO7hd/L8z5qTe0C6+w2o8thSxirNExakCAtd
	 wJtS/lxzaTpwevDuQveFA/7zhsgyYbGPLZ8TvawJZqzbLihmh+Z0l5CzM5ZMGVuU8j
	 Ldl1E6NsFT+KrvEoJkjG/AycQVKcUR6f2J5G05OgcLVrjTXoEeeWHyzSP9NZOSMrdv
	 5BUy3KaeW3VVIDJK5AKRfbRxMnFuviKq9aT/MtmMztUMNnapkYTRBwUHG5uYcq8cZH
	 2X/LUCKVZxgkg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec595d0acbso30777861fa.1;
        Sun, 30 Jun 2024 22:38:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVE4G7pqf62U/Q/OQIZxEPT2T9OuJPPPj1T6km3UqJ8eQZIfVDXVCIv9U61KwNgRhI8Bk1UNcPJwDK6xgFv+iUQx4S6gpkWDU407jFBSm9ylD97RPPigQpp/A4p5peGSbJCohHY5GxX
X-Gm-Message-State: AOJu0YzqEXCZySNQy36QkJAfWQzPbr8as0ksAf/Cde1fNuA8MStL3Cf0
	6O//0mpx9VW2FFlKN0G8oqQQNyB67BKJ5unL7A2QmNkvZxsubDAIHcQmJqghDnpb1HFTTKKRh72
	zacQgdFuxy23QPABmQ2SmyPyUC/A=
X-Google-Smtp-Source: AGHT+IE9c0f9Ge8w7lawJxdPjygfsjbStax8v+0UVoj0FgreatWXPtof7a8C9FnHidmsY/noZfFKoe1vIntoLZAjVPg=
X-Received: by 2002:a2e:a36b:0:b0:2ec:5019:8fa4 with SMTP id
 38308e7fff4ca-2ee5e6f794dmr29587351fa.49.1719812329702; Sun, 30 Jun 2024
 22:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com> <ZoJAAifMqIDXdniv@wunner.de>
In-Reply-To: <ZoJAAifMqIDXdniv@wunner.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 1 Jul 2024 07:38:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
Message-ID: <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os protocol
To: Lukas Wunner <lukas@wunner.de>
Cc: Aditya Garg <gargaditya08@live.com>, Hans de Goede <hdegoede@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Kerem Karabay <kekrby@gmail.com>, 
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 07:35, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sun, Jun 30, 2024 at 07:24:54PM +0000, Aditya Garg wrote:
> > @@ -335,9 +359,12 @@ static const efi_char16_t apple[] = L"Apple";
> >
> >  static void setup_quirks(struct boot_params *boot_params)
> >  {
> > -     if (IS_ENABLED(CONFIG_APPLE_PROPERTIES) &&
> > -         !memcmp(efistub_fw_vendor(), apple, sizeof(apple)))
> > -             retrieve_apple_device_properties(boot_params);
> > +     if (!memcmp(efistub_fw_vendor(), apple, sizeof(apple))) {
> > +             if (IS_ENABLED(CONFIG_APPLE_PROPERTIES)) {
> > +                     retrieve_apple_device_properties(boot_params);
> > +             }
> > +             apple_set_os();
> > +     }
>
> Nit: Unnecessary curly braces around retrieve_apple_device_properties().
>
> (And I'd appreciate a blank line between it and the apple_set_os() call.

Indeed. I can fix that up when applying.

Any thoughts on whether this should depend on CONFIG_APPLE_GMUX or not?

