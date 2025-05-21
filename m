Return-Path: <linux-efi+bounces-3759-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A247ABF644
	for <lists+linux-efi@lfdr.de>; Wed, 21 May 2025 15:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C026189FBE8
	for <lists+linux-efi@lfdr.de>; Wed, 21 May 2025 13:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C427B4E4;
	Wed, 21 May 2025 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVVgx5wr"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D42798F1;
	Wed, 21 May 2025 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834665; cv=none; b=En+ORTHS2f8l/hw0T3MGMwEmjSon6TScVKI8Vp3ol+xY0HViz4avERU/JJmmB0vMRmczIZb/OYHRahdj+xohHl/8g45P9srEcl2s5H7ps/8z1JnzrIn9Cwys21BoMjShB7Yqyh7hS1A7nTdTvLKIeYNKa9/qWTGcLq10r20jalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834665; c=relaxed/simple;
	bh=Q3vxupo3Dpy/q0eLFgkdBNBH9G50vEGn7yWruuYgOC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlxWeZLQtn5g4APi4XMyJ2rPSGMYBo7HRHmj16dfjIgn591fr6pEYJjA8tAbKlX/GMyDTt+ni3ca+wq9bvVHbn6Ty75V19UcHRVLME+T9N7DjL7MQFU3paVN/uTStST362vAdQfqwYmLzIGqLF94IljkwWXsRvZ+0Mp7R8PMpUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVVgx5wr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B61C4CEE7;
	Wed, 21 May 2025 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747834664;
	bh=Q3vxupo3Dpy/q0eLFgkdBNBH9G50vEGn7yWruuYgOC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SVVgx5wrku55voQSdFauIP8usiUXUr5MELLxr0pcNBqBflh9V01F7vVT0jOMwgx6u
	 Y8L8CXrJDKrT28wbvbhRisK28d5iTKU/MT/vDNQzVqqluzjNrJd9aGndHI0Jcaocug
	 4FidPWcv2jsms/G4tatxEovQy6vdmz8wRiWXYdfdkp+dDUndF3v7wZSsszxyVjgsIu
	 4uRwLQVm0q0IAbifEdbp2cFm5pVFj2OkiGm5u/0bS3bhX4DvVZm+kQs3+bwTv5QBiX
	 GIQZNXp205YCjLh427WaaJQCfS2zu2pSk9+39CUfmW6Evb6QRjY0s7iSOLLzMeQ1l5
	 qrEdhsAGsKpcw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54b10594812so8008321e87.1;
        Wed, 21 May 2025 06:37:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5expP0WGCUAk1eXS/jjvixggWIgO4cPCj4xzm5uGfTayHWCf3h3jmDkp79MJ0LYODPU7fCjgaqWI=@vger.kernel.org, AJvYcCXlfPPY4Q39Smeo/3VZDg110prUFa0LMGkXcKjk3y/OIWYSe0AR0TQ1lWM3Ye8i8aPLD7rgkdxo2D7M5lVQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzUpSgOvRj2RceX/Zyw3YGp1kZ3ucUgvkgjKMe8E+RWr29rPjQ1
	Jz3B9rhTtOq6jfW/KyftPrCAcwZyQTge1JhYalAOJD1OAj35GnIQFtt+qE+JxRfqpAzFtzaPnKq
	cOO94zfPXisFc8z7l3pYkl8ekx/Qqank=
X-Google-Smtp-Source: AGHT+IFko07FZvPd74P0BaT3/07hpt0YPXFdNbTcXRR7nkC4AEknVdNNihDaVx9qsxC6R3pVF5cdVeKlVFZ1xKYjWM0=
X-Received: by 2002:ac2:4c4a:0:b0:545:243e:e2dc with SMTP id
 2adb3069b0e04-550e7232305mr6204447e87.39.1747834662956; Wed, 21 May 2025
 06:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513125808.75510-1-vkuznets@redhat.com>
In-Reply-To: <20250513125808.75510-1-vkuznets@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 21 May 2025 15:37:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGBgkjEseNTaFewCwM=0h_zOVfnqshOouHPTTkmeiZN1w@mail.gmail.com>
X-Gm-Features: AX0GCFuY7joIXpf1EEnLZX1Mth4aBM4HKeH5hTeI3S0S81xmI8PHJi0gLhbIlL0
Message-ID: <CAMj1kXGBgkjEseNTaFewCwM=0h_zOVfnqshOouHPTTkmeiZN1w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] efi: Add a mechanism for embedding SBAT section
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
	Emanuele Giuseppe Esposito <eesposit@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Luca Boccassi <bluca@debian.org>, 
	Peter Zijlstra <peterz@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 14:58, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Changes since v2 (Ard):
> (https://lore.kernel.org/linux-efi/20250505154523.231233-1-vkuznets@redhat.com/)
> - Use 'textsize' intermediary in arch/x86/boot/header.S to avoid additional
>  '#ifdef CONFIG_EFI_SBAT'.
> - Fix indentation.
> - Added R-b tags.
>
> Original description:
>
> SBAT is a mechanism which improves SecureBoot revocations of UEFI binaries
> by introducing a generation-based technique. Compromised or vulnerable UEFI
> binaries can be prevented from booting by bumping the minimal required
> generation for the specific component in the bootloader. More information
> on the SBAT can be obtained here:
>
> https://github.com/rhboot/shim/blob/main/SBAT.md
>
> Currently, shim checks .sbat data for itself in self-test and for second
> stage bootloaders (grub, sd-boot, UKIs with sd-stub, ...) but kernel
> revocations require cycling signing keys or adding kernel hashes to shim's
> internal dbx. Adding .sbat to kernel and enforcing it on kernel loading
> will allow to do the same tracking and revocation distros are already
> doing with a simplified mechanism, and without having to keep lists of
> kernels outside of the git repos.
>
> Previously, an attempt was made to add ".sbat" section to the linux kernel:
>
> https://lwn.net/Articles/938422/
>
> The approach was rejected mainly because currently there's no policy on how
> to update SBAT generation number when a new vulnerability is discovered. In
> particular, it is unclear what to do with stable kernels which may or may
> not backport certain patches making it impossible to describe the current
> state with a simple number.
>
> This series suggests a different approach: instead of defining SBAT
> information, provide a mechanism for downstream kernel builders (distros)
> to include their own SBAT data. This leaves the decision on the policy to
> the distro vendors. Basically, each distro implementing SecureBoot today,
> will have an option to inject their own SBAT data during kernel build and
> before it gets signed by their SecureBoot CA. Different distro do not need
> to agree on the common SBAT component names or generation numbers as each
> distro ships its own 'shim' with their own 'vendor_cert'/'vendor_db'. Linux
> upstream will never, ever need to care about the data unless they choose in
> the future to participate in that way.
>
> Vitaly Kuznetsov (2):
>   efi: zboot specific mechanism for embedding SBAT section

I've picked up the first patch for the next cycle. The second one can
then go via the -tip tree for v6.17

Or if team-tip is happy to pick it up now, I've created a separate
efi-sbat branch with only the first patch, so it can be merged into
-tip and the second patch applied on top.

git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-sbat


>   x86/efi: Implement support for embedding SBAT data for x86
>
>  arch/x86/boot/Makefile                      |  2 +-
>  arch/x86/boot/compressed/Makefile           |  5 ++++
>  arch/x86/boot/compressed/sbat.S             |  7 +++++
>  arch/x86/boot/compressed/vmlinux.lds.S      |  8 ++++++
>  arch/x86/boot/header.S                      | 31 +++++++++++++++------
>  drivers/firmware/efi/Kconfig                | 24 ++++++++++++++++
>  drivers/firmware/efi/libstub/Makefile.zboot |  4 +++
>  drivers/firmware/efi/libstub/zboot-header.S | 22 +++++++++++++--
>  drivers/firmware/efi/libstub/zboot.lds      | 11 ++++++++
>  9 files changed, 102 insertions(+), 12 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/sbat.S
>
> --
> 2.49.0
>

