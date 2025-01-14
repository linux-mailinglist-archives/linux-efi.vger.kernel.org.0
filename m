Return-Path: <linux-efi+bounces-2617-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C131A10150
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 08:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1609F3A1364
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 07:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66376233548;
	Tue, 14 Jan 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPignYws"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56C23278D
	for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736840009; cv=none; b=j0IQHQOBYL5jQ8OtiSUoQZaYlTJgcyjqAo6TNIY+MAmzoq8jBlOgz6trBR3tuuhkEC9eNhbv8ixNiaVS8sExOXX8WADCS/dBncAPUbFkfdGLCRFF+QtDsw3kAl8mgUYCYjedy98sIyAJHS2t6FDIqrn1F5D8guXFr4NpsFHkdiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736840009; c=relaxed/simple;
	bh=fDvVqxLbeFvQyOOc2JevZ06mxdiENqyopYfyDCXubKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdm0NvSry7QjheqvhHGgB2LXOBcBy4Md+I5sAaIhawlKNWV7x5gHSWzhdmLOcSTLEV/t8kDQzxqoRMx3APaR5q9Gxl3l1iAf2dqh0PJza/QOCadsUgKHFTVaN1GrqRTE4kHhP17zagbj+f+VaqzU1S616TgjtNrNTkROBkat+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPignYws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912A4C4CEE6
	for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736840006;
	bh=fDvVqxLbeFvQyOOc2JevZ06mxdiENqyopYfyDCXubKI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JPignYwsnkffeQ7xE4gEUNqlWEt/5ksmH1U2tAqWPeZOecgDvDN8QXicXSM66L/dZ
	 i+EiKpPWJBjY84ZWjjg6+WK7ITy1jFlAE0/ZFLrdkykYvyo7tR6O5RuSPnKvMSk6J3
	 I6BPxOoIObadJQqTxc+UgoLZFdQPffJk36VJE+5/PfsRTjyb+oBKoPtXFO7N7g/ZqW
	 yWb93KmnEyMtMMl4z7fqGkZ23seS58sChdimEjSKmR/pP1yliUgEaLIbVx4dHOtbbI
	 XiUDkW8qMxFY2p5pPVyGRmLXpag3ObOVqdBHyTkJiG4L9vT1nlruPjZJ0DfSaFG8qG
	 A/8W/LRpMSnEw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-304d9a1f198so42822221fa.0
        for <linux-efi@vger.kernel.org>; Mon, 13 Jan 2025 23:33:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgCTAH/KMDHjER9rSRm/vqEhoMYJv9hYgM7wMHrPMGgRuXgGohBjAIIc8MDYdIZiFI6UFC3AWfAvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYl9Tb8e6dN6QiFxcng6C0IGOtpbUA05qEZdLBdJ8IteKSSso
	dimuHIo+PZk1cNN4eq5+Td3rvITtKpMNh6umKe4F2qMj9zvHsjf4mvkf1QgBq6DyZ3gsB9Rf9B0
	p5bROOpGUB5p64EZMmLpkKZXi7XU=
X-Google-Smtp-Source: AGHT+IFcpj6IuxpmgqG1ejtzXuclW5VJrXQrYmyEk1/l7oxDcHXucs5T329Pjuxv1ABZ++AhwUgQoB5lJVobG3utHi8=
X-Received: by 2002:a2e:be0d:0:b0:302:1b18:2bfe with SMTP id
 38308e7fff4ca-305f45f645cmr87526271fa.25.1736840004816; Mon, 13 Jan 2025
 23:33:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218150316.1583806-6-ardb+git@google.com> <20241218150316.1583806-7-ardb+git@google.com>
 <3d6f2bb7-3c23-4df7-a787-034bb30bff19@roeck-us.net>
In-Reply-To: <3d6f2bb7-3c23-4df7-a787-034bb30bff19@roeck-us.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 14 Jan 2025 08:33:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGz=dazpagUsxoDGHd4-n6QkoZta90h-c0DCBZPWuc_vg@mail.gmail.com>
X-Gm-Features: AbW1kvbJjeUUWmZg0qptaNWuqyrJ2XsyzLxiiIALCCQ0OTw-EQul8pC34aiXg9E
Message-ID: <CAMj1kXGz=dazpagUsxoDGHd4-n6QkoZta90h-c0DCBZPWuc_vg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] efi/libstub: Avoid legacy decompressor zlib/zstd wrappers
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	Jeremy Linton <jeremy.linton@arm.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jan 2025 at 01:31, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> On Wed, Dec 18, 2024 at 04:03:17PM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Remove the dependency on the decompression wrappers used by the legacy
> > decompressor, which do some odd things like providing a barebones
> > malloc() implementation. Instead, implement GZIP deflate and ZSTD
> > decompression in terms of the underlying libraries.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> With this patch in linux-next, my loongarch boot tests with qemu
> no longer boot. Log message is:
>
> qemu log:
> EFI stub: Decompressing Linux Kernel...
> EFI stub: EFI_RNG_PROTOCOL unavailable
> EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> EFI stub: Exiting boot services
>
> ... and then there is nothing until I abort the emulation.
>
> Reverting this patch results in a build failure, so I awas not able to
> test it. Bisect results are atatched for reference.
>

Thanks for the report - I'll drop the patch for now, and try again next cycle.

