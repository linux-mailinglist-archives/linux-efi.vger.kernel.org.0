Return-Path: <linux-efi+bounces-4380-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A613EB074D2
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 13:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949304E28AD
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068222C3266;
	Wed, 16 Jul 2025 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="heJNa0BG"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC0AEC2;
	Wed, 16 Jul 2025 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665568; cv=none; b=R5lK2ErDrG8iX+0xCQG4i8eN9BVJSRzidbVLfO/MUA+sx9UWewYCEyHSbVHzC9OTA+wAXPU/SX4QW+2UbBhq7/Fv3J627wj2z5mH8Wiqu8WAhqPYKkaF8l5CNiValpF4T8KQT/p/nqks2KOCEDoYle8J5nzn1fE5oE64bDIZ0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665568; c=relaxed/simple;
	bh=U4ftgHx7BG0hS5ZesMs/MbXKFwbhwp6p9GnEEEI+06I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzNBUIewxe0rGgPPX5KObmHmh8be2lqgCO2jcCvY845B11/SbLgkXpAqR4iNtHMUuxv9xECoXL8QeQNAUEROSyz8YJQWQEoA9yBI0qedbDFXX0TvwnhXRpBxq+J0wwsPc/vkl67Y8yupjXyyf5mK9k3UAobeA5TO78gDEczQYXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=heJNa0BG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MuwYelL0xRseR8w636GzApuv9StW2dYU73F2LfQJqJc=; b=heJNa0BGHYTM8DKfYXhLms8Vlu
	e3aRQw20cwpY73MRKMER5oQp1guBFAOWczjYGzArwEy/v9MnmuOiHWgWM12CeEU3u8MLRZl1MShKQ
	TQM62J+LbrbtxioOePxvGEl5c+zydCtPyTQBeQyjXuZx116iOKI5Z+8imk47+1jCGjBsw5NRdSqd8
	DiymWE3jbt0EP0dokRbr4nu4ZEdRc4f+5ecrkiZ7h6aoyHBQw9optHr6XSkbLmhsTBXysfG5BS/LG
	wE1UoW7DuRLgomYZn49UeTelcnUUrN5Ta8b4a9CpjAtNA4h5ZQKZJdQf886nrCobFC4w0BF34N6B7
	ERyM0RiQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc0NP-0000000A5kV-3uVf;
	Wed, 16 Jul 2025 11:32:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7AD00300186; Wed, 16 Jul 2025 13:32:43 +0200 (CEST)
Date: Wed, 16 Jul 2025 13:32:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v5 15/22] objtool: Add action to check for absence of
 absolute relocations
Message-ID: <20250716113243.GU1613200@noisy.programming.kicks-ass.net>
References: <20250716031814.2096113-24-ardb+git@google.com>
 <20250716031814.2096113-39-ardb+git@google.com>
 <20250716095446.GV905792@noisy.programming.kicks-ass.net>
 <CAMj1kXHNvPdgG+OKX6UB70oTzzbvovfvDhSH73vAj-q7G03c5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHNvPdgG+OKX6UB70oTzzbvovfvDhSH73vAj-q7G03c5Q@mail.gmail.com>

On Wed, Jul 16, 2025 at 08:26:55PM +1000, Ard Biesheuvel wrote:

> For robustness, we should actually check for all absolute relocations
> here, including R_X86_64_32S, which is not abstracted into a R_ABSxx
> type for objtool.
> 
> So perhaps this needs an arch hook where x86_64 can implement it as
> 
> bool arch_is_abs_reloc(reloc)
> {
>    switch (reloc_type(reloc)) {
>    case R_X86_64_32:
>    case R_X86_64_32S:
>    case R_X86_64_64:
>       return true;
>    }
>    return false;
> }
> 
> and the default just compares against R_ABS32 / R_ABS64 depending on
> the word size?

Yes, an arch hook like that makes sense. Perhaps make the signature:

bool arch_is_abs_reloc(struct elf *, struct reloc *);

Because the word size comes from elf_addr_size().

