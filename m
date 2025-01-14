Return-Path: <linux-efi+bounces-2627-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F945A10B2B
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 16:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA6316A953
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7AB1FC112;
	Tue, 14 Jan 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkpW/t/r"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8961E1FC109
	for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869140; cv=none; b=nuUDd4OEzYjdGlohTbuBRKZxEjtll+EASLOjUdhQjNAJvsCaZgJ04uqPRmuYbVLklxsDlGFKSxRCIOjHaLNZc0S9USHMYi05DwvlofSKJSMPLDSEcyeh1XU0JHtLr752FrAZ1CWKsYFLMFrtlSmPfRXU/sekcLRBQGwWzDF3RSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869140; c=relaxed/simple;
	bh=WaRLGDxUsU1Cw0VlRHdgDUeYcIvEDnebAfUA6KCkI8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgMHgaGE4NF965wfsRdpwdPII0yOYjxR13OeeyDMnpAzx6OSKCAUiDhyjQ1sevh+46p4qNjyAts0SbeqB+4dpoDJxLA/b4YCrHsPIK5u8hzm8YduoZinSveerV2sa3DP59KJuKBLKVJ+9NkdyXYOAdWc/+cYRwefBnaxNH6TrX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkpW/t/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC839C4CEDD
	for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736869139;
	bh=WaRLGDxUsU1Cw0VlRHdgDUeYcIvEDnebAfUA6KCkI8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RkpW/t/r6CtfebXHaqLHfz16eT6sB0ObZ+93Ps6IeCuXuQo0QHqWreW1D37IQ+SLd
	 +/hAvH9UYXiFpMwcsYd6dsko8mR/fmHuTcwhBJLds35gBuGrdwVn+z5idgPcgeSGg4
	 Tbjln+TU1p2YrZS+vA8Az/UUEyNveg0Wi2e1iBO4T6VQMK0ol2+ulLXftn1PJwJGt1
	 dqhi3DG3MX94POzWwkccmjaT8n6C0MjHbJiXFgNy9JW3o53QunhWq0UoXb9FeDF/Ae
	 IfkSpyCzSr6RJvNp1ajKk31CKSakgNT0fjBpWyU8B5ThhjpOu3zrSJxzzk54svfsIA
	 K/JgkOxaZY+XQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-304d757a9c1so51739621fa.0
        for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 07:38:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWI3mWJSAfNtGYmT7vgY03c1Vu1sFLJJ0FKWE4wSqMfeb3VavKdgYXd1XazDSpWImSc177QIpYKsqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/jpDWNpkpQgBVSUaG3U7M3jxiL59D5lboRwu9XfpgTilownkC
	2g6UVk73yP3BcTTEburmnOUIgCC98V2AD3gj8ESCGmuKIvlwUIVx71L0Y5hcV6G3/Nzv0WkjDnJ
	/VEl95XUPHDAgLTMrnvr2vNTYY4U=
X-Google-Smtp-Source: AGHT+IFHhN1x591d88MpeYAYeeybMu0ontEtog+602uQqMJihIu1Frb6lnKiGvoubU/aCAGN+5G8bcgh6kwBGulgahI=
X-Received: by 2002:a2e:a542:0:b0:300:31dc:8a4a with SMTP id
 38308e7fff4ca-305fd20a693mr83831811fa.18.1736869138265; Tue, 14 Jan 2025
 07:38:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218150316.1583806-6-ardb+git@google.com> <20241218150316.1583806-7-ardb+git@google.com>
 <3d6f2bb7-3c23-4df7-a787-034bb30bff19@roeck-us.net> <CAMj1kXGz=dazpagUsxoDGHd4-n6QkoZta90h-c0DCBZPWuc_vg@mail.gmail.com>
 <CAMj1kXEgdUS3qxGe9_uQF5jNxwnFAR2giA0dTvE-kQ=u7Bmh=Q@mail.gmail.com>
 <e5e1f492-1050-4c4c-9e61-6ff4a68c58d2@roeck-us.net> <CAMj1kXGtspGNfV2ESk4bR8Tysr_GTRAbU1AQ6ZHtbkEGKYNv-g@mail.gmail.com>
In-Reply-To: <CAMj1kXGtspGNfV2ESk4bR8Tysr_GTRAbU1AQ6ZHtbkEGKYNv-g@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 14 Jan 2025 16:38:47 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGFWLKf3R3N-5uetBBARA0UqSoOsExSpMS6ZFXW+_yJuA@mail.gmail.com>
X-Gm-Features: AbW1kvb4URYKAoIpWgYq-6XeuTMZHvqARbHUHSy5Oc3VNeKUkGFIit4meT-7u28
Message-ID: <CAMj1kXGFWLKf3R3N-5uetBBARA0UqSoOsExSpMS6ZFXW+_yJuA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] efi/libstub: Avoid legacy decompressor zlib/zstd wrappers
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	Jeremy Linton <jeremy.linton@arm.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jan 2025 at 16:34, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 14 Jan 2025 at 16:08, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 1/14/25 03:40, Ard Biesheuvel wrote:
> > > On Tue, 14 Jan 2025 at 08:33, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>
> > >> On Tue, 14 Jan 2025 at 01:31, Guenter Roeck <linux@roeck-us.net> wrote:
> > >>>
> > >>> Hi,
> > >>>
> > >>> On Wed, Dec 18, 2024 at 04:03:17PM +0100, Ard Biesheuvel wrote:
> > >>>> From: Ard Biesheuvel <ardb@kernel.org>
> > >>>>
> > >>>> Remove the dependency on the decompression wrappers used by the legacy
> > >>>> decompressor, which do some odd things like providing a barebones
> > >>>> malloc() implementation. Instead, implement GZIP deflate and ZSTD
> > >>>> decompression in terms of the underlying libraries.
> > >>>>
> > >>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >>>
> > >>> With this patch in linux-next, my loongarch boot tests with qemu
> > >>> no longer boot. Log message is:
> > >>>
> > >>> qemu log:
> > >>> EFI stub: Decompressing Linux Kernel...
> > >>> EFI stub: EFI_RNG_PROTOCOL unavailable
> > >>> EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> > >>> EFI stub: Exiting boot services
> > >>>
> > >>> ... and then there is nothing until I abort the emulation.
> > >>>
> > >>> Reverting this patch results in a build failure, so I awas not able to
> > >>> test it. Bisect results are atatched for reference.
> > >>>
> > >>
> > >> Thanks for the report - I'll drop the patch for now, and try again next cycle.
> > >
> > > Mind sharing your config/firmware/command line details? I'm failing to
> > > reproduce the issue.
> >
> > qemu-system-loongarch64 -M virt -cpu \
> >       la464 -kernel arch/loongarch/boot/vmlinuz.efi -smp 2 \
> >       -no-reboot -m 4G -initrd rootfs.cpio \
> >       -bios QEMU_EFI-loongarch64.fd \
> >       --append "panic=-1 kunit.stats_enabled=2 kunit.filter=speed>slow rdinit=/sbin/init console=ttyS0,115200 earlycon=uart8250,mmio,0x1fe001e0,115200n8" \
> >       -nographic -serial stdio -monitor none
> >
> > qemu version is 9.1. The EFI image is at
> > https://github.com/groeck/linux-build-test/blob/master/rootfs/firmware/QEMU_EFI-loongarch64.fd
> > and the initrd is at
> > https://github.com/groeck/linux-build-test/blob/master/rootfs/loongarch/rootfs.cpio.gz
> >
> > Configuration is defconfig with various debug options enabled.
> >
> > I'll be happy to make a test directory available with all information needed
> > if that helps. Please let me know.
> >
>
> Everything works fine with my distro QEMU:
>
> $ qemu-system-loongarch64 --version
> QEMU emulator version 8.2.4 (Debian 1:8.2.4+ds-1+build1)
> Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
>
> and it doesn't matter if I use your firmware or my own (grabbed
> randomly from [0])
>
> When I build QEMU from source (stable-9.2), things still work happily
> if I use that same firmware. With your firmware, my QEMU 9.2 is
> completely dead.
>
> Where did you find that image? I tried rebuilding it myself from a
> recent EDK2 base, but that doesn't work at all either.
>
> [0] https://github.com/AOSC-Dev/LoongArchQemuVirtFirmware

... actually, turns out I built the wrong platform. If I build

OvmfPkg/LoongArchVirt/LoongArchVirtQemu.dsc

from the EDK2 repository, I can boot the kernel with my change
applied, using your command line.

Perhaps I should try your .config as well?

