Return-Path: <linux-efi+bounces-3693-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D3CAB632C
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 08:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E908F167987
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 06:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3EA1EE7DD;
	Wed, 14 May 2025 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6LF/D9o"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C0A1F5E6;
	Wed, 14 May 2025 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204330; cv=none; b=g6O6V7pX3fq8qKgJQlvRFECIUSvukOkYAtnOLpA5AQEA+S0spKyQREL1pjQjEWhpDL72qZgwOj2zoIJBG0MrzDTjOPfDEnRbb4EDUtgnetpmg5sLnYFoaU6RkuKtEUBjwiO2SxOQ6eNfEuoEyfBfSAzpUcoK+Wv7d9Wp0mhae6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204330; c=relaxed/simple;
	bh=a5ihbTJoq76i1AJXKFMLCCn32Yf6hPthI1JAozW8irY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzF6zX1tpByW4xOaX7vmWdpj9LTmJulYJ6v9witxaUsvVwNUY1pwVFvBWyzBxZI+WBPSypTSZ0z9Eyvj6xL9P+d9zkkKxVBcAcp4xhQlQYlxDFc32Ma6TpmmV+2sCsKyBPWkTMftWBVEfRVHKaxx77K1sZ5Ru7blfe1hDNfB5J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6LF/D9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F2FC4CEE9;
	Wed, 14 May 2025 06:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747204329;
	bh=a5ihbTJoq76i1AJXKFMLCCn32Yf6hPthI1JAozW8irY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6LF/D9o451RHnxudJNSAovM/rFXea1bPhzXhCQZIVSFOH/O8nHKp+Whl2Hvptan3
	 BqLs5gM1CNvbHN6iAA+N0X6OoQGi6AVFUWrl0/xU1Jp5/NbCrRfhGKx5VO7v+zo7M6
	 APXCr2Tq6xL/+jzL6+XqYCQG/Tb3G/Mqc4B3o4AgQpY4PaFEWb6AZCpwLDCphmvnU5
	 RZquN3t8ALyp/DeKCU7fmUt3PFvNJ9o7nAXEFYMruOFVgsRCRQDScVZLGhGgqjyj9Z
	 nFpjfXN9l6bAWVW3XzJpOTfOznWyq4iK7vp0XaanyP2vWMbKImuHihDPzVQVm/JiIL
	 FhVOB71jZl1sw==
Date: Wed, 14 May 2025 08:32:03 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	x86@kernel.org, Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
Message-ID: <aCQ444zAwwkUwwm8@gmail.com>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>
 <aCMYrgd9DDQl7G1W@gmail.com>
 <20250513101250.GAaCMbIpk6kdVMizng@fat_crate.local>
 <aCMraFZ2yJQNyHf3@gmail.com>
 <20250513141633.GDaCNUQdRl6ci2zK5T@fat_crate.local>
 <CAMj1kXEzKEuePEiHB+HxvfQbFz0sTiHdn4B++zVBJ2mhkPkQ4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEzKEuePEiHB+HxvfQbFz0sTiHdn4B++zVBJ2mhkPkQ4Q@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Tue, 13 May 2025 at 15:17, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Tue, May 13, 2025 at 01:22:16PM +0200, Ingo Molnar wrote:
> ...
> > > Note that two of those fixes were from Ard who is working on further
> > > robustifying the startup code - a much needed change.
> >
> > Really? Much needed huh?
> >
> > Please do explain why is it much needed?
> >
> > Because the reason Ard is doing it is a different one but maybe
> > I misunderstood him...
> >
> 
> I will refrain from inserting myself into the intra-tip review and
> testing policy debate, but let me at least provide a quick recap of
> what I am doing here and why.
> 
> Since commit
> 
>    c88d71508e36 x86/boot/64: Rewrite startup_64() in C
> 
> dated Jun 6 2017, we have been using C code on the boot path in a way
> that is not supported by the toolchain, i.e., to execute non-PIC C
> code from a mapping of memory that is different from the one provided
> to the linker. It should have been obvious at the time that this was a
> bad idea, given the need to sprinkle fixup_pointer() calls left and
> right to manipulate global variables (including non-pointer variables)
> without crashing.
> 
> This C startup code has been expanding, and in particular, the SEV-SNP
> startup code has been expanding over the past couple of years, and
> grown many of these warts, where the C code needs to use special
> annotations or helpers to access global objects.
> 
> Google uses Clang internally, and as expected, it does not behave
> quite like GCC in this regard either. The result is that the SEV-SNP
> boot tended to break in cryptic ways with Clang built kernels, due to
> absolute references in the startup code that runs before those
> absolute references are mapped.
> 
> I've done a preliminary pass upstream with RIP_REL_REF() and
> rip_rel_ptr() and the use of the .head.text section for startup code
> to ensure that we detect such issues at build time, and it has already
> resulted in a number of true positives where the code in question
> would have failed at boot time. At this point, I'm not aware of any
> issues caused by absolute references going undetected.
> 
> However, Linus kindly indicated that the resulting diagnostics
> produced by the relocs tool do not meet his high standards, and so I
> proposed another approach, which I am implementing now (see cover
> letter for details). Note that this approach is also much more robust,
> as annotating things as __head by hand to get it emitted into the
> section to which the diagnostics are applied is obviously not
> foolproof.

Exactly.

> Fixing the existing 5-level paging and kernel mapping code was rather 
> straight-forward. However, splitting up the SEV-SNP code has been 
> rather challenging due to the way it was put together, i.e., as a 
> single source file used everywhere, and to which additional 
> functionality has been added piecemeal (i.e., the SVSM support).

Yeah.

> It is obvious that these changes should be tested before being merged,
> hence the RFT in the subject. And I have been struggling a bit to get
> access to usable hardware. (I do have access to internal development
> systems, but those do not fit the 'usable' description by any measure,
> given that I have to go through the cloud VM orchestration APIs to
> test boot a simple kernel image).

:-/ This is one of the reasons why bugs have such long latencies here.

For example it appears nobody has run kdump on SEV-SNP since last 
August:

  d2062cc1b1c3 x86/sev: Do not touch VMSA pages during SNP guest memory kdump

  ...
    It then results in unrecoverable #NPF/RMP faults as the VMSA page is
    marked busy/in-use when the vCPU is running and subsequently a causes
    guest softlockup/hang.
  ...

  1 file changed, 158 insertions(+), 86 deletions(-)

Yet lack of testability of your SEV-SNP series is still somehow 
blocking ongoing development work.

> What Boris might allude to is the fact that some of these changes also
> form a prerequisite for being able to construct a generic EFI zboot
> image for x86, which is a long-term objective that I am working on in
> the background. But this is not the main reason.
> 
> In any case, there is no urgency wrt these changes as far as I am
> concerned, and given that I already found an issue myself with v3,
> perhaps it is better if we disregard it for the time being, and we can
> come back to it for the next cycle. In the mean time, I can compare
> notes with Boris and Tom directly to ensure that this is in the right
> shape, and perhaps we could at least fix the pgtable_l5_enabled() mess
> as well (for which I sent out a RFC/v3 today).

You are being exceedingly generous here, but obviously boot code 
changes need quite a bit of testing, and v6.17 (or later) is perfectly 
fine too.

We could perhaps do the mechanical code movement to 
arch/x86/boot/startup/ alone, without any of the followup functional 
changes. This would reduce the cross section of the riskiest part of 
your series substantially. If that sounds good to you, please send a 
series for review.

Thanks,

	Ingo

