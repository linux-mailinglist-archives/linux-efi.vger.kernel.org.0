Return-Path: <linux-efi+bounces-4860-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEE4B84650
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 13:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3206A188613F
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345A1303A08;
	Thu, 18 Sep 2025 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+UYznhC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D327B328;
	Thu, 18 Sep 2025 11:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195896; cv=none; b=AcM8HjfpKdbuEkQhcc5vokMmrVCBhv+VnWwu20kiwAlhvIxgY4ePo7IuU0x/ZG5HPD9pTEax3vPTv7XNKii2BBBQkA2BSCoENt1n89Eq80nf1l8QDu6eLE1oO2QDgeL3UDPibJRfzkerQP+owSXONOolBVHfUTok2vaq/UQcJyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195896; c=relaxed/simple;
	bh=QWckBIgmlhG9nD+7S9Y3qbN6qkWCXNxu5YXuWFjTx04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoKs68/p7PlElIsi/gbXL6hfehxdf303/NsiLP5jdrj+lNfmm+L/gJKbRxCfH44js+T/E1L78UKadMHrKX6dbbFLBneXd1W7MtSCsUmMuCf/8RW9C5HgODVgBbbgFJ8hYZkDW/Hd9sjrvNWQdagzvyTTjykIkHlk+TI+aCMUF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+UYznhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A819AC4CEE7;
	Thu, 18 Sep 2025 11:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758195895;
	bh=QWckBIgmlhG9nD+7S9Y3qbN6qkWCXNxu5YXuWFjTx04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+UYznhCrKg0d5IG5hVOnmPVAM3kvmQX3yzneTIhT9kT2rFDwt+iClT/JG9aigoVJ
	 ka+Q/c6aRuLm6mz0qXvVxpbpamVmWa0ZV1UHZYZPOM7js43tnnjolt5OjSX5De0sPh
	 YFinjk8aE/JyjtnM7KbTPIsvVgRYkHct5PEKTD0FdbqRZaZipqFgV+naZIwkKHAoiK
	 vDsu40MAy2EPXPZeWRgWoM1ZMtU3hk8oACDORfPQb7oFNui70fUiJL5ZAAtuKpI4o/
	 IwH7xXY6T+zJ27AVcx+PHTSHIK7H3puCKUJLpV6BPRLRh/Tr+zApTBJi11+lpi+PMg
	 1oQ4W1AQR5uOw==
Date: Thu, 18 Sep 2025 12:44:50 +0100
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
Message-ID: <aMvwstR28CDphk4J@willie-the-truck>
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

I'm also happy to take the whole lot via arm64 this cycle, if you like?
I reviewed it a while ago and was happy with it then.

Up to you.

Will

