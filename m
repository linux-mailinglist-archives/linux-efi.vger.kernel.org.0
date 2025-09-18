Return-Path: <linux-efi+bounces-4859-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1198B845E4
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 13:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7074176490
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 11:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C042F7AB5;
	Thu, 18 Sep 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVb35xF2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D602CBA42
	for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195241; cv=none; b=A5qpLzbi1xlw+WsXpYF7eM5aadZ2MZd2gbj8CpL8Z104N1kbYnXIY0LXIdnYHIdoTITcb3eAme8go7KxlptqYV0bDUo9LTBY0Hw+t2kQmedZIFzDsc1IrHAnoQfSmqSeKUj5KpZZ4UPBtyXs+b45oKGHUBBP0Em92dREXEUes/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195241; c=relaxed/simple;
	bh=sDruQ31RQWcxA9NQ6hpfjci9hEglxsgsiVScqoGOvCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHVkjzx2RYZMaSe6rkpSK9S+/o6r6L+SdwnJvb5eGrlX2pogsZz2MJIERxv1pR2ocjO1tR6Zm6Cd0HHaO+4Gf4+gbxsOP+wyTPp8ObaCyT0gZmH7MbtnDYWGjYkbA3ueFldx3QbRGYd+zxnf0cTy8A7/qxscrQ34o9tM+WStwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVb35xF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA71C4CEEB
	for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 11:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758195241;
	bh=sDruQ31RQWcxA9NQ6hpfjci9hEglxsgsiVScqoGOvCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fVb35xF2JnZ5CrcL5/xgfPf9AAWIxH9atnakVT9ETUtGv74gLCtZtnmRc2CFvdQw8
	 aUgH50kHDXv2DxukpJPGzpWnGsxsotjbpf77+vzvp9Ml1/agLX8heoCSGQA/X4p6+0
	 hVm5ihb7yVv+f6Cs9MB8pseDN0FPgRfbuJyb4nt2fPYZEKJowWIsRAr/VzSvObLkKv
	 qpebeKGfjakNjnjXqXxevqoxRIICnPWVk0rknnanpUzvzVGauE1RKnauSxnWVs+Ijk
	 N4tJXCLmWLzMSAg1B1CEwueddeV/T38INbpCwLAgJlrtTgZw6AAp0D1FXJwwDoavZB
	 ifGpjE3RZhqjg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57933d3e498so541679e87.3
        for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 04:34:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YwALjE7In8OUlmQ3F2W5tT19YGePnDKjJ8Nt2mL5HfcmUX6QDlW
	Po6rcLtZo3RIuo0FtUalBfK5WF7apvvgkNPUHsTG0NM1syjQabtYo2uDT638MYdjYx4IN+CeUW9
	P/DhvsXfCoyd7wxb/dvhVnCy26q6KzWI=
X-Google-Smtp-Source: AGHT+IHRO51P1kh8hrccEQ8EhjnKuluFz4Bw+DY0+jrlyrxJs/osMNkIFLqBmkEhBzI+UI7ewRamktzcJNUv/x12ltM=
X-Received: by 2002:a05:6512:224b:b0:572:9791:203d with SMTP id
 2adb3069b0e04-577982850e7mr1582931e87.21.1758195239718; Thu, 18 Sep 2025
 04:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918103010.2973462-10-ardb+git@google.com>
In-Reply-To: <20250918103010.2973462-10-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 18 Sep 2025 13:33:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGndZxxe+u3st6FCebrdutUibspA7tJUpqGMgpj9UTFnA@mail.gmail.com>
X-Gm-Features: AS18NWBpKR-TPvng9fbMt92bDXPkedcwInqj0GFfa3493ydSnUglQQw7-ggQlLY
Message-ID: <CAMj1kXGndZxxe+u3st6FCebrdutUibspA7tJUpqGMgpj9UTFnA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] arm64: Make EFI calls preemptible
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 12:30, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The arm64 port permits the use of the baseline FP/SIMD register file in
> kernel mode, and no longer requires preemption to be disabled. Now that
> the EFI spec is being clarified to state that EFI runtime services may
> only use baseline FP/SIMD, the fact that EFI may code may use FP/SIMD
> registers (while executing at the same privilege level as the kernel) is
> no longer a reason to disable preemption when invoking them.
>
> This means that the only remaining reason for disabling preemption is
> the fact that the active mm is swapped out and replaced with efi_mm in a
> way that is hidden from the scheduler, and so scheduling is not
> supported currently. However, given that virtually all (*) EFI runtime
> calls are made from the efi_rts_wq workqueue, the efi_mm can simply be
> loaded into the workqueue worker kthread while the call is in progress,
> and this does not require preemption to be disabled.
>
> Note that this is only a partial solution in terms of RT guarantees,
> given that the runtime services execute at the same privilege level as
> the kernel, and can therefore disable interrupts (and therefore
> preemption) directly. But it should prevent scheduling latency spikes
> for EFI calls that simply take a long time to run to completion.
>
> Changes since v2:
> - Permit ordinary kernel mode FP/SIMD with IRQs disabled, so that the
>   special EFI case only deals with invocations in hardirq or NMI context
> - Disallow EFI runtime calls in hardirq or NMI context, so that the
>   special FP/SIMD handling for EFI can be dropped entirely
> - Use a mutex rather than a semaphore for the arm64 EFI runtime lock,
>   now that it is never trylock()ed in IRQ or NMI context.
>
> Changes since v1/RFC:
> - Disable uaccess for SWPAN before updating the preserved TTBR0 value
> - Document why disabling migration is needed
> - Rebase onto v6.17-rc1
>
> (*) only efi_reset_system() and EFI pstore invoke EFI runtime services
>     without going through the workqueue, and the latter only when saving
>     a kernel oops log to the EFI varstore
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Brown <broonie@kernel.org>
>
> Ard Biesheuvel (8):
>   efi: Add missing static initializer for efi_mm::cpus_allowed_lock
>   efi/runtime: Return success/failure from arch_efi_call_virt_setup()
>   efi/runtime: Deal with arch_efi_call_virt_setup() returning failure

Unless anyone objects, I am going to queue up these 3 patches ^^^ via
the EFI tree.

>   arm64/fpsimd: Permit kernel mode NEON with IRQs off
>   arm64/fpsimd: Drop special handling for EFI runtime services
>   arm64/efi: Use a mutex to protect the EFI stack and FP/SIMD state
>   arm64/efi: Move uaccess en/disable out of efi_set_pgd()
>   arm64/efi: Call EFI runtime services without disabling preemption
>

... so the rest can go in via the arm64 tree in the next cycle.

