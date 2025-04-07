Return-Path: <linux-efi+bounces-3217-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B693FA7E96B
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 20:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B933A9745
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 18:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8244122172E;
	Mon,  7 Apr 2025 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc1cm2TS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598DE221727;
	Mon,  7 Apr 2025 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049213; cv=none; b=dELH+zhfUaMxa6JyJx/g8Q113yW58ySqVU4Uz83af0ty/JtwUMJEVE+Ysvbu0JTZ/CMlSClbjVF1ulSvKXABtv63fwhaD+SzQepWYnkvF2jfH3zOivJKYrKJkRvsJT1sMyoF1stEB1M4rTYoRgoW9zYptwuw31q+xebh1Hnetww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049213; c=relaxed/simple;
	bh=MK/LnMtUtop8kC8hvXlfOeYWUUjyZpSdxLnXtoMexRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSbd8ETyksHRcXXuW5v97lZ1Qq7ma/08tR2qWeLJmiecvYtnQLAMvunIVmLhoktBJx6M3eXDqC8ajL+v86luxpNEcnndUn/+ZXvAm1VcV5SY7ebt3lo0HodVUDWDn5hF0enGznHdofEzIhr6N7tk8a+mCZO7tyGtlT3DB5tVdE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc1cm2TS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7443FC4AF0F;
	Mon,  7 Apr 2025 18:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049212;
	bh=MK/LnMtUtop8kC8hvXlfOeYWUUjyZpSdxLnXtoMexRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zc1cm2TSqOlLEFcIlP4EqxOjLHlqGhTSVFRbpYInc5qF32rS7se6YTmw+iHMFtsKm
	 tCz9FREtA+crPOHFqTnlh9HTWfKhnqFAej2S8WZUBv1Ul5OmcqpIiwNuv6ZQ3nSVap
	 IvxtPqoh74FC94G1yd3FWKX5+Ln9EUeDx2YTwY6fwywFe/JiDaScUOez1hpGo16cw5
	 J3J6mwXgLq/Gsu3bDdE2FRTyNDOqYq19fke4C+ZoHxmN+ak1AoUrBoVOvR5iQeQqmf
	 T8zvi9989EJAZSUcyPGgYc9A/cZ1pOHKMZG9qOlJ1tkumxQQl1IMqJnVzrLE10fjh5
	 VMmCPMM48rnag==
Date: Mon, 7 Apr 2025 20:06:48 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/boot: Move early kernel mapping code into
 startup/
Message-ID: <Z_QUOPyVwyPShwH_@gmail.com>
References: <20250407061132.69315-4-ardb+git@google.com>
 <20250407061132.69315-5-ardb+git@google.com>
 <Z_QO8QybPCwzRwms@gmail.com>
 <CAMj1kXGGpZp_OgUuQ2CkpJdDgsRzxuLz3wjesKxDyHvveuUqUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGGpZp_OgUuQ2CkpJdDgsRzxuLz3wjesKxDyHvveuUqUA@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Mon, 7 Apr 2025 at 19:44, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > The startup code that constructs the kernel virtual mapping runs from
> > > the 1:1 mapping of memory itself, and therefore, cannot use absolute
> > > symbol references. Move this code into a separate source file under
> > > arch/x86/boot/startup/ where all such code will be kept from now on.
> > >
> > > Since all code here is constructed in a manner that ensures that it
> > > tolerates running from the 1:1 mapping of memory, any uses of the
> > > RIP_REL_REF() macro can be dropped, along with __head annotations for
> > > placing this code in a dedicated startup section.
> >
> > So would it be possible to do this in ~3 steps: first the mechanic
> > movement of code, with very few changes (if the result builds & boots),
> > then drop the RIP_REL_REF() uses and __head annotations in two separate
> > patches?
> >
> > Bisectability, ease of review, etc.
> >
> > (The tiny bird gets the worm, but I might have butchered that proverb.)
> >
> 
> Yes.
> 
> And actually, the Clang boot regression that was reported indicates 
> that this statement it not 100% true to begin with. While it is no 
> longer necessary to use RIP_REL_REF() for accesses to global 
> variables, it may still be needed when explicitly taking the address 
> of a global variable and storing it in a stack allocated struct, 
> e.g.,
> 
> void __init startup_64_setup_gdt_idt(void)
> {
>         void *handler = NULL;
> 
>         struct desc_ptr startup_gdt_descr = {
>                 .address = (__force unsigned long)gdt_page.gdt,
>                 .size    = GDT_SIZE - 1,
>         };
> 
> In this case, even -fPIC may produce an absolute reference to
> gdt_page.gdt, but from .rodata not from .text, and this is equally
> broken at early boot.

OK.

> Once all this code has been moved into place, I'll propose the
> validation (similar to arm64 and EFI stub) which just greps the output
> of readelf -r and checks for occurrences of R_X86_64_64; that way, we
> will detect early and precisely whether the codegen is ok.

Yeah, that sounds good!

> Please let me know which of these patches you are intending to keep 
> in tip/x86/boot, and I will respin on top of that.

I'd like to merge all of them as long as they don't intentionally regress.
All of this seemed like a step forward, and having them in one place
will enable a new type of debugging check - which is a win too in my book.

So no fundamental worries from me, just the request to have more 
careful iterations.

Thanks,

	Ingo

