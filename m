Return-Path: <linux-efi+bounces-3588-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2A5AA8925
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 21:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125453B576A
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 19:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95831ACEBB;
	Sun,  4 May 2025 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd6Gart1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6A137E;
	Sun,  4 May 2025 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746387197; cv=none; b=O11zqRwylIQDGmWpWzm8TcXy+9mJ95qz6svgPvkJagb8+WSRnxIWNwReBKhgTuZdwV9xXSec60rRiZDR50Dw6/rIRfMyzTsKFmSMTbxUlaLA73utlRyRLnpF3twpgtbb61VMDvLMwrGAE8+bw8uSLhkdEznfSM5NZVgrALr8vGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746387197; c=relaxed/simple;
	bh=fexXmQdyZ/vERD6uYvIyME5r2X/mErKmLfdIPSUz+1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmS3lY6vjgxODOQtpMFa7iwEXUQpii3zeTSNslDrh7x6DsFv0XV3+0nJU+V0k3Wz75haNi+/QJrqm12J4EKRLCNfB4ySsrqEt5n1PjhjhZpqF5XRpHzhY0IRdduvMc2ZG9f7SxZMCMG85IDYy8Sn5TEnkSXmNghy4Wm0LISRW9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd6Gart1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4B7C4CEEE;
	Sun,  4 May 2025 19:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746387196;
	bh=fexXmQdyZ/vERD6uYvIyME5r2X/mErKmLfdIPSUz+1g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bd6Gart1CPYXw32krELquNIVxKj1ZtBddevozvMAIbHzwqgQbwiG4KddVFTxZ/3VO
	 1LSZj34QgiyqMiGw997sv/sW9ZQPOutq3Pe2Fj7oUOooVndDgbYqBifdUAA8Zwb61Z
	 tDU0UgJmycqBD/JHpZMLuxlOUQQJIF6GGtqfe/6zKZB1osoo0bAGhgpB/XBCcdHciv
	 /ZkmjrrZ3lYNiTFke6CvlVObjhBv2F0JaZdd2tF0VaLrKu+eV7e0gka3cAJ8uwji33
	 7iPXRUh/Os0pdxmFXmxljtbYvDDasvCNIHPjVU5yUAPJn4t+kwAwFr65I+AJZmmTkx
	 n0xVs6ToAWMYg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so51657111fa.1;
        Sun, 04 May 2025 12:33:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVE9dGekyCJSbmOiTYjZDVyNeTvIht7pt8n01eZA8LvRSi/9OWEfdpJOOohV6hypmxCGYyPZBBu+jtWftjW@vger.kernel.org, AJvYcCXK7nP4e7JP2EqYbnnf7ntaHIjrjLj0teTDWPI38SnUOUtRACnDsgFU+qDVKErFHHVavPMjD+QMutA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9iNi6ZVjhP0DzO7sRtCYhQjHQb8vJRvzBObL+4CxuoAy70s6W
	M3+qDYXguSZhc336l2A6Bok5brkOct6DCZ+i+xl9vzwdhT/iN9tZEuKzk+uPI20yBsYY9oInlua
	Qi7xPbJsGgOOjmJJhVLFPIfRFpGc=
X-Google-Smtp-Source: AGHT+IGgPuLEUK0k5cwIqTU8+7eH4UpoibqwCEnky19l8SpePrBzs7N2qW1u2F2OjqyKDOLjWddj2/PVqYVtGRzkAfs=
X-Received: by 2002:a05:6512:3055:b0:54d:6b7f:affa with SMTP id
 2adb3069b0e04-54ea7a44536mr3844838e87.1.1746387194491; Sun, 04 May 2025
 12:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-28-ardb+git@google.com> <aBdwwR52hI37bW9a@gmail.com> <CAHk-=wiaEzS_7CBVTz3RYnDt5zJus_GsPtfSjojkqiiMU-vSHQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiaEzS_7CBVTz3RYnDt5zJus_GsPtfSjojkqiiMU-vSHQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 4 May 2025 21:33:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFF0mwtLFDwGh7rafodCMX_0gfbtOwPceFVHrJT+uoH0g@mail.gmail.com>
X-Gm-Features: ATxdqUFVsshUCM6tTejWsbDNOCJYzYwU7PsEtfiBdZjzxIs_w9JJGNlaM3GjWN0
Message-ID: <CAMj1kXFF0mwtLFDwGh7rafodCMX_0gfbtOwPceFVHrJT+uoH0g@mail.gmail.com>
Subject: Re: [RFT PATCH v2 03/23] x86/boot: Drop global variables keeping
 track of LA57 state
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 May 2025 at 16:58, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 4 May 2025 at 06:51, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Cannot pgtable_l5_enabled() be a single, simple percpu flag or so?
>
> Isn't this logically something that should just be a static key? For
> some reason I thought we did that already, but looking around, that
> was only in the critical user access routines (and got replaced by the
> 'runtime-const' stuff)
>

The ordinary, late version of pgtable_l5_enabled() is #define'd to
cpu_feature_enabled(), which is runtime patched in a slightly more
efficient manner than the alternative I'm proposing here. It is
conceptually the same as a static key, i.e., the asm goto() gets
patched into a JMP or a NOP.

Whether or not using runtime constants are worth the hassle for
pgdir_shift and ptrs_per_p4d is a different question, I'll keep them
as ordinary globals for now, and drop the conditional expressions.

> But I guess that what Ard wants to get rid of is the variable itself,
> and for early boot using static keys sounds like a bad idea.
>

I wanted to get rid of the variable, and then noticed the nasty
'#define USE_EARLY_PGTABLE_L5' thing, so I attempted to fix that as
well. (Having to keep track of which code may be called early, late or
both is how I ended up in this swamp to begin with.)

> Honestly, looking at this, I think we should fix the *users* of
> pgtable_l5_enabled().
>
> Because I think there are two distinct classes:
>
>  - the stuff in <asm/pgtable.h> is exposed as the generic page table
> accessor macros to "real" code, and should probably use a static key
> (ie things like pgd_clear() / pgd_none() and friends)
>
>  - but in code like __kernel_physical_mapping_init() feels to me like
> using the value in %cr4 actually makes sense
>
> but that looks like a much bigger and fundamental patch than Ard's.
>

I think we should just rely on cpu_feature_enabled(), which can in
fact be called early as long as the capability gets set. So instead of
setting __pgtable_l5_enabled, we should just call
'set_cpu_cap(&boot_cpu_data, X86_FEATURE_LA57)' so that even early
callers can use the ordinary pgtable_l5_enabled(), and we can drop the
early flavor. (The decompressor will need its own version but it can
just inspect CR4.LA57 directly)

