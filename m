Return-Path: <linux-efi+bounces-3203-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BDCA7CFEB
	for <lists+linux-efi@lfdr.de>; Sun,  6 Apr 2025 21:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB423AE4D5
	for <lists+linux-efi@lfdr.de>; Sun,  6 Apr 2025 19:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1F817BB21;
	Sun,  6 Apr 2025 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE3IOZiT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E89146A72;
	Sun,  6 Apr 2025 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743967466; cv=none; b=XiPqsQQJejgigP2UwoZW76DJr2rD3lZa899m+jxi9i2TjS2I+sm9HI+hOgc+lLr2uvXoJGI9u0P+UnO0T2e4mYv8j4iexTnbNeXwg53pKX3SvD9MmseOiGRgaENmael+TYN/InYrnkBNPHZQMLTlWmLWgfTWCk6RpT2mPxrloLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743967466; c=relaxed/simple;
	bh=6tLvFLvhWnLUw2jwp9kpTNEEySXAPeUnebz0vEKqKBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yjeb5n65W06ZIbOYTD+ONrQ9PuJyXVGGzsacSSzaytQNgezXYwrChvetiwDvVNAH0gUUZpa3/y75AEn5LMT+IMnkAKkcL5ddZvCFbd2tNgvKb7ciVIV/E/qY7d3XjtMW4ozEz/BaREQ2tUvz3tW2ulc3ffmG0G4hkF8tItPBJAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE3IOZiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DD9C4AF0B;
	Sun,  6 Apr 2025 19:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743967465;
	bh=6tLvFLvhWnLUw2jwp9kpTNEEySXAPeUnebz0vEKqKBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GE3IOZiTjdLnFQAgap6a1yzjRQlJeJEsh/PsRAdFdXOp9t08OWYWTwjqMIPx87x9q
	 RRtOfTcr7glq124zkh0LfyjiYMhhfdD89+yhOQy84wdME+0KlPiKv5BTaPQ2r7XPYD
	 ZE8VuBcdgLEtnaLVJMB29JtG5T4LiMgIfx3BPBRZwb3FeL5+h1yiDQeTvb3iOq4i/l
	 IXFamYQeHRdh5oClMwhJU3mrWoayCGSS/KOc7GrTBY8a8tp0gYbFeLNQ/cUEZ1db13
	 fPpfJkkaJDdb52+PLp/QpY1pHL3dqn1rtQD7peuIYf5y8DDrvkyhH8tkiaSNoMv/KT
	 3t6zQbDx4bmfg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54b1095625dso4438754e87.0;
        Sun, 06 Apr 2025 12:24:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqhzD5URfZLv7F/c2Qw8/OPSgiIOiJNBoa4CUoEd2FpzeCtVGZCBOHaX8QZCwCn0eUx4qUgm0AZuA=@vger.kernel.org, AJvYcCVJSM+AbaqWp0IZLfgkwzsVyhRKe6HcXIEURM5a/jeY95gHceGguJT6R6IJXIpRIFD32OwV6Fyo7uBUY9bZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyYWcVeA5VDNO/4AtWsw49lvdVKtpyNURD3PaBzBHJtj+/79GMB
	pXHglnPYHgmaau9XwqTT/zjDvxJHKI5eYmzpHX3P1nujYt1nLgSDPO42O1WZNLl3WZIFD51W0nC
	B5l+mjnfjpiLKC6txfYbrBm9Ti2Y=
X-Google-Smtp-Source: AGHT+IHlTOBv13h3dsq/jBmeZoNliV3gZ5F0x3qP58gEEcKaaWzgwHrPQOFChIbPpvfE2bTHNaPK1MRX2be0ma17iF8=
X-Received: by 2002:a05:6512:3e08:b0:549:8ed4:fb64 with SMTP id
 2adb3069b0e04-54c227869d8mr3406472e87.24.1743967464229; Sun, 06 Apr 2025
 12:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401133416.1436741-8-ardb+git@google.com> <20250401133416.1436741-13-ardb+git@google.com>
 <Z_LNJO3q5QN82LN0@gmail.com>
In-Reply-To: <Z_LNJO3q5QN82LN0@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 6 Apr 2025 22:24:12 +0300
X-Gmail-Original-Message-ID: <CAMj1kXEqfyQBq=xfjbX5LwigiMb0ubFMd2+UCRkOJ+4O7boUHg@mail.gmail.com>
X-Gm-Features: ATxdqUFjGT8uz5TNG0XaFwKon3SzAQFZFc4Et6NDtI_-6rpPmVLk0vEVUrGcG0U
Message-ID: <CAMj1kXEqfyQBq=xfjbX5LwigiMb0ubFMd2+UCRkOJ+4O7boUHg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] x86/boot: Move early kernel mapping code into startup/
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 6 Apr 2025 at 21:51, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb+git@google.com> wrote:
>
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The startup code that constructs the kernel virtual mapping runs from
> > the 1:1 mapping of memory itself, and therefore, cannot use absolute
> > symbol references. Move this code into a separate source file under
> > arch/x86/boot/startup/ where all such code will be kept from now on.
> >
> > Since all code here is constructed in a manner that ensures that it
> > tolerates running from the 1:1 mapping of memory, any uses of the
> > RIP_REL_REF() macro can be dropped, along with __head annotations for
> > placing this code in a dedicated startup section.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/startup/Makefile     |   2 +-
> >  arch/x86/boot/startup/map_kernel.c | 232 ++++++++++++++++++++
> >  arch/x86/kernel/head64.c           | 228 +------------------
> >  3 files changed, 234 insertions(+), 228 deletions(-)
>
> So this patch breaks the x86-64 allmodconfig build:
>
>  ERROR: modpost: "page_offset_base" [arch/x86/crypto/aegis128-aesni.ko] undefined!
>  ERROR: modpost: "vmemmap_base" [arch/x86/crypto/aegis128-aesni.ko] undefined!
>  ERROR: modpost: "page_offset_base" [arch/x86/crypto/aesni-intel.ko] undefined!
>  ERROR: modpost: "vmemmap_base" [arch/x86/crypto/aesni-intel.ko] undefined!
>
> I suppose EXPORT_SYMBOL() in the new startup code isn't properly
> extracted?
>

No, and there is a fundamental issue here, as those exports use
absolute references.

I'll tweak this to keep these definitions in the old location.

