Return-Path: <linux-efi+bounces-5365-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54390C37AAD
	for <lists+linux-efi@lfdr.de>; Wed, 05 Nov 2025 21:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2E954E9060
	for <lists+linux-efi@lfdr.de>; Wed,  5 Nov 2025 20:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2F8340298;
	Wed,  5 Nov 2025 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVjlLypv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC7257AD1;
	Wed,  5 Nov 2025 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373732; cv=none; b=QTpmSOUMp8likNFzDMoiZ+5WbNTjQOCphgmRi0C5RNe4r/uPlNiaU1IMOE14cDIkOM4K1J0lbmjcEbQ5EN2ssYGh4XxdcitLOlQQOW4ZAK8+mGYFJGrzBCH/rSWI6s2rXpqmEozUgvNOgseXo2p0qZcJRCmW10pvXEd49zFbOQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373732; c=relaxed/simple;
	bh=Lw++o2HELy2ZtWzBIbekYFJktkL5pR/Om2RKn74v1rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwa9dJBs/dZIfKLSShxxH4njezKg7jC/hwlP49ycynaVW5nusOQyk7HZI8VZdIWE5Q4V4ZDKUV1m9wPT/YHgir+fOjomf6h2A89tqGm/hQRk2EoBm39QPfoPn/I0QshSE/HmfKKFFsiZ187wEnIhEu0tuo46Wapckp3oQpb1Sjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVjlLypv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A94C4CEF5;
	Wed,  5 Nov 2025 20:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762373731;
	bh=Lw++o2HELy2ZtWzBIbekYFJktkL5pR/Om2RKn74v1rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tVjlLypvxp3tK6h3M4G7McwvdI6gA8sxm/UocCXG0mBUTsqUSzgrjT87E1jK3B7rE
	 ibU2ywmazXPh8J10A3IxweVZ8xaZofARrlwX0OlWkDzUJKqErx5FjL0EPddsf91/NQ
	 3oPru8Psy5xRWnEgEShymCYgSetPXqw72puMPnE6ccAIz+Fu5j6x1iwibexdQ9zoiS
	 fe18mkKCL625LUctrbKaESMKZ7GPUJftYZvZ2rxKR4a+sJN2uJfeLNcoyICvtUikQi
	 PLh4WhrsOD8YLyih3t766j/ZSJe7NBsghwm5c25JoUzABBadcnwyLdEVVQJ7W553rD
	 0eOxjwkaepv7Q==
Date: Wed, 5 Nov 2025 13:15:22 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org, llvm@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] kbuild: Add '-fms-extensions' to areas with dedicated
 CFLAGS
Message-ID: <20251105201522.GB3787308@ax162>
References: <20251101-kbuild-ms-extensions-dedicated-cflags-v1-1-38004aba524b@kernel.org>
 <aQtUujos2ADVs-_O@gate>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQtUujos2ADVs-_O@gate>

On Wed, Nov 05, 2025 at 07:44:26AM -0600, Segher Boessenkool wrote:
> On Sat, Nov 01, 2025 at 12:35:47PM -0400, Nathan Chancellor wrote:
> > There are many places within the kernel that use their own CFLAGS
> > instead of the main KBUILD_CFLAGS, meaning code written with the main
> > kernel's use of '-fms-extensions' in mind that may be tangentially
> > included in these areas will result in "error: declaration does not
> > declare anything" messages from the compiler.
> 
> Please fix such non-standard code then, instead?  The only (documented)
> thing -fms-extensions does for C code is give meaning to something that
> otherwise is a syntax error (and it is for a good reason!)

Right, the kernel would like to start taking advantage of one of those
extensions. See these other threads for more information.

https://lore.kernel.org/20251020142228.1819871-1-linux@rasmusvillemoes.dk/
https://lore.kernel.org/20251023082142.2104456-1-linux@rasmusvillemoes.dk/

Cheers,
Nathan

