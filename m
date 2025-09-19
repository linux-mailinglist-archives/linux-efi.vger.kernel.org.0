Return-Path: <linux-efi+bounces-4876-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556B7B894B2
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 13:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E82562FBC
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE543093C9;
	Fri, 19 Sep 2025 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCwf0nIJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C819755B;
	Fri, 19 Sep 2025 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281904; cv=none; b=ZKB6CwKHvOjylZrOGA1PIUGGn5XA4CyceAfx4oBwzktRsWm5vl8+Zz3GVCPFTYmiAuz/5lGp+ZLL5/EVJ++9EzcioqA6TlOr9PRLqNlxFZ5I6daQWBpsEz5vlqSVQxOn5+LFjsZQsHsIhrwBQvgWFFoNGQcOLQksOsDXnXpwEPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281904; c=relaxed/simple;
	bh=vidOkY7U3aiEQG+l70hGzhfUzsMhfAF1dJHgRebiUMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZr8xJ7n94nTbqRkVrsoUKdj5jnMkEBL55/sEI/VfwXBz9weW+gDjziq/+rCI154jNETe3uwQ1w9E06gjKuJgKc4VEntrDB28YNrmJptAn2m5VBdVcvv964SmKb4psQ5kyt/KwsLt6hp6nwJ690qB+hj93pfaD1BrM08NNvYGIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCwf0nIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1168C4CEF0;
	Fri, 19 Sep 2025 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758281903;
	bh=vidOkY7U3aiEQG+l70hGzhfUzsMhfAF1dJHgRebiUMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCwf0nIJ2NO0jzAzO+tjoHLC4pkI79O4txtEutDJD9H2tq0ue553u1NLK/+A8vg+4
	 1Ta+BjvEMnzptkOy52E7ECxAXzxxA1OwtNBnzPaupKpynRp7lcStlZtwT0lOqrcDVh
	 G2/RuxROojKq4iU0mE9Ahggzk1IOt3siUdkaPgRSezTueqbPdAnarIIHa5hRkHz8yf
	 ltVlDqcR5Sh4apOY0wFBtZwQ9JMXyH3qBTLwt3X+7T3TUpue/oBWe7qp3AyM/D/yKS
	 HnTNyDC/jN/ZK2mTNp+bTsxsLXdiTYbsiQnxAZtyCXBdv7S04DWfSGlyznCTmvIYnu
	 16s1S6eEiS+iA==
Date: Fri, 19 Sep 2025 12:38:18 +0100
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/8] arm64: Make EFI calls preemptible
Message-ID: <aM1AqmHc7boSipIl@willie-the-truck>
References: <20250918103010.2973462-10-ardb+git@google.com>
 <CAMj1kXGndZxxe+u3st6FCebrdutUibspA7tJUpqGMgpj9UTFnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGndZxxe+u3st6FCebrdutUibspA7tJUpqGMgpj9UTFnA@mail.gmail.com>

On Thu, Sep 18, 2025 at 01:33:48PM +0200, Ard Biesheuvel wrote:
> On Thu, 18 Sept 2025 at 12:30, Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The arm64 port permits the use of the baseline FP/SIMD register file in
> > kernel mode, and no longer requires preemption to be disabled. Now that
> > the EFI spec is being clarified to state that EFI runtime services may
> > only use baseline FP/SIMD, the fact that EFI may code may use FP/SIMD
> > registers (while executing at the same privilege level as the kernel) is
> > no longer a reason to disable preemption when invoking them.
> >
> > This means that the only remaining reason for disabling preemption is
> > the fact that the active mm is swapped out and replaced with efi_mm in a
> > way that is hidden from the scheduler, and so scheduling is not
> > supported currently. However, given that virtually all (*) EFI runtime
> > calls are made from the efi_rts_wq workqueue, the efi_mm can simply be
> > loaded into the workqueue worker kthread while the call is in progress,
> > and this does not require preemption to be disabled.
> >
> > Note that this is only a partial solution in terms of RT guarantees,
> > given that the runtime services execute at the same privilege level as
> > the kernel, and can therefore disable interrupts (and therefore
> > preemption) directly. But it should prevent scheduling latency spikes
> > for EFI calls that simply take a long time to run to completion.
> >
> > Changes since v2:
> > - Permit ordinary kernel mode FP/SIMD with IRQs disabled, so that the
> >   special EFI case only deals with invocations in hardirq or NMI context
> > - Disallow EFI runtime calls in hardirq or NMI context, so that the
> >   special FP/SIMD handling for EFI can be dropped entirely
> > - Use a mutex rather than a semaphore for the arm64 EFI runtime lock,
> >   now that it is never trylock()ed in IRQ or NMI context.
> >
> > Changes since v1/RFC:
> > - Disable uaccess for SWPAN before updating the preserved TTBR0 value
> > - Document why disabling migration is needed
> > - Rebase onto v6.17-rc1
> >
> > (*) only efi_reset_system() and EFI pstore invoke EFI runtime services
> >     without going through the workqueue, and the latter only when saving
> >     a kernel oops log to the EFI varstore
> >
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Mark Brown <broonie@kernel.org>
> >
> > Ard Biesheuvel (8):
> >   efi: Add missing static initializer for efi_mm::cpus_allowed_lock
> >   efi/runtime: Return success/failure from arch_efi_call_virt_setup()
> >   efi/runtime: Deal with arch_efi_call_virt_setup() returning failure
> 
> Unless anyone objects, I am going to queue up these 3 patches ^^^ via
> the EFI tree.
> 
> >   arm64/fpsimd: Permit kernel mode NEON with IRQs off
> >   arm64/fpsimd: Drop special handling for EFI runtime services
> >   arm64/efi: Use a mutex to protect the EFI stack and FP/SIMD state
> >   arm64/efi: Move uaccess en/disable out of efi_set_pgd()
> >   arm64/efi: Call EFI runtime services without disabling preemption
> >
> 
> ... so the rest can go in via the arm64 tree in the next cycle.

As discussed off-list, that's probably the best plan for now. I've left
a few small comments on some of the arm64 bits and it would be good to
give them some soak time in -next.

Cheers,

Will

