Return-Path: <linux-efi+bounces-2618-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A0A105A7
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 12:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8D13A1099
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EFD234D0D;
	Tue, 14 Jan 2025 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFeOlhoG"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E114234CFF
	for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854822; cv=none; b=l77G6yeK/7XWDoZnmZosc7+EdPa9fmG2AG5pL7M0AHkAoGcIum1c2I++LjVfhuRz0HDfFPqJeIQAT5BoajpZwtJeRRkD0g44p5343gyTrg9Dw1+NR0lv0Fl5Lew7CN5vlqlxWCwBORbszIq3h+y33cnHUMnQhBa4K0lyTbWxW9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854822; c=relaxed/simple;
	bh=jecOuKY6L/T3C3DFPro2DHhb3PO4yH2nr2VrWee1da4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFWFRNNH/lbLC5NJ3AeUCDgujd8POwDgc/HkikIINZqNOI+2IDzbOZ3GQwShgu+212Z0KnGA8H16rET/enATje33b4adNxXQ9V0j2gUZdWLtvo7dPJFlSD2qNVPAYZqOOFmUePpaj1no2IVDnmOXJTrpg7sJ1+PzOP/eFjLZNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFeOlhoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A25C4AF09
	for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736854821;
	bh=jecOuKY6L/T3C3DFPro2DHhb3PO4yH2nr2VrWee1da4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CFeOlhoGULdeJ/v7dWOjbkIfpTo8da+c6zP/TWC3r1R2hGes1pCs7KxyIPiO5H/+h
	 vGKsyE+UNxVw8pxB5SaxKvTcnKujAxzkiSY+7VG9+SzESNTprvbcpgznNXdL6WGmF8
	 cbb61FofoP0ea4wSRIQAP3R69V45ouvfmPC8f12ptj1Y3Pr6gl9G4QFy0nG9f3OCpB
	 eRip9oy8+/3+juxysd3hom+pRWn8IuSDVjMeq0Dct7EoIF9qWGX6lzrGH8S8Qo8K0/
	 79yYTumF3dIqm3+G7odTCcEYGOzhFT0OY3PGfvx7EzHW+iv+dDE6dzgJX2ZisZVvKH
	 n8rPKOoEK+oOw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3061513d353so26402061fa.2
        for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 03:40:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlvbUKG5O/NvyeBdp0/+JGh9NXnOWu81LJUH65mJoU990EyaUFARMDxn0cdHtPbg76/033gDGAbwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtF62Gou38i3kKubuGiIhTSYG1d+z8CZ0LSP4ye9h01B2yEs49
	zNn7Y3u+kP8R38tqdEZsXp3I+EbQYuiiWLVovO4IuUZkxd0ELI8wXy/MjNRTLRUKWJQns4y9sJF
	9DTFAL5mQbyVBttMMHOWJ1t80/hQ=
X-Google-Smtp-Source: AGHT+IHvzPLVAf1cgiXffy/uI5SlCQDO/GXsGNUHuu41OMCdwImLfUezd5E0p4PKrPVcIZNIi1wiILf95JDpNsSebt8=
X-Received: by 2002:a05:6512:1281:b0:540:3561:666f with SMTP id
 2adb3069b0e04-54284526e49mr8106136e87.20.1736854820256; Tue, 14 Jan 2025
 03:40:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218150316.1583806-6-ardb+git@google.com> <20241218150316.1583806-7-ardb+git@google.com>
 <3d6f2bb7-3c23-4df7-a787-034bb30bff19@roeck-us.net> <CAMj1kXGz=dazpagUsxoDGHd4-n6QkoZta90h-c0DCBZPWuc_vg@mail.gmail.com>
In-Reply-To: <CAMj1kXGz=dazpagUsxoDGHd4-n6QkoZta90h-c0DCBZPWuc_vg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 14 Jan 2025 12:40:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEgdUS3qxGe9_uQF5jNxwnFAR2giA0dTvE-kQ=u7Bmh=Q@mail.gmail.com>
X-Gm-Features: AbW1kvZm0CdbYhVMKGGHEWoFiHrDp5e0x8vHRMwbmjihoel14UNdB9lDiMrTnI8
Message-ID: <CAMj1kXEgdUS3qxGe9_uQF5jNxwnFAR2giA0dTvE-kQ=u7Bmh=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] efi/libstub: Avoid legacy decompressor zlib/zstd wrappers
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	Jeremy Linton <jeremy.linton@arm.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jan 2025 at 08:33, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 14 Jan 2025 at 01:31, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Hi,
> >
> > On Wed, Dec 18, 2024 at 04:03:17PM +0100, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Remove the dependency on the decompression wrappers used by the legacy
> > > decompressor, which do some odd things like providing a barebones
> > > malloc() implementation. Instead, implement GZIP deflate and ZSTD
> > > decompression in terms of the underlying libraries.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > With this patch in linux-next, my loongarch boot tests with qemu
> > no longer boot. Log message is:
> >
> > qemu log:
> > EFI stub: Decompressing Linux Kernel...
> > EFI stub: EFI_RNG_PROTOCOL unavailable
> > EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> > EFI stub: Exiting boot services
> >
> > ... and then there is nothing until I abort the emulation.
> >
> > Reverting this patch results in a build failure, so I awas not able to
> > test it. Bisect results are atatched for reference.
> >
>
> Thanks for the report - I'll drop the patch for now, and try again next cycle.

Mind sharing your config/firmware/command line details? I'm failing to
reproduce the issue.

