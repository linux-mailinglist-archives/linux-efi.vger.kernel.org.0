Return-Path: <linux-efi+bounces-558-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0981855E06
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 10:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC061F211D6
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 09:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9217730;
	Thu, 15 Feb 2024 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qca106dL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD41BC23;
	Thu, 15 Feb 2024 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989224; cv=none; b=GDOssvBuJv1o/wK9uPQd1+9p4lkXN8trI2IENklOm5Utm7Ka0s6QvhrmEhsRZqG36pl0euORagDCyJyx529g9kMFT6m5Xlbb+n2RSXZpj9ueSF4altq9WVr/3CS8XhQT6Sq+SWc/U7CPUyDaf6WPakT0GNl1Ljngfli7Hg02jI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989224; c=relaxed/simple;
	bh=A5fbHGxtRbgjKuDkkQPsxhP/R9vJ3gqS4ITdwibQog8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPHUSZKAExYP4ym29CMOMY5LYgOUY6bzKteakoxmOHrqe8OwrntgJVbKKCT8UQi+v51bW1pmtzuHhe85gIZpkTPilMoJs4zzRoK/9aTebqQcZVn9lO+LTUg5m4rIbTuFQKnIUs9dzjxtkuQ2gJR3SsDvcKlcdgxSYGFi4BN4tIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qca106dL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7359C433C7;
	Thu, 15 Feb 2024 09:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707989224;
	bh=A5fbHGxtRbgjKuDkkQPsxhP/R9vJ3gqS4ITdwibQog8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qca106dLwOGDQJ1dpHdy0qAHOAX3i9KDetAvWb88/8QEFYznaFsNHMIf4p/BWJVHe
	 90JTWmsWmIKoAwlO8s1wMoKKlR//SGT3PPJwtXEk4sbqrEdBPMhv9BL/gqXwzgL3c5
	 LNypendNTG6qm0XVCEHd164i/uoF8TLjoPJRvxUA=
Date: Thu, 15 Feb 2024 10:27:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>,
	linux-efi <linux-efi@vger.kernel.org>, jan.setjeeilers@oracle.com,
	Peter Jones <pjones@redhat.com>, Steve McIntyre <steve@einval.com>,
	Julian Andres Klode <julian.klode@canonical.com>,
	Luca Boccassi <bluca@debian.org>,
	James Bottomley <jejb@linux.ibm.com>
Subject: Re: x86 efistub stable backports for v6.6
Message-ID: <2024021552-bats-tabby-a00b@gregkh>
References: <CAMj1kXEGzHW07X963Q3q4VPEqUtKC==y152JyfuK_t=cZ0CKYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEGzHW07X963Q3q4VPEqUtKC==y152JyfuK_t=cZ0CKYA@mail.gmail.com>

On Thu, Feb 15, 2024 at 10:17:20AM +0100, Ard Biesheuvel wrote:
> (cc stakeholders from various distros - apologies if I missed anyone)
> 
> Please consider the patches below for backporting to the linux-6.6.y
> stable tree.
> 
> These are prerequisites for building a signed x86 efistub kernel image
> that complies with the tightened UEFI boot requirements imposed by
> MicroSoft, and this is the condition under which it is willing to sign
> future Linux secure boot shim builds with its 3rd party CA
> certificate. (Such builds must enforce a strict separation between
> executable and writable code, among other things)
> 
> The patches apply cleanly onto 6.6.17 (-rc2), resulting in a defconfig
> build that boots as expected under OVMF/KVM.
> 
> 5f51c5d0e905 x86/efi: Drop EFI stub .bss from .data section
> 7e50262229fa x86/efi: Disregard setup header of loaded image
> bfab35f552ab x86/efi: Drop alignment flags from PE section headers
> 768171d7ebbc x86/boot: Remove the 'bugger off' message
> 8eace5b35556 x86/boot: Omit compression buffer from PE/COFF image
> memory footprint
> 7448e8e5d15a x86/boot: Drop redundant code setting the root device
> b618d31f112b x86/boot: Drop references to startup_64
> 2e765c02dcbf x86/boot: Grab kernel_info offset from zoffset header directly
> eac956345f99 x86/boot: Set EFI handover offset directly in header asm
> 093ab258e3fb x86/boot: Define setup size in linker script
> aeb92067f6ae x86/boot: Derive file size from _edata symbol
> efa089e63b56 x86/boot: Construct PE/COFF .text section from assembler
> fa5750521e0a x86/boot: Drop PE/COFF .reloc section
> 34951f3c28bd x86/boot: Split off PE/COFF .data section
> 3e3eabe26dc8 x86/boot: Increase section and file alignment to 4k/512
> 
> 1ad55cecf22f x86/efistub: Use 1:1 file:memory mapping for PE/COFF
> .compat section

Is the list here the order in which they should be applied in?

And is this not an issue for 6.1.y as well?

thanks,

greg k-h

