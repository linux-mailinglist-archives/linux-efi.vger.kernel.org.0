Return-Path: <linux-efi+bounces-2626-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12E3A10AF7
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 16:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF2A168E11
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A991E86E;
	Tue, 14 Jan 2025 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buvILZIx"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE358488
	for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868894; cv=none; b=cJ3nyu4BwcNx2WM7G9tyD2pqvq83ulpWbQlmojEsr7LsvYMvuS4bcghmhrGDKOXKTU6wnaMU13sr6aNUmpESDbaAiURg2UpG7Vouw0Y0m9qm+CClIj2rdBfOHTw/wvVCPkWmWIjaT8ukPNiW52PqBHgymrWFgh3240WzdHPoXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868894; c=relaxed/simple;
	bh=ntDiIuEuIKK52fy4iqayWZXMBhrUDJ4MIKQpFKTqEiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKoOQslxCElLC/N/JSdWoWpEPnu37UTeUydl3EtzTfRrsay97VOcOQOtYL4WxHWQlzNlvvZwDIvcOKBF2N4qwTec+7z58V34CH6/yvI3PUKxNuUz217Pz3UQvU0+JCBkLIu5/Y+RA+Od4OlpofuMB0ZzPwa7viTCKaQ/5rY4b2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buvILZIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEAAC4CEDF
	for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 15:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736868893;
	bh=ntDiIuEuIKK52fy4iqayWZXMBhrUDJ4MIKQpFKTqEiY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=buvILZIxasa+dulx9vsSJ1o7OmxiTLl9Gm3laIzILvzM6K7DakCkINU1/AHckwioV
	 rxhy0GZuBcwN08aqdJMkvaqeAIH+EXQEVBKIjwIOOPMWThw8SA5WaPDWD9GJN71vPn
	 C9zcTATJYNvDz3xl6QapwMQu7lkqFvV9eLt7bRfV2thQ4v0fILuGxUYskCSu0ZTdbM
	 YPuv1cYAmjkIDlf3EBC9cNzLDha0mg7k1ltDWfNvC62lnntF0OOJ5TJYp1gopwZ6tW
	 i2oz1/k9wdj+Yab1WgRYiCln0+wtNH7EBxP5fMQ+9gjBMpUl9tUmmRwfPsgwHbn0R6
	 2UDf4fA6qXJaA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30167f4c1e3so49230551fa.3
        for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 07:34:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRSakXS8xIrYE72vLOtf4So2kVrArWdjQxX+0n7O/VpD/h4WjmRp/I+5fyn2210gMcO+uJhCufJwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXJhgbDr4CvcRksyQhRcJEXMEBW/4alNG6IAbWG3k3VcB60Z+
	cE5FxncMMnvD1MFQja2zRUsn8sXbMdSvkbn59f7B5VgnGOwN3BymQY5Dg1pTYkjoIQxKl1hdQZt
	SWDs0Jk97r1gQntajEiACXwS2SBY=
X-Google-Smtp-Source: AGHT+IGy1TGAZ6ODgzFf9H/8uL4/mnaeYHRw4grv1utLUX7+/CrHRuimTNbek1zfHdS8l3itpw7BsME+htK0XGMKw5M=
X-Received: by 2002:a05:651c:2118:b0:302:1e65:f2a1 with SMTP id
 38308e7fff4ca-305f4550c2bmr86760751fa.12.1736868892218; Tue, 14 Jan 2025
 07:34:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218150316.1583806-6-ardb+git@google.com> <20241218150316.1583806-7-ardb+git@google.com>
 <3d6f2bb7-3c23-4df7-a787-034bb30bff19@roeck-us.net> <CAMj1kXGz=dazpagUsxoDGHd4-n6QkoZta90h-c0DCBZPWuc_vg@mail.gmail.com>
 <CAMj1kXEgdUS3qxGe9_uQF5jNxwnFAR2giA0dTvE-kQ=u7Bmh=Q@mail.gmail.com> <e5e1f492-1050-4c4c-9e61-6ff4a68c58d2@roeck-us.net>
In-Reply-To: <e5e1f492-1050-4c4c-9e61-6ff4a68c58d2@roeck-us.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 14 Jan 2025 16:34:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGtspGNfV2ESk4bR8Tysr_GTRAbU1AQ6ZHtbkEGKYNv-g@mail.gmail.com>
X-Gm-Features: AbW1kvaX4Z4N1InnUDWHdOZjlhuzqDxDmukEYe6FoYKdZ_VyuMGQxhf3zw4H0-8
Message-ID: <CAMj1kXGtspGNfV2ESk4bR8Tysr_GTRAbU1AQ6ZHtbkEGKYNv-g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] efi/libstub: Avoid legacy decompressor zlib/zstd wrappers
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	Jeremy Linton <jeremy.linton@arm.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jan 2025 at 16:08, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 1/14/25 03:40, Ard Biesheuvel wrote:
> > On Tue, 14 Jan 2025 at 08:33, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> On Tue, 14 Jan 2025 at 01:31, Guenter Roeck <linux@roeck-us.net> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On Wed, Dec 18, 2024 at 04:03:17PM +0100, Ard Biesheuvel wrote:
> >>>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>>
> >>>> Remove the dependency on the decompression wrappers used by the legacy
> >>>> decompressor, which do some odd things like providing a barebones
> >>>> malloc() implementation. Instead, implement GZIP deflate and ZSTD
> >>>> decompression in terms of the underlying libraries.
> >>>>
> >>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>>
> >>> With this patch in linux-next, my loongarch boot tests with qemu
> >>> no longer boot. Log message is:
> >>>
> >>> qemu log:
> >>> EFI stub: Decompressing Linux Kernel...
> >>> EFI stub: EFI_RNG_PROTOCOL unavailable
> >>> EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> >>> EFI stub: Exiting boot services
> >>>
> >>> ... and then there is nothing until I abort the emulation.
> >>>
> >>> Reverting this patch results in a build failure, so I awas not able to
> >>> test it. Bisect results are atatched for reference.
> >>>
> >>
> >> Thanks for the report - I'll drop the patch for now, and try again next cycle.
> >
> > Mind sharing your config/firmware/command line details? I'm failing to
> > reproduce the issue.
>
> qemu-system-loongarch64 -M virt -cpu \
>       la464 -kernel arch/loongarch/boot/vmlinuz.efi -smp 2 \
>       -no-reboot -m 4G -initrd rootfs.cpio \
>       -bios QEMU_EFI-loongarch64.fd \
>       --append "panic=-1 kunit.stats_enabled=2 kunit.filter=speed>slow rdinit=/sbin/init console=ttyS0,115200 earlycon=uart8250,mmio,0x1fe001e0,115200n8" \
>       -nographic -serial stdio -monitor none
>
> qemu version is 9.1. The EFI image is at
> https://github.com/groeck/linux-build-test/blob/master/rootfs/firmware/QEMU_EFI-loongarch64.fd
> and the initrd is at
> https://github.com/groeck/linux-build-test/blob/master/rootfs/loongarch/rootfs.cpio.gz
>
> Configuration is defconfig with various debug options enabled.
>
> I'll be happy to make a test directory available with all information needed
> if that helps. Please let me know.
>

Everything works fine with my distro QEMU:

$ qemu-system-loongarch64 --version
QEMU emulator version 8.2.4 (Debian 1:8.2.4+ds-1+build1)
Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers

and it doesn't matter if I use your firmware or my own (grabbed
randomly from [0])

When I build QEMU from source (stable-9.2), things still work happily
if I use that same firmware. With your firmware, my QEMU 9.2 is
completely dead.

Where did you find that image? I tried rebuilding it myself from a
recent EDK2 base, but that doesn't work at all either.

[0] https://github.com/AOSC-Dev/LoongArchQemuVirtFirmware

