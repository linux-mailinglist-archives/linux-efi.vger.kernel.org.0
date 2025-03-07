Return-Path: <linux-efi+bounces-2921-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C619A56A20
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 15:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C0E3B50A2
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBD621B8EC;
	Fri,  7 Mar 2025 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJb37XvP"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CB821ABDB;
	Fri,  7 Mar 2025 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356941; cv=none; b=Z+PJPyg8dIgb5DMNZTR26zcsBIzdUlnWQ20lrbDN/fU78RhpQqnWxriy5NfciDK3tHuMSgBjoc7tjHXVP+YXORH4NStvXxuM0yceAg7Vx4Om3iv0B8+CxfRrbu/Nu+N6Olq4VwWvobPEi5Lm4KHUlQG8O7VZd5qqIQhZRvw8mcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356941; c=relaxed/simple;
	bh=h61k6iv//Zq/ZiRsDE9u6tLjb5WeXniiaN02btlUD2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IknvDQqN6GG8Znd7b6hwScYTDZqo0xVgZtsK+30HC6RNrfBRc6V7fLPHYL3RojYjvk8FL69X10mT02BeXnfK78BBhUD3vMwijThDYxJd8z8kbTH2Ur48SkmjcbR0cNdNT6bHY/lYS4AnT4t4GAJ/unvN/SiiHNb0uQPYu8pvrzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJb37XvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881A3C4CED1;
	Fri,  7 Mar 2025 14:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741356940;
	bh=h61k6iv//Zq/ZiRsDE9u6tLjb5WeXniiaN02btlUD2U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AJb37XvPU3wdQoVVWHPVreIILAwibReo4M/jbFBbR45E2bebdUuCbB2DDamtnlebE
	 I53q5syHy1k8OHjPbjknGJ6Zt3EgL10DZH/zay6k0KfCytik+ainPyWdYfDX8Bu/lK
	 Qng4H9KJbi4hB+wN8ONHHZrv4rtonxbF7nFda2+OFRiehBmfO+q1hrXNdlojvPb76d
	 FQXsSnjdSoZYdkQx1/MjaUj+HCz6VzdHcP9R0yiNbOtUJKInQxfTbkGLdEsO5sOefN
	 swaBT6AzGGl4myNWln4fgQ5ngnUKAE5oTiz1htR5MmVvuYvXrO1dIx+h9KauO/r2nV
	 i6oekSjyY+imA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so2053456e87.3;
        Fri, 07 Mar 2025 06:15:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULiTwpaqUC1q3OP7O6BteZNgGPhqpVJxGSXrK4hTa8BoJRSGUpxv8+5VameMgCMV9GhyrqyQWUa4kF7bpl@vger.kernel.org, AJvYcCXh6ssMUcHgJ1SyCrbp3mSk0c7X1Yaq9VFlg8quXWfGVdEB48lEM1XahekyS/Ssy9NaPf58NrvTjWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8oD/RI4hXuUxWIavVrKxMmw+g3Vg6GamSN2qZ79g71bNSsKN7
	+giXcSZWdoMb3UgEQM0xnapaDaFDJ0s62ZY0nkMgnQlJvHFqQInlGzPNOvQz4YwK4gdqecb3sYk
	VnR7ZIXKgK0occy+2U+B7/0+2FhE=
X-Google-Smtp-Source: AGHT+IFOCmV4u3elWhaWSptdZbc8TD2xpzUa5YLcS6kt+CsHvdflAstlrsL3ORK9es0Vok4WkYXlvC9tg9iRlt5Z9d8=
X-Received: by 2002:a05:6512:3d0b:b0:546:2a27:ec35 with SMTP id
 2adb3069b0e04-54990eaaecfmr1416220e87.37.1741356938883; Fri, 07 Mar 2025
 06:15:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305101744.1706803-1-vkuznets@redhat.com> <CAMj1kXF-c46Bdw_cmLK-TckxukefqkpAYkOhg3jzfvW6YucDog@mail.gmail.com>
 <63vy4xc4mpm5tttdqz5vfzwyriqlminjdiffrbuamxcubmpuur@nxszi7xzxa6a>
In-Reply-To: <63vy4xc4mpm5tttdqz5vfzwyriqlminjdiffrbuamxcubmpuur@nxszi7xzxa6a>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 7 Mar 2025 15:15:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHQydeGHTa3Jd-ZByMntdqRp4f74ow6Uc0GLwjmejCSbw@mail.gmail.com>
X-Gm-Features: AQ5f1Jr86TiXszKmQrasOXuWsCUEnbIZThXAX6w_l2bc7xQGjQHKKDN-H-fN1BE
Message-ID: <CAMj1kXHQydeGHTa3Jd-ZByMntdqRp4f74ow6Uc0GLwjmejCSbw@mail.gmail.com>
Subject: Re: [PATCH RFC] x86/efi: Add a mechanism for embedding SBAT section
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org, linux-efi@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
	Emanuele Giuseppe Esposito <eesposit@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Luca Boccassi <bluca@debian.org>, Peter Zijlstra <peterz@infradead.org>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 14:29, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > This patch suggests a different approach: instead of defining SBAT
> > > information, provide a mechanism for downstream kernel builders (distros)
> > > to include their own SBAT data.
> >
> > Why does this require a mechanism in the upstream kernel at all?
>
> To avoid every distro re-inventing the wheel?
>

Fair enough.

> > > - CRC32 must be at the end of the file.
> >
> > We never cared about the CRC32 before with signed EFI images, which
> > gets clobbered when the image is signed. Why should we start caring
> > about it now?
>
> I have some blurry memories on having seen this crc32 discussion
> before ...
>
> The crc32 is not clobbered.  The signature is simply appended and
> wouldn't overwrite the crc32.  But if software expects to find that
> crc32 in the last four bytes of the file then yes, that assumption does
> not hold any more for signed kernel binaries.
>

The crc32 is a CRC over the entire bzImage. Whether or not it lives at
the end is irrelevant, as signing the bzImage will necessarily [*]
break the CRC, and subsequently regenerating the CRC will invalidate
the signature. (The CRC lives at the end because that is the easiest
way to generate an image whose checksum including the CRC itself is
~0. However, there are also other ways to achieve this)

> Who uses that crc32 and how?  If it is useless anyway, can we just drop
> it upstream?
>

I tried but hpa objected to that. [0]

> > Please don't create a special case for x86 again - iff this needs to
> > be in upstream (which I am not convinced about) it needs to be
> > implemented for all architectures.
>
> Well, x86 *is* the special case.  Everybody else just uses zboot.
>
> But, yes, when this RfC patch discussion comes to the conclusion that
> this is useful to have upstream the plan is to do this for zboot too
> so all architectures are covered.
>

Good.

> > So I'd like to understand better what is preventing you from appending
> > a PE/COFF section on an arbitrary bzImage (or EFI zboot image).
>
> Well, assuming it is safe to ignore the crc32 as per above discussion
> then nothing really.  It should be possible to do this as part of the
> signing process instead.  That leaves the "not re-inventing the wheel"
> aspect of this on the table.
>

[*] While it is feasible to generate an image that checksums to ~0 and
is signed for UEFI secure boot (details in [0]), I seriously doubt
that we should bother. Not even hpa's own bootloader 'syslinux' cares
about the CRC-32, and given that all signed distro kernels that have
been in circulation since they started signing them have corrupted
CRCs, there is really no need to start caring about that now.

If there is a need to maintain this upstream, we can host the tools
but I don't see a reason to integrate this with the bzImage build as
this patch proposes.





[0] https://lore.kernel.org/all/20230818134422.380032-1-ardb@kernel.org/T/#m3d3c7b62045072090c49706295a1fc9aa6a5e349

