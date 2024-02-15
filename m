Return-Path: <linux-efi+bounces-561-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 070F1856115
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 12:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7FF1C20CC5
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 11:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CFC129A73;
	Thu, 15 Feb 2024 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="crCSa6Vg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE1128837;
	Thu, 15 Feb 2024 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995526; cv=none; b=OgUv5ebW+725rRLhndJwsBfqAoo4nAuZdek+Y7C0Ku1RNQfyU8B1c5o/HGgwqHxhdEVFAzoeuUQ3rRqkrToIFtuXv2yau2ron0jOKqHbs+hafeaX4ZnYeyGkY/LpRB4ohKuiq7O8xAo1WtdT/cGAfcHSKEOrbAtLMqxREre2dvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995526; c=relaxed/simple;
	bh=SJcrFIOTHrB95xddXSdy5IjhQ8kFKHDldJOFnNw7YXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpwdn+QgRvpQd+ujF6fom1h+8GQZxgrzyoMqpRTCcWI18FvGl72nJd2Z/yDRihckVtWXUunsoEhZGW+fte0SXNL1PjvhsrAjTTXnwgzw9+1OU2uU6lgsjlM11R/XzcATR5o24M5ZcfrVsg4gCS2vw6xHDdjIXwGivaKKJYAmMPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=crCSa6Vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8F8C433F1;
	Thu, 15 Feb 2024 11:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707995526;
	bh=SJcrFIOTHrB95xddXSdy5IjhQ8kFKHDldJOFnNw7YXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=crCSa6Vg6S2e6yFv6jZXkczccOCBSJPPDDmhi2qXUZ5qErMURTcBiNVv+mzvSS+I4
	 OgjPIdXYSVHPkfo/2qmcMPkq3cRaz0Qi41NJmPt97mLMjLSmk7l2fgbpatXNJI6K40
	 pCpwBP/NTP/sDUXlHj2BoOvNmEcEIAsFfNk1eO5M=
Date: Thu, 15 Feb 2024 12:12:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>,
	linux-efi <linux-efi@vger.kernel.org>, jan.setjeeilers@oracle.com,
	Peter Jones <pjones@redhat.com>, Steve McIntyre <steve@einval.com>,
	Julian Andres Klode <julian.klode@canonical.com>,
	Luca Boccassi <bluca@debian.org>,
	James Bottomley <jejb@linux.ibm.com>
Subject: Re: x86 efistub stable backports for v6.6
Message-ID: <2024021545-coconut-stylishly-26ed@gregkh>
References: <CAMj1kXEGzHW07X963Q3q4VPEqUtKC==y152JyfuK_t=cZ0CKYA@mail.gmail.com>
 <2024021552-bats-tabby-a00b@gregkh>
 <CAMj1kXHVMDq670JhAwsYeGjYVVfgCxFC7YUChUF1GSerCUB1ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHVMDq670JhAwsYeGjYVVfgCxFC7YUChUF1GSerCUB1ow@mail.gmail.com>

On Thu, Feb 15, 2024 at 10:41:57AM +0100, Ard Biesheuvel wrote:
> On Thu, 15 Feb 2024 at 10:27, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 15, 2024 at 10:17:20AM +0100, Ard Biesheuvel wrote:
> > > (cc stakeholders from various distros - apologies if I missed anyone)
> > >
> > > Please consider the patches below for backporting to the linux-6.6.y
> > > stable tree.
> > >
> > > These are prerequisites for building a signed x86 efistub kernel image
> > > that complies with the tightened UEFI boot requirements imposed by
> > > MicroSoft, and this is the condition under which it is willing to sign
> > > future Linux secure boot shim builds with its 3rd party CA
> > > certificate. (Such builds must enforce a strict separation between
> > > executable and writable code, among other things)
> > >
> > > The patches apply cleanly onto 6.6.17 (-rc2), resulting in a defconfig
> > > build that boots as expected under OVMF/KVM.
> > >
> > > 5f51c5d0e905 x86/efi: Drop EFI stub .bss from .data section
> > > 7e50262229fa x86/efi: Disregard setup header of loaded image
> > > bfab35f552ab x86/efi: Drop alignment flags from PE section headers
> > > 768171d7ebbc x86/boot: Remove the 'bugger off' message
> > > 8eace5b35556 x86/boot: Omit compression buffer from PE/COFF image
> > > memory footprint
> > > 7448e8e5d15a x86/boot: Drop redundant code setting the root device
> > > b618d31f112b x86/boot: Drop references to startup_64
> > > 2e765c02dcbf x86/boot: Grab kernel_info offset from zoffset header directly
> > > eac956345f99 x86/boot: Set EFI handover offset directly in header asm
> > > 093ab258e3fb x86/boot: Define setup size in linker script
> > > aeb92067f6ae x86/boot: Derive file size from _edata symbol
> > > efa089e63b56 x86/boot: Construct PE/COFF .text section from assembler
> > > fa5750521e0a x86/boot: Drop PE/COFF .reloc section
> > > 34951f3c28bd x86/boot: Split off PE/COFF .data section
> > > 3e3eabe26dc8 x86/boot: Increase section and file alignment to 4k/512
> > >
> > > 1ad55cecf22f x86/efistub: Use 1:1 file:memory mapping for PE/COFF
> > > .compat section
> >
> > Is the list here the order in which they should be applied in?
> >
> 
> Yes. These are all from v6.7 except the last one, but that has been
> queued for v6.7 already.
> 
> > And is this not an issue for 6.1.y as well?
> >
> 
> It is, but there are many more changes that would need to go into v6.1:
> 
>  Documentation/x86/boot.rst                     |   2 +-
>  arch/x86/Kconfig                               |  17 +
>  arch/x86/boot/Makefile                         |   2 +-
>  arch/x86/boot/compressed/Makefile              |  13 +-
>  arch/x86/boot/compressed/efi_mixed.S           | 328 ++++++++++++++
>  arch/x86/boot/compressed/efi_thunk_64.S        | 195 --------
>  arch/x86/boot/compressed/head_32.S             |  38 +-
>  arch/x86/boot/compressed/head_64.S             | 593 +++++--------------------
>  arch/x86/boot/compressed/mem_encrypt.S         | 152 ++++++-
>  arch/x86/boot/compressed/misc.c                |  61 ++-
>  arch/x86/boot/compressed/misc.h                |   2 -
>  arch/x86/boot/compressed/pgtable.h             |  10 +-
>  arch/x86/boot/compressed/pgtable_64.c          |  87 ++--
>  arch/x86/boot/compressed/sev.c                 | 112 +++--
>  arch/x86/boot/compressed/vmlinux.lds.S         |   6 +-
>  arch/x86/boot/header.S                         | 215 ++++-----
>  arch/x86/boot/setup.ld                         |  14 +-
>  arch/x86/boot/tools/build.c                    | 271 +----------
>  arch/x86/include/asm/boot.h                    |   8 +
>  arch/x86/include/asm/efi.h                     |  14 +-
>  arch/x86/include/asm/sev.h                     |   7 +
>  drivers/firmware/efi/libstub/Makefile          |   8 +-
>  drivers/firmware/efi/libstub/alignedmem.c      |   5 +-
>  drivers/firmware/efi/libstub/arm64-stub.c      |   6 +-
>  drivers/firmware/efi/libstub/efi-stub-helper.c |   2 +
>  drivers/firmware/efi/libstub/efistub.h         |  28 +-
>  drivers/firmware/efi/libstub/mem.c             |   3 +-
>  drivers/firmware/efi/libstub/randomalloc.c     |  13 +-
>  drivers/firmware/efi/libstub/x86-5lvl.c        |  95 ++++
>  drivers/firmware/efi/libstub/x86-stub.c        | 327 +++++++-------
>  drivers/firmware/efi/libstub/x86-stub.h        |  17 +
>  include/linux/efi.h                            |   1 +
>  32 files changed, 1204 insertions(+), 1448 deletions(-)
> 
> (Note: the commit hashes below are bogus, they are from my tree [0])
> 
> If you're happy to take these too, I can give you the proper list, but
> perhaps we should deal with v6.6 first?

Yeah, let's deal with 6.6 first :)

What distros are going to need/want this for 6.1.y?  Will normal users
care as this is only for a new requirement by Microsoft, not for older
releases, right?

thanks,

greg k-h

