Return-Path: <linux-efi+bounces-4861-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD6FB84684
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 13:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF69B1C256AC
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 11:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AD02FAC1E;
	Thu, 18 Sep 2025 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyWGX9ek"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325F2F25E9
	for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758196103; cv=none; b=qjnyybuGuo/nPHvAkqhLyaZgGaB+uw0OvI5jYkNuiUDbxus7+8roYoX6hMrtrjKtZZa+LshK04bXHAhaogzGFP5XgIbQ73f9dOqe7ZFuJjY0+fdAtG+D8cQ6yg7HcrCOOrfYHSg7J3MoqtbwIR/i4lJWEISTiCtH3/Y1HF0YXUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758196103; c=relaxed/simple;
	bh=RTUNOwYnHz3bm7fXFE054iF4e70EGE1OcyC40tA5Vwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vy36RwjNwEn0vpeBAAmYKWaplwWTeAU979mJ9chzYtrV0Ap4A8m2K2dZwP+SKNzlHMBRze7HAPJAw8/Bsq36KfuFWM7eDSWucspTmkbeLpqlIThTgrfIQ7xKa2/Cxv3gipEBao8876Qyc549p1Qb+IIIpj3pt9DuYdWi8BSy0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyWGX9ek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDB9C4CEE7
	for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758196103;
	bh=RTUNOwYnHz3bm7fXFE054iF4e70EGE1OcyC40tA5Vwg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pyWGX9ekGA9wIniFXQFYd36XcgJrRczjKNwyyMmfLI/zXQSn8AXuByyOulFWaWWa2
	 LKmbRBlz9rxzv8mhwGUh0Mqe44q4Ha6FbcXwkorZ3ncub5G7hydpe4seTfEwTCRR5t
	 Sj7d58ma4J+FK1bCM1gyZqhuO3DapMdAf2R6NJr18ZEOnqzlQZLF3OHE9TeqmjCbT5
	 qHZZiSuWt2HlAytQp4BUyj4myxGi8iOiJAK+JZyOMTUTxBcruVVG8/4dnalThfVYTU
	 sxWpsK5jv0mdpbL8CcOxTCA/2g39qD5dUaTvIeML6yHlLkGWLElq32qlyWnFfRELjK
	 mNzxy0PWmhiyg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-579363a4602so513759e87.0
        for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 04:48:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlVmOBVwOqLWsuTxTLN64mWkHywoK8rNXYU8d/vDU2PZW4//cQP/pwGkauKFf9UiUnbtIVEJGSstY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFNjRVzDv7iS3vwKxj76Ere+v4zfapt39uJgpM0HWiuKcskBJQ
	vIQK8gMAmClBrhiNCqsgv/yJZ+mrbCDPjGtZous0DUhE8fja3oQVxHiQsBbJ4zSO49vybRXJPx2
	h/YNUka7sLx6pRgaJViRTRLPf3YCiWxA=
X-Google-Smtp-Source: AGHT+IGF0M6CdiMEFapSpsuAEcu8LEGsyj1+Ha6uD9bZ+JbV0vSO/y4+K4BYQUjIeTJU4lG+5fWipTeDfHAPo6wMBJM=
X-Received: by 2002:a05:6512:32c6:b0:55f:601d:a819 with SMTP id
 2adb3069b0e04-5779a6604d4mr1758174e87.33.1758196101313; Thu, 18 Sep 2025
 04:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918103010.2973462-10-ardb+git@google.com>
 <CAMj1kXGndZxxe+u3st6FCebrdutUibspA7tJUpqGMgpj9UTFnA@mail.gmail.com> <aMvwstR28CDphk4J@willie-the-truck>
In-Reply-To: <aMvwstR28CDphk4J@willie-the-truck>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 18 Sep 2025 13:48:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF1AAE9sLvDR0YwjZ0pDcnGG4cwqcy6VadUF-jOa7GkJw@mail.gmail.com>
X-Gm-Features: AS18NWCkpq6FAgVrtvz42UXpOw-zfg2xngxs2fJpZJ76gvKhtfUyxwhkKEjs2jU
Message-ID: <CAMj1kXF1AAE9sLvDR0YwjZ0pDcnGG4cwqcy6VadUF-jOa7GkJw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] arm64: Make EFI calls preemptible
To: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 13:44, Will Deacon <will@kernel.org> wrote:
>
> On Thu, Sep 18, 2025 at 01:33:48PM +0200, Ard Biesheuvel wrote:
> > On Thu, 18 Sept 2025 at 12:30, Ard Biesheuvel <ardb+git@google.com> wrote:
> > >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > The arm64 port permits the use of the baseline FP/SIMD register file in
> > > kernel mode, and no longer requires preemption to be disabled. Now that
> > > the EFI spec is being clarified to state that EFI runtime services may
> > > only use baseline FP/SIMD, the fact that EFI may code may use FP/SIMD
> > > registers (while executing at the same privilege level as the kernel) is
> > > no longer a reason to disable preemption when invoking them.
> > >
> > > This means that the only remaining reason for disabling preemption is
> > > the fact that the active mm is swapped out and replaced with efi_mm in a
> > > way that is hidden from the scheduler, and so scheduling is not
> > > supported currently. However, given that virtually all (*) EFI runtime
> > > calls are made from the efi_rts_wq workqueue, the efi_mm can simply be
> > > loaded into the workqueue worker kthread while the call is in progress,
> > > and this does not require preemption to be disabled.
> > >
> > > Note that this is only a partial solution in terms of RT guarantees,
> > > given that the runtime services execute at the same privilege level as
> > > the kernel, and can therefore disable interrupts (and therefore
> > > preemption) directly. But it should prevent scheduling latency spikes
> > > for EFI calls that simply take a long time to run to completion.
> > >
> > > Changes since v2:
> > > - Permit ordinary kernel mode FP/SIMD with IRQs disabled, so that the
> > >   special EFI case only deals with invocations in hardirq or NMI context
> > > - Disallow EFI runtime calls in hardirq or NMI context, so that the
> > >   special FP/SIMD handling for EFI can be dropped entirely
> > > - Use a mutex rather than a semaphore for the arm64 EFI runtime lock,
> > >   now that it is never trylock()ed in IRQ or NMI context.
> > >
> > > Changes since v1/RFC:
> > > - Disable uaccess for SWPAN before updating the preserved TTBR0 value
> > > - Document why disabling migration is needed
> > > - Rebase onto v6.17-rc1
> > >
> > > (*) only efi_reset_system() and EFI pstore invoke EFI runtime services
> > >     without going through the workqueue, and the latter only when saving
> > >     a kernel oops log to the EFI varstore
> > >
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Mark Brown <broonie@kernel.org>
> > >
> > > Ard Biesheuvel (8):
> > >   efi: Add missing static initializer for efi_mm::cpus_allowed_lock
> > >   efi/runtime: Return success/failure from arch_efi_call_virt_setup()
> > >   efi/runtime: Deal with arch_efi_call_virt_setup() returning failure
> >
> > Unless anyone objects, I am going to queue up these 3 patches ^^^ via
> > the EFI tree.
> >
> > >   arm64/fpsimd: Permit kernel mode NEON with IRQs off
> > >   arm64/fpsimd: Drop special handling for EFI runtime services
> > >   arm64/efi: Use a mutex to protect the EFI stack and FP/SIMD state
> > >   arm64/efi: Move uaccess en/disable out of efi_set_pgd()
> > >   arm64/efi: Call EFI runtime services without disabling preemption
> > >
> >
> > ... so the rest can go in via the arm64 tree in the next cycle.
>
> I'm also happy to take the whole lot via arm64 this cycle, if you like?
> I reviewed it a while ago and was happy with it then.
>

I've made some major changes this time, so please double check that
you're still ok with it.

In particular, I've ripped out all of the special EFI handling in fpsimd.c

