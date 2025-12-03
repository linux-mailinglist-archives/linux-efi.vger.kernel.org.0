Return-Path: <linux-efi+bounces-5779-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5412CC9EA9C
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 11:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A2E3A2EAD
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 10:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378672E7F17;
	Wed,  3 Dec 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3SlxfLj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1293B2E7BB6
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756815; cv=none; b=qsIEYspsNpjMlhGRWT0BrQLyz2bdA6t4U8IdJymINqzr52f0YTUbQSIMelPWZDY8WHnmVXhsw+mW9AOYiqp6yeLxQgA+01JoXOrPoHfLvt2XBz/NPHpQT7mkqymLwJXpFa7SFQ/Rqv4qZ8mJhDfzGiBvmILFUab3ysDauo8lh5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756815; c=relaxed/simple;
	bh=Cze7ErqqkpLz+XZgBbYQeWtEMFdLresxu3cFBZSDmwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Au5r/sTDTldTdimqaFVmgWLOIz1gEVMz1C/u82F/dxMa8wcISFM9r8RlBHeEA6QODjZPHqbZKhJOikxIKSLVaxBMj0q1+ZYSu7BPU8pbgW6wzxmQB3dSlyVOBWtQvMi2dMHBbOCYRFeYHcXNpeRqbg5WUKPeszRsbpD4XY91YLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3SlxfLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6CCC4CEFB
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 10:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764756814;
	bh=Cze7ErqqkpLz+XZgBbYQeWtEMFdLresxu3cFBZSDmwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J3SlxfLjIXh7j++wbN3LncYbvLl6gZsy/73oKRu0K4omyZDnH99kc/y72vXNcMec8
	 a2LWZRFf29nrTz4wRAXVJme9R6jQQfS4XxbXaafn+HGga8139pa6T2bRmqj08E8UEG
	 zVj0IMja6R1B7t8gvoskW4PRaeUOzvVgiwM9sUMozhYi/Hge/z/DRvVJqHDHLBNqrl
	 EKe3AYszafBC4jxYpvBWcjkPOGoCytXYrMo64GNvUMvIsfThVjKbgtWIhiI3PKBHgE
	 NPHV5NvTk2MBzgNNd/3Ll1Pf5lY5/hu5gwVq+/VkjV/wBOeNQ59cz8YOFaY/QKdNdn
	 rb7UWk74j8YSQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5957f617ff0so7411286e87.2
        for <linux-efi@vger.kernel.org>; Wed, 03 Dec 2025 02:13:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtnt8yoFX/eLAUM9y+02Q0Cv+Zfo7V3Lm4qTx148w9ihCYp0KA7iIQWuEszxJsiZyOiR3YTzGu680=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFwx4V4ZhERxiVnIdrG87Jm7fMW6PN/ufcpMpgXJjuLVvaSpdv
	y1aagC/UVbvCWgkwqF+WnmnMcsb1AIcylRTjpkFR3Wir6JxIqJpDJitb1/ovugy+wv3vCIjbQzI
	Q6HN3/o0/Z/HVwj7SY9677pqqc/f9cEE=
X-Google-Smtp-Source: AGHT+IEjQdkj/1Cic2lgrgFI19Se8QQ3Qy9UY9j5vrT08a555bfB2V1g7tUBZQ/05JQna5TxbQlzBvcPBTY6A+9cW6k=
X-Received: by 2002:a05:6512:3d9e:b0:595:90f9:b9d2 with SMTP id
 2adb3069b0e04-597d3f017f7mr851029e87.3.1764756812858; Wed, 03 Dec 2025
 02:13:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203090706.53778-1-tvrtko.ursulin@igalia.com>
 <20251203090706.53778-5-tvrtko.ursulin@igalia.com> <5ecc23ed-929f-4e60-a7a1-d4bd759e9af2@suse.de>
In-Reply-To: <5ecc23ed-929f-4e60-a7a1-d4bd759e9af2@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 3 Dec 2025 11:13:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEVq65rBQraKn8kcCiA6wU7tPfCCbf2Bma4F3p0As3ToQ@mail.gmail.com>
X-Gm-Features: AWmQ_blXylcyxLDhJlO_QB6L4rIs-0IgKCx6-qBnsdZeLqjAGgiMfCwJCVsEYwk
Message-ID: <CAMj1kXEVq65rBQraKn8kcCiA6wU7tPfCCbf2Bma4F3p0As3ToQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] efi: sysfb_efi: Fix efidrmfb and simpledrmfb on
 Valve Steam Deck
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org, 
	kernel-dev@igalia.com, Melissa Wen <mwen@igalia.com>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Dec 2025 at 11:05, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 03.12.25 um 10:07 schrieb Tvrtko Ursulin:
> > Valve Steam Deck has a 800x1280 portrait screen installed in a landscape
> > orientation. The firmware offers a software rotated 1280x800 mode which
> > GRUB can be made to switch to when displaying a boot menu. If this mode
> > was selected frame buffer drivers will see this fake mode and fbcon
> > rendering will be corrupted.
> >
> > Lets therefore add a selective quirk inside the current "swap with and
> > height" handling, which will detect this exact mode and fix it up back to
> > the native one.
> >
> > This will allow the DRM based frame buffer drivers to detect the correct
> > mode and, apply the existing panel orientation quirk, and render the
> > console in landscape mode with no corruption.
> >
> > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Melissa Wen <mwen@igalia.com>
> > Cc: linux-efi@vger.kernel.org
> > ---
> >   drivers/firmware/efi/sysfb_efi.c | 56 +++++++++++++++++++++++++++++---
> >   1 file changed, 51 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> > index eacf9a50eab2..566492e67798 100644
> > --- a/drivers/firmware/efi/sysfb_efi.c
> > +++ b/drivers/firmware/efi/sysfb_efi.c
> > @@ -231,16 +231,42 @@ static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
> >       {},
> >   };
> >
> > +struct efifb_mode_fixup {
> > +     unsigned int width;
> > +     unsigned int height;
> > +     unsigned int linelength;
> > +};
> > +
> >   static int __init efifb_swap_width_height(const struct dmi_system_id *id)
>
> It's something different now. Can this please become a separate list
> with a separate callback?
>

Why? That means we have to introduce another dmi_check_system() call,
and manually implement the logic to ensure that it is not called
redundantly, i.e., after the first one already found a match.

