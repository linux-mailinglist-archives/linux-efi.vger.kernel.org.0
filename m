Return-Path: <linux-efi+bounces-870-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C96887E2B
	for <lists+linux-efi@lfdr.de>; Sun, 24 Mar 2024 18:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1DD1C20986
	for <lists+linux-efi@lfdr.de>; Sun, 24 Mar 2024 17:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC410199D9;
	Sun, 24 Mar 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GngHH2Em"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7317555;
	Sun, 24 Mar 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711302217; cv=none; b=ODRqAXLa9YNZ3C9AKx8szvYNAsCBce13mC7ABwY5vljTN9ANMgBUEI+KbOP571lV5BL/yF0ifByKtUfBkPXSHjr4+h2KGkB4zndNlMzEKLlWB06l1JRJKnhdk4qQGoENvjpphLMlQbrqBPsFmTVP8a6ukhjdlsexw6pN76uhg8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711302217; c=relaxed/simple;
	bh=iV5eaQhCMjboTPn8RIB6+34ItDagxR0EDqsSNn6cFkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8zmVUb8Io1mU3shCDwKwP3+pRcbP89b3FhRcAsx4IEJREiYMHPtsViaMECtcdQfZ649+Hxu/kJ9AFTAwG3uPnQXh75bNAihJThyOkGnKJ8ANQuUiGBQ0xqRziKEbUHyHwpvXZHolYUqah8jR4KqH9xnfnuJdhJf3BXOFt19mOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GngHH2Em; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA13C433F1;
	Sun, 24 Mar 2024 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711302217;
	bh=iV5eaQhCMjboTPn8RIB6+34ItDagxR0EDqsSNn6cFkI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GngHH2Emt0UgAODe8rNAAbokRjd/3dZz7d9ws6sN5rYoXRd+5kjoAE5LR7fcihClr
	 6n/ddHPnr+a2z3iOenF528yUnqOsuLQvmmX/Vt92ZwYNbPVlbHRyjfxIexeMM/xEYL
	 h8bfdJM9eHnP29h77+iEgrVuKVB8S+Dges8W2LkKJmVAoGjQD/cJGQAfwuKVUQPz/q
	 Pu/aHQ55eLaw6zFrZlkca1N0URitlog0p/zxiVM7a3LbDJtgxrOfTr/3Q5JbZEoeta
	 plEAJdzjILd3eT1fOhfi0eV+glR0i3WGGwF6xzH8fEfzim5iiVLAJbK/0VGlSqfvAC
	 NEGYrLaIl5ZkA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d228a132acso51171391fa.0;
        Sun, 24 Mar 2024 10:43:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhYCYpxkOi3siIdsvQs7uBRoK+i0tmg2pi7VQgLQWrBR/w/K/hLAA5hrnn9SGsfnc1Y8ygGKmfg/RUFXmh0Kcbsftw3O2YqnDToqXDH+QCT0g3J2hT4+M+7pD004NzO1BTogjp1g++
X-Gm-Message-State: AOJu0Ywndv+2ZzkdqQdd0qszRPpBocd225J4mBy7PU2+YDEkQYJI1qxD
	UgIqciIsI59vWcxJ2Vpxc6hv09FKyPhX9tQNZLJ1YTFl37rdtyhwO8E1S2EU0XlsJsCRJAhP2Q4
	lKL5+9TOKk+8wsFMsKJYsZoex3hY=
X-Google-Smtp-Source: AGHT+IE7AWt7cuttWyQSkz/6C8k8f2wmWamg+V4k0ou5nWU+WNaV/FU3iygPmrusTd7cZR+rbmAd6ob/9A1zn1IdK/8=
X-Received: by 2002:a2e:8eda:0:b0:2d2:df0d:9e92 with SMTP id
 e26-20020a2e8eda000000b002d2df0d9e92mr3139059ljl.49.1711302215418; Sun, 24
 Mar 2024 10:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321150510.GI8211@craftyguy.net> <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
 <a3aae375-5582-46e4-866b-6a81641998af@redhat.com>
In-Reply-To: <a3aae375-5582-46e4-866b-6a81641998af@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 24 Mar 2024 19:43:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGrWGGv-aXabsn1oRwwMy-Ck1nz85QkEMqQ8LdQxyeBKQ@mail.gmail.com>
Message-ID: <CAMj1kXGrWGGv-aXabsn1oRwwMy-Ck1nz85QkEMqQ8LdQxyeBKQ@mail.gmail.com>
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
To: Hans de Goede <hdegoede@redhat.com>
Cc: Clayton Craft <clayton@craftyguy.net>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Mar 2024 at 16:49, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 3/21/24 11:48 PM, Ard Biesheuvel wrote:
> > (cc Hans)
> >
> > On Thu, 21 Mar 2024 at 23:05, Clayton Craft <clayton@craftyguy.net> wrote:
> >>
> >> I've been chasing a problem with 32-bit EFI mixed mode booting on two different
> >> (x86_64) Intel Bay Trail platforms, where the system reboots or hangs seemingly
> >> very early somewhere before or after loading the kernel. I've not been able to
> >> get any output from the kernel or stub over efifb when the issue happens[0], and
> >> do not have serial console access on these systems.
> >>
> >> v6.8 fails for me, and presumably so does everything back to v6.2. v6.1 is able
> >> to boot OK on these platforms with mixed mode, and it looks like there are a lot
> >> of changes from 6.1..6.2 for EFI/mixed mode booting.
> >
> > v6.1 just received some EFI related backports, so please check the
> > latest v6.1.y as well.
> >
> >> I did managed to bisect the
> >> issue to:
> >>
> >>         commit e2ab9eab324cdf240de89741e4a1aa79919f0196
> >>         Author: Ard Biesheuvel <ardb@kernel.org>
> >>         Date:   Tue Nov 22 17:10:02 2022 +0100
> >>
> >>             x86/boot/compressed: Move 32-bit entrypoint code into .text section
> >>
> >> However I'm not sure how to proceed from here, or if my bisect is all that
> >> useful since the commit seems to be in the middle of a bunch of changes I do not
> >> understand. I've been using systemd-boot to test this (both the full bootloader
> >> and UKI w/ the sd-boot stub). Is 32-bit mixed mode on x86_64 working for others?
> >>
> >
> > I usually test on 32-bit OVMF built with LOAD_X64_ON_IA32_ENABLE,
> > which allows the use of the compat entry point. This is different from
> > the EFI handover protocol, and I am not sure which one you are using.
> >
> > I have never had any reports, or noticed any issues myself. Last time
> > I tried (some weeks ago) it was working for me.
> > CC'ing Hans who may have more data points.
>
> I've been offline for most of the week and I see that in the mean time
> you seem to have found a fix, great.
>
> FWIW I have been booting everything up to 6.8.0 on my own mixed-mode
> Bay Trail tablets without issues, so the problem seems to be specific to
> certain BIOS-es.
>
> Please Cc me on the final fix, then I can test that early and double check
> that things don't regress on other mixed-mode Bay Trail devices.
>

Thanks.

I pushed another branch

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-clayton-3

which has a proper fix for the issue that you found.

As it turns out, the compat mixed mode (with handover protocol) was
broken from the beginning, and the change you identified just happened
to trigger it on your hardware.

