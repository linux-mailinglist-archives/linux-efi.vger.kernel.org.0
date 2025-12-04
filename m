Return-Path: <linux-efi+bounces-5803-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 137ADCA5315
	for <lists+linux-efi@lfdr.de>; Thu, 04 Dec 2025 20:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C79AD30B6AE8
	for <lists+linux-efi@lfdr.de>; Thu,  4 Dec 2025 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127493446DB;
	Thu,  4 Dec 2025 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTI9rRYG"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B533290D
	for <linux-efi@vger.kernel.org>; Thu,  4 Dec 2025 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878341; cv=none; b=LGMyS3Q29x1N4oVjNAEHBObgNADN77Ig4lmNl5Z8gXncOpRAFl3hKSJt74TOv+h6kLR9xS3KJ/tPsEbu3C9sfooUL1L/7ESnHsfzOiCMcw6VUIZcyEmZGMolvKMeB2V+8l/S7FqFK9LhuDmpa18DUwubY1Ak1ElXLGlYsj65pEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878341; c=relaxed/simple;
	bh=G+knv8Jl6492/pvR27kMohY40iiTF47+8r2FthdMUeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwzGoPoKT8p15ynYibsLTgwepX1iRE3NVGpSU6MaaNFZl2bnuHoseDXxw2FOR55As/EORoTbnACtkIZ+FnoEbKaOPkQywzOHy9Ib6qSCVQnGfjRXEGcrj4mhlqHIaH9OoxKrLr0JS6Y4+r3lFpduw+aKvxXBsDnx6sC+ytEWKQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTI9rRYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC7EC2BCAF
	for <linux-efi@vger.kernel.org>; Thu,  4 Dec 2025 19:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764878340;
	bh=G+knv8Jl6492/pvR27kMohY40iiTF47+8r2FthdMUeA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XTI9rRYG2iAHWMRLRX5BYAVBnxP6R4tAom8Zwcj87mVNXsGN8GBV4R4mQ7XC2W9tN
	 X5xGaCb63yxDnrgz47Ew8acu+wa9CYu6GufChG9dshWco1ieTAJPUMcOvzYuxuj2wW
	 b8/m6KOIpD9kdA+0pgsPNOLU4lDQsJJhguGgnhc3y9PRXTkrws/JAdhicdE4OWtEi8
	 51lTbszUuk76tHuF8d/dD7wvQbmOUaU8K937Qv0rVxGXDqDaoCmYKwD9z65UnWhHD/
	 CPzKE2RUA8cRH8WfJ7XJRutShFN5T+kC+diTmrlJSG/zZ3m9YY/lyzBVp9iDEzHSC7
	 shpFfu58tfR2A==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37902f130e1so10096811fa.1
        for <linux-efi@vger.kernel.org>; Thu, 04 Dec 2025 11:59:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJAErRgFm2+Rey7iKZkAa6doLYJk5atGDzDli+nJzjTdHKqyF7vw0b8pXlSm5P/n6mRRZFBMvzfdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkoA4TD5CU+rxA1BNhd3hRLLL96Vow7nH5piHNZErwzk+W0ZMC
	BUj2UY+LiCs44cfs9gcgfr3u0EeFE0h7BD7lgxt0ROSYx6YIzmGF92p+/bMOC3zr+gOquJKOww0
	Kfs9Prqk2jDb4qebl7mN4FYbTShHCqVc=
X-Google-Smtp-Source: AGHT+IGBgxikODpMZ9ObBrtYbMcNRSE/j83LraQIe/V53b+Z+G57OsXr6rtW/XFD2uH39UohWvbIbAuw6yQhPFWTX98=
X-Received: by 2002:a05:651c:41d4:b0:37b:9976:3ba0 with SMTP id
 38308e7fff4ca-37e63505831mr22440161fa.0.1764878338779; Thu, 04 Dec 2025
 11:58:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204072143.3636863-1-sohil.mehta@intel.com>
 <CAMj1kXFicnmVUeoRsMNbBgDN20fCN+R01H9shcgOJMD2Nzn8Cg@mail.gmail.com>
 <5fb937b4-5459-4894-a107-945bfb50a701@intel.com> <CAMj1kXECOBQczcNeqmhfgttz_0545B3m7OgLAk4WE_hOkUbohg@mail.gmail.com>
 <B0E164E9-9037-4DD3-BFF6-E628B23349FF@zytor.com> <CAMj1kXHYKX4nU_xULC9vBDQxdyq9n_gcDqUTL2QZXvZhkHZRAg@mail.gmail.com>
 <F707CA45-DA37-460A-AEFF-C11AC6AB6A05@zytor.com>
In-Reply-To: <F707CA45-DA37-460A-AEFF-C11AC6AB6A05@zytor.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Dec 2025 20:58:47 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEQFhdZ4kcObsxNoj2cK+TGS=xBU83ARVrifxjw8yPcJQ@mail.gmail.com>
X-Gm-Features: AWmQ_blZ_XtTcCVWujnr5r4d1wnt7WYK06LW-v3QD1IMfqTTK1w3bQOQQbc-HPo
Message-ID: <CAMj1kXEQFhdZ4kcObsxNoj2cK+TGS=xBU83ARVrifxjw8yPcJQ@mail.gmail.com>
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

On Thu, 4 Dec 2025 at 20:51, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On December 4, 2025 11:40:03 AM PST, Ard Biesheuvel <ardb@kernel.org> wro=
te:
> >On Thu, 4 Dec 2025 at 20:16, H. Peter Anvin <hpa@zytor.com> wrote:
> >>
> >> On December 4, 2025 11:03:52 AM PST, Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >> >On Thu, 4 Dec 2025 at 18:34, Sohil Mehta <sohil.mehta@intel.com> wrot=
e:
> >> >>
> >> >> On 12/4/2025 4:47 AM, Ard Biesheuvel wrote:
> >> >> > Hello Sohil,
> >> >> >
> >> >>
> >> >> Hello Ard - Thank you for looking at the patches.
> >> >>
> >> >>
> >> >> >>
> >> >> >>   2) Boot services code and data are referenced long after
> >> >> >>   ExitBootServices(). For example, efi_check_for_embedded_firmwa=
res()
> >> >> >>   accesses boot services memory even after SetVirtualAddressMap(=
).
> >> >> >>
> >> >> >
> >> >> > These accesses use the kernel direct map, so I don't think they c=
ome
> >> >> > into play here.
> >> >> >
> >> >>
> >> >> I don't mean SVAM should have switched these addresses to virtual o=
nes
> >> >> but doesn't all of EFI_BOOT_SERVICES_{CODE|DATA} have address[63] =
=3D 0?
> >> >>
> >> >
> >> >Whether a mapping has bit 63 set or cleared depends on the location o=
f
> >> >the mapping in the virtual address space, not on the location of the
> >> >physical backing of that mapping.
> >> >
> >> >efi_check_for_embedded_firmwares() maps EFI_BOOT_SERVICES_DATA region=
s
> >> >in the kernel region, so bit 63 will be set.
> >> >
> >> >> LASS wouldn't care whether there is an actual mapping behind the
> >> >> address. It only relies on the MSB for enforcement. So, any code th=
at
> >> >> relied on accessing boot services memory before efi_free_boot_servi=
ces()
> >> >> could get affected by LASS.
> >> >>
> >> >
> >> >This only applies to code that accesses boot services memory via a
> >> >mapping in the lower range.
> >> >
> >> >> >>   3) Some runtime services fail to switch to virtual mode proper=
ly and
> >> >> >>   continue referencing physical addresses [3]. The kernel mainta=
ins a
> >> >> >>   1:1 mapping of all runtime services code and data regions to a=
void
> >> >> >>   breaking such firmware.
> >> >> >>
> >> >> >
> >> >> > In [3], I mainly elaborated on why it is still necessary to call
> >> >> > SetVirtualAddressMap(), and why it needs to be called with a mapp=
ing
> >> >> > in the upper address range.
> >> >> >
> >> >> > For this particular call, there is no choice but to disarm LASS, =
given
> >> >> > that the lower mapping is still active at this point.
> >> >> >
> >> >> > However, that does not imply that we have to assume that systems =
that
> >> >> > support LASS (which are fairly recent AIUI) are buggy in the same=
 way,
> >> >> > i.e., that they access addresses in the 1:1 region after
> >> >> > SetVirtualAddressMap() completes.
> >> >>
> >> >> I assumed that it must be widespread because the kernel maintains t=
he
> >> >> 1:1 mapping unconditionally without any Family-model checks. The co=
de
> >> >> isn't explicitly warning about such implementations, either.
> >> >>
> >> >
> >> >Exactly, and this is an oversight that occured 10+ years ago. No
> >> >reason to keep carrying that forward forever.
> >> >
> >> >> >
> >> >> > In fact, we might attempt to use the availability of LASS as a
> >> >> > preliminary cutoff point for disabling this hack entirely, and on=
ly
> >> >> > backpedal if we get actual reports where this is still a problem.
> >> >>
> >> >> Sure, I am onboard with this approach, but some folks seemed skepti=
cal
> >> >> about it during the base LASS series review. My only concern is bre=
aking
> >> >> user systems when they update to a LASS-enabled kernel.
> >> >>
> >> >> x86 maintainers, any preference?
> >> >>
> >> >> Would it be useful to put this (patch 2) behind an "efi=3Ddisable_l=
ass"
> >> >> command line option? That way, if someone runs into it, there is at
> >> >> least a fallback option they can rely on. By default, we would stil=
l
> >> >> expect newer firmware to not need this hack.
> >> >>
> >> >
> >> >efi=3Dnoruntime is already available, which may be sufficient to work
> >> >around this in individual cases, to regain access to a non-booting
> >> >system.
> >>
> >> You are missing something *really* important:
> >>
> >> What do you expect to gain?
> >>
> >> There is basically no downside to the current workaround, which is why=
 it is unconditional.
> >>
> >
> >The downside is that it requires LASS to be disabled - that is the
> >point of this discussion.
> >
> >I think proactively carrying over this workaround to LASS systems
> >without any idea whether or not it is even needed is not the right way
> >to go about this.
> >
> >> All it takes is the BIOS developer missing to register *one* pointer a=
nd this problem is back.
> >>
> >> The *real* bug is the BIOSes that not only require the use of SetVirtu=
alMap() in the first place, but require a non-1:1 mapping in the upper half=
. For Linux it would be far better to *only* have the restricted 1:1 mappin=
g in the lower address space, as it wouldn't molest the kernel address layo=
ut which affects, especially, kexec.
> >>
> >
> >Agreed. On arm64, we stopped calling SetVirtualAddressMap() years ago,
> >and just use the 1:1 mapping at runtime.
> >
> >This is not feasible on x86, of course, due to the many buggy
> >implementations. But it would also mean no LASS for EFI calls, right?
> >
>
> But your underlying assumption is that disabling LASS around EFI calls is=
 a problem. It isn't, because the efi_mm has explicitly unmapped any memory=
 EFI isn't allowed to touch. In other words, we are already doing the equiv=
alent of LASS "manually."
>

I must have misunderstood then - there was some pushback on this IIRC
but if en/disabling LASS is fine then sure.

