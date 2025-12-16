Return-Path: <linux-efi+bounces-5885-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 684FFCC3702
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 15:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0054306451F
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EAB322B87;
	Tue, 16 Dec 2025 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhRmTTh3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4F031DD90
	for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891497; cv=none; b=ZwbwEGTOaZ3g5uYoz+dC31b2ElTILGyTB+0hPcfjqeqVBm4iqzYRADU9Q0Q3txO2YJWa7hYI4+/TRF2oDfmeY/dqOkPt8KfXpt1QcwFDFEt5FAWPREVxP+D8/kP0BDbFHaaijbRAA4B1CdHwA9Hcw7z8AcTqahqOceKqmDSaaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891497; c=relaxed/simple;
	bh=OFjOLDZ+Htljn9mhZJvvPB7mxrz5xHNxpULHvNFA274=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfbkvPBXcydFqPvgd1+X1KLi21bw+9o9wfSpz1ZzWiRFU8kSWGpR7uL/92OfXaRHKz4FA/5VA0OgU+HRtAiowLCkoCdwp/5jCfbSEl/QliOYFuQ5kMIUH82x+g9Dh8W4RbtNlDsV/G6NEcvcPi8sctvHx8i4hr1kg/n/kX8OKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhRmTTh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82BCC4CEF1
	for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 13:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765891496;
	bh=OFjOLDZ+Htljn9mhZJvvPB7mxrz5xHNxpULHvNFA274=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FhRmTTh36eu/CDwWZvZ8g1ZMnmXK4TNT7d8kqvd3AXwlEMzVxvhjTJy9oNeMNuxxc
	 i2CCxCgtSbdslnAyzHb90nB2i6xvGUquyHJS///EGp9fGqGdo6ofHb0d9uLg1d+SsI
	 kIWYXD4Xg0Js+FMLncUZHECabbtZoPl29Cr6sIcgNRjdM3I84TgVaYfNS4Nodw3kAF
	 tGsWfFk9e6jdQ85hXHahi7aZqH/HYf8wr/gyorAAkAQ64yhqr+jHMkERqV721N1fM3
	 NUgqHEuIuxyvJzlUHnetEezk9F/IoVTkH3RsZPjSuoOKCQ/YmjIagbUuWr32pzeJpj
	 inRWN94XFn2qw==
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c363eb612so3087592a91.0
        for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 05:24:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6N+eDdoQQQa2drT/Ce25vZMFrVr75+1jWkzqRcAlJxnzVhHWFUYlIYmfGDfokCg6Ua0XC1OufR5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqRHS0aMXSYQTcOp95qpX86aY1MybT0G1km9JM+teV7RWXMXIu
	tjFZsHdow27cGEMhxTwuXgmAYUZ/jgMfTjiuX8NEbpJR63qv2GeCbN5BIb+qBMD06/Ym28En3vF
	m/Q9vVx9GPb/3oWx7snu1DhD7fSR8YZM=
X-Google-Smtp-Source: AGHT+IExnmvm24wckON7fJ9fYhZ0zYkTc+hqMRfIglpWonig7OEYfvLFTC7+mFwSOqtbgqRAHyvY2+x9TLgJ4A7eNZQ=
X-Received: by 2002:a17:90b:1fc6:b0:339:cece:a99 with SMTP id
 98e67ed59e1d1-34abd6dd2fcmr14151922a91.13.1765891496308; Tue, 16 Dec 2025
 05:24:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208193925.7449-1-tursulin@igalia.com> <CAMj1kXFZD+No6C4MEpmSY5Ha0DtJH+kHfTiO02By4ejUekLaRA@mail.gmail.com>
In-Reply-To: <CAMj1kXFZD+No6C4MEpmSY5Ha0DtJH+kHfTiO02By4ejUekLaRA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 16 Dec 2025 14:24:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHWWzqVKDO81+d6RAZrmZuLcoBhKNqCGJwX1bRyYkXVjQ@mail.gmail.com>
X-Gm-Features: AQt7F2qNW4SGOOjvSMv4uZLdKi0bWBL2AdBxefzKOS2b3E8LsGGZNjLFauQjcoo
Message-ID: <CAMj1kXHWWzqVKDO81+d6RAZrmZuLcoBhKNqCGJwX1bRyYkXVjQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] EFI fbcon fixes etc
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Melissa Wen <mwen@igalia.com>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Dec 2025 at 03:05, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 9 Dec 2025 at 04:39, Tvrtko Ursulin <tursulin@igalia.com> wrote:
> >
> > From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >
> > Two generic fixes split out for easy review, one refactoring as requested, and
> > then the last patch is the panel/mode quirk to allow for corruption free fbcon
> > with simpledrmfb and efidrmfb on the Valve Steam Deck.
> >
> > v2:
> >  * s/unsigned/unsigned int/
> >  * s/pitch/linelength/
> >  * Removed comment explaining the Steam Deck quirk.
> >  * Added patch to refactor quirk application via callbacks.
> >
> > v3:
> >  * Added forgotten __initconst.
> >  * Use separate callback for the fixup quirk.
> >
> > v4:
> >  * Use __screen_info_lfb_bits_per_pixel() instead of accessing lfb_depth directly.
> >
> > v5:
> >  * s/lfb_width/bpp/.
> >  * Grammar and typo tidy in the last patch.
> >
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Melissa Wen <mwen@igalia.com>
> > Cc: linux-efi@vger.kernel.org
> >
> > Tvrtko Ursulin (4):
> >   efi: sysfb_efi: Replace open coded swap with the macro
> >   efi: sysfb_efi: Fix lfb_linelength calculation when applying quirks
> >   efi: sysfb_efi: Convert swap width and height quirk to a callback
> >   efi: sysfb_efi: Fix efidrmfb and simpledrmfb on Valve Steam Deck
> >
> >  drivers/firmware/efi/sysfb_efi.c | 73 ++++++++++++++++++++++++++++----
> >  1 file changed, 65 insertions(+), 8 deletions(-)
> >
>
> This looks fine to me now. Unless there are more comments, I intend to
> get this queued up as soon as -rc1 comes around.
>

Queued up now, thanks.

