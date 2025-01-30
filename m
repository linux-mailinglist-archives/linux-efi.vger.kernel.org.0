Return-Path: <linux-efi+bounces-2731-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B74A2317C
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2025 17:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF2A188815B
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2025 16:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977831E9B33;
	Thu, 30 Jan 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7xX/6ZR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4D84D34;
	Thu, 30 Jan 2025 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738253256; cv=none; b=mDPR7dExbwk0+hrEwBYa8BrHFIwzKNx/h4yQaheB8eQ3Nf8hhRcax6QCD/xsM3I0BJL7Pf2Kb4gLiZoRr1s05Gmwoq/NOm4wW/9kHT3uH5nP0HDkedIavnnF26jwIxyFAgmpdhvbdiIDdj174hWM6GZ+kBZOhCNGPHNFOH4L3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738253256; c=relaxed/simple;
	bh=w/YOoMVtzzyliGHIn9zfArDIGrhdrWf4TbtOCpdheVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQYkOJrICRbRhZ3HUMCWxol8M7lXR6u5tqAPuKWzdttUMN8H1lKLdwFAQGkjj/CwqNEOLRlwpiulgS01M7UKhCyvd8BfcjL6Zf9O0juqNlMPb4u3jhI1qaRxGs+SqB5rfzq1H6qZizYdGFuqm8rHPGpryQa/fkk5d2Bv0PtoaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7xX/6ZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC70CC4CED2;
	Thu, 30 Jan 2025 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738253254;
	bh=w/YOoMVtzzyliGHIn9zfArDIGrhdrWf4TbtOCpdheVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7xX/6ZRmcIStaIZJt0IhrQeilmcQQcA39GDRoP5Nty2srKRUQEImNlKOGjlTkIMT
	 TnRWqFdmXRcn5qrqWw5EHJ3iTqwrbXro22fBifKxWr+62EEbpOu/RrWmqswwyrud0j
	 PmNzZrWe1XrTQ0T1RjysJdg+iJviL/dzkKfAuIG0sJAYFCVT0WMX+B6mO15nlDZ5WF
	 BJkC72/ZGKgNI1tIi9B8zqHZMAO9glQ+oiqRr95jY/narGMpBG3sRqfLBl0HcG5w/p
	 pvyLfaIlFnQIowaXepWEAH2zAPBT2jAFJxV3yoq+iGYqIvTaIlebMkDwWJMQVMDVsx
	 BSaawU91q/vww==
Date: Thu, 30 Jan 2025 08:07:30 -0800
From: Kees Cook <kees@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Sam James <sam@gentoo.org>, Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, stable@vger.kernel.org,
	Kostadin Shishmanov <kostadinshishmanov@protonmail.com>,
	Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 0/2] A couple of build fixes for x86 when using GCC 15
Message-ID: <202501300804.20D8CC2@keescook>
References: <20250121-x86-use-std-consistently-gcc-15-v1-0-8ab0acf645cb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121-x86-use-std-consistently-gcc-15-v1-0-8ab0acf645cb@kernel.org>

On Tue, Jan 21, 2025 at 06:11:32PM -0700, Nathan Chancellor wrote:
> GCC 15 changed the default C standard version from gnu17 to gnu23, which
> reveals a few places in the kernel where a C standard version was not
> set, resulting in build failures because bool, true, and false are
> reserved keywords in C23 [1][2]. Update these places to use the same C
> standard version as the rest of the kernel, gnu11.

Hello x86 maintainers!

I think this would be valuable to get into -rc1 since we're getting very
close to a GCC 15 release. Can someone get this into -tip urgent,
please? If everyone is busy I can take it via the hardening tree, as we
appear to be the ones tripping over it the most currently. :)

-Kees

> [1]: https://lore.kernel.org/4OAhbllK7x4QJGpZjkYjtBYNLd_2whHx9oFiuZcGwtVR4hIzvduultkgfAIRZI3vQpZylu7Gl929HaYFRGeMEalWCpeMzCIIhLxxRhq4U-Y=@protonmail.com/
> [2]: https://lore.kernel.org/Z4467umXR2PZ0M1H@tucnak/
> 
> ---
> Nathan Chancellor (2):
>       x86/boot: Use '-std=gnu11' to fix build with GCC 15
>       efi: libstub: Use '-std=gnu11' to fix build with GCC 15
> 
>  arch/x86/boot/compressed/Makefile     | 1 +
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250121-x86-use-std-consistently-gcc-15-f95146e0050f
> 
> Best regards,
> -- 
> Nathan Chancellor <nathan@kernel.org>
> 

-- 
Kees Cook

