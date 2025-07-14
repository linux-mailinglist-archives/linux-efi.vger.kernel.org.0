Return-Path: <linux-efi+bounces-4312-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBF9B03739
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 08:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87632164030
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 06:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9D72264B9;
	Mon, 14 Jul 2025 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEJvLVQk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92131BE4A;
	Mon, 14 Jul 2025 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474861; cv=none; b=qc6tJmpXn/36LW+PYFf7P23J4jnVWUWSoI2+69nGXvADNqbCgHTVNk/TqUtBsKyx9zkNu2vrjAkEEK43piyLv8+6ieerHZ8FlqyIjfX9RckSqKtq6h1zoZOTil3ulCZQ1a2jsWjk2HkaxsH0qvUFNt23wk1R+PANue3O+fV4kGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474861; c=relaxed/simple;
	bh=ynfzJ9dsAps2aTd6f/tPXnxcet4bhZr25ybz3JfD7/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZN+RsKju3clmFmITox9EOV57K+rXtVajyeLf0Ux5YzmQWJ/zZMLfqmFQByoNN7CYmI0iy5Jx54hizodbS2/rClQn7o2aPWoT+uXrUPoLfXBn3CDb9VXXy9FQr7qQxo5y9++ymUkLiZQ1PciJWgHdk8vGtNKIdtZmMb04UHvD8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEJvLVQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44105C4CEF9;
	Mon, 14 Jul 2025 06:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752474861;
	bh=ynfzJ9dsAps2aTd6f/tPXnxcet4bhZr25ybz3JfD7/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kEJvLVQkjY7hRn/K87feYU0o9wfLcoFoQapbEzji/H3oVgosLIR+n/zpshU8j5xPx
	 cnTymersGd/N+1mHqJ3BKGWRQrcT85aRPAwcP/faI8e5poEh4ZkWHMwaVBKocHO+rc
	 dLlEMs5vxTbWhanxYLW+okfeFmBQsBMdx563LZdcvTyj2iv+aiVsVXtnqPaTwDI3J5
	 Ad4wSY0s6HRoT9uqxSgF5lXh8e2IN8+z1k96CRC4nfbcNwzS/6YDJxQqc+sBU8hMEi
	 vOLX3wP8hDRXfWv7ELSL3IU03zRlrE1pWJntsOZb60EXxyqcIuI5/EbVfSlwDO+8oX
	 OGL6/yKjUUb0A==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b49ac6431so30674891fa.1;
        Sun, 13 Jul 2025 23:34:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcPzKbbCyVeY/6m+9F2wcdWeAcBfbEeFO3Y29Z5vA+3+O8edoT5vUdEfAYa2Cjo/njnBWlSgZOj/w=@vger.kernel.org, AJvYcCXQFQEATWOLoPwoWF/3oGJZLHWRNutHERaDYaI4RUGJOyQk/lqnSfrDgCHxptRB0Icg4YOHeJ5c5zz5AdI4@vger.kernel.org, AJvYcCXyFgK3VKhyvGqKs5ugBb5h7TQVwIDEf3cwr8hWwUScwK9pK8uP7LjIcnWBWFGsRN0jRsgFv1EnU1VN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7FPBqzqh0OCl8JQGmCIIeHI1Xb8XcWQPGoh5tVjiM0F7FHL+l
	ClxC6M+uU+N23ft5vbsTpDc9yAYPPzJ64UECNl4f91obL6aH9vzRSFhyAX06hi3F3Kq0jHnFcGR
	pgZvrS4BlPf7BIiyEcOInBXcb7qjiSlw=
X-Google-Smtp-Source: AGHT+IEy4x7iRPRFME+dpdQyQI1jtmLIqNYRLMk1ojNaRg715rzBCM8Q86llYRAXa+twgNvvkR8qSO1icXiwfjuZzv0=
X-Received: by 2002:a2e:a7ca:0:b0:32b:80e1:300d with SMTP id
 38308e7fff4ca-33053186d88mr35999851fa.0.1752474859585; Sun, 13 Jul 2025
 23:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714060843.4029171-5-ardb+git@google.com> <20250714060843.4029171-6-ardb+git@google.com>
 <dade7d17-d45d-455e-a43c-01e9ea95c3b4@gmail.com> <CAMj1kXETDd+19i+awMx1v1sE4RXhF-r2a-mTa3rWfus5s4HMmw@mail.gmail.com>
 <f538a1b9-6a7c-474f-af2a-d87c35b82fc5@gmail.com>
In-Reply-To: <f538a1b9-6a7c-474f-af2a-d87c35b82fc5@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Jul 2025 16:34:08 +1000
X-Gmail-Original-Message-ID: <CAMj1kXGG0Mi+AT7ZeoHLTDhVbbahP-PLRgY1=aSZMVQEgWz5sQ@mail.gmail.com>
X-Gm-Features: Ac12FXzYFywZb16ZKDUVBGm4_KFbnsnrDO10Xk4vWwqGRcRLn5B3XWIM87WiCT4
Message-ID: <CAMj1kXGG0Mi+AT7ZeoHLTDhVbbahP-PLRgY1=aSZMVQEgWz5sQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] efi-rtc: Remove wakeup functionality
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Bibo Mao <maobibo@loongson.cn>, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, x86@kernel.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 16:22, Demi Marie Obenour <demiobenour@gmail.com> wrote:
>
> On 7/14/25 02:19, Ard Biesheuvel wrote:
> > On Mon, 14 Jul 2025 at 16:13, Demi Marie Obenour <demiobenour@gmail.com> wrote:
> >>
> >> On 7/14/25 02:08, Ard Biesheuvel wrote:
> >>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>
> >>> The EFI rtc driver is used by non-x86 architectures only, and exposes
> >>> the get/set wakeup time functionality provided by the underlying
> >>> platform. This is usually broken on most platforms, and not widely used
> >>> to begin with [if at all], so let's just remove it.
> >> systemd uses the underlying functionality: a timer can wake the system up.
> >> I have no idea if that is implemented in terms of this function, though.
> >
> > To be clear, you are referring to wake from poweroff at some date/time
> > in the future, right?
>
> Yes.
>
> > This change does not remove this functionality from the RTC subsystem,
> > it just ceases to expose it on non-x86 EFI platforms that claim to
> > support it.
>
> Do these platforms generally expose the functionality in a different way?

On x86, the CMOS rtc is manipulated directly (and this is officially
condoned by the EFI spec).

On non-x86, this functionality rarely works, which is really the point
of this series.

> If not, systemd should probably document that the functionality is
> non-portable if it doesn't do that already.

Not sure what you mean by non-portable. This functionality should be
exposed in a generic manner (using the RTC subsystem interfaces), but
only if it can be relied upon. On x86, the RTC subsystem will use the
rtc-cmos driver, which implements the wakeup routines in terms of port
I/O.

If removing this functionality altogether from the EFI rtc driver is a
problem, perhaps it would be better to implement an allowlist based
solution that does not attempt to access the runtime services by
default.

