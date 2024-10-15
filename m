Return-Path: <linux-efi+bounces-1974-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CEA99F527
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 20:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59821C229C1
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 18:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6145D2216AF;
	Tue, 15 Oct 2024 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOD/JAw2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39319212640;
	Tue, 15 Oct 2024 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016652; cv=none; b=S1cIuvmVLC6IheBRrg6DmNQ+sdOImAqMMlFBLmkCg7tOK8i5XrNnDjDqECCpidr/aNaxUbRSteN6cuPBmBv3L36674hTWN1s4NVaE9R9k0gE3pqOgm2TkQgJUIcWNt0/rCq+25yqC8kdTTEXgLTSS3bvxsBf9EbJKgFWqxHcIXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016652; c=relaxed/simple;
	bh=upWiI//rYiJLMKe4yJasEb1zsuVr65vUUAay7scsqIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahwWb9X34R/xdX411XqESahlustFXtPv/xHKNj/DJF6NB+1642ujwEJQV1SbLFbLPEGIs38Bm/mX4KqzCazFSYyPrQfQmLXorDImLGCyESHhbBNDb/rMWW5Y8gZbtapfnCBG/EFozR3lkTTxYL9AFaU7/16AbzfZO4kPPYVc4kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOD/JAw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A13C4AF09;
	Tue, 15 Oct 2024 18:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729016651;
	bh=upWiI//rYiJLMKe4yJasEb1zsuVr65vUUAay7scsqIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gOD/JAw2huOzSx4oo6mE2aERtlExe+t8XzFk2ho0psqIPh1eENDUjwTTRyGIgxoed
	 HCuAgzTdhffQqxj9YPG4aeHxOOs4HnOGxTWt4uZwZ2I9PHzpY3wu89n5yY8a2BBCni
	 5yhn/XwjxeV61UhQ5v1ZIzZVilmgK6KUpQUdlo7wUXx9G9ReMXFrAHukv9Hg3S665d
	 qwliX/lGIwUwZUWw/gb/rXu/1UgA9XNlnQ3b9SVYblgitqSJc+OBZIuK2uH6CT/D8J
	 oDJ4W35GckOEy2WFWTjpiVcW+/Q6Tz6y9Sw14oILXhEHhvCSotpd5yK0bM2UmUA3Rh
	 DCnnE2wh3q8uw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f84907caso2914509e87.3;
        Tue, 15 Oct 2024 11:24:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6HKL/Qxqzjnxn8Qb8Xxndx3seUNr6IkTy6nXffJ3gXghhtS4dNzpp68MOY7UPtmYWvcZFJ3H/9DQ=@vger.kernel.org, AJvYcCWUCBMn7+pQASEpnDE7TPJOLd6vrnJCoX9qsj6DESp+wbWlFBdxg7CT34UnnAQVQKJGYCc3kwUrJePZB/cG@vger.kernel.org
X-Gm-Message-State: AOJu0YydRwa9CIIyiFT8ZMsxGkfSXn25KCWmhOfKeWeamvA2oZ5o3HsZ
	J8ncl45ktIGGISyC1nU+bg3J4FZCgiSSkb5QijK/RpAcUQ7hOmnst/QnP3pBZFUPkOPf+nUxpEd
	3eK4HBSrLuk7KwEBsLNlO6qs8veo=
X-Google-Smtp-Source: AGHT+IEqxVDXB+67x2LNye5De4wern0VGF7eTCBuNTaTpqVe3ApOmkkxRNI+6XI3r/iORIhQq67NA6NmjkUJKvg1GQM=
X-Received: by 2002:a05:6512:3d24:b0:539:f4d8:ee43 with SMTP id
 2adb3069b0e04-53a03f29dacmr951250e87.22.1729016649970; Tue, 15 Oct 2024
 11:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001032028.483199-1-jeremy.linton@arm.com>
 <CAMj1kXEwsB2JZeE451Qf=tad7mapWATu_-ty+r7fcMTcxQ=StQ@mail.gmail.com>
 <CAC_iWjJH8JwdPbL9Et6xNLf4vV1AQDm8ZZh8zYVkb+VFLXedTg@mail.gmail.com>
 <0bed3801-47c0-439a-8b46-53c2704e9bb0@arm.com> <CAC_iWjLo3j73J1x1Bw01szxN4uHUU+tPstWkYk3=+7t7DziHpw@mail.gmail.com>
 <c0121455-6c46-468e-a386-6be2180dd7a3@arm.com> <CAC_iWjKB479Wbg01bgbo46rM_OyNzDmxqH9OkusNr8+8GafcPQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKB479Wbg01bgbo46rM_OyNzDmxqH9OkusNr8+8GafcPQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 15 Oct 2024 20:23:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFYqon3u74_cV9v-UtQs2UQR6bVkdieW0b7QsX42AMfVg@mail.gmail.com>
Message-ID: <CAMj1kXFYqon3u74_cV9v-UtQs2UQR6bVkdieW0b7QsX42AMfVg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: measure initrd to PCR9 independent of source
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>, linux-efi@vger.kernel.org, bp@alien8.de, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 20:25, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Jeremy,
>
> [...]
>
> > >>>
> > >>> Back when we added this we intentionally left loading an initramfs
> > >>> loaded via the command line out.
> > >>> We wanted people to start using the LoadFile2 protocol instead of the
> > >>> command line option, which suffered from various issues  -- e.g could
> > >>> only be loaded if it resided in the same filesystem as the kernel and
> > >>> the bootloader had to reason about the kernel memory layout.
> > >>> I don't think measuring the command line option as well is going to
> > >>> cause any problems, but isn't it a step backward?
> > >>
> > >> Thanks for looking at this. Since no one else seems to have commented, I
> > >> will just express IMHO, that both methods are useful in differing
> > >> circumstances.
> > >>
> > >> For a heavyweight Linux aware bootloader like grub/sd-boot the
> > >> INITRD_MEDIA_GUID is obviously preferred. But, for booting strictly out
> > >> out of a pure UEFI environment or Linux unaware bootloader (ex: UEFI
> > >> shell),
> > >
> > > I am not sure I am following on the EfiShell. It has to run from an
> > > EFI firmware somehow. The two open-source options I am aware of are
> > > U-Boot and EDK2.
> > > U-Boot has full support for the LoadFile2 protocol (and the
> > > INITRD_MEDIA_GUID). In fact, you can add the initramfs/dtb/kernel
> > > triplets as your boot options, supported by the EfiBoot manager and
> > > you don't need grub/systemd boot etc.
> > >
> > > I don't think you can do that from EDK2 -- encode the initrd in a boot
> > > option, but you can configure the initramfs to be loaded via LoadFile2
> > > in OMVF via the 'initrd' shell command.
> >
> > Oh, I guess the shell is a bad example because I was unaware that there
> > was a initrd option in it now. I'm buying into the boot loader/boot
> > manager distinction, where the manager is largely unaware of the target
> > OS's specific needs (in this case, having the initrd GUID set).
>
> Yes, FWIW what was added in U-Boot needs to be aware of the
> Linux-specific GUID, but as far as the EFI BootOptions defined in the
> Boot manager, we aren't violating anything in the EFI spec. On the
> contrary, we use the _EFI_LOAD_OPTION exactly as the spec describes.
>
> >
> >
> > >
> > >> the commandline based initrd loader is a useful function.
> > >> Because, the kernel stub should continue to serve as a complete, if
> > >> minimal implementation for booting Linux out of a pure UEFI environment
> > >> without additional support infrastructure (shim/grub/etc). So, it seems
> > >> that unless there is a reason for divergent behavior it shouldn't exist.
> > >> And at the moment, the two primary linux bootloaders grub2 and sdboot
> > >> are both using the INITRD_MEDIA_GUID. Given the battering ram has been
> > >> successful, it isn't a step backward.
> > >
> > > I am not saying we shouldn't. As I said I don't think this patch
> > > breaks anything. I am just wondering if enhancing EDK2 to load the
> > > initramfs via LoadFile2 for more than OVMF is a better option.
> >
> > There is a separation of concerns argument here. People regularly
> > complain about firmware implementations tuned for windows, but making
> > the FW aware of this GUID is doing the same thing for Linux.
> > So, IMHO
> > that should be avoided, rather assuring the firmware is made as OS
> > agnostic as possible, and the OS specifics are moved into the OS boot
> > loader, one of which is this stub. It would make more logical sense to
> > have the stub set the GUID from built in command line defaults. To be
> > clear, i'm not suggesting that.
>
> I get the separation point but ....
> If you do it the other way around you *force* people to use specific
> OS loaders that implement OS-specific protocols. And the EFI stub is
> not the problem here nor are distros that use such loaders. However,
> vertical distros for embedded boards which don't need all the added
> complexity have a reasonable way out.
>
> Anyway, since Ard doesn't plan to deprecate initrd=, the patch is
> reasonable, I have no objections
>

I've queued this up now - thanks all.

