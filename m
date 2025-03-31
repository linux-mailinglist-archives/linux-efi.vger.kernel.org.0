Return-Path: <linux-efi+bounces-3139-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D19A76C4C
	for <lists+linux-efi@lfdr.de>; Mon, 31 Mar 2025 18:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D7B188DB0C
	for <lists+linux-efi@lfdr.de>; Mon, 31 Mar 2025 16:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AB82135DE;
	Mon, 31 Mar 2025 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6q/M26k"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB891E570A
	for <linux-efi@vger.kernel.org>; Mon, 31 Mar 2025 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743440150; cv=none; b=QF+w6/Dmpf7V0XhEb9lC0n3SVuu0lMbGDTeCzqMvyHu979bp/E0erI/QxIHFWqWbI4Wd54+Duzz0QuspYYFI0abUybPtaOt5bGjRQ1qXzJGu7CrJAw9WeuOR9OC/dptc1WtrCTRk4LZlcXBQ2V45xwM9lJhELPs4KXKk8peLDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743440150; c=relaxed/simple;
	bh=KuniyAJaqXmnw4mfc/EVNPcSIkIBaIZECRgRtd2AdxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFBOcrs9h4Ji7yRpCskVUz5R9a1lbmRAwYVvDJeRggzRq2ts90TYFq5YRIrENp6ZVh217onrBQmJpndXlQX7NVG9NMz2FyrnfP4/5BaJTHOi890fj5DLubpdV/paqKi+MnDCDn5Kwrljimap4YRSP5Bch0WGq3VBMF2FA9TqJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6q/M26k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB56BC4CEE3;
	Mon, 31 Mar 2025 16:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743440149;
	bh=KuniyAJaqXmnw4mfc/EVNPcSIkIBaIZECRgRtd2AdxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6q/M26kwPoFBSDrKDQ2UrTUaCGWgnSNwaY7PZSgftPyEyo6C9iiMnQeMmJu4kqvr
	 /IPyChxdOWXoNKKnbIsV69h+cZeh3/OOAFlMtmAiZ/G8g6sM4X3kT65pdv32lCHtsa
	 9XAhIjrhZoKCoAjEfrCZE4bWwa6wtir1DspbXSpuohOLti1MhhR63cSOckNtIF6ff4
	 H7Pv1zUZWVunw4lZxDrPkNh5i87NKyum7t4h7oHAKHImW+aaPsHVWRMZsGuYXpVDlU
	 o34a+8nSqVfqHw62SMPCApdlOzmdMuREG9cKh+Ebw7zHmXChcBRRgv8iYOwC+NSplu
	 YqqIjIDHTSOQQ==
Date: Mon, 31 Mar 2025 18:55:45 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-efi@vger.kernel.org
Subject: Re: [GIT PULL] EFI updates for v6.15
Message-ID: <Z-rJESxkzhg438vo@gmail.com>
References: <20250328070525.2248563-2-ardb+git@google.com>
 <CAHk-=wjc-EAEtv02iUFGej6RZs9C7ALAMtuh4rFNYs5VUt+4UA@mail.gmail.com>
 <CAMj1kXF61PeyercrHdkevq+UdKvBsfJ4QV2RFJyXMWAYtJ95oQ@mail.gmail.com>
 <Z-j8b7Z5oja05cCI@gmail.com>
 <CAMj1kXEpYG7LFgDiM2g4VsBVy1-+8pPxSwy6Xc9DS5u9f8aQZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEpYG7LFgDiM2g4VsBVy1-+8pPxSwy6Xc9DS5u9f8aQZg@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> So what I would like to propose for this arch/x86/boot/<something> 
> subdirectory is to move all these source files there, and build a 
> static library that can be pulled into the kernel proper as well as 
> the decompressor, using C flags etc that ensure that all code it 
> contains is safe for execution from the 1:1 mapping. This is how the 
> EFI stub static library is built, and also how the code in 
> arch/arm64/kernel/pi/ is constructed to ensure that it can safely run 
> from a virtual mapping that doesn't match the one the linker used at 
> build time.
> 
> How does that sound?

Sounds fantastic, related code should be together, like friends around 
a campfire.

Proposed locations, if it's 99% boot/init code (SYSTEM_BOOTING code):

	arch/x86/boot/efi/
	arch/x86/boot/efi/lib/
	arch/x86/boot/efilib/
	arch/x86/boot/lib/efi/

... or if there's a substantial runtime code (SYSTEM_RUNNING code):

	arch/x86/platform/efi/   # <--- already exists
	arch/x86/kernel/efi/

I'm a bit against the arch/x86/lib/ location for the simple reason
that the x86 library functions are usually simple self-contained 
regular-runtime facilities in C or asm with very little magic, which 
the EFI boot/stub code is as far away from as technologically possible. 
;-)

Look into arch/x86/lib/ and you'll see that EFI functionality doesn't 
really fit there.

Thanks,

	Ingo

