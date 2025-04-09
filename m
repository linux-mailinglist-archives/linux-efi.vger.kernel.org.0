Return-Path: <linux-efi+bounces-3255-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB6A82419
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 14:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B731B671E7
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 12:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0D254B09;
	Wed,  9 Apr 2025 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EE8vaj0Q"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4142253E4;
	Wed,  9 Apr 2025 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200071; cv=none; b=lk2hjM6mfbTlC+GtnMG69LpTnPCwiyLDfihkyygYKJI/n+AHKUb8bx1Wsnqhnthluzp5BkZ0DdYlnBzPnEjDnlZvDt/cJTJ6QMeqN2A5lcIvqvytkjww1gwtLNT4trmZV61yWzSk8NXXRMylvqduLiGIwIX9UO1N8flm8TroIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200071; c=relaxed/simple;
	bh=pUe0pgLGEmQZd+5lmbVqR6aUjhDeprWINrzKqoVQ5lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raT6uBZFdxCGju2e4vBp9NQs3WdUd+rnBoQSx5Mh3uudH5xom2juRu/zalqk2oNn+7fkLx85utm/chMlgnSQ/8qaCOeXh6ogCy6rn9z7+Rr8fYs3RrWvrgM3er7MS5M/1yYQkfDjPcy2OC1yElUl3xJ9cJP5yhiMeTss6Dfx8og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EE8vaj0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB571C4CEE3;
	Wed,  9 Apr 2025 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744200070;
	bh=pUe0pgLGEmQZd+5lmbVqR6aUjhDeprWINrzKqoVQ5lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EE8vaj0Q8BG93uovigDIohTc0+GnWrUrajONCFVl3wrw+uJSxBvQ2TErStCi9N5MV
	 wV3c5OOqaJePYxFBwBMtdHg+riOt0s9QlAwhKQ4LDPh2SUlXoG+a1MtcF8wU4F4Lqf
	 DjfRcTN6NduWclVyfz19/MPV5TRsdbNRjC4BnFFWdkn54mypNZB+Rw3ITIyv32qt08
	 0W98szmrLpwFEUtDN1nCZKxeMimIWsKXGyNm6gvEMCKJmC5f5v/8zomx8UgDcye5jj
	 kqfsc/WjQt0S8NV72HbGzh3neVbhGf7gk1So7a6IHNbVhBy9bq0d8CBXS6+fggKLfH
	 uZsCm1kR7dezw==
Date: Wed, 9 Apr 2025 14:01:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v3 3/7] x86/boot: Move the early GDT/IDT setup code into
 startup/
Message-ID: <Z_ZhglTgGStO8K5O@gmail.com>
References: <20250408085254.836788-9-ardb+git@google.com>
 <20250408085254.836788-12-ardb+git@google.com>
 <Z_ZGbVXOTPbGXleS@gmail.com>
 <Z_ZG7pAZavKDgFDK@gmail.com>
 <CAMj1kXHPg7NxFwyT6jNp5FunnGbWRW7Kd2FG5UPntLb-sxB03Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXHPg7NxFwyT6jNp5FunnGbWRW7Kd2FG5UPntLb-sxB03Q@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Wed, 9 Apr 2025 at 12:07, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ingo Molnar <mingo@kernel.org> wrote:
> >
> > >
> > > * Ard Biesheuvel <ardb+git@google.com> wrote:
> > >
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > Move the early GDT/IDT setup code that runs long before the kernel
> > > > virtual mapping is up into arch/x86/boot/startup/, and build it in a way
> > > > that ensures that the code tolerates being called from the 1:1 mapping
> > > > of memory. The code itself is left unchanged by this patch.
> > > >
> > > > Also tweak the sed symbol matching pattern in the decompressor to match
> > > > on lower case 't' or 'b', as these will be emitted by Clang for symbols
> > > > with hidden linkage.
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > >  arch/x86/boot/compressed/Makefile |  2 +-
> > > >  arch/x86/boot/startup/Makefile    | 15 ++++
> > > >  arch/x86/boot/startup/gdt_idt.c   | 83 ++++++++++++++++++++
> > > >  arch/x86/kernel/head64.c          | 73 -----------------
> > > >  4 files changed, 99 insertions(+), 74 deletions(-)
> > >
> > > This causes the following build failure on x86-64-defconfig:
> > >
> > >    arch/x86/boot/startup/gdt_idt.c:67:55: error: cast to generic address space pointer from disjoint ‘__seg_gs’ address space pointer [-Werror]
> >
> > Caused by the previous patch:
> >
> >   x86/asm: Make rip_rel_ptr() usable from fPIC code
> >
> 
> Oops, sorry about that. I saw that error and thought I had fixed it
> with the (__force void*) cast.

NP, caught it early enough.

Thanks,

	Ingo

