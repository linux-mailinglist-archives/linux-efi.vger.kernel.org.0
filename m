Return-Path: <linux-efi+bounces-5801-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45800CA5273
	for <lists+linux-efi@lfdr.de>; Thu, 04 Dec 2025 20:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A816300DA71
	for <lists+linux-efi@lfdr.de>; Thu,  4 Dec 2025 19:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85CF1D5178;
	Thu,  4 Dec 2025 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZjGQGds"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38971A9F85
	for <linux-efi@vger.kernel.org>; Thu,  4 Dec 2025 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764877217; cv=none; b=uyXcQg+TPwc11evD82HTVzGNw2Xr9ToZ6tkA74VzeRG8AGsdkEf+rx8Nz6YaFsDcRzU6R6RpJLjAjcFDA1b8jSYO6sVfwceSm6B6FtnZHrmyGZZ6ApfSdBFxAa6lACq3nY3KQ4gRcyeDAXwTyd4dvbzUZwUOiXtBHWVhuMpMHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764877217; c=relaxed/simple;
	bh=d2UWplutQ5HUK78bS3g92FWdA+kn+Fro9AvDDwsPbcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGdfplPEwE0Lu+6P/lHikwGeVO82Mc5wJKGMuAAfcZ+paAroAvfCFe2P1/mjMBq6ytBQcWDOmSmwUZf0q87c/0YRYxBk+cskFXN0PKdc26ND2yxRp7lgr7NZVi8I3xvIswSLpgPoOGFgcLQE/5byAuNWiu920cNElOgLKB8XSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZjGQGds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A9FC2BCB0
	for <linux-efi@vger.kernel.org>; Thu,  4 Dec 2025 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764877217;
	bh=d2UWplutQ5HUK78bS3g92FWdA+kn+Fro9AvDDwsPbcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AZjGQGdsNwSMrjv70L2gYQmunIM6UN7y9BQkHXKAAcwcHtk5hKlkjIcUsN0sXOgu4
	 vIglzC//Xdwx+Kbdqd0u1iMyBTAS+7PT3AlYEomZaS/yLOTNBMZsB1R7Sa7hk+Pghd
	 u823xFQDl5sXPfmiS5CyN4TaW2OYrzGg6luv2LxLdyPQi5jDqEs9r1WJBK0WGpZ8AO
	 EKONUdq7Q+NJ8BCOmVKEy3Quf7vqYQ97LQyp3gmes+BEFLrCf9hQsUyCh0nx3dvzpF
	 BRPtNmClP3+V7qf6W0JJGQKsd1bfNu4VmDVNAbLiOdc+VSA4amfKobxvrOxLv3SKSZ
	 /WiXxFR1RrNWw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5943b62c47dso1303998e87.1
        for <linux-efi@vger.kernel.org>; Thu, 04 Dec 2025 11:40:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdFoDdR7+vWvS9SF6nO42Qa7r2NoGU85LKbht2p6aTyq39NMDnpprOjIVqSfyw7oKZ5eeutC+ff1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzUksLlE3X4AeU2jMDkySKWlrIyvgXKGoj5royD/3cXlw62W9
	+luplFNhzIqxSo7RNBV/kKmi9XgyEoWh758Y/5d2E4ymXvVxJ3gAup5FVEQImrS72GkjvX4a5LQ
	RS6LBdT8hUUyDSsveBhL45XArbM5mXx0=
X-Google-Smtp-Source: AGHT+IGRqS5yhl/687xlbnKbW6TnT/U2j5G/ZYNpxPFOBnWKZUNqIvE86wMdc5tYoh82ZYOL0Z6MppS/J0AdjW43/mE=
X-Received: by 2002:a05:6512:b1a:b0:593:1383:7945 with SMTP id
 2adb3069b0e04-597d3f355dbmr2996487e87.20.1764877215392; Thu, 04 Dec 2025
 11:40:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204072143.3636863-1-sohil.mehta@intel.com>
 <CAMj1kXFicnmVUeoRsMNbBgDN20fCN+R01H9shcgOJMD2Nzn8Cg@mail.gmail.com>
 <5fb937b4-5459-4894-a107-945bfb50a701@intel.com> <CAMj1kXECOBQczcNeqmhfgttz_0545B3m7OgLAk4WE_hOkUbohg@mail.gmail.com>
 <B0E164E9-9037-4DD3-BFF6-E628B23349FF@zytor.com>
In-Reply-To: <B0E164E9-9037-4DD3-BFF6-E628B23349FF@zytor.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Dec 2025 20:40:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHYKX4nU_xULC9vBDQxdyq9n_gcDqUTL2QZXvZhkHZRAg@mail.gmail.com>
X-Gm-Features: AWmQ_blrcAV4gIxRHSRNQizO63xM4zNQEVVpsjhlY1y1chpcnmT5IMiDXKCcZfo
Message-ID: <CAMj1kXHYKX4nU_xULC9vBDQxdyq9n_gcDqUTL2QZXvZhkHZRAg@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86: Extend LASS support to EFI configurations
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Tony Luck <tony.luck@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Dec 2025 at 20:16, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On December 4, 2025 11:03:52 AM PST, Ard Biesheuvel <ardb@kernel.org> wro=
te:
> >On Thu, 4 Dec 2025 at 18:34, Sohil Mehta <sohil.mehta@intel.com> wrote:
> >>
> >> On 12/4/2025 4:47 AM, Ard Biesheuvel wrote:
> >> > Hello Sohil,
> >> >
> >>
> >> Hello Ard - Thank you for looking at the patches.
> >>
> >>
> >> >>
> >> >>   2) Boot services code and data are referenced long after
> >> >>   ExitBootServices(). For example, efi_check_for_embedded_firmwares=
()
> >> >>   accesses boot services memory even after SetVirtualAddressMap().
> >> >>
> >> >
> >> > These accesses use the kernel direct map, so I don't think they come
> >> > into play here.
> >> >
> >>
> >> I don't mean SVAM should have switched these addresses to virtual ones
> >> but doesn't all of EFI_BOOT_SERVICES_{CODE|DATA} have address[63] =3D =
0?
> >>
> >
> >Whether a mapping has bit 63 set or cleared depends on the location of
> >the mapping in the virtual address space, not on the location of the
> >physical backing of that mapping.
> >
> >efi_check_for_embedded_firmwares() maps EFI_BOOT_SERVICES_DATA regions
> >in the kernel region, so bit 63 will be set.
> >
> >> LASS wouldn't care whether there is an actual mapping behind the
> >> address. It only relies on the MSB for enforcement. So, any code that
> >> relied on accessing boot services memory before efi_free_boot_services=
()
> >> could get affected by LASS.
> >>
> >
> >This only applies to code that accesses boot services memory via a
> >mapping in the lower range.
> >
> >> >>   3) Some runtime services fail to switch to virtual mode properly =
and
> >> >>   continue referencing physical addresses [3]. The kernel maintains=
 a
> >> >>   1:1 mapping of all runtime services code and data regions to avoi=
d
> >> >>   breaking such firmware.
> >> >>
> >> >
> >> > In [3], I mainly elaborated on why it is still necessary to call
> >> > SetVirtualAddressMap(), and why it needs to be called with a mapping
> >> > in the upper address range.
> >> >
> >> > For this particular call, there is no choice but to disarm LASS, giv=
en
> >> > that the lower mapping is still active at this point.
> >> >
> >> > However, that does not imply that we have to assume that systems tha=
t
> >> > support LASS (which are fairly recent AIUI) are buggy in the same wa=
y,
> >> > i.e., that they access addresses in the 1:1 region after
> >> > SetVirtualAddressMap() completes.
> >>
> >> I assumed that it must be widespread because the kernel maintains the
> >> 1:1 mapping unconditionally without any Family-model checks. The code
> >> isn't explicitly warning about such implementations, either.
> >>
> >
> >Exactly, and this is an oversight that occured 10+ years ago. No
> >reason to keep carrying that forward forever.
> >
> >> >
> >> > In fact, we might attempt to use the availability of LASS as a
> >> > preliminary cutoff point for disabling this hack entirely, and only
> >> > backpedal if we get actual reports where this is still a problem.
> >>
> >> Sure, I am onboard with this approach, but some folks seemed skeptical
> >> about it during the base LASS series review. My only concern is breaki=
ng
> >> user systems when they update to a LASS-enabled kernel.
> >>
> >> x86 maintainers, any preference?
> >>
> >> Would it be useful to put this (patch 2) behind an "efi=3Ddisable_lass=
"
> >> command line option? That way, if someone runs into it, there is at
> >> least a fallback option they can rely on. By default, we would still
> >> expect newer firmware to not need this hack.
> >>
> >
> >efi=3Dnoruntime is already available, which may be sufficient to work
> >around this in individual cases, to regain access to a non-booting
> >system.
>
> You are missing something *really* important:
>
> What do you expect to gain?
>
> There is basically no downside to the current workaround, which is why it=
 is unconditional.
>

The downside is that it requires LASS to be disabled - that is the
point of this discussion.

I think proactively carrying over this workaround to LASS systems
without any idea whether or not it is even needed is not the right way
to go about this.

> All it takes is the BIOS developer missing to register *one* pointer and =
this problem is back.
>
> The *real* bug is the BIOSes that not only require the use of SetVirtualM=
ap() in the first place, but require a non-1:1 mapping in the upper half. F=
or Linux it would be far better to *only* have the restricted 1:1 mapping i=
n the lower address space, as it wouldn't molest the kernel address layout =
which affects, especially, kexec.
>

Agreed. On arm64, we stopped calling SetVirtualAddressMap() years ago,
and just use the 1:1 mapping at runtime.

This is not feasible on x86, of course, due to the many buggy
implementations. But it would also mean no LASS for EFI calls, right?

